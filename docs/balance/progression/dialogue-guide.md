# NPC dialogue sources

Conversation flavour (greetings, information, service responses and GOODBYE) lives in `gamemodes/ix_cotz/plugins/dialogue/dialogue/`:

| Contact | Conversation file |
| --- | --- |
| 'Cleaner' | [sh_owlnpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_owlnpc.lua) |
| 'Technut' | [sh_technpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_technpc.lua) |
| 'Old Timer' | [sh_tutorialnpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_tutorialnpc.lua) |
| 'Spicy Lemon' | [sh_cooknpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_cooknpc.lua) |
| 'Haggler' | [sh_tradernpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_tradernpc.lua) |
| 'Mute' | [sh_stalkernetadmin.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_stalkernetadmin.lua) |
| 'Egghead' | [sh_ecologistnpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_ecologistnpc.lua) |
| 'Beanstalk' | [sh_ecologistnpc2.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_ecologistnpc2.lua) |
| 'Intern' | [sh_ecologistnpc3.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_ecologistnpc3.lua) |
| 'Quartermaster' | [sh_unisgnpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_unisgnpc.lua) |
| 'Boss' | [sh_unisgnpc2.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_unisgnpc2.lua) |
| 'Smartass' | [sh_unisgnpc3.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_unisgnpc3.lua) |
| 'Hoarder' | [sh_raritynpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_raritynpc.lua) |
| 'Computer' | [sh_computernpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_computernpc.lua) |
| 'Jitters' | [sh_medicnpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_medicnpc.lua) |
| 'The Original' | [sh_firststalkernpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_firststalkernpc.lua) |
| '???' | [sh_cconnpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_cconnpc.lua) |
| 'Arena Master' | [sh_arenanpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_arenanpc.lua) |
| NPC | [sh_communitynpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_communitynpc.lua) |

Progression request and completion flavour has separate sources:

- `gamemodes/ix_cotz/plugins/progression/definitions/sh_*prog.lua`: each NPC’s original and added progression definitions, authored `briefing` / `BuildResponse` text and completion messages. Preparation stages sit before their original final milestone; optional branches follow the NPC’s main definitions.
- [sh_quarterprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_quarterprog.lua): Quartermaster’s weapon and field-equipment commissions.
- [sh_eggheadprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_eggheadprog.lua): Egghead’s science and equipment requests.
- [sh_definitions.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_definitions.lua): main-story requests, numeric checkpoint messages and story completion announcements.
- [libs/sh_expansion.lua](../../../gamemodes/ix_cotz/plugins/progression/libs/sh_expansion.lua): shared requirements, future-stage preview, claim options and reward-summary rendering. This adds saved character state to the authored briefings.
- [libs/sh_services.lua](../../../gamemodes/ix_cotz/plugins/progression/libs/sh_services.lua): service option labels, actual prices, credits and discount explanations.

Main-menu ordering and exit placement are enforced in [dialogue/libs/sh_dialogue.lua](../../../gamemodes/ix_cotz/plugins/dialogue/libs/sh_dialogue.lua) and the dialogue panel. The shared priority is trade/barter, services, work, progression, information, then GOODBYE. Back/exit options remain below dynamic choices. Static lists use the same order; templates and progression-locked contacts also keep GOODBYE last.

A model/template's display name and dialogue binding live in [vendor_adv/libs/sh_npctemplates.lua](../../../gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_npctemplates.lua). Changing an NPC's name affects saved vendor stock identity, so edit flavour in the dialogue/progression sources instead of renaming the template merely to change its voice.

Per-NPC progression files (main story and checkpoint definitions remain in `definitions/sh_definitions.lua`):

| Contact | Progression file |
| --- | --- |
| 'Boss' | [sh_bossprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_bossprog.lua) |
| 'Egghead' | [sh_eggheadprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_eggheadprog.lua) |
| 'Haggler' | [sh_hagglerprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_hagglerprog.lua) |
| 'Jitters' | [sh_jittersprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_jittersprog.lua) |
| 'Old Timer' | [sh_oldtimerprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_oldtimerprog.lua) |
| 'Quartermaster' | [sh_quarterprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_quarterprog.lua) |
| 'Spicy Lemon' | [sh_spicylemonprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_spicylemonprog.lua) |
| 'Technut' | [sh_technutprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_technutprog.lua) |
| 'Mute' | [sh_muteprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_muteprog.lua) |
| 'Computer' | [sh_computerprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_computerprog.lua) |
| 'Intern' | [sh_definitions.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_definitions.lua) |
| 'The Original' | [sh_originalprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_originalprog.lua) |
| 'Hoarder' | [sh_hoarderprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_hoarderprog.lua) |
| '???' | [sh_noosphereprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_noosphereprog.lua) |
| NPC | [sh_communityprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_communityprog.lua) |
| 'Cleaner' | [sh_cleanerprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_cleanerprog.lua) |
| 'Beanstalk' | [sh_beanstalkprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_beanstalkprog.lua) |
| 'Smartass' | [sh_smartassprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_smartassprog.lua) |
| 'Arena Master' | [sh_arenaprog.lua](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_arenaprog.lua) |
