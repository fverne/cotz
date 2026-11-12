# Authored quest commissions

The town progression has 646 steps. Half of the former 316 field commissions now use ordinary
item deliveries: 158 deliveries and 158 remaining field commissions. Every contact converts half
of its field steps, rounded up or down where needed; Arena Master's competitive bouts stay intact.
The remaining field commissions include 154 custom bound cargo assignments: 113 return to the
issuer, 38 deliver to another contact, and three use a field cache. Four research-defence runs
retain their sampler/results cargo. Milestone IDs, dependencies, benefits and cash awards are unchanged.

Converted requests draw a specific item from the named requirement pool, using the existing saved
requirement selection and unit counting. Bring that item to the issuer; no bound cargo, field site,
second contact or repeatable work completion is required. Their briefings and completion replies now
describe supply work in each contact's voice. Quantities below are initial tuning, requiring economy playtesting.

All 327 finite delivery milestones now scale through four phases using FTS availability:
one common item type early, growing to four types with larger common quantities and smaller
amounts of lower-availability material. See the [FTS availability and balance report](delivery-balance.md)
for point counts, weighting, rarity ratios, generated pools and every current delivery requirement.
Earlier fixed-pool descriptions are superseded. Saved item selections and partial hand-ins remain intact.

## Authoring and acquisition

Edit `field.cargo`, `field.label`, optional `field.description`, and optional `field.recipient` in each contact definition.
`cargo` is a registered item ID; `label` names this particular commission's inventory item;
`description` supplies narrative context alongside the model's physical appearance; `recipient` is a town contact ID. Omit the recipient to return cargo to the issuer. Dead-drop
commissions use their assigned cache endpoint and cannot also have an NPC recipient.
Current NPC recipients have no progression access gate, avoiding circular courier prerequisites.

The 33 concrete cargo definitions live in `townnpcs/items/jobcargo/`, inheriting jobsystem's
`base_jobcargo`. They reuse selected quest-asset models, dimensions, weights and icon cameras,
but have separate `town_quest_*` IDs and zero price. Existing valuable quest IDs and instances
are unchanged. A cargo model can serve several stories; the saved commission label, character
and claim distinguish each physical item. All 158 remaining field commissions declare an assignment-specific
label and description, including the four
research-defence runs that retain the standard results item. For example, the leather-journal model
serves as Gasket's "Generator service journal" and "Water-pump maintenance log" with different contextual
descriptions. These are recoverable cargo, not usable equipment.
Cargo is spawned only for an accepted assignment, using the existing configured field-site
providers. Story locations in briefings do not create fixed camps, facilities or enemy outposts.

Paper-record commissions that previously used sensors now use ordinary recovery. Remaining
sensor recording and signal-bearing commissions retain their existing interactions.
NPC deliveries require **I have a delivery for you** at the named contact. The server validates
the active character, claim, receiving vendor, access, proximity, map and matching inventory
item. Successful removal records delivery; return to the issuer to complete the commission and
receive its progression reward. Pickup alone does not qualify. Field-cache deliveries use the
PDA's **Field work → Deliver parcel** action instead.

Cargo cannot be traded, dropped or transferred to another character. Full inventories leave the
world item available; lost cargo can be recovered at the same saved site. No completion cash,
repeatable-job credit, restock or bonus is awarded for the intermediate NPC handover.

## Existing characters

Progression and commission IDs are unchanged. Accepted jobs keep their saved cargo, mechanic,
location and recipient, including old generic-case recoveries with no recipient. New assignments
snapshot both the objective description and the separate cargo label/description. Existing carried items
without a saved cargo-description override retain the concrete item description. Older assignments derive instructions from their saved state.
No saves are reset and completed milestones are not reopened. Converted steps retain a completion-only
job identity: already accepted field assignments can finish using their saved field state, including
interrupted pending completions. They settle the same milestone once, with the existing payout and
benefit protections. These retired assignments cannot be accepted again. Abandoning one leaves the
ordinary delivery requirement available instead. Newly selected hand-in requirements are saved normally.

## Commission inventory

The editable contact definition remains authoritative. Recipient `Issuer` means return the
item directly; `Field cache` means deliver at the assigned cache before returning to the issuer.

