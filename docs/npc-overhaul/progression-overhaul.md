# Town progression overhaul, 9 November 2026

This replaces the former 600-milestone town graph with 631 hand-in milestones across 52
branches, including 212 stock-preparation intermissions. The authored `upgradeChains` in
`sh_equipment.lua` now include Cutlery before Cleaning kit; all other equipment and `regularAmmoChain` ordering is retained. Where one branch combines families, cheaper available items come first without reversing an
authored family. Equipment tier prerequisites can cross sellers; unrelated branches have no shared
introduction or joined ending. The Original and Arena Master retain no finite progression.

## Ownership and starting stock

| Contact | Progression branches | Starting sale stock |
| --- | --- | --- |
| Atlas | Binoculars; Geiger counter/GPS; anomaly detector; headlamp | Flashlight, compass |
| Ballast | Initial hideout access, then Swamps hideout improvements | Buys all at 0.3 |
| Gasket | Sidearms; strong alcohol | Nagant, Contender, M1917, Ruger Mk III; .22, 7.62x25, 9x18, .45 ACP |
| Haggler | Pact CQB/shotguns | .22, 7.62x25, 9x18, 9x19, .45 ACP, .410; tanker helmet |
| Jitters | Separate medkit, bandage, antirad, antipsychotic, psy-healing and stimpak branches | Basic bandages and medkits |
| Mute | Regional mutant PDA reports; emission warnings | None |
| Old Timer | Knives; melee in groups of 2/2/3; high-tier cooker; hidestashers | Lead pipe, low-tier cooker, charcoal |
| Spicy Lemon | Weak drugs/nicotine; beer; energy drinks | Corn, beans, chili beans; cheapest vodka, cigarettes and energy drink |
| Technut | Ordinary, Clear Sky and military suits; painting | Anorak, cloth mask |
| Brass | Regular ammunition; HP exchanges; TR/DT/MG shotgun loads | Basic gun ammunition, buckshot and slugs |
| Cleaner | Initial hideout access, then Garbage hideout improvements | Buys all at 0.3 |
| Latch | Gasmasks, matching filters and middle-tier headwear | Cloth mask |
| Spool | Steel/riot headwear; strong drugs | Russian tank helmet |
| Spoor | Slow-firing rifles | Sako .22 and Winchester .22 |
| Vesper | Pact rifles | None |
| Wake | Backpacks; carried weight; inventory rows | Basic bandages and medkits |
| Boss | Higher-tier helmets and matching filters | None |
| Carbon | AP exchanges | None |
| Ledger | Initial hideout access, then Waystation hideout improvements | Buys all at 0.3 |
| Quartermaster | NATO rifles | US MRE, canned water, basic antirad/bandages/medkits |
| Smartass | NATO CQB/shotguns; bunker then laboratory access cards | None |
| Suture | Suit attachments; suit variant conversion unlocks | Conversion menu |
| Beanstalk | Suppressors; red dots; optics | None |
| Egghead | SSP-99, SSP-99M, SEVA | Ukrainian/Russian MREs, canned water, basic antirad/bandages/medkits |
| Intern | Echo, Bear, Veles artifact detectors | None |

Latch starts with the cloth mask and unlocks the remaining mask chain and operator-Russian-2/CS1/CS2 headwear. Spool starts with the Russian tank helmet and unlocks three steel helmets and the riot helmet; Haggler's tanker starter is an intentional duplicate. Boss owns
the remainder of the helmet chain. All four trenchcoat colours share Technut's black-trenchcoat step.

