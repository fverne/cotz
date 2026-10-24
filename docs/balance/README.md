# CoTZ balancing workbook

Export Lua configuration into an Excel workbook, edit its supported values, and
import the edits back into the original files. The importer never executes Lua.
It validates all rows before writing and detects concurrent edits using a Git
commit baseline. Python 3.10+ and the dependencies in `requirements.txt` are required.

The tool, tests, dependencies, and this guide live in `docs/balance/`. Submitted
workbooks go in `docs/balance/input/`; generated workbooks and reports go in
`docs/balance/output/` (ignored by Git). Workflow entry points remain in
`.github/workflows/`, as required by GitHub Actions. Game configuration remains
in its original Lua paths so Garry's Mod can load it.

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
   `docs/balance/input/` on the default branch. Do not replace the baseline with one
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
/tmp/cotz-balance-venv/bin/pip install -r docs/balance/requirements.txt

# Configuration must be committed so the export has a reproducible baseline.
/tmp/cotz-balance-venv/bin/python docs/balance/balance.py export

# Edit docs/balance/output/balance.xlsx, then preview the changes:
/tmp/cotz-balance-venv/bin/python docs/balance/balance.py import \
  --workbook docs/balance/output/balance.xlsx \
  --baseline docs/balance/output/baseline.json

# Apply after reviewing docs/balance/output/import-report.json:
/tmp/cotz-balance-venv/bin/python docs/balance/balance.py import \
  --workbook docs/balance/output/balance.xlsx \
  --baseline docs/balance/output/baseline.json --apply

