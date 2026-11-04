# Character hideouts

A Helix plugin for character-owned interiors. The first entrant reserves a space
in a configured remote map volume, pastes a shell using advdupeint, restores
contents, and teleports inside. The last departure saves and removes the
instance. A character may own several hideouts. Invited characters share the
same instance and keep it loaded when the owner leaves.

All implementation changes live under ix_cotz. Item/inventory integration uses
schema method overrides, and world-item persistence uses the schema's saveitems
plugin override. The upstream helix directory remains unchanged.

## Setup

Run these commands in game as an administrator. Configuration and hideout records
are saved per map through PLUGIN:SetData; repeat setup for each map.

1. Mark the usable remote area. Stand at its lower corner and run
   /HideoutAreaStart. Move to the diagonally opposite upper corner and run
   /HideoutAreaFinish remote. These are positions at your feet, not eye-trace
   points. Use noclip to mark the upper corner. The entire volume must be usable
   empty space inside the world. Stay clear of arenas and other dynamic systems.
2. Return to normal playable ground and run /HideoutRecovery. This is the
   fallback outside position if a player's original return point is blocked.
3. Put an approved AdvDupe2 shell in the server's
   AdvDupe2.DataFolder/STALKERDupes/name.txt. Add a template, for example:

       /HideoutTemplateAdd cabin hideout_cabin 1024 1024 512

   The example is a filename and size illustration, not a bundled dupe.
4. The template uses the paste anchor as its origin. Bounds default to
   (-width/2, -depth/2, -16) through (width/2, depth/2, height). Spawn points
   default to local (0,0,8), (48,0,8), and (-48,0,8). Configure the shell
   so these are above its floor, with standing room. You can fine-tune the points
   by standing inside the loaded hideout after completing steps 5–7 below.
5. Stand at a safe outside return location, look at a nearby wall or floor,
   and run /HideoutEntranceAdd village. This places an entrance keypad at
   the trace and records your feet position as an outside exit candidate.
6. Grant a hideout to a player's current character:

       /HideoutGrant "Player Name" cabin village "My cabin"

   Grant again to give that character another hideout.
7. Use the keypad, or /HideoutEnter ID near its entrance. Verify the pasted
   bounds, floor, spawn clearance, exit, and storage before provisioning players.
   Return using the exit entity or /HideoutLeave.

While inside a loaded cabin hideout, stand where you want each point and run:

    /HideoutTemplatePoint cabin spawn
    /HideoutTemplatePoint cabin exit
    /HideoutTemplatePoint cabin storage

The commands use your feet position relative to that instance, so you do not
need to calculate local coordinates. Spawn also records your facing direction
and replaces the default spawn candidates with one candidate; it applies to
future entries. Exit and storage move immediately in all loaded hideouts using
the template, with their models lifted clear of the floor. Move away after placing
them. The positions persist for future loads as well. Wait for any loading or
saving instance of this template to finish before editing.

Explicit local coordinates remain supported, for example
/HideoutTemplatePoint cabin spawn 0 0 8. With coordinates omitted, you must stand
inside a loaded hideout using that template; standing by the original build
elsewhere on the map does not identify its paste anchor.

The allocator uses template bounds plus hideoutGap (512 units by default),
checks geometry/entities, and reserves space before loading. It does not
reposition occupied hideouts. Area, entrance, and template-dimension edits require
all instances to be unloaded; point placement can be edited live as described
above. An oversized or obstructed dupe is rejected without teleporting anyone.

## Commands

| Command | Access | Purpose |
| --- | --- | --- |
| HideoutList | Admin | List accessible hideouts for this character |
| HideoutEnter ID | Admin | Enter near the associated entrance |
| HideoutLeave | Admin occupant | Return outside |
| HideoutInvite ID PLAYER | Admin owner | Grant access to the target's active character |
| HideoutRevoke ID PLAYER | Admin owner | Revoke that character's access and attempt evacuation |
| HideoutStatus | Admin | Inspect loaded instances and occupants |
| HideoutRetrySave ID | Admin | Retry a completed but unsuccessful save |
| HideoutDelete ID | Admin | Delete the hideout and its remaining contents |
| HideoutLegacyStorage ID | Admin occupant | Recover overflow from an old private stash near its storage entity |

All hideout commands are admin-only. Character access still controls normal
entrance menus, exit entities, and storage use; players use those interactions.

Deletion also runs when the owner character is deleted. Items already exported
to another inventory are retained. Failed deletion leaves a deletion marker
that prevents further entry; resolve the problem and retry the command.
Map setup commands are described above.

