# Job System

## Revised repeatable jobs, 6 November 2026

The [current roster and implementation guide](../../../../docs/npc-overhaul/repeatable-jobs.md)
supersedes the older town repeatable delivery/tier descriptions below. New work uses regional targets,
alternate receivers, cross-map dead drops, information couriers and Atlas's alternating photography.
Reference cash is 1,000/2,000/3,000; reputation is 15/25/35. Current reward packages and bonuses remain.
Accepted old assignments retain completion-only definitions and their original reputation terms.
Finite progression is unchanged and its rework is deferred, including stalled inactive-issuer checkpoints.

`definitions/sh_regionalcatalogue.lua` is static generated source data. `libs/sh_regionaljobs.lua`
owns shared eligibility/identity helpers; `sv_regionaljobs.lua` owns authoritative progress and bound
camera/courier issuance. Per-assignment field settings, both route maps and cargo variants are saved.
Run `luatex --luaonly tests/regional_jobs_spec.lua` alongside the suites below.
No server deployment, first-time setup or live-save reset is part of offline verification.

## Editing definitions

Field-work menus and temporary world labels use the shared
[COTZ UI style](../../../../docs/ui-style.md). Assignment labels have a dark backing and amber border
and stay within the viewport; marker duration, positions and server actions are unchanged.

Restart after editing shared definitions. Job IDs, category IDs, cargo item IDs, network names and
saved character keys remain stable. Existing accepted field jobs keep their saved destinations,
recording parameters, selected rewards and defence wave rolls; definition edits tune new assignments.
No save reset or first-time setup is required.

For deliveries addressed to a town contact, the PDA and hand-in checks resolve that contact's current
home map. This keeps accepted commissions usable when the workbook plan moves the scientists to
the Marsh Eco Bunker. Saved search sites, cargo identity, claim serials and delivery progress are retained.
The town progression multiplier changes required commission trips and cumulative checkpoints, not the
ordinary repeatable job's quantities or combat settings.

| Change | Edit |
| --- | --- |
| Point providers/pools, sources per job, search radius, sensor timing, reading spacing, routes, defence waves/health/duration | `definitions/sh_fieldsettings.lua` |
| Generic field-job names/descriptions, categories, difficulty maps, reference money and reputation | `definitions/sh_fieldjobs.lua` |
| Reward cash rates, supply budgets/limits, bonus interval, reputation gates and fallback contact profiles | `definitions/sh_rewardsettings.lua` |
| NPC offer lifetime/count, request distance/rate, kill-credit radius and default abandon cooldown | `definitions/sh_settings.lua` |
| NPC classes/patterns and species/group kill triggers | `definitions/sh_killcredit.lua` |
| Item hand-ins and kill-job counts, categories, reputation and reward budgets | Existing `definitions/sh_itemjobs_*.lua` and `sh_killjobs_*.lua` |
| Legacy survey/package tool item, initial tool data, completion keys and rewards | `definitions/sh_specialjobs.lua` |
| Cargo model, inventory size and weight | `items/jobcargo/sh_job_*.lua` |
| Town contact job specialty, maps, payouts, vendor supplies, reward packages and finite objectives | `townnpcs/definitions/sh_<contact>.lua` |

Ordinary definitions call `ix.jobs.register({...}, "stable-id")` directly. Legacy tool jobs call
`ix.jobs.RegisterToolJob`; their item configuration is data and their shared callbacks live in
`libs/sh_tooljobs.lua`. Reward profiles here are fallbacks and kit-redemption catalogues. Town contacts
install dedicated `rewards` definitions separately from their ordinary vendor `supplies`.
`moneyReward` is reference cash processed by reward calculations,
not necessarily the final preview payment. Preserve field names and units when tuning.

Existing map points are the default: recovery uses stash/event points, sensors anomaly/radiation
points, triangulation event/stash points, dead drops stash pickup and stash/event destinations, and
research defence event points. Optional authored town points are added to these sources. No manual
point placement is needed when existing providers contain suitable points for the destination map.

