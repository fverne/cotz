The main menu's **Tasks** tab contains the current task list, including Abandon and
Field work actions. Tasks have their own page alongside Help and You, including when
there are no active jobs. The You tab contains the backpack and equipment.

## Task rewards and existing kits

Jobsystem owns repeatable job rewards, previews, acceptance, item delivery
and automatic supply-claim continuation. Its post-data-load hook validates task rewards. The `ix.taskRewards` API and saved character
keys remain unchanged. Progression owns story milestones and their completion payouts.
Jobsystem uses progression's NPC access checks, purchase unlocks and token-backed reward-claim service.

`libs/sh_taskrewards.lua` defines contact profiles, nominal-value budgeting and visible
packages. `libs/sv_taskrewards.lua` persists offers and transfers selected rewards into
the existing token-backed claim queue. `integrations/sh_dialogue.lua` installs
"Choose or claim task rewards", and an
authoritative task preview. Contacts without a work topic show the main-menu entry only when a relevant reward,
kit exchange, barter or pending supply claim is available.
Saved supplies keep "About work" accessible even after the active job is finished.
That menu lists repeatable job offers. Progression tasks pay money and reputation
through their own completion flow, without selectable supply rewards. Existing kit and
barter exchanges remain available through the supplies menu.

Medium repeatable tasks require 250 reputation; hard tasks require 1,600. Easy tasks
have no reputation gate. Preview generation and acceptance both enforce the requirements,
including when reputation changes after a preview was saved. Locked categories are hidden.

The work menu shows a concrete saved offer from each unlocked difficulty, including
requirements, cash and up to three supply packages. Players select their package when
accepting and can change it through the rewards menu before completion. Each package
contains one or two existing supply items, with explicit uses/rounds and no worn weapons
or suits. A supply allowance uses the task's fixed reference cash payment at an independent
55% rate, with a minimum of 600 rubles even for easy tasks; quantities
respect that budget and normal stack capacities. Cash value alone determines the quantity,
up to two full stacks, regardless of the easy/medium/hard category. Quantities fill the
first item before spilling into the second; partial stacks show their exact uses/rounds. Unspent allowance is banked toward the
same trader's five-task bonus. A catalogue with no affordable eligible items banks the whole allowance.

Every five repeatable completions for the same trader earn a bonus at that trader.
Each trader has a separate completion counter and accumulated bonus value. Progress persists without a time limit or streak reset. Only the unused portion of each task's supply allowance contributes to the bonus;
there is no base contribution or percentage of ordinary cash added. Higher-quality hand-ins
can increase ordinary cash but do not inflate the bonus. Task previews explain this rule;
the rewards menu shows progress and the accumulated value. If five tasks leave no unused
allowance, the cycle resets without creating an empty bonus offer. Existing earned bonuses
and previously accumulated value are preserved.

An earned bonus offers visible supply packages within the same budget or Technut
repair credit with 30% more face value. Credit appears only when the whole award fits
within the existing 20,000 balance cap and Technut is accessible. Claim-time checks prevent
lost credit if capacity changes. Credit is provider-bound and applies after repair discounts;
it cannot become cash. Supplies remain available when credit is unavailable.
Bonus packages never include cash or ruble items, including rounding remainders.
Legacy unclaimed offers are rebuilt with the same earned budget before selection.
Kit and barter redemption retain their existing remainder handling. Full inventories retain token-backed claims.

Contact profiles and each contact's full progression vendor catalogue determine eligible consumable
rewards: ammunition, food, drinks, medicine, charcoal, sharpening stones and the four-use cleaning kit.
All eligible supplies are in the reward pool regardless of purchase progression. NPC access still
applies, and receiving a reward never grants permission to buy it. Equipment, armour attachments,
other tools and stash notes/PDAs are excluded from ordinary task and five-task bonus supply catalogues.
Cleaner's configured reward profile also excludes hidestash notes and PDAs.
Bonus catalogues refresh when the rewards menu opens without changing the earned budget.
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
/tmp/cotz-balance-venv/bin/python -m unittest discover -s docs/balance/tests -p test_task_rewards.py -v
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

Edit `libs/sh_fieldtasks.lua`. `field.sources` maps source names to existing plugin/table
pairs. Each supported table is keyed by map, with the position at `row[1]`:

| Source | Existing data |
| --- | --- |
| `stash` | `hidestashspawner.stashspawnpoints` |
| `event` | `eventcontroller.eventpoints` |
| `anomaly` | `anomalycontroller.anomalypoints` |
| `radiation` | `radiationcontroller.radiationpoints` |

`field.pools` provides composable aliases: `packages = {"stash"}`, `rf = {"event"}`,
and `gas = {"anomaly", "radiation"}`. Each `field.settings` task has its own `sources`
list. For example, change recovery to use both existing survey families:

```lua
recovery = {sources = {"gas", "rf"}, cargo = "job_recovery_case", searchRadius = 384},
```

Lists can combine raw sources and pool aliases. Collection deduplicates positions,
handles missing providers/maps and cyclic aliases, and never changes source tables.
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
