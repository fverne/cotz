# Helix upgrade test checklist

Target: Helix `bb8bf86988b980d576419597ae6b966ee939e409` with COTZ compatibility patches on `feature/helixupdate`, based on `origin/dev`. The progression-overhaul commits and personal vendor-stock system are excluded. Dev’s existing progression and Sherpa behavior remain unchanged.

Run the priority checks first on a test server with a copy of your usual addons, content and saved data. Use a full server restart and reconnect clients; this update changes framework code and networking. Keep the server console and client console open throughout. A check passes only when its expected result holds and neither console gains a related Lua error.

Before testing persistence, back up the database and the server's Helix saved data. The upgrade does not migrate or reset them. The pre-upgrade source archive is `/tmp/cotz-helix-upgrade-backup/gamemodes-before.tar.gz`; copy it somewhere durable if you want to keep it, because `/tmp` is temporary. Do not overwrite a running server to roll back.

## Priority checks

- [ ] **T01 — Boot and existing characters.** Restart, join, load an existing character, switch characters, then reconnect. **Expected:** the schema and plugins load; names, factions, money, progression, equipment and inventories remain intact. Check startup output for missing APIs, plugin failures, CAMI/admin integration errors and database errors.
- [ ] **T02 — Item lifecycle and inventory layout.** Use a 1×1 item and a larger item. Move each between inventory cells, drop it, pick it up, transfer it through a container, then sell/use one. **Expected:** exactly one item is transferred/consumed, quantities and money change once, no ghost icons or blocked empty cells remain, and the larger item's occupied cells stay consistent.
- [ ] **T03 — Bags and equipment restoration.** Put a usable item in a bag inventory, where supported, and exercise a feature that searches for that item (for example, suit customization that needs paint). Reconnect with a weapon, suit and bag equipped. **Expected:** bag contents are still found, equipment/PAC restores once, ammo and attachments persist, and equipment limits still apply. Test multiple bag levels only if COTZ permits them; prohibited bag nesting should stay prohibited.
- [ ] **T04 — Generated item icons.** In the client console run `ix_flushicon`, then open inventories/vendor lists with a material-customized generated icon, a normal generated icon and an image-based icon. **Expected:** generated icons rebuild with the right camera/material; the normal icon does not inherit the previous item's material; image icons still work. Render/cache rebuilding may take a moment.
- [ ] **T05 — Ordinary advanced-vendor trade.** Buy and sell known items; include a stackable consumable/ammo item and an item whose price depends on condition. Try an unaffordable purchase and an equipped-item sale. **Expected:** correct price, quantity, condition handling, money, stock and progression effects; rejected trades have no side effects. Stock is shared: a purchase by one character reduces the stock seen by another character.
- [ ] **T06 — Vendor trade modes and access.** Configure a vendor item as sell-only, buy-only, both and disabled in turn. Also test a character without vendor access. **Expected:** only the configured directions are available; disabled/unauthorized purchases fail; reopening the menu cannot bypass the restrictions. In particular, buy-only means the vendor buys from players and cannot sell that item to them.
- [ ] **T07 — Sherpa withdrawal.** With a Sherpa character, deposit a permitted item, withdraw it with no money, then try again with no stock. Use another character to check the same shared stock. **Expected:** the first withdrawal is free and consumes one unit; empty stock grants nothing; both characters see the same stock; dev’s existing access rules still apply.
- [ ] **T08 — Vendor editor.** Disable stock for an item, re-enable it with a maximum, change its price/mode and edit restocking. Close and reopen the editor. **Expected:** no error when disabling stock; stock appears in column 4 and restocking in column 5; the correct item changes and updates reach other open viewers.
- [ ] **T09 — Exhaustion and recovery.** Sprint on level ground to exhaustion, try jumping, wait until stamina recovers past 50, then sprint again. **Expected:** stamina drains on grounded sprinting; exhaustion limits you to current walk speed and keeps the existing jump restriction; breathing audio/HUD work; recovery restores the existing sprint capability without requiring an inventory update.
- [ ] **T10 — Weight and sprint modifiers.** Repeat exhaustion/recovery at normal weight, overweight and heavily overweight. Change weight while exhausted. If available, repeat with Lightning Sprint. **Expected:** overweight/heavy movement restrictions remain effective, exhaustion never increases speed, and recovery does not leave run speed permanently at walking speed. The existing Lightning Sprint removal on exhaustion still applies. Hunger/thirst continue to behave as before; their movement modifiers are currently commented out in COTZ.
- [ ] **T11 — Persistence after restart.** Record money, progression, ammo, equipment, bag/container contents, vendor settings and shared vendor stock. Make changes, allow/save normally, restart the server and reconnect. **Expected:** all recorded state matches the saved changes, no missing/duplicated items, no character reset, and saved shared stock/restocking settings are restored normally.

## UI, containers and equipment