Town easy item-return definitions set `requiredPool` in addition to their existing `requiredItem`
reference. Server hand-ins accept any candidate from that progression pool, count its actual units,
and value the submitted item. Different candidates can contribute to the same job. The original
item still anchors the quantity/payment floor and stable ID. Medium/hard requests omit `requiredPool`
and require their specific item. Pool labels appear in easy job titles and descriptions.

Item hand-ins count saved `quantity` units, using the item's `quantity` or `ammoAmount` as
its default capacity and one for individual items. Ammunition counts by rounds. Only the remaining
requested units are consumed; surplus stays in the stack. Payment uses the consumed units' value,
and failed whole-item removal grants no progress. Progression hand-ins follow the same unit convention.

## Per-assignment cargo identity

Job cargo supports server-side instance overrides through Helix item data:

```lua
item:SetData("fieldName", "Generator service recorder")
item:SetData("fieldDescription", "A battered recorder with maintenance dates pencilled on its casing.")
```

`GetName()` and `GetDescription()` read these keys with `GetData`, falling back to the concrete
item's name and description. Clear either key with `SetData(key, nil)` to restore that fallback.
Delivery/return instructions remain appended, including dead-drop parcels' PDA instructions.
Inventory descriptions also append the concrete item's `longdesc` between the saved description and
those instructions. World descriptions omit that extra prose. Saved overrides are not rewritten.
Helix saves and synchronizes these overrides through its existing item data API.

Town commissions may set `field.description` beside `field.cargo` and `field.label`.
Registration maps it to `fieldCargoDescription`; acceptance snapshots it as `fieldTask.cargoDescription`,
and recovery copies it to the item's `fieldDescription`. Existing assignments without this optional
value keep the concrete item description. Definition edits affect new assignments; accepted descriptions
remain saved for recovery or replacement cargo. Models, dimensions and weight stay on the concrete item.

## Runtime ownership and loading

Helix loads `libs/sh_00_definitions.lua` before the other libraries. It explicitly includes configuration
using full gamemode paths so definitions are available to the shared field and reward libraries.
`sh_plugin.lua` registers character storage, loads job definitions and explicitly includes realm files.
The dialogue plugin still loads `integrations/sh_dialogue.lua` early to register reward topics.

- `libs/sh_jobs.lua`: registry, category/tier selection and shared formatting.
- `sv_jobs.lua`: character acceptance, progress, completion and abandonment.
- `sv_npcjobs.lua`: persistent NPC offer lists, legacy network requests and the admin reset command.
- `sv_listeners.lua`: server kill/chat triggers using the editable kill-credit rules.
- `libs/sh_fieldtasks.lua`: shared point collection, route selection and field validation.
- `sv_fieldplacement.lua` and `sv_fieldassignment.lua`: placement hulls and saved assignment creation.
- `sv_fieldactions.lua`: PDA requests, readings, deployment, delivery and status markers.
  Town commissions can override cargo/labels and nominate a receiving NPC. Accepted assignments
  snapshot those values and their description; recipient hand-ins consume cargo before recording
  delivery, then the player returns to the issuer for progression completion. See the
  [commission inventory](../../../../docs/npc-overhaul/quest-commissions.md).
- `sv_fieldtasks.lua`: live cargo, asynchronous pickup, periodic updates and cleanup.
- `sv_fielddefence.lua`: research encounters, owned attackers and wave progression.
- `sv_cargo.lua`: item transfer and world-object protection hooks.
- `libs/sh_taskrewards.lua` and `libs/sv_taskrewards.lua`: reward calculations, saved offers and claims.
- `cl_plugin.lua` and `cl_fieldtasks.lua`: Tasks menu and field markers.

Public legacy job/player API names remain available for existing dialogue and item callers. The
`ix_JobTrigger` callback retains its original `hook.Add` dispatch stage; it is server-only and is not
also registered as a plugin method. The existing reward-claim continuation hook retains its stage too.
NPC offer requests validate character, contact identity, access, distance and server rate limits. The
legacy Computer menu may still send categories/count, but these are taken from `settings.legacyOffers`
on the server. Other contacts use the current authoritative task-preview flow.

## Regression checks

From the addon root:

