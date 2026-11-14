# Job System

`jobs` remains a persistent character var, with a `MEDIUMTEXT` SQL column for fresh databases.
See [character storage](../../../../docs/database/README.md) for its definition and the other large character vars.

## Revised repeatable jobs, 6 November 2026

The [current roster and implementation guide](../../../../docs/npc-overhaul/repeatable-jobs.md)
supersedes the older town repeatable delivery/tier descriptions below. New work uses regional targets,
alternate receivers, cross-map dead drops, information couriers and Atlas's alternating photography.
Reference cash is 1,000/2,000/3,000; reputation is 15/25/35. Reward packages and completion-time choices are described below.
Accepted old assignments retain completion-only definitions and their original reputation terms.
Finite progression is unchanged and its rework is deferred, including stalled inactive-issuer checkpoints.

Beanstalk, Egghead and Intern live in the Swamps Eco Bunker. Their town definitions declare
`map = "rp_marsh_cs"` and `bunker = true`. Wake's easy information couriers exclude bunker contacts;
hard couriers include all three scientists alongside Waystation recipients. Existing physical bunker
access and the hard-tier card-purchase gate remain. Beanstalk offers research defence; Egghead's
specimen requests retain Garbage/Waystation/Pripyat difficulty regions, with claims at the bunker.

`definitions/sh_regionalcatalogue.lua` is static generated source data. `libs/sh_regionaljobs.lua`
owns shared eligibility/identity helpers; `sv_regionaljobs.lua` owns authoritative progress and bound
camera/courier issuance. Per-assignment field settings, both route maps and cargo variants are saved.
Run `luatex --luaonly tests/regional_jobs_spec.lua` alongside the suites below.
No server deployment, first-time setup or live-save reset is part of offline verification.

## Hand-in quality

Meal and raw-meat hand-ins use saved weight through their existing prices. Reference quotes use
the raw meat's `BaseWeight`, including the corresponding cooked meal. Mutant-part hand-in value
multiplies the existing tier price by saved weight divided by `baseweight`; missing saved weight
uses the normal base weight. Ordinary vendor part prices retain their existing tier rules.
Repeatable delivery cash scales with this value, including its tier minimum, so better specimens
increase rewards even for inexpensive requests. Finite progression accrues the weighted value for
completion cash and includes part weight in its reputation quote. Saved delivery credit remains intact.

Run `luatex --luaonly tests/handin_quality_spec.lua`. Check actual mixed-quality deliveries and
completion/reconnect behavior in multiplayer; standalone tests use mocked inventory boundaries.

## Task feedback and hand-ins

Valuable couriers list every eligible receiving contact in the confirmation and task journal.
Map references, including saved BSP filenames with extensions, use the cross-server display names, with built-in names available before that plugin
loads; accepted descriptions containing BSP names are formatted without changing saved locations.
Incoming delivery options require an actual nonempty matching item or bound parcel, rather than
assignment state alone. Reward choices refresh immediately after the final hand-in at the issuer;
completed field/combat work reveals its choices on returning to the issuer.
Every objective completion sends a task-completed notification and PDA sound once. The Tasks tab shows objectives and progress without payment or reward-choice instructions.
At the default COTZ font scale of 1.30, the journal uses 33 px headers, 25 px task names
and 22 px body/button text at 1080p. Adjust it under Settings → Appearance; action rows
scale with the text, and cards wrap and scroll.
Field-work tasks appear first, with contacts sorted by name within the field-work and ordinary task groups.
Each card shows its task image on the right above a full-content-width progress bar, preserving its aspect ratio. Regional species hunts reuse
the matching legacy kill-task image, including the Snork photo; tasks without artwork use the area icon.
Search above the task list matches task names, contacts, objective descriptions and current objective
zone names as you type, without regard to case. The status filter offers All tasks, In progress and
Completed. Completed means ready to return to the contact; handed-in assignments leave the list and
are not a task history. Current zone follows the assignment's current step: its saved field/combat
map, courier receiver, dead-drop burial map, or issuing contact when returning cargo/completed work.
Photography, unrestricted legacy kill work and tasks without a known zone remain visible in any zone.
Search and both filters combine, stay above the scrolling
cards, and show the matching count against the total accepted tasks. They refresh as assignments change.
Photography
shows the saved captured species/anomaly list in the journal. There is no camera HUD ledger.
Triangulation saves the origin and compass bearing of each reading and marks those positions in
world space until the transmitter is collected. Old coordinate-only readings remain supported.
Mute now offers triangulation in Swamps / Waystation / Pripyat, with 3 / 4 / 5 readings.
Contacts without repeatable work omit the root offer link while retaining active legacy job status.
Abandoning a task requires confirmation; the callback rechecks the character, assignment and cooldown.

