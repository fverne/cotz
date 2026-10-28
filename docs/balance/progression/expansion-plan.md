# Expanded NPC progression and reward allocation

Implementation specification, 27 October 2026. The progression expansion and personal stock rewards are implemented; live-server playtesting remains required. Backpack acquisition changes were withdrawn and removed.

## Implemented result

The runtime now has 227 definitions across all 19 NPC templates: 219 deliveries and eight numeric programmes. Fifty-five original delivery milestones are split into 64 additional stages; 21 optional deliveries and three arena programmes cover contacts with little or no prior progression. Job programmes retain their original final completion counts and add intermediate checkpoints.

All original delivery quantities are preserved across each logical milestone, and original purchase unlocks are retained. Indivisible requests stay together where another split would add acquisition cost; this includes the first mask pair, while the two-unit melee request uses two stages. Radiation headgear precedes the radiation suit so the more valuable suit retains the final field proof. Original NPC-specific task descriptions are preserved. Every added stage has an authored contact-specific briefing and completion message; the shared renderer adds saved requirements, programme previews and declared benefits. Egghead’s placeholder requests are also replaced.

Programme assignments are rolled and saved for all stages when the programme opens. Later requirements are previewed so extra stages do not force blind repeat expeditions. Inventory highlights and hand-ins still follow the current active stage. Cash and reputation use cumulative programme rounding; one saved supply-choice bonus is earned at the original milestone endpoint.

Menu order is shared across NPCs: trade/barter, services, work, progression, information, then exit. GOODBYE is last even when static and dynamic options are combined. All withdrawn exchange definitions, input pools, selection paths, catalogue restrictions and related tests have been removed; no item base or backpack entity changes are part of this rework.

## Completed reward and service allocation

| Contact | Implemented allocation |
| --- | --- |
| The Original | Three optional survival commissions: food/water, cooking fuel, then advanced bandage/provisions. |
| Hoarder | Four commissions: specialist ammunition, followed by purchase access to SW500, VSSK and Nitro at their existing prices. Rare guns are purchase authorisations, not free gun rewards. |
| Smartass | RF checkpoint ammunition after one job, PSO-1 purchase access after three, original science/bunker access after five. Three optional reconnaissance deliveries unlock existing optics and suppressors after Boss's data programme. |
| Quartermaster | Two optional attachment commissions after the flashdrive and first military requisition: Kobra/foregrip, then Eotech/Aimpoint/Micro T1. No Haggler prerequisite. |
| Boss | First of four data jobs grants 500 repair credit at Technut. The fourth retains the original story effect. |
| Intern | Supplies after 2, 6 and 11 surveys; original laboratory access after 17. |
| Computer | Research medicine after 3 and 8 artifact jobs; original ??? contact after 14. |
| Beanstalk | Optional expedition supplies after his original documents programme; base PP2000 catalogue includes matching 9x19 ammunition. |
| Cleaner | Two optional storage commissions grant 300 then 600 storage-expansion credit; final commission also earns a permanent 5% expansion discount. Original storage access remains separate. |
| Arena Master | Three optional programmes against distinct human opponents: 150 treatment credit, medkit, then recognition and a permanent 10% treatment discount. |
| ??? | Three optional proofs after Computer access: recognition, 25,000 wish credit, then recognition and a permanent 2.5% wish discount. First wish remains free; credit applies only to positive fees. Existing wish magnitudes remain unchanged. |
| Community NPC | Three optional contribution commissions grant provisions, medical supplies and recognition. Shared deposits do not replenish or advance the personal commission automatically. |
| Technut | Existing painting milestone also earns a permanent 5% repair discount. Existing equipment/attachment unlocks are distributed across their split stages. |
| Jitters | Third medical milestone also earns a permanent 5% treatment discount. Split medical unlocks and personal supply capacity remain in place. |
| Old Timer, Haggler, Mute, Spicy Lemon, Egghead | Existing equipment/consumable authorisations split across the approved stages; selected contacts additionally award the whitelisted capacity ranks below. |

Fixed supplies and credits replace the standard supply-choice bonus on the new commissions. They retain the normal 30% consumed-value cash and reputation. Original logical milestones retain their original reward budget and only one final supply-choice bonus, valued against the former random alternative. Cash and reputation round cumulatively across inserted stages.

Credits belong to the character and named provider/service. Credits cannot become cash, bypass service access, exceed the actual fee, or stack discounts. Repair quotes verify item ownership and current condition; storage retains its normal unlock and dimensions; treatment preserves earned maximum health. Confirmation quotes belong to the player, character and NPC, expire after 60 seconds, and are consumed once. A changed fee requires choosing the service again. Newly unlocked items appear in an open shop with their full catalogue policy.

Item rewards that cannot be delivered remain saved claims. Claims carry durable item tokens and are acknowledged after Helix's asynchronous inventory insertion. One claim is attempted at a time; additional rewards are available through “Claim pending reward”. Existing completed milestones and administrative grants do not replay cash, items or service allowances; permanent purchase access, stock ranks and discounts follow earned completion.

Implementation validation covers all 227 definitions, 19 contacts, original effort/quantity preservation, reward item IDs, catalogue thresholds, dependency cycles, duplicate claims, service-price validation, stock protocol updates, and dialogue ordering. `/ProgressionAudit` repeats definition, item and dependency checks against the live server registry. Physical map barriers, live encounter frequency and real multiplayer sessions still require Garry's Mod playtesting; the automated harness does not simulate those.

See the [dialogue source guide](dialogue-guide.md) for the NPC text locations.

## Recommendation

