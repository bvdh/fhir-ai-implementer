#!/usr/bin/env node

import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import xlsx from 'xlsx';

function parseArgs(argv) {
  const args = { jiraDir: '', excelFile: '' };
  for (let i = 2; i < argv.length; i += 1) {
    const arg = argv[i];
    if (arg === '--jira-dir' && i + 1 < argv.length) {
      args.jiraDir = argv[i + 1];
      i += 1;
      continue;
    }
    if (arg === '--excel' && i + 1 < argv.length) {
      args.excelFile = argv[i + 1];
      i += 1;
    }
  }
  return args;
}

function normalize(value) {
  return String(value || '').trim();
}

function normKey(value) {
  return normalize(value).toLowerCase();
}

function findHeaderKey(row, names) {
  const wanted = new Set(names.map((x) => x.toLowerCase()));
  for (const key of Object.keys(row)) {
    if (wanted.has(normKey(key))) {
      return key;
    }
  }
  return null;
}

function isNonEmpty(value) {
  return normalize(value) !== '';
}

function classifyTicket(status, resolution) {
  const s = normKey(status);
  const r = normKey(resolution);

  const closed = new Set([
    'applied',
    'duplicate',
    'deferred',
    'resolved',
    'closed',
    'resolved - no change',
    'resolved - change required',
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

function escapeMd(value) {
  return normalize(value).replace(/\r\n/g, '\n').replace(/\r/g, '\n');
}

function renderTicketMarkdown(ticket) {
  const lines = [];
  const headingSummary = ticket.summary || 'No summary';
  lines.push(`# ${ticket.key}: ${headingSummary}`);
  lines.push('');
  lines.push('## Metadata');
  lines.push('');

  for (const [k, v] of Object.entries(ticket.metadata)) {
    if (isNonEmpty(v)) {
      lines.push(`- **${k}**: ${escapeMd(v)}`);
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
    if (c.security) {
      lines.push(`Security: ${c.security}`);
    }
    lines.push('');
    lines.push(c.text || '_Empty comment_');
    lines.push('');
  });

  return `${lines.join('\n')}\n`;
}

function main() {
  const args = parseArgs(process.argv);
  if (!args.jiraDir || !args.excelFile) {
    console.error('Usage: node sync-jira-tickets.mjs --jira-dir <path> --excel <path>');
    process.exit(1);
  }

  const jiraDir = path.resolve(args.jiraDir);
  const excelFile = path.resolve(args.excelFile);
  const repoRoot = path.resolve(jiraDir, '..');
  const currentTicketsPath = path.join(repoRoot, 'currentTickets.md');
  const currentTicketsSet = loadCurrentTicketsSet(currentTicketsPath);

  if (!fs.existsSync(jiraDir) || !fs.statSync(jiraDir).isDirectory()) {
    console.error(`ERROR: jira directory not found: ${jiraDir}`);
    process.exit(1);
  }

  if (!fs.existsSync(excelFile) || !fs.statSync(excelFile).isFile()) {
    console.error(`ERROR: excel file not found: ${excelFile}`);
    process.exit(1);
  }

  const workbook = xlsx.readFile(excelFile, { cellDates: true });
  if (!workbook.SheetNames.length) {
    console.error('ERROR: no worksheets found in excel file');
    process.exit(1);
  }

  const sheetName = workbook.SheetNames[0];
  const sheet = workbook.Sheets[sheetName];
  const rows = xlsx.utils.sheet_to_json(sheet, { defval: '' });

  const tickets = new Map();

  for (const row of rows) {
    const keyHeader = findHeaderKey(row, ['Issue key', 'Key', 'Issue Key']);
    if (!keyHeader) {
      continue;
    }

    const key = normalize(row[keyHeader]);
    if (!key || !/^FHIR-\d+$/i.test(key)) {
      continue;
    }

    const summaryHeader = findHeaderKey(row, ['Summary', 'Issue Summary']);
    const statusHeader = findHeaderKey(row, ['Status']);
    const resolutionHeader = findHeaderKey(row, ['Resolution']);

    const commentTextHeader = findHeaderKey(row, ['Comment', 'Comment body', 'Comment text', 'Comments']);
    const commentAuthorHeader = findHeaderKey(row, ['Comment author', 'Comment Author']);
    const commentCreatedHeader = findHeaderKey(row, ['Comment created', 'Comment date']);
    const commentSecurityHeader = findHeaderKey(row, ['Comment security', 'Security level']);

    const summary = summaryHeader ? normalize(row[summaryHeader]) : '';
    const status = statusHeader ? normalize(row[statusHeader]) : '';
    const resolution = resolutionHeader ? normalize(row[resolutionHeader]) : '';

    if (!tickets.has(key)) {
      tickets.set(key, {
        key,
        summary,
        status,
        resolution,
        metadata: {},
        comments: []
      });
    }

    const ticket = tickets.get(key);

    if (!ticket.summary && summary) {
      ticket.summary = summary;
    }
    if (!ticket.status && status) {
      ticket.status = status;
    }
    if (!ticket.resolution && resolution) {
      ticket.resolution = resolution;
    }

    for (const [field, value] of Object.entries(row)) {
      const fieldNorm = normKey(field);
      if (fieldNorm.startsWith('comment')) {
        continue;
      }
      if (!isNonEmpty(value)) {
        continue;
      }
      if (!ticket.metadata[field]) {
        ticket.metadata[field] = normalize(value);
      }
    }

    const commentText = commentTextHeader ? normalize(row[commentTextHeader]) : '';
    if (commentText) {
      ticket.comments.push({
        text: escapeMd(commentText),
        author: commentAuthorHeader ? normalize(row[commentAuthorHeader]) : '',
        created: commentCreatedHeader ? normalize(row[commentCreatedHeader]) : '',
        security: commentSecurityHeader ? normalize(row[commentSecurityHeader]) : ''
      });
    }
  }

  ensureDir(path.join(jiraDir, 'open'));
  ensureDir(path.join(jiraDir, 'active'));
  ensureDir(path.join(jiraDir, 'closed'));

  const counts = { open: 0, active: 0, closed: 0 };

  for (const ticket of tickets.values()) {
    const ticketKeyUpper = ticket.key.toUpperCase();
    const state = currentTicketsSet.has(ticketKeyUpper)
      ? 'active'
      : classifyTicket(ticket.status, ticket.resolution);
    const targetDir = path.join(jiraDir, state, ticket.key);

    const possibleOldLocations = [
      path.join(jiraDir, 'open', ticket.key),
      path.join(jiraDir, 'active', ticket.key),
      path.join(jiraDir, 'closed', ticket.key),
      path.join(jiraDir, ticket.key)
    ];

    for (const location of possibleOldLocations) {
      if (path.resolve(location) !== path.resolve(targetDir)) {
        removeIfExists(location);
      }
    }

    ensureDir(targetDir);
    const outFile = path.join(targetDir, `${ticket.key}.md`);
    fs.writeFileSync(outFile, renderTicketMarkdown(ticket), 'utf8');
    counts[state] += 1;
  }

  console.log(`Synced ${tickets.size} Jira tickets from sheet '${sheetName}'.`);
  console.log(`Current tickets loaded from ${currentTicketsPath}: ${currentTicketsSet.size}`);
  console.log(`  - Open: ${counts.open}`);
  console.log(`  - Active: ${counts.active}`);
  console.log(`  - Closed: ${counts.closed}`);
  console.log(`Output directory: ${jiraDir}`);
  console.log(`  - Open tickets: ${path.join(jiraDir, 'open')}`);
  console.log(`  - Active tickets: ${path.join(jiraDir, 'active')}`);
  console.log(`  - Closed tickets: ${path.join(jiraDir, 'closed')}`);
}

main();