```sh
luatex --luaonly tests/jobsystem_spec.lua
luatex --luaonly tests/jobs_loading_spec.lua
luatex --luaonly tests/field_tasks_spec.lua
luatex --luaonly tests/task_rewards_spec.lua
luatex --luaonly tests/jobs_menu_spec.lua
luatex --luaonly tests/townnpcs_spec.lua
```

Standalone mocks do not establish GMod runtime correctness. In multiplayer, verify acceptance,
pickup, abandon/reaccept, full inventory, rewards, reconnect/map travel and server restart, plus
representative defence sites and legacy Computer/tool jobs. Do not reset saved data for these checks.

The [town NPC extension](../townnpcs/README.md) generates per-contact work categories
and finite field commissions from editable definitions. Server acceptance verifies contact ownership,
reputation and active progression. Finite commissions pay only their progression reward and do not
advance repeatable-job counters, reward bonuses or restock events. Only current town job definitions are used; there is no town preview or assignment migration.

The main menu's **Tasks** tab contains the current task list, including descriptions, selected rewards, progress, Abandon and
Field work actions. The scrollable cards use the equipment menu palette, borders and scaled typography,
and refresh when accepted tasks change. Tasks have their own page alongside Help and You, including when
there are no active jobs. The You tab contains the backpack and equipment.

## Task rewards and existing kits

Jobsystem owns repeatable job rewards, previews, acceptance, item delivery
and automatic supply-claim continuation. Its post-data-load hook validates task rewards. The `ix.taskRewards` API and saved character
keys remain unchanged. Progression owns story milestones and their completion payouts.
Jobsystem uses progression's NPC access checks, purchase unlocks and token-backed reward-claim service.

`libs/sh_taskrewards.lua` defines contact profiles, nominal-value budgeting and visible
packages. `libs/sv_taskrewards.lua` persists offers and transfers selected rewards into
the existing token-backed claim queue. `integrations/sh_dialogue.lua` installs
"Claim rewards" and an authoritative task preview. Contacts without a work topic show the main-menu entry only when a relevant reward,
kit exchange, barter or pending reward claim is available.
Pending rewards keep "About work" accessible even after the active job is finished.
That menu lists repeatable job offers. Progression tasks pay money and reputation
through their own completion flow, without selectable item rewards. Existing kit and
barter exchanges remain available through the rewards menu.

Medium repeatable tasks require 250 reputation; hard tasks require 1,600. Easy tasks
have no reputation gate. Preview generation and acceptance both enforce the requirements,
including when reputation changes after a preview was saved. Locked categories are hidden.

The work menu shows a concrete saved offer from each unlocked difficulty with its
task name and cash. Opening an offer shows its description, with up to three reward packages
shown once on the acceptance buttons. Players select their reward package when
accepting. That selection is then locked on the server, including while a completed reward awaits delivery.
About work only offers claims for earned rewards and bonuses, kit exchanges and barters;
it cannot change an accepted task reward. Saved selections and pending claims remain intact. Each ordinary package
contains one or two existing supply items or explicitly selected trade goods, with exact quantities
and no weapons or suits. Each town contact defines up to three named package families; one affordable,
unlocked candidate per family is selected deterministically for each saved offer. Labels identify
maintenance materials and electronics as trade goods, without promising new repair or power mechanics.
A supply allowance uses the task's fixed reference cash payment at an independent
55% rate, with a minimum of 600 rubles even for easy tasks; quantities
respect that budget and normal stack capacities. Cash value alone determines the quantity,
up to two full stacks, regardless of the easy/medium/hard category. Quantities fill the
first item before spilling into the second; partial stacks show their exact uses/rounds. Unspent allowance is banked toward the
same trader's five-task bonus. A catalogue with no affordable eligible items banks the whole allowance.

Every five repeatable completions for the same trader earn a bonus at that trader.
Each trader has a separate completion counter and accumulated bonus value. Progress persists without a time limit or streak reset. Only the unused portion of each task's supply allowance contributes to the bonus;
there is no base contribution or percentage of ordinary cash added. Higher-quality hand-ins
can increase ordinary cash but do not inflate the bonus. The rewards menu shows progress
and the accumulated value. If five tasks leave no unused
allowance, the cycle resets without creating an empty bonus offer. If positive value cannot yet buy
an eligible themed reward, it remains banked and joins the next five-task cycle. Existing earned bonuses
and previously accumulated value are preserved.