Add intermediate milestones where existing tasks bundle several rewards or jump sharply in requirement breadth. Give contacts with little progression their own short, themed branches. Preserve the current total acquisition effort to reach existing major unlocks as the initial tuning target, while providing useful rewards more often. Do not multiply the existing 25% difficulty growth by every inserted step.

Treat map tier, contact access, equipment power and task difficulty as separate inputs. A Marsh NPC can offer late research after the Waystation story, while ordinary Marsh survival equipment should remain obtainable locally. Additional branches are optional unless explicitly identified as part of an existing story gate.

**Confirmed access constraint:** Intern, Egghead and Beanstalk are physically located on map 1, but their area is inaccessible until after map 2 progression. Their entire catalogue, services, tasks and new preparation stages therefore belong to post-map-2 progression. Returning to map 1 is an intentional part of that progression, not a reason to reset their difficulty to newcomer level. Preserve both the physical access restriction and personal story gates; do not bypass either through remote dialogue, early assignments or relocated rewards.

**Current scope:** defer all proposed new item definitions and mechanics, including the recent cleaning kits, dressings, rations, protective inserts and survey-equipment ideas. Existing item rewards and personal vendor stock-capacity milestones are in scope. Backpack acquisition and item bases remain outside this rework. Any new-item/signature suggestions retained below or in the earlier reward proposal are future possibilities, not dependencies for this rework. Replace their planned stage rewards with existing supplies, stock capacity or an existing service benefit where appropriate.

Use existing items and services first. The implementation below includes explicit catalogue additions, service credits, permanent service discounts and the 20% task restock. New item definitions and signature-item mechanics remain deferred. The contact sections retain the original design rationale; the implemented allocation below is authoritative where they describe alternative reward choices.

## Source audit and current problems

The pre-expansion baseline contains **139 progression definitions: 134 deliveries and five job counters**, owned by 14 NPCs. There are 19 vendor templates in total. Appendix A allocates existing shop unlocks; the contact plans below also cover the five templates without progression.

The audit uses `plugins/progression/sh_*prog.lua`, `sh_definitions.lua`, `libs/sh_progression.lua`, vendor templates, dialogue and the job system, under `gamemodes/ix_cotz/`. Pacing assumptions come from `docs/balance/progression_pacing.py` and the progression balance rationale. No game Lua was executed.

- Old Timer's knife line jumps from one category to five and then eight; Jitters goes 1 → 3 → 6 → 8 in four steps. Egghead's detector line goes 1 → 3 → 8. These are the strongest candidates for intermediate work.
- Old Timer grants five melee weapons at once; Spicy Lemon grants eight food/drink items at once. Medical, scientific and weapon milestones often grant multiple different upgrades together.
- Cleaner has one step; Smartass, Beanstalk and Intern each have one story counter/delivery. The Original, Hoarder, Arena Master, ??? and the community NPC have no progression definitions.
- Haggler and Quartermaster already have 27 and 23 definitions respectively, including story. Expand selected bundles and difficult transitions rather than doubling every weapon branch.
- Generated documents are not fully synchronized with live literals: for example, Cleaner currently requests one common artifact, while the pacing report lists three. Regenerate the audit from live definitions before freezing numeric budgets; do not silently apply the current tuner first.
- Technut's story plate IDs (`steelplate_1`, `ceramicplate_1`, `fabricplate_1`) need resolution against the active `attachment_*` definitions. Avoid granting a second reward for the same corrected item through two paths.

## Map and difficulty bands

These are planning bands, not nine mandatory global reputation ranks. Every contact keeps personal branch progress. Equipment differences need a stats/compatibility check before final ordering; numeric item suffixes alone do not establish power.

| Band | Acquisition ceiling | Typical requirements | Reward purpose |
| --- | --- | --- | --- |
| M1: newcomer | Marsh, tier 1 | One local supply category or an introductory job | Basic survival, first tool or service |
| M2: established | Marsh, tier 1 | Two local categories; ordinary quarry | Useful upgrade or a small supply selection |
| M3: field capable | Marsh, tier 1 | Three or four local categories; specialised local work | Finish basic equipment families and early utility |
| W1: trusted contact | Waystation, tier 2 | Three or four categories, or qualified local contracts | Surplus-to-military transition |
| W2: specialist | Waystation, tier 2 | Four to six categories; instruments, research or dangerous trophies | Advanced protection and specialist equipment |
| W3: veteran | Waystation, tier 2 | Six to eight categories where the reward warrants it | Military/scientific capstones obtainable without Pripyat salvage |
| P1: expedition | Pripyat, tier 3 | Four to six categories of verified expedition inputs | Late equipment and reconnaissance support |
| P2: laboratory | Pripyat, tier 3 | Six to eight categories or multi-stage field programmes | Computer, laboratory and advanced research rewards |
| P3: endgame | Pripyat, tier 3 | Optional demanding commissions after story completion | Wishes, prestigious options and renewable endgame supplies |

A ceiling permits earlier sources too; it does not force travel or prove that a trophy spawns on that map. World loot pairs are 1/2 for Marsh, 3/4 for Waystation and 5/6 for Pripyat. Check *every candidate*, including rare alternatives. Harvesting, cooking, job rewards and vendor routes need separate map-availability evidence.

Science entry occurs only after map 2 access is resolved, using the W2–W3 equipment/difficulty comparisons as initial references rather than M1–M3. This is an access floor, not a blanket requirement for Pripyat materials or eight-category deliveries. Science preparation can use earlier-map supplies while still being balanced for a character who has progressed through map 2. Check cumulative story effort, preparation and owned equipment when comparing these branches to other contacts.

