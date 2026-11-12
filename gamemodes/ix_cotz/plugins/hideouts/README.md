# Personal and squad hideouts

A Helix plugin for character-owned storage rooms and squad-owned interiors. The first entrant reserves a space
in a configured remote map volume, pastes a shell using advdupeint, restores
contents, and teleports inside. The last departure saves and removes the
instance. A character may own several hideouts, subject to `hideoutPersonalLimit` (0 means unlimited). Invited characters share the
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

Reusable setup can also be exported and deployed through
[First Time Setup](../firsttimesetup/README.md#hideout-setup). `/FTSDumpPluginData` writes the setup
fields to `garrysmod/data/FTSDump/hideouts.txt` for the map preset's `plugindata["hideouts"]` entry.
Player-owned rooms and their contents are excluded, as are squad-placed entrances. Shell files and
their template markers must be copied separately. Imports add missing setup IDs, preserve existing
definitions and player state, and require every instance to be unloaded. The bundled presets start
empty; author and verify each map's usable areas and entrances before exporting.

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
| Storage container | An independently installed/upgraded container; up to 32 unique slot IDs |
| Squad vendor | The default/reset position and rotation of the movable squad vendor; one |
| Legacy recovery storage | Optional administrator recovery fixture for old `storageID` inventories; one |

Markers use their exact entity origins and angles relative to the paste anchor. Place utility previews
where the real console/crate/register belongs. A spawn marker's origin marks the player's **feet**;
its yaw sets facing. Keep spawn points above the floor with room for a standing player. Both personal and squad
hideouts instantiate storage container markers; only squad hideouts instantiate the vendor. One shell can contain both.

For each storage container, choose a recipe and a permanent **slot ID** in its menu. New markers get
an ID automatically; copied markers keep their ID, so rename copies to make separate containers.
Keep the ID when moving/resaving a spot: its upgrades, sharing and inventory belong to that ID in each
hideout. Do not reuse a slot for a different recipe; loading rejects recipe changes, duplicate slots,
duplicate singleton roles and markers outside the bounds. `shop` is reserved for squad stock.
Removed spots retain their saved inventories for `/HideoutRecoveryOpen ID SPOT`.

Marker settings are saved by the duplicator, not in SQL. During hideout loading, markers are consumed
and replaced with protected runtime utilities. Unmarked roles inherit manual template settings. If any
storage container markers are present, they replace the entire manually configured container list.
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

Allocation ignores non-blocking triggers and map logic entities, including `trigger_soundscape`.
Players and solid entities still block placement, including invisible collision brushes. Entity
visibility does not determine whether a volume is clear.

Template bounds and allocation areas are separate settings. Registering a template does not
create an allocation area: the administrator must mark an empty world volume with
`/HideoutAreaStart` and `/HideoutAreaFinish NAME` on each map. The area must contain the full
`maxs - mins` size. For example, a 1024×1024×512 template uses a 16-unit below-anchor margin,
so its allocation volume must be at least 1024×1024×528. The gap separates instances; it does
not require extra border space around a single instance. Allocation errors distinguish missing
areas, areas too small for the full bounds, and failure to find a clear/unreserved placement.

## Personal storage rooms

Ballast handles Swamps (`rp_marsh_cs`), Cleaner handles Garbage (`rp_garbage_cotz`), and Ledger
handles Waystation (`rp_waystation`). Each map has one contact for all its personal hideout locations.
After configuring a template and a fixed exterior entrance, register a location as an administrator:

    /HideoutLocationAdd village cabin village "Village room"

Arguments are location ID, template ID, entrance ID and display name. Bindings are permanent; a new
entrance/template combination needs a new location ID. The command can rename an existing location.
It does not place a shell, entrance or NPC. No preset or first-time setup is run automatically.

At that contact, choose **Barter → Can I arrange a hideout or buy improvements?** Players can unlock
one free room at each configured location after the local `v3/hideout/access` milestone: hand in one
unequipped crowbar or bat to Ballast, one sledgehammer to Cleaner, or one FUBar to Ledger.
Each access hand-in consumes exactly one tool, independent of the contact's delivery difficulty.
The shared contact definition's `claimStep` accepts a numeric improvement level or a named hideout milestone.
Existing rooms retain entry and ownership. Existing owned rooms also count toward
the location claim. `/HideoutGrant` remains administrator-only and can create additional rooms using the
same entrance/template. `hideoutPersonalLimit` remains an optional map-wide cap (default 0, unlimited).

Enter a room once to resolve its dupe markers. The saved layout then supplies the exterior trader's
barter offers even while that room is unloaded. Each room has its own paid levels and inventories;
completing a contact milestone only unlocks permission to purchase. Offers show costs and locked gates.
The exterior contacts' [progression branches](../../../../docs/npc-overhaul/progression-overhaul.md)
unlock purchase permissions; they do not grant free improvements or item gifts.

### Storage and sharing

New personal rooms receive exactly one free, private **general 2×3 crate**. The first general marker
in slot-ID order is the starter; other markers start uninstalled and have no runtime entity until purchased.
If no general marker exists, `personal_starter` uses the template's storage position. Reserve that slot
ID for this fallback. Author general, ammo, medical and weapon markers for additional purchasable spots.
The marker editor now includes weapon storage. Unmarked templates can add spots with:

    /HideoutTemplateContainer cabin ammo_shelf ammo
    /HideoutTemplateContainer cabin medical_shelf medical
    /HideoutTemplateContainer cabin weapon_rack weapon

All purchases and upgrades happen at the contact's barter menu. An active room receives a new container
immediately; unloaded rooms instantiate it on next entry. Container size and model can change per level.
Allow clearance for the largest configured model when placing markers. Inventory IDs, contents and access
survive upgrades. Removed markers retain their inventories for `/HideoutRecoveryOpen ID SPOT`.

| Recipe | Initial size | Permitted contents | Installation cost |
| --- | --- | --- | --- |
| general | 2×3 | Ordinary storable items | 600 roubles + Small Utility Pouch; starter is free |
| ammo | 4×4 | `isAmmo == true` | 900 roubles + Ammunition Transit Can |
| medical | 4×4 | `base_aid` | 1,000 roubles + Injector Transport Pouch |
| weapon | 6×4 | `isWeapon == true` | 1,400 roubles + Military Transit Crate |

Inventory-bearing bags are rejected by every recipe. `sh_personal.lua` defines 12 levels per recipe,
with monotonically growing dimensions. General crates remain at most 40% of a specialized container's
capacity at the same level. Prices multiply by 2.2 each level while slot gains remain modest; subsequent
levels cost roubles only. Models switch at level 3 by default and may be configured per tier.
Only the pilot levels below are purchasable; later levels remain explicitly locked.

Owners use the entrance keypad or exit menu to invite/revoke characters. Each installed container's
owner menu opens storage, shares with all invited guests, or grants/revokes individual invited characters.
Private starts with owner-only access; selected guest permissions work while all-guest sharing is off.
The revoke-invitation menu lists only current invitees, including offline characters by ID when their name is unavailable.
Room invitations never grant storage or building rights automatically. Revocation closes affected sessions,
and transfers recheck current invitation and per-container access. Guests cannot change these controls.

### Personal progression and furnishings

Each local contact has twelve `v3/hideout/01`–`12` hand-in milestones. Each contact's additional
`v3/hideout/access` precedes their unfinished improvements and new location claims. `personalUnlockSteps` is the
editable gate table. The local contact is Ballast in Swamps, Cleaner in Garbage and Ledger in Waystation.

| Local completed step | Purchases enabled for each owned room on this map |
| --- | --- |
| 01 | Container installation at tier 1; the room's initial general crate is still free |
| 02 | Container tier 2; first loose-item upgrade, 4 → 6 (500 roubles) |
| 03 | Container tier 3; props/PET access (5,000 roubles) |
| 04 | Container tier 4; second loose-item upgrade, 6 → 8 (1,100 roubles) |
| 05–12 | Matching container tier |

For testing, administrators may use `/ProgressionGrant <character> cotz/town/ballast/v3/hideout/01` (or the matching
contact/step), then buy the desired improvement. Existing progression grants do not purchase upgrades.
The rebuilt town graph passes the offline dependency audit. Verify the natural unlock path in multiplayer.

A room permits four loose item entities by default; floor purchases increase this by two each time.
Guests share the same allowance. Drop/throwaway and direct inventory-to-world transfers enforce the cap.
Scripted outputs, such as unloaded ammo when inventory is full, and excess legacy floor items keep their
original saved rows in a waiting list. They reappear as capacity becomes free, including after restart;
no inputs or existing assets are deleted to meet the cap. A failed persistence verification retains the
live item for retry rather than risking loss. Waiting items do not occupy container slots.

Props and contextual PET tools require the room's furnishing purchase. Only its owner receives these
rights inside that room. Guests, including those allowed to use storage, cannot move furnishings or gain
PET access. Rights end on exit; no character flags are saved or shared. Existing personal furnishings stay
saved while the purchase is locked. Squad building permissions are unchanged.

### Compatibility and transaction recovery

Existing installed personal storage retains its inventory, dimensions, sharing and appearance. On first
entry it maps to the first compatible personal tier without resizing; oversized legacy containers stop
upgrading rather than shrink. Old receipt recovery applies before this one-time conversion. New personal
receipts recover paid levels independently of current progression/price changes, without another payment.
Banks remain stored separately; Ballast's bank service is retired by the progression overhaul. Existing `storageID` inventories
remain available to administrators through `/HideoutLegacyStorage ID`.

Purchases use the existing atomic item/rouble/receipt adapter. A per-room lock also protects asynchronous
inventory creation, deletion and entry. Confirmation binds to character, NPC, quote revision, expiry and
current upgrade level. Required container items must be unequipped, unbound instances in the main inventory.
Inventory assignment failure prevents payment and retains that inventory ID for retry.

### Progression ideas beyond the pilot (proposals only)

The pilot deliberately shares a small test structure; these are directions for differentiating later trees,
not additional implemented gates or promises of new quest mechanics.

| Contact | Proposed later progression |
| --- | --- |
| Ballast | Dry freight hand-ins enable more general crate spots; recovered transit hardware enables middle storage levels; larger recovery milestones buy +2 floor allowances; late freight work opens heavy storage models. |
| Cleaner | Successful dead-drop circuits enable ammunition compartments; recovered medical cases add medical spots; secured-case hand-ins open weapon racks; later circuits unlock expensive specialized levels and furnishing capacity. |
| Ledger | Label and packaging hand-ins enable individually shared general crates; intact deliveries unlock reserve medical/ammo storage; reconciled freight milestones permit higher container levels; late dispatch work opens additional +2 allowances. |

Keep each extra container tied to an authored permanent slot. Later gates should unlock a purchase,
with increasing rouble/item costs, rather than grant storage or move existing items automatically.

## Squad hideouts

Provision a target character's squad as an administrator:

    /HideoutSquadGrant "Player Name" cabin "Squad headquarters"

A squad may own **one hideout across all maps sharing the schema database**. Provision it on its home map. The stable squad ID owns it, not its leader.
Squad rooms are available at shared hideout entrance keypads on their home map without binding or placing
a squad-specific entrance. Membership, invitations and access mode still control admission. The entrance
used for a request is checked again after loading; leaving returns to that entrant's saved outside position.
Administrators see their own squad rooms alongside personal rooms and explicit invitations.

Leaders/officers can optionally open **Tab → Squads → Squad hideout** to place a dedicated entrance or relocate it.
Aim at a nearby solid surface on the home map before opening the menu and choose **Place entrance
where you are looking**. The same control is available when managing the existing entrance.
This places a shared, visible keypad entity. Existing invisible squad keypads become visible when entrances reload. Stand safely outside
interior allocation areas. Everyone interacts with the same entity; it is not a private squad portal.
Personal door keypads remain fixed. Relocation preserves occupied players' original return positions.

Squad members always have entry. The hideout management menu's **Access** selector controls outsiders:
public admits eligible characters, invite admits invited characters, and squad excludes outsiders.
The default is squad-only. Offline squads remain in the authoritative squad refresh so their shops
can be visited without members online. Unverifiable/stale membership closes privileged access;
disbanding retains the hideout and assets for administrator recovery.

Leaders/officers receive temporary prop/physgun/tool access inside their squad hideout, without
saved flag changes. It permits shared furnishings, supported appearance properties, colour/material/submaterial,
the standard and improved stacker tools on furnishing props, and furnishing removal. Stacked props use the
same capacity, bounds, ownership and persistence checks as spawned furnishings. Template geometry, fixed utilities,
unsafe tools, duplicators and arbitrary scripted entity spawning remain protected. Privileges end on exit or loss of rank/membership.

### Shared containers and furnishings

Squad rooms instantiate the same container slots, recipes, capacities and upgrade hand-ins as personal
rooms. All members can use installed containers by default; outside visitors cannot use squad containers.
An officer or leader uses a container to install/upgrade it and choose **Entire squad**, **Officers and
leader**, or **Leader only** access for that slot. Officers cannot change or upgrade leader-only containers
or set a restriction above their own rank. Leaders can change every slot. Changing access closes open
sessions; transfers and periodic session audits recheck current membership and rank.

Personal owners who have purchased furnishing access receive the same contextual tools as squad officers. Guests receive no
building privileges. Personal containers keep their existing owner/private/invited-guest sharing rules.
The personal room limit applies to new grants on this map and never removes rooms already owned.

### Prop capacity upgrades

Each personal or squad hideout starts with a **30-prop** furnishing capacity. Owners and squad
leaders/officers can buy **40**, **50**, then **60** props through hideout management at an entrance
or the interior exit (also available from squad management). The three upgrades cost **5,000**,
**10,000**, and **20,000 roubles**, paid by the managing character, once per room. Capacity purchases
do not grant furnishing permissions; personal rooms still need their existing props/PET purchase.

Only player-placed furnishings count. Shell geometry, containers, vendors and loose items keep their
existing rules. Both the spawn request and the resulting entity enforce the room-wide capacity,
shared by all builders. Old furnishings are preserved even above the current limit; remove props
or upgrade before adding more. Removed props free capacity immediately. A missing saved tier means
the initial 30-prop tier. Purchased tiers use the existing transaction journal and replay after restart
if the plugin-data save was interrupted. Deploy client and server changes together.

### Container layout and prop removal

The marker editor includes a **Suit and gear storage** recipe (`gear`) for suits, helmets, masks,
backpacks and exoskeleton frames. Inventory-bearing bags remain excluded. Add a new permanent
container slot with this recipe to the authored shell; existing slots keep their recipes and contents.
Personal lockers use the existing twelve hideout improvement gates and trader purchase flow.
Squad lockers use the existing three container hand-ins.

Players with furnishing/building access can move and freeze containers with the physgun. Squad
container rank restrictions also apply to movement. Container position and rotation survive checkpoints,
unloading and reallocation. Storage sessions close on pickup and cannot reopen while a container is held.
Movement outside the interior bounds returns the container to its last valid position. Containers cannot
be removed, duplicated or picked up with the use key or gravity gun. The legacy recovery fixture stays fixed.

Use the context menu **Remove** action or remover tool to remove props placed by the current character.
The placing character is saved with each furnishing, including squad furnishings. Another character's
props and the template shell remain protected. Old personal furnishings belong to the room owner;
old squad furnishings without a recorded placer stay protected because their original owner is unknown.

**Reset hideout layout** is available from the entrance and interior management menus, with a confirmation.
It restores the containers the owner/officer can manage to their template positions and rotations, freezes
them, and removes only that character's furnishings. It also works at the entrance while the room is
unloaded. Container inventories, upgrades, access settings, loose items, shell and squad vendor remain
intact. Leader-only containers retain their layout when an officer resets the room. The reset is blocked
while saving, loading, trading/upgrading, or holding a container. If the configuration cannot be saved,
the current layout is retained. Vendor position keeps its separate reset control.

### Vendor and treasury

The vendor is an animated Sherpa quartermaster derived from the advanced vendor entity, using the
shared [Sherpa implementation](../sherpas/README.md). It is a movable utility. Leaders/officers can move/freeze it with the physgun and use
supported appearance tools. Its local transform survives unloading/reallocation. Removal and duplication
are blocked. **Reset vendor position** is available from the entrance or interior exit management
menu; the vendor's own **Manage squad hideout** button also exposes it. This restores the template
position or recreates a missing entity without requiring proximity to that vendor. Stock is retained.
Place a **Squad vendor** marker in the shell to configure its reset point. For an unmarked role,
`/HideoutTemplatePoint cabin vendor` remains available inside a loaded instance. A blocked reset point
reports failure. Vendor movement/reset closes shop sessions.

Use the vendor's dialogue to trade, donate supplies, access the existing personal bank or manage stock.
Stock opens in the advanced vendor's two-column trading window: vendor instances on the left, eligible
player items on the right. Select an item and use Purchase/Donate; officers right-click vendor stock to
set its whole-instance price or recover it. Options contains pages, transaction history, management and
leader treasury withdrawals. The window does not remove rows optimistically when sending a request.

Administrators use **Edit Vendor** for model, name, description, bubble, sound group, animation group and
idle sequence. Skin/bodygroup properties remain available through the existing furnishing permissions.
Appearance and movement survive unloading/reallocation. Reset vendor position preserves appearance.
Catalogue/template/money controls do not apply to instance stock and are hidden for Sherpas.

The stock rules remain:

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
| Use the interior exit | Leave; owners/officers can manage invitations/access, reset the layout and reset the vendor |
| Use a container | Personal owner: open/set sharing; squad officer: open/install/upgrade/set rank; other permitted users: open |
| Use the squad vendor | Dialogue opens trading, donations and personal bank; stock Options exposes authorized management and treasury actions |
| Tab → Squads → Squad hideout | Leaders/officers can optionally place/relocate a dedicated entrance and upgrade prop capacity |

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
builder and native transactions. It uses an operation journal, treasury table and squad-home claim table;
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

The `ix_hideout_homes` registry has one primary key per schema/squad. New grants persist a disabled
pending record before reserving that key. Startup registers existing squad homes; if older saves contain
several homes across maps, the first successfully registered home remains usable and conflicting records
are blocked and logged. Their inventories and furnishings are retained for administrator recovery. Recover
assets, then explicitly retire unwanted homes with `/HideoutDelete`; deleting a conflicting record cannot
release another map's claim. Deploy all maps together so older servers cannot bypass the new registry.
No existing home is silently moved or overwritten.

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
teleports. Administrators can enter personal and squad hideouts without an invitation, including through
the entrance while noclipping; occupancy audits do not eject administrators visiting an interior directly.
Administrator keypad menus list only their own rooms and rooms that explicitly invite their current character.
Normal loading, persistence and disabled-room checks still apply. Generic world-item persistence excludes hideout floor items.
Blowout temporary-item cleanup also excludes tagged hideout floor items, including template seeds and
player drops. These items retain `bTemporary` for the separate hideout persistence path; the flag alone
does not make them disposable world loot. Check with `luatex --luaonly tests/blowout_items_spec.lua`.

AdvDupe integration retains its existing public signatures and historical
DepawnAdvDupe2Dupe helper. Optional per-paste validation, completion callbacks,
scoped dummy conversion, entity accounting, and partial-paste cleanup support
independent instances. The paste call uses the existing synchronous paste API;
confirm behavior against the server's installed AdvDupe2 version.

## Validation

From the repository root:

    python3 gamemodes/ix_cotz/plugins/hideouts/tests/run.py
    luatex --luaonly tests/fts_hideouts_spec.lua
    luatex --luaonly tests/hideout_management_spec.lua
    luatex --luaonly tests/hideout_vendor_spec.lua

This syntax-checks changed GLua and runs real server methods against mocked engine boundaries
using the system Lua shared library. Feature cases use the installed query builder and real SQLite
transactions. Coverage includes ownership/access, per-container sharing and upgrades, concurrent
purchases, rollback, saved wallet changes, treasury overdrafts/demotion, vendor reset, stable artifact
destinations and cross-map arrival/rejection, alongside existing allocation and item persistence cases.
Layout cases cover gear filtering and progression, placer ownership across reloads, rank-restricted movement,
container checkpoints/reallocation, and loaded/unloaded resets including failed saves and stale sessions.
Menu cases load the actual menu server module and cover container hand-ins/sharing/opening, invitation
updates, guest exit, initial entrance placement, vendor reset, role/location/character changes, and
administrator-only command counterparts. Shared-storage cases also exercise squad rank restrictions,
demotion during upgrades, global home claims, personal limits, and individual Sherpa custody/earnings
transactions, including full inventories and database failures.
Marker cases cover duplicator settings, exact transforms and spawn facings, replacement of markers
in the full paste lifecycle, slot identity across cold reloads, recipe/duplicate/bounds validation,
administrator editor sessions, tool permissions and marker-based vendor reset.
The vendor initialization spec loads the real hideout/Sherpa/advanced entity chain on both realms
with an empty baseclass cache, covering parent initialization, movement and delayed animation setup.

A live server smoke test is still required for actual dupe coordinates, map
geometry/PVS, model bounds, storage UI, database adapter behavior, and revive.
Test at least two occupants, two instances using the same template, repeated
item transfers/unloads, restart recovery, map cleanup, and a simulated database
failure before enabling player access.

Personal pilot checks also cover free claims at multiple locations, extra admin grants, all three local contacts,
locked/earned purchases, +2 floor steps, scripted floor overflow/recovery, per-character container sharing,
model/size changes, and owner-only PET before/after entry. Reconnect and restart with inventories full.

The feature smoke test additionally needs two real servers: verify visible entrance interaction and global squad-home uniqueness,
offline shopping, per-slot squad ranks, container sharing/revocation, temporary tools on exit/demotion, vendor appearance/movement/reset,
artifact arrival into unloaded hideouts, character switches, delayed connections, and MySQL failures.
No running Garry's Mod development session or server dupe assets were available during implementation.
For markers, also save/reload a real AdvDupe2 file with all roles, edit and resave a container without
changing its slot ID, verify exact preview placement/facing, and test vendor reset after unloading.

Layout smoke checks: move/freeze each container, unload/reenter and restart, then reset from both the
entrance and exit menus. Check occupied storage windows, guests, officers with leader-only slots,
props from two characters, out-of-bounds movement, and unchanged inventory contents/upgrades.
