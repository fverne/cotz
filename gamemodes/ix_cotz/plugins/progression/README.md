# Progression engine

The [town progression overhaul](../../../../docs/npc-overhaul/progression-overhaul.md) uses 25 finite
contacts, 52 branches and 631 hand-in milestones (including 212 stock intermissions). Town compilation scales new quantities
by the contact's effort multiplier. Fresh `v3/` IDs do not inherit old completion permissions; old
requests and contributions remain saved history. Inventory, money and paid hideout assets are retained.
Ballast's bank service is retired with its data preserved. Suture provides paid suit conversions;
Technut retains painting. Mute's existing STALKERnet features have explicit service gates.
Technut's initial anorak stock step and eleven intermediate stock-preparation steps are retired.
Anoraks remain starting stock; the Mail Jacket starts suit progression and each later suit follows its
preceding suit directly. Retired records stay saved history;
retained suit IDs, request quantities, partial contributions and completed purchases are preserved.
The town service labels are included in benefit summaries; optional `plannedUnlocks` remain inactive.

Paid repairs at Technut and Boss use `2 * round(missingCondition * price^(1/3))` for suits,
masks, helmets and repairable weapons. Weapons read `wear`; suits and headgear read `durability`.
The cloth mask alone sets `repairCostMultiplier = 1 / 3`, reducing its per-condition repair rate
before rounding. Other masks and helmets keep the standard rate.
Earned discounts apply after this base calculation. At 0% condition, a cloth mask costs 666 RU
and a standard anorak costs 3,768 RU before discounts. Legacy `repairCost` item fields do not
control these fees; each repairable base supplies its rate through `GetRepairCost()`.

Progression is a top-level menu tab beside Tasks, using contact cards and the shared
[COTZ typography and palette](../../../../docs/ui-style.md). The list begins empty for each character.
Opening a contact's progression conversation records its currently active topics in the character
data key `knownProgressionTopics`; newly unlocked topics require another conversation before they
appear. Discovery survives reconnects and does not change progression eligibility or saved progress.
Purple inventory backgrounds and Progression tooltip labels use the same discovery rules: only
outstanding items for active, discussed topics are highlighted. Inventory tooltips list each requesting
contact beside Task or Progression, with repeated contacts shown once per type. Courier tasks list
their eligible delivery recipients. Ordinary task highlighting is unchanged.
The tab uses a fill-docked scrolling list with one card per contact. Within each card, spaced
dividers separate the heading and earned benefits from each progression section. Long task
requirements and rewards wrap inside the card. A search bar stays above the list and filters contact
cards as you type, matching names, visible requests, required items and rewards without regard to case.
Clearing the search restores all discovered cards; undiscovered topics remain hidden.

Town requests use each contact's explicit core/support specialty pools rather than a global theme
rotation. Swamps branches' first two original milestones and all work below 45% use only Swamps-sourced
candidates. Policy 4 replaces remaining later-region demands in those openings without discarding
fulfilled contributions. Valid saved requests stay fixed; new requests receive the revised specialties.

Saved category labels also display Swamps in place of the previous region name without rewriting
accepted choices, quantities or contributions.

This plugin owns character progression storage, persistent item requirements, numeric counters,
prerequisite validation, purchase permissions, completion payouts, pending reward claims and services.
Town content is authored in [townnpcs](../townnpcs/README.md); superseded town definition files are removed.
Town purchases now use seller-specific gates for all catalogue items, including ammunition. Explicit
canonical equipment owners supply tier prerequisites. Authoring-only `plannedUnlocks` are deliberately
not copied into compiled reward definitions, so TODO entries cannot issue claims or grant permissions.

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