## Persistence and duplication handling

Loose items have one authoritative Helix ix_items row. Its data.cotzHideout
contains schema, map, hideout ID, local position/angles, and movable state.
The entire normal item data table remains in Helix. Unloading safely removes the
entity and releases its in-memory item instance; it does not delete the row
or store a separately replayable item copy. Loading uses ix.item.New and
item:Spawn to reconstruct the existing row.

Pickup writes the new inventory_id and clears hideout metadata in the same SQL
update. A drop inside a hideout writes its provisional local placement and
inventory_id = 0 together, before spawning the entity; OnItemSpawned refines
the actual drop position. Destruction and successful world consumption delete
the row. Restoration selects only world rows (inventory_id = 0) that still
match this hideout. A stale checkpoint cannot recreate a deleted row or one
now belonging to a player inventory.

Item dummies in the shell are seeded once per hideout. Their chosen item/data
and initialization flags are saved before players enter. The seed key is part
of the inserted item row, allowing an interrupted first load to find an existing
seed instead of inserting it twice. Taking or consuming seeded loot does not
replenish it on subsequent visits.

Storage opens the visitor's character bank (bankID), using the same personal
storage service and inventory as Ballast. Bank width/height upgrades apply in
both places. Each visitor sees their own bank, including invited guests. All
hideouts belonging to a character access that same bank. Closing or deleting a
hideout does not delete its owner's bank. It remains separate from generic
ix_container persistence/removal. No bag-specific serialization is implemented.

Existing private hideout stashes remain saved. When the owner opens the hideout
storage, their former stash contents transfer into their personal bank where
possible. Items that cannot transfer remain in the original inventory. An admin
inside that hideout can use /HideoutLegacyStorage ID near its storage entity to
recover leftovers. Guests never automatically receive the owner's legacy items.

Loose-item placement is checkpointed every hideoutCheckpoint seconds and on
unload. Ordinary item data changes continue using Helix's own saves.
Transfers, actions, and damage are blocked while a save is in progress. Failed
or stalled saves retain the instance reservation. A connection that never
returns a callback requires fixing the database connection and restarting;
saved item rows remain authoritative. A hard crash can lose movement since
the last placement checkpoint, but should not mint another item copy.

## Supported content and integrations

Loaded hideout volumes are safe zones: incoming/outgoing damage is blocked,
including radiation/psy damage and armor wear from those damage events. Players
receive the same passive healing and radiation-protection buffs as near town
NPCs, using the existing regeneration amount and interval settings. Safe-zone
protection uses physical bounds and ends when the player leaves those bounds;
town-style buffs expire normally after their short duration.

Shell templates accept prop_physics, prop_physics_multiplayer, prop_dynamic,
prop_dynamic_override, and ix_dupedummyitem. Arbitrary scripted entities,
NPCs, vehicles, and standard containers are not serialized. Use the dedicated
storage entity. Shell props are fixed and protected; props spawned by permitted
players inside the instance are tracked furnishings, with local transforms,
model, skin, color, material, bodygroups, submaterials, and movable state.
Other entities created inside an instance are tracked for runtime cleanup;
persistent custom scripted-entity state requires a class-specific serializer.

The plugin has explicit occupancy, cancellation, timeouts, cleanup, disconnect,
character switching/deletion, and revive/respawn handling. Reviving retains the
instance; a final respawn returns outside. The normal Spawn Saver stores outside
return positions for hideout occupants and intercepts old interior restores.
Area membership is audited once per second, including intruders and external
teleports. Generic world-item persistence excludes hideout floor items.

AdvDupe integration retains its existing public signatures and historical
DepawnAdvDupe2Dupe helper. Optional per-paste validation, completion callbacks,
scoped dummy conversion, entity accounting, and partial-paste cleanup support
independent instances. The paste call uses the existing synchronous paste API;
confirm behavior against the server's installed AdvDupe2 version.

## Validation

From the repository root:

    python3 gamemodes/ix_cotz/plugins/hideouts/tests/run.py

This syntax-checks changed GLua and runs the real server plugin methods against
mocked engine/Helix boundaries using the system Lua shared library. It covers
ownership, allocation, entry/exit, concurrent requests, item persistence,
consumption, stale rows, save failures, initialization, and AdvDupe cleanup.

A live server smoke test is still required for actual dupe coordinates, map
geometry/PVS, model bounds, storage UI, database adapter behavior, and revive.
Test at least two occupants, two instances using the same template, repeated
item transfers/unloads, restart recovery, map cleanup, and a simulated database
failure before enabling player access.