Keep early Marsh story deliveries at ceiling 1. Preserve ceiling 2 for Boss and Quartermaster equipment and Egghead's existing advanced science, even when those branches are difficult. Preserve existing ceiling 3 inputs in late Technut, Haggler and Spicy Lemon branches initially; do not introduce Pripyat inputs simply because a branch gained depth. Mute and Jitters currently finish at ceiling 2. Science contacts based in the Marsh retain their later story access gates.

## Effort and payout rules

1. Freeze live requirements, pool means, source routes, job counts and reward values as the baseline. Retain map effort factors 1 / 1.5 / 2.25 and the source model's loot yield, rarity and mutant-danger inputs. Scores remain estimates, not playtime measurements.
2. Give each original milestone an effort budget E. Partition it across its replacement stages: initially 40% / 60% for two stages, 20% / 35% / 45% for three, or 15% / 20% / 30% / 35% for four. Use raw quantities and complete job counts; compare actual rounded effort after partitioning. A split should normally stay within ±10% of E. If indivisible rare inputs cannot fit, use fewer stages or a cheaper verified input instead of inflating the budget.
3. Keep each original branch endpoint's cumulative effort within ±10% of the live baseline initially. The old 25% growth applies between original logical milestones. Inserted stages share that milestone's budget. Per-stage costs can reset when a new logical milestone starts; increasing cumulative branch effort and risk are the intended curve. Change the tuner and its monotonic-per-edge assertions to express this policy before adding nodes. Merely lowering one global growth constant does not solve mixed branch lengths.
4. Preserve scarce inputs and dangerous proof at the final stage that earns the powerful reward. Intermediate work uses appropriate cheaper categories. Avoid replacing a dangerous hunt with several safe shopping deliveries. Add at most one new category per adjacent preparation stage where feasible; final field trials may differ.
5. New optional branches get independent budgets fitted to their map band and reward, using nearby live tasks as comparators. They must not raise the cost of reaching an existing story gate. A new requirement must have a route available before its own reward unlocks.
6. Permanent purchase/service access is separate from the completion payout. Appendix A redistributes purchase access; it does not award a free copy of every gun or suit. Preserve existing base stock caps and 12/48-hour replenishment settings, with only the explicit personal capacity upgrades below raising eligible maxima.
7. Partition cash, reputation and bonus-item value too. Current delivery cash is based on consumed value (30%, plus the existing singleton compensation); reputation includes a per-stack base; the alternative-item reward has a minimum quantity of one. Repeating these formulas on each tiny stage would inflate payout. Aggregate reward accounting across the original milestone's replacement stages, pay allocated portions once, and settle rounding at the final stage. Do not duplicate singleton compensation or minimum-one items. The saved supply choices replacing the random bonus use that same expected-value budget.
8. Repeatable jobs retain their ordinary job payout. Job-counter milestones add only the stated access/one-off allocation, not another complete job payout. Partial hand-ins give progress only. Do not also credit a submitted reward toward a later task automatically.
9. The 20% restock for eligible items needs a separate rule for these new stages: count the completed original milestone once, not each preparation stage. New independent commissions may count once at their own completion. This revises the earlier proposal's per-milestone wording to avoid multiplying equipment replenishment by splitting tasks.

Example: Jitters medical2 currently unlocks bandage 2, antirad 1 and medkit 3. Make three stages with those rewards in that order. Allocate about 20%, 35% and 45% of its existing effort and payout, place the most demanding medical inputs last, and retain the original completion ID on the medkit stage. The player sees three useful gains while the original endpoint stays close to its present total cost.

## Personal vendor stock-capacity rewards

Add permanent, character-specific capacity milestones as intermediate progression rewards. They reserve a larger supply of selected already-unlocked consumables at the issuing contact. They do not grant items, purchase access, discounts, faster passive replenishment or extra restock quantity by themselves. Use these benefits to replace some preparation-stage supply allocations and deferred new-item rewards, without adding compulsory errands or raising existing endpoint effort merely to accommodate them.

### Initial allocation

Use explicit item-ID lists per NPC, not broad category matches. Values below are proposed effective stock caps under the current default catalogue; they count stock entries, not bullets or uses inside an item.

| Contact | Eligible existing stock | First capacity milestone | Final capacity milestone | Placement |
| --- | --- | --- | --- | --- |
| Haggler | Standard hunting/surplus ammunition, initially `12gauge`, `9x18`, `762x25`, `762x39`, `762x54` | 4 → 5 | 5 → 6 | Earn the first during established surplus progression; the second after a substantial later weapon branch |
| Quartermaster | Standard military ammunition, initially `545x39`, `556x45`, `762x39`, `762x51`, `9x19` | 4 → 5 | 5 → 6 | Both remain behind his existing flashdrive introduction; award during military progression |
| Jitters | Ordinary bandages and medkits already unlocked at that stage | 3 → 4 | 4 → 5 | An early established-medical milestone, then a later supply milestone; define exact eligible IDs with each rank |
| Spicy Lemon | Ordinary food, water and tea already sold/unlocked, initially `drink_bottlewater`, `drink_bottletea`, `food_can_sprats`, plus approved existing food unlocks | 4 → 5 | 5 → 6 | Provisioning branch, then its later logistics/supply milestone |
| Old Timer | `medic_bandage_1` and `medic_bandage_2` | 3 → 4 | No second rank initially | A later hunting-support milestone; preserve Jitters' stronger clinical supply benefit |
| Egghead | Selected unlocked specialist medicines, initially `medic_psyheal_2` and `medic_stimpak_1` | 2 → 3 | No second rank initially | Post-map-2 science progression only |