| Contact | Step | Commission | Cargo ID | Interaction | Search region | Recipient |
| --- | --- | --- | --- | --- | --- | --- |
| arena-master | AR06 | The Damaged Shipment | `town_quest_armour` | recovery | Swamps | suture |
| arena-master | AR14 | A Fighter's Effects | `town_quest_personnel` | recovery | Swamps | Issuer |
| atlas | AT02 | The First Landmark | `town_quest_module` | sensor | Swamps | Issuer |
| atlas | AT06 | Ballast's Shortcut | `town_quest_notebook` | recovery | Swamps | ballast |
| atlas | AT10 | An Unfinished Map | `town_quest_tape` | recovery | Garbage | Issuer |
| atlas | AT14 | The Wrong Coordinates | `town_quest_official` | recovery | Swamps | Issuer |
| atlas | AT18 | The First Pripyat Mark | `town_quest_module` | sensor | Pripyat | Issuer |
| ballast | BA02 | The First Stranding | `town_quest_case` | recovery | Swamps | Issuer |
| ballast | BA06 | A Missing Mooring | `town_quest_tools` | recovery | Swamps | Issuer |
| ballast | BA10 | The Floating Trail | `town_quest_tape` | recovery | Swamps | Issuer |
| ballast | BA14 | The Other Landing | `town_quest_manifest` | recovery | Swamps | ledger |
| ballast | BA18 | The Last Mooring | `town_quest_personnel` | recovery | Swamps | Issuer |
| beanstalk | BN06 | Two Sides of the Heap | `town_quest_lab` | recovery | Garbage | Issuer |
| beanstalk | BN22 | The Last Control | `town_quest_module` | recovery | Pripyat | Issuer |
| boss | BO02 | The Missing Patrol | `town_quest_orders` | recovery | Waystation | Issuer |
| boss | BO06 | The Interrupted Shipment | `town_quest_equipment` | recovery | Waystation | Issuer |
| boss | BO10 | The Missing Names | `town_quest_personnel` | recovery | Waystation | wake |
| boss | BO14 | The Pripyat Outpost | `town_quest_orders` | recovery | Pripyat | Issuer |
| boss | BO18 | The Withheld Annex | `town_quest_official` | recovery | Pripyat | wake |
| brass | BR02 | The Broken Seal | `town_quest_manifest` | recovery | Garbage | Issuer |
| brass | BR06 | The Depot Register | `town_quest_receipt` | recovery | Garbage | Issuer |
| brass | BR10 | The Supplier's Stamp | `town_quest_contract` | recovery | Garbage | latch |
| brass | BR14 | The Military Manifest | `town_quest_military` | recovery | Waystation | quartermaster |
| brass | BR18 | The Pripyat Consignment | `town_quest_equipment` | recovery | Pripyat | Issuer |
| brass | BR22 | The Final Receipt | `town_quest_receipt` | recovery | Garbage | Issuer |
| carbon | CA02 | The Maintenance Office | `town_quest_official` | recovery | Waystation | Issuer |
| carbon | CA06 | The Original's Account | `town_quest_notebook` | recovery | Waystation | the-original |
| carbon | CA10 | Egghead's Citation | `town_quest_lab` | recovery | Waystation | Issuer |
| carbon | CA14 | The Pripyat Index | `town_quest_archive` | recovery | Pripyat | Issuer |
| carbon | CA18 | The False Summary | `town_quest_dossier` | recovery | Waystation | Issuer |
| cleaner | CL02 | The Unattended Drop | `town_quest_evidence` | recovery | Garbage | Issuer |
| cleaner | CL06 | An Empty Hiding Place | `town_quest_security` | recovery | Garbage | Issuer |
| cleaner | CL10 | The Buried Register | `town_quest_receipt` | recovery | Garbage | Issuer |
| cleaner | CL14 | Ledger's Missing Copy | `town_quest_manifest` | recovery | Garbage | ledger |
| cleaner | CL18 | The Other Register | `town_quest_archive` | recovery | Waystation | ledger |
| cleaner | CL22 | A Cache With Two Owners | `town_quest_contract` | recovery | Pripyat | Issuer |
| cleaner | CL26 | The Cache That Stayed Closed | `town_quest_evidence` | deadDrop | Garbage | Field cache |
| egghead | EG02 | The Control Notebook | `town_quest_diary` | recovery | Waystation | Issuer |
| egghead | EG06 | The Comparison Site | `town_quest_module` | sensor | Waystation | Issuer |
| egghead | EG10 | The Failed Trial | `town_quest_module2` | recovery | Waystation | Issuer |
| egghead | EG14 | Beanstalk's Objection | `town_quest_clinic` | recovery | Garbage | vesper |
| egghead | EG18 | The Pripyat Baseline | `town_quest_module` | recovery | Pripyat | Issuer |
| egghead | EG22 | The Family Resemblance | `town_quest_module2` | recovery | Pripyat | Issuer |
| gasket | GK02 | The Empty Service Shed | `town_quest_notebook` | recovery | Swamps | Issuer |
| gasket | GK06 | The Pump Log | `town_quest_notebook` | recovery | Swamps | Issuer |
| gasket | GK10 | The Scrap Specification | `town_quest_official` | recovery | Garbage | latch |
| gasket | GK14 | The Shelter Circuit | `town_quest_module2` | recovery | Swamps | Issuer |
| gasket | GK18 | The Original Manual | `town_quest_official` | recovery | Swamps | Issuer |
| haggler | HG02 | The Missing Invoice | `town_quest_receipt` | recovery | Swamps | Issuer |
| haggler | HG06 | The Wrong Seal | `town_quest_manifest` | recovery | Swamps | Issuer |
| haggler | HG10 | Two Sets of Books | `town_quest_receipt` | recovery | Swamps | ledger |
| haggler | HG14 | A Broken Agreement | `town_quest_contract` | recovery | Garbage | Issuer |
| haggler | HG18 | The Shipment List | `town_quest_manifest` | recovery | Swamps | brass |
| haggler | HG22 | The Unpaid Supplier | `town_quest_personnel` | recovery | Swamps | Issuer |
| intern | IN02 | The Calibration Point | `town_quest_module` | sensor | Waystation | Issuer |
| intern | IN06 | Beanstalk's Control | `town_quest_module2` | sensor | Garbage | Issuer |
| intern | IN10 | The Senior's Notebook | `town_quest_diary` | recovery | Waystation | Issuer |
| intern | IN14 | The Lost Calibration Case | `town_quest_research` | recovery | Waystation | technut |
| intern | IN18 | The Contradictory Site | `town_quest_module` | sensor | Pripyat | Issuer |
| intern | IN22 | The Independent Control | `town_quest_module2` | sensor | Pripyat | Issuer |
| jitters | JT02 | The Empty Cabinet | `town_quest_clinic` | recovery | Swamps | Issuer |
| jitters | JT06 | The Exposure Log | `town_quest_clinic2` | recovery | Swamps | Issuer |
| jitters | JT10 | The Contaminated Batch | `town_quest_tube` | recovery | Garbage | Issuer |
| jitters | JT14 | A Second Opinion | `town_quest_lab` | recovery | Swamps | Issuer |
| jitters | JT18 | The Field Ward | `town_quest_clinic` | recovery | Swamps | wake |
| jitters | JT22 | The Patient's Route | `town_quest_module2` | recovery | Pripyat | Issuer |
| jitters | JT26 | The Case Closed | `town_quest_personnel` | recovery | Swamps | Issuer |
| latch | LA02 | The Missing Inventory | `town_quest_manifest` | recovery | Garbage | Issuer |
| latch | LA06 | A Machine With a Number | `town_quest_control` | recovery | Garbage | Issuer |
| latch | LA10 | The Wrong Replacement | `town_quest_equipment` | recovery | Garbage | Issuer |
| latch | LA14 | The Precision Crate | `town_quest_tools` | recovery | Waystation | Issuer |
| latch | LA18 | The Last Bearing | `town_quest_equipment` | recovery | Pripyat | Issuer |
| latch | LA22 | The Commissioning Plate | `town_quest_official` | recovery | Garbage | Issuer |
| ledger | LE02 | The First Route | `town_quest_case` | deadDrop | Waystation | Field cache |
| ledger | LE06 | Ballast's Landing Copy | `town_quest_manifest` | recovery | Swamps | ballast |
| ledger | LE10 | The Duplicate Destination | `town_quest_official` | recovery | Waystation | Issuer |
| ledger | LE14 | The Last Scheduled Drop | `town_quest_evidence` | deadDrop | Waystation | Field cache |
| ledger | LE18 | The Dispatcher's Detour | `town_quest_tape` | recovery | Pripyat | Issuer |
| ledger | LE22 | The Last Receipt | `town_quest_receipt` | recovery | Waystation | Issuer |
| mute | MU02 | The Silent Repeater | `town_quest_control` | recovery | Swamps | Issuer |
| mute | MU06 | A Line Through the Swamps | `town_quest_module` | recovery | Swamps | Issuer |
| mute | MU10 | The Duplicate Message | `town_quest_disc` | recovery | Swamps | Issuer |
| mute | MU14 | The Second Copy | `town_quest_disc` | recovery | Waystation | spool |
| mute | MU18 | The Old Routing Table | `town_quest_archive` | recovery | Pripyat | carbon |
| mute | MU22 | The Broken Handshake | `town_quest_control` | triangulation | Pripyat | Issuer |
| old-timer | OT02 | Know Your Ground | `town_quest_notebook` | recovery | Swamps | Issuer |
| old-timer | OT06 | Ready Enough | `town_quest_case` | recovery | Swamps | Issuer |
| old-timer | OT10 | Enough for the Walk Home | `town_quest_case` | recovery | Swamps | Issuer |
| old-timer | OT14 | Thin the Pack | `town_quest_notebook` | recovery | Swamps | Issuer |
| old-timer | OT18 | Leave a Way Out | `town_quest_diary` | recovery | Swamps | Issuer |
| old-timer | OT22 | A Voice on Tape | `town_quest_tape2` | recovery | Waystation | spool |
| old-timer | OT26 | He Made It This Far | `town_quest_photo` | recovery | Pripyat | Issuer |
| quartermaster | QM02 | The Missing Requisition | `town_quest_orders` | recovery | Waystation | Issuer |
| quartermaster | QM06 | The Depot Copy | `town_quest_receipt` | recovery | Garbage | brass |
| quartermaster | QM10 | The Returned Equipment | `town_quest_official` | recovery | Waystation | Issuer |
| quartermaster | QM14 | The Wrong Model | `town_quest_military` | recovery | Waystation | latch |
| quartermaster | QM18 | The Pripyat Manifest | `town_quest_manifest` | recovery | Pripyat | Issuer |
| quartermaster | QM22 | The Contractor's Copy | `town_quest_contract` | recovery | Waystation | carbon |
| smartass | SM02 | The Lost Beacon | `town_quest_control` | triangulation | Garbage | Issuer |
| smartass | SM06 | The Interference Site | `town_quest_control` | triangulation | Garbage | Issuer |
| smartass | SM10 | The False Beacon | `town_quest_control` | triangulation | Garbage | Issuer |
| smartass | SM14 | Mute's Missing Packet | `town_quest_drive` | recovery | Garbage | Issuer |
| smartass | SM18 | The Rooftop Source | `town_quest_control` | recovery | Pripyat | Issuer |
| smartass | SM22 | Two Signals One Source | `town_quest_control` | recovery | Pripyat | Issuer |
| spicy-lemon | SL02 | The Cold Kitchen | `town_quest_notebook` | recovery | Swamps | Issuer |
| spicy-lemon | SL06 | The Spoiled Shipment | `town_quest_manifest` | recovery | Swamps | Issuer |
| spicy-lemon | SL10 | The Supplier's Ledger | `town_quest_receipt` | recovery | Garbage | Issuer |
| spicy-lemon | SL14 | Jitters' Complaint | `town_quest_clinic` | recovery | Swamps | jitters |
| spicy-lemon | SL18 | The Long Walk | `town_quest_module` | recovery | Swamps | gasket |
| spicy-lemon | SL22 | The Cook's Detour | `town_quest_personnel` | recovery | Swamps | Issuer |
| spicy-lemon | SL26 | Room at the Table | `town_quest_photo` | recovery | Swamps | Issuer |
| spool | SO02 | The Local Silence | `town_quest_control` | triangulation | Waystation | Issuer |
| spool | SO06 | The Crossed Bearings | `town_quest_module` | recovery | Waystation | technut |
| spool | SO10 | Mute's Header | `town_quest_drive` | recovery | Swamps | Issuer |
| spool | SO14 | The Unsent Call | `town_quest_tape2` | recovery | Waystation | wake |
| spool | SO18 | The Last Check-in | `town_quest_tape` | recovery | Pripyat | wake |
| spool | SO22 | The Message Home | `town_quest_tape2` | recovery | Waystation | Issuer |
| spoor | SP02 | The Scavenger's Camp | `town_quest_notebook` | recovery | Garbage | Issuer |
| spoor | SP06 | Lemon's Complaint | `town_quest_diary` | recovery | Garbage | jitters |
| spoor | SP10 | Tracks in the Wrong Place | `town_quest_module` | recovery | Garbage | Issuer |
| spoor | SP14 | The Pattern Breaks | `town_quest_module2` | recovery | Waystation | atlas |
| spoor | SP18 | The Survivor's Cache | `town_quest_equipment` | recovery | Pripyat | Issuer |
| spoor | SP22 | The Hunter's Proof | `town_quest_notebook` | recovery | Garbage | Issuer |
| suture | SU02 | The Missing Pattern | `town_quest_official` | recovery | Waystation | Issuer |
| suture | SU06 | The Forgotten Measurements | `town_quest_notebook` | recovery | Waystation | Issuer |
| suture | SU10 | The Loaded Pack | `town_quest_module` | recovery | Waystation | Issuer |
| suture | SU14 | The Failed Seam | `town_quest_worncase` | recovery | Waystation | Issuer |
| suture | SU18 | The Pripyat Trial | `town_quest_module2` | recovery | Pripyat | Issuer |
| suture | SU22 | The Return Journey Test | `town_quest_module` | sensor | Waystation | Issuer |
| technut | TN02 | The Missing Toolbox | `town_quest_tools` | recovery | Swamps | Issuer |
| technut | TN06 | The Misaligned Jig | `town_quest_official` | recovery | Swamps | Issuer |
| technut | TN10 | Latch's Find | `town_quest_control` | recovery | Swamps | latch |
| technut | TN14 | Patterns in Metal | `town_quest_official` | recovery | Swamps | Issuer |
| technut | TN18 | The Test Assembly | `town_quest_research` | recovery | Waystation | Issuer |
| technut | TN22 | The Machine's Origin | `town_quest_official` | recovery | Pripyat | Issuer |
| technut | TN26 | A Test Under Load | `town_quest_module` | sensor | Swamps | Issuer |
| the-original | OR02 | Where It Fed | `town_quest_notebook` | recovery | Swamps | Issuer |
| the-original | OR06 | The Wrong Tracks | `town_quest_tape` | recovery | Swamps | Issuer |
| the-original | OR10 | A Story With Dates | `town_quest_diary` | recovery | Swamps | carbon |
| the-original | OR14 | The Camp Before This One | `town_quest_notebook` | recovery | Waystation | Issuer |
| the-original | OR18 | The Route He Remembers | `town_quest_official` | recovery | Pripyat | atlas |
| the-original | OR22 | The Place in the Story | `town_quest_tape` | recovery | Pripyat | Issuer |
| vesper | VE02 | The Quiet Edge | `town_quest_module` | sensor | Garbage | Issuer |
| vesper | VE06 | The Second Field | `town_quest_module` | sensor | Garbage | Issuer |
| vesper | VE10 | The Unstable Reading | `town_quest_tape` | recovery | Garbage | Issuer |
| vesper | VE14 | The Lost Team's Notes | `town_quest_diary` | recovery | Waystation | wake |
| vesper | VE18 | The Team's Cache | `town_quest_equipment` | recovery | Garbage | Issuer |
| vesper | VE22 | A Different Explanation | `town_quest_tape` | recovery | Pripyat | carbon |
| wake | WA02 | The Unmarked Camp | `town_quest_personnel` | recovery | Garbage | Issuer |
| wake | WA06 | The Convoy List | `town_quest_personnel` | recovery | Garbage | brass |
| wake | WA10 | Atlas' Missing Mark | `town_quest_notebook` | recovery | Garbage | atlas |
| wake | WA14 | The Withheld Copy | `town_quest_official` | recovery | Garbage | carbon |
| wake | WA18 | The Last Transmission | `town_quest_tape2` | recovery | Pripyat | Issuer |
| wake | WA22 | The Final Name | `town_quest_personnel` | recovery | Garbage | Issuer |