Dead drops use invisible, non-solid `bNoPersist` world objects. Use a usable `base_hidestashers`
tool to dig up the pickup and bury the parcel, or use the carried parcel's burial action. Both use
an eight-second action and revalidate character, claim, tool and location afterwards, including
the asynchronous pickup callback. Cancelling leaves the pickup intact. Task digging does not consume
tool uses and never writes to the permanent hidden-stash registry. Bound parcels can be rearranged
inside the main inventory and cannot leave it. Sensor world objects use
`models/lostsignalproject/items/quest/scanner_anomaly.mdl`, including custom commission sensors.

Hand-in cash is 50% of the required items' value, with minimum payouts of 500 / 750 / 1,000 rubles
for easy / medium / hard jobs. The minimum is a floor, not an added fee: one 1,200-ruble cat tail
pays 600 rubles on easy. The chosen supply reward never reduces cash. Item value funds neither
supplies nor the five-task bonus: hand-in supply allowances remain 600 / 1,000 / 1,500 rubles, and
only unused supply allowance contributes to bonuses. Whole-item requests value whole meals/specimens;
per-use requests retain unit valuation and higher-quality hand-ins retain their increased value.
Definition-only quotes that return zero without instance data, such as a meal's saved weight, use
the configured item price as their reference. Actual hand-ins retain their instance valuation.
Unpaid delivery assignments and previews refresh their cash from the shared calculation without
changing their identity, quantities, credited value or progress.
Accepted assignments retain their identity and progress. Unpaid reward offers migrate to the current
completion-time catalogue; their bonus allowance is capped to the current tier basis.
Previously completed hand-ins also receive the current cash formula at claim; paid claims stay paid.

## Editing definitions

Field-work menus and temporary world labels use the shared
[COTZ UI style](../../../../docs/ui-style.md). Assignment labels have a dark backing and amber border
and stay within the viewport. Recovery retains text directions and adds a narrowing search-area marker nearby.

Restart after editing shared definitions. Job IDs, category IDs, cargo item IDs, network names and
saved character keys remain stable. Existing accepted field jobs keep their saved destinations,
recording parameters and defence wave rolls; definition edits tune new assignments.
No save reset or first-time setup is required.

For deliveries addressed to a town contact, the PDA and hand-in checks resolve that contact's current
home map. This keeps accepted commissions usable when the workbook plan moves the scientists to
the Swamps Eco Bunker. Saved search sites, cargo identity, claim serials and delivery progress are retained.
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
`libs/sh_tooljobs.lua`. Reward profiles here are fallbacks. Town contacts
install dedicated `rewards` definitions separately from their ordinary vendor `supplies`.
`moneyReward` is reference cash processed by reward calculations,
not necessarily the final preview payment. Preserve field names and units when tuning.

Existing map points are the default: recovery uses stash/event points, sensors anomaly/radiation
points, triangulation event/stash points, dead drops stash pickup and stash/event destinations, and
research defence outside event points. Optional authored town points are added for the other task types. No manual
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

Cargo protection resolves the numeric instance ID supplied to `CanPlayerDropItem` and the world
entity's `ixItemID` supplied to `CanPlayerTakeItem` through `ix.item.instances`. Pickup ownership uses
saved instance data; ordinary persistent drops and pickups continue through the remaining hooks.

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
luatex --luaonly tests/job_overlays_spec.lua
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

The main menu's **Tasks** tab contains the current task list, including descriptions, payment, progress, Abandon and
Field work actions. The scrollable cards use the equipment menu palette, borders and scaled typography,
and refresh when accepted tasks change. Tasks have their own page alongside Help and You, including when
there are no active jobs. The You tab contains the backpack and equipment.

## Task rewards and existing kits

Jobsystem owns repeatable reward preparation, hand-in choices, bonus accounting and stored claims.
Town contacts configure rewards beside their jobs in `townnpcs/definitions/sh_<contact>.lua`.
Reward lists are independent of vendor stock and purchase unlocks. NPC conversation/access checks
still apply. Finite progression retains its separate completion payments.

