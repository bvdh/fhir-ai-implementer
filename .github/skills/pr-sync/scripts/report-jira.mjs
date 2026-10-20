import { existsSync, readFileSync, writeFileSync } from 'node:fs';
import { join, resolve } from 'node:path';
import { pathToFileURL } from 'node:url';

export function createReport(prs, readTicket) {
  const tickets = new Map();
  const unlinked = [];
  for (const pr of prs) {
    const keys = [...new Set(`${pr.title}\n${pr.body ?? ''}`.match(/\bFHIR-\d+\b/g) ?? [])];
    if (keys.length === 0) unlinked.push(pr);
    for (const key of keys) {
      if (!tickets.has(key)) tickets.set(key, []);
      tickets.get(key).push(pr);
    }
  }

  const open = [];
  const finished = [];
  const rows = [[], [], []];
  const unknown = [];
  const overlaps = [];
  const sortKeys = (keys) => keys.sort((a, b) => Number(a.slice(5)) - Number(b.slice(5)));
  const prLinks = (refs) => refs.map((pr) => `[HL7/fhir#${pr.number}](${pr.url})`).join(', ');
  for (const key of sortKeys([...tickets.keys()])) {
    const refs = tickets.get(key);
    const isOpen = refs.some((pr) => pr.state === 'OPEN');
    (isOpen ? open : finished).push(key);
    if (isOpen && refs.some((pr) => pr.state !== 'OPEN')) overlaps.push(`${key}: ${prLinks(refs)}`);
    const text = readTicket(key);
    if (text === null) {
      unknown.push(`${key}: no unique local ticket record; ${prLinks(refs)}`);
      continue;
    }
    const status = text.match(/^- \*\*Status\*\*:\s*(.*)$/m)?.[1]?.trim();
    const grouping = text.match(/^- \*\*Grouping\*\*:[ \t]*(.*)$/m)?.[1]?.trim() ?? '';
    const awaiting = grouping.split(',').some((value) => value.trim() === 'AwaitingMerge');
    const row = `| [${key}](https://jira.hl7.org/browse/${key}) | ${(status ?? 'Unknown').replaceAll('|', '\\|')} | ${grouping.replaceAll('|', '\\|') || '(empty)'} | ${prLinks(refs)} |`;
    if (!status) unknown.push(`${key}: missing local Status field; ${prLinks(refs)}`);
    if (isOpen && !awaiting) rows[0].push(row);
    if (isOpen && status && status !== 'Applied') rows[1].push(row);
    if (!isOpen && awaiting) rows[2].push(row);
  }

  const searches = [
    ['Add AwaitingMerge', open, '(Grouping NOT IN ("AwaitingMerge") OR Grouping IS EMPTY)'],
    ['Set status to Applied', open, 'status != "Applied"'],
    ['Remove AwaitingMerge', finished, 'Grouping IN ("AwaitingMerge")'],
  ];
  const parts = [
    '# PR / Jira discrepancies',
    `Generated: ${new Date().toISOString()}`,
    'Scope: PRs authored by bvdh in HL7/fhir. Ticket keys are extracted from PR titles and descriptions, not comments. Draft PRs count as open.',
    'The discrepancy tables use local Jira Markdown snapshots, not live Jira data. Open the search links for current results. No Jira tickets are modified.',
    `Linked tickets: ${tickets.size}; open-PR scope: ${open.length}; closed/merged-only scope: ${finished.length}.`,
    '## Jira search links',
  ];
  searches.forEach(([label, keys, filter], index) => {
    const scope = keys.length ? `key IN (${keys.join(', ')})` : 'key IS EMPTY';
    const jql = `project = FHIR AND ${scope} AND ${filter} ORDER BY key ASC`;
    const url = `https://jira.hl7.org/issues/?jql=${encodeURIComponent(jql)}`;
    parts.push(`${index + 1}. [${label}](${url})\n\n\`\`\`jql\n${jql}\n\`\`\``);
    parts.push(`### ${label}: ${rows[index].length} local discrepancies\n\n` +
      (rows[index].length
        ? '| Ticket | Local status | Local grouping | PRs |\n|---|---|---|---|\n' + rows[index].join('\n')
        : 'None found in available local records.'));
  });
  parts.push('## Missing or incomplete local records', unknown.length ? unknown.map((item) => `- ${item}`).join('\n') : 'None.');
  parts.push('## Tickets in both open and finished PRs',
    'Open PRs take precedence: these tickets are excluded from the removal query.',
    overlaps.length ? overlaps.map((item) => `- ${item}`).join('\n') : 'None.');
  parts.push('## PRs with no ticket keys in title or description',
    unlinked.length ? unlinked.map((pr) => `- ${prLinks([pr])}`).join('\n') : 'None.');
  return parts.join('\n\n') + '\n';
}

if (process.argv[1] && import.meta.url === pathToFileURL(resolve(process.argv[1])).href) {
  const [input, root] = process.argv.slice(2);
  if (!input || !root) throw new Error('Usage: node report-jira.mjs <PR JSON file> <repository root>');
  const prs = JSON.parse(readFileSync(input, 'utf8'));
  const report = createReport(prs, (key) => {
    const paths = ['open', 'active', 'closed']
      .map((state) => join(root, 'jira', state, key, `${key}.md`))
      .filter(existsSync);
    return paths.length === 1 ? readFileSync(paths[0], 'utf8') : null;
  });
  const output = join(root, 'pr', 'jira-discrepancies.md');
  writeFileSync(output, report);
  console.log(`Jira discrepancy report: ${output}`);
}
