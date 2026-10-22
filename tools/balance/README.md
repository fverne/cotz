# CoTZ balancing workbook

Export Lua configuration into an Excel workbook, edit its supported values, and
import the edits back into the original files. The importer never executes Lua.
It validates all rows before writing and detects concurrent edits using a Git
commit baseline. Python 3.10+ and the dependencies in `requirements.txt` are required.

## GitHub Actions

After these files are merged into the repository's default branch:

1. Open **Actions → Export balancing workbook → Run workflow**. Relevant pushes
   to `main` or `master` also export automatically. If your default branch has a
   different name, update the export workflow's branch filter.
2. Download and unpack the `cotz-balance-<commit>` artifact from the completed run.
   Keep `balance.xlsx` and its original `baseline.json` together. Artifacts expire
   after 90 days; retain a local copy if needed.
3. Edit the blue cells in the workbook. Excel and LibreOffice can edit XLSX files.
   Other editors must preserve cell types, sheet names, and metadata.
4. Commit the edited workbook and its **unchanged original** baseline under
   `balance-input/` on the default branch. Do not replace the baseline with one
   from a newer export. A normal PR can be used to submit the input files.
5. Run **Import balancing workbook**, entering their paths. Leave `apply`
   unchecked first to validate and download the JSON change report.
6. Run again with `apply` checked to create or update the
   `automation/balance-import` PR. Review the Lua diff and merge when ready.

The workflow always imports against the current default branch. It regenerates
the dedicated automation branch on subsequent imports, so do not put manual work
on that branch. It never merges or deploys changes to a game server. A no-change
import creates no commit or PR. When multiple proposals are in progress, finish
or discard one before applying another; they share this branch.

Repository settings must permit Actions to create pull requests
(**Settings → Actions → General → Workflow permissions → Allow GitHub Actions
to create and approve pull requests**). Import uses the built-in `GITHUB_TOKEN`;
no personal access token or spreadsheet service credentials are needed. Depending
on GitHub's token-trigger rules, checks on the generated PR may require approving
the workflow run. The importer performs validation before pushing, and the
**Validate balancing tools** workflow can also be run manually. Export and
validation jobs have read-only repository permissions.

## Local usage

From the repository root:

```bash
python3 -m venv /tmp/cotz-balance-venv
/tmp/cotz-balance-venv/bin/pip install -r tools/balance/requirements.txt

# Configuration must be committed so the export has a reproducible baseline.
/tmp/cotz-balance-venv/bin/python tools/balance/balance.py export

# Edit balance-output/balance.xlsx, then preview the changes:
/tmp/cotz-balance-venv/bin/python tools/balance/balance.py import \
  --workbook balance-output/balance.xlsx \
  --baseline balance-output/baseline.json

# Apply after reviewing balance-output/import-report.json:
/tmp/cotz-balance-venv/bin/python tools/balance/balance.py import \
  --workbook balance-output/balance.xlsx \
  --baseline balance-output/baseline.json --apply

/tmp/cotz-balance-venv/bin/python -m unittest discover -s tools/balance/tests -v
```

Use `export --preview` to inspect uncommitted configuration. Such a preview is
not importable if its baseline differs from the recorded commit. After committing
your source changes, generate a fresh export for editing. Clones used for import
need the baseline commit in their history; Actions checks out full history.

`--root /path/to/cotz` before the command selects another checkout. `export
--output <directory>` changes the output directory. Import defaults to a dry run;
`--apply` is the only option that writes game files. Reports are written to
`balance-output/import-report.json` unless overridden with `--report`.

## Workbook contents

| Sheet | Editable configuration |
| --- | --- |
| Items | Price, dimensions, weight parameters, healing/quantity fields, ammo amount, protection, artifact parameters |
| Item bases | The same fields on shared item defaults |
| Weapons | Damage, fire delay, magazine/default ammo, automatic mode, spread/recoil, durability parameters |
| Mutants | Health, health variation, resistance parameters, range settings |
| Anomalies | Explicit `BalanceDamage`, `BalanceCooldown`, and `BalanceRadius` fields where defined |
| Anomaly fields | Spacing and common/rare/very-rare artifact pools |
| Metadata | Commit, baseline checksum, editing instructions |
| Column guide | Units and interpretation notes |
| Coverage | Unsupported expressions, duplicate IDs, and behavior embedded in code |

