# Personal and squad hideouts

A Helix plugin for character-owned storage rooms and squad-owned interiors. The first entrant reserves a space
in a configured remote map volume, pastes a shell using advdupeint, restores
contents, and teleports inside. The last departure saves and removes the
instance. A character may own several hideouts. Invited characters share the
same instance and keep it loaded when the owner leaves.

Player and marker-editor menus use the shared [COTZ UI style](../../../../docs/ui-style.md), including
scrolling confirmations, wrapped actions and responsive fonts/controls. Network actions and access
checks are unchanged. Shared client checks: `luatex --luaonly tests/cotz_ui_spec.lua`.

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
3. Build the shell with **Hideout Template Marker** entities (see below), then save the complete build.
   Put the approved AdvDupe2 shell in the server's
   AdvDupe2.DataFolder/STALKERDupes/name.txt. Add a template, for example:

       /HideoutTemplateAdd cabin hideout_cabin 1024 1024 512

   The example is a filename and size illustration, not a bundled dupe.
4. The template uses the paste anchor as its origin. Bounds default to
   (-width/2, -depth/2, -16) through (width/2, depth/2, height). Spawn points
   default to local (0,0,8), (48,0,8), and (-48,0,8) when no spawn markers are supplied. Configure the shell
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

### Place points in the build with markers

As an administrator, spawn **Entities → Helix → Hideout Template Marker** beside your original shell
build. Press **E** on a marker to choose its role, then position/rotate it with the physgun. Include all
markers when copying and saving the shell in AdvDupe2. No point-placement commands are needed.

| Marker role | Result when the hideout loads |
| --- | --- |
| Player spawn | Safe arrival candidate, with its own facing direction; up to 8 |
| Exit / management | The exit entity and its player management menu; one |
| Personal storage container | An independently installed/upgraded container; up to 32 unique slot IDs |
| Squad vendor | The default/reset position and rotation of the movable squad vendor; one |
| Legacy recovery storage | Optional administrator recovery fixture for old `storageID` inventories; one |

Markers use their exact entity origins and angles relative to the paste anchor. Place utility previews
where the real console/crate/register belongs. A spawn marker's origin marks the player's **feet**;
its yaw sets facing. Keep spawn points above the floor with room for a standing player. Only personal
hideouts instantiate container markers; only squad hideouts instantiate the vendor. One shell can contain both.

For each personal container, choose a recipe and a permanent **slot ID** in its menu. New markers get
an ID automatically; copied markers keep their ID, so rename copies to make separate containers.
Keep the ID when moving/resaving a spot: its upgrades, sharing and inventory belong to that ID in each
hideout. Do not reuse a slot for a different recipe; loading rejects recipe changes, duplicate slots,
duplicate singleton roles and markers outside the bounds. `shop` is reserved for squad stock.
Removed spots retain their saved inventories for `/HideoutRecoveryOpen ID SPOT`.

Marker settings are saved by the duplicator, not in SQL. During hideout loading, markers are consumed
and replaced with protected runtime utilities. Unmarked roles inherit manual template settings. If any
personal container markers are present, they replace the entire manually configured container list.
Marker-based shells omit an unused legacy fixture unless one is marked or an old inventory needs recovery.
Saved vendor movement continues to take precedence until **Reset vendor position** uses the marked default.

To change a marked point, edit the original build, overwrite the server dupe and let affected hideouts
fully unload before entering again. Loaded instances keep their existing layout. Manual point commands
reject roles currently supplied by markers. World allocation areas, exterior door keypads and template
bounds remain separate administrator setup; interior markers do not create or relocate those.

### Manual point placement (existing templates)

For an unmarked role, while inside a loaded cabin hideout, stand where you want each point and run:

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

