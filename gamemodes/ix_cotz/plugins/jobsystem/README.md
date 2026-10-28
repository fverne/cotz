## Task rewards and existing kits

Jobsystem owns repeatable job rewards, previews, acceptance, item delivery
and automatic supply-claim continuation. Its post-data-load hook validates task rewards. The `ix.taskRewards` API and saved character
keys remain unchanged. Progression owns story milestones and their completion payouts.
Jobsystem uses progression's purchase unlock checks and token-backed reward-claim service.

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
use contact profiles and job tier.
Uses/rounds range from 25–60% of normal capacity at tier 1, increasing by 10 percentage
points per tier, capped at normal capacity (minimum one use/round). Equipment starts at
30–60% durability and wear condition, increasing by 10 points per tier up to tier 5.
Unlocked provider equipment is eligible up to catalogue prices of 2,500 / 7,500 / 15,000 /
30,000 / 50,000 rubles by tier. These settings live beside `BuildJobChoices` in
`libs/sh_taskrewards.lua`; each amount is deterministic for its saved offer.
Delivery cash is 55% of the required hand-in value, using the higher of catalogue value
and configured/live trader sale quotes, multiplied by the actual requested count.
Stackable requirements are priced per consumed use; ammunition boxes without `quantity`
count as whole inventory items. Actual specimen quality/value is recorded before
consumption. Non-delivery jobs pay 55% of their configured midpoint cash plus half the
supply expected value. Both components are scaled together.
A base Swamp Controller hand (catalogue value 6,700) pays 3,685 rubles from its repeatable
job, plus its single supply item; progression credit for that hand is 4,355 rubles.
`JOB_CASH_RATE` configures repeatable payouts in `libs/sh_taskrewards.lua`.
Progression sets `PROGRESSION_CASH_RATE` separately in `../progression/libs/sh_rewards.lua`. Money is paid once on job completion, not during item delivery.
A qualifying completion still earns its existing 20% personal vendor restock exactly once.
Job previews save their cash and supplies when created; reopening and accepting reuse that offer.

Profiles use existing items and provider-specific purchase checks. Task-kit offers
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
