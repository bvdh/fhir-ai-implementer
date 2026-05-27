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

function cellText(cell) {
  if (!cell) {
    return '';
  }

  return normalize(xlsx.utils.format_cell(cell));
}

function readWorksheetRows(sheet) {
  const ref = sheet['!ref'];
  if (!ref) {
    return [];
  }

  const range = xlsx.utils.decode_range(ref);
  const headers = [];
  let emptyHeaderCount = 0;

  for (let c = range.s.c; c <= range.e.c; c += 1) {
    const cell = sheet[xlsx.utils.encode_cell({ r: range.s.r, c })];
    const header = cellText(cell);
    if (header) {
      headers.push(header);
    } else {
      headers.push(emptyHeaderCount === 0 ? '__EMPTY' : `__EMPTY_${emptyHeaderCount}`);
      emptyHeaderCount += 1;
    }
  }

  const rows = [];

  for (let r = range.s.r + 1; r <= range.e.r; r += 1) {
    const row = {};

    for (let c = range.s.c; c <= range.e.c; c += 1) {
      const value = cellText(sheet[xlsx.utils.encode_cell({ r, c })]);
      if (!value) {
        continue;
      }

      const field = headers[c - range.s.c];
      if (row[field]) {
        row[field] = `${row[field]} | ${value}`;
      } else {
        row[field] = value;
      }
    }

    if (Object.keys(row).length > 0) {
      rows.push(row);
    }
  }

  return rows;
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

function addMetadataValue(ticket, field, value) {
  const fieldNorm = normKey(field);
  const valueNorm = normalize(value);

  if (!fieldNorm || !valueNorm) {
    return;
  }

  let displayField = ticket.metadataFieldByNorm.get(fieldNorm);
  if (!displayField) {
    displayField = field;
    ticket.metadataFieldByNorm.set(fieldNorm, displayField);
  }

  if (!ticket.metadataValues.has(displayField)) {
    ticket.metadataValues.set(displayField, new Set());
  }
  ticket.metadataValues.get(displayField).add(valueNorm);
}

function finalizeMetadata(ticket) {
  const entries = [...ticket.metadataValues.entries()].sort((a, b) =>
    a[0].localeCompare(b[0], undefined, { sensitivity: 'base' })
  );

  ticket.metadata = Object.fromEntries(
    entries.map(([field, values]) => [field, [...values].join(' | ')])
  );
}

function resolveCommentHeaders(row) {
  const text = findHeaderKey(row, ['Comment', 'Comment body', 'Comment text']);
  const author = findHeaderKey(row, ['Comment author', 'Comment Author']);
  const created = findHeaderKey(row, ['Comment created', 'Comment date']);
  const security = findHeaderKey(row, ['Comment security', 'Security level']);

  if (text) {
    return { text, author, created, security, isGridLayout: false };
  }

  const comments = findHeaderKey(row, ['Comments']);
  const empty = findHeaderKey(row, ['__EMPTY']);
  const empty1 = findHeaderKey(row, ['__EMPTY_1']);
  const empty2 = findHeaderKey(row, ['__EMPTY_2']);

  if (comments && empty2) {
    return {
      text: empty2,
      author: empty,
      created: comments,
      security: empty1,
      isGridLayout: true
    };
  }

  if (comments) {
    return { text: comments, author, created, security, isGridLayout: false };
  }

  return null;
}

function isGridHeaderComment(comment) {
  return (
    normKey(comment.text) === 'text' &&
    normKey(comment.created) === 'date' &&
    normKey(comment.author) === 'author' &&
    normKey(comment.security) === 'security'
  );
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
  const rows = readWorksheetRows(sheet);

  const tickets = new Map();

  let lastTicketKey = '';

  for (const row of rows) {
    const keyHeader = findHeaderKey(row, ['Issue key', 'Key', 'Issue Key']);
    const parsedKey = keyHeader ? normalize(row[keyHeader]) : '';
    const commentHeaders = resolveCommentHeaders(row);

    let key = '';
    let isContinuationCommentRow = false;

    if (parsedKey && /^FHIR-\d+$/i.test(parsedKey)) {
      key = parsedKey;
      lastTicketKey = key;
    } else if (lastTicketKey && commentHeaders) {
      key = lastTicketKey;
      isContinuationCommentRow = true;
    } else {
      continue;
    }

    const summaryHeader = findHeaderKey(row, ['Summary', 'Issue Summary']);
    const statusHeader = findHeaderKey(row, ['Status']);
    const resolutionHeader = findHeaderKey(row, ['Resolution']);

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
        metadataValues: new Map(),
        metadataFieldByNorm: new Map(),
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

    if (!isContinuationCommentRow) {
      for (const [field, value] of Object.entries(row)) {
        addMetadataValue(ticket, field, value);
      }
    }

    const commentText = commentHeaders ? normalize(row[commentHeaders.text]) : '';
    if (commentText) {
      const comment = {
        text: escapeMd(commentText),
        author: commentHeaders && commentHeaders.author ? normalize(row[commentHeaders.author]) : '',
        created: commentHeaders && commentHeaders.created ? normalize(row[commentHeaders.created]) : '',
        security: commentHeaders && commentHeaders.security ? normalize(row[commentHeaders.security]) : ''
      };

      if (!(commentHeaders && commentHeaders.isGridLayout && isGridHeaderComment(comment))) {
        ticket.comments.push(comment);
      }
    }
  }

  for (const ticket of tickets.values()) {
    finalizeMetadata(ticket);
    delete ticket.metadataValues;
    delete ticket.metadataFieldByNorm;
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
