#!/usr/bin/env node

// Parse a Jira "full content" HTML export and sync ticket markdown files,
// producing the same directory layout and markdown format as the Excel-based sync.

import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import * as cheerio from 'cheerio';

const assignedUserNames = new Set(['bvdh', 'bas van den heuvel']);

function parseArgs(argv) {
  const args = { jiraDir: '', htmlFile: '', prune: false };
  for (let i = 2; i < argv.length; i += 1) {
    const arg = argv[i];
    if (arg === '--jira-dir' && i + 1 < argv.length) {
      args.jiraDir = argv[i + 1];
      i += 1;
      continue;
    }
    if (arg === '--html' && i + 1 < argv.length) {
      args.htmlFile = argv[i + 1];
      i += 1;
      continue;
    }
    if (arg === '--prune') {
      args.prune = true;
    }
  }
  return args;
}

function normalize(value) {
  return String(value == null ? '' : value)
    .replace(/\u00a0/g, ' ')
    .replace(/\r\n/g, '\n')
    .replace(/\r/g, '\n')
    .replace(/[ \t]+/g, ' ')
    .replace(/ *\n */g, '\n')
    .replace(/\n{3,}/g, '\n\n')
    .trim();
}

function normKey(value) {
  return normalize(value).toLowerCase();
}

function isNonEmpty(value) {
  return normalize(value) !== '';
}

function classifyTicket(status, resolution) {
  const s = normKey(status);
  const r = normKey(resolution);

  const changeRequiredPattern = /\bchange\s*-?\s*required\b|\bchanged\s*-?\s*required\b/;
  if (changeRequiredPattern.test(s) || changeRequiredPattern.test(r)) {
    return 'open';
  }

  const closed = new Set([
    'applied',
    'duplicate',
    'deferred',
    'resolved',
    'closed',
    'published',
    'resolved - no change',
    'done'
  ]);

  if (closed.has(s) || closed.has(r)) {
    return 'closed';
  }
  return 'open';
}

function loadCurrentTicketsSet(currentTicketsPath) {
  if (!fs.existsSync(currentTicketsPath) || !fs.statSync(currentTicketsPath).isFile()) {
    return new Set();
  }

  const content = fs.readFileSync(currentTicketsPath, 'utf8');
  const matches = content.match(/FHIR-\d+/gi) || [];
  return new Set(matches.map((ticketKey) => ticketKey.toUpperCase()));
}

function ticketLink(key) {
  return `https://jira.hl7.org/browse/${key}`;
}

function removeIfExists(targetPath) {
  if (fs.existsSync(targetPath)) {
    fs.rmSync(targetPath, { recursive: true, force: true });
  }
}

function ensureDir(targetPath) {
  fs.mkdirSync(targetPath, { recursive: true });
}

function listNonOverviewEntries(ticketDir, ticketKey) {
  if (!fs.existsSync(ticketDir) || !fs.statSync(ticketDir).isDirectory()) {
    return [];
  }

  return fs
    .readdirSync(ticketDir, { withFileTypes: true })
    .filter((entry) => entry.name !== `${ticketKey}.md`)
    .map((entry) => entry.name);
}

function hasExtraArtifacts(ticketDir, ticketKey) {
  return listNonOverviewEntries(ticketDir, ticketKey).length > 0;
}

function migrateExtraArtifacts(sourceDir, targetDir, ticketKey) {
  if (!hasExtraArtifacts(sourceDir, ticketKey)) {
    return;
  }

  ensureDir(targetDir);

  for (const entry of fs.readdirSync(sourceDir, { withFileTypes: true })) {
    if (entry.name === `${ticketKey}.md`) {
      continue;
    }

    const fromPath = path.join(sourceDir, entry.name);
    const toPath = path.join(targetDir, entry.name);

    if (fs.existsSync(toPath)) {
      console.warn(`WARN: Preserving conflicting artifact, leaving in place: ${fromPath}`);
      continue;
    }

    fs.renameSync(fromPath, toPath);
  }
}

function removeStaleTicketDirectories(baseDir, validTicketKeysUpper) {
  if (!fs.existsSync(baseDir) || !fs.statSync(baseDir).isDirectory()) {
    return;
  }

  for (const entry of fs.readdirSync(baseDir, { withFileTypes: true })) {
    if (!entry.isDirectory()) {
      continue;
    }

    if (!/^FHIR-\d+$/i.test(entry.name)) {
      continue;
    }

    if (!validTicketKeysUpper.has(entry.name.toUpperCase())) {
      const ticketDir = path.join(baseDir, entry.name);
      if (hasExtraArtifacts(ticketDir, entry.name)) {
        console.warn(`WARN: Preserving stale ticket directory with extra artifacts: ${ticketDir}`);
        continue;
      }

      removeIfExists(ticketDir);
    }
  }
}

