# Personal character progression

Progression belongs to a Helix **character**, including other characters on the same
account. All delivery steps use saved personal requirements. Bulk hand-ins
are reduced; fixed story keys keep their single-item requirements. The story
job-completion progressions use the same increasing effort curve as deliveries. NPC arrivals remain
persistent global unlocks triggered by the first character to complete their milestone.

## Expanded progression

There are now **227 definitions** across all 19 NPC templates: 219 deliveries and eight numeric programmes. The expansion splits 55 original delivery milestones into 64 extra stages and adds 21 optional deliveries plus three arena programmes. No new item definitions or backpack acquisition changes are included.

`milestoneGroup`, `stageIndex` and `stageCount` keep split deliveries within their original total quantities. All stages receive persistent assignments together when the programme becomes available, but dialogue shows only the current stage's requirements. Completing a stage activates its successor immediately; reopen the progression list to view it. Only the active stage accepts hand-ins. Shared candidate pools keep the same personal candidate across a programme, and money/reputation rewards use cumulative rounding without selectable supplies.

The original completion IDs retain story effects, NPC arrivals and final outgoing links. Scientist access still requires the post-map-2 story milestone even though scientists live in Marsh. Quartermaster retains his flashdrive introduction without Haggler prerequisites. Numeric programmes have cumulative checkpoints: Boss 1/4 jobs, Smartass 1/3/5, Intern 2/6/11/17 and Computer 3/8/14. Their final totals have not increased. Intern still performs Pripyat surveys and claims work in Marsh.

Selected supply milestones declare `stockUnlocks` containing a contact, item whitelist and cumulative bonus. The greatest completed applicable bonus wins; alternate branches cannot stack it. Personal maxima are sent only to that shopper, with base catalogue settings left intact. Earning capacity does not fill shelves or change passive refill intervals. Common ammunition and provisions reach six stock, Jitters' ordinary clinical supplies reach five, and selected other supplies receive one extra reserve.

Qualifying jobs and completed logical delivery milestones replenish 20% of each eligible unlocked item's effective personal capacity. Fractional credit persists and is shown in the shop, capped at full shelves. Preparation stages do not each grant another restock. Job serials and milestone claim markers prevent duplicate replenishment. Quest/access items, buy-only/infinite stock, disabled restock and community deposits are excluded.

Checkpoint and arena item rewards remain pending if the inventory is full. Helix's asynchronous inventory confirmation clears a tokenised claim; restored claims recognise an already inserted item before attempting another grant. Arena progression credits distinct human opponents only, with no credit for disconnects, timeouts or repeated opponents.

Existing version-three completed milestones retain all split purchase access. Existing saved original assignments follow their original requirements and suppress replacement preparation stages; they are not rerolled. Other database versions still require the planned fresh-start handling described below.

NPC-specific conversation text is in `plugins/dialogue/dialogue/sh_*.lua`. Original progression request text and completion announcements remain in the NPC progression files. Added stages live alongside the respective NPC’s original definitions in `sh_*prog.lua`, with shared requirement/reward rendering in `libs/sh_expansion.lua`. Shared dialogue ordering keeps GOODBYE last and main menus consistent across contacts.

Validation:

```bash
luatex --luaonly tests/progression_spec.lua
luatex --luaonly tests/vendor_stock_spec.lua
luatex --luaonly tests/progression_services_spec.lua
luatex --luaonly tests/dialogue_order_spec.lua
luatex --luaonly tests/dialogue_order_spec.lua
/tmp/cotz-balance-venv/bin/python -m unittest discover -s docs/balance/tests -v
```

The sections below describe the underlying assignment, storage and stock systems. The expansion rules above supersede historical counts and the former per-edge quantity tuning.

## Personal delivery assignments

A delivery definition contains `requirementSlots`. Each slot names a curated pool
and a positive integer `quantity`. When the step becomes active and its NPC is
personally unlocked, the server selects one candidate per slot and requests exactly
that slot's quantity.

