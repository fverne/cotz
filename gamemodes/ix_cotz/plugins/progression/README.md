# Progression engine

This plugin owns character progression storage, persistent item requirements, numeric counters,
prerequisite validation, purchase permissions, completion payouts, pending reward claims and services.
Town content is authored in [townnpcs](../townnpcs/README.md); superseded town definition files are removed.

## Content and ownership

- Town objectives, catalogue allocations, stock benefits and task text: townnpcs/definitions/sh_<contact>.lua.
- All shared and town requirement candidates: definitions/sh_requirementpools.lua.
  Town contacts read this registry directly; there is no separate town pool installation.
  The 46 `valuables_*` authoring pools cover 296 non-quest valuables and await acquisition playtesting.
  Another 72 `town_delivery_*` pools split contact themes and starting regions into four FTS availability bands.
  See [delivery balance](../../../../docs/npc-overhaul/delivery-balance.md) for generation and tuning.
- Standalone non-town contacts: definitions/sh_computer_story.lua, sh_computerprog.lua,
  sh_hoarderprog.lua, sh_noosphereprog.lua and sh_communityprog.lua. These are separate gameplay,
  not compatibility copies of town NPC progressions. Secret Hoarder spawning remains separate.
- Current town access prerequisites are compiled from contact.access. Storage, suit painting,
  broadcast and emission-warning consumers check current town milestone IDs directly.

Shared supply pools allow limited thematic overlap at comparable live loot weights. Fasteners now
include nails and screws; batteries include D-cells; cleaning accepts ordinary household stock;
statues include the raven; field/engine maintenance gain suitable lubricant alternatives; town
textiles include rope, sewing supplies and tarpaulin. Paracord remains in field repair and textiles
but is excluded from electrical repairs. Electrical pools share wiring where appropriate.
Evidence on each changed pool records current regional weights and relevant stack differences.
Screws, D-cells and small lubricant aerosols retain their existing later-region acquisition routes;
these alternatives are not promises of equal availability on every map. Tool tiers and story inputs
remain distinct. Pool IDs, quantities and saved progression selections are preserved.

libs/sh_storage.lua exposes character-owned snapshots. Server mutations commit through the setter;
clients only read replicated state. Requirements are assigned once by the server and remain stable
for current assignments. Hand-ins validate character, NPC, access, map, inventory and remaining units.
Whole-stack removal must succeed before progress/rewards are granted.

Non-town completion cash uses 60% of consumed nominal value. Town milestones instead declare
completionCash explicitly; trackers and arena checkpoints pay zero additional cash. Partial hand-ins
do not pay early. Existing accrued credit is preserved as a minimum completion payment. Town
completion does not trigger ordinary task restocking. Fixed benefits use token-backed pending claims;
an inventory reservation is not acknowledgement of an asynchronous insert. Full inventories keep
rewards pending. Task descriptions separate the title, briefing, required-item list and rewards with blank lines.
The encyclopedia displays each task title once; required-item lists use a stable order.
Task descriptions call completion payouts rewards; stock rewards explicitly
describe purchase capacity. Hand-in replies give a short receipt and the remaining requirement or completion. Service credits, discounts and stock capacity remain separate from item gifts.

Only current registered definitions participate in task discovery and equipment gating. There is no
town migration, old-ID permission fallback, completion alias or grandfathered prerequisite handling.
Old database rows are not rewritten or erased by loading the plugin.

Completion speech prefixes the authored reply with the completing character's current name for
both town and standalone contacts. Nearby listeners can identify who the NPC is addressing.

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