### Completion-time choices

Accepting a task shows its objective and ordinary cash payment. It does not select or reveal a
reward. Preview packets transmit zero reward choices, and neither previews, active jobs nor their
unrevealed offers store reward candidate details. The task journal shows ordinary payment and return
instructions. Bonus progress shows the number of completions, without revealing the bonus value.

Once the objective is ready, open **About work → Task rewards** at the issuing contact.
**Complete the assignment** also reveals up to three reward choices in that submenu. Selecting one
completes the hand-in, consumes any required cargo, pays cash/reputation, credits the task and restock once, and grants the selected reward. Selection is checked
against the current character, active claim, completion state, cargo, NPC access and proximity.
Walking away after revealing a reward preserves the job and choices; returning does not reroll them.

A full inventory queues selected items with the existing progression reward tokens and exact quantities.
A full claim queue keeps the chosen earned offer until space opens; its choice stays locked so
retrying cannot change the allowance already credited to the bonus. Retrying it cannot pay ordinary
cash or credit task/bonus progress again. Pending inventory insertions retain their existing callback
and token recovery behaviour. Cash rewards require no inventory space.

New repeatable tasks and field commissions from that contact stay unavailable until all earned task
and five-task bonus rewards are collected, including selected items awaiting inventory delivery.
The server also rejects stale previews and direct acceptance while rewards remain. About work stays
visible for claims after the assignment disappears; hand-ins return there, and reward choices stay
in their submenu. Existing ammunition barter actions retain their main-menu placement.

New queued items carry an additive `taskNPC` issuer field; barter items use `false`. Existing tokens,
quantities and queue order are unchanged. Older queued items without an issuer remain claimable and
block new tasks at every contact until collected, since their original issuer cannot be recovered.

### Allowed items and quantities

Town reward items must be consumable or have limited uses. Ammunition, medicine, food, drinks,
charcoal, sharpening stones and stash digging tools qualify. Hidestash spawners are eligible because
their stash-generation action is spent once. Euro Notes and Dollar Notes are the only valuable-item
exceptions. Reusable equipment, attachments and other valuables are excluded from new town reward lists.
Technut and Jitters instead issue provider-bound repair and treatment credits for both regular
and five-task rewards. These restrictions apply to ordinary and five-task bonus choices.

Every ammunition reward contains exactly half its normal pack, rounded down for an odd pack size.
Its allowance must cover that half-pack. Larger allowances never increase ammunition quantities,
including for bonus ammunition. Other consumables use explicit, budgeted quantities within their
normal stack capacity; ordinary and bonus choices contain at most two inventory items. Bonus
choices pay the unused allowance directly in rubles, with the amount shown in the choice label.
Ordinary item choices do not include a cash remainder.

| Contact | Regular reward highlights | Five-task bonus highlights |
| --- | --- | --- |
| Old Timer | 10 .410 shells (`45acp41`), sharpening stones, canned tushonka | Fine stones, Swamps stash notes |
| Cleaner | Cutlery, stash cleaning kits, canned beans | Lost Note, Lost Rookie PDA, Lost Veteran PDA |
| Spicy Lemon | Cutlery, canned chili beans/olives/corn, charcoal | Canned supplies, charcoal, or cash |
| Mute, Spool, Ballast | Cash only: 200 / 400 / 600 rubles for easy / medium / hard | Euro Notes or Dollar Notes |
| Technut | Repair credit: 200 / 400 / 600 rubles | Remaining allowance as repair credit |
| Jitters | Treatment credit: 200 / 400 / 600 rubles | Remaining allowance as treatment credit |
| Haggler, Smartass, Latch, Brass, Boss | Dedicated consumable/currency packages | Dedicated packages or cash |
| Other contacts | Dedicated food, medical, ammunition and other consumable packages | Defined consumable/currency packages or stash information |

Old Timer's only reward ammunition is .410. Cleaner has no ordinary stash-spawner reward.
The three stash spawners generate caches in Swamps, Waystation and Pripyat respectively.
Contact definitions list every candidate; `packages` configures ordinary choices, `bonusPackages`
configures separate bonus choices (defaulting to ordinary packages), `cashPerTier` replaces ordinary
items with cash, and `bonusCash` adds a cash alternative to the bonus choices. A `service` profile replaces both
item pools with that service's credits; `creditPerTier` sets the regular face value per difficulty tier.