An earned bonus offers larger versions of that contact's themed packages. Only Technut and Boss
add repair credit, bound to the issuing provider, with 30% more face value. Credit appears only when
the whole award fits within the existing 20,000 balance cap and the provider is accessible.
Claim-time checks prevent lost credit if capacity changes. Credit applies after repair discounts
and cannot become cash. Other contacts do not offer Technut credit.
Mute, Atlas, Latch, Suture and Smartass also have explicit equipment bonus lists: binoculars,
a compass, industrial tools, fabric reinforcement and optics/suppressors respectively. These
choices contain one item, fit the earned budget and respect existing personal purchase gates.
They never grant purchase permission or add items to vendor stock.
Bonus packages never include cash or ruble items, including rounding remainders.
Unclaimed bonus choices refresh with the same earned budget. Kit and barter redemption retain
their existing remainder handling. Full inventories retain token-backed claims.

Town contact rewards are authored under `rewards.packages` in each contact definition. Each entry
has a `label` and candidate `items`. Optional `bonusItems` and `bonusService` configure larger bonuses.
These lists are separate from `supplies`, which still configures ordinary vendor stock and legacy
kit redemption. Vendor unlock catalogues do not automatically expand town task rewards.
Ordinary rewards include existing ammunition, food, drinks, medicine, charcoal, sharpening stones,
the stash cleaning kit and selected mechanical, electronic, textile and archive trade goods.
Existing town equipment/ammunition gates apply. Medicines use the contact's own seller milestone
where present; support contacts without a medicine catalogue require a completed milestone at a
real seller. Contact access always applies. Standalone non-town reward profiles retain their
existing consumable catalogue behaviour.
Unlocks never multiply the payment for identical work. Preview packages are saved and
stable; already accepted jobs retain their assigned rewards. Cached unaccepted previews receive
the increased allowance and catalogue revisions when reopened, preserving the task identity and requirements. Abandonment grants neither
bonus progress nor payment. Finite story/progression tasks do not count toward the bonus.

Delivery cash is 50% of the required hand-in value, using the higher of catalogue value
and configured/live trader sale quotes, multiplied by the actual requested count.
Stackable requirements are priced per consumed use; ammunition boxes without `quantity`
count as whole inventory items. Actual specimen quality/value is recorded before
consumption. Non-delivery jobs pay 55% of their configured midpoint cash plus half the
supply expected value. Both components are scaled together.
A base Swamp Controller hand (catalogue value 6,700) pays 3,350 rubles from its repeatable
job, plus its chosen supply package; progression credit for that hand is 4,020 rubles.
`JOB_CASH_RATE` configures repeatable delivery payouts in `libs/sh_taskrewards.lua`.
`JOB_REFERENCE_CASH_RATE` preserves supply budgets and non-delivery cash at their existing values.
Cached unaccepted delivery previews refresh their cash without rerolling their supplies.
Progression sets `PROGRESSION_CASH_RATE` separately in `../progression/libs/sh_rewards.lua`. Money is paid once on job completion, not during item delivery.
A qualifying completion still earns its existing 20% personal vendor restock exactly once.
Job previews save their cash and supplies when created; reopening and accepting reuse that offer.

Kit redemption retains its original profiles and provider-specific purchase checks. Task-kit offers
retain nominal-value budgeting. Higher-value offers of those types may
include an already-authorised weapon or body armour from that provider, worth at least
60% of the offer budget. Quantities are explicit; indivisible value and the package-size
limit settle into a visible ruble remainder. Offers stay within one ruble of their nominal
budget. Task variety and personal assignments provide variation without hidden jackpots.
This preserves nominal catalogue value, not identical vendor resale proceeds or equipment
utility; balancing still requires live playtesting.

The paid upgrade dialogue is removed. Recognised task-kit types, including shared ammo/
aid kit types used by jobs, redeem at contacts for visible choices with no fee. These types
redeem deterministically; unrelated starter, medical and world kits keep their opening
behaviour. Reward definitions reference existing items and pools directly.

