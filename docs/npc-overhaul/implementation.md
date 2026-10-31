# Implementation handoff

[Design index](README.md). This is a future-work checklist, not a record of completed implementation.
Read repository instructions and the affected plugin's current documentation before coding.
Consult Helix documentation and the bundled API before changing framework integration.

## Existing ownership and proposed authoring layout

Paths below are relative to gamemodes/ix_cotz/plugins/ unless stated otherwise.
Keep content in its owning plugin. Per-contact definitions can span these systems; the requirement
is easy editing and clear ownership, not a new monolithic NPC framework.

| Content | Current source | Proposed approach |
| --- | --- | --- |
| Names, models, dialogue binding, catalogue | vendor_adv/libs/sh_npctemplates.lua | Preserve old identity fields exactly; make new contacts and seller allocations easy to find. Decide whether per-contact catalogue files justify a small explicit loader. |
| Ordinary conversation | dialogue/dialogue/sh_*.lua | One clear conversation definition per contact, including editable gossip and milestone reactions. |
| Finite progression | progression/definitions/sh_*prog.lua; main story and trackers also in sh_definitions.lua | Put each contact's authored steps, requirements, rewards, and text together. Shared machinery remains in libs/. |
| Repeatable work | jobsystem/definitions/ and dialogue possibleJobs offerings | Map the roster's one player-facing category to supported runtime IDs; do not offer unrelated categories at another difficulty. |
| Task supplies | jobsystem/libs/sh_taskrewards.lua and server implementation | Add/update contact profiles and validate catalogue eligibility. |
| Requirement candidates | progression/definitions/sh_requirementpools.lua | Use appropriate source-verified pools; preserve saved assignments. |
| Barters | npcbarter/sh_definitions.lua | Add revised exchanges with explicit inputs and outputs. |
| Placement | firsttimesetup/presets/ and progression world arrivals | Use one placement owner per NPC; avoid FTS/arrival duplication. |
| Map travel | simplecrossserver and map-specific setup | Integrate Garbage and revise travel gates intentionally. |

Current Old Timer conversation is sh_tutorialnpc.lua, with progression in sh_oldtimerprog.lua
and sh_definitions.lua. Existing filename/template IDs need not be renamed to match display names.
The [dialogue source guide](../balance/progression/dialogue-guide.md) maps the remaining old contacts.

Definition records should expose: stable step ID, title, prerequisites/successors, home/target map,
objective kind and parameters, briefing and completion text, concrete rewards, unlock announcements,
and conditional relationship reactions. Do not invent new runtime fields until their consumers exist.
Record how to edit and validate each content type in nearby runtime documentation when implemented.

The [individual contact designs](contacts/README.md) provide the authored starting outline for
every remaining town NPC. Their short labels are document references, not final persistent IDs.
Resolve all generic item slots and conditional upgrade prerequisites before registration; the
preliminary current-source item lists do not replace the complete unlock coverage ledger.

New progression/job/pool files need explicit includes where the current loaders require them.
Dialogue has its own directory loader and task-reward integration ordering. Preserve realms and the
loader behaviour documented in [repository layout](../repository-layout.md).

## Supported mechanics versus work still needed

| Proposed content | Current foundation | Remaining work |
| --- | --- | --- |
| Item hand-ins and checkpoint rewards | Persistent requirements, token-backed claims, service benefits. | Author valid items, pools, quantities, and rewards; map migrated state. |
| Job completion programmes | Existing listeners and numeric checkpoints. | Generalise only as necessary for all specialties, with exact contact/category attribution and duplicate protection. |
| Recovery, sensors, triangulation, dead drops, defended research | Existing jobsystem field assignments. | Author destinations and finite-story integration; repeatable support does not automatically register a finite objective. |
| Arena progression | Existing distinct-opponent milestones. | Rebalance chapter rewards; preserve anti-farming rules and optional status. |
| Fixed-location stories, notebooks, keepsakes, multi-objective investigations | Some field primitives are reusable. | Define actual completion events, cargo/state ownership, placements, and save/recovery behaviour. |
| Gossip and conditional greetings | Existing dialogue and personal progression queries. | Add editable topic definitions, ordering, and accurate conditions. |
| Visible town improvements or ferry travel | Narrative proposal only. | Separate mechanic and persistence design; not required just to author supply quests. |
| Garbage content | Upcoming map. | Verify actual map ID, routes, landmarks, spawns, sources, tiers, and safe NPC placements. |