### Cash and five-task bonuses

Ordinary payment is independent of the selected reward. Hand-in cash pays 50% of the required items'
value, subject to an easy / medium / hard minimum of 500 / 750 / 1,000 rubles. Actual hand-in quality
is recorded before consumption; whole-item requests use whole-item value, and per-use requests use
consumed-unit value. Non-item
jobs retain their ordinary 55% reference-cash payment. The 200 / 400 / 600 reward for cash-only
contacts is paid in addition to that payment.

Supply allowance retains its 600-ruble minimum. Item hand-ins retain allowances of 600 / 1,000 / 1,500
rubles by tier. In `sh_rewardsettings.lua`, `jobHandInBaseMoney` sets cash minimums and
`jobHandInSupplyMoney` sets supply funding before the 600-ruble minimum. Item reimbursement never
funds supplies or bonuses. On reward selection, the chosen items' value or
chosen cash reward is deducted from the allowance. Only the remainder enters that trader's five-task
bonus. Each trader keeps a separate completion count and budget, without a time limit.

Bonus choices are generated and revealed only after five completed hand-ins for that trader.
A bonus cash choice pays the earned budget. Item bonus choices contain at most two inventory items
and pay the remaining allowance directly in whole rubles. Euro and dollar choices use their configured per-note
values (52 and 38 rubles), rounding down and paying the remaining whole rubles. Five all-easy / all-medium /
all-hard jobs at Mute, Spool or Ballast produce budgets of 2,000 / 3,500 / 5,250 rubles: a choice of
38 / 67 / 100 euros or 52 / 92 / 138 dollars. Mixed difficulties combine the remaining allowances.
Unaffordable bonus value carries into the next cycle; a zero-value cycle creates no empty reward.
Revealed current-version bonus choices persist without rerolling on menu reopen or reconnect.

Technut's repair credits and Jitters's treatment credits replace their item and extra-cash reward
choices. Regular rewards are 200 / 400 / 600 credits; one credit covers one ruble of that provider's
service fee. Their item-hand-in allowances leave 400 / 600 / 900 credits per job for the bonus,
so five jobs of one difficulty yield 2,000 / 3,000 / 4,500 bonus credits. Normal cash and reputation
remain separate. There is no credit premium or ruble remainder for these profiles.

Credit balances retain the existing caps: 20,000 for Technut's repairs and 5,000 for Jitters's treatment.
A claim fills available balance space and saves any excess as a pending reward. Spend credits and
return to Task rewards to collect the remainder; this also supports bonuses larger than the balance
cap. Pending credit blocks new work at that contact. Inventory space is irrelevant, and retries
cannot pay ordinary cash, reputation or completion progress again.

### Compatibility and ammunition barters

Catalogue version 7 replaces unpaid Technut/Jitters reward offers with service credit, preserving
assignment identity, progress, earned budgets and already queued item claims. Partially collected
credit offers save only their unpaid remainder for subsequent migrations.

Catalogue version 6 caps bonus offers at two items and adds direct ruble remainders. Unclaimed
bonus offers rebuild with their earned budget preserved. Already-selected rewards in the durable
item queue retain their exact items and quantities; they are not paid again or converted retroactively.

The catalogue migration retires old acceptance-time reward reservations. On character load and NPC
interaction, active jobs and saved previews lose cached choices while keeping their IDs, quantities,
progress, cargo, claim serials and ordinary cash terms. Already-earned unclaimed offers receive the
current eligible catalogue with their earned budget preserved. Previously paid/token-queued rewards
remain recoverable; this migration does not erase existing item claims or repay completed jobs.
No database reset or first-time setup is required. Update all map servers together and restart.

Legacy kits, including Hiking Backpack, open directly from inventory using their existing loot tables.
NPC kit hand-in choices and their server redemption handler are removed. Existing item IDs and queued
reward claims are preserved. Ammunition barters retain visible choices, existing valuation, bounded
token-backed pending claims and provider access checks. The paid upgrade dialogue remains removed.

Checks:

