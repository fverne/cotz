# Advanced vendor definitions

## Trading interface

Town traders use the shared stock inspector with **Buy / Sell** tabs. The left pane lists catalogue
goods or eligible personal item instances; the right pane shows the selected item's icon, description,
price, stock information and Purchase/Sell action. Personal items retain instance-specific descriptions
and saved quantity/condition values where present. Icons and normal item tooltips are retained.
List and selected-item previews fit the complete icon inside their bounds with its aspect ratio preserved,
including wide and tall items in the shared Sherpa/squad vendor window.
Personal stock limits, fractional restock credit, progression gates and existing prices still apply.
NPCs have no earnings account in this interface. Personal bank access stays in dialogue.

Hold **Shift** and **right click** an item row to buy or sell that item immediately.
**Settings → Hotkeys → Quick trade modifier** offers Shift (default), Ctrl, Alt or Disabled;
either left or right modifier key works. The footer shows the active shortcut. Quick trades use
the existing request cooldown and server validation; depleted stock and editor previews cannot trade.
The same shortcut buys or donates instances in the shared Sherpa/squad window, skipping its confirmation.

Trades wait for stock broadcasts and inventory synchronization before changing rows; rejected requests
do not remove the selection. The vendor editor retains its read-only preview and existing update methods.
The window uses COTZ fonts/scaling and reflows its panes on narrow screens. Run
`luatex --luaonly tests/vendor_inspector_spec.lua` for inspector state, permissions and viewport bounds;
engine layout, tooltips, live resizing and multiplayer transactions still require in-game verification.

## Catalogue definitions

The [approved workbook plan](../../../../docs/npc-overhaul/vendor-plan.md) now owns the 25 planned
contacts' assortments. Vendors buy their hand-in candidates, catalogue goods and ordinary supplies.
Additional `buyItems` IDs and `buyCategories` category lookups are configured on town contacts;
Haggler buys ammunition/weapons and Spicy Lemon also buys all strong alcohol, raw meat and cooked meals.
Beanstalk, Egghead and Intern at the Eco Bunker buy all items in the `Artifacts` and `Mutant Parts`
categories, independently of progression unlocks.
Buying lists are separate from progression and courier requests. Buying-only goods use BUYONLY;
catalogue goods and supplies use SELLANDBUY, with catalogue purchases gated by seller-specific progression.
Before a purchase unlock, the trade menu retains the BUYONLY action.
Saved town vendor rows are reconciled to this plan on load, including trade modes and removed routes.
The server checks both sale and purchase eligibility. Existing personal stock history is not reset.
The Original retains ordinary work and supplies without a finite progression catalogue.

NPC traders have no cash balance or payout limit. Advanced vendors ignore legacy saved/template
balances, reject attempts to enable cash accounting and hide the cash controls in the editor.
Players still pay purchase prices and receive normal sale payouts. Item eligibility, ownership,
equipped-item restrictions and personal stock limits still apply. Sherpa/squad earnings accounts
remain managed by their own transaction system; they are separate from NPC cash limits.
Run `luatex --luaonly tests/helix_vendor_trade_spec.lua` for zero-balance sales and player payment checks.
Selling an unequipped duplicate weapon preserves the equipped instance's SWEP and PAC appearance.
Both weapon bases check equipped state and exact SWEP ownership when an item is removed.
Run `luatex --luaonly tests/weapon_removal_spec.lua` for the removal callbacks.

Personal `vendorStock` and `vendorRestockClaims` are separate persistent character vars with
`bNoNetworking = true`, including during initial synchronization. Each uses its own `MEDIUMTEXT`
SQL column. Vendor menus receive their current stock through the vendor networking rather than
the full history for every map and contact. This targets a fresh database; see
[character storage](../../../../docs/database/README.md).

The 12 new town contacts have editable appearance definitions and conversations. The
[town NPC plugin](../townnpcs/README.md) installs jobs, progression trees, catalogue gates,
and task dialogue for all 27 contacts while preserving existing identities and services.

## Place a new contact

After a server restart/changelevel with the updated files, join as an administrator and aim at
a clear patch of ground. Use the appropriate chat command below. All contacts are also available
in the advanced vendor editor's template dropdown: spawn **Vendor - Advanced** under **Helix**,
open its **Edit Vendor** property, select the contact, and click **Load**.

| Planned home | Contact | Chat command | Appearance definition |
| --- | --- | --- | --- |
| Swamps | Atlas | /spawnadvvendor atlasnpc | [sh_atlas.lua](definitions/sh_atlas.lua) |
| Swamps | Gasket | /spawnadvvendor gasketnpc | [sh_gasket.lua](definitions/sh_gasket.lua) |
| Swamps | Ballast | /spawnadvvendor ballastnpc | [sh_ballast.lua](definitions/sh_ballast.lua) |
| Garbage | Latch | /spawnadvvendor latchnpc | [sh_latch.lua](definitions/sh_latch.lua) |
| Garbage | Spoor | /spawnadvvendor spoornpc | [sh_spoor.lua](definitions/sh_spoor.lua) |
| Garbage | Brass | /spawnadvvendor brassnpc | [sh_brass.lua](definitions/sh_brass.lua) |
| Garbage | Wake | /spawnadvvendor wakenpc | [sh_wake.lua](definitions/sh_wake.lua) |
| Garbage | Vesper | /spawnadvvendor vespernpc | [sh_vesper.lua](definitions/sh_vesper.lua) |
| Waystation | Suture | /spawnadvvendor suturenpc | [sh_suture.lua](definitions/sh_suture.lua) |
| Waystation | Ledger | /spawnadvvendor ledgernpc | [sh_ledger.lua](definitions/sh_ledger.lua) |
| Waystation | Spool | /spawnadvvendor spoolnpc | [sh_spool.lua](definitions/sh_spool.lua) |
| Waystation | Carbon | /spawnadvvendor carbonnpc | [sh_carbon.lua](definitions/sh_carbon.lua) |