Technut has no proposed maintenance consumable in this release because new items are deferred; do not add a capacity milestone for nonexistent stock. Beanstalk, Intern, Smartass and service-only contacts do not need a stock reward just for uniformity. Add one only if an audited existing sale catalogue gives it practical value. Avoid upgrading the same generic medical range at every seller.

Keep guns, suits, helmets, reusable tools, attachments, access items, rare ammunition and other rare equipment outside the initial eligibility lists. Player-deposited community/Sherpa goods, buy-only entries, infinite stock and items without a valid replenishing sale policy are excluded.

A capacity rank never unlocks its listed products. For a product earned later, the rank may apply when that item's ordinary access milestone is completed; display that condition clearly. Jitters' later medkits must still require their original medical access. Scientist location on map 1 does not allow early capacity rewards before post-map-2 physical and personal access.

### Stock and replenishment behaviour

- Rank one gives +1 capacity; rank two gives +2 total from the base catalogue, not another +2. Apply the highest earned rank once. Shared/alternative milestone routes and repeated completion calls cannot stack it again. Each rank has a defined whitelist and cumulative bonus.
- Resolve normal elapsed restock against the old maximum before applying an increased maximum. Preserve the resulting count and timer state. Do not backfill the newly created spaces with previously discarded full-shelf time, reset depleted stock, or grant a free refill on first shop access after earning a rank. A missing personal stock record starts from the ordinary base starting stock, not the upgraded maximum.
- Keep the existing one-item passive replenishment amount and 12-hour consumable interval. Capacity 4 → 6 provides a larger reserve after time away; it does not increase the sustained passive supply rate. Retain the established full-shelf timer policy.
- The separately proposed task restock remains 20% of the **effective personal maximum**, so a 4-cap item contributes 0.8 stock per qualifying completion and a 6-cap item contributes 1.2. Preserve fractions and clamp at the new maximum. This interaction intentionally improves task-funded replenishment and must be included in reward-value tuning. Apply once per original logical milestone, never once for every inserted preparation stage. The capacity change itself does not trigger restock; any replenishment from a qualifying completion is a separate, clearly displayed benefit.
- Preserve vendor catalogue/admin settings as the base policy rather than rewriting shared vendor items when one character earns a rank. Resolve only supported finite sale policies, respect disabled restock, and document how subsequent admin cap edits combine with the fixed personal bonus. Reopening a shop, replacing an NPC or using an alternative progression route must not reset supply.

### Implementation and display

The existing stock code in `plugins/vendor_adv/libs/sv_stock.lua` saves counts per character but reads maximum capacity directly from `vendor.items`. Add a single resolver for the effective policy from the base catalogue, contact identity and character's earned progression rank. Use it consistently for stock initialization, elapsed replenishment, purchase validation, sales that affect stock, task restock, clamping and the catalogue copy sent to that shopper. Never mutate the shared catalogue for a personal reward.

Derive the rank from completed personal progression, or save it idempotently with the completion; do not increment an unbounded bonus in a callback. Follow the existing map/contact stock identity and explicitly bind each milestone to that contact's catalogue. Preserve persistence across reconnect, restart and server transfer. Define continuing-character mappings for any moved milestone without resetting counts or paying twice.

Show `Stock: 2/5` using the character's actual maximum, and show the progression reward as, for example, `Haggler: selected standard ammunition capacity 4 → 5; refill speed unchanged`. The progression help view must show personal cap bonuses separately from base catalogue settings, including which items remain locked. Existing stock updates only send current counts; refresh the personal policy/catalogue too if capacity changes while the shop is open. Other characters, including those on the same account, must retain their own limits and stock.

Test characters with different ranks at the same vendor, alternative completion routes, locked-item lists, cap increases with empty/full/partial shelves, uninitialized stock, existing partial refill time and offline restock. Verify no free refill, unchanged passive rate, correct fractional task restock at caps 4/5/6, exclusions, reconnect/restart/transfer, live shop updates and admin base-cap changes. Add these cases to vendor-stock tests when implementing the system.

## Contact-by-contact plan

Counts below describe the intended shape, including preparation stages. Final definition counts follow the item and effort audit; branch layouts are not one global linear ladder.

### Old Timer — Marsh hunting and survival

Keep the three story milestones and their arrivals in place. Expand the optional knife line from three to five stages: small-game proof → knife2, predator preparation → field supplies, big-game proof → knife3, elite tracking preparation → hunting supplies, final dangerous proof → knife4. Split the two digging milestones into four stages: basic anomaly evidence → supply allocation, mixed local evidence → cleaning-kit digging tool, advanced search preparation → supplies, final treasure-hunter proof → shovel. These tools keep their actual digging purpose.

Split Clubbing into three stages: bat/hatchet → machete/fireaxe → fubar. This creates twelve optional stages from the present six. All remain Marsh ceilings; dangerous quarry availability must be checked rather than inferred from generic harvest tables. Keep knife4 and the shovel as capstones, and use the existing alternative-item payout budget for preparation rewards. New exclusive hunting dressings belong to the separate reward implementation.

### Cleaner — storage and transport

Keep `cleanerItemDelivery_Storage` as the first service unlock and preserve paid storage upgrades. Add two optional logistics milestones for local recovery and delivery preparation, using existing supply pools and completion rewards. Backpack exchanges, special input handling, direct backpack rewards and vendor restrictions have been removed. Existing stash barters and storage limits retain their normal rules.

### Technut — repair, suits, masks and attachments