The current field-job guide maps easy/medium/hard to Marsh/Waystation/Pripyat.
That is existing behaviour, not the new rule: difficulty and destination should be configurable
within specialty, and Garbage must be included deliberately. No Pripyat contact may be used as a
shortcut to reward claims or services.

## Unlock coverage and migration gate

Before replacing the graph:

1. Inventory all live definitions and consumers: purchase access, stock, services, fixed rewards,
   world arrivals, travel locks, and main-story endpoints.
2. Produce the complete old-to-new vendor-unlock ledger described in
   [progression and rewards](progression-and-rewards.md). Old Timer's example alone is insufficient.
3. Preserve old names/models and establish stable IDs for new contacts. Map/name changes affect stock keys.
4. Define how existing completions preserve earned purchase permissions, how partial hand-ins and
   assignments carry forward, and how pending fixed/job rewards stay claimable.
5. Map depleted personal stock to its new owner without refreshing shelves as a side effect of moving NPCs.
   Document how duplicate old routes merge and how caps are handled.
6. Map global NPC arrivals and personal access separately; remove obsolete Pripyat placements through an
   explicit world migration, not by rerunning first-time setup.
7. Keep Hoarder's periodic secret lifecycle separate. Exclusion from this roster does not delete him.
   ???, Computer, and community exclusion also does not authorize unrelated runtime deletion.
8. Version and make any migration repeat-safe. Review on representative saves before deployment.

Do not reset character progression, world unlocks, or stock to simplify validation. Existing completion
must not replay currency, fixed supplies, credits, or reward/restock events.

## Implementation order

1. Resolve map identity/access and complete unlock coverage before final reward placement.
2. Finalise the Old Timer slice for review: concrete destinations, sources, rewards, tracker thresholds,
   editable dialogue, and migration from his old graph.
3. Implement only the shared mechanics that slice demonstrably needs, keeping framework conventions.
4. Verify accept → travel → objective → return → reward → save/reconnect with real multiplayer clients.
5. Expand by contact and settlement, validating category uniqueness and dependency graphs each time.
6. Apply reviewed world/save migrations and update runtime guides to describe actual final behaviour.

Do not implement all 646 steps before validating a small complete expedition.

## Acceptance checks for the finished overhaul

- Exactly 27 planned town contacts: Marsh 10, Garbage 9, Waystation 8; zero NPCs in Pripyat.
- All existing names, models, and personalities preserved; new models available and mounted.
- One repeatable category per contact across every difficulty; unique category per home map.
- Roughly half of each finite line uses ordinary hand-ins/trackers, with arena reviewed separately.
- Every old progression vendor item unlock has a validated reachable replacement route.
- Direct upgrades require the previous tier's personal progression milestone, including across NPCs;
  parallel branches and alternate authored rewards cannot silently bypass that order.
- Basic survival/services accessible; no source, equipment, NPC-arrival, or travel dependency cycles.
- Dialogue definitions editable and findable; exits present; referrals and requirements accurate.
- Saved assignments, partial deliveries, earned permissions, depleted stock, and pending claims preserved.
- Character changes, disconnects, restarts, map transfer, full inventory, repeat requests, and repeated
  asynchronous callbacks cannot lose rewards or grant them twice.
- Secret Hoarder stays secret and periodic; no ordinary referral reveals him.

Relevant existing standalone specs include progression_spec.lua, task_rewards_spec.lua,
vendor_stock_spec.lua, progression_services_spec.lua, dialogue_order_spec.lua,
and field_tasks_spec.lua (verify current filenames before running).
Run applicable specs from the root with luatex --luaonly tests/<name>_spec.lua.
Balance checks use python -m unittest discover -s docs/balance/tests -v with the documented requirements.
Add meaningful tests for new persistence, objective completion, permissions, and migrations.
Mocks do not establish multiplayer correctness: realm/loading/networking/database changes need runtime checks.

## Open decisions to resolve while authoring

- Target completion effort and acceptable repetition per chapter, based on actual playtesting.
- Exact cumulative tracker baselines and thresholds, especially across parallel branches.
- Which NPCs exist immediately versus arrive globally, and which services require personal access.
- Cross-NPC referrals and reward dependencies without forcing every optional line into the main story.
- Concrete story sites, cargo items, evidence, and sources; compatibility with current loot and travel tiers.
- Which optional physical town changes justify implementing new mechanics.