Template bounds and allocation areas are separate settings. Registering a template does not
create an allocation area: the administrator must mark an empty world volume with
`/HideoutAreaStart` and `/HideoutAreaFinish NAME` on each map. The area must contain the full
`maxs - mins` size. For example, a 1024×1024×512 template uses a 16-unit below-anchor margin,
so its allocation volume must be at least 1024×1024×528. The gap separates instances; it does
not require extra border space around a single instance. Allocation errors distinguish missing
areas, areas too small for the full bounds, and failure to find a clear/unreserved placement.

## Personal storage rooms

Personal entrances remain administrator-placed keypads on fixed doors. Players cannot move them.
Owners use the entrance keypad's **Manage** button or the interior exit menu to invite/revoke
characters. Using an individual container opens its owner menu: **Open storage**, **Install/Upgrade**,
and **Private/Public** sharing. Hand-ins show the required item and resulting size, with confirmation.
Invited guests use shared containers to open their ordinary storage interface; they receive no owner controls.

An invited guest can enter the room but cannot open its containers by default. Each spot is
**Private** until the owner makes that particular spot **Public** (shared with invited guests only).
Making it private or revoking an invitation closes affected sessions and invalidates transfers.
Only the owner installs/upgrades containers or changes sharing. Upgrades preserve sharing and contents.

Container markers are the preferred way to place these spots in the shell. For templates without
container markers, an administrator can still stand at a position inside a loaded personal hideout and run:

    /HideoutTemplateContainer cabin left general
    /HideoutTemplateContainer cabin ammo_shelf ammo
    /HideoutTemplateContainer cabin medical_shelf medical

Spot IDs are permanent per template. Reusing an ID moves that spot; it does not create a new
inventory. Recipe changes in place are rejected. Removed spot definitions retain their saved
inventories for explicit recovery. New spots start locked. Models lift 16 units from the marked feet
position; inspect placement and clearance before giving players access.

Recipes live in `sh_definitions.lua`; they explicitly define each tier's input and resulting capacity:

| Recipe | Successive hand-ins | Storage sizes | Contents |
| --- | --- | --- | --- |
| general | Small Utility Pouch, Deep Utility Crate, Military Transit Crate | 3×3, 6×6, 10×8 | Ordinary storable items |
| ammo | One Ammunition Transit Can per tier | 4×4, 6×6, 10×8 | Items marked `isAmmo` |
| medical | One Injector Transport Pouch per tier | 3×3, 5×5, 8×6 | `base_aid` items |

Each hand-in affects only that hideout's selected spot. These are starting balance values for
administrators to review before provisioning. Existing installed capacities are saved; recipe edits
cannot silently shrink them. Inventory-bearing bags are not accepted. There is no uninstall or refund.

Existing banks and bank upgrades remain available through Ballast. Hideouts no longer open a bank
or automatically move items between a former hideout stash and a bank. Old `storageID` stashes remain
accessible to administrators through `/HideoutLegacyStorage ID` near the old recovery fixture.

## Squad hideouts

Provision a target character's squad as an administrator:

    /HideoutSquadGrant "Player Name" cabin "Squad headquarters"

One squad hideout may be provisioned per squad per map. The stable squad ID owns it, not its leader.
Leaders/officers open **Tab → Squads → Squad hideout** to place the first entrance or relocate it.
Aim at a nearby solid surface on the home map before opening the menu and choose **Place entrance
where you are looking**. The same control is available when managing the existing entrance.
This places its shared invisible interaction entity. Stand safely outside
interior allocation areas. Everyone interacts with the same entity; it is not a private squad portal.
Personal door keypads remain fixed. Relocation preserves occupied players' original return positions.

Squad members always have entry. The hideout management menu's **Access** selector controls outsiders:
public admits eligible characters, invite admits invited characters, and squad excludes outsiders.
The default is squad-only. Offline squads remain in the authoritative squad refresh so their shops
can be visited without members online. Unverifiable/stale membership closes privileged access;
disbanding retains the hideout and assets for administrator recovery.

Leaders/officers receive temporary prop/physgun/tool access inside their squad hideout, without
saved flag changes. It permits shared furnishings, supported appearance properties, colour/material,
and furnishing removal. Template geometry, fixed utilities, unsafe tools, duplicators and arbitrary
scripted entity spawning remain protected. Privileges end on exit or loss of rank/membership.