```bash
luatex --luaonly tests/task_rewards_spec.lua
luatex --luaonly tests/jobs_menu_spec.lua
luatex --luaonly tests/jobs_loading_spec.lua
luatex --luaonly tests/kit_opening_spec.lua
python3 -m unittest discover -s docs/balance/tests -p test_task_rewards.py -v
```

The standalone checks cover hidden previews, completion choices, cash-only tasks, half-pack ammunition,
allowed item types, currency quantities, duplicate claims, unavailable contacts, saved-offer migration,
full inventories and full claim queues. Verify dialogue refresh, cargo hand-in, map travel, reconnect,
restart and actual inventory insertion in multiplayer before deployment.

## Repeatable field assignments

Jobsystem owns equipment recovery, sensor deployment/retrieval, radio triangulation,
dead-drop circuits and field research defence.
Their runtime, cargo items, world entity and PDA controls all live in this plugin.
No new map spawn-point definitions or per-assignment staff setup are required.

- **Recovery:** search the named event-spawn area described in the PDA, collect the assigned cargo, and return it.
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
  within 2,048 units, clear the waves and complete 90 seconds of defended recording, then
  collect the 1x2, 0.5 kg results recorder and return it. The sampler has 250 health.
  Attackers advance on the sampler and, when visible and within 160 units, disrupt it
  for 8 damage per mutant per second. Seeing a player or taking damage from one switches
  their attention to player combat and pauses their disruption. After losing player contact,
  they resume attacking the sampler. Its own attackers can also damage it directly;
  unrelated players cannot. Easy jobs have two small waves; medium
  and hard jobs have three waves with tougher configured compositions.

Open **Field work** on an accepted job in the PDA task list for directions, readings
or deployment, research startup, and parcel delivery. Assignment markers last 30 seconds; Show
assignment displays them again. Recorded triangulation origins and bearings stay visible during the search.
Recovery uses the named event-spawn area, with a compass offset and approximate distance when needed.
Within 4,096 units (about 80 metres) of the object, Show assignment also displays an approximate
recovery-area marker for 30 seconds. Its centre and search radius tighten as the player approaches:
the default 1,536-unit area (about 30 metres) narrows to 256 units (about 5 metres). Walking out of range
hides it; collecting cargo, abandoning/replacing the job or changing character clears it.
Wrong-map status reports the target map. Easy/medium/hard definitions target Swamps/Waystation/Pripyat respectively,
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
default to `rf`, reusing event points. Both sampler sites and attacker approaches require
eventcontroller points tagged with a regional `_outside_easy` or `_outside_hard` suffix.
Building, underground, sniper, untagged and authored town points are excluded, including
when collecting from FTS presets. Existing accepted assignments keep their saved locations.
A site needs at least one approach 512–4,096
units away and within 256 vertical units. Up to eight approaches are saved. Attackers use
the event controller's shared placement service around those approaches: connected ground
nodes within its 750-unit spawn radius are preferred, with the same validated floor/clearance
fallback when graph candidates are unavailable or blocked. The validated position is used
directly without another `DropToFloor`. Positions occupied by nearby players are skipped;
unsafe or population-limited spawns remain pending. Existing point data cannot guarantee navigable NPC paths;
verify representative outdoor sites in-game.

`ix.jobs.field.SelectDefenceSite(settings, map, usable)` returns the site vector, packed approaches and
the selected event point's location text. Its optional `usable(site, name)` filter can reject unnamed or
blocked sites. Server-side `ix.jobs.field.FindDefenceSpawn(defence)` shuffles `defence.spawnPoints` and applies
shared placement, `defence.playerSafeDistance` and hard population checks, returning a position or
`nil, reason`. Research encounters and automated Supply-truck mutant defenses both use these helpers;
their wave ownership, budgets, objectives and rewards remain separate.

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

Research attackers remain awake in isolated packs. Their sampler is a movement objective,
not a combat enemy: the NPC base cannot melee props, so the existing proximity disruption
damages it on arrival. Ordinary visible-player acquisition and damage retaliation take priority.
Player pursuit retains the combat system's ten-second last-contact memory; losing that contact
or the player's death resumes the sampler approach. Movement respects attack recovery and `ai_disabled`.

