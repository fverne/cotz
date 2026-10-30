# Equipment slots

Adds suit, helmet, gasmask, backpack, exoskeleton, primary weapon, secondary weapon,
knife, artifact detector, PDA, Geiger counter, anomaly detector, headlamp, compass,
and GPS tracker slots. Drag an item from the backpack onto a compatible slot or
use its usual Equip action.
Each `ixStalkerInventoryPanel` gets an equipment companion, including the **You**
tab, Cleaner storage, other containers, and standalone inventory windows. On the
You tab it remains embedded immediately left of the backpack, with the journal
using the remaining space. Closing a backpack removes its own equipment companion.
Multiple views have independent panels and receive the same equipment updates.

Storage displays the container on the left, equipment in the middle, and the
backpack on the right. Large storage grids shrink visually to fit; capacity and
item dimensions are unchanged. An `EditablePanel` popup hosts the complete storage
view above NPC dialogue, including its manually painted inventory children. The
host is removed with storage. Standalone companions use the available side of
their inventory window.
The Field Locker layout groups protection, weapons, and devices into thin-bordered
cards. Weapon slots are wider than the knife slot. Cards wrap to additional rows
as space shrinks, with scrolling above a fixed bottom protection summary. Fonts,
spacing, cards, and the footer scale with screen size; the journal retains space
when present, and the equipment area uses the full remaining width otherwise.
Journal space is reserved only for an actual `ixCharacterJournalPanel`; transient
subpanel controls during menu creation do not reduce the equipment width.
The footer shows ballistic, rupture, radiation, anomaly, and psy percentage reduction.
Its tooltips report flat absorption separately, matching the existing damage formulas.
Values refresh while the page is visible, and real item durability appears on cards
where that state exists. The UI does not introduce new gameplay statistics.
Slotted icons omit equipped badges and small corner condition indicators. Full-width
card bars show durability above wear when both exist, or a single bar for knife
sharpness, durability, or wear. Ordinary backpack icons keep their existing overlays.
Section headers use the same plain label and thin divider as the bottom protection header.
Equipment icons use the existing `ix.util.GetItemIcon` material cache, including
its `img` priority, rather than rebuilding spawn icons when the menu opens.
Icons preserve their aspect ratio and shrink to fit each slot, capped at their
owning backpack grid's display size so larger slots never enlarge an item image.
Right-click equipped icons for the existing item actions. Use the × button,
the Unequip action, or drag back onto the backpack to unequip.

Combined equipment occupies every applicable slot but remains one item instance.
An occupied slot must be cleared before replacing its item. Unequipping requires
enough space in the main backpack, including after a delayed action finishes.
Equipped items retain their normal weight, protection, carry bonuses, device
effects, ammunition, durability, attachments, and hotkey availability.
The existing Drop action goes directly to the world and does not require backpack
space. If another handler vetoes a drop after its unequip hook, the inactive item
remains visible in its slot; the × button returns it when backpack space is available.

## Storage and compatibility

All runtime changes live in this plugin. No Helix files or existing item definitions
are edited. The plugin installs runtime wrappers after `InitializedPlugins`.

Equipment uses reserved cells of the **same character inventory**, rather than a
second inventory with a different ID. This deliberately preserves existing
`invID` checks, `GetItems(true)`, `HasItem`, repair/attachment targets, item ownership,
and Helix's item loadout, attribute boost, save, death, removal, and sync paths.
`GetItems` and item callbacks are not replaced or replayed. Existing consumers
still see equipped items exactly as they did before; their own rules determine
whether they may sell, consume, or otherwise interact with an equipped item.

Columns 32–63 contain fifteen 8 × 8 equipment regions. Main inventory dimensions
must be below 32 columns and at most 63 rows. Ordinary fitting, adding, and movement
are limited to the original backpack dimensions. `GetSize()` returns those
dimensions; internal storage dimensions include the reserved cells. Bags and
containers retain their original behavior.

The bundled character loader calls `ShouldRestoreInventory` before restoring its
inventories. The plugin marks the untyped character inventory and expands its
restore dimensions before Helix reads item positions. This is required because
the bundled restore implementation otherwise discards positions outside its grid.
Other inventory restores are passed through unchanged. New characters receive the
same layout without a second inventory or new database tables.

Equipment transitions persist coordinates and item data together in one item-row
update. Normal item action callbacks still run through Helix's dispatcher, including
their hooks and post-hooks. Delayed equipment callbacks recheck character identity,
ownership, life state, permissions, equipped state, conflicts, and backpack space.
Only equipment actions use the guarded black-screen callback wrapper; other uses
of the helper are passed through unchanged.

There is **no legacy migration**. An item already marked equipped in ordinary
backpack cells stays there until unequipped and equipped again.

## Removal

Unequip items on **all characters that have used the slots** before deleting or
disabling the plugin, then restart the server. Re-equipping after removal uses the
original inventory behavior. Do not hot-disable it while players are using it:
runtime wrappers are installed for the lifetime of the Lua session.

Removing the plugin while items remain in reserved cells makes those items fall
outside the original loader's dimensions. Their database rows remain, but they
will not load until the plugin is restored. There is no automatic conversion or
uninstall migration.

## Verification

From the repository root:

```sh
luatex --luaonly tests/equipment_slots_spec.lua
luatex --luaonly tests/equipment_layout_spec.lua
luatex --luaonly tests/equipment_views_spec.lua
luatex --luaonly tests/headgear_durability_spec.lua
luatex --luaonly tests/helix_upgrade_spec.lua
```

The equipment spec exercises the plugin with bundled inventory enumeration,
fitting searches, removal, and the bundled item-action dispatcher plus mocked
Garry's Mod networking, timers, and database calls. It does not establish runtime
VGUI or multiplayer correctness.
The layout spec checks slot/header/footer bounds and overlap at 1024×768, 1280×720,
1366×768, 1600×900, 1920×1080, 2560×1440, 3440×1440, and 3840×2160, with inventory
scales of 0.8, 1, and 1.25 and with/without journal space. These geometry checks do
not verify engine docking, font rendering, tooltips, or drag/drop in a live client.
The view spec covers deferred attachment, duplicate prevention, storage popup
hosting, independent view cleanup, multi-view refresh, resolution changes, and
storage/equipment/backpack bounds. It uses mocked VGUI controls; live popup drawing
and mouse/keyboard focus still require a multiplayer client check.

Multiplayer acceptance checks:

- Equip and unequip each family through context menus, drag/drop, and hotkeys.
- Check all linked slots for integrated suits/headgear; reject conflicting items.
- Fill the freed backpack space; reject unequip without stripping effects, then
  free space and retry. Also fill it during the unequip delay.
- Verify weapon clips, reserve ammo, attachments, durability, armor/radiation
  protection, weight, carry bonuses, PDA, and both detector types.
- Reconnect, respawn, restart the server, switch characters during a delay, and
  travel between identically configured servers. Check item callbacks and boosts
  are applied once and no item is duplicated or lost.
- Open/close the You tab and storage windows, inspect combined-item tooltips and
  context menus, and change resolution. Verify equipment stays beside the inventory
  in every view, including Cleaner storage above dialogue. Check the You page with
  and without journal entries, and verify its equipment hides on other tabs.
- Attempt repeated requests, foreign item IDs, incompatible slot IDs, and moves
  into reserved cells. Verify containers/bags keep their existing dimensions.