Keep the suit line's existing power order: mail jacket → trenchcoat variants → Sunrise → CS1 → Wind → CS2 → CS3, with NBC as its own branch. Keep colour variants together. Add preparation stages before Sunrise, NBC and the late helmet transition where source-based effort jumps are large. Preparation rewards are bounded repair supplies/credit from the original payout allocation; the actual suit/helmet unlock remains on the final stage.

Split each of the four paired mask rewards into two stages. Split each steel/ceramic plate pair into two stages at the same nominal protection level; retain fabric, Kevlar and frame branches. Split PSZ12 and Sphere12 at Helmet6, subject to their resistance/weight comparison. Do not split the three steel helmets or Russian operator variants just to create cosmetic chores. Keep painting as a single inexpensive utility unlock.

Retain Wind/PS5M and CS3/Berill pacing comparisons across Technut and Boss. These remain balance comparisons, not new mandatory cross-NPC prerequisites. Resolve story plate IDs before allocating plates between the story and optional branch.

### Jitters — eight to ten medical milestones

Replace the four medical milestones with the ten reward groups in Appendix A. Keep bandage1 and paid treatment initially available. The first seven groups stay locally attainable; the last three remain the current ceiling-2 advanced medical segment. If adjacent medkits are effectively equivalent, combine them and ship eight or nine meaningful stages instead of ten superficial ones.

Use medical salvage, supplies and verified local alternatives. Do not require players to buy the just-unlocked medicine to unlock itself. Field trauma dressings and treatment-credit choices can replace a portion of the existing completion bonus when implemented.

### Haggler — surplus branches

Retain the branching tree and every existing weapon endpoint. Split the six bundles in Appendix A into separate earned access stages, keeping matching new calibres with their gun. Short/long shotgun variants remain paired. Add preparation stages only where the effort audit identifies a large jump, especially the late .500 hunting branch.

Keep early branches at one to three categories and preserve their current map ceilings. AKM and AKS-74U stay surplus exceptions. Quartermaster retains his existing flashdrive introduction gate; no Haggler milestone becomes a gameplay prerequisite. Their shared equipment curve remains an offline difficulty comparison. Extra split stages must not inflate Quartermaster requirements merely through graph depth.

### Spicy Lemon — provisions, drinks and remedies

Keep the seven single-reward medicine milestones. Turn the Food bundle into four stages: hydration → portable snacks → canned meals → energy drinks. Split premium vodka into two and wine/spirits into two. Add one preparation stage before Swamp Brew, keeping the brew itself as the capstone. This gives seventeen stages instead of eleven.

Hydration/food/drink preparation stays local where existing ceilings allow. Keep the late medicine branches' current ceilings. Separate food, alcohol and medicine branch activation so reaching Spirits or Brew through one parent cannot bypass another *required* preparation stage; define explicit all-parent gates where intended. Existing `nextProgressions` edges activate independently, so a visual join alone is insufficient. Keep the earlier access route where multiple parents are deliberate alternatives.

### Mute — observation and communications

Expand binoculars from four to six milestones by adding preparation before the six- and eight-category requests. Keep the existing binocular IDs in their current reward order pending magnification/handling checks. Split anomaly sensing and Echo access with a preparation step before Echo. Add one preparation step before broadcasts; warning access stays a single useful early utility unlock. The radio-tower story still grants the flashdrive at its existing endpoint.

Keep personal blowout warnings and event broadcasts on their original completion IDs. Existing broadcasts require especially expensive ingredients; use those costs to divide preparation from final installation. New communications repeatable work must be enabled in dialogue explicitly; commented-out tasks do not count as an existing feature.

### Quartermaster — military requisitions

Split the nine bundled weapon milestones in Appendix A into their distinct groups, adding ten intermediate rewards in total. Keep the single-weapon endpoints, including AK12, FN FAL and SVD. Matching ammunition remains available before a weapon can be used; do not sell progression access as ammunition-only busywork when the calibre is already base stock.

All existing branches retain ceiling 2 and their four-to-eight-category range across each original logical milestone. Earlier split stages may use a subset of those categories. Add basic optics/foregrip access as optional side rewards only when the catalogue additions from the reward plan are implemented. AP/HP ammunition remains controlled through existing barters or their separately designed deterministic replacements.

### Quartermaster access — retain the existing introduction

Keep `quarterMasterDelivery_activateItem` as the existing flashdrive introduction that activates Quartermaster's weapon-progression roots. Discard the proposed Haggler milestone requirement and the associated new firearm-purchase eligibility checks. Preserve existing story, trade and base-stock access conditions; do not add another gate as part of this rework. Haggler and Quartermaster still share an equipment/difficulty comparison in the offline model, not a new mandatory quest dependency.

### Boss — heavy protection and operations

Keep IO7a an inexpensive W1 introduction. Add preparation before PS5M and Berill if needed to smooth their current effort jumps. Preserve PS5M → Berill → SKAT10 → SKAT9 ordering until a resistance/mobility comparison supports a change. Split radiation helmet/suit and Spartan/exoskeleton into two stages each; exoskeleton is the final reward.

Split the four data-extraction jobs into two counter stages of 1 + 3 completions. Stage one gets a bounded operational supply allocation; the fourth total completion retains the original `boss_dataTasks` ID, Smartass arrival and next story activation. Easy/medium/hard categories currently all count as one; any new difficulty requirement is a deliberate balance change requiring comparison of actual job contents.

### Smartass — reconnaissance