Names, IDs, sources, base identifiers, class/ammo links, and availability notes
are read-only. Blue cells are the only supported edit targets. Cell colors are a
visual guide; import validation enforces the restrictions even if the workbook
is altered. Sheets are not password protected, allowing normal sorting/filtering.

Artifact pools are JSON arrays, for example:

```json
["artifact_droplet", "artifact_bolt", "artifact_bonecluster"]
```

Order and duplicates are preserved. New pool entries must reference discovered
item IDs. An empty array clears a supported pool; an empty cell is invalid.

## Validation and conflicts

Rows are matched by sheet, ID, and source path, so sorting rows is safe. All
baseline rows must remain present exactly once. Adding/removing definitions,
adding absent attributes, changing metadata, and changing columns are rejected.
Formulas in configuration cells are rejected, including formulas in otherwise
blank cells. Keep calculations in a separate sheet.

Existing numbers must stay numeric and finite; edited numbers must be
nonnegative (weapon clip/default ammo fields also allow the `-1` sentinel).
Dimensions, counts, and rarity require integers; dimensions, fire
delay, and anomaly spacing must be positive. Existing booleans require actual
TRUE/FALSE values. Blank cells mean absent or unsupported, never zero. These
checks catch structural mistakes; they do not establish that a particular value
is balanced or appropriate to its gameplay implementation.

The importer reconstructs the baseline from its original ancestor Git commit and
checks it against `baseline.json`. Modifying hidden metadata or the manifest
cannot introduce arbitrary source paths or replacement spans.

For each edited value:

* If Lua still matches the baseline, apply the proposal.
* If Lua already matches the proposal, leave it alone.
* If Lua changed to a different value, reject the entire import with a conflict.

Untouched spreadsheet values never revert newer Lua changes. If any row fails,
no Lua files are written. Successful imports replace only the relevant literal
spans, preserving surrounding comments, encoding/BOMs, and line endings. Review
the diff and run a multiplayer development server before deploying balance edits.

## Scope and extension

This is a file-based XLSX implementation. Live Google Sheets synchronization is
not included and needs a separate adapter and account setup. XLSX and JSON files
are not committed by the exporter itself.

The discovery rules match the bundled Helix item loader's root and one-category
depth for schema and CoTZ plugin item directories. Nested `old/` subdirectories
are not recursively loaded. Top-level folders named `old` are still considered
by the loader. Archived `!unused plugins/` and bundled Helix framework items are
excluded. Plugin enablement, external addons, runtime-generated items, include
ordering, and runtime overrides are not resolved. Duplicate item IDs are
reported and made read-only rather than choosing an arbitrary definition.

Mutant/anomaly rows include the source filename in their ID because attributes
can occur in both `shared.lua` and `init.lua`. These are source definitions, not
merged runtime entities. Items show explicit values only: inheritance is not
expanded. Edit defaults on the base row, considering every inheriting item.
Conditional assignments, computed expressions, and repeated assignments are
not editable. Weapon definitions currently cover `lua/weapons/*/shared.lua`.

Mutant attacks inside initialization functions remain unsupported and are
reported in Coverage. Eight anomaly types expose their existing damage and
gameplay cooldown through explicit attributes without changing the defaults.
Other anomaly damage, sound durations, physics, and attack behavior remain code.
The workbook does not claim to calculate effective DPS, armor mitigation, vendor
prices, rolled artifact weights, or instance-specific state.

To extend support, add a field to the appropriate allowlist and give it validation
where necessary. For hard-coded behavior, first introduce a named configuration
attribute, preserve its existing default, and make the behavior read it. Add an
extraction/round-trip test before exposing new syntax. Changes to the baseline
format require a schema-version bump and fresh exports.