Defence recording advances only while the assigned character is alive and within 2,048 units of the
sampler. Accepted assignments with the former 768-unit default receive this wider radius on their
next active update; other saved radius values remain unchanged. Leaving, dying, changing characters,
disconnecting or restarting the server removes ephemeral attackers and pauses the current wave.
Every attacker kill is saved immediately as a dense boolean list in `defence.waveKills` within the
existing job state. On return, completed waves, individual kills in the current wave, recording time
and sampler health are retained. Only surviving or unspawned slots are recreated, so leaving cannot
respawn already harvested attackers. Kill tracking clears when the next wave begins or an explicit
retry starts a fresh attempt. Older saves without this list treat the unfinished wave as uncredited;
previously unsaved partial kills cannot be reconstructed. No save reset is required.
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
luatex --luaonly tests/job_overlays_spec.lua
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

## Recovery location clues and courier interests

Field point collection returns its existing vector list plus a position-keyed name lookup. Recovery
clues use named routine event points from saved map data or undeployed FTS presets. New offers need
a named clue. Accepted recovery sites retain their coordinates, cargo, description and claim; their
optional `fieldTask.whereabouts` text is resolved lazily and saved through the existing jobs field.
Missing providers leave existing jobs intact, with a temporary unavailable message and later retry.
Show assignment and the journal display the same clue. Area names are literal text, including `%`.
Nearby recovery markers use the saved search direction and claim, with a stable fallback for older
assignments lacking a search centre or having a centre directly on the object. The marker sits 75%
of the current search radius away from the object, so the object remains inside the stated area
without sitting directly under the marker. Marker radii are scaled by four for both existing and
new assignments without moving the saved object or rewriting its search area.
`runtimeSettings.recoveryMarkerDistance`, `recoveryMarkerMinRadius`, `recoveryMarkerRadiusScale` and
`recoveryMarkerUpdateInterval` in `definitions/sh_fieldsettings.lua` control the activation range,
minimum area, search-area scale and client refresh. `recoveryMarkerOffsetFraction` controls the
marker's separation from the object as a fraction of the current radius (default `0.75`).
Marker geometry updates locally every 0.1 seconds; the server sends only the contact and active claim
when Field work requests status in range. No per-frame networking or persistence migration is needed.
Other field types retain their current markers. Check narrowing, expiry, map/character changes and
pickup/abandonment in multiplayer alongside `tests/field_tasks_spec.lua` and `tests/job_overlays_spec.lua`.

Admins with observer access can enable **Settings → Observer → Field Equipment ESP** (off by default).
It shows the exact position and cargo name of spawned field-task equipment through walls, including
recovery cargo, sensors and research equipment. It follows the master **Show admin ESP** toggle and
requires observer noclip outside vehicles. Only entities transmitted to the client are available;
equipment still spawns when its assigned player approaches. The entity list and static marker data
refresh once a second, with removed objects hidden immediately. No extra networking is used.

Valuable couriers use explicit per-contact `courierPools`, separate from ordinary `wantedItems`
shop assortments. The compiled courier index and previous receiver interests drive the same offer,
journal and hand-in checks. Items still require an obtainable regional-catalogue source, existing
difficulty rules and a permitted receiver. New offers require a placed receiver and exclude The
Original; accepted work retains its previous permitted receivers. Disabled items remain excluded.
Item-specific counts, partial-stack handling and payments are unchanged.

Command metadata for CharResetJobs is shared in `libs/sh_commands.lua`; its implementation remains
server-side. Run `tests/field_tasks_spec.lua`, `tests/job_overlays_spec.lua`,
`tests/regional_jobs_spec.lua` and `tests/shared_commands_spec.lua` using `luatex --luaonly`.

### Interaction regression checks

Run `luatex --luaonly tests/contact_job_flow_spec.lua`, `tests/task_rewards_spec.lua`,
`tests/field_tasks_spec.lua`, `tests/jobs_menu_spec.lua` and `tests/dialogue_order_spec.lua`
with the same `luatex --luaonly` prefix for each file. Check hidden pickup, tool cancellation/loss,
full inventory, parcel burial, reward timing and character switches in multiplayer as well.

## Bunker courier discovery

Beanstalk, Egghead and Intern are excluded from valuable-courier recipients and new information-parcel
assignments until that character has greeted the individual scientist. Offers, previews, journals and
server hand-ins share this filter. Accepted parcel destinations remain saved. Existing progression-topic
discovery counts as prior contact; earlier unrecorded greetings require another conversation.
See [town discovery and verification](../townnpcs/README.md#bunker-courier-discovery).