### Vendor and treasury

The vendor is a movable utility. Leaders/officers can move/freeze it with the physgun and use
supported appearance tools. Its local transform survives unloading/reallocation. Removal and duplication
are blocked. **Reset vendor position** is available from the entrance or interior exit management
menu; the vendor's own **Manage squad hideout** button also exposes it. This restores the template
position or recreates a missing entity without requiring proximity to that vendor. Stock is retained.
Place a **Squad vendor** marker in the shell to configure its reset point. For an unmarked role,
`/HideoutTemplatePoint cabin vendor` remains available inside a loaded instance. A blocked reset point
reports failure. Vendor movement/reset closes shop sessions.

Use the vendor to shop or manage stock:

- Members donate actual items into squad-owned stock without payment. Donations are final squad property.
- Leaders/officers publish prices, reprice, cancel listings (price zero), or recover stock without payout.
- Every buyer, including members, pays the displayed whole-instance price. Quantity, durability,
  custom names, bookmarks and other instance data stay on the original item row.
- Only paid sales credit the shared squad treasury. Default commission is 5%, rounded down, controlled
  by `hideoutSaleCommission`. A 1,000-rouble purchase credits 950; donations and cancellations credit zero.
- Only the leader withdraws treasury funds to their own character. Members can view recent transactions.
- Stock defaults to a 10×8 grid; `hideoutStockWidth`/`hideoutStockHeight` apply to new inventories.
  Listed and unlisted stock share that capacity. Shop pages contain at most 20 entries.
- Equipped, bound, non-transferable, field cargo and inventory-bearing items are rejected.
  Normal NPC reward/progression callbacks are not invoked.

## Player menus and administrator recovery

Players do not need chat commands. All hideout commands are restricted to administrators.

| Interaction | Available actions |
| --- | --- |
| Use the entrance keypad or squad entrance | Enter an accessible hideout; owners/officers can manage access and invitations |
| Use the interior exit | Leave; owners/officers can manage invitations/access and reset the vendor |
| Use a personal container | Owner: open, install/upgrade, change sharing; invited guests: open if Public |
| Use the squad vendor | Shop, donate, manage listings, treasury/history; officers can open hideout management |
| Tab → Squads → Squad hideout | Leaders/officers can place the first entrance or relocate it on this map |

Management requests bind to the active character and the relevant entrance, exit, vendor, or container.
Actions recheck the current role and location. Container actions apply only to the container whose
menu is open; moving away or switching characters invalidates that session. A guest's exit menu
allows leaving without granting management privileges. Vendor reset also remains accessible when
the vendor itself is missing or unreachable. The squad-tab menu never permits remote container access.

Setup, grant, status, deletion, retry-save and recovery commands remain available to administrators.
The former player commands (`HideoutEnter`, `HideoutLeave`, `HideoutManage`, `HideoutInvite`,
`HideoutRevoke`, `HideoutEntrancePlace`, `HideoutAccess`, `HideoutVendorReset`, and container commands)
are administrator-only fallbacks.
`/HideoutRecoveryOpen ID SPOT` opens an existing or retired container for withdrawal;
use `shop` for squad stock. This also recovers assets after disbanding or character deletion.
Recovery sessions bind to the administrator's character and position and permit withdrawal only.
Banks are never deleted by hideout deletion. Legacy floor-item deletion behaviour is unchanged.

## Artifact and cross-map travel

Compass records a stable hideout reference (schema/map/hideout ID and local transform) when used
inside an authorized interior. Moon, bedroll checkpoints and their respawn consumer support the same
representation. Ordinary world-coordinate bookmarks remain supported. Artifacts retain their existing
30-second channel and 15-minute cooldown. A failed hideout admission does not spend that cooldown.