## Converted delivery inventory

These 158 milestones replaced field commissions. All hand-ins return to the issuer and use the
same FTS balance policy as the other finite deliveries. Earlier story descriptions for these IDs
remain design references. Pools below roll separate specific items; required units follow each pool.

| Contact | Step | Requirement pools × required units |
| --- | --- | --- |
| arena-master | AR10 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| arena-master | AR22 | `town_delivery_medical_marsh_1` × 4; `town_delivery_medical_marsh_2` × 3; `town_delivery_medical_marsh_3` × 2; `town_delivery_medical_marsh_4` × 1 |
| atlas | AT04 | `town_delivery_research_marsh_1` × 1 |
| atlas | AT08 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| atlas | AT12 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| atlas | AT16 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| atlas | AT20 | `town_delivery_research_marsh_1` × 4; `town_delivery_research_marsh_2` × 3; `town_delivery_research_marsh_3` × 2; `town_delivery_research_marsh_4` × 1 |
| atlas | AT22 | `town_delivery_research_marsh_1` × 4; `town_delivery_research_marsh_2` × 3; `town_delivery_research_marsh_3` × 2; `town_delivery_research_marsh_4` × 1 |
| ballast | BA04 | `town_delivery_textiles_marsh_1` × 1 |
| ballast | BA08 | `town_delivery_textiles_marsh_1` × 2; `town_delivery_textiles_marsh_2` × 1 |
| ballast | BA12 | `town_delivery_textiles_marsh_1` × 3; `town_delivery_textiles_marsh_2` × 2; `town_delivery_textiles_marsh_3` × 1 |
| ballast | BA16 | `town_delivery_textiles_marsh_1` × 3; `town_delivery_textiles_marsh_2` × 2; `town_delivery_textiles_marsh_3` × 1 |
| ballast | BA20 | `town_delivery_textiles_marsh_1` × 4; `town_delivery_textiles_marsh_2` × 3; `town_delivery_textiles_marsh_3` × 2; `town_delivery_textiles_marsh_4` × 1 |
| ballast | BA22 | `town_delivery_textiles_marsh_1` × 4; `town_delivery_textiles_marsh_2` × 3; `town_delivery_textiles_marsh_3` × 2; `town_delivery_textiles_marsh_4` × 1 |
| beanstalk | BN04 | `town_delivery_research_marsh_1` × 1 |
| beanstalk | BN08 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| beanstalk | BN12 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| beanstalk | BN16 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| beanstalk | BN20 | `town_delivery_research_marsh_1` × 4; `town_delivery_research_marsh_2` × 3; `town_delivery_research_marsh_3` × 2; `town_delivery_research_marsh_4` × 1 |
| beanstalk | BN24 | `town_delivery_research_marsh_1` × 4; `town_delivery_research_marsh_2` × 3; `town_delivery_research_marsh_3` × 2; `town_delivery_research_marsh_4` × 1 |
| boss | BO04 | `town_delivery_military_waystation_1` × 18; `town_delivery_military_waystation_2` × 1 |
| boss | BO08 | `town_delivery_military_waystation_1` × 18; `town_delivery_military_waystation_2` × 1 |
| boss | BO12 | `town_delivery_military_waystation_1` × 27; `town_delivery_military_waystation_2` × 2; `town_delivery_military_waystation_3` × 1 |
| boss | BO16 | `town_delivery_military_waystation_1` × 27; `town_delivery_military_waystation_2` × 2; `town_delivery_military_waystation_3` × 1 |
| boss | BO20 | `town_delivery_military_waystation_1` × 36; `town_delivery_military_waystation_2` × 3; `town_delivery_military_waystation_3` × 2; `town_delivery_military_waystation_4` × 1 |
| boss | BO22 | `town_delivery_military_waystation_1` × 36; `town_delivery_military_waystation_2` × 3; `town_delivery_military_waystation_3` × 2; `town_delivery_military_waystation_4` × 1 |
| brass | BR04 | `town_delivery_military_garbage_1` × 2; `town_delivery_military_garbage_2` × 1 |
| brass | BR08 | `town_delivery_military_garbage_1` × 2; `town_delivery_military_garbage_2` × 1 |
| brass | BR12 | `town_delivery_military_garbage_1` × 3; `town_delivery_military_garbage_2` × 2; `town_delivery_military_garbage_3` × 1 |
| brass | BR16 | `town_delivery_military_garbage_1` × 3; `town_delivery_military_garbage_2` × 2; `town_delivery_military_garbage_3` × 1 |
| brass | BR20 | `town_delivery_military_garbage_1` × 3; `town_delivery_military_garbage_2` × 2; `town_delivery_military_garbage_3` × 1 |
| brass | BR24 | `town_delivery_military_garbage_1` × 4; `town_delivery_military_garbage_2` × 3; `town_delivery_military_garbage_3` × 2; `town_delivery_military_garbage_4` × 1 |
| carbon | CA04 | `town_delivery_records_waystation_1` × 1 |
| carbon | CA08 | `town_delivery_records_waystation_1` × 2; `town_delivery_records_waystation_2` × 1 |
| carbon | CA12 | `town_delivery_records_waystation_1` × 2; `town_delivery_records_waystation_2` × 1 |
| carbon | CA16 | `town_delivery_records_waystation_1` × 3; `town_delivery_records_waystation_2` × 2; `town_delivery_records_waystation_3` × 1 |
| carbon | CA20 | `town_delivery_records_waystation_1` × 4; `town_delivery_records_waystation_2` × 3; `town_delivery_records_waystation_3` × 2; `town_delivery_records_waystation_4` × 1 |
| carbon | CA22 | `town_delivery_records_waystation_1` × 4; `town_delivery_records_waystation_2` × 3; `town_delivery_records_waystation_3` × 2; `town_delivery_records_waystation_4` × 1 |
| cleaner | CL04 | `town_delivery_trail_garbage_1` × 1 |
| cleaner | CL08 | `town_delivery_trail_garbage_1` × 2; `town_delivery_trail_garbage_2` × 1 |
| cleaner | CL12 | `town_delivery_trail_garbage_1` × 2; `town_delivery_trail_garbage_2` × 1 |
| cleaner | CL16 | `town_delivery_trail_garbage_1` × 3; `town_delivery_trail_garbage_2` × 2; `town_delivery_trail_garbage_3` × 1 |
| cleaner | CL20 | `town_delivery_trail_garbage_1` × 3; `town_delivery_trail_garbage_2` × 2; `town_delivery_trail_garbage_3` × 1 |
| cleaner | CL24 | `town_delivery_trail_garbage_1` × 4; `town_delivery_trail_garbage_2` × 3; `town_delivery_trail_garbage_3` × 2; `town_delivery_trail_garbage_4` × 1 |
| cleaner | CL28 | `town_delivery_trail_garbage_1` × 4; `town_delivery_trail_garbage_2` × 3; `town_delivery_trail_garbage_3` × 2; `town_delivery_trail_garbage_4` × 1 |
| egghead | EG04 | `town_delivery_research_waystation_1` × 1 |
| egghead | EG08 | `town_delivery_research_waystation_1` × 2; `town_delivery_research_waystation_2` × 1 |
| egghead | EG12 | `town_delivery_research_waystation_1` × 2; `town_delivery_research_waystation_2` × 1 |
| egghead | EG16 | `town_delivery_research_waystation_1` × 3; `town_delivery_research_waystation_2` × 2; `town_delivery_research_waystation_3` × 1 |
| egghead | EG20 | `town_delivery_research_waystation_1` × 3; `town_delivery_research_waystation_2` × 2; `town_delivery_research_waystation_3` × 1 |
| egghead | EG24 | `town_delivery_research_waystation_1` × 4; `town_delivery_research_waystation_2` × 3; `town_delivery_research_waystation_3` × 2; `town_delivery_research_waystation_4` × 1 |
| egghead | EG26 | `town_delivery_research_waystation_1` × 4; `town_delivery_research_waystation_2` × 3; `town_delivery_research_waystation_3` × 2; `town_delivery_research_waystation_4` × 1 |
| gasket | GK04 | `town_delivery_utilities_marsh_1` × 2; `town_delivery_utilities_marsh_2` × 1 |
| gasket | GK08 | `town_delivery_utilities_marsh_1` × 2; `town_delivery_utilities_marsh_2` × 1 |
| gasket | GK12 | `town_delivery_utilities_marsh_1` × 3; `town_delivery_utilities_marsh_2` × 2; `town_delivery_utilities_marsh_3` × 1 |
| gasket | GK16 | `town_delivery_utilities_marsh_1` × 3; `town_delivery_utilities_marsh_2` × 2; `town_delivery_utilities_marsh_3` × 1 |
| gasket | GK20 | `town_delivery_utilities_marsh_1` × 4; `town_delivery_utilities_marsh_2` × 3; `town_delivery_utilities_marsh_3` × 2; `town_delivery_utilities_marsh_4` × 1 |
| gasket | GK22 | `town_delivery_utilities_marsh_1` × 4; `town_delivery_utilities_marsh_2` × 3; `town_delivery_utilities_marsh_3` × 2; `town_delivery_utilities_marsh_4` × 1 |
| haggler | HG04 | `town_delivery_trade_marsh_1` × 1 |
| haggler | HG08 | `town_delivery_trade_marsh_1` × 2; `town_delivery_trade_marsh_2` × 1 |
| haggler | HG12 | `town_delivery_trade_marsh_1` × 2; `town_delivery_trade_marsh_2` × 1 |
| haggler | HG16 | `town_delivery_trade_marsh_1` × 3; `town_delivery_trade_marsh_2` × 2; `town_delivery_trade_marsh_3` × 1 |
| haggler | HG20 | `town_delivery_trade_marsh_1` × 3; `town_delivery_trade_marsh_2` × 2; `town_delivery_trade_marsh_3` × 1 |
| haggler | HG24 | `town_delivery_trade_marsh_1` × 4; `town_delivery_trade_marsh_2` × 3; `town_delivery_trade_marsh_3` × 2; `town_delivery_trade_marsh_4` × 1 |
| haggler | HG26 | `town_delivery_trade_marsh_1` × 4; `town_delivery_trade_marsh_2` × 3; `town_delivery_trade_marsh_3` × 2; `town_delivery_trade_marsh_4` × 1 |
| intern | IN04 | `town_delivery_research_waystation_1` × 1 |
| intern | IN08 | `town_delivery_research_waystation_1` × 2; `town_delivery_research_waystation_2` × 1 |
| intern | IN12 | `town_delivery_research_waystation_1` × 2; `town_delivery_research_waystation_2` × 1 |
| intern | IN16 | `town_delivery_research_waystation_1` × 3; `town_delivery_research_waystation_2` × 2; `town_delivery_research_waystation_3` × 1 |
| intern | IN20 | `town_delivery_research_waystation_1` × 3; `town_delivery_research_waystation_2` × 2; `town_delivery_research_waystation_3` × 1 |
| intern | IN24 | `town_delivery_research_waystation_1` × 4; `town_delivery_research_waystation_2` × 3; `town_delivery_research_waystation_3` × 2; `town_delivery_research_waystation_4` × 1 |
| jitters | JT04 | `town_delivery_medical_marsh_1` × 1 |
| jitters | JT08 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| jitters | JT12 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| jitters | JT16 | `town_delivery_medical_marsh_1` × 3; `town_delivery_medical_marsh_2` × 2; `town_delivery_medical_marsh_3` × 1 |
| jitters | JT20 | `town_delivery_medical_marsh_1` × 3; `town_delivery_medical_marsh_2` × 2; `town_delivery_medical_marsh_3` × 1 |
| jitters | JT24 | `town_delivery_medical_marsh_1` × 4; `town_delivery_medical_marsh_2` × 3; `town_delivery_medical_marsh_3` × 2; `town_delivery_medical_marsh_4` × 1 |
| latch | LA04 | `town_delivery_workshop_garbage_1` × 2; `town_delivery_workshop_garbage_2` × 1 |
| latch | LA08 | `town_delivery_workshop_garbage_1` × 2; `town_delivery_workshop_garbage_2` × 1 |
| latch | LA12 | `town_delivery_workshop_garbage_1` × 3; `town_delivery_workshop_garbage_2` × 2; `town_delivery_workshop_garbage_3` × 1 |
| latch | LA16 | `town_delivery_workshop_garbage_1` × 3; `town_delivery_workshop_garbage_2` × 2; `town_delivery_workshop_garbage_3` × 1 |
| latch | LA20 | `town_delivery_workshop_garbage_1` × 4; `town_delivery_workshop_garbage_2` × 3; `town_delivery_workshop_garbage_3` × 2; `town_delivery_workshop_garbage_4` × 1 |
| ledger | LE04 | `town_delivery_records_waystation_1` × 1 |
| ledger | LE08 | `town_delivery_records_waystation_1` × 2; `town_delivery_records_waystation_2` × 1 |
| ledger | LE12 | `town_delivery_records_waystation_1` × 3; `town_delivery_records_waystation_2` × 2; `town_delivery_records_waystation_3` × 1 |
| ledger | LE16 | `town_delivery_records_waystation_1` × 3; `town_delivery_records_waystation_2` × 2; `town_delivery_records_waystation_3` × 1 |
| ledger | LE20 | `town_delivery_records_waystation_1` × 4; `town_delivery_records_waystation_2` × 3; `town_delivery_records_waystation_3` × 2; `town_delivery_records_waystation_4` × 1 |
| mute | MU04 | `town_delivery_electronics_marsh_1` × 1 |
| mute | MU08 | `town_delivery_electronics_marsh_1` × 2; `town_delivery_electronics_marsh_2` × 1 |
| mute | MU12 | `town_delivery_electronics_marsh_1` × 2; `town_delivery_electronics_marsh_2` × 1 |
| mute | MU16 | `town_delivery_electronics_marsh_1` × 3; `town_delivery_electronics_marsh_2` × 2; `town_delivery_electronics_marsh_3` × 1 |
| mute | MU20 | `town_delivery_electronics_marsh_1` × 3; `town_delivery_electronics_marsh_2` × 2; `town_delivery_electronics_marsh_3` × 1 |
| mute | MU24 | `town_delivery_electronics_marsh_1` × 4; `town_delivery_electronics_marsh_2` × 3; `town_delivery_electronics_marsh_3` × 2; `town_delivery_electronics_marsh_4` × 1 |
| old-timer | OT04 | `town_delivery_trail_marsh_1` × 1 |
| old-timer | OT08 | `town_delivery_trail_marsh_1` × 2; `town_delivery_trail_marsh_2` × 1 |
| old-timer | OT12 | `town_delivery_trail_marsh_1` × 2; `town_delivery_trail_marsh_2` × 1 |
| old-timer | OT16 | `town_delivery_trail_marsh_1` × 3; `town_delivery_trail_marsh_2` × 2; `town_delivery_trail_marsh_3` × 1 |
| old-timer | OT20 | `town_delivery_trail_marsh_1` × 3; `town_delivery_trail_marsh_2` × 2; `town_delivery_trail_marsh_3` × 1 |
| old-timer | OT24 | `town_delivery_trail_marsh_1` × 4; `town_delivery_trail_marsh_2` × 3; `town_delivery_trail_marsh_3` × 2; `town_delivery_trail_marsh_4` × 1 |
| old-timer | OT28 | `town_delivery_trail_marsh_1` × 4; `town_delivery_trail_marsh_2` × 3; `town_delivery_trail_marsh_3` × 2; `town_delivery_trail_marsh_4` × 1 |
| quartermaster | QM04 | `town_delivery_military_waystation_1` × 18; `town_delivery_military_waystation_2` × 1 |
| quartermaster | QM08 | `town_delivery_military_waystation_1` × 18; `town_delivery_military_waystation_2` × 1 |
| quartermaster | QM12 | `town_delivery_military_waystation_1` × 27; `town_delivery_military_waystation_2` × 2; `town_delivery_military_waystation_3` × 1 |
| quartermaster | QM16 | `town_delivery_military_waystation_1` × 27; `town_delivery_military_waystation_2` × 2; `town_delivery_military_waystation_3` × 1 |
| quartermaster | QM20 | `town_delivery_military_waystation_1` × 27; `town_delivery_military_waystation_2` × 2; `town_delivery_military_waystation_3` × 1 |
| quartermaster | QM24 | `town_delivery_military_waystation_1` × 36; `town_delivery_military_waystation_2` × 3; `town_delivery_military_waystation_3` × 2; `town_delivery_military_waystation_4` × 1 |
| smartass | SM04 | `town_delivery_electronics_waystation_1` × 1 |
| smartass | SM08 | `town_delivery_electronics_waystation_1` × 2; `town_delivery_electronics_waystation_2` × 1 |
| smartass | SM12 | `town_delivery_electronics_waystation_1` × 2; `town_delivery_electronics_waystation_2` × 1 |
| smartass | SM16 | `town_delivery_electronics_waystation_1` × 3; `town_delivery_electronics_waystation_2` × 2; `town_delivery_electronics_waystation_3` × 1 |
| smartass | SM20 | `town_delivery_electronics_waystation_1` × 3; `town_delivery_electronics_waystation_2` × 2; `town_delivery_electronics_waystation_3` × 1 |
| smartass | SM24 | `town_delivery_electronics_waystation_1` × 4; `town_delivery_electronics_waystation_2` × 3; `town_delivery_electronics_waystation_3` × 2; `town_delivery_electronics_waystation_4` × 1 |
| spicy-lemon | SL04 | `town_delivery_kitchen_marsh_1` × 1 |
| spicy-lemon | SL08 | `town_delivery_kitchen_marsh_1` × 2; `town_delivery_kitchen_marsh_2` × 1 |
| spicy-lemon | SL12 | `town_delivery_kitchen_marsh_1` × 2; `town_delivery_kitchen_marsh_2` × 1 |
| spicy-lemon | SL16 | `town_delivery_kitchen_marsh_1` × 3; `town_delivery_kitchen_marsh_2` × 2; `town_delivery_kitchen_marsh_3` × 1 |
| spicy-lemon | SL20 | `town_delivery_kitchen_marsh_1` × 3; `town_delivery_kitchen_marsh_2` × 2; `town_delivery_kitchen_marsh_3` × 1 |
| spicy-lemon | SL24 | `town_delivery_kitchen_marsh_1` × 4; `town_delivery_kitchen_marsh_2` × 3; `town_delivery_kitchen_marsh_3` × 2; `town_delivery_kitchen_marsh_4` × 2 |
| spool | SO04 | `town_delivery_electronics_marsh_1` × 1 |
| spool | SO08 | `town_delivery_electronics_marsh_1` × 2; `town_delivery_electronics_marsh_2` × 1 |
| spool | SO12 | `town_delivery_electronics_marsh_1` × 3; `town_delivery_electronics_marsh_2` × 2; `town_delivery_electronics_marsh_3` × 1 |
| spool | SO16 | `town_delivery_electronics_marsh_1` × 3; `town_delivery_electronics_marsh_2` × 2; `town_delivery_electronics_marsh_3` × 1 |
| spool | SO20 | `town_delivery_electronics_marsh_1` × 4; `town_delivery_electronics_marsh_2` × 3; `town_delivery_electronics_marsh_3` × 2; `town_delivery_electronics_marsh_4` × 1 |
| spoor | SP04 | `town_delivery_trail_garbage_1` × 1 |
| spoor | SP08 | `town_delivery_trail_garbage_1` × 2; `town_delivery_trail_garbage_2` × 1 |
| spoor | SP12 | `town_delivery_trail_garbage_1` × 3; `town_delivery_trail_garbage_2` × 2; `town_delivery_trail_garbage_3` × 1 |
| spoor | SP16 | `town_delivery_trail_garbage_1` × 3; `town_delivery_trail_garbage_2` × 2; `town_delivery_trail_garbage_3` × 1 |
| spoor | SP20 | `town_delivery_trail_garbage_1` × 4; `town_delivery_trail_garbage_2` × 3; `town_delivery_trail_garbage_3` × 2; `town_delivery_trail_garbage_4` × 1 |
| suture | SU04 | `town_delivery_textiles_waystation_1` × 2; `town_delivery_textiles_waystation_2` × 1 |
| suture | SU08 | `town_delivery_textiles_waystation_1` × 2; `town_delivery_textiles_waystation_2` × 1 |
| suture | SU12 | `town_delivery_textiles_waystation_1` × 3; `town_delivery_textiles_waystation_2` × 2; `town_delivery_textiles_waystation_3` × 1 |
| suture | SU16 | `town_delivery_textiles_waystation_1` × 3; `town_delivery_textiles_waystation_2` × 2; `town_delivery_textiles_waystation_3` × 1 |
| suture | SU20 | `town_delivery_textiles_waystation_1` × 3; `town_delivery_textiles_waystation_2` × 2; `town_delivery_textiles_waystation_3` × 1 |
| suture | SU24 | `town_delivery_textiles_waystation_1` × 4; `town_delivery_textiles_waystation_2` × 3; `town_delivery_textiles_waystation_3` × 2; `town_delivery_textiles_waystation_4` × 1 |
| technut | TN04 | `town_delivery_workshop_marsh_1` × 1 |
| technut | TN08 | `town_delivery_workshop_marsh_1` × 2; `town_delivery_workshop_marsh_2` × 1 |
| technut | TN12 | `town_delivery_workshop_marsh_1` × 2; `town_delivery_workshop_marsh_2` × 1 |
| technut | TN16 | `town_delivery_workshop_marsh_1` × 3; `town_delivery_workshop_marsh_2` × 2; `town_delivery_workshop_marsh_3` × 1 |
| technut | TN20 | `town_delivery_workshop_marsh_1` × 3; `town_delivery_workshop_marsh_2` × 2; `town_delivery_workshop_marsh_3` × 1 |
| technut | TN24 | `town_delivery_workshop_marsh_1` × 4; `town_delivery_workshop_marsh_2` × 3; `town_delivery_workshop_marsh_3` × 2; `town_delivery_workshop_marsh_4` × 1 |
| technut | TN28 | `town_delivery_workshop_marsh_1` × 4; `town_delivery_workshop_marsh_2` × 3; `town_delivery_workshop_marsh_3` × 2; `town_delivery_workshop_marsh_4` × 1 |
| the-original | OR04 | `town_delivery_collectibles_marsh_1` × 2; `town_delivery_collectibles_marsh_2` × 1 |
| the-original | OR08 | `town_delivery_collectibles_marsh_1` × 2; `town_delivery_collectibles_marsh_2` × 1 |
| the-original | OR12 | `town_delivery_collectibles_marsh_1` × 3; `town_delivery_collectibles_marsh_2` × 2; `town_delivery_collectibles_marsh_3` × 1 |
| the-original | OR16 | `town_delivery_collectibles_marsh_1` × 3; `town_delivery_collectibles_marsh_2` × 2; `town_delivery_collectibles_marsh_3` × 1 |
| the-original | OR20 | `town_delivery_collectibles_marsh_1` × 3; `town_delivery_collectibles_marsh_2` × 2; `town_delivery_collectibles_marsh_3` × 1 |
| the-original | OR24 | `town_delivery_collectibles_marsh_1` × 4; `town_delivery_collectibles_marsh_2` × 3; `town_delivery_collectibles_marsh_3` × 2; `town_delivery_collectibles_marsh_4` × 1 |
| vesper | VE04 | `town_delivery_research_marsh_1` × 1 |
| vesper | VE08 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| vesper | VE12 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| vesper | VE16 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| vesper | VE20 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| vesper | VE24 | `town_delivery_research_marsh_1` × 4; `town_delivery_research_marsh_2` × 3; `town_delivery_research_marsh_3` × 2; `town_delivery_research_marsh_4` × 1 |
| wake | WA04 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| wake | WA08 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| wake | WA12 | `town_delivery_medical_marsh_1` × 3; `town_delivery_medical_marsh_2` × 2; `town_delivery_medical_marsh_3` × 1 |
| wake | WA16 | `town_delivery_medical_marsh_1` × 3; `town_delivery_medical_marsh_2` × 2; `town_delivery_medical_marsh_3` × 1 |
| wake | WA20 | `town_delivery_medical_marsh_1` × 4; `town_delivery_medical_marsh_2` × 3; `town_delivery_medical_marsh_3` × 2; `town_delivery_medical_marsh_4` × 1 |