- [ ] **T12 — Menu and Escape.** Open the COTZ menu, visit its tabs, scroll the tab list, and test the new “Escape returns to game” option both off and on. **Expected:** all tabs are reachable and retain their COTZ layout; with the option on, Escape closes the menu without leaving the pause screen open. Restore your preferred setting afterward.
- [ ] **T13 — Chat tabs and focus.** Create two tabs. Rename the active tab, right-click it again, rename an inactive tab, and attempt a duplicate name. Press Escape while typing. **Expected:** tab operations use the current names, the active tab stays selected after renaming, duplicate names are rejected, and Escape releases chat focus without trapping input.
- [ ] **T14 — Tooltips and previews.** Inspect both normal and minimal tooltips, custom item descriptions, character/model previews and attribute bars. Open/close these during character switching. **Expected:** readable tooltip backgrounds/text, normal attribute animation, custom names/descriptions intact, and no invalid-model/inventory errors.
- [ ] **T15 — Horizontal scrolling.** Open a panel with a horizontal scrollbar, if available, and drag it; also check vertical scrolling. **Expected:** both paint and scroll correctly without errors about missing scrollbar buttons. Mark not exercised if no accessible panel uses horizontal scrolling.
- [ ] **T16 — Locked containers.** Try wrong and correct passwords on an existing locked container; open an unlocked container normally. Restart with a saved container. **Expected:** wrong passwords deny access, the correct password works, restored models/names are correct, and COTZ money, categories and collision settings survive.
- [ ] **T17 — Two-player storage updates.** Where the storage system permits concurrent viewers, have two players view the same storage and change an item's data/quantity or remove it. **Expected:** both clients see the update/removal, without duplicate icons or a stale tooltip. If concurrent access is intentionally blocked, confirm that restriction and test by closing/reopening from the second player.
- [ ] **T18 — Suits, gear and weapon state.** Equip/unequip a model-changing suit, helmet/gear, backpack, normal weapon and miscellaneous weapon. Customize a suit skin. Test restriction/unrestriction using your normal supported gameplay/admin action. **Expected:** hands match the restored/current model, “Take Off”/“Put On” wording remains where customized, generic equip/unequip tips are correct, resistances/overlays/attachments remain correct, and restricted weapons regain their item links and loaded ammo.
- [ ] **T19 — Vendor collision and templates.** Spawn an advanced vendor through its normal template path, rotate it, change its model in the editor, and restart with it saved. **Expected:** interaction/collision bounds fit its model and orientation, it remains stationary, and templates/dialogue/stock still work.
- [ ] **T20 — Business toggle.** With an appropriate trader character, test Business with `allowBusiness` enabled and disabled in configuration. Also try a character lacking the trader flag. **Expected:** disabling Business blocks the tab/actions; enabling it preserves COTZ's flag and item restrictions. Restore the original configuration.

## Framework and admin checks

- [ ] **T21 — PAC, observer and weapon selection.** Equip/remove a PAC item, switch characters, enter observer with an authorized admin, and cycle weapons including a localized stock weapon. **Expected:** no leftover PAC parts, observer remains restricted as before, and selection names are readable rather than untranslated `#` keys.
- [ ] **T22 — Character restrictions.** On a disposable test character, exercise a temporary ban and its expiry, then any faction whitelist restriction. **Expected:** expiry removes only the temporary-ban barrier; a missing whitelist still blocks character use. Do not use a character you need for other tests.
- [ ] **T23 — Admin permissions and configuration.** Use your installed admin addon to exercise vendor editing, observer access and configuration editing, including an array-valued setting if one is available. **Expected:** authorized users retain access; ordinary users do not gain it; settings display/save normally. Restore altered settings.
- [ ] **T24 — Bundled framework features, if enabled.** Exercise normal Helix vendors, acts (enter/exit an animation), area editing, persistent props and map scenes. **Expected:** normal trades log correctly, acts return the player to their original position, and enabled features restore without errors. COTZ intentionally disables the stock stamina, strength, doors and recognition plugins; leave those disabled and mark their feature-specific tests not applicable.

## What to record if something fails

Record the test ID, exact actions, character/faction and relevant permissions, item ID/vendor name, expected versus actual result, server/client console error with its stack trace, and whether reconnecting/restarting changes the result. For inventory/vendor issues include before/after item counts, money and stock. These details help distinguish an upgrade regression from existing behavior or an addon integration issue.

## Automated checks run on the dev-based upgrade

Run from the addon root:

```bash
luatex --luaonly tests/helix_upgrade_spec.lua
luatex --luaonly tests/helix_vendor_trade_spec.lua
```

- `tests/helix_upgrade_spec.lua`: **36 passed** — inventory, nested bags, movement, vendor authorization, shared-stock reads and icon argument/material compatibility.
- `tests/helix_vendor_trade_spec.lua`: **20 passed** — executes the real dev-based purchase handler and stock methods with engine stand-ins. Covers shared shelves across two characters, stock depletion, vendor modes/access, unknown items, affordability, dev’s existing free Sherpa withdrawals, invalid sessions and successful trade hooks/saving.

The progression branch’s personal-stock tests and overhaul-specific suites are excluded because those systems are absent from this branch. Previous results for them do not validate this dev-based upgrade.

Changed Lua syntax is checked through lexical GLua adaptation followed by Lua compilation, plus `git diff --check`. This is not native GLua execution. No game server or database was started or modified during implementation. Run the in-game checks above before rollout.
