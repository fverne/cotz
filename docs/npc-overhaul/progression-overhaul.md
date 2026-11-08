# Town progression overhaul, 8 November 2026

This replaces the former 600-milestone town graph with 639 hand-in milestones across 49 independent
branches, including 223 stock-preparation intermissions. The authored `upgradeChains` and
`regularAmmoChain` in `sh_equipment.lua` retain their exact order. Where one branch combines families, cheaper available items come first without reversing an
authored family. Equipment tier prerequisites can cross sellers; unrelated branches have no shared
introduction or joined ending. The Original and Arena Master retain no finite progression.

## Ownership and starting stock

| Contact | Progression branches | Starting sale stock |
| --- | --- | --- |
| Atlas | Binoculars; Geiger counter/GPS; anomaly detector; headlamp | Flashlight, compass |
| Ballast | Swamps hideout improvements | Buys all at 0.3 |
| Gasket | Sidearms; strong alcohol | Nagant, Contender, M1917, Ruger Mk III; .22, 7.62x25, 9x18, .45 ACP |
| Haggler | Pact CQB/shotguns | .22, 7.62x25, 9x18, 9x19, .45 ACP, .410; tanker helmet |
| Jitters | Separate medkit, bandage, antirad, antipsychotic, psy-healing and stimpak branches | Basic bandages and medkits |
| Mute | STALKERnet, including emission warnings and event broadcasts | None |
| Old Timer | Knives; melee in groups of 2/2/3; high-tier cooker; hidestashers | Lead pipe, low-tier cooker, charcoal |
| Spicy Lemon | Weak drugs/nicotine; beer; energy drinks | Corn, beans, chili beans; cheapest vodka, cigarettes and energy drink |
| Technut | Ordinary, Clear Sky and military suits; painting | Anorak, cloth mask |
| Brass | Regular ammunition; HP exchanges; TR/DT/MG shotgun loads | Basic gun ammunition, buckshot and slugs |
| Cleaner | Garbage hideout improvements | Buys all at 0.3 |
| Latch | Gasmasks and middle-tier headwear | None |
| Spool | Steel/riot headwear; strong drugs | None |
| Spoor | Slow-firing rifles | Sako .22 and Winchester .22 |
| Vesper | Pact rifles | None |
| Wake | Backpacks; carried weight; inventory rows | Basic bandages and medkits |
| Boss | Higher-tier helmets | None |
| Carbon | AP exchanges | None |
| Ledger | Waystation hideout improvements | Buys all at 0.3 |
| Quartermaster | NATO rifles | US MRE, canned water, basic antirad/bandages/medkits |
| Smartass | NATO CQB/shotguns; bunker then laboratory access cards | None |
| Suture | Suit attachments; suit variant conversion unlocks | Conversion menu |
| Beanstalk | Suppressors; red dots; optics | None |
| Egghead | SSP-99, SSP-99M, SEVA | Ukrainian/Russian MREs, canned water, basic antirad/bandages/medkits |
| Intern | Echo, Bear, Veles artifact detectors | None |

Latch sells the full authored mask chain and operator-Russian-2/CS1/CS2 headwear. Spool sells the tanker,
three steel helmets and riot helmet; Haggler's tanker starter is an intentional duplicate. Boss owns
the remainder of the helmet chain. All four trenchcoat colours share Technut's black-trenchcoat step.

Weak drugs include cigarettes, tobacco, cigars, mints, codeine and caffeine. Spool's strong-drug branch
contains adrenaline, morphine, marijuana, glucose, cocaine and swampbrew. Gasket owns moonshine, vodka,
wine and spirits; the cheapest vodka also remains a Spicy Lemon starter.

## Unlocks, exchanges and retained assets

Town requirements contain only valuables and artifacts, validated through item inheritance and actual
checked-in world/box/cycling acquisition sources. Currency and bound quest assets are excluded.
Scientists retain artifact deliveries at equipment milestones; their preparation stages request ordinary
research and technical valuables. Garbage introductions borrow locally available textiles, workshop
supplies, trail supplies and military salvage. Later stages can recover their specialist themes.
Other contacts' thematic pools are shared as appropriate, with disjoint slots and varied consecutive requests.

Original equipment rank determines regional access, using `(index - 1) / (branch length - 1)`:

| Branch position | Eligible acquisition maps |
| --- | --- |
| First milestone, or a single-step branch | Contact's home map only |
| After introduction, below 45% | Home map, Marsh and Garbage |
| 45% to below 75% | Also Waystation |
| 75% onward | Also Pripyat |

The home map always remains eligible. Newly regional goods enter the lowest-quantity slots: at most one
expanded slot before the final quarter and two afterward. Other slots remain local. Intermissions inherit
the following original milestone's rank and maps; extra graph depth never accelerates this ramp.
Main deliveries retain their base quantities `1`, `2/1`, `3/2/1` or `4/3/2/1`. Contact difficulty applies
once, rounding upward; Ledger uses 3×. Branches are optional, so the catalogue total is not one playthrough.