Kit-producing Haggler/Quartermaster barters appear in the task supplies menu as explicit
ammunition selections from their original ammunition families. Their required items and
quantities are unchanged. The old barter endpoint cannot issue those kits. Ordinary named
barters remain in the normal barter menu. Failed input checks consume nothing.

Offers use character data `taskRewardOffers`; preview assignments use `taskJobPreviews`.
Pending supplies use progression line `taskRewardClaims`. Token acknowledgement and
restart recovery are shared with existing fixed rewards. Offers and queues are bounded;
paid choices are removed, and abandoned/unaccepted alternate offers are retired. Claiming
continues while space permits; the menu can resume remaining claims later.

Additional checks:

```bash
luatex --luaonly tests/task_rewards_spec.lua
luatex --luaonly tests/jobs_menu_spec.lua
python -m unittest discover -s docs/balance/tests -p test_task_rewards.py -v
```

Legacy global partial progress is preserved at the most recently credited trader, using
the greatest saved completion serial. Its earlier trader attribution cannot be recovered.
Existing earned bonus offers retain their original trader and value. New progress is
stored per trader under `taskCompletionBonus.traders`; `BonusStatus` calls the displayed
amount "Bonus value earned" rather than "Banked" to distinguish it from spendable cash.

## Repeatable field assignments

Jobsystem owns equipment recovery, sensor deployment/retrieval, radio triangulation,
dead-drop circuits and field research defence.
Their runtime, cargo items, world entity and PDA controls all live in this plugin.
No new map spawn-point definitions or per-assignment staff setup are required.

- **Recovery:** search around an approximate marker, collect a 2x2, 2.5 kg case, and return it.
- **Sensor:** choose a deployment position within 512 units of the assigned survey point,
  using the PDA's Field work menu. The sensor is placed in front of the player after a
  ground/clearance check. Leave at least 512 units from the deployed sensor and allow
  120 seconds of recording, then collect the 1x2, 0.5 kg recorder and return it.
  Recording continues while the character is offline; departure must have been observed
  while playing, and is saved separately.
- **Triangulation:** use the PDA to take three readings, each at least 512 units from
  previous readings and at least 15 degrees different in bearing to the source.
  Bearings use the schema compass convention (north along +X, east along -Y).
  The final reading reveals the site; collect the 2x1, 0.75 kg transmitter and return it.
- **Dead-drop circuit:** collect a 2x2, 5 kg sealed parcel at one existing point and
  deliver it to another through the PDA's Deliver parcel action. Pickup and delivery
  must be at least 2,048 units apart. Pickup alone earns nothing; delivery consumes the
  matching parcel and saves completion. Return to the contact to receive payment.
- **Research defence:** start the sampler at the assigned site through the PDA. Stay
  within 768 units, clear the waves and complete 90 seconds of defended recording, then
  collect the 1x2, 0.5 kg results recorder and return it. The sampler has 250 health.
  Visible encounter mutants within 160 units disrupt it for 8 damage per mutant per
  second. Its own attackers can also damage it directly; unrelated players cannot.
  Bundled mutant AI targets defenders, so proximity disruption supplies the equipment
  threat without changing the NPC framework. Easy jobs have two small waves; medium
  and hard jobs have three waves with tougher configured compositions.

Open **Field work** on an accepted job in the PDA task list for directions, readings
or deployment, research startup, and parcel delivery. Markers last 30 seconds; Show
assignment displays them again. A recovery
marker gives a search area rather than the exact case position. Wrong-map status reports
the target map. Easy/medium/hard definitions target Swamps/Waystation/Pripyat respectively,
following the existing field jobs' regional difficulty convention. Target maps, categories,
reference payments and reputation are in `definitions/sh_fieldjobs.lua`. Existing reputation
gates, supply choices, completion bonuses and completion/restock handling still apply.
The configured reference cash is processed by the ordinary reward calculation; it is not
the final cash payout displayed in the preview.

### Reusing and combining point pools

