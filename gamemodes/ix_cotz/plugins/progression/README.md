# Character progression

Personal progression is owned by a Helix **character**, not a Steam account or a map.
Requirements and thresholds retain their existing amounts. Different characters
on the same account start independently. NPC arrivals are persistent global world
unlocks triggered when any character completes the associated milestone.

## Progression overview workbook

The [balancing workbook](../../../../docs/balance/README.md#reviewing-current-progression)
now includes five read-only progression tabs: NPC overview, steps and chain links,
item hand-ins, unlocks, and item demand. Export it with:

```bash
/tmp/cotz-balance-venv/bin/python docs/balance/balance.py export
```

Run from the repository root after following the workbook's Python setup instructions.
The result is `docs/balance/output/balance.xlsx`; the export workflow also includes
it in its downloadable artifact. These views document current requirements before
personal quantities and randomized item pools are introduced. Editing the progression
tabs does not import changes into Lua.

The current catalog contains 139 steps: 134 item hand-ins and five job progressions.
The hand-ins contain 321 requirement entries covering 196 distinct item IDs. Counts
are quantity units, not stacks or loot finds. The workbook regenerates these details
from source and shows personal access separately from the four global NPC arrivals.

## Storage and server transfers

Character data stores `progression = {version = 2, lines = {...}}`. Reads return
snapshots; writes use `SetCharacterProgression`. Helix replicates this data only
to its owner and includes it in character saves. Turn-ins and numeric progression
updates save the character. The existing cross-server transfer code also saves
characters before redirecting them.

All participating servers must use the same character database/schema and this
version of the addon. The progression plugin no longer reads or writes
`<map>_progression` records in `ix_xserverdata`; old records can remain archived.
Do not run mixed old/new progression implementations across linked servers.

## Existing saves

Characters start with empty personal progression. Old global completion and
contributor names are not imported into individual progress.

The plugin save preserves the previous global table as
`{version = 2, legacy = <previous save>, worldUnlocks = {...}}`. Legacy completion
restores NPC arrivals only; it never grants personal progress or service access.
Existing vendor inventories remain intact, but progression items are gated by the
buyer's personal milestones even if they were already added by the old system.
Missing progression catalog items are registered automatically without resetting
existing catalog configuration. Limited stock is personal to each character; vendor
money remains shared.

## Personal vendor stock

One character's purchases never deplete another character's supply, including
characters on the same account. The workbook marks vendor unlocks as
`Personal access and stock`, with labeled initial stock, maximum stock, restock
amount, and interval in the `Details` column. Stock counts there are base values
multiplied by `VendorStockMult`; the interval is in hours and is not multiplied.
These are catalog settings, not live remaining stock for a character.

Personal vendor stock is stored server-side in character data under `vendorStock`.
The identity is the map plus NPC display name, so respawning the same NPC does not
reset a character's supply. NPCs with the same name on the same map share that
character's stock; renaming an NPC creates a different stock identity. Characters
on the same account have independent supplies. Purchases and sherpa stock changes
save the character immediately and send stock updates only to that shopper.

The NPC catalog defines initial stock, maximum stock, restock amount, and interval
in hours. Restocks are calculated from elapsed wall time when opening the shop or
checking stock for a trade, including time offline, and are capped at the configured
maximum. Reopening a shop cannot replay a refill. Zero interval or amount disables
refilling; unlimited-stock items remain unlimited. Admin stock edits configure the
catalog defaults rather than overwriting every character's current count. Changes
to catalog settings are reflected when shoppers reopen the vendor.
Changing characters closes the active vendor session.

## Global NPC arrivals

The four NPC arrivals unlock globally on the first character's completion and
are placed once on their configured map after saved vendors have loaded. Global
arrival flags survive restarts, and existing saved NPCs remain in place. Characters
without the personal milestone can have a short introduction conversation with
these NPCs. Full dialogue, trade, and barter require the character's own unlock.
Faction and class restrictions still apply to conversations.

Back up the database and server data directory before deploying. Rollback requires
restoring that backup together with the previous addon version; the embedded
legacy archive alone is not a complete server backup.

Admins can use `/ProgressionGrant <character> <progressionID>` to mark a milestone
complete and activate its immediate successors. Grants do not give turn-in
rewards or replay messages. Grants also unlock any associated global NPC arrival.
Grant preceding story milestones as needed to restore
a particular character's desired starting point.

## Integration API

Server mutations and shared queries require an explicit character:

```lua
ix.progression.IsActive(character, progressionID)
ix.progression.IsCompleted(character, progressionID)
ix.progression.GetLine(character, progressionID)
ix.progression.GetActiveProgressions(character, npcName)
ix.progression.AddProgressionValue(character, progressionID, amount)
ix.progression.TurnIn(client, vendorEntity, progressionID, itemID)
```

Definitions use `GetItemIds`, `OnComplete(character)`, `nextProgressions`, and
`vendorUnlocks`. Numeric definitions use ordered thresholds and
`OnRun(self, character)`. Completion bookkeeping is centralized. Loading saved
progress never replays completion callbacks. Client UI queries use the selected
character; there is no global client progression cache.

## Validation

From the addon root, run `luatex --luaonly tests/progression_spec.lua` (or
`lua tests/progression_spec.lua`). This exercises the actual progression library
and all definitions using GMod/Helix stand-ins.

Run `luatex --luaonly tests/vendor_stock_spec.lua` for personal stock isolation,
elapsed restocking, saved-state restoration, and real vendor purchase-handler checks.

Before live rollout, verify with two clients in Garry's Mod:

- One character's job completion and partial turn-ins leave the other unchanged.
- Vendor catalogs, storage, painting, and NPC access follow personal milestones.
- NPC arrival unlocks are shared; locked characters receive only limited dialogue.
- Locked requests fail server-side, including repeated turn-ins.
- PDA announcements and blowout/event warnings reach only eligible characters.
- Switching characters, reconnecting, restarting, and transferring servers retain
  the correct personal progress without replaying rewards or spawning duplicates.
