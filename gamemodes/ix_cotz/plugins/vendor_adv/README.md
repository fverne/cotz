# Advanced vendor NPC scaffolds

The 11 new town NPCs have appearance definitions and basic conversations. They can be placed
manually with the existing advanced vendor tools. No progression, repeatable jobs, trade stock,
barters, or service rewards have been added. Existing NPC definitions remain unchanged.

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

The planned home is guidance for placement, not an enforced map restriction. Garbage's map ID
and positions are not assigned. No contacts are automatically spawned or moved, and no map
presets are changed.

Use fresh vendor entities for these scaffolds. Appearance defaults use replaceable Half-Life 2
human models, silent greetings, and automatic idle selection. Select your final mounted models,
skin, bodygroups, and animations in the definition or vendor editor. These are not final model choices.
The template's scale field is the vendor sale-price factor, not character/model size.

## Edit appearance and conversation

- Appearance, name, model, skin, idle animation, and dialogue binding:
  definitions/sh_<contact>.lua in this plugin.
- Editable introduction, specialty, advice, contacts, back, and goodbye text:
  ../dialogue/dialogue/sh_<contact>npc.lua.
- Example: [Atlas conversation](../dialogue/dialogue/sh_atlasnpc.lua).
- The matching template ID and dialogue ID are <contact>npc, for example atlasnpc.
  Keep these IDs and display names stable once placed; names participate in saved vendor identity.

Each conversation explains the contact's specialty but explicitly has no assignment ready.
Introductions, specialty explanations, advice, and contacts appear inside **Can I ask you something?**,
grouped by the shared dialogue loader. The root is reserved for actions and that submenu entry.
SpecialtyTopic is informational, deliberately separate from the existing AboutWorkTopic job/reward
integration. No job categories, progression registrations, or new network handlers are installed.

Template definitions are explicitly included from libs/sh_npctemplates.lua on both realms using
ix.util.Include. Dialogue files are discovered by the existing dialogue directory loader. There is
no new loader or plugin. Shared inclusion follows the
[Helix ix.util guidance](https://docs.gethelix.co/libraries/ix.util/) and the bundled loader.

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
and dialogue bindings. Check that no work, trade, or progression offer appears for a fresh character.

Full future design: [NPC overhaul](../../../../docs/npc-overhaul/README.md).