Replace the single five-job RF counter with three stages of 1 + 2 + 2 completed jobs. Award a small reconnaissance supply allocation first, proposed basic optic purchase access second, and the existing bunker-card/next science access last. Keep the last node's `smartass_rfTasks` ID and all original arrival/gating effects. Basic optics require the new catalogue; without it, use a bounded supply choice rather than pretend an empty shop is a reward.

Add an optional later suppressor/advanced-optic branch at W2–W3, using the catalogue proposed in the reward plan and verified weapon compatibility. RF tools remain assigned job instruments. Do not sell them as generic rewards or unlock Egghead before the five-job total.

### Beanstalk — expedition preparation

All stages start after the physically gated return to the scientists on map 1 following map 2. Expedition preparation here means preparing an experienced character for scientific work, not teaching a new Marsh character basic survival.

Split the current document delivery into three phases sharing its current effort: field records → a modest science expedition supply allocation; instrumentation records → new expedition catalogue access if adopted; final research archive → the original story completion and Egghead artifact task. Use five existing categories divided across those phases; do not request the full archive three times.

Keep existing PP-2000 and Screen Helmet availability unless explicitly opting into a fresh-start catalogue rebalance. Correct matching ammunition using the actual weapon definition. Add one optional expedition-outfitting milestone after the story work. The contact remains physically in the Marsh but starts after Waystation story access and retains ceiling 2.

### Egghead — detectors, suits and science drugs

All detector, suit, medicine and story roots retain post-map-2 physical and personal access. Even the first Echo research stage is a later science introduction; its placement on map 1 must not make it an early alternative to Mute's accessible equipment progression.

Expand detectors from three to six milestones: Echo research → Echo; Bear preparation → science supplies; calibration → Bear; anomaly-family survey preparation → supplies; documented specialist research → supplies; final six-family research → Veles. The final Veles task retains evidence from all six anomaly categories, with document work moved into preparation if needed. Do not reduce the detector acquisition challenge to common scrap.

Keep SSP99 → SSP99M → SEVA, adding preparation before SSP99M to spread the 3 → 6 category jump. Split Aid1 into psyheal2 → antirad2 → stimpak1; Aid2 into antipsychotic2 → stimpak2; Aid3 into antipsychotic3 → stimpak3. Keep the three science branches independent where they are independent today.

Split the story artifact delivery into preparation + final specimens only if its effort audit supports it; all next-story activation stays at the original endpoint. Existing advanced science retains ceiling 2, including Veles and SEVA. Buying and turning in scientific supplies must not create a profit loop. Research signatures are proposed new items, not assumed live rewards.

### Intern — surveys and Pripyat readiness

Intern becomes reachable only after map 2, alongside the other scientists. His early checkpoints are post-map-2 expedition rewards; none become available during the initial Marsh progression.

Replace the single 17-job story counter with four stages of 2 + 4 + 5 + 6 hard survey jobs. Show cumulative progress 2 / 6 / 11 / 17; completion count is per job, not per scanned point. Reward stages one and two with bounded expedition supplies, stage three with a research supply allocation, and stage four with the existing Computer apparatus and laboratory-card access at Egghead. Keep the original `intern_gasAnalyzerReadings` ID on stage four.

The hard jobs issue a four-point analyzer bound to Pripyat, while the progression definition requires completion on Marsh. The job hook runs when the job is claimed. Verify the complete Pripyat scan → return to Marsh → claim flow before changing either map check; this may be intentional expedition/return pacing. Label acquisition tier 3 separately from the hand-in map. Do not move the whole contact to Pripyat or let easier Marsh scans substitute unnoticed. Numeric tuning must account for those trips rather than using Marsh job effort alone.

### Computer — laboratory stages

Keep its one-item access apparatus as a single key gate. Split hardware startup into three stages: power and heavy hardware → diagnostic access; computing and repairs → operational diagnostics; remaining technical documentation/integration → full research operation. Diagnostics initially provide feedback and a bounded reward allocation; any new service requires implementation. Preserve all eight categories across the three stages without repeating them.

Split fourteen artifact jobs into three stages of 3 + 5 + 6, with a supply allocation at the first two checkpoints and ??? arrival/access only after fourteen total. Keep `computerDelivery_main` and `computer_artifactTasks` as the final IDs of their respective segments. Computer has no shop: use direct reward redemption in its dialogue, with a saved claim record. Never replenish an imaginary catalogue.

### The Original — optional newcomer branch

Add three optional M1–M3 milestones: first field supply delivery → a small food/fuel choice; cooking demonstration → prepared meal allocation; mixed survival commission → a modest tool/supply choice. Keep knife1, the cooker, cutlery and basic food available initially. These are practice and replenishment milestones, not extra gates before Old Timer's story. Existing repeatable trophy jobs remain useful; add progression dialogue explicitly.

### Hoarder — optional specialist commissions

Add four optional milestones fitted to the map where Hoarder is actually placed: appraisal → modest specialist-ammo allocation; collection → a named existing rare-item purchase offer; advanced commission → a higher offer; capstone → a prestigious named offer or implemented signature. Use W2–P3 only when placement and verified supply routes support those bands. No live placement is established by the template alone.

Keep existing exotic-ammo stock as the initial catalogue. His special-sale dialogue is commented out, so deterministic rare offers need implementation and an audited list drawn from existing items. No automatic full rare gun reward per easy turn-in. Do not make this branch part of laboratory access.

### Arena Master — optional arena progression

Add three arena milestones: complete an authorised match → bounded arena treatment credit; complete a varied match programme → combat supply choice; final programme → prestige/cosmetic reward and an implemented renewable supply option. Determine match counts from real match effort before choosing numbers; the generic delivery/job model does not describe PvP matches.

