#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../../.." && pwd)"
OPEN_DIR="$REPO_ROOT/jira/open"
OVERVIEW_DIR="$REPO_ROOT/jira/overview"
NAMING_STYLE="slug"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --naming-style)
      if [[ $# -lt 2 ]]; then
        echo "ERROR: --naming-style requires a value: slug or label" >&2
        exit 1
      fi
      NAMING_STYLE="$2"
      shift 2
      ;;
    *)
      echo "ERROR: unknown argument: $1" >&2
      exit 1
      ;;
  esac
done

if [[ "$NAMING_STYLE" != "slug" && "$NAMING_STYLE" != "label" ]]; then
  echo "ERROR: invalid naming style '$NAMING_STYLE'. Use slug or label." >&2
  exit 1
fi

if [[ ! -d "$OPEN_DIR" ]]; then
  echo "ERROR: open tickets directory not found: $OPEN_DIR" >&2
  exit 1
fi

mkdir -p "$OVERVIEW_DIR"

# Always clear previous generated overview files before a new run.
find "$OVERVIEW_DIR" -maxdepth 1 -type f -name '*.md' -delete

node - "$REPO_ROOT" "$NAMING_STYLE" <<'NODE'
const fs = require('fs');
const path = require('path');

const repoRoot = process.argv[2];
const namingStyle = process.argv[3];
const openDir = path.join(repoRoot, 'jira', 'open');
const overviewDir = path.join(repoRoot, 'jira', 'overview');

const statusOrder = [
  'Triaged',
  'Waiting for Input',
  'Submitted',
  'Open',
  'In Progress',
  'Reopened',
  'Unknown'
];

function statusRank(status) {
  const idx = statusOrder.findIndex((s) => s.toLowerCase() === String(status).toLowerCase());
  return idx === -1 ? statusOrder.length : idx;
}

function parseMetadata(text) {
  const metadata = {};
  const lines = text.split(/\r?\n/);
  let inMeta = false;
  const metaLineRegex = /^- \*\*(.+?)\*\*:\s*(.*)$/;

  for (const line of lines) {
    if (!inMeta) {
      if (line.trim() === '## Metadata') {
        inMeta = true;
      }
      continue;
    }

    if (line.startsWith('## ') && line.trim() !== '## Metadata') {
      break;
    }

    const m = line.match(metaLineRegex);
    if (m) {
      metadata[m[1].trim()] = m[2].trim();
    }
  }

  return metadata;
}

function splitMulti(value, regex = /[;,]/) {
  return String(value || '')
    .split(regex)
    .map((s) => s.trim())
    .filter(Boolean);
}

function parseGrouping(value) {
  if (!value) {
    return [];
  }
  const cleaned = String(value).replace(/^\[|\]$/g, '').trim();
  if (!cleaned) {
    return [];
  }
  return splitMulti(cleaned, /[,;]/);
}

function urlTail(value) {
  if (!value) {
    return '';
  }
  try {
    const parsed = new URL(String(value));
    return path.posix.basename(parsed.pathname || '').replace(/\.html?$/i, '').trim();
  } catch {
    return '';
  }
}

function slugify(value) {
  return String(value)
    .toLowerCase()
    .replace(/&/g, ' and ')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '') || 'group';
}