From the third original unlock onward, stock preparation precedes repeated requirement patterns and
three-/four-slot requests where the previous milestone has eligible shop stock. Intern, Egghead and
Beanstalk have preparation between every equipment tier. A preparation delivery requests half the next
milestone's base units, rounded upward with minimum one, before applying contact difficulty once.
Its reward increases personal capacity for the previous purchase group, including grouped equipment.
Highest-earned bonuses apply once, up to +4 total; current stock, refill interval and amount stay unchanged.
Existing single-item `stock.item` definitions and grouped `stock.items` are both supported.
Mute's cash-only directory maintenance is removed; location tracking now leads directly to the dossier.

Finite progression has no flat completion cash. Accepted hand-ins accrue the existing 60% valuation,
including instance pricing and the existing vendor valuation rules. Cash is rounded upward once at
completion; partial deliveries pay nothing. Reputation remains unchanged. No item gifts are awarded,
and town completion does not trigger ordinary job restocking. Repeatable job rewards and standalone
progression requirements are unchanged.

Brass's matching regular milestone makes HP progression eligible; completing its HP milestone enables
the 2:1 exchange and makes Carbon's matching AP progression eligible. Completing AP enables a 3:1
exchange. Both exchanges consume regular ammunition, measured in standard-box round equivalents;
partial stacks can be combined. HP/AP cash sales are removed. Debit credit survives failed removals,
and paid outputs use the existing stored-reward queue, including full-inventory and asynchronous
delivery recovery. Collect pending outputs through stored rewards after making room.

Suture's menu starts available. A base-suit unlock and Suture's matching conversion milestone are both
required; that milestone covers all its non-looted finishes. Suits with no alternate finishes have no
empty conversion milestone. Conversions preserve the existing fee, ownership, attachment and condition rules.
Technut retains paid painting behind his own hand-in milestone. Bank/Computer progression access,
town service credit and town repair/treatment discounts are retired; ordinary paid repair/treatment remain.
Computer is no longer gated by an obsolete Intern milestone. Existing bank data is retained.

Wake supplies the existing total limits of +5 kg and +2 inventory rows through separate branches.
Ballast/Cleaner/Ledger each have twelve local hideout stages, enabling the existing twelve storage tiers.
The two +2 floor allowances require stages 2 and 4; furnishings require stage 3. Purchases still cost
their configured roubles/items. Saved paid levels, receipts, inventory dimensions and contents remain.

`ij600`, `lax410` and `ruger1022` await later starter allocation. Music awaits later acquisition.
Sharpening stones and cutlery remain job rewards without progression sales. All eight canned foods are
Spicy Lemon job and bonus candidates. His three canned starters remain saleable. Meals and raw meat
cannot be bought from ordinary NPC vendors; cooking, hunting and job hand-ins remain available.
Rare/reserved equipment retains its existing non-purchase policy.

## Saves, tooling and verification

Current IDs remain `cotz/town/<contact>/v3/<branch>/<entry>`. New intermissions append `/stock`
to the following unlock's ID. Existing completions, owned items, ordinary jobs and paid hideout assets
remain saved. New intermissions gate unfinished unlocks, including requests with partial contributions;
completed purchases are not revoked. When an intermission's parents were completed before deployment,
character initialization activates it without completing it or awarding any benefit automatically.

Requirement policy 3 converts only outstanding ineligible or out-of-region saved inputs. Eligible saved
requests retain their exact items and quantities. Completed contributions remain credited; converted
remaining units and their replacement are saved in `requirementConversions`, so reconnects cannot reroll
or repeat the operation. Completed requests are untouched. Recorded unpaid monetary/reputation credit
is preserved; suppressed historical cash is not retrospectively reconstructed. Paid rewards never replay.
Old pre-v3 completion IDs and retired commission journals remain inactive history.

Deploy every map server together and restart without resetting saves or rerunning first-time setup.

The ammo report tool now reads the authored chain and only writes its report. It cannot rewrite
equipment or seller allocations. The legacy FTS delivery writer rejects branch definitions before
writing anything; use its `--inspect` mode for availability and edit branch requirements directly.
The [unlock ledger](unlock-ledger.md) and [ammo report](ammo-progression.md) describe current definitions.
Older story/contact documents and earlier runtime notes are historical where they conflict with this guide.

Run the town/progression, ammo exchange, vendor plan, regional jobs, task rewards, dialogue, acquisition
and report checks. Multiplayer verification must cover discovery, fresh/existing character gates,
painting/conversions, barter with partial stacks/full inventories, saved vendor refresh and paid hideout
upgrades. Standalone mocks do not verify live MySQL callbacks, map transfers or client presentation.

## Authoring and regression checks

`python3 docs/npc-overhaul/tools/expand_progression.py --write` reproduces the expanded definitions and
source-audited pools. `--check` verifies them without writing. Candidate/source changes affect new
assignments; bump the saved requirement policy deliberately only when another conversion is intended.
The offline JSON snapshot preserves sparse vendor terms and numeric object keys.

Regenerate the reward ledger with `progression_rewards.py --write`; check it with `--check`.
Run `python3 tests/progression_expansion_spec.py` and
`luatex --luaonly tests/progression_expansion_spec.lua` alongside the existing progression, town,
stock/vendor, ammunition exchange, task-reward and report suites. Real multiplayer/MySQL recovery,
map transfers, shop refresh and acquisition timing still need live verification.
