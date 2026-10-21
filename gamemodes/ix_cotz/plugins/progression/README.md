# Character progression

Progression is owned by a Helix **character**, not a Steam account or a map.
Requirements and thresholds retain their existing amounts. Different characters
on the same account start independently.

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
`{version = 2, legacy = <previous save>}`. It does not use this archive for gameplay.
Existing vendor inventories remain intact, but progression items are gated by the
buyer's personal milestones even if they were already added by the old system.
Missing progression catalog items are registered automatically without resetting
existing stock. Stock and vendor money remain shared.

The four NPCs previously spawned by completion are now placed once per map after
saved vendors have loaded. They remain visible world entities; their dialogue,
trade, and barter access is restricted by personal milestones.

Back up the database and server data directory before deploying. Rollback requires
restoring that backup together with the previous addon version; the embedded
legacy archive alone is not a complete server backup.

Admins can use `/ProgressionGrant <character> <progressionID>` to mark a milestone
complete and activate its immediate successors. Grants do not give turn-in
rewards or replay messages. Grant preceding story milestones as needed to restore
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

Before live rollout, verify with two clients in Garry's Mod:

- One character's job completion and partial turn-ins leave the other unchanged.
- Vendor catalogs, storage, painting, and NPC access follow personal milestones.
- Locked requests fail server-side, including repeated turn-ins.
- PDA announcements and blowout/event warnings reach only eligible characters.
- Switching characters, reconnecting, restarting, and transferring servers retain
  the correct personal progress without replaying rewards or spawning duplicates.
