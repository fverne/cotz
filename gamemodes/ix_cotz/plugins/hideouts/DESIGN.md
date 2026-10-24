# Dynamic character hideouts

Implemented as gamemodes/ix_cotz/plugins/hideouts. See the
[plugin setup and validation guide](README.md).

## Ownership and placement

- Permanent records use character IDs; each character can own multiple hideouts.
- Owners can invite other characters. Every occupant keeps the shared instance
  alive independently of the owner.
- Each map has administrator-defined remote usable volumes and outside entrances.
- Template bounds plus configurable clearance determine available spaces.
  Reservations include loading, saving, and failed instances.
- Physical slots are temporary. Stored positions are relative to the hideout
  origin, so a subsequent visit may use another slot.
- Initial access/provisioning uses admin commands. Purchases, rent, factions,
  raids, cross-map access, and arbitrary scripted-entity adapters are extensions.
- All hideout commands are admin-only; players use the entrance/exit entities.
- Loaded interiors block damage and provide town-style healing/radiation buffs.

## Lifecycle

UNLOADED -> LOADING -> ACTIVE -> SAVING -> UNLOADED

1. Validate character access, outside entrance proximity, player state, and space.
2. Reserve a space; concurrent entry requests share one load.
3. Paste the shell through AdvDupe integration, restore furnishings, attach
   storage, seed initial items once, and restore remaining floor items.
4. Save the outside return position before admitting the player. Check their
   character, access, location, and spawn clearance again after asynchronous work.
5. Maintain explicit occupancy and audit external movement. Downed characters
   retain occupancy during the revive window.
6. On the last departure, close storage, block mutations, checkpoint contents,
   remove runtime entities, and release the slot after successful saving.
7. Failed saves retain the instance for recovery. Timed-out loads invalidate their
   callbacks and remove partial runtime entities while retaining saved item rows.

Disconnects, character changes/deletion, respawn/revive, map cleanup, and normal
Spawn Saver behavior are integrated. Reconnects recover outside.

## Item persistence decision

The user permits new item database IDs, but preserving the existing Helix row
makes duplication prevention simpler than replacing rows and coordinating a
second snapshot store.

- The Helix item row is the only authoritative item copy, occupied or unloaded.
- Hideout membership/local placement lives in that row's item data alongside
  quantity, durability, upgrades, names, and other ordinary persistent data.
- Unload safely removes the entity, retaining its row. Load reconstructs the same
  row using Helix item functions; it does not insert a replacement.
- Pickup changes inventory membership and clears hideout placement in one update.
- Dropping into a hideout changes inventory membership and records provisional
  placement in one update, then refines placement after spawning.
- Deleted/consumed items have no row to restore. Items exported to an inventory
  fail the floor-row selection even if old placement metadata survives.
- Initial dummy loot has persisted seed choices and initialization flags. A seed
  key inserted with its item row prevents a canceled first load duplicating it.
- Storage opens each visitor's personal bank, shared with Cleaner and all their
  other hideouts. Guests access their own banks. Existing private stashes migrate
  to their owner's bank where possible; overflow stays available for admin recovery.
  Generic container removal/persistence is not used. No bag-specific work is included.

This avoids the proposed multi-row snapshot/live-item transaction: the economic
transition is a single update to the existing authoritative row. File snapshots
contain furnishings and configuration, not alternative loose-item copies.
Periodic position checkpoints can lose recent movement after a hard crash.

## AdvDupe and Helix changes

- Operation-local paste data, duplicate-ID rejection, explicit failure/completion,
  scoped dummy conversion, tracking of converted items and pasted constraints/
  children, late-callback cancellation, and partial-paste cleanup.
- Existing event/arena signatures and the historical despawn-helper spelling
  remain supported.
- Schema overrides add narrow hooks for world-item save/restore exclusion, atomic item
  transfer/drop metadata, world-item consumption, and outside character
  save/restore positions.
- A revive hook distinguishes resurrection from final respawn.
- Integration methods and the saveitems/spawnsaver plugin overrides live entirely
  under ix_cotz; the upstream helix directory remains unchanged.

## Verification

Automated server-method regression tests run against mocked Helix/engine
boundaries, plus syntax checks of changed GLua. Live map/AdvDupe2/database/UI
verification remains necessary; no server or dupe files are bundled in this
checkout. Actual volumes, recovery points, entrances, template bounds, and dupe
names must be configured per map.