function renderTicketMarkdown(ticket) {
  const lines = [];
  const headingSummary = ticket.summary || 'No summary';
  lines.push(`# ${ticket.key}: ${headingSummary}`);
  lines.push('');
  lines.push('## Metadata');
  lines.push('');

  for (const [k, v] of ticket.metadata) {
    if (isNonEmpty(v)) {
      lines.push(`- **${k}**: ${normalize(v)}`);
    }
  }

  lines.push('');
  lines.push(`- **Jira**: ${ticketLink(ticket.key)}`);
  lines.push('');
  lines.push('## Comments');
  lines.push('');

  if (ticket.comments.length === 0) {
    lines.push('_No comments in export._');
    return `${lines.join('\n')}\n`;
  }

  ticket.comments.forEach((c, idx) => {
    lines.push(`### ${idx + 1}. ${c.author || 'Unknown'}${c.created ? ` - ${c.created}` : ''}`);
    lines.push('');
    lines.push(c.text || '_Empty comment_');
    lines.push('');
  });

  return `${lines.join('\n')}\n`;
}

function blockText($, el) {
  return normalize($(el).text());
}

function parseSubText(text) {
  const dates = {};
  const created = text.match(/Created:\s*([0-9]{4}-[0-9]{2}-[0-9]{2})/i);
  const updated = text.match(/Updated:\s*([0-9]{4}-[0-9]{2}-[0-9]{2})/i);
  const resolved = text.match(/Resolved:\s*([0-9]{4}-[0-9]{2}-[0-9]{2})/i);
  if (created) dates.Created = created[1];
  if (updated) dates.Updated = updated[1];
  if (resolved) dates.Resolved = resolved[1];
  return dates;
}

function parseTicketsFromHtml(html) {
  const $ = cheerio.load(html);
  const tickets = [];

  $('h3.formtitle').each((_, titleEl) => {
    const $title = $(titleEl);
    const titleText = normalize($title.text());
    const keyMatch = titleText.match(/FHIR-\d+/i);
    if (!keyMatch) {
      return;
    }
    const key = keyMatch[0].toUpperCase();

    // Summary: text of the browse link inside the title.
    let summary = '';
    $title.find('a[href*="/browse/"]').each((__, a) => {
      if (!summary) {
        summary = normalize($(a).text());
      }
    });

    const dates = parseSubText(normalize($title.find('.subText').text()));

    // The issue content lives in the sibling elements following the h3's
    // header table, up to the issue separator (hr.fullcontent) or next formtitle.
    const headerTable = $title.closest('table');
    const metadata = new Map();
    const setField = (label, value) => {
      const l = normalize(label).replace(/:$/, '');
      const v = normalize(value);
      if (l && v && !metadata.has(l)) {
        metadata.set(l, v);
      }
    };

    if (summary) {
      setField('Summary', summary);
    }
    for (const [k, v] of Object.entries(dates)) {
      setField(k, v);
    }

    let status = '';
    let resolution = '';
    let assignedToMe = false;
    let description = '';
    const comments = [];

    // Walk forward across sibling nodes collecting field rows, description,
    // and comments until the issue separator.
    let node = headerTable.length ? headerTable[0] : titleEl;
    let steps = 0;
    while (node && steps < 5000) {
      steps += 1;
      const $node = $(node);

      // Stop at the horizontal separator that ends an issue.
      if (node.type === 'tag' && node.name === 'hr') {
        const cls = ($node.attr('class') || '').toLowerCase();
        if (cls.includes('fullcontent')) {
          break;
        }
      }

      if (node.type === 'tag' && node.name === 'table') {
        // Field rows: <td><b>Label:</b></td><td>value</td>
        $node.find('tr').each((__, tr) => {
          const $cells = $(tr).children('td');
          if ($cells.length >= 2) {
            const labelCell = $cells.eq(0);
            const boldLabel = labelCell.find('b').first();
            if (boldLabel.length && /:$/.test(normalize(boldLabel.text()))) {
              const label = normalize(boldLabel.text());
              const value = normalize($cells.eq(1).text());
              setField(label, value);
              const ln = label.replace(/:$/, '').toLowerCase();
              if (ln === 'status') status = value;
              if (ln === 'resolution') resolution = value;
              if (ln === 'assignee') {
                const identities = [value];
                $cells.eq(1).find('a').each((___, a) => {
                  const link = $(a);
                  identities.push(link.text(), link.attr('data-username'), link.attr('rel'));
                  const href = link.attr('href');
                  if (href) {
                    identities.push(new URL(href, 'https://jira.hl7.org').searchParams.get('name'));
                  }
                });
                assignedToMe = identities.some((identity) => assignedUserNames.has(normKey(identity)));
              }
            }
          }
        });

        // Description
        const descArea = $node.find('#descriptionArea');
        if (descArea.length) {
          description = normalize(descArea.text());
        }

        // Comments
        $node.find('tr[id^="comment-header-"]').each((__, tr) => {
          const id = ($(tr).attr('id') || '').replace('comment-header-', '');
          const author = normalize($(tr).find('a.user-hover').first().text());
          const dateText = normalize($(tr).find('font font').first().text()) ||
            (normalize($(tr).text()).match(/\[\s*([0-9]{4}-[0-9]{2}-[0-9]{2})\s*\]/) || [])[1] || '';
          const bodyRow = $node.find(`tr#comment-body-${id}`);
          const text = normalize(bodyRow.text());
          if (author || text) {
            comments.push({ author, created: dateText, text });
          }
        });
      }

      node = node.nextSibling;
    }

    if (description) {
      setField('Description', description);
    }

    tickets.push({ key, summary, status, resolution, assignedToMe, metadata, comments });
  });

  return tickets;
}

