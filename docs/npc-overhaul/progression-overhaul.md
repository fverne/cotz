# Town progression overhaul, 7 November 2026

This replaces the former 600-milestone town graph with 417 hand-in milestones across 49 independent
branches. The author's `upgradeChains` and `regularAmmoChain` in `sh_equipment.lua` retain their exact
order. Where one branch combines families, cheaper available items come first without reversing an
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

Each branch uses the contact's existing thematic requirement pools. Definitions explicitly declare
one to four pools with descending quantities `1`, `2/1`, `3/2/1` or `4/3/2/1` as branch rank increases.
The existing contact effort multiplier applies once, rounding upward. Researcher requirements remain
artifact requests. Completion cash ranges from 450 to 3,000 roubles by branch rank. Item prices,
effects, ammunition pack sizes and repeatable job mechanics are unchanged. Progression gives no item gifts.

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

New IDs use `cotz/town/<contact>/v3/<branch>/<entry>`. Old completions, rolled requirements and partial
hand-ins remain stored as history and do not unlock the new graph. Old commission identities remain
completion-only; their pending journals cannot advance new branches. Money, owned items, ordinary
accepted jobs and paid hideout assets are not reset. Deploy every map server together and restart;
do not rerun first-time setup.

The ammo report tool now reads the authored chain and only writes its report. It cannot rewrite
equipment or seller allocations. The legacy FTS delivery writer rejects branch definitions before
writing anything; use its `--inspect` mode for availability and edit branch requirements directly.
The [unlock ledger](unlock-ledger.md) and [ammo report](ammo-progression.md) describe current definitions.
Older story/contact documents and earlier runtime notes are historical where they conflict with this guide.

Run the town/progression, ammo exchange, vendor plan, regional jobs, task rewards, dialogue, acquisition
and report checks. Multiplayer verification must cover discovery, fresh/existing character gates,
painting/conversions, barter with partial stacks/full inventories, saved vendor refresh and paid hideout
upgrades. Standalone mocks do not verify live MySQL callbacks, map transfers or client presentation.
