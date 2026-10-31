# Advanced vendor definitions

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
| Marsh | Atlas | /spawnadvvendor atlasnpc | [sh_atlas.lua](definitions/sh_atlas.lua) |
| Marsh | Gasket | /spawnadvvendor gasketnpc | [sh_gasket.lua](definitions/sh_gasket.lua) |
| Marsh | Ballast | /spawnadvvendor ballastnpc | [sh_ballast.lua](definitions/sh_ballast.lua) |
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
Arena Master belongs on rp_marsh_cs; Garbage is mz_garbage. The generic commands above remain
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
this plugin owns template updates and placed-vendor stock handling. Catalogue unlocks and supply lists
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

Relevant standalone checks from the repository root:

    luatex --luaonly tests/vendor_stock_spec.lua
    luatex --luaonly tests/dialogue_order_spec.lua

These checks do not establish Garry's Mod runtime correctness. In a multiplayer development session,
check the template dropdown, spawn each contact, inspect its model/idle, open every conversation
branch, use Back and Goodbye, confirm ordinary players can talk, and save/restart to verify placement
and dialogue bindings. Check trading, the single job specialty, progression branches, services, and pending reward claims.

Runtime and design reference: [NPC overhaul](../../../../docs/npc-overhaul/README.md).