/tmp/cotz-balance-venv/bin/python -m unittest discover -s docs/balance/tests -v
```

Use `export --preview` to inspect uncommitted configuration. Such a preview is
not importable if its baseline differs from the recorded commit. After committing
your source changes, generate a fresh export for editing. Clones used for import
need the baseline commit in their history; Actions checks out full history.

`--root /path/to/cotz` before the command selects another checkout. `export
--output <directory>` changes the output directory. Import defaults to a dry run;
`--apply` is the only option that writes game files. Reports are written to
`docs/balance/output/import-report.json` unless overridden with `--report`.

## Workbook contents

| Sheet | Contents / editability |
| --- | --- |
| Items - &lt;category&gt; | One sheet per item category, containing only supported attributes explicitly used by that category |
| Item bases | The same fields on shared item defaults |
| Weapons | Damage, fire delay, magazine/default ammo, automatic mode, spread/recoil, durability parameters |
| Mutants | Health, health variation, resistance parameters, range settings |
| Anomalies | Explicit `BalanceDamage`, `BalanceCooldown`, and `BalanceRadius` fields where defined |
| Anomaly fields | Spacing and common/rare/very-rare artifact pools |
| Progression overview | Read-only NPC summary: step counts, starting definitions, NPC access milestones, and maps |
| Progression steps | Read-only step catalog: descriptions, incoming/outgoing chain links, personal NPC gates, quantities, and job thresholds |
| Progression hand-ins | Read-only candidate rows grouped by personal slot: step, NPC, item, quantity if selected, pool, and source |
| Progression unlocks | Read-only successor activations, vendor items with personal stock/restock settings, personal NPC/service access, and global NPC arrivals |
| Progression item demand | All scanned item IDs, including zero-demand items, with read-only potential demand across all possible selections |
| Progression pools | Read-only pool candidates, rarity categories, and acquisition rationale |
| Progression rebalance | Read-only comparison of original requirements against each step's personal assignment range and exceptions |
| Acquisition audit | Read-only source loot probabilities, spawn quantities, harvest/cooking routes, and anomaly tiers |
| Metadata | Commit, baseline checksum, editing instructions |
| Column guide | Units and interpretation notes |
| Coverage | Unsupported expressions, duplicate IDs, and behavior embedded in code |

Item categories use each item's explicit `ITEM.category`, then the category of
its item base (including base chains). When no literal category is available,
the item directory name is used, or `Uncategorized` for root items. For example,
`Items - Aid` contains medical-item attributes, while `Items - Ammunition`
contains ammo attributes. Columns unused by every item in a category are omitted.
Category names that exceed Excel's sheet-title limit or contain invalid characters
receive a shortened, unique title. `Item bases` remains a separate defaults sheet.

Names, IDs, sources, and base identifiers are read-only. Blue cells are the only
supported edit targets. Cell colors are a visual guide; import validation
enforces the restrictions even if the workbook
is altered. Sheets are not password protected, allowing normal sorting/filtering.

### Reviewing current progression

Start with `Progression overview` to choose an NPC, then filter `Progression steps`
by that NPC. The incoming and outgoing progression IDs show the branches. Incoming
links are **alternatives**: completion of any listed predecessor activates the step;
they are not an AND checklist. `Initially active definition` reflects `defaultActive`
only; personal NPC access is still required. Maps are resolved at each registration,
including changes to the map variable within a definition file.

Use `Progression hand-ins` to inspect candidates for each requirement slot. **Only
one candidate per slot is assigned to a character**; other rows in that slot are
alternatives. `Units if selected` is the slot's fixed quantity, shared by every
candidate in that slot. Each original shared total is divided by 16, rounded up,
and split evenly across the categories with a minimum of one item per category.
`Progression steps` shows the total quantity; minimum and maximum are equal because
random selection changes item IDs, not counts. Job thresholds also divide by 16
and round up.

Counts are quantity units, not inventory stacks, guaranteed loot finds, or elapsed
playtime. `Progression item demand` includes every scanned item ID, showing zero
for items unused by progression, and retains any referenced IDs missing from the
scan. It sums potential requirements across all possible selections.
Those totals include alternatives and branches, so they are not a
combined shopping list or required playthrough cost. Item names come from the
existing item scan; missing or ambiguous IDs are flagged rather than silently resolved.

`Progression pools` shows candidates and the rarity/acquisition rationale for each
pool. `Progression rebalance` compares all 134 deliveries and five task thresholds
against their original shared requirements. It shows the divided item targets and
extra units required to keep at least one item per category. See the [balance rationale](progression/README.md).
Most deliveries now request three categories, with broader candidate selections
and overlap between related pools across the catalog. Detector3 requests six
specimens covering all five anomaly families plus an exceptional artifact.
The hand-in and pool tabs show every alternative; each character receives only
one candidate per slot. `value_personal` remains outside progression.
`Acquisition audit` includes conditional probabilities within each weighted loot
table, explicit spawn quantities, simple instance quantity ranges, guaranteed meat,
rare trophy probabilities, cooking inputs, and artifact field tiers.
Worldspawn tables 1/2 belong to the Marsh, 3/4 to Waystation,
and 5/6 to Pripyat; odd tables are ordinary loot and even tables are hard to find.
The audit labels each world route with its map tier, map name and spawn class.
Step and hand-in tabs show each delivery's `Loot map ceiling`; early low-tier
branches exclude later-map world candidates. Non-world routes remain explicit
and require their own availability review. It also includes
original items removed by the rebalance. Server map spawn-point configuration and
mutant encounter frequency are not resolved; these require live playtesting.

The game assigns and saves requests once at unlock. Reconnecting, changing maps,
opening dialogue, or editing pool definitions does not reroll existing assignments.
Fixed story keys and specialist single-item exceptions are listed explicitly.

`Progression unlocks` distinguishes personal NPC/service access and vendor purchase
eligibility and stock from global NPC arrivals. Limited stock and restock clocks
belong to each character; vendor money remains shared. It also includes the
completion gates used by storage, suit painting, blowout warnings, and event
broadcasts. Other conditions may apply in those consumers. Completion callbacks,
messages, jobs, crafting, and external plugin behavior are not exhaustively analyzed;
consult the listed source paths and line numbers. Unsupported extraction and broken
successor references appear in `Coverage`.

### Personal vendor stock

Each character has their own limited stock and restock clock for each NPC. Buying
an item cannot deplete another character's supply, including another character on
the same account. NPC entities, catalog definitions, and vendor money remain shared.

Vendor entries in `Progression unlocks` show the initial stock, maximum stock,
restock amount, and restock interval as labeled values in `Details`. Stock counts
are base configuration values multiplied by `VendorStockMult`; intervals are in
hours and are not multiplied. The workbook describes these settings, not a live
character's remaining stock.

Stock persists across reconnects and NPC respawns, keyed by map and NPC display
name. Reopening a shop does not reset it. Elapsed restocks, including time offline,
are applied when the shop is opened or stock is checked for a trade, capped at the
configured maximum. Zero restock interval or amount disables refilling. Items with
unlimited stock remain unlimited. Changing characters closes the current shop.

Admin stock edits change catalog defaults; they do not reset every character's
remaining supply. NPCs with the same display name on the same map use the same
stock identity for a character. Renaming an NPC creates a different identity.

All progression and acquisition tabs use gray cells and are **informational only**. Editing
them does not alter Lua: the importer ignores these tabs. Existing blue balance
cells retain their normal export/import behavior. Edit personal delivery slots and
pools in their Lua definitions; fresh exports regenerate these views. The historical
JSON snapshot is documentation only, not runtime migration support. The planned
server wipe starts everyone with new assignments. Runtime progression uses version 3;
the workbook baseline remains schema 2 because these read-only views add no import
fields. Generate a fresh workbook to see the new tabs.

Artifact pools are JSON arrays, for example:

```json
["artifact_droplet", "artifact_bolt", "artifact_bonecluster"]
```

Order and duplicates are preserved. New pool entries must reference discovered
item IDs. An empty array clears a supported pool; an empty cell is invalid.

## Validation and conflicts

This layout uses baseline schema 2. Workbooks and baselines from schema 1 need a
fresh export before importing; do not mix old baselines with new workbooks.

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