Record results through authoritative arena completion, exclude cancellations and duplicate events, and limit repeated rewards from the same opponent. Keep ordinary treatment available from the start. Catalogue medkit1 exists but trade is hidden in the greeting; do not present its access as a valuable new milestone without implementing the flow. Keep arena progression optional so solo story advancement remains possible.

### ??? — optional endgame wishes

Access still requires Computer's final artifact milestone. Add three endgame stages: contact/attunement → lore/cosmetic recognition; anomalous proof → an explicit one-use wish-service credit; final proof → a prestige reward or implemented signature. Keep all existing wish options and stat magnitudes; do not turn three stages into three automatic permanent stat increases.

The current first wish costs zero, with subsequent costs based on wishes already taken. Any credit must apply to an actual positive fee, capped at a defined value, and never create cash. Confirm desired fresh-start wish access before making paid wishes progression-gated; initial implementation can leave purchases available and make this branch optional. ??? is a service contact, not a hidden shop.

### Community NPC (`ratnpc`, display name `NPC`) — optional contribution branch

Add three small contribution milestones using verified local goods: initial provisions → a small fixed supply allocation; workshop contribution → a utility allocation; sustained support → a cosmetic distinction. Scale ceiling and theme to actual placement rather than assume this template lives in Marsh. Keep Sherpa/community trade available immediately.

Personal donations may advance that character only. Community player-deposited goods cannot generate restock or count as a renewable free reward. A new personal branch must not manufacture stock for the shared exchange or reward unrestricted buy/sell cycling. If the template is unused on the deployed maps, definitions can exist but remain unavailable until deliberately placed.

## Story activation and persistence design

Keep existing story IDs on the final replacement stage, preserving consumers in dialogue, vendor access, broadcasts and `npcRequirements`. Global arrivals remain global first completions; personal access remains per character. New early stages never emit final arrival effects. Key items remain quantity one.

Inserted stages need explicit activation changes: redirect each incoming edge to the first stage, have stages activate only their successor, and retain outgoing edges on the final stage. For default-active tasks, move `defaultActive` to the first stage. For NPC-gated roots, require the same personal contact access. Review alternative-parent versus all-parent semantics explicitly; the current runtime activates a successor after any completed incoming edge. A multi-parent prerequisite feature would need runtime/UI support.

For counters, store stage-local increments (for example RF 1, then 2, then 2) and show a cumulative programme total. Count a completed job once; do not count it in the old counter and the new counter simultaneously. Keep the final gate at the original total. Existing lifetime counters may instead keep cumulative thresholds if the UI can represent the new milestones clearly; choose one representation before coding.

Use the current progression graph directly for the fresh-start release. Runtime code does not import old completions, partition old assignments or reprice old rewards.

## Implementation sequence and acceptance checks

1. Rebuild the source audit from live literals, resolve invalid reward IDs, and capture deployed NPC placements/vendor overrides. Compare existing weapon, mask, helmet, medkit and bag stats to confirm ordering. Keep new item mechanics deferred; identify any service dependencies separately and finalize the existing-item stock whitelists.
2. Extend the balance model with logical milestone groups, preserved effort/reward budgets, separate acquisition/hand-in maps and explicit reward allocation. Generate before/after paths, cumulative cost, worst/mean personal rolls and acquisition evidence. Do not run the unchanged depth tuner against the expanded graph.
3. Implement the personal stock-policy resolver and capacity milestone/UI support, with the verification cases above. Implement high-value splits first: Jitters, Old Timer, Spicy Lemon, Egghead, and the selected multi-item weapon/armour unlocks. Update dialogue to show actual saved requirements, next reward and cumulative programme progress. Provide a concrete reward at every playable stage.
4. Implement sparse-contact branches and their proposed catalogue/service dependencies. Then implement story counter checkpoints, keeping the same totals, final keys and access gates. Add the remaining optional contacts after their actual placement and event sources are verified.
5. Validate every original configured purchase unlock appears exactly once in its replacement segment, all original single unlocks survive, source ceilings hold for every candidate, no prerequisite depends on its own reward, and all story endpoints are reachable. Check branches separately rather than summing every optional path into one mandatory route.
6. Exercise fresh and continuing characters as appropriate, fixed assignments, partial stacks, full inventory, reconnect/restart/transfer, admin grants, repeated completion requests and multiple NPC instances. Check one-time payouts, rounding, service credits, fractional restock eligibility and duplicate job/arena events. Add meaningful regression cases to `tests/progression_spec.lua` and balance-model tests when implementation begins.
7. Verify Quartermaster progression retains the flashdrive introduction and has no added Haggler requirement. Verify that withdrawn exchange definitions and specialised input/purchase handlers are absent. Test pending checkpoint claims, restart/transfer and duplicate claims. Check every NPC menu and dynamic option list keeps GOODBYE last.
8. Playtest a new Marsh character, a Waystation military/science character and a Pripyat laboratory character. Compare total time and spend to the old endpoint, the longest interval without a useful reward, costly random assignments and the value of each stage's unlock. Adjust the ±10% effort tolerance from observed evidence if the old task was itself badly tuned. Source odds alone cannot establish real spawn frequency or travel time.
9. Verify science access specifically: an initial map-1 character cannot reach scientist services, claim their preparation rewards or acquire their gated catalogue through a new branch. After map 2, returning to map 1 exposes the intended science introductions while later personal story requirements still apply. Test physical access and progression access separately.

## Appendix A — exact existing shop-unlock split

