# Equipment slots

Adds suit, helmet, gasmask, backpack, exoskeleton, primary weapon, secondary weapon,
knife, artifact detector, binoculars, Geiger counter, anomaly detector, headlamp,
compass, and GPS tracker slots. Drag an item from the backpack onto a compatible
slot, click anywhere on a card to choose a matching backpack item, or use its usual Equip action.
Empty cards have no inset button or text. Equipped images have no inset background.
An occupied slot must be unequipped before choosing a replacement.

Equipment appears only on the **You** tab, embedded immediately left of the backpack.
It does not appear in storage windows (including Cleaner storage), containers, or
standalone inventory windows. Tasks remain in their own main-menu tab.

Click **EQUIPMENT / HOTKEYS** to configure the four existing item hotkey assignments.
Each submenu shows its current game binding and marks its selected item. Choices
use the existing hotkey item registry and include None. Game key bindings continue
to use `gm_showhelp`, `gm_showteam`, `gm_showspare1`, and `gm_showspare2`.
Assignments are validated on the server against the registry and owned items.

Geiger counters and anomaly detectors have a **Toggle Power** context-menu action
while equipped. Their cards show a small green (on) or red (off) status light. Power is saved on the item independently
of its equipped state; switching off stops detector effects without freeing its
slot. Existing items default to on, and reconnecting or re-equipping preserves the
chosen power setting.

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
the Unequip action, or drag back onto the backpack to unequip. Dragging can start
anywhere on the outer card, while the dragged image remains compact. Drag unequip
places the item in the previewed backpack cells. The server validates the complete
footprint both when requested and after a delayed action; if those cells become
occupied, the item stays equipped instead of moving to another position.

Combined equipment occupies every applicable slot but remains one item instance.
An occupied slot must be cleared before replacing its item. Unequipping requires
enough space in the main backpack, including after a delayed action finishes.
Equipped items retain their normal weight, protection, carry bonuses, device
effects, ammunition, durability, attachments, and hotkey availability.
The existing Drop action goes directly to the world and does not require backpack
space. If another handler vetoes a drop after its unequip hook, the inactive item
remains visible in its slot; the × button returns it when backpack space is available.

## Storage and compatibility

The plugin installs runtime wrappers after `InitializedPlugins`. Device power actions
live in their owning item definitions. The schema inventory drag preview uses the
destination grid's cell size for its footprint; equipment icon controls fit their
actual item image so the dragged panel no longer includes an oversized card area.
No bundled Helix files are modified.

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

An item already marked equipped in ordinary backpack cells stays there until
unequipped and equipped again. Binoculars reuse the former PDA region without
shifting any other saved slots. A PDA saved in that region remains visible as
**PDA - RETURN TO BACKPACK**, occupying the region until returned with Unequip or
×. It cannot be equipped there again. Ordinary PDAs retain their existing actions
inside the backpack. No saved items or rows are deleted or reset.

## Admin inventory access

`/CharTakeInventory <character>` opens an item list for another online character.
Click **Take** to transfer the existing instance into the administrator's main
backpack. Equipped items first request their normal Unequip action as the owner;
click Take again once that action finishes. Normal backpack-space, carry, and
transfer restrictions apply. If the target cannot unequip into their backpack,
free space there first. No new inventory receiver permissions are granted.

Every take request rechecks command access, the active target character, exact
item membership, pending equipment actions, and destination space. Transfer
failures retain the source item. Both players are notified after a successful
take, and the displayed list refreshes. Requests are rate limited.

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
luatex --luaonly tests/equipment_admin_spec.lua
luatex --luaonly tests/equipment_interactions_spec.lua
luatex --luaonly tests/device_power_spec.lua
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
The view spec covers deferred menu attachment, duplicate prevention, storage and
standalone exclusion, independent view cleanup, refresh, and resolution changes.
The admin spec covers access, stale targets, membership, space, pending actions,
unequip requests, failed transfers, and repeated takes. The power spec checks
saved/default power, rate limits, ownership, equipped state, and effect flags.
The interaction spec checks hotkey request validation and destination-sized drag previews.
These use mocks; live drawing, menu focus, and networking still require a client.

Multiplayer acceptance checks:

- Equip and unequip each family through context menus, drag/drop, and hotkeys.
- Check all linked slots for integrated suits/headgear; reject conflicting items.
- Fill the freed backpack space; reject unequip without stripping effects, then
  free space and retry. Also fill it during the unequip delay.
- Verify weapon clips, reserve ammo, attachments, durability, armor/radiation
  protection, weight, carry bonuses, binoculars, and both detector types.
- Toggle each noisy device off/on, reconnect, and re-equip; verify its power
  setting persists and an off device stays equipped without emitting detector sounds.
- Reconnect, respawn, restart the server, switch characters during a delay, and
  travel between identically configured servers. Check item callbacks and boosts
  are applied once and no item is duplicated or lost.
- Open/close the You tab and storage windows, inspect combined-item tooltips and
  context menus, and change resolution. Verify equipment appears only on You
  and is absent from Cleaner storage and all other storage/standalone windows. Check the You page with
  and without journal entries, and verify its equipment hides on other tabs.
- Attempt repeated requests, foreign item IDs, incompatible slot IDs, and moves
  into reserved cells. Verify containers/bags keep their existing dimensions.

- Check the four hotkey assignments from the equipment heading and use their
  displayed bindings. Change character and reopen to check the selected assignments.
- Use CharTakeInventory as an admin and try requests without access, against a
  switched/disconnected target, twice for one item, with a full destination, and
  during a delayed unequip. Check successful takes retain item data and effects
  are removed from the original owner exactly once.
- Load a previously slotted PDA, return it to the backpack, then equip binoculars.
