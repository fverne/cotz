# Helix upgrade proposal — 28 October 2026

Status: original proposal approved and implemented on the progression branch, then adapted to a dev-based upgrade at the user’s request. The proposal below is retained as the review record. See [implementation notes](helix-upgrade-notes.md) and the [test checklist](helix-upgrade-tests.md) for the final result.

## Comparison target and scope

- Upstream: [NebulousCloud/helix master](https://github.com/NebulousCloud/helix/commit/bb8bf86988b980d576419597ae6b966ee939e409), commit `bb8bf86988b980d576419597ae6b966ee939e409`, dated 27 October 2026.
- Installed framework: `gamemodes/helix`; schema: `gamemodes/ix_cotz`.
- All 200 upstream tracked files were compared against the installed framework: 88 existing files differ, 111 match byte for byte, and one file is new. The installed `helix.yml` is local configuration and must be preserved.
- A useful historical comparison point is upstream `dc986499a265595a874cefc78e9b691c3cc01c69` (17 September 2023). This is an inferred comparison baseline, not a claim that the installed framework is an exact checkout. Only 11 installed files differ from that snapshot; five differences are line endings only and six contain substantive changes.
- Reviewed same-name copies, renamed copies identified through content similarity, schema hooks, public API overrides, plugin load order, and affected inventory, vendor, movement, and icon call sites. Similarity is a discovery aid, not proof that all code in a file originated upstream.

## Proposed Helix changes

1. Update the framework to the pinned upstream commit, including core code, bundled plugins, translations, documentation, and tooling. Add Turkish. Keep the existing database configuration. No database migration is indicated by this diff; back up the database and saved Helix data before deployment.
2. Include upstream item and inventory fixes: validate missing instances/inventories, validate item use distance and use target, fix inventory move message arguments, repair removal of corrupt slot layouts, notify storage receivers of item data, fire the inventory removal hook, handle reserved inventory slots, and correct `GetShouldSave()`.
3. Include upstream character/player fixes: temporary bans continue through whitelist checks after expiry; safe character-list handling; faction-change notifications; attribute-specific maxima; bot model selection and saving; SteamID64 timer identifiers; restriction/restoration retains weapon item links and ammunition; interaction targets use `GetUseEntity()`; optional text-entry defaults.
4. Include upstream plugin and API changes: nested plugin context restoration; option defaults and phrase/description overrides; table netvar updates; SQL OFFSET; updated CAMI integration; logging fallback; color validation; server address lookup; safe empty player searches; lock/blocker access; player/entity iterator conversions.
5. Include upstream UI fixes: horizontal scrollbar support, scrollable menu tabs, Escape option, tooltip alpha clamping, attribute animation speed, model/subpanel validity checks, config array population, localized flag descriptions and weapon names, and area/door editor fixes.
6. Include bundled plugin fixes: chat tab renaming and pause-menu handling; container restore and password validation; vendor access, mode, stock, price, collision and hook fixes; movement-based exhaustion; PAC cleanup; door permission message validation; recognition validation; persistence guards; mapscene/spawn selection; 3D panel guard; restore player position when exiting acts.
7. Preserve item materials. `ITEM:GetMaterial()` is already overridden in COTZ; that schema override will remain authoritative, so the redundant base edit can be removed when refreshing Helix.
8. Preserve material-aware generated icons while restoring upstream argument compatibility. Keep upstream's `(name, w, h, model, camInfo, updateCache)` positions and add material as an optional trailing argument; update both COTZ callers. Retain the render entity material assignment/reset. This is a small documented framework compatibility patch because upstream's renderer has no material argument or equivalent hook.
9. Remove the older SteamID64 fallback detour in `shared.lua`, as upstream already removed it. Restore upstream English/German entries and vendor trade logging/zero-price handling rather than carrying older versions of those files forward. Normalize line-ending-only differences as part of the update.
10. Apply a documented inventory compatibility patch before rollout: make `Inventory:Iter()` yield each item once, while continuing to skip reserved boolean slots. Retain recursive `GetItems()` traversal in newly converted operations that previously included bag contents (item searches, loadout/save/equipment paths, and relevant storage/PAC/logging operations). This preserves existing COTZ bag behavior while accepting the actual bug fixes. Do not blindly replace every `GetItems()` loop in the schema.

### Why the inventory compatibility patch is necessary

The target upstream iterator walks every occupied grid cell without tracking seen item IDs. A 2×2 item can therefore be returned four times. It also traverses only that inventory's slots, whereas `GetItems()` includes bag inventories by default. Upstream changed searches, loadout/save callbacks, equipment checks and other operations to use this iterator. This is a source-level finding; the proposed patch still requires runtime verification with multi-slot items and nested bags.

### Existing local Helix differences and disposition

| File relative to `gamemodes/helix` | Finding and proposed treatment |
| --- | --- |
| `gamemode/shared.lua` | Older SteamID64 fallback remains locally; remove in favor of upstream. Accept salary timer changes. |
| `gamemode/core/meta/sh_item.lua` | Material getter customization; preserve behavior in the existing COTZ override. Accept upstream item fixes. |
| `gamemode/core/libs/thirdparty/cl_ikon.lua` | Custom material parameter shifts upstream arguments; retain material rendering with a backward-compatible trailing parameter. |
| `plugins/vendor/sh_plugin.lua` | Local copy lacks baseline trade logging and zero-price flags and has older save/hook placement. Restore upstream behavior. |
| `gamemode/languages/sh_english.lua` | Missing baseline `syntax` phrase; restore upstream and carry new keys into COTZ English. |
| `gamemode/languages/sh_german.lua` | Older translations; replace with upstream. |
| `gamemode/config/sh_config.lua`, `gamemode/core/derma/cl_character.lua`, `gamemode/core/libs/sh_currency.lua`, `gamemode/core/libs/cl_bar.lua`, `gamemode/core/libs/sh_chatbox.lua` | Differences from the historical baseline are line endings only. No bespoke logic to preserve. |

## Proposed COTZ changes

Paths below are relative to `gamemodes/ix_cotz`.

| Files | Planned change and behavior to preserve |
| --- | --- |
| `schema/libs/sh_item.lua` | Bring the copied registration function's `isBase` default into line with upstream (`isBaseItem or false`); preserve throw-away, drop, pickup and inheritance behavior. Keep scope limited rather than refactoring the whole registration system during this upgrade. |
| `entities/entities/ix_item.lua` | Port missing-item guards in duplication, damage and Think; return after removal. Preserve custom models, colors, materials and pickup logic. Account for the schema hook that disables damage. |
| `schema/cl_skin.lua` | Port horizontal scrollbar handling and button painters into the COTZ skin while keeping its styling. |
| `schema/derma/cl_menu.lua` | Use scrolling tabs and honor `escCloseMenu` while keeping the COTZ menu layout and controls. |
| `schema/derma/cl_tooltip.lua` | Apply alpha clamping to both tooltip panel types; preserve custom tooltip content. |
| `schema/derma/cl_attribute.lua` | Add configurable animation speed with the current speed as the default. |
| `schema/derma/cl_modelpanel.lua` | Guard invalid model entities before manipulating pose parameters; preserve animation/weapon preview rendering. This copied implementation has diverged substantially from upstream. |
| `schema/derma/cl_inventory.lua` | Guard missing character inventory before opening bags, preserve recursive bag behavior and custom item rendering, and update the generated-icon call to the compatible signature. |
| `schema/libs/sh_iconhelper.lua` | Update its generated-icon call to the compatible signature and retain custom materials/icon cameras. |
| `schema/cl_hooks.lua`, `schema/sh_hooks.lua` | Honor the new `allowBusiness` setting in schema hooks that can bypass base hooks; preserve trader flag checks and existing item restrictions. |
| `schema/languages/sh_english.lua` | Merge upstream new/fixed phrases, including flags, equip/unequip, door labels and the Escape option, while preserving COTZ terminology and custom phrases. |
| `plugins/chatbox/sh_plugin.lua`, `plugins/chatbox/derma/cl_chatbox.lua`, `plugins/chatbox/derma/cl_chatboxcustomize.lua` | Port rename ID tracking, active-tab rename handling, duplicate-name validation, and `OnPauseMenuShow`; remove the superseded per-frame Escape interception. Preserve COTZ chat customization. |
| `plugins/containers/sh_plugin.lua`, `plugins/containers/entities/entities/ix_container.lua` | Validate restored record/model types, set model before Spawn, guard nil models, and validate password request entity/class/lock state and character before dereferencing. Adapt to COTZ's simpler password handler; preserve money, categories, cyclical containers, collision settings and saved data format. |
| `plugins/vendor_adv/sh_plugin.lua`, `plugins/vendor_adv/entities/entities/ix_vendor_adv.lua` | Port rotated collision bounds/physics initialization in spawn, restore and model changes; guard unknown items in instance-aware pricing; supply vendor entity to `CanPlayerUseVendor`; fix the stockDisable string/table mismatch. Validate purchasing server-side with COTZ's progression, Sherpa, mode, pricing and stock rules intact. Preserve existing access checks already present in the trade handler. |
| `schema/items/base/sh_suit.lua` | Refresh hands after outfit model changes as appropriate on equip/unequip; merge applicable equip/unequip phrases and tips. Preserve suits, skins, attachments, durability and resistance logic. Retain recursive equipment checks. |
| `schema/items/base/sh_gear.lua`, `schema/items/base/sh_newbags.lua`, `schema/items/base/sh_newweapons.lua`, `schema/items/base/sh_miscweapons.lua` | Merge applicable equip/unequip phrase/tip fixes and review copied equipment/death cleanup loops against upstream. Preserve custom ammunition, weapon integrations, bag equipment, slot limits and recursive inventory behavior. |
| `plugins/stm/sh_plugin.lua` | Port grounded sprint drain and movement-based exhaustion limits. Preserve breathing audio, disabled attribute gains, jump restriction and HUD. Remove exhaustion's direct run-speed reset so it does not overwrite COTZ modifiers. Verify against `plugins/weight/sv_plugin.lua` and `plugins/survival_system.lua`; change those only if needed to preserve their existing restrictions. |
| `plugins/pac.lua` | Keep the PAC adjustment fix already present locally; bring applicable player iteration changes across while retaining recursive inventory traversal for equipped parts. |
| `plugins/observer.lua` | Apply the player iteration update, preserving custom observer display/access behavior. |
| `plugins/wepselect.lua` | Localize weapon print names before uppercasing; preserve custom selection behavior. |
| `schema/meta/sh_inventory.lua` | Add only the compatibility overrides needed for the inventory traversal decisions above; retain the custom item-count method. |

### Changes deliberately not copied blindly

- COTZ's advanced vendor stock column is **4**, and its restock column is **5**. Upstream's change from stock column 4 to 5 belongs to upstream's layout; applying it here would corrupt the restock display. Preserve COTZ's column indices.
- The advanced vendor already checks trade access. It also defines `CanSellToPlayer`, but the purchase handler does not call it. Integrate equivalent server validation without breaking Sherpa purchases or progression rules; the existing method does not encode all those exceptions.
- PAC's material/part adjustment on removal is already present in COTZ. Keep it without adding a duplicate implementation.
- Several copied panels have no new functional upstream changes: character, character loading/creation, settings, information, notices, scoreboard, death screen, menu buttons and storage. Preserve their COTZ versions. COTZ's `cl_charload.lua` overrides the upstream character-load panel despite its different filename.
- `entities/weapons/ix_hands.lua`, crosshair, prop protection, spawn saver and container definitions have COTZ differences but no corresponding new upstream changes in this comparison. Preserve them.
- `schema/meta/sh_item.lua` already supplies custom material/color/name/description getters. Retain these rather than replacing the file with the full framework metatable.
- `schema/libs/sh_fverneutils.lua` overrides `ix.util.GetMaterial`; upstream has no new change to that function in this comparison. Preserve the override.

## Verification and rollout proposed after review

1. Save an exact code revision/diff and back up database plus saved Helix data before running the upgraded server.
2. Check changed Lua/GLua syntax with available tooling; ordinary Lua parsers need adaptation for upstream GLua operators and `continue`. Check diff whitespace, signatures, load order and net message reader/writer pairs.
3. Exercise multi-slot items once per operation; nested bag search/loadout/save/PAC; item removal and corruption recovery; storage updates visible to multiple viewers; drop, pickup, throw-away and custom icons.
4. Exercise menu tabs, Escape/chat focus and tab renaming, horizontal scrolling, tooltips and missing model/inventory cases.
5. Exercise normal and advanced vendors, buying/selling modes, unknown items, stock disable/editing, progression restrictions, Sherpa stock, restocking, model changes and rotated collision bounds. Confirm normal logging and custom trade hooks.
6. Exercise stamina exhaustion/recovery, sprinting/jumping/swimming, weight limits and survival movement modifiers; equip/unequip suits, bags, gear and weapons; verify hands and ammunition after restriction/restoration.
7. Restart the server and verify saved character/inventory/container/vendor/PAC state. Confirm current Garry's Mod supports the upstream iterator APIs and that the installed admin addon works with the updated CAMI.

These are planned checks, not completed runtime tests. This review did not start a game/server or touch the database. Runtime validation requires the Garry's Mod environment and relevant addons/content.

## Complete framework file inventory

Every changed/new upstream path is listed below. Updating to upstream includes these files, subject to the explicitly described compatibility patches above. Paths are relative to `gamemodes/helix`.

- Update `.luacheckrc`.
- Update `README.md`.
- Update `docs/hooks/plugin.lua`.
- Update `entities/entities/ix_item.lua`.
- Update `gamemode/config/sh_config.lua`.
- Update `gamemode/config/sh_options.lua`.
- Update `gamemode/core/cl_skin.lua`.
- Update `gamemode/core/derma/cl_attribute.lua`.
- Update `gamemode/core/derma/cl_character.lua`.
- Update `gamemode/core/derma/cl_classes.lua`.
- Update `gamemode/core/derma/cl_config.lua`.
- Update `gamemode/core/derma/cl_help.lua`.
- Update `gamemode/core/derma/cl_inventory.lua`.
- Update `gamemode/core/derma/cl_menu.lua`.
- Update `gamemode/core/derma/cl_modelpanel.lua`.
- Update `gamemode/core/derma/cl_subpanel.lua`.
- Update `gamemode/core/derma/cl_tooltip.lua`.
- Update `gamemode/core/hooks/cl_hooks.lua`.
- Update `gamemode/core/hooks/sh_hooks.lua`.
- Update `gamemode/core/hooks/sv_hooks.lua`.
- Update `gamemode/core/libs/cl_bar.lua`.
- Update `gamemode/core/libs/sh_character.lua`.
- Update `gamemode/core/libs/sh_chatbox.lua`.
- Update `gamemode/core/libs/sh_class.lua`.
- Update `gamemode/core/libs/sh_currency.lua`.
- Update `gamemode/core/libs/sh_faction.lua`.
- Update `gamemode/core/libs/sh_flag.lua`.
- Update `gamemode/core/libs/sh_item.lua`.
- Update `gamemode/core/libs/sh_language.lua`.
- Update `gamemode/core/libs/sh_log.lua`.
- Update `gamemode/core/libs/sh_menu.lua`.
- Update `gamemode/core/libs/sh_option.lua`.
- Update `gamemode/core/libs/sh_plugin.lua`.
- Update `gamemode/core/libs/sh_storage.lua`.
- Update `gamemode/core/libs/sv_networking.lua`.
- Update `gamemode/core/libs/sv_player.lua`.
- Update `gamemode/core/libs/thirdparty/cl_ikon.lua`.
- Update `gamemode/core/libs/thirdparty/sh_cami.lua`.
- Update `gamemode/core/libs/thirdparty/sv_mysql.lua`.
- Update `gamemode/core/meta/sh_character.lua`.
- Update `gamemode/core/meta/sh_entity.lua`.
- Update `gamemode/core/meta/sh_inventory.lua`.
- Update `gamemode/core/meta/sh_item.lua`.
- Update `gamemode/core/meta/sh_player.lua`.
- Update `gamemode/core/sh_commands.lua`.
- Update `gamemode/core/sh_util.lua`.
- Update `gamemode/items/ammo/sh_crossbowammo.txt`.
- Update `gamemode/items/base/sh_bags.lua`.
- Update `gamemode/items/base/sh_outfit.lua`.
- Update `gamemode/items/base/sh_pacoutfit.lua`.
- Update `gamemode/items/base/sh_weapons.lua`.
- Update `gamemode/languages/sh_dutch.lua`.
- Update `gamemode/languages/sh_english.lua`.
- Update `gamemode/languages/sh_french.lua`.
- Update `gamemode/languages/sh_german.lua`.
- Update `gamemode/languages/sh_korean.lua`.
- Update `gamemode/languages/sh_norwegian.lua`.
- Update `gamemode/languages/sh_polish.lua`.
- Update `gamemode/languages/sh_portuguese.lua`.
- Update `gamemode/languages/sh_russian.lua`.
- Update `gamemode/languages/sh_spanish.lua`.
- Update `gamemode/shared.lua`.
- Update `plugins/3dpanel.lua`.
- Update `plugins/act/sh_plugin.lua`.
- Update `plugins/area/derma/cl_areaedit.lua`.
- Update `plugins/area/sh_plugin.lua`.
- Update `plugins/area/sv_hooks.lua`.
- Update `plugins/chatbox/derma/cl_chatbox.lua`.
- Update `plugins/chatbox/derma/cl_chatboxcustomize.lua`.
- Update `plugins/chatbox/sh_plugin.lua`.
- Update `plugins/containers/entities/entities/ix_container.lua`.
- Update `plugins/containers/sh_plugin.lua`.
- Update `plugins/doors/cl_plugin.lua`.
- Update `plugins/doors/derma/cl_door.lua`.
- Update `plugins/doors/sh_plugin.lua`.
- Update `plugins/doors/sv_plugin.lua`.
- Update `plugins/logging.lua`.
- Update `plugins/mapscene.lua`.
- Update `plugins/observer.lua`.
- Update `plugins/pac.lua`.
- Update `plugins/persistence.lua`.
- Update `plugins/recognition.lua`.
- Update `plugins/spawns.lua`.
- Update `plugins/stamina/sh_plugin.lua`.
- Update `plugins/typing.lua`.
- Update `plugins/vendor/entities/entities/ix_vendor.lua`.
- Update `plugins/vendor/sh_plugin.lua`.
- Update `plugins/wepselect.lua`.
- Add `gamemode/languages/sh_turkish.lua`.

Preserve local-only `helix.yml`. No installed framework files need deletion; `helix.yml` is simply absent from upstream.
