import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import test from 'node:test';

const parser = fileURLToPath(new URL('./sync-jira-from-html.mjs', import.meta.url));

function issue(key, assignee = '', status = 'Submitted', resolution = 'Unresolved') {
  return `<table><tr><td><h3 class="formtitle">[${key}]
    <a href="/browse/${key}">Example summary</a></h3></td></tr></table>
    <table>
      <tr><td><b>Status:</b></td><td>${status}</td></tr>
      <tr><td><b>Resolution:</b></td><td>${resolution}</td></tr>
      <tr><td><b>Assignee:</b></td><td>${assignee}</td></tr>
    </table><hr class="fullcontent">`;
}

function workspace(t) {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), 'jira-sync-test-'));
  t.after(() => fs.rmSync(root, { recursive: true, force: true }));
  const jira = path.join(root, 'jira');
  fs.mkdirSync(jira);
  return {
    root,
    ticket(state, key) {
      return path.join(jira, state, key, `${key}.md`);
    },
    seed(state, key, artifacts = {}) {
      const dir = path.join(jira, state, key);
      fs.mkdirSync(dir, { recursive: true });
      fs.writeFileSync(path.join(dir, `${key}.md`), 'Old overview');
      for (const [name, content] of Object.entries(artifacts)) {
        fs.writeFileSync(path.join(dir, name), content);
      }
    },
    sync(html, ...flags) {
      const input = path.join(root, 'export.html');
      fs.writeFileSync(input, html);
      const result = spawnSync(process.execPath, [
        parser, '--jira-dir', jira, '--html', input, ...flags
      ], { encoding: 'utf8' });
      assert.equal(result.status, 0, result.stderr);
      return result;
    }
  };
}

test('matches own assignee identities and prioritizes assigned over active and closed', (t) => {
  const w = workspace(t);
  fs.writeFileSync(path.join(w.root, 'currentTickets.md'), 'FHIR-1\nFHIR-2');
  const identities = [
    'Bas van den Heuvel',
    ' BVDH ',
    '<a data-username="bvdh">Different display name</a>',
    '<a href="/secure/ViewProfile.jspa?name=bvdh">Different display name</a>',
    '<a rel="bvdh">Different display name</a>'
  ];
  const result = w.sync(identities.map((identity, i) =>
    issue(`FHIR-${i + 1}`, identity, 'Applied', 'Resolved')
  ).join(''));
  for (let i = 1; i <= identities.length; i += 1) {
    assert.ok(fs.existsSync(w.ticket('assigned', `FHIR-${i}`)));
    assert.ok(!fs.existsSync(w.ticket('active', `FHIR-${i}`)));
    assert.ok(!fs.existsSync(w.ticket('closed', `FHIR-${i}`)));
  }
  assert.match(result.stdout, /Assigned: 5/);
  assert.match(fs.readFileSync(w.ticket('assigned', 'FHIR-1'), 'utf8'),
    /\*\*Assignee\*\*: Bas van den Heuvel/);
});

test('preserves routing for other assignees, unassigned and missing assignee fields', (t) => {
  const w = workspace(t);
  fs.writeFileSync(path.join(w.root, 'currentTickets.md'), 'FHIR-1');
  w.sync(
    issue('FHIR-1', 'Another User', 'Applied') +
    issue('FHIR-2', 'Unassigned') +
    issue('FHIR-3', 'Another User', 'Applied') +
    issue('FHIR-4', 'bvdh-other') +
    issue('FHIR-5', 'Bas van den Heuvel Jr.') +
    issue('FHIR-6').replace('<tr><td><b>Assignee:</b></td><td></td></tr>', '') +
    issue('FHIR-7', 'Another User', 'Resolved - change required')
  );
  assert.ok(fs.existsSync(w.ticket('active', 'FHIR-1')));
  assert.ok(fs.existsSync(w.ticket('closed', 'FHIR-3')));
  for (const key of ['FHIR-2', 'FHIR-4', 'FHIR-5', 'FHIR-6', 'FHIR-7']) {
    assert.ok(fs.existsSync(w.ticket('open', key)));
  }
});

test('moves tickets into assigned with artifacts and preserves absent incremental tickets', (t) => {
  const w = workspace(t);
  const states = ['open', 'active', 'closed'];
  states.forEach((state, i) => w.seed(state, `FHIR-${i + 1}`, { 'plan.md': state }));
  w.seed('assigned', 'FHIR-99');
  w.sync(states.map((_, i) => issue(`FHIR-${i + 1}`, 'bvdh')).join(''));
  states.forEach((state, i) => {
    const key = `FHIR-${i + 1}`;
    assert.ok(!fs.existsSync(path.dirname(w.ticket(state, key))));
    assert.equal(fs.readFileSync(path.join(path.dirname(w.ticket('assigned', key)), 'plan.md'), 'utf8'), state);
  });
  assert.ok(fs.existsSync(w.ticket('assigned', 'FHIR-99')));
});

test('moves reassigned tickets out of assigned using existing routing', (t) => {
  const w = workspace(t);
  fs.writeFileSync(path.join(w.root, 'currentTickets.md'), 'FHIR-1');
  for (const key of ['FHIR-1', 'FHIR-2', 'FHIR-3']) {
    w.seed('assigned', key, { 'plan.md': key });
  }
  w.sync(
    issue('FHIR-1', 'Another User') +
    issue('FHIR-2', 'Unassigned') +
    issue('FHIR-3', 'Another User', 'Applied')
  );
  ['active', 'open', 'closed'].forEach((state, i) => {
    const key = `FHIR-${i + 1}`;
    assert.ok(!fs.existsSync(path.dirname(w.ticket('assigned', key))));
    assert.ok(fs.existsSync(w.ticket(state, key)));
    assert.equal(fs.readFileSync(path.join(path.dirname(w.ticket(state, key)), 'plan.md'), 'utf8'), key);
  });
});

test('full sync prunes stale assigned tickets but retains extra artifacts', (t) => {
  const w = workspace(t);
  w.seed('assigned', 'FHIR-1');
  w.seed('assigned', 'FHIR-2', { 'plan.md': 'Keep this plan' });
  const result = w.sync(issue('FHIR-3', 'bvdh'), '--prune');
  assert.ok(!fs.existsSync(path.dirname(w.ticket('assigned', 'FHIR-1'))));
  assert.ok(fs.existsSync(w.ticket('assigned', 'FHIR-2')));
  assert.ok(fs.existsSync(w.ticket('assigned', 'FHIR-3')));
  assert.match(result.stderr, /Preserving stale ticket directory with extra artifacts/);
});
