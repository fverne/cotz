# Progression engine

This plugin owns character progression storage, persistent item requirements, numeric counters,
prerequisite validation, purchase permissions, completion payouts, pending reward claims and services.
Town content is authored in [townnpcs](../townnpcs/README.md); superseded town definition files are removed.

## Content and ownership

- Town objectives, catalogue allocations, stock benefits and task text: townnpcs/definitions/sh_<contact>.lua.
- Shared requirement candidates: definitions/sh_requirementpools.lua.
- Standalone non-town contacts: definitions/sh_computer_story.lua, sh_computerprog.lua,
  sh_hoarderprog.lua, sh_noosphereprog.lua and sh_communityprog.lua. These are separate gameplay,
  not compatibility copies of town NPC progressions. Secret Hoarder spawning remains separate.
- Current town access prerequisites are compiled from contact.access. Storage, suit painting,
  broadcast and emission-warning consumers check current town milestone IDs directly.

libs/sh_storage.lua exposes character-owned snapshots. Server mutations commit through the setter;
clients only read replicated state. Requirements are assigned once by the server and remain stable
for current assignments. Hand-ins validate character, NPC, access, map, inventory and remaining units.
Whole-stack removal must succeed before progress/rewards are granted.

Completion cash uses 60% of consumed nominal value. Partial hand-ins do not pay early; rounding
credit accumulates for the whole completion. Fixed benefits use token-backed pending claims;
an inventory reservation is not acknowledgement of an asynchronous insert. Full inventories keep
rewards pending. Task descriptions call completion payouts rewards; stock rewards explicitly
describe purchase capacity. Hand-in replies give a short receipt and the remaining requirement or completion. Service credits, discounts and stock capacity remain separate from item gifts.

Only current registered definitions participate in task discovery and equipment gating. There is no
town migration, old-ID permission fallback, completion alias or grandfathered prerequisite handling.
Old database rows are not rewritten or erased by loading the plugin.

## Runtime and checks

PlayerLoadedCharacter initializes progression storage. Town state initializes through its owning
plugin hook. ProgressionAudit validates registered requirements, rewards and graph references;
ProgressionGrant marks a current milestone complete.
World-arrival support remains for explicit worldNPC definitions; Pripyat town arrivals are suppressed.

    luatex --luaonly tests/progression_spec.lua
    luatex --luaonly tests/townnpcs_spec.lua
    luatex --luaonly tests/progression_services_spec.lua
    luatex --luaonly tests/task_rewards_spec.lua

The engine suite retains snapshot isolation, authoritative hand-ins, failed removal, payout rounding,
partial-stack persistence, mixed requirement groups, overflow and asynchronous insertion/retry checks.
Town content is exercised by townnpcs_spec.lua. Multiplayer loading, networking, real inventory
callbacks, database interruption and map transfer still need runtime verification.