Prefer **/TownNPCPlace <slug>**, for example **/TownNPCPlace arena-master**, on the contact's
home map. It validates the map and duplicate identity, installs missing stock, and saves immediately.
Arena Master belongs on rp_marsh_cs; Garbage is rp_garbage_cotz. The generic commands above remain
available for manual editing and do not enforce home maps. Existing saved contacts need to be
moved manually. The overhaul does not guess positions or relocate vendors across servers.

Use fresh vendor entities for new contacts. Appearance defaults use replaceable Half-Life 2
human models, silent greetings, and automatic idle selection. Select your final mounted models,
skin, bodygroups, and animations in the definition or vendor editor. These are not final model choices.
The template's scale field is the vendor sale-price factor, not character/model size.

## Edit appearance and conversation

- Appearance, name, model, skin, idle animation, base stock and dialogue binding for every contact:
  definitions/sh_<contact>.lua in this plugin. Existing templates are split out of the old monolithic table.
- Editable introduction, specialty, advice, contacts, back, and goodbye text:
  ../dialogue/dialogue/sh_<contact>npc.lua.
- Example: [Atlas conversation](../dialogue/dialogue/sh_atlasnpc.lua).
- The matching template ID and dialogue ID are <contact>npc, for example atlasnpc.
  Keep these IDs and display names stable once placed; names participate in saved vendor identity.

Introductions, specialty explanations, advice, and contacts appear inside **Can I ask you something?**.
The root is reserved for actions and that submenu entry. The town plugin installs work/progression
and updates specialty text after dialogue registration. Edit job settings and progression text in
../townnpcs/definitions/sh_<contact>.lua; edit flavour in the conversation file.

Shared stock assembly lives in libs/sh_towncontacts.lua. The town plugin supplies contact configuration;
this plugin owns template updates and placed-vendor stock handling. Catalogue unlocks and reward/stock item lists
are authored beside each town contact's progression, rather than duplicated in vendor definitions.

Template definitions are explicitly included from libs/sh_npctemplates.lua on both realms using
ix.util.Include. Dialogue files are discovered by the existing dialogue directory loader.
Shared inclusion follows the [Helix ix.util guidance](https://docs.gethelix.co/libraries/ix.util/)
and the bundled loader.

## Saving placements and updating definitions

Advanced vendors use the existing vendor plugin's saved snapshot of model, transform, name,
dialogue ID, and other settings. The spawn command and template-load endpoint do not force an
immediate save. Confirm an editor change, such as a custom description, to trigger the existing
save path, or allow the normal server save cycle before checking persistence after restart.
Moving an entity also needs a subsequent save.

Saved vendors do not automatically reapply template files on load. Editing a template changes
future spawns or explicit template loads; update existing placed vendors through the editor as
needed. Dialogue text is loaded by dialogue ID when scripts load, so a matching saved binding
receives the updated conversation after restart.

For eventual deployment presets, capture final transforms and add reviewed vendor records through
the [map setup workflow](../../../../docs/map-setup.md). There is no need to run first-time setup
to place these contacts manually.

## Verification

The [mutant defense plugin](../mutantdefense/README.md) awards transferable vouchers redeemable through
vendor dialogue for 50% of the holder's personal maximum stock. The shared `ix.vendorStock.RestockFraction`
API preserves normal restock eligibility, progression bonuses, caps and fractional credit. Task restocks
continue to grant 20%; vendors with no eligible deficit keep the voucher. Sherpas/hideout vendors are excluded.
Run `luatex --luaonly tests/mutant_defense_spec.lua` alongside the stock checks below.

Relevant standalone checks from the repository root:

    luatex --luaonly tests/vendor_stock_spec.lua
    luatex --luaonly tests/town_vendor_buying_spec.lua
    luatex --luaonly tests/character_storage_spec.lua
    luatex --luaonly tests/character_sync_spec.lua
    luatex --luaonly tests/dialogue_order_spec.lua

These checks do not establish Garry's Mod runtime correctness. In a multiplayer development session,
check the template dropdown, spawn each contact, inspect its model/idle, open every conversation
branch, use Back and Goodbye, confirm ordinary players can talk, and save/restart to verify placement
and dialogue bindings. Check trading, the single job specialty, progression branches, services, and pending reward claims.

Runtime and design reference: [NPC overhaul](../../../../docs/npc-overhaul/README.md).

## Sherpa and squad vendors

[Sherpas](../sherpas/README.md) reuse this entity's appearance/animation behavior, **Edit Vendor**
property and trading panel. The editor now accepts an explicit idle sequence and resolves animation
group names to their installed numeric IDs. Sherpas trade real item instances through their own
server endpoint and share the hideout transaction journal, rather than using NPC catalogue counts,
progression rewards or restocking. Appearance-only controls are shown when editing a Sherpa.
Standalone `ix_sherpa_vendor` placements share this plugin's save/load path; transient
`ix_hideout_vendor` entities remain exclusively owned by hideout saves.