Each row replaces one existing delivery segment. Groups are awarded left to right; rewards separated by `+` stay together. The original ID stays on the last group. Original segments not listed keep their full existing unlock allocation, including colour/length variants, matching new calibres and single-item endpoints. Preparation stages described above use a partition of the completion payout rather than duplicating those purchase unlocks. This appendix covers declared vendor unlocks; service/story allocations are specified in the contact sections.

| NPC | Current definitions |
| --- | ---: |
| 'Beanstalk' | 1 |
| 'Boss' | 8 |
| 'Cleaner' | 1 |
| 'Computer' | 3 |
| 'Egghead' | 10 |
| 'Haggler' | 27 |
| 'Intern' | 1 |
| 'Jitters' | 4 |
| 'Mute' | 9 |
| 'Old Timer' | 9 |
| 'Quartermaster' | 23 |
| 'Smartass' | 1 |
| 'Spicy Lemon' | 11 |
| 'Technut' | 31 |

| Existing segment | New reward stages |
| --- | --- |
| `bossItemDelivery_6` | `suit_radsuit` → `headwear_rad` |
| `bossItemDelivery_7` | `headwear_spartan` → `suit_exoskeleton` |
| `eggheadItemDelivery_Aid1` | `medic_psyheal_2` → `medic_antirad_2` → `medic_stimpak_1` |
| `eggheadItemDelivery_Aid2` | `medic_antipsychotic_2` → `medic_stimpak_2` |
| `eggheadItemDelivery_Aid3` | `medic_antipsychotic_3` → `medic_stimpak_3` |
| `hagglerItemDelivery_1` | `fort12` → `m1911` + `brhp` |
| `hagglerItemDelivery_11` | `lax410s` → `sten` |
| `hagglerItemDelivery_121` | `sks` → `rugermini14` |
| `hagglerItemDelivery_122` | `kiparis` → `kp31` |
| `hagglerItemDelivery_22` | `mp34` → `saigasemi545` |
| `hagglerItemDelivery_221` | `w1895` → `sako85` |
| `jittersItemDelivery_medical1` | `medic_medkit_1` → `medic_medkit_2` |
| `jittersItemDelivery_medical2` | `medic_bandage_2` → `medic_antirad_1` → `medic_medkit_3` |
| `jittersItemDelivery_medical3` | `medic_bandage_3` → `medic_medkit_4` |
| `jittersItemDelivery_medical4` | `medic_medkit_5` → `medic_medkit_6` → `medic_antirad_2` |
| `oldtimerItemDelivery_Melee` | `bat` + `hatchet` → `machete` + `fireaxe` → `fubar` |
| `quartermasterItemDelivery_1` | `mp5` → `mossberg500` |
| `quartermasterItemDelivery_11` | `mateba` → `ak74` → `l85` |
| `quartermasterItemDelivery_111` | `lax44` → `g36c` |
| `quartermasterItemDelivery_112` | `aek971` → `an94k` |
| `quartermasterItemDelivery_12` | `m3super90` → `fiveseven` |
| `quartermasterItemDelivery_121` | `ump45` → `p90` |
| `quartermasterItemDelivery_21` | `taurusragingbull` → `mp9a1` |
| `quartermasterItemDelivery_211` | `uzi` → `pp1901vityaz` |
| `quartermasterItemDelivery_22` | `rem870ae` → `mr96` |
| `spicylemonItemDelivery_Food` | `drink_canwater` + `drink_bottlebeer_6` → `food_nuts_2` + `food_cheese_2` → `food_can_tomato` + `food_can_tushonka` → `drink_energydrink_4` + `drink_energydrink_2` |
| `spicylemonItemDelivery_Vodka` | `drink_vodka_4` → `drink_vodka_5` + `drink_vodka_6` |
| `spicylemonItemDelivery_Spirits` | `drink_wine` → `drink_spirit_1` + `drink_spirit_2` + `drink_spirit_3` |
| `technutItemDelivery_Helmet6` | `headwear_psz12` → `helm_sphere12` |
| `technutItemDelivery_Mask1` | `mask_halfmask` → `mask_respirator` |
| `technutItemDelivery_Mask2` | `mask_gp5` → `mask_eo20` |
| `technutItemDelivery_Mask3` | `mask_pmk3` → `mask_xm40` |
| `technutItemDelivery_Mask4` | `mask_m40` → `mask_m50` |
| `technutItemDelivery_Attachment1` | `attachment_steelplate_1` → `attachment_ceramicplate_1` |
| `technutItemDelivery_Attachment2` | `attachment_steelplate_2` → `attachment_ceramicplate_2` |
| `technutItemDelivery_Attachment3` | `attachment_steelplate_3` → `attachment_ceramicplate_3` |

These 36 bundle reallocations alone add **43 delivery stages**, taking the existing 139 definitions to 182 before preparation stages, new contact branches and counter splits. Final scope should be counted from the approved graph, including any stages merged after the stats/effort review. No existing declared shop reward is removed by this allocation.

## Completed task reward overhaul

The remaining kit routes now use saved visible reward choices, documented in the
[jobsystem runtime guide](../../../gamemodes/ix_cotz/plugins/jobsystem/README.md#task-rewards-and-existing-kits).
Difficulty-based jobs preview the task and chosen supplies before acceptance; cash uses
the original range midpoint. Configured job and task-kit contents supply nominal reward
budgets, not new kit items. Haggler's paid upgrading is removed, existing kits redeem for
shown contents, and kit-producing barters expose explicit ammunition selections. Older
delivery programmes earn their saved choice only at the original logical endpoint.
Fixed commissions, service benefits, access gates and personal restocking remain intact.
New item mechanics and backpack changes remain deferred.