function labelName(value) {
  return String(value)
    .replace(/\s+/g, '_')
    .replace(/[\\/:*?"<>|]+/g, '')
    .replace(/^_+|_+$/g, '') || 'group';
}

const groups = new Map();
const publishedAnomalies = [];
const allOpenKeys = new Set();
const coveredOpenKeys = new Set();

for (const ticketDir of fs.readdirSync(openDir)) {
  const mdPath = path.join(openDir, ticketDir, `${ticketDir}.md`);
  if (!fs.existsSync(mdPath)) {
    continue;
  }

  const metadata = parseMetadata(fs.readFileSync(mdPath, 'utf8'));
  const key = metadata['Key'] || ticketDir;
  const summary = metadata['Summary'] || '';
  const status = metadata['Status'] || 'Unknown';
  const jira = metadata['Jira'] || `https://jira.hl7.org/browse/${key}`;

  allOpenKeys.add(key);

  if (String(status).toLowerCase() === 'published') {
    publishedAnomalies.push(key);
    continue;
  }

  let detectedGroups = [];
  if (metadata['Related Page(s)']) {
    detectedGroups = splitMulti(metadata['Related Page(s)']);
  } else {
    const tail = urlTail(metadata['Related URL']);
    if (tail) {
      detectedGroups = [tail];
    } else if (metadata['Related Section(s)']) {
      detectedGroups = splitMulti(metadata['Related Section(s)']);
    } else {
      detectedGroups = parseGrouping(metadata['Grouping']);
    }
  }

  if (detectedGroups.length === 0) {
    detectedGroups = ['other'];
  }

  for (const group of detectedGroups) {
    const groupLabel = group || 'other';
    if (!groups.has(groupLabel)) {
      groups.set(groupLabel, []);
    }

    groups.get(groupLabel).push({
      key,
      summary,
      status,
      jira,
      sourceRel: `../open/${key}/${key}.md`
    });
    coveredOpenKeys.add(key);
  }
}

const usedNames = new Set();
const fileByGroup = new Map();
for (const group of [...groups.keys()].sort((a, b) => a.localeCompare(b))) {
  let base = group.toLowerCase() === 'other'
    ? 'other'
    : (namingStyle === 'label' ? labelName(group) : slugify(group));

  let fileName = `${base}.md`;
  let idx = 2;
  while (usedNames.has(fileName)) {
    fileName = `${base}-${idx}.md`;
    idx += 1;
  }

  usedNames.add(fileName);
  fileByGroup.set(group, fileName);
}

for (const [group, tickets] of groups.entries()) {
  const outFile = path.join(overviewDir, fileByGroup.get(group));
  const title = group.toLowerCase() === 'other' ? 'Other' : group;

  const byStatus = new Map();
  for (const t of tickets) {
    const statusKey = t.status || 'Unknown';
    if (!byStatus.has(statusKey)) {
      byStatus.set(statusKey, []);
    }
    byStatus.get(statusKey).push(t);
  }

  const orderedStatuses = [...byStatus.keys()].sort((a, b) => {
    const rankDiff = statusRank(a) - statusRank(b);
    if (rankDiff !== 0) {
      return rankDiff;
    }
    return a.localeCompare(b);
  });

  const lines = [];
  lines.push(`# ${title}`);
  lines.push('');
  lines.push(`Ticket count: ${tickets.length}`);
  lines.push('');

  for (const status of orderedStatuses) {
    const statusTickets = byStatus.get(status).slice().sort((a, b) => a.key.localeCompare(b.key));
    lines.push(`## ${status} (${statusTickets.length})`);
    lines.push('');
    for (const t of statusTickets) {
      lines.push(`- ${t.key}: ${t.summary} | [Jira](${t.jira}) | [Source](${t.sourceRel})`);
    }
    lines.push('');
  }

  fs.writeFileSync(outFile, `${lines.join('\n').trimEnd()}\n`, 'utf8');
}

if (![...fileByGroup.values()].includes('other.md')) {
  fs.writeFileSync(path.join(overviewDir, 'other.md'), '# Other\n\nTicket count: 0\n', 'utf8');
}

const missingCoverage = [...allOpenKeys].filter((key) => !coveredOpenKeys.has(key));

console.log(`Open tickets processed: ${allOpenKeys.size}`);
console.log(`Overview files written: ${fs.readdirSync(overviewDir).filter((f) => f.endsWith('.md')).length}`);
console.log(`Published anomalies skipped: ${publishedAnomalies.length}`);
if (publishedAnomalies.length > 0) {
  console.log(`Published anomalies: ${publishedAnomalies.sort().join(', ')}`);
  console.log('Action: re-run jira-sync-from-excel to move published tickets out of jira/open.');
}

if (missingCoverage.length > 0) {
  console.log(`Coverage mismatch: ${missingCoverage.length} tickets were not grouped.`);
  console.log(`Missing keys: ${missingCoverage.sort().join(', ')}`);
  process.exitCode = 2;
} else {
  console.log('Coverage check: OK');
}
NODE