Latch unlocks civilian filters immediately before Halfmask, military before EO-20, and scientific
before M40. Boss unlocks military filters before CS-4 and scientific before Screen. These five
seller-local delivery stages precede the mask purchases and preserve any earlier stock-preparation
requirements. Completed mask permissions remain earned; unfinished mask requests wait for the new
filter stage without losing saved contributions or accrued value. Existing owners can complete the
new filter stages after their old prerequisites, without replaying completed mask requests.
See the [filter purchase details](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md#gasmask-filter-purchases).

Weak drugs include cigarettes, tobacco, cigars, mints, codeine and caffeine. Spool's strong-drug branch
contains adrenaline, morphine, marijuana, glucose, cocaine and swampbrew. Gasket owns moonshine, vodka,
wine and spirits; the cheapest vodka also remains a Spicy Lemon starter.

## Category totals and specific requests

Every town delivery slot declares `mode = "any"` or `mode = "random"` beside its pool and quantity.
`any` accepts a mixture of 3–4 item types selected once from the pool for that character; it never
exposes a large catalogue as the accepted list. `random` chooses one item once per character and
requires that exact item. Other progression definitions retain their
existing behaviour when mode is omitted.

The first `ceil(unlockCount / 5)` milestones in each connected unlock chain use only `any` slots.
Count actual non-intermission milestones; retired entries are excluded. Shared branch labels do not
join independent one-step upgrades: all seven of Wake's capacity purchases remain category-only.
A stock intermission inherits its following unlock's opening classification. All stock intermissions
remain category-wide even later in the chain. After the opening, a normal delivery's last, smallest
slot uses `random`; earlier slots remain `any`. A one-slot delivery therefore becomes a specific-item
request after its opening. Technut's first three of thirteen suit purchases are category-only:
Mail Jacket, the trenchcoat group and Sunrise. Painting is its own category-only one-step branch.

Catalogue pools may overlap, but accepted subsets are partitioned per character: one item can only
contribute to one counter in a request. Assignment allocates the most constrained categories first,
favouring items not needed by another category, then adds a fourth type where the roll and available
candidates permit it. `settings.progressionCategoryChoices = {3, 4}` owns this policy. The three physical
hideout-access hand-ins retain their existing tool choices and one-tool cost.

New category goals require at least the rolled 3–4 supply batches. Whole valuables contribute one
batch each. Quantity-bearing valuables use the minimum natural spawn quantity, including explicit
loot overrides, rather than inventory capacity: three nuts or four bolts contribute one batch.
A category offer containing nuts always contains bolts too; neither appears alone. Other examples
are two capacitors, two 9V batteries or two kerosene units per batch. The generated shared
`ix.progression.requirementBatchSizes` registry records these values. Specific requests multiply their
base amount by the selected item's batch size once; their displayed quantity is the final raw total.
Task text lists per-batch costs, highlights show raw outstanding quantities and incomplete batches
have no hand-in action. Surplus units remain in inventory. Rewards price the actual raw units consumed.

Bulk catalogues favour local sources within the contact's specialty. Related record, tool and packing
pools supply enough local candidates where earlier catalogues contained only one or two types.
Specific pools compare modeled batch-equivalent supply and stay within a threefold frequency range.
Checked-in loose points, boxes and cycling containers provide comparative estimates, not measured
player acquisition times. Scientist equipment retains its artifact families and regional ceilings remain.

Mode version 2 saves accepted subsets and per-item batch costs. Reconnects and later pool/batch edits
do not reroll them. Unfinished older category requests receive a subset once, retaining their canonical
keys, delivered credit and money. Outstanding category goals below three rise to three; fulfilled
categories and completed milestones are not reopened. Previous specific rolls and raw-unit targets
remain intact. Region-policy conversions run before this migration. No database reset or SQL column
change is required.

The server resolves each donated item to exactly one saved counter, consumes only the remaining
quantity and prices the actual item supplied. Dialogue, journal text, search and inventory highlights
read the same saved alternatives. Existing completion, purchase gates and payout handling are reused.

Run `luatex --luaonly tests/progression_subsets_spec.lua`,
`luatex --luaonly tests/progression_requirement_modes_spec.lua` and
`python3 tests/progression_expansion_spec.py`. Regenerate with
`python3 docs/npc-overhaul/tools/expand_progression.py --write`; verify with `--check`.
Restart all map servers together. Multiplayer UI, replication, inventory and database/reconnect
behaviour still need runtime verification; do not rerun first-time setup.

## Unlocks, exchanges and retained assets

Except for the three initial hideout tool hand-ins, town requirements contain only valuables and artifacts,
validated through item inheritance and actual
checked-in world/box/cycling acquisition sources. Currency and bound quest assets are excluded.
Scientists retain artifact deliveries at equipment milestones; their preparation stages request ordinary
research and technical valuables. Garbage introductions use locally available members of each
contact's specialty; later stages add harder regional materials within the same specialty.
Each contact declares `progressionIdentity` beside its progression: a named specialty, explicit core
pools and a small list of related support pools. The generator no longer rotates through every town
theme. All high-quantity slots stay with the contact's core work; only the smallest slot of a three-
or four-slot request may borrow support goods. This keeps at least 75% of requested units within the
core specialty, including preparation stages. Source availability never triggers an unrelated-theme
fallback: missing specialty supplies are an authoring error. Shared items remain appropriate between
related professions; scientist equipment milestones retain their established artifact families.

Examples: Brass requests powder, ammunition cases and weapon-care supplies; Jitters requests clinical,
trauma and medical-equipment salvage; Ledger needs dispatch paperwork and secure cases. Smartass
focuses on computers and data media, Gasket on generator parts and electrics, Spicy Lemon on kitchen
stores and cooking fuel. The [request specialty table](unlock-ledger.md#request-specialties) lists all
25 allocations, whose characterization comes from the existing contact profiles.

Original equipment rank determines regional access, using `(index - 1) / (branch length - 1)`:

| Branch position | Eligible acquisition maps |
| --- | --- |
| First milestone, or a single-step branch | Contact's home map only |
| After introduction, below 45% | Home map, Swamps and Garbage |
| 45% to below 75% | Also Waystation |
| 75% onward | Also Pripyat |

**Swamps exception:** the first two original milestones of every Swamps branch, and all other milestones
below 45%, stay wholly local. This includes preparation stages attached to those milestones. Every
candidate must have a positive checked-in Swamps source; simply retaining Swamps among several possible
maps is insufficient. Short branches cannot make their second request Pripyat-only.

The home map always remains eligible. Newly regional goods enter the lowest-quantity slots: at most one
expanded slot before the final quarter and two afterward. Other slots remain local. Intermissions inherit
the following original milestone's rank and maps; extra graph depth never accelerates this ramp.
Main deliveries retain their base quantities `1`, `2/1`, `3/2/1` or `4/3/2/1`. Contact difficulty applies
once, rounding upward; Ledger uses 3×. Branches are optional, so the catalogue total is not one playthrough.

From the third original unlock onward, stock preparation precedes repeated requirement patterns and
three-/four-slot requests where the previous milestone has eligible shop stock, except at Technut.
Technut's initial anorak stock step and eleven intermediate `/stock` steps are retired. Anoraks remain
starting stock; the Mail Jacket starts the suit chain and each later suit requires its predecessor.
The painting branch, retained suit IDs, request quantities, regional ranks and saved contributions remain.
Retired stock-step records remain saved history. `preserveProgression = true` prevents authoring-tool
regeneration of these intermissions. Intern, Egghead and
Beanstalk have preparation between every equipment tier. A preparation delivery requests half the next
milestone's base units, rounded upward with minimum one, before applying contact difficulty once.
Its reward increases personal capacity for the previous purchase group, including grouped equipment.
Highest-earned bonuses apply once, up to +4 total; current stock, refill interval and amount stay unchanged.
Existing single-item `stock.item` definitions and grouped `stock.items` are both supported.
All scoreboard tools and dossier fields are available immediately, including server-supplied remote records.
Mute's retained `networkSearch`, `networkSquads`, `networkRanking` and `eventBroadcasts` milestone IDs now
unlock mutant spawn PDA reports in Swamps, Garbage, Waystation and Pripyat, respectively. Emission warnings
remain between Waystation and Pripyat reports. The redundant activity, location and dossier milestones are
retired; saved records remain history. Retained milestones keep their delivery terms, assigned items and
completed states, so existing completion grants the corresponding regional report permission.

Jitters' stimpak branch follows `medic_medkit_6`; antirads follow `medic_medkit_2`; Asenapine and Modafines
follow `medic_medkit_4`. Later medicine tiers retain their family prerequisites. Atlas' anomaly detector
follows his Geiger counter. Haggler's three gunpowder/ammunition-kit barters are removed.
Town progression dialogue displays the same assigned items, remaining quantities and rewards as the task journal.

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

Wake's existing +5 kg and +2 inventory rows are optional one-depth side branches at the backpack milestones
below. Each requires only its assigned backpack; all seven can be completed independently of one another.
Later backpacks and their preparation continue along the backpack route. The side branches remain available
for later completion, including when their backpack was completed before this update. Their IDs, contribution
records, hand-in terms and capacity amounts are preserved. Completed purchases and capacity remain earned.

| After backpack | Optional capacity upgrade revealed |
| --- | --- |
| Worn Sportsbag | Carried weight +1 kg (01) |
| School Backpack | Carried weight +1 kg (02) |
| Large Sling Backpack | Inventory +1 row (01) |
| Army Backpack | Carried weight +1 kg (03) |
| Modern Military Backpack (Russian) | Carried weight +1 kg (04) |
| Modern Military Backpack (USA) | Inventory +1 row (02) |
| Large Modern Military Backpack (Russian) | Carried weight +1 kg (05) |

Spool's tank helmet and Latch's cloth mask have no active purchase milestones; both are starting vendor
stock. Retired milestone records remain history. Their successors keep the original delivery terms and
regional tier positions. `preserveProgression = true` on Spool, Latch and Wake tells the expansion tool to
preserve their approved layout, stock stages and quantities. Mode and candidate-pool authoring applies
to every contact, including these protected layouts.
Quartermaster's two gunpowder-for-ammunition-kit barters are removed from the main menu; his six regular
currency-for-ammunition barters remain in his barter submenu. Suture's suit conversion milestones are
labelled with the suit name followed by "variants", including "Anorak variants".
Ballast/Cleaner/Ledger each have twelve local hideout improvement stages, enabling the existing twelve storage tiers.
Each contact additionally requires `v3/hideout/access` before new local room claims and unfinished improvements.
Ballast consumes one unequipped crowbar or bat, at the player's choice; Cleaner consumes one unequipped
sledgehammer and Ledger consumes one unequipped FUBar. Access requirements are not multiplied by contact
difficulty. Ballast's two choices credit one shared requirement; repeated hand-ins cannot consume or pay again.
Existing owned rooms and paid upgrades remain saved and usable without completing the new access step.
The two +2 floor allowances require stages 2 and 4; furnishings require stage 3. Purchases still cost
their configured roubles/items. Saved paid levels, receipts, inventory dimensions and contents remain.

`ij600`, `lax410` and `ruger1022` await later starter allocation. Music awaits later acquisition.
Sharpening stones remain job rewards without progression sales. Old Timer unlocks
Cutlery → Cleaning kit → Shovel; cutlery also remains a job reward. All eight canned foods are
Spicy Lemon job and bonus candidates. His three canned starters remain saleable. Meals and raw meat
cannot be bought from ordinary NPC vendors; cooking, hunting and job hand-ins remain available.
Rare/reserved equipment retains its existing non-purchase policy.

## Saves, tooling and verification

Current IDs remain `cotz/town/<contact>/v3/<branch>/<entry>`. New intermissions append `/stock`
to the following unlock's ID. Existing completions, owned items, ordinary jobs and paid hideout assets
remain saved. New intermissions gate unfinished unlocks, including requests with partial contributions;
completed purchases are not revoked. When an intermission's parents were completed before deployment,
character initialization activates it without completing it or awarding any benefit automatically.

Requirement policy 4 converts only outstanding ineligible or out-of-region saved inputs. It upgrades
policy-3 assignments so that opening Swamps work cannot retain later-map-only demands. Eligible saved
requests retain their exact items and quantities, including locally available requests that predate the
new specialties. Specialties apply to new rolls without rerolling valid saved assignments.
Completed contributions remain credited; converted
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

Each active step owns its authored `briefing` and `completion` in the contact definition, including
stock intermissions. All 631 pairs are individually written against the contact's profile and current
benefits. Stock upgrades raise personal capacity and add the corresponding quantity to current stock; exchange,
conversion, hideout and purchase wording retains the later ammunition costs, fees or purchases.
Keep exact assigned items and quantities in the generated objective display rather than hard-coding
them into speech, since valid saved requests can differ from newly rolled requests.

The expansion tool retains existing stock-step text by stable ID when rebuilding requirements. New
intermissions start with the following unlock's text and need their own replies. Verify all 631 pairs
and their compiled fields with `luatex --luaonly tests/progression_dialogue_spec.lua`; the Python
expansion suite also checks that regeneration preserves distinct stock conversations. Editorial review
of voice, continuity and promises is still required; uniqueness checks cannot assess writing quality.

`python3 docs/npc-overhaul/tools/expand_progression.py --write` reproduces the expanded definitions and
source-audited pools. `--check` verifies them without writing. Candidate/source changes affect new
assignments; bump the saved requirement policy deliberately only when another conversion is intended.
The offline JSON snapshot preserves sparse vendor terms and numeric object keys.

Regenerate the reward ledger with `progression_rewards.py --write`; check it with `--check`.
Run `python3 tests/progression_expansion_spec.py` and
`luatex --luaonly tests/progression_expansion_spec.lua` alongside the existing progression, town,
stock/vendor, ammunition exchange, task-reward and report suites. Real multiplayer/MySQL recovery,
map transfers, shop refresh and acquisition timing still need live verification.