Delivery and job requirements follow a source-based effort curve. Original logical milestones
use the 25% modeled effort growth policy; inserted stages share their original milestone
budget rather than multiplying that growth. Optional commissions use explicit independent budgets.
Map difficulty, normalized loot odds, spawned yields, poaching odds and mutant combat
danger inform quantities. Plentiful supplies need more units than rare trophies.
Counts are raw quantity units. Story access keys remain single-item requests.
The model is an offline tuning tool; runtime definitions contain literal quantities.
See the [model and assumptions](../../../../docs/balance/progression/README.md#quantity-and-effort-decisions)
and [per-step estimates](../../../../docs/balance/progression/pacing.md).

World loot tables come in map pairs: 1/2 are Marsh ordinary/hard-to-find loot,
3/4 are Waystation, and 5/6 are Pripyat. Definitions declare a `lootMapTier`
ceiling for curation and documentation. Opening low-tier branches and the Marsh
story deliveries use local pools; later branches can introduce later-map hardware.
Regression checks compare every candidate's earliest active worldspawn map against
the ceiling. Non-world rewards, harvesting and vendors need their own availability
review; they do not imply a worldspawn route. See the balance rationale for the
exact branch policy and map table.

The server saves the chosen item IDs, quantities, slot selections, and assignment
version in the character's progression line. Clients read those saved requirements;
they never roll their own. Reopening dialogue, reconnecting, changing characters,
restarting, transferring servers, or changing pool definitions cannot reroll an
existing assignment. Every uncompleted step receives its assignment at most once.

There are 627 slots across the 219 deliveries and 85 pools covering 223 item IDs.
Optional quest lines start at one requirement and grow towards eight as their
successor depth increases. Haggler and Quartermaster share one difficulty range:
Haggler uses one slot at depths 0–1, two at depths 2–3, and three from depth 4
onward; Quartermaster's gear branches continue with four at their roots and add
one per successor depth, reaching eight. Shorter branches can finish below the
maximum. Story deliveries use explicit pacing; access keys remain single-item
requests. Detector3 retains its six anomaly categories and adds two document slots.

Related categories share candidates across
the catalog, while slots used together in one delivery remain disjoint. Pools
with multiple candidates spread demand across characters; they
do not guarantee different rolls for every pair of characters. Deliberate single-item
exceptions include story keys, specialty tools, and items without a comparable
substitute. Each exception and its rationale is visible in the workbook.

Artifact categories describe acquisition sources rather than mandatory travel checks.
Caches and trading remain valid ways to obtain the assigned items. Existing saved
assignments keep their original quantities; newly assigned steps use the new tuning.

Dialogue descriptions, available hand-in options, the progression help menu,
inventory highlights, and server validation all use the same character-aware
requirements query. Another pool member is not accepted unless it was assigned to
that character. Hand-ins consume only the remaining required quantity; excess
stack units stay in the inventory. Completed requirements cannot be submitted again.

Delivery rewards are paid once, when all requirements of the progression task are
fulfilled. Partial hand-ins only save credit; they give no currency, reputation or
items. Currency is 65% of hand-in value. Repeatable delivery jobs pay 55%.
Catalogue value, trader overrides and specimen quality are respected. Legacy cash and
supply-value bonuses do not raise either delivery rate.
Ammunition is priced per consumed round. Credit accumulates without rounding; completion
rounds cash up once and deducts amounts already paid. Reputation is twice
the previous formula: `2 * (5 + (fullStackValue * 0.1)^0.25)` per full stack, scaled
by the fraction consumed. Both totals accumulate before rounding at completion, so
splitting a delivery into multiple requests cannot multiply rewards.

Progression tasks pay their existing money and reputation automatically on completion.
They do not create selectable supply offers. Singleton and multi-item pools use the same
cash rate. Authored commissions retain their fixed supplies,
services and progression unlocks; these do not offer a player-selected reward.
Obsolete progression supply offers are retired on character load without replaying payouts.
Previously queued fixed rewards remain claimable through their progression task dialogue.

Existing partial-task cash credit is repriced from saved contributions at the new rate on
the next hand-in. When contribution quantities are unavailable, prior credit is scaled by
the change in rates. Reputation credit from version two onward is preserved; older
reputation credit retains its original migration.
Previously paid amounts are deducted from the final payout, with a minimum of zero;
money already paid is never reclaimed. Completed tasks are not paid again.
Completion callbacks and successor activation retain their existing behavior and
run once.

## Progression overview workbook

See the [balancing workbook guide](../../../../docs/balance/README.md#reviewing-current-progression)
for setup, then export from the repository root:

```bash
/tmp/cotz-balance-venv/bin/python docs/balance/balance.py export
```

The result is `docs/balance/output/balance.xlsx`; GitHub's export workflow also
includes it in its downloadable artifact. The read-only progression views show:

- NPC summaries and all 227 steps, including incoming/outgoing chain links.
- Candidate hand-ins grouped by slot. Rows in one slot are alternatives, not a combined shopping list.
- Personal service/vendor unlocks and the four global NPC arrivals.
- Potential item demand, pool candidates, quantity multipliers, and rarity rationale.
- Before/after requirements for every delivery, including all single-item exceptions.
- Acquisition evidence from weighted loot, spawned quantities, poaching, cooking, and anomaly tiers.

The workbook describes possible assignments, not live character assignments.
Acquisition probabilities are conditional on the listed source, not an overall
per-map drop rate. Map spawn-point configuration and mutant encounter frequency
are not available from these definitions and require server playtesting. See the
[balance rationale](../../../../docs/balance/progression/README.md).

## Authored rewards and services

Added stage briefings and completion messages live in the respective NPC’s `sh_*prog.lua` file. Quartermaster’s optional attachment branch is in `sh_quarterprog.lua`; scientific briefs are in `sh_eggheadprog.lua`. See the [dialogue source guide](../../../../docs/balance/progression/dialogue-guide.md).

Definitions may declare `completionBenefits` (fixed `items` and/or provider-bound `services`), `checkpointBenefits`, `checkpointMessages`, `serviceDiscounts` and `recognition`. Fixed completion benefits accompany the progression cash premium and existing reputation. Numeric checkpoints do not duplicate the ordinary job payout. Recognition appears in personal progression help. Service discounts use the greatest earned fraction, capped at 15%; they never stack or alter item prices.

`libs/sh_services.lua` quotes repairs, treatment, storage expansion and wishes from authoritative state. Per-player confirmation quotes bind the character, NPC and owned item, expire after 60 seconds, and cannot be replayed. Execution recomputes price and rejects an increased fee. Credits offset only a positive charge at the named service/provider, preserve ordinary access restrictions and never produce cash. The shared service path is used by Technut, Boss, Jitters, Arena Master, Cleaner and ???.

The implemented reward allocations are listed in the [expansion specification](../../../../docs/balance/progression/expansion-plan.md#completed-reward-and-service-allocation). Existing completed tasks and administrative grants never replay one-time supplies or service credits. Their permanent purchase/stock/discount access remains available.

## Fresh-start storage and server transfers

This release targets the planned database and server-data wipe. Versions older than three have no migration or legacy completion import. Existing version-three assignments and completions retain the compatibility described above. Character records use
`progression = {version = 3, lines = {...}}`; records from older versions are rejected.
New characters start without contributions or completed milestones. Their initially
active, accessible delivery steps receive and save personal assignments.

Helix replicates progression data only to its owner and saves it with the character.
Assignments, hand-ins, and numeric updates save the character. All participating
servers must share the character database/schema and this addon version. The
cross-server transfer path saves characters before redirecting them. Progression
no longer uses `<map>_progression` records in `ix_xserverdata`.

Plugin data stores `{version = 3, worldUnlocks = {...}}` for global NPC arrivals.
It does not seed a character's personal milestones.

## Personal vendor stock

One character's purchases never deplete another character's supply, including
characters on the same account. `Progression unlocks` labels vendor entries
`Personal access and stock` and shows the initial stock, maximum stock, restock
amount, and interval. Counts are absolute; the old `VendorStockMult` setting no
longer applies. These are catalog settings, not live remaining stock. Vendor money
remains shared.

Purchasable defaults and progression unlocks use these limits:

- Ammunition, food, cooked meals, water, and tea: maximum 4.
- Bandages, medkits, and anti-radiation medicine: maximum 3.
- Other consumables (including specialty medicine, alcohol, and fuel): maximum 2.
- Equipment, weapons, armor, attachments, and reusable tools: maximum 1.

Consumables replenish one item every 12 real hours; equipment replenishes one
every 48 real hours. Initial catalog stock starts at the maximum. Loading saved
vendors applies these defaults and clamps existing personal stock on access without
resetting depleted stock. Buy-only entries and player-deposited Sherpa goods are
excluded. Admins can still override stock settings after loading.

Personal stock is stored server-side under `vendorStock`, keyed by map plus NPC
display name. Respawning the same NPC does not reset it. NPCs with the same name
on the same map use the same stock identity for a character; renaming an NPC creates
a different identity. Purchases and sherpa stock changes save the character and
send stock updates only to that shopper. Changing characters closes the shop.

Elapsed restocks, including time offline, are calculated when opening the shop or
checking stock for a trade and are capped at the configured maximum. Zero interval
or amount disables refilling. Full shelves do not bank restock time: the first
purchase from a full shelf starts a complete interval. Admin stock edits
change catalog defaults, not every character's remaining count. Shoppers receive complete updated catalogue policies when progression unlocks an item in an open shop.

## Global NPC arrivals and administration

The four progression NPC arrivals unlock globally on first completion and are placed
once on their configured map after saved vendors load. Their arrival flags survive
restarts. Characters without the personal milestone receive limited dialogue;
full dialogue, trade, and barter require their own unlock. Faction and class
restrictions still apply.

`/ProgressionAudit` validates all registered requirements, live item/reward IDs, service benefits, catalogue thresholds and graph dependencies. It also runs during server data setup.

`/ProgressionGrant <character> <progressionID>` marks a milestone complete, activates
its successors, assigns newly accessible deliveries, and unlocks any associated
NPC arrival. It does not replay turn-in rewards or GPDA completion broadcasts.
Completion broadcasts include the finishing character's name alongside the NPC's message.

## Integration API

Queries and mutations require an explicit character:

```lua
ix.progression.IsActive(character, progressionID)
ix.progression.IsCompleted(character, progressionID)
ix.progression.GetLine(character, progressionID)
ix.progression.GetRequirements(character, progressionID)
ix.progression.GetNeededItems(character)
ix.progression.GetActiveProgressions(character, npcName)
ix.progression.AddProgressionValue(character, progressionID, amount)
ix.progression.TurnIn(client, vendorEntity, progressionID, itemID)
```

`GetRequirements` returns a snapshot of the saved item-to-quantity map. On the server,
it ensures an active step has an assignment before returning it. On clients, it only
reads replicated data. `GetComplexProgressionReqs` aliases this character-aware API.
`GetItemIds` is no longer used. `GetNeededItems` returns outstanding assigned quantities
for inventory highlighting.

Definitions use `requirementSlots`, `OnComplete(character)`, `nextProgressions`, and
`vendorUnlocks`. Pools live in `sh_requirementpools.lua`; each candidate has an `item` ID.
Slots define positive integer `quantity` values. Numeric definitions use scaled ordered thresholds and
`OnRun(self, character)`. `BuildResponse(npcName, status, character)` receives the
selected character so it can describe the actual saved request.

## Validation

From the addon root:

```bash
luatex --luaonly tests/progression_spec.lua
luatex --luaonly tests/vendor_stock_spec.lua
luatex --luaonly tests/progression_services_spec.lua
luatex --luaonly tests/dialogue_order_spec.lua
/tmp/cotz-balance-venv/bin/python -m unittest discover -s docs/balance/tests -v
```

Tests cover all definitions, persistent assignments, alternate pool selections,
server rejection of unassigned items, the real dialogue producer/UI/consumer path,
partial stacks, reward splitting, one-time completion, personal stock, source
acquisition evidence, and workbook import isolation.

Before rollout, playtest early, middle, and late branches with multiple clients.
Compare assignment difficulty and availability on each configured map. Check that
reconnects, character switches, restarts, and transfers preserve assignments and stock,
and that global NPC arrivals never grant another character's personal access.

## Task rewards and existing kits

`libs/sh_taskrewards.lua` defines contact profiles, nominal-value budgeting and visible
packages. `libs/sv_taskrewards.lua` persists offers and transfers selected rewards into
the existing token-backed claim queue. Dialogue's `libs/sh_taskrewards.lua` installs
"Choose or claim task supplies" (currently hidden by `SHOW_TASK_SUPPLIES = false`), and an
authoritative task preview. Contacts without a work topic retain the main-menu entry.
Saved supplies keep "About work" accessible even after the active job is finished.
That menu lists repeatable job offers. Progression tasks pay money and reputation
through their own completion flow, without selectable supply rewards. Existing kit and
barter exchanges remain available through the supplies menu.

Medium repeatable tasks require 250 reputation; hard tasks require 1,600. Easy tasks
have no reputation gate. Preview generation and acceptance both enforce the requirements,
including when reputation changes after a preview was saved. Locked categories are hidden.

The work menu shows a concrete saved offer from each configured unlocked easy/medium/hard category,
with the exact task count, cash and one server-selected random supply in its label.
The confirmation dialogue states both the cash and the assigned supply. Reputation amounts
and vendor-restock details are omitted. Reopening the task preserves the supply assignment. Acceptance reserves the revealed supply without a
player-selected index. Reputation amounts remain hidden in confirmation. Declining
returns to the main dialogue and keeps the conversation open. Supplies can still be
changed under "About work" after acceptance.
Unaccepted previews stay hidden from the separate supplies menu and cannot be reserved
through its selection endpoint.
Each job supply choice delivers exactly one inventory item. Job supplies
use contact profiles and job tier; legacy `rewardCount` remains ignored.
Uses/rounds range from 25–60% of normal capacity at tier 1, increasing by 10 percentage
points per tier, capped at normal capacity (minimum one use/round). Equipment starts at
30–60% durability and wear condition, increasing by 10 points per tier up to tier 5.
Unlocked provider equipment is eligible up to catalogue prices of 2,500 / 7,500 / 15,000 /
30,000 / 50,000 rubles by tier. These settings live beside `BuildJobChoices` in
`libs/sh_taskrewards.lua`; each amount is deterministic for its saved offer.
Previously prepared job offers are replaced with single-item choices and their selection
is cleared so the player can review the new supplies. Earned status and task progress
are preserved; old offers without a stored tier use tier 1. Already delivered items and
rewards already transferred to the claim queue are unchanged.
Delivery cash is 55% of the required hand-in value, using the higher of catalogue value
and configured/live trader sale quotes, multiplied by the actual requested count.
Stackable requirements are priced per consumed use; ammunition boxes without `quantity`
count as whole inventory items. Actual specimen quality/value is recorded before
consumption. Non-delivery jobs pay 55% of their original midpoint cash plus half the old
supply expected value. Both components are scaled together.
A base Swamp Controller hand (catalogue value 6,700) pays 3,685 rubles from its repeatable
job, plus its single supply item; progression credit for that hand is 4,355 rubles.
Existing jobs and previews receive the reduced cash rate once, replacing older higher
quotes. `JOB_CASH_RATE` and `PROGRESSION_CASH_RATE` configure the rates in
`libs/sh_taskrewards.lua`. Money is paid once on job completion, not during item delivery.
A qualifying completion still earns its existing 20% personal vendor restock exactly once.
Already-active jobs receive saved choices on character load without changing their work.

Profiles use existing items and provider-specific purchase checks. Legacy-kit offers
retain nominal-value budgeting. Higher-value offers of those types may
include an already-authorised weapon or body armour from that provider, worth at least
60% of the offer budget. Quantities are explicit; indivisible value and the package-size
limit settle into a visible ruble remainder. Offers stay within one ruble of their nominal
budget. Task variety and personal assignments provide variation without hidden jackpots.
This preserves nominal catalogue value, not identical vendor resale proceeds or equipment
utility; balancing still requires live playtesting.

The paid upgrade dialogue is removed. Recognised task-kit types, including shared ammo/
aid kit types used by jobs, redeem at contacts for visible choices with no fee. These types
redeem deterministically regardless of where an old instance was found; unrelated starter,
medical and world kits keep their opening behaviour. Existing kit definitions remain for
saved-instance compatibility. Legacy tier-8 weapon pools were disabled and used the old
random-item default fallback; redemption values that same default pool. The removed codeine
reference values the existing painkiller equivalent. No new item definitions are introduced.

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
