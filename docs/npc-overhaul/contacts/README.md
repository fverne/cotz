# Individual town contact designs

[Design overview](../README.md) · [Roster](../roster.md) · [Progression rules](../progression-and-rewards.md)

These 26 new documents cover the other **618** proposed steps. Together with the
[28-step Old Timer example](../old-timer.md), the plan remains **27 contacts and 646 steps**.
The documents are detailed authoring drafts, not runtime definitions or a completed unlock audit.

## How to read a contact document

Each has a contact brief, five chapter ranges, individually named objectives and small rewards,
upgrade requirements, relationship notes, sample dialogue, implementation limits, and source references.
Design labels such as QM11 are review references, not final persistent progression IDs.
Every step follows the previous one unless an additional prerequisite is explicitly stated.
Optional branch redesigns must preserve upgrade order.

Exactly half the steps in these new drafts use ordinary hand-ins or job checkpoints, alternating
hand-in and tracker across those slots. The other half are authored field or competitive objectives.
This is an initial authoring pattern, not a requirement to preserve rigid alternation in final play.

Trackers count only the contact's single repeatable category. C1, C2, etc. name cumulative checkpoints
within that contact's programme; they do not assign quantities. Preserve earned credit and define
when tracking starts before implementation. Arena counts eligible distinct sanctioned opponents.
Authored arena bouts need separately eligible results, not automatic completion from one prior win.

Hand-in pools, quantities, stock increments, prices, reward amounts, and generic equipment slots
remain unassigned where stated. Choose accessible existing items and publish the exact IDs in final
definitions. Unique story evidence is an authored field objective, not an ordinary hand-in.
Task equipment must not quietly grant the higher-tier item a progression is supposed to unlock.

Every claimed stock benefit requires a real catalogue item with an explicit cap. Different
ammunition calibres, optic roles, clothing colours, and protection trade-offs are not automatically
linear upgrades. Proven direct upgrades require their previous-tier milestone on the same character.

Late chapter names or a later map do not enforce access: implement explicit personal dependencies.
Never place a contact, receiving NPC, or claim terminal in Pripyat. Fixed-location field sites,
invented records and identities are proposals until mapped and implemented.

## Contact directory

### Marsh

| Contact | Repeatable category | Steps | Mix: hand-ins / trackers / authored |
| --- | --- | ---: | --- |
| [Old Timer](../old-timer.md) | Mutant hunting | 28 | 7 / 7 / 14 |
| [Spicy Lemon](spicy-lemon.md) | Meal deliveries | 26 | 7 / 6 / 13 |
| [Haggler](haggler.md) | Hostile human elimination | 26 | 7 / 6 / 13 |
| [Jitters](jitters.md) | Medical supply deliveries | 26 | 7 / 6 / 13 |
| [Technut](technut.md) | Industrial salvage deliveries | 28 | 7 / 7 / 14 |
| [Mute](mute.md) | Electronics deliveries | 24 | 6 / 6 / 12 |
| [The Original](the-original.md) | Mutant specimen deliveries | 24 | 6 / 6 / 12 |
| [Atlas](atlas.md) | Sensor deployment and retrieval | 22 | 6 / 5 / 11 |
| [Gasket](gasket.md) | Utility supply deliveries | 22 | 6 / 5 / 11 |
| [Ballast](ballast.md) | Equipment recovery | 22 | 6 / 5 / 11 |

### Garbage

| Contact | Repeatable category | Steps | Mix: hand-ins / trackers / authored |
| --- | --- | ---: | --- |
| [Cleaner](cleaner.md) | Dead-drop circuits | 28 | 7 / 7 / 14 |
| [Arena Master](arena-master.md) | Arena bouts | 22 | 6 / 5 / 11 |
| [Beanstalk](beanstalk.md) | Research defence | 24 | 6 / 6 / 12 |
| [Smartass](smartass.md) | Radio triangulation | 24 | 6 / 6 / 12 |
| [Latch](latch.md) | Industrial salvage deliveries | 22 | 6 / 5 / 11 |
| [Spoor](spoor.md) | Mutant hunting | 22 | 6 / 5 / 11 |
| [Brass](brass.md) | Ammunition deliveries | 24 | 6 / 6 / 12 |
| [Wake](wake.md) | Equipment recovery | 22 | 6 / 5 / 11 |
| [Vesper](vesper.md) | Sensor deployment and retrieval | 24 | 6 / 6 / 12 |

### Waystation

| Contact | Repeatable category | Steps | Mix: hand-ins / trackers / authored |
| --- | --- | ---: | --- |
| [Quartermaster](quartermaster.md) | Ammunition deliveries | 24 | 6 / 6 / 12 |
| [Boss](boss.md) | Hostile human elimination | 22 | 6 / 5 / 11 |
| [Egghead](egghead.md) | Artifact deliveries | 26 | 7 / 6 / 13 |
| [Intern](intern.md) | Sensor deployment and retrieval | 24 | 6 / 6 / 12 |
| [Suture](suture.md) | Textile supply deliveries | 24 | 6 / 6 / 12 |
| [Ledger](ledger.md) | Dead-drop circuits | 22 | 6 / 5 / 11 |
| [Spool](spool.md) | Radio triangulation | 22 | 6 / 5 / 11 |
| [Carbon](carbon.md) | Document deliveries | 22 | 6 / 5 / 11 |

## Explicit upgrade dependencies to preserve

| Family | Draft milestone chain | Status |
| --- | --- | --- |
| Knives | Old Timer 3 (knife2) → Old Timer 12 (knife3) → QM11 (knife4), also after QM10. | Explicit cross-contact prerequisite; do not substitute possession. |
| Sharpening stones | Old Timer 7 → Old Timer 19. | Both branches precede the fine stone. |
| Binoculars | MU01 binoculars_2 → MU05 binoculars_1 → MU13 binoculars_4 → MU17 binoculars_3. | Preserves current source order; suffixes are not tiers. |
| Artifact detectors | EG03 Echo → EG11 Bear → EG21 Veles. | Mute's current Echo access must be merged or equivalently gated. |
| Medkits | JT07 → JT11 → JT15 → JT17 → JT19 → JT23, proposed medic_medkit_1 through _6. | Check effective effects and preserve verified predecessors. |
| Bandages | Existing basic access → JT05 → JT13. | Stock benefits are separate from purchase tiers. |
| Anti-radiation medicine | JT09 → JT21. | Imported alternate sources must obey the same order. |
| Stash equipment | Existing baseline access → CL05 stash Cleaning kit → CL09 Shovel. | Check actual tool interactions and baseline sources. |
| Carrying equipment | SU03 → SU09 → SU15 → SU19. | Exact items and trade-off comparison unresolved; no shortcut at another seller. |
| Reinforcement | TN13 → SU07 → SU11 → SU21 if these are direct replacements. | IDs/stat review required; candidate dependencies are blockers until resolved. |
| Protective suits, headwear, plates, optics, specialised ammunition | See local gates in each contact document; record exact previous item and milestone. | Full shared catalogue audit required before implementation. |

Read the per-contact gates together with the global unlock ledger. Neither these examples nor the
preliminary per-file item lists prove whole-roster coverage. Retain all current vendor item unlocks
somewhere, including those redistributed from excluded contacts, while preserving earned access.
Secret periodic NPC content remains outside the town overhaul and is not advertised by these contacts.
