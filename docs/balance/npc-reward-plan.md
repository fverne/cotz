# NPC shops and task rewards — revised allocation

Revised 27 October 2026 against the current working-tree progression implementation. This document supersedes the earlier proposed allocation. The remaining reward overhaul is now implemented;
see the [runtime reward documentation](../../gamemodes/ix_cotz/plugins/progression/README.md#task-rewards-and-existing-kits).

## Baseline and constraints

The current source declares **227 progression definitions: 219 deliveries and eight numeric programmes, covering all 19 NPC templates**. The source parser reports no unsupported progression registrations. The expansion already supplies intermediate equipment unlocks, fixed commission rewards, service credits, permanent discounts, personal consumable-stock capacity and a 20% task restock. These are existing systems, not recommendations to implement again.

The current [expanded progression specification](progression/expansion-plan.md) defines the accepted scope. Use existing items and services. New dressings, cleaning kits, cartridge variants, meals with new effects, protective inserts and navigation mechanics remain deferred. Backpack acquisition, item bases and backpack entities remain unchanged; there is no new backpack shop or exchange progression in this plan. Quartermaster retains his flashdrive introduction, with no added Haggler dependency. The three Marsh scientists are inaccessible until after map 2; neither local shop additions nor task assignments should bypass physical or personal story access.

Evidence: current vendor templates, all loaded per-NPC progression definitions (`sh_*prog.lua` and story definitions in `sh_definitions.lua`), service and stock libraries, repeatable-job payout, dialogue, and active barter definitions. Appendix A inventories every configured base entry, progression purchase authorisation and barter output. It includes the milestone and checkpoint threshold for each purchase, rather than treating all unlocked goods as initial stock. Map-saved server catalogue edits are not available in this workspace and need comparison before deployment.

## Design decisions

- Preserve all current equipment authorisations, split-stage ordering, checkpoint totals, service benefits and saved-character compatibility.
- Give each contact a primary economic purpose. Permit necessities and relevant local ammunition to overlap; avoid another complete copy of a specialist catalogue.
- Separate shop ownership, task-earned authorisation and truly exclusive items. The current work mostly delivers NPC-specific access and services, not newly exclusive physical items. Do not label ordinary medicine or a shared detector as a task-only exclusive.
- Keep finite progression and repeatable jobs distinct. An optional three-step commission is not a renewable task loop. Restocks on eligible repeatable jobs are the existing renewable benefit; contacts without such jobs still need a later repeatable-work decision.
- Keep limited randomness in visible reward offers or small extras. Remove paid kit upgrading and hidden kit contents from the task reward route in the next reward pass; those changes have not yet been completed by the progression expansion.
- Do not add tasks merely to attach another reward. Existing logical milestones retain their total effort and payout budget; a split preparation stage does not earn another 20% restock.

## Responsibility by contact

Each section distinguishes current implementation from the remaining recommendation. All existing valid sales and barters in Appendix A remain with their owner unless a replacement is explicitly identified.

### Old Timer — hunting and field survival

**Keep:** mutant contracts, trophy/hide buying, part-to-ammunition barters, knives, field melee equipment, lighting/Geiger counter, bandages and tobacco. His knife and melee authorisations are now distributed across smaller stages. `oldtimerItemDelivery_Knife2` grants +1 personal maximum stock for bandages 1 and 2, taking their default capacity from three to four.

**Next:** use existing hunting ammunition and bandages as visible repeatable reward choices. Preserve part barters as an alternative way to obtain ammunition rather than copying a full gun shop. Basic water or a simple existing food item would be a small optional shop addition; neither requires another progression branch.

**Reason to return:** hunting supplies, part conversion and earned bandage capacity. Do not move the advanced knife line to a later NPC. A new exclusive dressing is outside current scope.

### Technut — repair, fabrication and general protection

**Keep:** civilian starter firearms, improvised tools, suits, helmets, masks, armour attachments, full workshop repair and suit painting. The painting milestone now grants a permanent 5% repair discount. Story plate authorisations now use valid `attachment_*` IDs; the earlier invalid-ID finding has been resolved.

**Next:** reward technical deliveries with compatible existing attachments or bounded credit at Technut, using the already implemented service system. Validate ammo support for his existing guns and add only missing matching calibres. Preserve salvage acquisition: avoid selling the full materials needed to complete his own deliveries.

**Boundary:** general armour and maintenance stay here; Boss owns heavy combat protection, Egghead scientific suits. Existing technical and protective branches already establish this division, so no reassignment is needed.

**Reason to return:** repairs, the earned repair rate, replacement protection and restocks. Portable maintenance mechanics remain deferred.

### Jitters — clinical care and conventional medical reserves

**Keep:** physical/radiation/mental-health treatment, staged medkits 1–6, bandages 1–3 and antirad access. Medical milestone 2 grants +1 personal capacity for the whitelisted ordinary bandages/medkits; milestone 4 grants +2 total from base. Their default capacities become four, then five. Milestone 3 grants a permanent 5% treatment discount. Capacity never grants access to a still-locked medical item.

**Next:** retain the full conventional medical role here. Consider existing painkillers, morphine and adrenaline only if a stock gap remains after comparing Spicy Lemon's established medicine branches. Add no new drug mechanics and no full science pharmacy. A repeatable medical-supply job line would support renewable restocking, but is future work: the current medical deliveries are finite progression.

**Reason to return:** the best established conventional supply reserve and broad treatment service. Keep basic bandages accessible before advanced authorisations.

### Cleaner — storage, stashes and delivery logistics

**Keep:** personal storage, package delivery jobs, small basic-ammo catalogue, intentionally expensive emergency masks, buy-all outlet, currency and stash barters. The new two-step logistics branch follows original storage access and awards 300 then 600 storage-expansion credit; the final step also grants a permanent 5% expansion discount.

**Next:** keep named stash containers and fixed logistics supplies as reward choices. Preserve normal storage maximums. Once storage is fully expanded, offer useful existing stash/ammo choices rather than additional unusable storage credit.

**Boundary:** no new backpack sales, exchanges, bag milestones or bag-acquisition restrictions. Cleaner remains a storage/logistics contact without becoming a new source for the entire backpack catalogue.

**Reason to return:** stash conversion, package jobs, ammunition restocks and storage services. Credits and discounts are already implemented, not new promises.

### Haggler — civilian and surplus weapons, hunting ammunition

**Keep:** the complete pistol, surplus SMG, shotgun, semi-auto and bolt-action lines, including existing AKM/AKS-74U exceptions. Selected hunting ammunition (`12gauge`, `9x18`, `762x25`, `762x39`, `762x54`) now earns +1 then +2 maximum capacity, normally four → five → six. Repeated +2 awards are alternative ways of reaching the same rank, not additive +2 bonuses.

**Implemented:** paid upgrading is removed; the three `kit_reward_ammo_*` barter specifications now produce visible existing-ammunition choices. Add `9x19` as ordinary matching supply if needed for his current weapon catalogue. Use the earned hunting-ammo reserve as his lasting advantage rather than adding invented cartridge variants.

**Boundary:** modern weapons and military requisitions remain Quartermaster's primary role. Haggler's progression is not a new access prerequisite for Quartermaster.

**Reason to return:** surplus weapons, hunting-ammo capacity and human-target jobs that replenish that supply.

### Spicy Lemon — provisions, cooking and established remedies

**Keep:** cooking equipment and fuel, water/tea, alcohol, canned food, all staged food/drink/medicine authorisations, Swamp Doctor's Brew and existing MRE/aid barters. The food milestone grants +1, and Brew +2 total capacity for the explicit food/water/tea whitelist, normally four → five → six.

**Next:** use named existing meal, MRE, drink or fuel choices for repeatable rewards. A small stock of existing cooked meals is a reasonable catalogue extension, but account for meal-delivery tasks first: buying an entire request from the same NPC should not become profitable. Do not restore every commented-out cooked-meat entry indiscriminately. MREs can remain deliberate deterministic barters.

**Boundary:** preserve his earned low-level medical/remedy overlap. Jitters has the main clinical range; Egghead owns advanced scientific preparations. No new meal effects or signature food items in this phase.

**Reason to return:** provisions, larger earned reserves, cooking fuel and existing meal tasks.

### Mute — observation, navigation and communication access

**Keep:** binocular progression, compass/GPS, lights/Geiger counter, guitar, flashdrive story access, PDA avatars, and existing anomaly/Echo detector overlap. His expanded progression contains 13 delivery stages; do not mistake that for an active renewable job line. Repeatable-work options remain disabled in the greeting.

**Next:** make his existing observation/navigation catalogue and PDA service explicit in task descriptions. Reward suitable existing field equipment where budgets allow. A renewable communications commission is an optional later task addition; its inputs and outputs must use functional existing items. Do not retail task-bound receivers or invent battery consumption from junk-item names.

**Boundary:** binoculars and navigation belong here; gun optics and suppression equipment belong with Smartass. Advanced artifact detectors stay with Egghead.

**Reason to return:** equipment replacement and communication/navigation services. His renewable incentive is weaker than Haggler's while repeatable tasks remain absent; record that gap rather than claiming it solved.

### Quartermaster — modern arms, patrol attachments and military reserves

**Keep:** all existing firearms and ammo, split equipment authorisations, specialist-ammo barters and the flashdrive gate. The two optional field-equipment commissions are already implemented: Kobra/foregrip, then Eotech/Aimpoint/Micro T1, after the introduction and first military requisition. Selected `545x39`, `556x45`, `762x39`, `762x51`, `9x19` reserves now gain +1 then +2 maximum stock, normally four → five → six.

**Implemented:** retain that attachment selection. The `kit_ammo_rare` and `kit_ammo_m_rare` barter specifications now produce named existing-calibre choices. Preserve direct AP/HP barters with explicit quantities. Reward supply contracts with matching ammunition rather than generic medical kits or random weapons.

**Boundary:** basic combat sights/grips here, specialist optics/suppressors at Smartass, rare curiosities at Hoarder. No extra Haggler gate and no backpack changes.

**Reason to return:** modern ammunition reserves and requisitions, enhanced by the existing 20% job restock.

### Boss — heavy protection, secure access and operations

**Keep:** heavy suit/helmet progression through exoskeleton, restricted access and data-extraction work. Radiation headgear now precedes the radiation suit; preserve that order. The first data job already grants 500 repair credit at Technut, and four data jobs retain the original story outcome.

**Next:** keep current ammunition as operational convenience overlap, without expanding it into another full Quartermaster catalogue. Future reward choices can use existing support supplies or bounded repair credit. Do not add exoskeleton frames, new inserts or carrying changes in this phase.

**Boundary:** heavy protective equipment comes from Boss; repair benefits continue to be redeemed at their named provider. A Boss-earned repair credit at Technut does not make Boss the source of Technut's discount or catalogue.

**Reason to return:** heavy equipment, access and data jobs. Expensive stock still benefits from fractional task restocking without a rounded-up full weapon/suit refill.

### Smartass — reconnaissance optics and suppression

**Keep:** RF surveys, specimen buying, suit-variant exchange, and the now-implemented optical catalogue. RF checkpoints are one, three and five jobs: ammunition after one; PSO-1 authorisation after three; original science/bunker access after five. Three optional recon deliveries follow Boss's data programme and authorise PSO-1/C-More, then ACOG/Shortdot, then Nightforce and PBS/Saker/Tundra/Cobra suppressors. PSO-1 has two authorisation paths; completing both does not award two free optics.

**Next:** retain those exact branches. Recommend compatible, existing optic/suppressor reward selections only after budget and weapon checks. Do not automatically add every remaining sight; King Arms and RMR need a separate compatibility/usefulness case.

**Boundary:** Mute supplies observation/navigation; Quartermaster basic patrol fittings; Smartass specialised sighting/suppression. Retain existing specimen purchase convenience, but avoid making him the best-paying universal buyer.

**Reason to return:** RF work, optical replacements, and restocking an actual unlocked catalogue. No new calibrated-optic item is required.

### Egghead — artifact science and advanced field medicine

**Keep:** artifacts/specimen buying; Echo/Bear/Veles; SSP-99/SSP-99M/SEVA; staged scientific medicines; computer/laboratory access. Scientific Aid 1 now grants +1 personal capacity for `medic_psyheal_2` and `medic_stimpak_1`, normally two → three. Its other medical authorisations retain their staged order.

**Access:** despite being in Marsh, the entire science contact is post-map-2 content. Existing acquisition ceilings and story dependencies remain; do not rebalance this into an introductory medicine/detector shop based on location alone.

**Next:** retain the science speciality and use existing scientific medicines for visible rewards. Keep advanced detector ownership here. Do not add a shop selling artifacts that can be turned directly into his own profitable research requests.

**Reason to return:** scientific consumables and their earned reserve, artifact tasks, advanced detectors and protective equipment.

### Beanstalk — expedition administration and field provisioning

**Keep:** Screen Helmet, PP-2000, both current `9x19` and `9x21` stock, suit-variant service and documents progression. The PP-2000 ammo mismatch is already fixed by adding 9x19. His optional expedition commission follows the documents programme and already pays basic antirad plus psy recovery medicine.

**Next:** keep a compact expedition catalogue. Small local clean-water/basic-bandage additions are defensible if a real travel-supply gap exists. Do not duplicate Technut's entire protective-equipment range or Egghead's detectors/suits. No bags, new rations or preparation mechanics.

**Access:** all tasks, shops and preparation remain behind the post-map-2 science access floor. The optional commission does not move that floor earlier.

**Reason to return:** expedition supplies, local weapon support and variant service. His finite commission provides identity, but another renewable loop remains optional future work.

### Intern — dangerous surveys and local hazard recovery

**Keep:** compact anomaly detector/Geiger counter and hazard medicine stock, including existing medkits 5–6 and their explicit prices. The survey programme now has checkpoints at 2/6/11/17 jobs: antirad; tea plus basic medkit; advanced psy recovery; then original laboratory-access outcome. Work is Pripyat field work even though the contact is in Marsh.

**Next:** retain these checkpoints rather than adding a new reward after every survey. Use existing hazard medicine in repeatable-job reward choices. A small bandage/water stock is optional local convenience; no full general pharmacy.

**Boundary:** preserve existing high-medkit local overlap with Jitters; it is post-map-2 supply, not an early shortcut. Keep sophisticated research authorisations with Egghead.

**Reason to return:** renewable survey work and hazardous-expedition recovery supplies.

### Computer — artifact analysis and research milestones

**Keep:** analysis and story work, with medicine at 3 and 8 artifact jobs and original ??? access at 14. There is no ordinary shop catalogue, so a shelf restock here has no useful inventory effect.

**Next:** keep this a research terminal. Reward explicit existing medicine/research supplies through the existing benefit system; make its value clear in milestone previews. Do not invent a retail kiosk, dispensing cache or calibration mechanic to force every contact to have a shop.

**Reason to return:** analysis, research checkpoints and endgame access. Its distinct reward is research progress/access; unique physical items remain deferred. State the absence of a stock benefit honestly.

### The Original — newcomer survival and rough provisions

**Keep:** low-cost rough food, dirty water, alcohol, knife, cutlery hidestasher, basic cooker/fuel and trophy work. Three optional survival commissions now already award food/water, fuel, then bandage 2 plus provisions.

**Next:** retain those low-barrier commissions. Convert repeatable rewards to useful existing provisions, with clean water as a reasonable small shop addition. Keep advanced knives at Old Timer and premium provisions at Spicy Lemon. No new bag sales or exclusive trail-ration mechanics.

**Reason to return:** cheap food/fuel, trophy work and local restocking. The three commissions are finite assistance, not renewable personal supply rewards.

### Hoarder — rare calibres and rare-weapon authorisations

**Keep:** the current unusual ammunition catalogue and four implemented commissions. These pay fixed ammunition and progressively authorise purchase of SW500, VSSK and Nitro at existing prices. They do not hand out free rare guns. The former random special-sale interface remains commented out.

**Next:** preserve the named purchases and visible fixed ammo. Do not revive blind sales or import the historical random pools. Four commissions are finite; a later repeatable rare-salvage commission would improve long-term restocking, but should be evaluated separately rather than assumed present.

**Boundary:** keep shared calibres where another seller supports an earned gun. Rare-ammo ownership need not remove Haggler's .500 support or Quartermaster's 5.7/other relevant supplies.

**Reason to return:** unusual ammo and exclusive purchase routes. No invented specialty-cartridge definitions in this phase.

### Arena Master — competitive progression and recovery

**Keep:** arena functions, basic medkit sale, variant exchange, physical treatment and three implemented programmes requiring distinct human opponents. The sequence awards 150 treatment credit, a basic medkit, then Arena Veteran recognition and a permanent 10% treatment discount. Qualifying completed matches count; victory is not required by the current hook. Do not describe these as kill or victory bounties.

**Next:** keep arena rewards attached to actual competition. Optional basic bandages/water can support local recovery, but do not turn this into a weapon shop. Review normal arena payouts together with progression benefits before introducing repeatable service rewards.

**Reason to return:** competition, recovery and earned treatment rate. The three programmes are finite; do not assume each subsequent match invokes the standard job restock path.

### ??? — wishes and endgame recognition

**Keep:** wishes with their current effects and first free wish. Three optional proofs now award recognition, 25,000 wish credit, then recognition and a permanent 2.5% wish discount. Credits apply only against positive fees and do not consume the free first wish.

**Next:** preserve this service role. No ordinary shop, permanent stat inflation per repeatable task, or artificial shelf-restock reward. This contact already has distinctive service benefits, so the former proposal to omit progression is obsolete.

**Reason to return:** wishes and explicitly priced endgame services. The proofs are finite; they do not introduce an infinite wish reward loop.

### Community NPC — contribution and community recognition

**Keep:** the `ratnpc`/`NPC` sherpa/community template and existing shared functions. Three personal commissions now award water/tea, bandage, then provisions and Trusted Community Supplier recognition. Shared deposits do not automatically satisfy the personal commission.

**Next:** retain this deliberate participation route. Do not exclude the contact from progression merely because the template is unusual; it already has personal commissions. Keep shared deposits and personal claims separate.

**Boundary:** sherpa stock is explicitly excluded from personal capacity upgrades and task restock. Do not turn community participation into personal rare-equipment supply or bypass that exclusion through the generic display name.

## Stock and overlap allocation

| Category | Primary role | Intentional overlap | Decision |
|---|---|---|---|
| Basic survival | Original / Old Timer | Spicy Lemon and small field-contact supplies | Preserve convenience; no universal full survival shop |
| Food, drink, fuel | Spicy Lemon | Original's cheap provisions; Technut's snack | Keep earned food reserves at Spicy Lemon |
| Conventional medicine | Jitters | Old Timer bandages, arena medkit, Intern local supply | Jitters owns the broad clinical range and reserve |
| Scientific medicine | Egghead | Intern hazards, Beanstalk commission, Computer checkpoints, Spicy Lemon's existing remedies | Preserve established overlap without cloning the full catalogue |
| Civilian/surplus guns | Haggler | Technut's starter guns | Preserve current authorisations and matching ammunition |
| Modern guns/ammunition | Quartermaster | Boss operational stock, Beanstalk PP-2000, Haggler's existing surplus exceptions | Keep distinct earned ammo reserves; no new Haggler gate |
| Rare guns/ammunition | Hoarder | Existing calibre support elsewhere | Preserve new named weapon commissions; no blind special sales |
| General protection/repair | Technut | Cleaner expensive emergency masks; Beanstalk Screen Helmet | Keep repairs at Technut; preserve earned discount |
| Heavy combat protection | Boss | Technut general helmets/attachments | Keep heavy progression and headgear-before-suit order |
| Scientific protection/detection | Egghead | Mute's early detector alternatives; Intern instruments | Preserve post-map-2 access and specialised detector branches |
| Basic weapon attachments | Quartermaster | Smartass weapon optics | Keep implemented patrol-attachment commissions |
| Specialist optics/suppressors | Smartass | PSO-1's two own authorisation routes | Preserve thresholds; no duplicated physical rewards |
| Navigation/binoculars | Mute | Basic headlamps/Geiger counters elsewhere | Keep separate from weapon optics |
| Stash containers/storage | Cleaner | Existing hidestashers at Original/Old Timer | Existing logistics credits/discount; no backpack changes |
| Artifact analysis / wishes | Computer / ??? | Medicines as checkpoint supplies | Keep service contacts; no compulsory retail catalogue |

Allow broad buying convenience, including established buy-all outlets. A buy-only entry is not a shop source for that item. Specialist buy-price advantages can be reviewed later; do not silently change every specimen buyer's prices as part of reward allocation.

## Existing capacity and restock interaction

Capacity is earned personal maximum stock for explicit already-unlocked item IDs. It grants neither free goods nor a faster passive refill. Bonus ranks use the largest earned bonus, not the sum. Appendix B records exact milestone IDs and eligible items.

| Contact | Eligible supplies | Default effective capacity after ranks |
|---|---|---|
| Old Timer | Bandages 1–2 | 3 → 4 |
| Haggler | Five listed hunting/surplus calibres | 4 → 5 → 6 |
| Quartermaster | Five listed military calibres | 4 → 5 → 6 |
| Jitters | Bandages 1–3 and medkits 1–6, subject to purchase access | 3 → 4 → 5 |
| Spicy Lemon | Seven listed food/water/tea entries | 4 → 5 → 6 |
| Egghead | Psyheal 2 and stimpak 1 | 2 → 3 |

The already implemented task restock adds **20% of effective personal maximum**, saves fractions, caps at capacity, and discards excess/full-shelf progress. Thus earned capacity increases both the reserve ceiling and the amount a qualifying task replenishes. For example, a six-stock ammo entry gains 1.2 units of restock progress per qualifying completion, compared with 0.8 at four-stock capacity. Passive refill intervals and quantities remain unchanged.

Restock applies to finite, unlocked, sellable entries with positive passive replenishment. It excludes quest/access-card IDs, buy-only entries and sherpa vendors. The restock itself includes eligible equipment, not just the consumables allowed to earn capacity upgrades. Keep that distinction explicit.

Each qualifying repeatable job receives one restock. Split original delivery programmes receive it at their original logical endpoint, not every inserted stage or partial hand-in. Administrative grants do not replay rewards. Numeric programme checkpoints pay their declared benefits; do not attach another restock to a checkpoint on top of the triggering job. Arena, service-only and community contacts do not gain an ordinary job restock merely because they now have progression.

Keep this implementation as the baseline. Balance the combined effect of capacity and fast repeatable jobs before increasing percentages or adding more capacity ranks. Do not advertise a shelf refill at Computer/??? when their catalogues are empty.

## Reward overhaul — implemented

The expansion's remaining kit routes now use saved visible choices: jobs, older logical delivery bonuses,
legacy kit redemption, and kit-producing barters. Paid upgrading is removed. Existing fixed-benefit
commissions, service rewards, gates and the 20% restock retain their behaviour. The original kit tables
remain as nominal valuation specifications and saved-item compatibility, rather than new task rewards.
The steps below record the implementation scope; optional new repeatable branches remain future work.

1. **Keep the current structure.** Freeze existing stage order, major unlock effort, prerequisite gates and completed-character access. Do not add further preparation steps just to host reward choices.
2. **Convert task/job kit outputs and active kit barters.** Give visible choices of existing goods, themed by the contact above, using comparable value and explicit quantities. Remove paid kit upgrading once existing kits have a deterministic conversion route. World/non-task kit handling is a separate scope decision.
3. **Replace the remaining alternative-item roll within its existing budget.** Reveal and save a small selection when the original logical programme is assigned, then pay once at its endpoint. Existing fixed-benefit commissions need not receive another bonus or a forced choice. Keep minor random extras small, and do not reroll offers by reconnecting or changing dialogue.
4. **Prioritise renewable relevance.** Old Timer, Haggler, Spicy Lemon, Cleaner and Quartermaster already have repeatable work that can sustain personal restocks. Jitters and Mute are stronger candidates for later renewable supply/communication jobs; Hoarder's and Beanstalk's finite branches can be evaluated after that. Do not repeat permanent discounts, capacities or authorisations as if they were consumables.
5. **Use existing named services for distinct rewards.** Keep Technut repair, Jitters treatment, Cleaner expansion, Arena recovery and ??? wishes provider-specific. Optional future repeatable credits must be bounded and must offer a useful alternative when a service has reached its cap. Do not introduce a token currency or new item mechanics in this phase.
6. **Be honest about exclusivity.** The revised scope supports NPC-specific purchase routes, reserves, discounts and service allowances. It cannot make every NPC supply a unique new physical item without expanding the deferred-item scope. Preserve the long-term wish for task-only signatures as a later design decision, not a hidden requirement of this plan.

## Validation before gameplay changes

This revision re-parses all 227 progression registrations and refreshes the complete configured shop/barter inventory. It checks catalogue and reward IDs against existing item files and records checkpoint-gated authorisations. The old Beanstalk ammo and Technut plate-ID issues are fixed in the current source and must not remain listed as outstanding work.

For a future reward implementation, compare live/map-saved vendors and use `/ProgressionAudit` against the actual server registry. Verify preserved unlocks and story gates, post-map-2 science access, no duplicated programme/bonus/restock payments, fixed commission benefits, persistent saved choices, full-inventory claims, service credit limits and discount non-stacking, effective-capacity/fraction behaviour, attachment compatibility, and purchase–turn-in profitability. Reward, migration, claim and catalogue tests accompany the implementation; live balancing remains unverified.

## Appendix A — current configured inventories and purchase gates

Generated from the current source. All base items and active barter outputs are included; commented-out definitions are excluded. Purchase-authorisation rows identify their granting progression and any numeric checkpoint threshold. Authorisation means permission to buy, not a free physical item. Duplicate authorisation paths are retained for traceability. Buy-all flags describe additional purchasing beyond explicit buy-only lists. Current server-saved edits may differ.

### Cleaner (`owlnpc`)

**Base sales:** `12gauge`, `9x18`, `9x19`, `762x25`, `22lr`, `45acp`, `45acp41`, `mask_halfmask`, `mask_gp5`

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** Yes.

**Active barter outputs:** `22lr`, `12gauge`, `45acp41`, `value_currency_euro`, `hidestash_1`, `hidestash_2`, `hidestash_3`

**Progression purchase authorisations:** None declared.

### Technut (`technpc`)

**Base sales:** `22lr`, `45acp`, `45acp41`, `ruger1022`, `rugermk3`, `w9422`, `sako85varmint`, `nagantrev`, `g2contender`, `mp18`, `toz106`, `crowbar`, `leadpipe`, `sledgehammer`, `headwear_riot`, `helm_tanker`, `mask_cloth`, `suit_anorak`, `food_nuts_1`

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** No.

**Active barter outputs:** None declared.

| Granting progression | Gate | Purchase authorisation |
|---|---|---|
| [technutItemDelivery_Main](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L260) | completion | `attachment_steelplate_1` |
| [technutItemDelivery_Main](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L260) | completion | `attachment_ceramicplate_1` |
| [technutItemDelivery_Main](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L260) | completion | `attachment_fabric_1` |
| [technutItemDelivery_Helmet6_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L811) | completion | `headwear_psz12` |
| [technutItemDelivery_Mask2_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L999) | completion | `mask_gp5` |
| [technutItemDelivery_Mask3_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1076) | completion | `mask_pmk3` |
| [technutItemDelivery_Mask4_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1156) | completion | `mask_m40` |
| [technutItemDelivery_Attachment1_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1233) | completion | `attachment_steelplate_1` |
| [technutItemDelivery_Attachment2_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1312) | completion | `attachment_steelplate_2` |
| [technutItemDelivery_Attachment3_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1393) | completion | `attachment_steelplate_3` |
| [technutItemDelivery_Suit1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L3) | completion | `suit_mailjacket` |
| [technutItemDelivery_Suit2](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L52) | completion | `suit_trenchcoat_black` |
| [technutItemDelivery_Suit2](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L52) | completion | `suit_trenchcoat_brown` |
| [technutItemDelivery_Suit2](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L52) | completion | `suit_trenchcoat_green` |
| [technutItemDelivery_Suit2](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L52) | completion | `suit_trenchcoat_tan` |
| [technutItemDelivery_Suit3](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L127) | completion | `suit_sunrise` |
| [technutItemDelivery_SuitNBC](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L206) | completion | `suit_nbc` |
| [technutItemDelivery_Suit4](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L260) | completion | `suit_cs1` |
| [technutItemDelivery_Suit5](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L312) | completion | `suit_wind` |
| [technutItemDelivery_Suit6](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L366) | completion | `suit_cs2` |
| [technutItemDelivery_Suit7](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L420) | completion | `suit_cs3` |
| [technutItemDelivery_Helmet1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L520) | completion | `helm_steel_ger` |
| [technutItemDelivery_Helmet1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L520) | completion | `helm_steel_rus` |
| [technutItemDelivery_Helmet1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L520) | completion | `helm_steel_arab` |
| [technutItemDelivery_Helmet2](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L573) | completion | `headwear_cs1` |
| [technutItemDelivery_Helmet3](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L625) | completion | `helm_operator_rus_1` |
| [technutItemDelivery_Helmet3](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L625) | completion | `helm_operator_rus_2` |
| [technutItemDelivery_Helmet4](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L678) | completion | `headwear_cs2` |
| [technutItemDelivery_Helmet4](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L678) | completion | `headwear_cs4` |
| [technutItemDelivery_Helmet5](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L754) | completion | `helm_sphere08` |
| [technutItemDelivery_Helmet6](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L836) | completion | `helm_sphere12` |
| [technutItemDelivery_Helmet7](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L894) | completion | `helm_operator_nato` |
| [technutItemDelivery_Mask1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L949) | completion | `mask_halfmask` |
| [technutItemDelivery_Mask1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L949) | completion | `mask_respirator` |
| [technutItemDelivery_Mask2](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1024) | completion | `mask_eo20` |
| [technutItemDelivery_Mask3](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1102) | completion | `mask_xm40` |
| [technutItemDelivery_Mask4](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1181) | completion | `mask_m50` |
| [technutItemDelivery_Attachment1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1258) | completion | `attachment_ceramicplate_1` |
| [technutItemDelivery_Attachment2](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1337) | completion | `attachment_ceramicplate_2` |
| [technutItemDelivery_Attachment3](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1418) | completion | `attachment_ceramicplate_3` |
| [technutItemDelivery_AttachmentFabric1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1474) | completion | `attachment_fabric_1` |
| [technutItemDelivery_AttachmentFabric2](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1528) | completion | `attachment_fabric_2` |
| [technutItemDelivery_AttachmentFrame1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1581) | completion | `attachment_aluframe` |
| [technutItemDelivery_AttachmentFrame2](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1636) | completion | `attachment_steelframe` |
| [technutItemDelivery_AttachmentCarbon](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1690) | completion | `attachment_carbonfibre` |
| [technutItemDelivery_AttachmentKevlar1](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1743) | completion | `attachment_kevlar_1` |
| [technutItemDelivery_AttachmentKevlar2](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L1799) | completion | `attachment_kevlar_2` |

### Old Timer (`tutorialnpc`)

**Base sales:** `headlamp`, `geigercounter`, `medic_bandage_1`, `medic_bandage_2`, `drug_tobacco_1`, `drug_cigarette_1`, `drug_cigarette_2`

**Explicit buy-only entries:** `part_bear`, `part_blinddog`, `part_bloodsucker`, `part_boar`, `part_burer_1`, `part_burer_2`, `part_cat`, `part_chimera`, `part_controller_1`, `part_controller_2`, `part_electrocontroller_1`, `part_electrocontroller_2`, `part_flesh`, `part_izlom`, `part_hellhound`, `part_karlik_1`, `part_karlik_2`, `part_pseudodog`, `part_pseudogiant`, `part_psydog`, `part_skeleton`, `part_snork_1`, `part_snork_2`, `part_spider`, `part_sprig`, `part_swampcontroller_1`, `part_swampcontroller_2`, `part_tark`, `part_tushkano`, `part_vareshka`, `part_zombie_1`, `part_zombie_2`, `hide_blinddog`, `hide_bloodsucker`, `hide_bear`, `hide_boar`, `hide_burer`, `hide_cat`, `hide_chimera`, `hide_controller`, `hide_electrocontroller`, `hide_flesh`, `hide_karlik`, `hide_pseudodog`, `hide_pseudogiant`, `hide_spider`, `hide_sprig`, `hide_swampcontroller`, `hide_tushkano`, `hide_tark`, `hide_vareshka`

**Buy-all enabled:** No.

**Active barter outputs:** `22lr`, `9x18`, `762x25`, `9x19`, `45acp41`, `45acp`, `12gauge`, `545x39`, `12gaugesg`

| Granting progression | Gate | Purchase authorisation |
|---|---|---|
| [oldtimerItemDelivery_Melee_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_oldtimerprog.lua#L216) | completion | `bat` |
| [oldtimerItemDelivery_Melee_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_oldtimerprog.lua#L216) | completion | `hatchet` |
| [oldtimerItemDelivery_Melee_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_oldtimerprog.lua#L216) | completion | `machete` |
| [oldtimerItemDelivery_Melee_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_oldtimerprog.lua#L216) | completion | `fireaxe` |
| [oldtimerItemDelivery_Knife1](../../gamemodes/ix_cotz/plugins/progression/sh_oldtimerprog.lua#L3) | completion | `knife2` |
| [oldtimerItemDelivery_Knife2](../../gamemodes/ix_cotz/plugins/progression/sh_oldtimerprog.lua#L77) | completion | `knife3` |
| [oldtimerItemDelivery_Knife3](../../gamemodes/ix_cotz/plugins/progression/sh_oldtimerprog.lua#L157) | completion | `knife4` |
| [oldtimerItemDelivery_Melee](../../gamemodes/ix_cotz/plugins/progression/sh_oldtimerprog.lua#L244) | completion | `fubar` |
| [oldtimerItemDelivery_Hidestash1](../../gamemodes/ix_cotz/plugins/progression/sh_oldtimerprog.lua#L320) | completion | `hidestasher_cleaningkit` |
| [oldtimerItemDelivery_Hidestash2](../../gamemodes/ix_cotz/plugins/progression/sh_oldtimerprog.lua#L399) | completion | `hidestasher_shovel` |

### Spicy Lemon (`cooknpc`)

**Base sales:** `hightiercooker`, `value_kerosene`, `lowtiercookerfuel`, `drug_cigarette_1`, `drug_cigarette_2`, `drink_bottlebeer_1`, `drink_canbeer_1`, `drink_canbeer_2`, `drink_bottletea`, `drink_bottlewater`, `drink_vodka_1`, `drink_vodka_2`, `drink_vodka_3`, `food_can_sprats`, `waterflask`

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** No.

**Active barter outputs:** `miscaid_swampbrew`, `drug_glucose`, `medic_stimpak_2`, `food_mre_ukraine`, `food_mre_russia`, `food_mre_usa`

| Granting progression | Gate | Purchase authorisation |
|---|---|---|
| [spicylemonItemDelivery_Food_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L382) | completion | `drink_canwater` |
| [spicylemonItemDelivery_Food_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L382) | completion | `drink_bottlebeer_6` |
| [spicylemonItemDelivery_Food_stage2](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L408) | completion | `food_nuts_2` |
| [spicylemonItemDelivery_Food_stage2](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L408) | completion | `food_cheese_2` |
| [spicylemonItemDelivery_Food_stage3](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L434) | completion | `food_can_tomato` |
| [spicylemonItemDelivery_Food_stage3](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L434) | completion | `food_can_tushonka` |
| [spicylemonItemDelivery_Vodka_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L532) | completion | `drink_vodka_4` |
| [spicylemonItemDelivery_Spirits_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L615) | completion | `drink_wine` |
| [spicylemonItemDelivery_Medical1](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L3) | completion | `drug_mints` |
| [spicylemonItemDelivery_Medical2](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L54) | completion | `drug_caffeine` |
| [spicylemonItemDelivery_Medical3](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L105) | completion | `medic_psyheal_1` |
| [spicylemonItemDelivery_Medical4](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L160) | completion | `medic_antipsychotic_1` |
| [spicylemonItemDelivery_Medical5](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L213) | completion | `drug_painkillers` |
| [spicylemonItemDelivery_Medical6](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L268) | completion | `drug_adrenaline` |
| [spicylemonItemDelivery_Medical7](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L325) | completion | `drug_morphine` |
| [spicylemonItemDelivery_Food](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L461) | completion | `drink_energydrink_4` |
| [spicylemonItemDelivery_Food](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L461) | completion | `drink_energydrink_2` |
| [spicylemonItemDelivery_Vodka](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L558) | completion | `drink_vodka_5` |
| [spicylemonItemDelivery_Vodka](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L558) | completion | `drink_vodka_6` |
| [spicylemonItemDelivery_Spirits](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L642) | completion | `drink_spirit_1` |
| [spicylemonItemDelivery_Spirits](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L642) | completion | `drink_spirit_2` |
| [spicylemonItemDelivery_Spirits](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L642) | completion | `drink_spirit_3` |
| [spicylemonItemDelivery_Brew](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L727) | completion | `miscaid_swampbrew` |

### Haggler (`tradernpc`)

**Base sales:** `762x25`, `9x18`, `12gauge`, `762x54`, `762x39`, `556x45`, `545x39`, `22lr`, `45acp`, `45acp41`, `ij600`, `mp27`, `c96`, `cz52`, `makarov`, `tokarev`, `m1917`, `skorpion`, `obrez`

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** No.

**Active barter outputs:** `kit_reward_ammo_tier01`, `kit_reward_ammo_tier02`, `kit_reward_ammo_tier03`

| Granting progression | Gate | Purchase authorisation |
|---|---|---|
| [hagglerItemDelivery_1_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L3) | completion | `fort12` |
| [hagglerItemDelivery_11_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L88) | completion | `lax410s` |
| [hagglerItemDelivery_121_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L390) | completion | `sks` |
| [hagglerItemDelivery_122_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L642) | completion | `kiparis` |
| [hagglerItemDelivery_22_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L1197) | completion | `mp34` |
| [hagglerItemDelivery_221_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L1277) | completion | `w1895` |
| [hagglerItemDelivery_1](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L28) | completion | `m1911` |
| [hagglerItemDelivery_1](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L28) | completion | `brhp` |
| [hagglerItemDelivery_11](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L113) | completion | `sten` |
| [hagglerItemDelivery_111](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L169) | completion | `lax410` |
| [hagglerItemDelivery_1111](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L223) | completion | `swmodel29` |
| [hagglerItemDelivery_1111](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L223) | completion | `44magnum` |
| [hagglerItemDelivery_112](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L278) | completion | `sterling` |
| [hagglerItemDelivery_12](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L335) | completion | `toz66` |
| [hagglerItemDelivery_12](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L335) | completion | `toz66short` |
| [hagglerItemDelivery_121](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L415) | completion | `rugermini14` |
| [hagglerItemDelivery_1211](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L474) | completion | `saigasemi` |
| [hagglerItemDelivery_12111](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L529) | completion | `w9422357` |
| [hagglerItemDelivery_12111](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L529) | completion | `357magnum` |
| [hagglerItemDelivery_121111](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L586) | completion | `g2contender500` |
| [hagglerItemDelivery_121111](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L586) | completion | `500magnum` |
| [hagglerItemDelivery_122](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L667) | completion | `kp31` |
| [hagglerItemDelivery_1221](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L722) | completion | `mac11` |
| [hagglerItemDelivery_12211](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L774) | completion | `m1911chic` |
| [hagglerItemDelivery_2](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L828) | completion | `toz34` |
| [hagglerItemDelivery_2](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L828) | completion | `toz34short` |
| [hagglerItemDelivery_21](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L880) | completion | `sako85nato` |
| [hagglerItemDelivery_211](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L932) | completion | `c96carbine` |
| [hagglerItemDelivery_2111](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L987) | completion | `ppsh` |
| [hagglerItemDelivery_212](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L1040) | completion | `toz194` |
| [hagglerItemDelivery_2121](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L1092) | completion | `m1887` |
| [hagglerItemDelivery_21211](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L1144) | completion | `ithaca37` |
| [hagglerItemDelivery_22](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L1222) | completion | `saigasemi545` |
| [hagglerItemDelivery_221](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L1302) | completion | `sako85` |
| [hagglerItemDelivery_2211](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L1359) | completion | `mosin` |
| [hagglerItemDelivery_22111](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L1411) | completion | `svt40` |
| [hagglerItemDelivery_222](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L1464) | completion | `mp40` |
| [hagglerItemDelivery_2221](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L1516) | completion | `aks74u` |
| [hagglerItemDelivery_22211](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L1571) | completion | `akm` |

### Mute (`stalkernetnpc`)

**Base sales:** `headlamp`, `geigercounter`, `binoculars_5`, `compass`, `gpstracker`, `guitar`

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** No.

**Active barter outputs:** None declared.

| Granting progression | Gate | Purchase authorisation |
|---|---|---|
| [stalkerNetAdminDelivery_mainRadioTower](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L395) | completion | `quest_flashdrive` |
| [muteItemDelivery_Binoc1](../../gamemodes/ix_cotz/plugins/progression/sh_muteprog.lua#L3) | completion | `binoculars_2` |
| [muteItemDelivery_Binoc2](../../gamemodes/ix_cotz/plugins/progression/sh_muteprog.lua#L55) | completion | `binoculars_1` |
| [muteItemDelivery_Binoc3](../../gamemodes/ix_cotz/plugins/progression/sh_muteprog.lua#L127) | completion | `binoculars_4` |
| [muteItemDelivery_Binoc4](../../gamemodes/ix_cotz/plugins/progression/sh_muteprog.lua#L206) | completion | `binoculars_3` |
| [muteItemDelivery_Anomaly](../../gamemodes/ix_cotz/plugins/progression/sh_muteprog.lua#L264) | completion | `anomalydetector` |
| [muteItemDelivery_Detector](../../gamemodes/ix_cotz/plugins/progression/sh_muteprog.lua#L338) | completion | `detectorecho` |

### Egghead (`ecologistnpc`)

**Base sales:** None declared.

**Explicit buy-only entries:** `part_bear`, `part_blinddog`, `part_bloodsucker`, `part_boar`, `part_burer_1`, `part_burer_2`, `part_cat`, `part_chimera`, `part_controller_1`, `part_controller_2`, `part_electrocontroller_1`, `part_electrocontroller_2`, `part_flesh`, `part_izlom`, `part_hellhound`, `part_karlik_1`, `part_karlik_2`, `part_pseudodog`, `part_pseudogiant`, `part_psydog`, `part_skeleton`, `part_snork_1`, `part_snork_2`, `part_spider`, `part_sprig`, `part_swampcontroller_1`, `part_swampcontroller_2`, `part_tark`, `part_tushkano`, `part_vareshka`, `part_zombie_1`, `part_zombie_2`, `hide_blinddog`, `hide_bloodsucker`, `hide_bear`, `hide_boar`, `hide_burer`, `hide_cat`, `hide_chimera`, `hide_controller`, `hide_electrocontroller`, `hide_flesh`, `hide_karlik`, `hide_pseudodog`, `hide_pseudogiant`, `hide_spider`, `hide_sprig`, `hide_swampcontroller`, `hide_tushkano`, `hide_tark`, `hide_vareshka`, `artifact_grapes`, `artifact_arachno`, `artifact_battery`, `artifact_blowncap`, `artifact_bolt`, `artifact_bonecluster`, `artifact_capacitor`, `artifact_cell`, `artifact_crystal`, `artifact_droplet`, `artifact_dwarfgalaxy`, `artifact_eye`, `artifact_flame`, `artifact_flash`, `artifact_gaia`, `artifact_galaxy`, `artifact_gmamasbeads`, `artifact_halo`, `artifact_kolobok`, `artifact_mamasbeads`, `artifact_mementomori`, `artifact_mica`, `artifact_midas`, `artifact_moonlight`, `artifact_mycelia`, `artifact_panacea`, `artifact_slime`, `artifact_slug`, `artifact_sparkler`, `artifact_thorn`, `artifact_urchin`, `artifact_photo`, `artifact_moon`, `artifact_compass`, `artifact_storm`

**Buy-all enabled:** No.

**Active barter outputs:** None declared.

| Granting progression | Gate | Purchase authorisation |
|---|---|---|
| [intern_gasAnalyzerReadings](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L717) | completion | `quest_computeraccess` |
| [intern_gasAnalyzerReadings](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L717) | completion | `accesscard_laboratory` |
| [eggheadItemDelivery_Detector1](../../gamemodes/ix_cotz/plugins/progression/sh_eggheadprog.lua#L3) | completion | `detectorecho` |
| [eggheadItemDelivery_Detector2](../../gamemodes/ix_cotz/plugins/progression/sh_eggheadprog.lua#L62) | completion | `detectorbear` |
| [eggheadItemDelivery_Detector3](../../gamemodes/ix_cotz/plugins/progression/sh_eggheadprog.lua#L143) | completion | `detectorveles` |
| [eggheadItemDelivery_Suit1](../../gamemodes/ix_cotz/plugins/progression/sh_eggheadprog.lua#L183) | completion | `suit_ssp99` |
| [eggheadItemDelivery_Suit2](../../gamemodes/ix_cotz/plugins/progression/sh_eggheadprog.lua#L241) | completion | `suit_ssp99m` |
| [eggheadItemDelivery_Suit3](../../gamemodes/ix_cotz/plugins/progression/sh_eggheadprog.lua#L279) | completion | `suit_seva` |
| [eggheadItemDelivery_Aid1](../../gamemodes/ix_cotz/plugins/progression/sh_eggheadprog.lua#L367) | completion | `medic_stimpak_1` |
| [eggheadItemDelivery_Aid2](../../gamemodes/ix_cotz/plugins/progression/sh_eggheadprog.lua#L431) | completion | `medic_stimpak_2` |
| [eggheadItemDelivery_Aid3](../../gamemodes/ix_cotz/plugins/progression/sh_eggheadprog.lua#L497) | completion | `medic_stimpak_3` |
| [eggheadItemDelivery_Aid1_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_eggheadprog.lua#L316) | completion | `medic_psyheal_2` |
| [eggheadItemDelivery_Aid1_stage2](../../gamemodes/ix_cotz/plugins/progression/sh_eggheadprog.lua#L342) | completion | `medic_antirad_2` |
| [eggheadItemDelivery_Aid2_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_eggheadprog.lua#L405) | completion | `medic_antipsychotic_2` |
| [eggheadItemDelivery_Aid3_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_eggheadprog.lua#L470) | completion | `medic_antipsychotic_3` |

### Beanstalk (`ecologistnpc2`)

**Base sales:** `headwear_screen`, `pp2000`, `9x19`, `9x21`

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** No.

**Active barter outputs:** None declared.

**Progression purchase authorisations:** None declared.

### Intern (`ecologistnpc3`)

**Base sales:** `anomalydetector`, `geigercounter`, `medic_psyheal_1`, `medic_antirad_1`, `medic_medkit_5`, `medic_medkit_6`, `medic_antipsychotic_1`

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** Yes.

**Active barter outputs:** None declared.

**Progression purchase authorisations:** None declared.

### Quartermaster (`unisgnpc`)

**Base sales:** `9x18`, `9x18hp`, `9x19`, `9x19hp`, `9x21`, `45acp`, `357magnum`, `44magnum`, `762x39`, `556x45`, `545x39`, `762x51`, `762x54`, `12gauge`, `12gaugesg`, `9x39`, `57x28`, `50ae`, `glock17`, `ar159mm`, `mp5k`, `pp2000`, `stoegerdd`, `stoegerddshort`, `m3supershort`, `beretta92`, `p99`

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** Yes.

**Active barter outputs:** `kit_ammo_rare`, `kit_ammo_m_rare`, `556x45ap`, `556x45hp`, `44magnumap`, `44magnumhp`, `762x51ap`, `762x51hp`

| Granting progression | Gate | Purchase authorisation |
|---|---|---|
| [quartermasterFieldEquipment1](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L1474) | completion | `kobra` |
| [quartermasterFieldEquipment1](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L1474) | completion | `foregrip` |
| [quartermasterFieldEquipment2](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L1497) | completion | `eotech` |
| [quartermasterFieldEquipment2](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L1497) | completion | `aimpoint` |
| [quartermasterFieldEquipment2](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L1497) | completion | `microt1` |
| [quartermasterItemDelivery_1_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L3) | completion | `mp5` |
| [quartermasterItemDelivery_11_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L88) | completion | `mateba` |
| [quartermasterItemDelivery_11_stage2](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L113) | completion | `ak74` |
| [quartermasterItemDelivery_111_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L197) | completion | `lax44` |
| [quartermasterItemDelivery_112_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L341) | completion | `aek971` |
| [quartermasterItemDelivery_12_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L547) | completion | `m3super90` |
| [quartermasterItemDelivery_121_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L630) | completion | `ump45` |
| [quartermasterItemDelivery_21_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L942) | completion | `taurusragingbull` |
| [quartermasterItemDelivery_211_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L1025) | completion | `uzi` |
| [quartermasterItemDelivery_22_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L1218) | completion | `rem870ae` |
| [quartermasterItemDelivery_1](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L29) | completion | `mossberg500` |
| [quartermasterItemDelivery_11](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L139) | completion | `l85` |
| [quartermasterItemDelivery_111](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L223) | completion | `g36c` |
| [quartermasterItemDelivery_1111](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L284) | completion | `sg552` |
| [quartermasterItemDelivery_112](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L367) | completion | `an94k` |
| [quartermasterItemDelivery_1121](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L427) | completion | `rk95` |
| [quartermasterItemDelivery_11211](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L487) | completion | `ak12` |
| [quartermasterItemDelivery_12](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L574) | completion | `fiveseven` |
| [quartermasterItemDelivery_121](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L656) | completion | `p90` |
| [quartermasterItemDelivery_122](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L713) | completion | `lr300` |
| [quartermasterItemDelivery_1221](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L770) | completion | `m16a4` |
| [quartermasterItemDelivery_12211](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L830) | completion | `fnfal` |
| [quartermasterItemDelivery_2](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L889) | completion | `swr8` |
| [quartermasterItemDelivery_21](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L969) | completion | `mp9a1` |
| [quartermasterItemDelivery_211](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L1051) | completion | `pp1901vityaz` |
| [quartermasterItemDelivery_212](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L1107) | completion | `famas` |
| [quartermasterItemDelivery_2121](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L1163) | completion | `aug` |
| [quartermasterItemDelivery_22](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L1244) | completion | `mr96` |
| [quartermasterItemDelivery_221](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L1305) | completion | `mp153` |
| [quartermasterItemDelivery_222](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L1361) | completion | `sv98` |
| [quartermasterItemDelivery_2221](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L1417) | completion | `svd` |

### Boss (`unisgnpc2`)

**Base sales:** `9x18hp`, `9x19`, `9x19hp`, `9x21`, `45acp`, `357magnum`, `44magnum`, `762x39`, `556x45`, `545x39`, `762x51`, `762x54`, `9x39`, `57x28`, `12gauge`, `12gaugesg`, `12gaugetr`, `headwear_altyn`

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** No.

**Active barter outputs:** None declared.

| Granting progression | Gate | Purchase authorisation |
|---|---|---|
| [bossItemDelivery_1](../../gamemodes/ix_cotz/plugins/progression/sh_bossprog.lua#L3) | completion | `suit_io7a` |
| [bossItemDelivery_2](../../gamemodes/ix_cotz/plugins/progression/sh_bossprog.lua#L74) | completion | `suit_ps5m` |
| [bossItemDelivery_3](../../gamemodes/ix_cotz/plugins/progression/sh_bossprog.lua#L147) | completion | `suit_berill` |
| [bossItemDelivery_4](../../gamemodes/ix_cotz/plugins/progression/sh_bossprog.lua#L200) | completion | `suit_skat10` |
| [bossItemDelivery_5](../../gamemodes/ix_cotz/plugins/progression/sh_bossprog.lua#L250) | completion | `suit_skat9` |
| [bossItemDelivery_6](../../gamemodes/ix_cotz/plugins/progression/sh_bossprog.lua#L326) | completion | `suit_radsuit` |
| [bossItemDelivery_7](../../gamemodes/ix_cotz/plugins/progression/sh_bossprog.lua#L405) | completion | `suit_exoskeleton` |
| [smartass_rfTasks](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L595) | completion | `accesscard_bunker` |
| [bossItemDelivery_6_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_bossprog.lua#L301) | completion | `headwear_rad` |
| [bossItemDelivery_7_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_bossprog.lua#L379) | completion | `headwear_spartan` |

### Smartass (`unisgnpc3`)

**Base sales:** None declared.

**Explicit buy-only entries:** `part_bear`, `part_blinddog`, `part_bloodsucker`, `part_boar`, `part_burer_1`, `part_burer_2`, `part_cat`, `part_chimera`, `part_controller_1`, `part_controller_2`, `part_electrocontroller_1`, `part_electrocontroller_2`, `part_flesh`, `part_izlom`, `part_hellhound`, `part_karlik_1`, `part_karlik_2`, `part_pseudodog`, `part_pseudogiant`, `part_psydog`, `part_skeleton`, `part_snork_1`, `part_snork_2`, `part_spider`, `part_sprig`, `part_swampcontroller_1`, `part_swampcontroller_2`, `part_tark`, `part_tushkano`, `part_vareshka`, `part_zombie_1`, `part_zombie_2`, `hide_blinddog`, `hide_bloodsucker`, `hide_bear`, `hide_boar`, `hide_burer`, `hide_cat`, `hide_chimera`, `hide_controller`, `hide_electrocontroller`, `hide_flesh`, `hide_karlik`, `hide_pseudodog`, `hide_pseudogiant`, `hide_spider`, `hide_sprig`, `hide_swampcontroller`, `hide_tushkano`, `hide_tark`, `hide_vareshka`, `artifact_grapes`, `artifact_arachno`, `artifact_battery`, `artifact_blowncap`, `artifact_bolt`, `artifact_bonecluster`, `artifact_capacitor`, `artifact_cell`, `artifact_crystal`, `artifact_droplet`, `artifact_dwarfgalaxy`, `artifact_eye`, `artifact_flame`, `artifact_flash`, `artifact_gaia`, `artifact_galaxy`, `artifact_gmamasbeads`, `artifact_halo`, `artifact_kolobok`, `artifact_mamasbeads`, `artifact_mementomori`, `artifact_mica`, `artifact_midas`, `artifact_moonlight`, `artifact_mycelia`, `artifact_panacea`, `artifact_slime`, `artifact_slug`, `artifact_sparkler`, `artifact_thorn`, `artifact_urchin`, `artifact_photo`, `artifact_moon`, `artifact_compass`, `artifact_storm`

**Buy-all enabled:** No.

**Active barter outputs:** None declared.

| Granting progression | Gate | Purchase authorisation |
|---|---|---|
| [smartass_rfTasks](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L595) | checkpoint 3 | `pso1` |
| [smartassRecon1](../../gamemodes/ix_cotz/plugins/progression/sh_smartassprog.lua#L1) | completion | `pso1` |
| [smartassRecon1](../../gamemodes/ix_cotz/plugins/progression/sh_smartassprog.lua#L1) | completion | `cmore` |
| [smartassRecon2](../../gamemodes/ix_cotz/plugins/progression/sh_smartassprog.lua#L29) | completion | `acog` |
| [smartassRecon2](../../gamemodes/ix_cotz/plugins/progression/sh_smartassprog.lua#L29) | completion | `shortdot` |
| [smartassRecon3](../../gamemodes/ix_cotz/plugins/progression/sh_smartassprog.lua#L56) | completion | `nightforce` |
| [smartassRecon3](../../gamemodes/ix_cotz/plugins/progression/sh_smartassprog.lua#L56) | completion | `pbssuppressor` |
| [smartassRecon3](../../gamemodes/ix_cotz/plugins/progression/sh_smartassprog.lua#L56) | completion | `sakersuppressor` |
| [smartassRecon3](../../gamemodes/ix_cotz/plugins/progression/sh_smartassprog.lua#L56) | completion | `tundrasuppressor` |
| [smartassRecon3](../../gamemodes/ix_cotz/plugins/progression/sh_smartassprog.lua#L56) | completion | `cobrasuppressor` |

### Hoarder (`raritynpc`)

**Base sales:** `500magnum`, `50ae`, `57x28`, `93x64`, `127x55`, `145x114`, `700nitro`, `338lapua`, `12gaugemg`, `12gaugedt`

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** No.

**Active barter outputs:** None declared.

| Granting progression | Gate | Purchase authorisation |
|---|---|---|
| [hoarderCollection2](../../gamemodes/ix_cotz/plugins/progression/sh_hoarderprog.lua#L21) | completion | `sw500` |
| [hoarderCollection3](../../gamemodes/ix_cotz/plugins/progression/sh_hoarderprog.lua#L42) | completion | `vssk` |
| [hoarderCollection4](../../gamemodes/ix_cotz/plugins/progression/sh_hoarderprog.lua#L63) | completion | `nitro` |

### Computer (`computernpc`)

**Base sales:** None declared.

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** No.

**Active barter outputs:** None declared.

**Progression purchase authorisations:** None declared.

### Jitters (`medicnpc`)

**Base sales:** `medic_bandage_1`

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** No.

**Active barter outputs:** None declared.

| Granting progression | Gate | Purchase authorisation |
|---|---|---|
| [jittersItemDelivery_medical1_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_jittersprog.lua#L3) | completion | `medic_medkit_1` |
| [jittersItemDelivery_medical2_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_jittersprog.lua#L78) | completion | `medic_bandage_2` |
| [jittersItemDelivery_medical2_stage2](../../gamemodes/ix_cotz/plugins/progression/sh_jittersprog.lua#L103) | completion | `medic_antirad_1` |
| [jittersItemDelivery_medical3_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_jittersprog.lua#L194) | completion | `medic_bandage_3` |
| [jittersItemDelivery_medical4_stage1](../../gamemodes/ix_cotz/plugins/progression/sh_jittersprog.lua#L271) | completion | `medic_medkit_5` |
| [jittersItemDelivery_medical4_stage2](../../gamemodes/ix_cotz/plugins/progression/sh_jittersprog.lua#L297) | completion | `medic_medkit_6` |
| [jittersItemDelivery_medical1](../../gamemodes/ix_cotz/plugins/progression/sh_jittersprog.lua#L28) | completion | `medic_medkit_2` |
| [jittersItemDelivery_medical2](../../gamemodes/ix_cotz/plugins/progression/sh_jittersprog.lua#L128) | completion | `medic_medkit_3` |
| [jittersItemDelivery_medical3](../../gamemodes/ix_cotz/plugins/progression/sh_jittersprog.lua#L220) | completion | `medic_medkit_4` |
| [jittersItemDelivery_medical4](../../gamemodes/ix_cotz/plugins/progression/sh_jittersprog.lua#L324) | completion | `medic_antirad_2` |

### The Original (`firststalkernpc`)

**Base sales:** `drink_vodka_2`, `drink_bottlebeer_3`, `drink_canbeer_1`, `drink_canbeer_2`, `drink_bottlewaterdirty`, `food_oldmeat`, `food_can_tushonka`, `food_can_sprats`, `knife1`, `hidestasher_cutlery`, `lowtiercooker`, `lowtiercookerfuel`

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** No.

**Active barter outputs:** None declared.

**Progression purchase authorisations:** None declared.

### ??? (`cconnpc`)

**Base sales:** None declared.

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** No.

**Active barter outputs:** None declared.

**Progression purchase authorisations:** None declared.

### Arena Master (`arenanpc`)

**Base sales:** `medic_medkit_1`

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** No.

**Active barter outputs:** None declared.

**Progression purchase authorisations:** None declared.

### NPC (`ratnpc`)

**Base sales:** None declared.

**Explicit buy-only entries:** None declared.

**Buy-all enabled:** Yes.

**Active barter outputs:** None declared.

**Progression purchase authorisations:** None declared.

## Appendix B — current personal supply-capacity milestones

Values are total bonus from base, not additional bonuses to sum. Purchase access still applies.

| Contact | Granting progression | Total bonus | Eligible IDs |
|---|---|---|---|
| 'Egghead' | [eggheadItemDelivery_Aid1](../../gamemodes/ix_cotz/plugins/progression/sh_eggheadprog.lua#L367) | +1 | `medic_psyheal_2`, `medic_stimpak_1` |
| 'Haggler' | [hagglerItemDelivery_11](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L113) | +1 | `12gauge`, `9x18`, `762x25`, `762x39`, `762x54` |
| 'Haggler' | [hagglerItemDelivery_1211](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L474) | +2 | `12gauge`, `9x18`, `762x25`, `762x39`, `762x54` |
| 'Haggler' | [hagglerItemDelivery_22111](../../gamemodes/ix_cotz/plugins/progression/sh_hagglerprog.lua#L1411) | +2 | `12gauge`, `9x18`, `762x25`, `762x39`, `762x54` |
| 'Jitters' | [jittersItemDelivery_medical2](../../gamemodes/ix_cotz/plugins/progression/sh_jittersprog.lua#L128) | +1 | `medic_bandage_1`, `medic_bandage_2`, `medic_bandage_3`, `medic_medkit_1`, `medic_medkit_2`, `medic_medkit_3`, `medic_medkit_4`, `medic_medkit_5`, `medic_medkit_6` |
| 'Jitters' | [jittersItemDelivery_medical4](../../gamemodes/ix_cotz/plugins/progression/sh_jittersprog.lua#L324) | +2 | `medic_bandage_1`, `medic_bandage_2`, `medic_bandage_3`, `medic_medkit_1`, `medic_medkit_2`, `medic_medkit_3`, `medic_medkit_4`, `medic_medkit_5`, `medic_medkit_6` |
| 'Old Timer' | [oldtimerItemDelivery_Knife2](../../gamemodes/ix_cotz/plugins/progression/sh_oldtimerprog.lua#L77) | +1 | `medic_bandage_1`, `medic_bandage_2` |
| 'Quartermaster' | [quartermasterItemDelivery_11](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L139) | +1 | `545x39`, `556x45`, `762x39`, `762x51`, `9x19` |
| 'Quartermaster' | [quartermasterItemDelivery_11211](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L487) | +2 | `545x39`, `556x45`, `762x39`, `762x51`, `9x19` |
| 'Quartermaster' | [quartermasterItemDelivery_12211](../../gamemodes/ix_cotz/plugins/progression/sh_quarterprog.lua#L830) | +2 | `545x39`, `556x45`, `762x39`, `762x51`, `9x19` |
| 'Spicy Lemon' | [spicylemonItemDelivery_Food](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L461) | +1 | `drink_bottlewater`, `drink_bottletea`, `food_can_sprats`, `food_cheese_2`, `food_nuts_2`, `food_can_tomato`, `food_can_tushonka` |
| 'Spicy Lemon' | [spicylemonItemDelivery_Brew](../../gamemodes/ix_cotz/plugins/progression/sh_spicylemonprog.lua#L727) | +2 | `drink_bottlewater`, `drink_bottletea`, `food_can_sprats`, `food_cheese_2`, `food_nuts_2`, `food_can_tomato`, `food_can_tushonka` |

## Appendix C — current fixed benefits and service discounts

Checkpoint counts are cumulative. Items use their existing default quantities unless specified in source. Credits belong to the named redemption provider.

| Contact / milestone | Award timing | Fixed benefit |
|---|---|---|
| 'Boss' / [boss_dataTasks](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L532) | 1 jobs | 500 repair credit at 'Technut' |
| 'Smartass' / [smartass_rfTasks](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L595) | 1 jobs | `9x19` |
| 'Intern' / [intern_gasAnalyzerReadings](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L717) | 2 jobs | `medic_antirad_1` |
| 'Intern' / [intern_gasAnalyzerReadings](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L717) | 6 jobs | `drink_bottletea`; `medic_medkit_1` |
| 'Intern' / [intern_gasAnalyzerReadings](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L717) | 11 jobs | `medic_psyheal_2` |
| 'Computer' / [computer_artifactTasks](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L846) | 3 jobs | `medic_antirad_1` |
| 'Computer' / [computer_artifactTasks](../../gamemodes/ix_cotz/plugins/progression/sh_definitions.lua#L846) | 8 jobs | `medic_psyheal_2` |
| 'The Original' / [originalSurvival1](../../gamemodes/ix_cotz/plugins/progression/sh_originalprog.lua#L1) | Completion | `food_can_tushonka`; `drink_bottlewater` |
| 'The Original' / [originalSurvival2](../../gamemodes/ix_cotz/plugins/progression/sh_originalprog.lua#L21) | Completion | `lowtiercookerfuel` |
| 'The Original' / [originalSurvival3](../../gamemodes/ix_cotz/plugins/progression/sh_originalprog.lua#L41) | Completion | `medic_bandage_2`; `food_can_tushonka` |
| 'Hoarder' / [hoarderCollection1](../../gamemodes/ix_cotz/plugins/progression/sh_hoarderprog.lua#L1) | Completion | `500magnum` |
| 'Hoarder' / [hoarderCollection2](../../gamemodes/ix_cotz/plugins/progression/sh_hoarderprog.lua#L21) | Completion | `500magnum` |
| 'Hoarder' / [hoarderCollection3](../../gamemodes/ix_cotz/plugins/progression/sh_hoarderprog.lua#L42) | Completion | `127x55` |
| 'Hoarder' / [hoarderCollection4](../../gamemodes/ix_cotz/plugins/progression/sh_hoarderprog.lua#L63) | Completion | `700nitro` |
| '???' / [noosphereAttunement1](../../gamemodes/ix_cotz/plugins/progression/sh_noosphereprog.lua#L1) | Completion | Recognition: Heard by the Noosphere |
| '???' / [noosphereAttunement2](../../gamemodes/ix_cotz/plugins/progression/sh_noosphereprog.lua#L22) | Completion | 25000 wish credit at '???' |
| '???' / [noosphereAttunement3](../../gamemodes/ix_cotz/plugins/progression/sh_noosphereprog.lua#L42) | Earned completion | 2.5% wish discount at '???' |
| '???' / [noosphereAttunement3](../../gamemodes/ix_cotz/plugins/progression/sh_noosphereprog.lua#L42) | Completion | Recognition: Witness of the Noosphere |
| NPC / [communitySupport1](../../gamemodes/ix_cotz/plugins/progression/sh_communityprog.lua#L1) | Completion | `drink_bottlewater`; `drink_bottletea` |
| NPC / [communitySupport2](../../gamemodes/ix_cotz/plugins/progression/sh_communityprog.lua#L21) | Completion | `medic_bandage_1` |
| NPC / [communitySupport3](../../gamemodes/ix_cotz/plugins/progression/sh_communityprog.lua#L41) | Completion | `food_can_tushonka` |
| NPC / [communitySupport3](../../gamemodes/ix_cotz/plugins/progression/sh_communityprog.lua#L41) | Completion | Recognition: Trusted Community Supplier |
| 'Cleaner' / [cleanerLogistics1](../../gamemodes/ix_cotz/plugins/progression/sh_cleanerprog.lua#L51) | Completion | 300 storage credit at 'Cleaner' |
| 'Cleaner' / [cleanerLogistics2](../../gamemodes/ix_cotz/plugins/progression/sh_cleanerprog.lua#L75) | Completion | 600 storage credit at 'Cleaner' |
| 'Cleaner' / [cleanerLogistics2](../../gamemodes/ix_cotz/plugins/progression/sh_cleanerprog.lua#L75) | Earned completion | 5.0% storage discount at 'Cleaner' |
| 'Beanstalk' / [beanstalkExpedition1](../../gamemodes/ix_cotz/plugins/progression/sh_beanstalkprog.lua#L52) | Completion | `medic_antirad_1`; `medic_psyheal_1` |
| 'Arena Master' / [arenaProgramme1](../../gamemodes/ix_cotz/plugins/progression/sh_arenaprog.lua#L1) | Completion | 150 treatment credit at 'Arena Master' |
| 'Arena Master' / [arenaProgramme2](../../gamemodes/ix_cotz/plugins/progression/sh_arenaprog.lua#L19) | Completion | `medic_medkit_1` |
| 'Arena Master' / [arenaProgramme3](../../gamemodes/ix_cotz/plugins/progression/sh_arenaprog.lua#L37) | Earned completion | 10.0% treatment discount at 'Arena Master' |
| 'Arena Master' / [arenaProgramme3](../../gamemodes/ix_cotz/plugins/progression/sh_arenaprog.lua#L37) | Completion | Recognition: Arena Veteran |
| 'Jitters' / [jittersItemDelivery_medical3](../../gamemodes/ix_cotz/plugins/progression/sh_jittersprog.lua#L220) | Earned completion | 5.0% treatment discount at 'Jitters' |
| 'Technut' / [technutItemDelivery_SuitPainting](../../gamemodes/ix_cotz/plugins/progression/sh_technutprog.lua#L474) | Earned completion | 5.0% repair discount at 'Technut' |
