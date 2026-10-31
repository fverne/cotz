# Quartermaster: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Waystation. Every hand-in and reward claim occurs here.
- **Identity:** Existing stern procurement contact.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Ammunition deliveries.
- **Finite plan:** 24 steps; **6 hand-ins, 6 job checkpoints, 12 authored objectives**.
- **Step labels:** QM01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 4 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | QM01–QM04 | Supply credibility |
| 2 | QM05–QM10 | Procurement records |
| 3 | QM11–QM14 | Equipment branches |
| 4 | QM15–QM20 | Expedition outfitting |
| 5 | QM21–QM24 | Supply agreement |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Supply credibility

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| QM01 | A Supplier's Credentials | Hand-in | Deliver accessible ammunition and supply documents. | First entry military weapon purchase. |
| QM02 | The Missing Requisition | Authored | Recover a procurement record in Waystation territory. | Supply-branch information. |
| QM03 | On the Register | Tracker | Cumulative checkpoint C1: complete initial ammunition-delivery checkpoint. | One compatible ammunition purchase. |
| QM04 | The Misrouted Crate | Authored | Recover a sealed equipment case on a regional route. | Field preparation supplies. |

### Chapter 2: Procurement records

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| QM05 | Standard Issue | Hand-in | Supply ordinary operational ammunition. | First military weapon sidegrade. |
| QM06 | The Depot Copy | Authored | Retrieve a depot register in Garbage. | Brass relationship response. |
| QM07 | Enough for the Patrol | Tracker | Cumulative checkpoint C2: reach the next ammunition checkpoint. | First armour-family entry unlock after its verified predecessor. |
| QM08 | The Supplier's Mark | Authored | Recover supplier evidence from an abandoned freight site. | Equipment procurement lead. |
| QM09 | Fittings and Mounts | Hand-in | Deliver existing weapon-fitting supplies. | First compatible attachment purchase. |
| QM10 | The Returned Equipment | Authored | Recover a field inspection record in Waystation territory. | Suture relationship response. |

### Chapter 3: Equipment branches

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| QM11 | Steel Earned | Tracker | Cumulative checkpoint C3: reach the blade-procurement ammunition checkpoint. | knife4 purchase; also requires Old Timer step 12. |
| QM12 | The Lost Agreement | Authored | Recover the old procurement contract. | Regional expedition lead. |
| QM13 | More Than One Role | Hand-in | Supply a second operational ammunition family. | Next weapon role sidegrade. |
| QM14 | The Wrong Model | Authored | Recover a serial-number record for a diverted shipment. | Equipment investigation clue. |

### Chapter 4: Expedition outfitting

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| QM15 | A Dependable Reserve | Tracker | Cumulative checkpoint C4: maintain regional ammunition orders. | Selected operational ammunition reserve. |
| QM16 | The Field Test | Authored | Retrieve an equipment-trial recorder from a remote site. | Later procurement lead. |
| QM17 | Ready for Deployment | Hand-in | Deliver source-verified expedition ammunition. | Next verified weapon tier after its lower-tier milestone. |
| QM18 | The Pripyat Manifest | Authored | Recover expedition supply records in Pripyat. | Pripyat equipment lead. |
| QM19 | Kept Supplied | Tracker | Cumulative checkpoint C5: reach the next ammunition checkpoint. | Next compatible attachment sidegrade. |
| QM20 | The Abandoned Stores | Authored | Recover an equipment case at a Pripyat supply site. | Expedition provisions. |

### Chapter 5: Supply agreement

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| QM21 | Procurement Evidence | Hand-in | Deliver existing administrative records and supplies. | Final military equipment unlock after all relevant lower tiers. |
| QM22 | The Contractor's Copy | Authored | Recover the supply agreement's surviving annex. | Final contract evidence. |
| QM23 | A Standing Agreement | Tracker | Cumulative checkpoint C6: reach the final ammunition checkpoint. | Final selected supply reserve. |
| QM24 | The Signed Requisition | Authored | Retrieve the agreement's last field record and return. | Recognition and permanent procurement barter. |

## Upgrade gates and allocation

QM11 knife4 requires both Old Timer step 12 and his local predecessor QM10. Old Timer step 12 transitively follows knife2 at step 3. Other weapon and armour tiers need actual prior-item milestones at Haggler, Technut, or Boss where appropriate.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

QM11's locked response must explain: “Old Timer needs to finish your survival-blade training first.”
Required cross-contact milestone: [Old Timer step 12](../old-timer.md), not ownership of knife3.

## Relationships and editable dialogue

Values Brass, Ledger, and Suture as suppliers. Has little patience for Smartass; reports professionally to Boss.

| Moment | Draft response |
| --- | --- |
| Greeting | Supplies or requisitions? Make it clear which. |
| About repeatable work | Operational ammunition. Correct calibre, correct quantity. I have no use for excuses. |
| Story conclusion | The agreement stands. Keep your end of it and we'll keep ours. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

No arena gate for essential procurement. Locked blade access must be visible in dialogue and enforced before any alternate reward or barter grants that upgrade.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_quartermaster.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_quartermaster.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_unisgnpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_quartermaster.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | QM01 → QM02 → QM03 → QM04 |
| Supplies and work | QM05 → QM07 → QM09 → QM11 → QM13 → QM15 → QM17 → QM19 |
| Field work and story | QM06 → QM08 → QM10 → QM12 → QM14 → QM16 → QM18 → QM20 |
| Conclusion after both branches | QM21 → QM22 → QM23 → QM24 |

Equipment gates can add prerequisites across these branches or contacts. The requires and
crossRequires fields plus the shared catalogue upgrade chains are authoritative.
Edit job.kind, job.pools, job.quantities, job.minimumValue and job.maps to tune repeatable work.
Edit dialogue prompts and progression briefings/completion text in the contact definition;
background and gossip remain in the existing conversation file.

The tables above retain the original story/reward direction. Actual item IDs, quantities, cumulative
targets, stock benefits, discounts and catalogue access are now specified by the runtime definitions
and unlock ledger. Field commissions use configured point pools; physical locations still need map
authoring and multiplayer verification. No live rescue or bespoke multi-site investigation mechanic
is implied by the narrative. Arena objectives count completed eligible bouts, not an unreported win.