Requirement slots optionally declare `mode = "any"` or `mode = "random"`. Omitted mode retains
legacy behaviour. Any-mode selections snapshot a category's accepted items and one canonical counter;
random-mode selections snapshot the chosen item. `GetRequirementKey` and `GetRequirementChoices` accept
the owning character as their third argument to resolve saved choices. Task labels, inventory highlights,
dialogue actions and server consumption use these same helpers.
All town slots declare a mode. Their first 20% of actual connected-chain unlocks, rounded up, are category-only;
stock intermissions remain category-wide. Other later requests use a specific final slot and category
slots before it. Town `categoryChoiceRange` selects 3–4 types per character and saves disjoint accepted
subsets, even when catalogue pools overlap. New category totals have a matching 3–4 batch minimum.
`GetRequirementUnitSize` reads saved raw-unit costs: three nuts or four bolts contribute one batch.
Nuts and bolts must appear together in category subsets. New specific requests scale their raw target
by the batch minimum once. Inventory surplus and actual consumed-item valuation are preserved.
Mode version 2 retains old specific targets and credited progress, raises outstanding category totals
below three and replaces full-category lists once. Fulfilled categories and completed milestones stay
fulfilled. Subsequent definition edits do not reroll subsets or batch costs.
Haggler's opening shop-supply requests use mode version 3 to refresh unfinished categories once with
regular Swamps loot, retaining their counters, delivered units and earned credit. Completed requests
stay completed; later requests retain mode version 2.
See the [town policy](../../../../docs/npc-overhaul/progression-overhaul.md#category-totals-and-specific-requests).
Run `luatex --luaonly tests/progression_subsets_spec.lua` for per-character subsets and batch consumption.
Run `luatex --luaonly tests/town_requirement_modes_spec.lua` for all compiled town boundaries.
Run `luatex --luaonly tests/progression_requirement_modes_spec.lua` for mixed delivery, snapshot,
legacy conversion, isolation, failed-removal and duplicate-payment coverage.

libs/sh_storage.lua exposes character-owned snapshots. Server mutations commit through the setter;
clients only read replicated state. Requirements are assigned once by the server. Policy 4 converts outstanding ineligible/out-of-region
town inputs once while preserving fulfilled contributions and eligible saved requests. Hand-ins validate
character, NPC, access, map, inventory and remaining units.
Whole-stack removal must succeed before progress/rewards are granted.

Progression persists in its own owner-local `progression` character var and `MEDIUMTEXT` SQL column,
outside generic character data. This targets a fresh database; see [character storage](../../../../docs/database/README.md).
Initial owner snapshots and progression updates use the schema's compressed character transport,
split into reliable chunks below the net message limit. The setter retains its server-side
`CharacterVarChanged` callback and owner-only replication. This networking fix preserves existing saves.

All finite progression pays only accumulated hand-in value at the existing 60% rate, rounded up once
on completion. Town hand-ins now accrue monetary credit too; flat completion cash is removed.
Partial hand-ins pay nothing. Existing recorded cash/reputation credit remains intact. Town
completion does not trigger ordinary task restocking. Progression does not award item gifts at
completion or checkpoints. Definitions containing gift items fail validation, and the runtime benefit
handler only grants service credits. Old progression gift queues and saved `progression:` offers are
retained as inactive history: they cannot be queued, selected, claimed or shown as reward actions.
Already received inventory items are not removed. Repeatable job supplies still use the separate
`taskRewardClaims` queue, including asynchronous insertion acknowledgement and full-inventory recovery. Task descriptions separate the title, briefing, required-item list and rewards with blank lines.
The encyclopedia displays each task title once; required-item lists use a stable order.
Task descriptions place purchase access, stock capacity and all other benefits under Rewards,
after the required items. Journal copy uses region names and addresses the player directly.
All scoreboard tools, dossier fields and remote roster data are available immediately. Mute's progression
instead grants map-specific mutant spawn PDA reports. Town dialogue uses the full task description, including
assigned required items and remaining quantities. A definition's `requirementAlternatives` maps an accepted
alternative item to its canonical requirement; both choices share one saved contribution and completion. Hand-in replies give a short receipt and the remaining requirement or completion. Service credits, discounts and stock capacity remain functional progression rewards. Stock upgrades also add the capacity increase to current personal stock once, when that stock is next refreshed or read.

Only current registered definitions participate in task discovery and equipment gating. There is no
old-ID permission import or completion alias. The explicit policy-4 request conversion and activation
of inserted intermissions preserve existing completions; unfinished unlocks require the new stages.

Town completion messages use the authored reply verbatim, including Mute's nonverbal presentation.
Standalone contacts retain the completing character's current name as a prefix. All 631 active town
briefings and completions live in their owning contact definitions; the shared engine contains no
individual contact prose. Run `luatex --luaonly tests/progression_dialogue_spec.lua` for coverage and
`luatex --luaonly tests/progression_spec.lua` for both notification paths.

Technut and Jitters accept provider-bound repeatable-job credits for repair and treatment respectively.
Their contact reward profiles opt into credit use; other town contacts retain disabled credit balances.
The existing service quotes and confirmations spend credit before charging cash. Balance caps remain
20,000 repair / 5,000 treatment credits; jobsystem retains excess reward value as a recoverable offer.
No new finite-progression credit rewards are introduced.

## Runtime and checks

PlayerLoadedCharacter initializes progression storage. Town state initializes through its owning
plugin hook. ProgressionAudit validates registered requirements, rewards and graph references;
ProgressionGrant marks a current milestone complete.
World-arrival support remains for explicit worldNPC definitions; Pripyat town arrivals are suppressed.

    luatex --luaonly tests/progression_expansion_spec.lua
    python3 tests/progression_expansion_spec.py
    luatex --luaonly tests/progression_spec.lua
    luatex --luaonly tests/item_requirement_tooltips_spec.lua
    luatex --luaonly tests/character_storage_spec.lua
    luatex --luaonly tests/character_sync_spec.lua
    luatex --luaonly tests/character_network_spec.lua
    luatex --luaonly tests/townnpcs_spec.lua
    luatex --luaonly tests/progression_services_spec.lua
    luatex --luaonly tests/task_rewards_spec.lua

The engine suite retains snapshot isolation, authoritative hand-ins, failed removal, payout rounding,
partial-stack persistence, mixed requirement groups, overflow and asynchronous insertion/retry checks.
Town content is exercised by townnpcs_spec.lua. Multiplayer loading, networking, real inventory
callbacks, database interruption and map transfer still need runtime verification.