A bookmark does not grant permission: entry rechecks current invitations/squad access. The target
instance loads if needed; a blocked local bookmark falls back to configured safe spawn points.
Cross-map travel uses existing redirect and presence handoff APIs and a character-scoped, expiring
arrival intent. MySQL connections restore fresh character data rather than replaying a previous map's
Helix character cache. Destination admission registers occupancy and an outside return point, then clears
that intent. Spawn Saver cannot restore raw coordinates over this admission. Cross-map exit uses the
destination entrance/recovery point. Denied/expired arrivals remain outside. Deploy all maps together.

Old raw bookmarks into reserved interior volumes must be recorded again. Their original instance
cannot safely be inferred from whichever interior now occupies those coordinates.

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

Container state, templates, access, entrance placement and vendor transforms use plugin data.
Ordinary item data/inventory creation/restoration and storage sessions use Helix APIs. The narrow
`sv_operations.lua` adapter coordinates economic commits through the existing structured query
builder and native transactions. It adds only an operation journal and shared squad treasury table;
it does not replace normal inventory/item persistence. MySQL requires mysqloo transaction support
and InnoDB for `ix_items`, `ix_characters` and the two new tables. Engine compatibility is checked;
this plugin never converts existing tables. SQLite transactions support local tests/development.

Purchases, stock recovery/donation and upgrade hand-ins lock affected custody while committing.
Outgoing money is reserved immediately; character saves are deferred until the outcome is known,
then unrelated wallet changes are preserved while the character session remains active. Upgrade journal entries replay committed entitlements
if the plugin-data projection was interrupted. An uncertain database outcome retains locks and logs
its operation token rather than issuing a speculative refund or replay. Lost commit acknowledgements
are checked against receipts. After disconnect/session loss, an old character object cannot save over
a newer session; its next selection refreshes authoritative character data. Resolve the database issue
and restart to restore authoritative rows; do not hot-reload during pending economic work.

The version-2 migration labels existing records as character-owned and initializes container state
without resetting banks, inventory IDs, furnishings, item data or invitations. Deleted records retain
new inventory references under retired state for explicit administrator recovery. The journal is
indexed for upgrade replay and recent squad history; retain it with database backups.

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
prop_dynamic_override, ix_dupedummyitem, and ix_hideout_marker. Arbitrary scripted entities,
NPCs, vehicles, and standard containers are not serialized. Use template markers for interior
utilities and storage spots. Shell props are fixed and protected; props spawned by permitted
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

This syntax-checks changed GLua and runs real server methods against mocked engine boundaries
using the system Lua shared library. Feature cases use the installed query builder and real SQLite
transactions. Coverage includes ownership/access, per-container sharing and upgrades, concurrent
purchases, rollback, saved wallet changes, treasury overdrafts/demotion, vendor reset, stable artifact
destinations and cross-map arrival/rejection, alongside existing allocation and item persistence cases.
Menu cases load the actual menu server module and cover container hand-ins/sharing/opening, invitation
updates, guest exit, initial entrance placement, vendor reset, role/location/character changes, and
administrator-only command counterparts.
Marker cases cover duplicator settings, exact transforms and spawn facings, replacement of markers
in the full paste lifecycle, slot identity across cold reloads, recipe/duplicate/bounds validation,
administrator editor sessions, tool permissions and marker-based vendor reset.

A live server smoke test is still required for actual dupe coordinates, map
geometry/PVS, model bounds, storage UI, database adapter behavior, and revive.
Test at least two occupants, two instances using the same template, repeated
item transfers/unloads, restart recovery, map cleanup, and a simulated database
failure before enabling player access.

The feature smoke test additionally needs two real servers: verify invisible entrance interaction,
offline shopping, container sharing/revocation, temporary tools on exit/demotion, vendor movement/reset,
artifact arrival into unloaded hideouts, character switches, delayed connections, and MySQL failures.
No running Garry's Mod development session or server dupe assets were available during implementation.
For markers, also save/reload a real AdvDupe2 file with all roles, edit and resave a container without
changing its slot ID, verify exact preview placement/facing, and test vendor reset after unloading.
