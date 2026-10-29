## Task rewards and existing kits

Jobsystem owns repeatable job rewards, previews, acceptance, item delivery
and automatic supply-claim continuation. Its post-data-load hook validates task rewards. The `ix.taskRewards` API and saved character
keys remain unchanged. Progression owns story milestones and their completion payouts.
Jobsystem uses progression's purchase unlock checks and token-backed reward-claim service.

`libs/sh_taskrewards.lua` defines contact profiles, nominal-value budgeting and visible
packages. `libs/sv_taskrewards.lua` persists offers and transfers selected rewards into
the existing token-backed claim queue. Dialogue's `libs/sh_taskrewards.lua` installs
"Choose or claim task rewards", and an
authoritative task preview. Contacts without a work topic retain the main-menu entry.
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
or suits. A supply allowance is 100% of the task's fixed reference cash payment, with a minimum
of 600 rubles even for easy tasks; quantities
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

Contact profiles and earned vendor supply unlocks determine eligible ammunition,
consumables, stash containers and protective attachments. Bonus catalogues refresh when
the rewards menu opens, respecting new unlocks without changing the earned budget.
Unlocks never multiply the payment for identical work. Preview packages are saved and
stable; already accepted jobs retain their assigned rewards. Cached unaccepted previews receive
the increased allowance when reopened, preserving the task identity and requirements. Abandonment grants neither
bonus progress nor payment. Finite story/progression tasks do not count toward the bonus.

Delivery cash is 55% of the required hand-in value, using the higher of catalogue value
and configured/live trader sale quotes, multiplied by the actual requested count.
Stackable requirements are priced per consumed use; ammunition boxes without `quantity`
count as whole inventory items. Actual specimen quality/value is recorded before
consumption. Non-delivery jobs pay 55% of their configured midpoint cash plus half the
supply expected value. Both components are scaled together.
A base Swamp Controller hand (catalogue value 6,700) pays 3,685 rubles from its repeatable
job, plus its chosen supply package; progression credit for that hand is 4,355 rubles.
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

Legacy global partial progress is preserved at the most recently credited trader, using
the greatest saved completion serial. Its earlier trader attribution cannot be recovered.
Existing earned bonus offers retain their original trader and value. New progress is
stored per trader under `taskCompletionBonus.traders`; `BonusStatus` calls the displayed
amount "Bonus value earned" rather than "Banked" to distinguish it from spendable cash.