function main() {
  const args = parseArgs(process.argv);
  if (!args.jiraDir || !args.htmlFile) {
    console.error('Usage: node sync-jira-from-html.mjs --jira-dir <path> --html <path>');
    process.exit(1);
  }

  const jiraDir = path.resolve(args.jiraDir);
  const htmlFile = path.resolve(args.htmlFile);
  const repoRoot = path.resolve(jiraDir, '..');
  const currentTicketsPath = path.join(repoRoot, 'currentTickets.md');
  const currentTicketsSet = loadCurrentTicketsSet(currentTicketsPath);

  if (!fs.existsSync(jiraDir) || !fs.statSync(jiraDir).isDirectory()) {
    console.error(`ERROR: jira directory not found: ${jiraDir}`);
    process.exit(1);
  }

  if (!fs.existsSync(htmlFile) || !fs.statSync(htmlFile).isFile()) {
    console.error(`ERROR: html file not found: ${htmlFile}`);
    process.exit(1);
  }

  const html = fs.readFileSync(htmlFile, 'utf8');
  const parsed = parseTicketsFromHtml(html);

  // De-duplicate by key (keep first occurrence, which is the primary listing).
  const tickets = new Map();
  for (const ticket of parsed) {
    if (!tickets.has(ticket.key)) {
      tickets.set(ticket.key, ticket);
    }
  }

  const ticketKeysUpper = new Set([...tickets.keys()].map((key) => key.toUpperCase()));

  ensureDir(path.join(jiraDir, 'open'));
  ensureDir(path.join(jiraDir, 'active'));
  ensureDir(path.join(jiraDir, 'closed'));
  ensureDir(path.join(jiraDir, 'assigned'));

  if (args.prune) {
    removeStaleTicketDirectories(path.join(jiraDir, 'open'), ticketKeysUpper);
    removeStaleTicketDirectories(path.join(jiraDir, 'active'), ticketKeysUpper);
    removeStaleTicketDirectories(path.join(jiraDir, 'closed'), ticketKeysUpper);
    removeStaleTicketDirectories(path.join(jiraDir, 'assigned'), ticketKeysUpper);
    removeStaleTicketDirectories(jiraDir, ticketKeysUpper);
  }

  const counts = { open: 0, active: 0, closed: 0, assigned: 0 };

  for (const ticket of tickets.values()) {
    const ticketKeyUpper = ticket.key.toUpperCase();
    const state = ticket.assignedToMe
      ? 'assigned'
      : currentTicketsSet.has(ticketKeyUpper)
        ? 'active'
        : classifyTicket(ticket.status, ticket.resolution);
    const targetDir = path.join(jiraDir, state, ticket.key);

    const possibleOldLocations = [
      path.join(jiraDir, 'open', ticket.key),
      path.join(jiraDir, 'active', ticket.key),
      path.join(jiraDir, 'closed', ticket.key),
      path.join(jiraDir, 'assigned', ticket.key),
      path.join(jiraDir, ticket.key)
    ];

    for (const location of possibleOldLocations) {
      if (path.resolve(location) !== path.resolve(targetDir) && fs.existsSync(location)) {
        migrateExtraArtifacts(location, targetDir, ticket.key);
        removeIfExists(location);
      }
    }

    ensureDir(targetDir);
    const outFile = path.join(targetDir, `${ticket.key}.md`);
    fs.writeFileSync(outFile, renderTicketMarkdown(ticket), 'utf8');
    counts[state] += 1;
  }

  console.log(`Synced ${tickets.size} Jira tickets from HTML export.`);
  console.log(`Mode: ${args.prune ? 'full (stale ticket directories pruned)' : 'incremental (existing tickets preserved)'}`);
  console.log(`Current tickets loaded from ${currentTicketsPath}: ${currentTicketsSet.size}`);
  console.log(`  - Open: ${counts.open}`);
  console.log(`  - Active: ${counts.active}`);
  console.log(`  - Closed: ${counts.closed}`);
  console.log(`  - Assigned: ${counts.assigned}`);
  console.log(`Output directory: ${jiraDir}`);
}

main();