Edit `definitions/sh_fieldsettings.lua`. `field.sources` maps source names to existing plugin/table
pairs. Each supported table is keyed by map, with the position at `row[1]`:

| Source | Existing data |
| --- | --- |
| `stash` | `hidestashspawner.stashspawnpoints` |
| `event` | `eventcontroller.eventpoints` |
| `anomaly` | `anomalycontroller.anomalypoints` |
| `radiation` | `radiationcontroller.radiationpoints` |

`field.pools` provides composable aliases: `packages = {"stash"}`, `rf = {"event"}`,
and `gas = {"anomaly", "radiation"}`. Each `field.settings` task has its own `sources`
list. All five task types use existing event points by default. Sensors also use hazard points;
recovery, triangulation and dead drops also use stash points. Dead drops still need endpoints at
least 2,048 units apart, and defence still needs suitable nearby approaches.
For example, change recovery to use both existing survey families:

```lua
recovery = {sources = {"gas", "rf"}, cargo = "job_recovery_case", searchRadius = 384},
```

Lists can combine raw sources and pool aliases. Collection deduplicates positions,
handles missing providers/maps and cyclic aliases, and never changes source tables.
When a provider has no entry for the destination map, collection reads that provider's
`firsttimesetup.map_presets[map].plugindata` coordinates. This does not run setup or write saved data.
Saved map entries take precedence, including explicitly empty tables. Custom maps without a preset
still need saved or authored points.
All five tasks may share the same pools. Empty field pools are excluded from new
offers, including cached previews while those providers are unavailable. Restoring the
provider restores that preview without rerolling it. Existing non-field offers remain
eligible. A currently disabled provider may still have loaded data, so remove its source
from the task configuration if those points should not be used.

Dead drops configure pickup `sources` and `destinationSources` separately, plus
`minRouteDistance`. For example, `sources = {"packages"}` and
`destinationSources = {"rf", "gas"}` make a stash-to-survey circuit. Routes without
a sufficiently separated pair are excluded from offers. Both endpoints are saved when
the task is accepted. Losing the parcel reopens pickup on that same route. Completed
delivery remains complete after the parcel is consumed or the character reconnects.

Research defence configures sampler `sources` and `attackSources` separately. Both
default to `rf`, reusing event points. A site needs at least one approach 512–4,096
units away and within 256 vertical units. Up to eight approaches are saved; models
and NPC hulls are checked for ground/clearance at runtime. Attack points occupied by
nearby players are skipped. Existing point data cannot guarantee navigable NPC paths;
verify representative sites in-game, especially buildings and underground areas.
Wave class lists and counts, health, recording duration, disruption, radius and retry
parameters live in `field.settings.defence`. Wave compositions are rolled once on
acceptance and saved. An unavailable population manager or missing approaches hides
these offers. The default global limits are three simultaneous defence encounters and
two task NPC spawn attempts per one-second update, across all defenders.

Task attackers check the installed event controller's `CanSpawnMutant(position, true)`
and register immediately through `RegisterMutant`, so live and queued global/regional
caps remain authoritative. The generic spawn queue does not return owned NPC references;
these bounded encounters create and register their own NPCs to track kills and cleanup.
The existing jobsystem kill listener forwards deaths without changing dispatch order or
ordinary kill credit. Removing an NPC without a death event does not clear its wave;
the missing attacker is replaced subject to the same spawn/cap checks.

Defence recording advances only while the assigned character is alive and near the
sampler. Leaving, dying, changing characters, disconnecting or restarting the server
removes ephemeral attackers and interrupts the current wave. On return, completed waves,
recording time and sampler health are retained; only the unfinished wave restarts.
Unrelated nearby players can help fight but cannot substitute for the assigned defender
or collect the results. Destroying the sampler or exceeding the 300-second active-attempt
limit fails the attempt. After a saved 30-second delay, explicitly restarting resets the
attempt at the same site with the same saved wave composition. Failures pay nothing.
Abandonment, reset and completion remove the encounter's remaining owned NPCs.
Removing the population manager pauses active research. Unloading jobsystem removes
its world objects and attackers and disables retained field-action callbacks; saved
assignments and carried cargo remain available when the plugin is loaded again.

Assignments save their selected map, position, search area, timing, reading requirements,
readings and stage inside the existing character `jobs` field. Changing pools affects
future assignments; it does not reroll accepted work. There are no new persistence keys
requiring a world migration or reset. Remote-map point clearance can only be checked
after travel. Objects use a model-sized ground trace with small nearby placement offsets;
obstructed sites retry and notify the owner. Existing source points still need to be
reachable in the deployed map; source coordinates alone cannot prove accessibility.

### Ownership and lifecycle

The server checks active assignment, character identity, map, distance, life/restriction
state and action cooldowns. World objects are ephemeral `ix_job_field_object` entities,
created only when the assigned living character is within 1,024 units. Sensors appear
after deployment; transmitters appear after the required readings. Objects despawn beyond
1,536 units or after character departure, death, abandonment, completion or reset, then
reappear at their saved site when appropriate. They are excluded from Helix persistence.
Updates run once a second and iterate active players/jobs rather than scanning world entities.

Only the assigned character can collect an object. Cargo stores its character and unique
job claim, cannot be dropped or transferred to another inventory, and occupies the main
inventory. Pickup first creates the item asynchronously, rechecks the active character,
claim, distance and entity in the callback, then transfers the existing item synchronously.
A pending lock prevents repeated collection; failed transfers remove only the new item,
leaving the objective available. Timed-out requests unlock after 30 seconds; late callbacks
are discarded by request identity, so retries cannot grant duplicate cargo. Requests are
also retired when their world object leaves the active set. This avoids treating `Inventory:Add(string)`'s initial
slot reservation as successful item delivery. The cargo's installed `ITEM:CanTransfer`
callback also enforces its binding because COTZ's existing `corechanges` hook can return
`true` and stop subsequent plugin hooks. No competing hook registrations were converted.

Completion checks for the matching cargo before paying, consumes it, and uses the existing
claim/reward path. Inventory state repairs the carrying stage after an interrupted save.
Lost cargo reopens recovery at the same site. Abandoning or resetting removes cargo and
invalidates pending pickup callbacks. SQL failures remain visible through Helix; this
plugin does not wrap or replace the framework database layer.

Regression checks:

```bash
luatex --luaonly tests/field_tasks_spec.lua
luatex --luaonly tests/task_rewards_spec.lua
luatex --luaonly tests/population_performance_spec.lua
```

The standalone checks mock Garry's Mod and do not establish multiplayer correctness.
Before deployment, verify all five tasks with two players, owner-only Use, full/overweight
inventories, PDA layout and compass bearings, obstruction/ground clearance at representative
source points, map travel, character switches, disconnect/restart recovery, abandonment,
admin reset, and single payment with the ordinary supplies/bonus/restock flow.
For circuits, verify both endpoints, missing cargo, repeated delivery and post-delivery
reconnects. For defence, verify navigation, population saturation, sampler disruption,
group assistance, failure/retry, interruption during each wave, and attacker cleanup.

## Leaderboard statistics

`libs/sh_leaderboard.lua` tracks personal kills and successful task hand-ins in the existing
`leaderboardStats` character data. Rare kills include bloodsuckers, burers, controllers, chimeras,
electro chimeras and pseudogiants. Species use exact configured species rules, merging controller
variants; overlapping group triggers cannot multiply a kill. Nearby players keep their normal job
credit without receiving personal kill statistics.

Hard tasks are tier 3 or above. Research operations are sensor or defence field assignments; recovery
operations are recovery field assignments. Each counts at guarded hand-in, once. Task earnings count
actual ordinary job cash payouts, excluding item rewards, bonuses and separate progression payouts.
New counters start when deployed; existing totals are retained. Favorite contact is derived from
saved progression: count completed defined steps for each contact and show the names with the highest
positive count. Ties show every matching name alphabetically; no completed steps shows None.
Only aggregate public statistics enter cross-map snapshots; species sets and progression lines do not.

Run `luatex --luaonly tests/leaderboard_stats_spec.lua` alongside the job and presence specs.
Check the scrolling dossier and local/remote totals in a multiplayer session after character save.
