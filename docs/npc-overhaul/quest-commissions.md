# Authored quest commissions

The town progression has 646 steps, including 316 field commissions. Of those commissions,
312 now declare custom bound cargo: 230 return it to the issuer, 76 deliver it to another town
contact, and six deliver it to a field cache. Four research-defence commissions retain their
existing sampler/results cargo. Ordinary supply hand-ins, cumulative work checkpoints, arena
bouts, prerequisites and progression rewards remain unchanged.

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
and claim distinguish each physical item. All 316 field commissions now declare an assignment-specific label and description, including the four
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
No saves are reset and completed milestones are not reopened. Abandoning and accepting again
creates a new assignment using the current definition and a new claim.

## Commission inventory

The editable contact definition remains authoritative. Recipient `Issuer` means return the
item directly; `Field cache` means deliver at the assigned cache before returning to the issuer.

| Contact | Step | Commission | Cargo ID | Interaction | Search region | Recipient |
| --- | --- | --- | --- | --- | --- | --- |
| arena-master | AR06 | The Damaged Shipment | `town_quest_armour` | recovery | Marsh | suture |
| arena-master | AR10 | The Supplier's Seal | `town_quest_manifest` | recovery | Marsh | brass |
| arena-master | AR14 | A Fighter's Effects | `town_quest_personnel` | recovery | Marsh | Issuer |
| arena-master | AR22 | The Name on the Board | `town_quest_archive` | recovery | Marsh | Issuer |
| atlas | AT02 | The First Landmark | `town_quest_module` | sensor | Marsh | Issuer |
| atlas | AT04 | The Route That Shifted | `town_quest_module2` | recovery | Marsh | Issuer |
| atlas | AT06 | Ballast's Shortcut | `town_quest_notebook` | recovery | Marsh | ballast |
| atlas | AT08 | The Missing Surveyor | `town_quest_diary` | recovery | Garbage | Issuer |
| atlas | AT10 | An Unfinished Map | `town_quest_tape` | recovery | Garbage | Issuer |
| atlas | AT12 | The Freight Route | `town_quest_manifest` | recovery | Marsh | ledger |
| atlas | AT14 | The Wrong Coordinates | `town_quest_official` | recovery | Marsh | Issuer |
| atlas | AT16 | The Lost Team's Cache | `town_quest_equipment` | recovery | Waystation | wake |
| atlas | AT18 | The First Pripyat Mark | `town_quest_module` | sensor | Pripyat | Issuer |
| atlas | AT20 | The Last Survey Station | `town_quest_tape` | recovery | Pripyat | Issuer |
| atlas | AT22 | Finish Their Route | `town_quest_module2` | sensor | Pripyat | Issuer |
| ballast | BA02 | The First Stranding | `town_quest_case` | recovery | Marsh | Issuer |
| ballast | BA04 | The Rotten Landing | `town_quest_notebook` | recovery | Marsh | Issuer |
| ballast | BA06 | A Missing Mooring | `town_quest_tools` | recovery | Marsh | Issuer |
| ballast | BA08 | The Crew List | `town_quest_personnel` | recovery | Marsh | Issuer |
| ballast | BA10 | The Floating Trail | `town_quest_tape` | recovery | Marsh | Issuer |
| ballast | BA12 | The Disputed Cargo | `town_quest_evidence` | recovery | Garbage | brass |
| ballast | BA14 | The Other Landing | `town_quest_manifest` | recovery | Marsh | ledger |
| ballast | BA16 | A Voice From Shore | `town_quest_tape2` | recovery | Marsh | Issuer |
| ballast | BA18 | The Last Mooring | `town_quest_personnel` | recovery | Marsh | Issuer |
| ballast | BA20 | The Missing Logbook | `town_quest_notebook` | recovery | Marsh | carbon |
| ballast | BA22 | The First Return Cargo | `town_quest_case` | recovery | Marsh | ledger |
| beanstalk | BN04 | The Buried Meter | `town_quest_control` | recovery | Garbage | Issuer |
| beanstalk | BN06 | Two Sides of the Heap | `town_quest_lab` | recovery | Garbage | Issuer |
| beanstalk | BN08 | Vesper's Reading | `town_quest_module` | recovery | Garbage | vesper |
| beanstalk | BN12 | The Dirty Filter | `town_quest_clinic` | recovery | Garbage | Issuer |
| beanstalk | BN16 | The Contradictory Result | `town_quest_module2` | recovery | Waystation | vesper |
| beanstalk | BN20 | The Abandoned Station | `town_quest_tape` | recovery | Pripyat | Issuer |
| beanstalk | BN22 | The Last Control | `town_quest_module` | recovery | Pripyat | Issuer |
| beanstalk | BN24 | A Result They Both Accept | `town_quest_lab` | recovery | Garbage | carbon |
| boss | BO02 | The Missing Patrol | `town_quest_orders` | recovery | Waystation | Issuer |
| boss | BO04 | The Forward Record | `town_quest_military` | recovery | Waystation | Issuer |
| boss | BO06 | The Interrupted Shipment | `town_quest_equipment` | recovery | Waystation | Issuer |
| boss | BO08 | The Supply Register | `town_quest_manifest` | recovery | Garbage | quartermaster |
| boss | BO10 | The Missing Names | `town_quest_personnel` | recovery | Waystation | wake |
| boss | BO12 | The Second Command Post | `town_quest_tape` | recovery | Waystation | Issuer |
| boss | BO14 | The Pripyat Outpost | `town_quest_orders` | recovery | Pripyat | Issuer |
| boss | BO16 | The Handler's Orders | `town_quest_tape2` | recovery | Pripyat | Issuer |
| boss | BO18 | The Withheld Annex | `town_quest_official` | recovery | Pripyat | wake |
| boss | BO20 | The Last Command | `town_quest_military` | recovery | Waystation | Issuer |
| boss | BO22 | The Missing Patrol's Answer | `town_quest_personnel` | recovery | Waystation | Issuer |
| brass | BR02 | The Broken Seal | `town_quest_manifest` | recovery | Garbage | Issuer |
| brass | BR04 | The Missing Boxes | `town_quest_equipment` | recovery | Garbage | Issuer |
| brass | BR06 | The Depot Register | `town_quest_receipt` | recovery | Garbage | Issuer |
| brass | BR08 | The Mixed Shipment | `town_quest_manifest` | recovery | Garbage | Issuer |
| brass | BR10 | The Supplier's Stamp | `town_quest_contract` | recovery | Garbage | latch |
| brass | BR12 | Ledger's Missing Receipt | `town_quest_receipt` | recovery | Garbage | ledger |
| brass | BR14 | The Military Manifest | `town_quest_military` | recovery | Waystation | quartermaster |
| brass | BR16 | The Empty Truck | `town_quest_tape` | recovery | Garbage | Issuer |
| brass | BR18 | The Pripyat Consignment | `town_quest_equipment` | recovery | Pripyat | Issuer |
| brass | BR20 | The Wrong Recipient | `town_quest_official` | recovery | Pripyat | ledger |
| brass | BR22 | The Final Receipt | `town_quest_receipt` | recovery | Garbage | Issuer |
| brass | BR24 | The Depot's Copy | `town_quest_contract` | recovery | Garbage | Issuer |
| carbon | CA02 | The Maintenance Office | `town_quest_official` | recovery | Waystation | Issuer |
| carbon | CA04 | A Date That Does Not Fit | `town_quest_archive` | recovery | Garbage | Issuer |
| carbon | CA06 | The Original's Account | `town_quest_notebook` | recovery | Waystation | the-original |
| carbon | CA08 | The Missing Annex | `town_quest_official` | recovery | Waystation | Issuer |
| carbon | CA10 | Egghead's Citation | `town_quest_lab` | recovery | Waystation | Issuer |
| carbon | CA12 | The Restricted Copy | `town_quest_intel` | recovery | Waystation | Issuer |
| carbon | CA14 | The Pripyat Index | `town_quest_archive` | recovery | Pripyat | Issuer |
| carbon | CA16 | The Administrative Trail | `town_quest_official` | recovery | Pripyat | ledger |
| carbon | CA18 | The False Summary | `town_quest_dossier` | recovery | Waystation | Issuer |
| carbon | CA20 | The Surviving Archive | `town_quest_archive` | recovery | Pripyat | Issuer |
| carbon | CA22 | The Last Witness on Paper | `town_quest_diary` | recovery | Waystation | Issuer |
| cleaner | CL02 | The Unattended Drop | `town_quest_evidence` | recovery | Garbage | Issuer |
| cleaner | CL04 | The Wrong Marker | `town_quest_notebook` | recovery | Garbage | Issuer |
| cleaner | CL06 | An Empty Hiding Place | `town_quest_security` | recovery | Garbage | Issuer |
| cleaner | CL08 | The Missing Runner | `town_quest_tape` | recovery | Garbage | Issuer |
| cleaner | CL10 | The Buried Register | `town_quest_receipt` | recovery | Garbage | Issuer |
| cleaner | CL12 | The Duplicate Seal | `town_quest_evidence` | recovery | Garbage | Issuer |
| cleaner | CL14 | Ledger's Missing Copy | `town_quest_manifest` | recovery | Garbage | ledger |
| cleaner | CL16 | The False Destination | `town_quest_security` | deadDrop | Garbage | Field cache |
| cleaner | CL18 | The Other Register | `town_quest_archive` | recovery | Waystation | ledger |
| cleaner | CL20 | The Unmanned Depot | `town_quest_equipment` | recovery | Pripyat | Issuer |
| cleaner | CL22 | A Cache With Two Owners | `town_quest_contract` | recovery | Pripyat | Issuer |
| cleaner | CL24 | The Burned Address | `town_quest_official` | recovery | Pripyat | Issuer |
| cleaner | CL26 | The Cache That Stayed Closed | `town_quest_evidence` | deadDrop | Garbage | Field cache |
| cleaner | CL28 | No More Missing Parcels | `town_quest_receipt` | recovery | Garbage | Issuer |
| egghead | EG02 | The Control Notebook | `town_quest_diary` | recovery | Waystation | Issuer |
| egghead | EG04 | The Old Field Station | `town_quest_research` | recovery | Waystation | Issuer |
| egghead | EG06 | The Comparison Site | `town_quest_module` | sensor | Waystation | Issuer |
| egghead | EG08 | The Missing Calibration | `town_quest_lab` | recovery | Garbage | Issuer |
| egghead | EG10 | The Failed Trial | `town_quest_module2` | recovery | Waystation | Issuer |
| egghead | EG12 | The Paired Samples | `town_quest_lab` | recovery | Waystation | Issuer |
| egghead | EG14 | Beanstalk's Objection | `town_quest_clinic` | recovery | Garbage | vesper |
| egghead | EG16 | The Archived Finding | `town_quest_dossier` | recovery | Waystation | carbon |
| egghead | EG18 | The Pripyat Baseline | `town_quest_module` | recovery | Pripyat | Issuer |
| egghead | EG20 | The Unfinished Experiment | `town_quest_research` | recovery | Pripyat | Issuer |
| egghead | EG22 | The Family Resemblance | `town_quest_module2` | recovery | Pripyat | Issuer |
| egghead | EG24 | The Programme's Missing Page | `town_quest_archive` | recovery | Waystation | carbon |
| egghead | EG26 | The Last Control Record | `town_quest_lab` | recovery | Waystation | Issuer |
| gasket | GK02 | The Empty Service Shed | `town_quest_notebook` | recovery | Marsh | Issuer |
| gasket | GK04 | Technut's Regulator | `town_quest_control` | recovery | Marsh | technut |
| gasket | GK06 | The Pump Log | `town_quest_notebook` | recovery | Marsh | Issuer |
| gasket | GK08 | The Bad Intake | `town_quest_module` | sensor | Marsh | Issuer |
| gasket | GK10 | The Scrap Specification | `town_quest_official` | recovery | Garbage | latch |
| gasket | GK12 | The Forgotten Store | `town_quest_case` | recovery | Marsh | Issuer |
| gasket | GK14 | The Shelter Circuit | `town_quest_module2` | recovery | Marsh | Issuer |
| gasket | GK16 | The Long Supply Line | `town_quest_manifest` | recovery | Marsh | ledger |
| gasket | GK18 | The Original Manual | `town_quest_official` | recovery | Marsh | Issuer |
| gasket | GK20 | The Emergency Test | `town_quest_module` | sensor | Marsh | Issuer |
| gasket | GK22 | A Light Left On | `town_quest_notebook` | recovery | Marsh | Issuer |
| haggler | HG02 | The Missing Invoice | `town_quest_receipt` | recovery | Marsh | Issuer |
| haggler | HG04 | Who Pays Twice | `town_quest_contract` | recovery | Marsh | Issuer |
| haggler | HG06 | The Wrong Seal | `town_quest_manifest` | recovery | Marsh | Issuer |
| haggler | HG08 | The Abandoned Stall | `town_quest_notebook` | recovery | Garbage | Issuer |
| haggler | HG10 | Two Sets of Books | `town_quest_receipt` | recovery | Marsh | ledger |
| haggler | HG12 | The Collector's Route | `town_quest_intel` | recovery | Marsh | Issuer |
| haggler | HG14 | A Broken Agreement | `town_quest_contract` | recovery | Garbage | Issuer |
| haggler | HG16 | The Broker's Copy | `town_quest_contract` | recovery | Waystation | carbon |
| haggler | HG18 | The Shipment List | `town_quest_manifest` | recovery | Marsh | brass |
| haggler | HG20 | The Empty Depot | `town_quest_archive` | recovery | Marsh | Issuer |
| haggler | HG22 | The Unpaid Supplier | `town_quest_personnel` | recovery | Marsh | Issuer |
| haggler | HG24 | The Last Ledger | `town_quest_notebook` | recovery | Marsh | Issuer |
| haggler | HG26 | Nobody Collects Here | `town_quest_contract` | recovery | Marsh | Issuer |
| intern | IN02 | The Calibration Point | `town_quest_module` | sensor | Waystation | Issuer |
| intern | IN04 | The Mislabelled Sample | `town_quest_lab` | recovery | Waystation | Issuer |
| intern | IN06 | Beanstalk's Control | `town_quest_module2` | sensor | Garbage | Issuer |
| intern | IN08 | The Missing Interval | `town_quest_tape` | recovery | Waystation | spool |
| intern | IN10 | The Senior's Notebook | `town_quest_diary` | recovery | Waystation | Issuer |
| intern | IN12 | The Field Vesper Chose | `town_quest_module` | sensor | Waystation | Issuer |
| intern | IN14 | The Lost Calibration Case | `town_quest_research` | recovery | Waystation | technut |
| intern | IN16 | The First Pripyat Series | `town_quest_module2` | sensor | Pripyat | Issuer |
| intern | IN18 | The Contradictory Site | `town_quest_module` | sensor | Pripyat | Issuer |
| intern | IN20 | The Earlier Team | `town_quest_tape` | recovery | Pripyat | wake |
| intern | IN22 | The Independent Control | `town_quest_module2` | sensor | Pripyat | Issuer |
| intern | IN24 | The Missing Observation | `town_quest_lab` | recovery | Waystation | Issuer |
| jitters | JT02 | The Empty Cabinet | `town_quest_clinic` | recovery | Marsh | Issuer |
| jitters | JT04 | A Missing Bag | `town_quest_medical` | recovery | Marsh | Issuer |
| jitters | JT06 | The Exposure Log | `town_quest_clinic2` | recovery | Marsh | Issuer |
| jitters | JT08 | The Broken Instrument | `town_quest_control` | recovery | Marsh | technut |
| jitters | JT10 | The Contaminated Batch | `town_quest_tube` | recovery | Garbage | Issuer |
| jitters | JT12 | Where the Water Came From | `town_quest_module` | recovery | Marsh | gasket |
| jitters | JT14 | A Second Opinion | `town_quest_lab` | recovery | Marsh | Issuer |
| jitters | JT16 | The Missing Volunteer | `town_quest_medical` | recovery | Garbage | Issuer |
| jitters | JT18 | The Field Ward | `town_quest_clinic` | recovery | Marsh | wake |
| jitters | JT20 | No One Came Back | `town_quest_tape` | recovery | Pripyat | Issuer |
| jitters | JT22 | The Patient's Route | `town_quest_module2` | recovery | Pripyat | Issuer |
| jitters | JT24 | An Answer on Tape | `town_quest_tape2` | recovery | Pripyat | Issuer |
| jitters | JT26 | The Case Closed | `town_quest_personnel` | recovery | Marsh | Issuer |
| latch | LA02 | The Missing Inventory | `town_quest_manifest` | recovery | Garbage | Issuer |
| latch | LA04 | The Broken Bench | `town_quest_tools` | recovery | Garbage | Issuer |
| latch | LA06 | A Machine With a Number | `town_quest_control` | recovery | Garbage | Issuer |
| latch | LA08 | The Borrowed Specification | `town_quest_official` | recovery | Garbage | technut |
| latch | LA10 | The Wrong Replacement | `town_quest_equipment` | recovery | Garbage | Issuer |
| latch | LA12 | The Old Workshop | `town_quest_notebook` | recovery | Garbage | technut |
| latch | LA14 | The Precision Crate | `town_quest_tools` | recovery | Waystation | Issuer |
| latch | LA16 | Where It Was Built | `town_quest_archive` | recovery | Pripyat | carbon |
| latch | LA18 | The Last Bearing | `town_quest_equipment` | recovery | Pripyat | Issuer |
| latch | LA20 | The Load Test | `town_quest_module` | sensor | Garbage | Issuer |
| latch | LA22 | The Commissioning Plate | `town_quest_official` | recovery | Garbage | Issuer |
| ledger | LE02 | The First Route | `town_quest_case` | deadDrop | Waystation | Field cache |
| ledger | LE04 | The Missing Receipt | `town_quest_receipt` | recovery | Waystation | Issuer |
| ledger | LE06 | Ballast's Landing Copy | `town_quest_manifest` | recovery | Marsh | ballast |
| ledger | LE08 | The Interrupted Connection | `town_quest_equipment` | recovery | Garbage | cleaner |
| ledger | LE10 | The Duplicate Destination | `town_quest_official` | recovery | Waystation | Issuer |
| ledger | LE12 | The Missing Dispatcher | `town_quest_tape` | recovery | Waystation | Issuer |
| ledger | LE14 | The Last Scheduled Drop | `town_quest_evidence` | deadDrop | Waystation | Field cache |
| ledger | LE16 | The Unmanned Pripyat Cache | `town_quest_research` | deadDrop | Pripyat | Field cache |
| ledger | LE18 | The Dispatcher's Detour | `town_quest_tape` | recovery | Pripyat | Issuer |
| ledger | LE20 | The Return Consignment | `town_quest_case` | deadDrop | Pripyat | Field cache |
| ledger | LE22 | The Last Receipt | `town_quest_receipt` | recovery | Waystation | Issuer |
| mute | MU02 | The Silent Repeater | `town_quest_control` | recovery | Marsh | Issuer |
| mute | MU04 | The Missing Address | `town_quest_drive` | recovery | Marsh | Issuer |
| mute | MU06 | A Line Through the Marsh | `town_quest_module` | recovery | Marsh | Issuer |
| mute | MU08 | Spool's Packet | `town_quest_security` | recovery | Garbage | spool |
| mute | MU10 | The Duplicate Message | `town_quest_disc` | recovery | Marsh | Issuer |
| mute | MU12 | The Unlisted Receiver | `town_quest_control` | triangulation | Marsh | Issuer |
| mute | MU14 | The Second Copy | `town_quest_disc` | recovery | Waystation | spool |
| mute | MU16 | A Message With No Sender | `town_quest_tape` | recovery | Marsh | Issuer |
| mute | MU18 | The Old Routing Table | `town_quest_archive` | recovery | Pripyat | carbon |
| mute | MU20 | Someone on the Line | `town_quest_module2` | recovery | Pripyat | Issuer |
| mute | MU22 | The Broken Handshake | `town_quest_control` | triangulation | Pripyat | Issuer |
| mute | MU24 | The Last Address | `town_quest_security` | recovery | Marsh | Issuer |
| old-timer | OT02 | Know Your Ground | `town_quest_notebook` | recovery | Marsh | Issuer |
| old-timer | OT04 | Bring Something Back | `town_quest_diary` | recovery | Marsh | Issuer |
| old-timer | OT06 | Ready Enough | `town_quest_case` | recovery | Marsh | Issuer |
| old-timer | OT08 | Travel Light | `town_quest_equipment` | recovery | Marsh | Issuer |
| old-timer | OT10 | Enough for the Walk Home | `town_quest_case` | recovery | Marsh | Issuer |
| old-timer | OT12 | Keep Yourself Alive | `town_quest_worncase` | recovery | Marsh | Issuer |
| old-timer | OT14 | Thin the Pack | `town_quest_notebook` | recovery | Marsh | Issuer |
| old-timer | OT16 | Not Normal Behaviour | `town_quest_tape` | recovery | Marsh | Issuer |
| old-timer | OT18 | Leave a Way Out | `town_quest_diary` | recovery | Marsh | Issuer |
| old-timer | OT20 | The Convoy That Never Arrived | `town_quest_manifest` | recovery | Garbage | ledger |
| old-timer | OT22 | A Voice on Tape | `town_quest_tape2` | recovery | Waystation | spool |
| old-timer | OT24 | The Last Address | `town_quest_official` | recovery | Pripyat | Issuer |
| old-timer | OT26 | He Made It This Far | `town_quest_photo` | recovery | Pripyat | Issuer |
| old-timer | OT28 | Nothing Left Unsaid | `town_quest_personnel` | recovery | Pripyat | Issuer |
| quartermaster | QM02 | The Missing Requisition | `town_quest_orders` | recovery | Waystation | Issuer |
| quartermaster | QM04 | The Misrouted Crate | `town_quest_equipment` | recovery | Waystation | Issuer |
| quartermaster | QM06 | The Depot Copy | `town_quest_receipt` | recovery | Garbage | brass |
| quartermaster | QM08 | The Supplier's Mark | `town_quest_manifest` | recovery | Waystation | Issuer |
| quartermaster | QM10 | The Returned Equipment | `town_quest_official` | recovery | Waystation | Issuer |
| quartermaster | QM12 | The Lost Agreement | `town_quest_contract` | recovery | Waystation | Issuer |
| quartermaster | QM14 | The Wrong Model | `town_quest_military` | recovery | Waystation | latch |
| quartermaster | QM16 | The Field Test | `town_quest_module` | recovery | Waystation | Issuer |
| quartermaster | QM18 | The Pripyat Manifest | `town_quest_manifest` | recovery | Pripyat | Issuer |
| quartermaster | QM20 | The Abandoned Stores | `town_quest_equipment` | recovery | Pripyat | Issuer |
| quartermaster | QM22 | The Contractor's Copy | `town_quest_contract` | recovery | Waystation | carbon |
| quartermaster | QM24 | The Signed Requisition | `town_quest_orders` | recovery | Waystation | Issuer |
| smartass | SM02 | The Lost Beacon | `town_quest_control` | triangulation | Garbage | Issuer |
| smartass | SM04 | The Wrong Frequency | `town_quest_module` | recovery | Garbage | Issuer |
| smartass | SM06 | The Interference Site | `town_quest_control` | triangulation | Garbage | Issuer |
| smartass | SM08 | Spool's Correction | `town_quest_module2` | recovery | Garbage | spool |
| smartass | SM10 | The False Beacon | `town_quest_control` | triangulation | Garbage | Issuer |
| smartass | SM12 | The Receiver List | `town_quest_archive` | recovery | Waystation | quartermaster |
| smartass | SM14 | Mute's Missing Packet | `town_quest_drive` | recovery | Garbage | Issuer |
| smartass | SM16 | A Signal Across Maps | `town_quest_control` | triangulation | Garbage | Issuer |
| smartass | SM18 | The Rooftop Source | `town_quest_control` | recovery | Pripyat | Issuer |
| smartass | SM20 | The Handler's Record | `town_quest_tape` | recovery | Pripyat | carbon |
| smartass | SM22 | Two Signals One Source | `town_quest_control` | recovery | Pripyat | Issuer |
| smartass | SM24 | The Silent Frequency | `town_quest_security` | recovery | Garbage | Issuer |
| spicy-lemon | SL02 | The Cold Kitchen | `town_quest_notebook` | recovery | Marsh | Issuer |
| spicy-lemon | SL04 | Spoor's Contribution | `town_quest_diary` | recovery | Marsh | spoor |
| spicy-lemon | SL06 | The Spoiled Shipment | `town_quest_manifest` | recovery | Marsh | Issuer |
| spicy-lemon | SL08 | The Missing Crate | `town_quest_case` | recovery | Garbage | Issuer |
| spicy-lemon | SL10 | The Supplier's Ledger | `town_quest_receipt` | recovery | Garbage | Issuer |
| spicy-lemon | SL12 | Smoke Without Supper | `town_quest_notebook` | recovery | Marsh | Issuer |
| spicy-lemon | SL14 | Jitters' Complaint | `town_quest_clinic` | recovery | Marsh | jitters |
| spicy-lemon | SL16 | An Unfinished Menu | `town_quest_notebook` | recovery | Waystation | Issuer |
| spicy-lemon | SL18 | The Long Walk | `town_quest_module` | recovery | Marsh | gasket |
| spicy-lemon | SL20 | The Last Cookfire | `town_quest_diary` | recovery | Marsh | Issuer |
| spicy-lemon | SL22 | The Cook's Detour | `town_quest_personnel` | recovery | Marsh | Issuer |
| spicy-lemon | SL24 | The Recipe He Kept | `town_quest_diary` | recovery | Marsh | Issuer |
| spicy-lemon | SL26 | Room at the Table | `town_quest_photo` | recovery | Marsh | Issuer |
| spool | SO02 | The Local Silence | `town_quest_control` | triangulation | Waystation | Issuer |
| spool | SO04 | The Station Log | `town_quest_tape` | recovery | Waystation | Issuer |
| spool | SO06 | The Crossed Bearings | `town_quest_module` | recovery | Waystation | technut |
| spool | SO08 | The Absent Operator | `town_quest_control` | recovery | Waystation | Issuer |
| spool | SO10 | Mute's Header | `town_quest_drive` | recovery | Marsh | Issuer |
| spool | SO12 | The Garbage Relay | `town_quest_control` | recovery | Waystation | Issuer |
| spool | SO14 | The Unsent Call | `town_quest_tape2` | recovery | Waystation | wake |
| spool | SO16 | The First Pripyat Call | `town_quest_control` | triangulation | Pripyat | Issuer |
| spool | SO18 | The Last Check-in | `town_quest_tape` | recovery | Pripyat | wake |
| spool | SO20 | The Receiver That Stayed On | `town_quest_control` | recovery | Waystation | Issuer |
| spool | SO22 | The Message Home | `town_quest_tape2` | recovery | Waystation | Issuer |
| spoor | SP02 | The Scavenger's Camp | `town_quest_notebook` | recovery | Garbage | Issuer |
| spoor | SP04 | Where They Feed | `town_quest_tape` | recovery | Garbage | Issuer |
| spoor | SP06 | Lemon's Complaint | `town_quest_diary` | recovery | Garbage | jitters |
| spoor | SP08 | The Displaced Pack | `town_quest_notebook` | recovery | Garbage | Issuer |
| spoor | SP10 | Tracks in the Wrong Place | `town_quest_module` | recovery | Garbage | Issuer |
| spoor | SP12 | The Empty Hide | `town_quest_personnel` | recovery | Garbage | Issuer |
| spoor | SP14 | The Pattern Breaks | `town_quest_module2` | recovery | Waystation | atlas |
| spoor | SP16 | The First Pripyat Trail | `town_quest_diary` | recovery | Pripyat | Issuer |
| spoor | SP18 | The Survivor's Cache | `town_quest_equipment` | recovery | Pripyat | Issuer |
| spoor | SP20 | The Last Observation | `town_quest_tape2` | recovery | Pripyat | Issuer |
| spoor | SP22 | The Hunter's Proof | `town_quest_notebook` | recovery | Garbage | Issuer |
| suture | SU02 | The Missing Pattern | `town_quest_official` | recovery | Waystation | Issuer |
| suture | SU04 | A Broken Strap | `town_quest_equipment` | recovery | Waystation | Issuer |
| suture | SU06 | The Forgotten Measurements | `town_quest_notebook` | recovery | Waystation | Issuer |
| suture | SU08 | The Workshop Scrapbook | `town_quest_diary` | recovery | Garbage | latch |
| suture | SU10 | The Loaded Pack | `town_quest_module` | recovery | Waystation | Issuer |
| suture | SU12 | The Quartermaster's Specification | `town_quest_official` | recovery | Waystation | quartermaster |
| suture | SU14 | The Failed Seam | `town_quest_worncase` | recovery | Waystation | Issuer |
| suture | SU16 | The Long Expedition's Kit | `town_quest_personnel` | recovery | Waystation | ledger |
| suture | SU18 | The Pripyat Trial | `town_quest_module2` | recovery | Pripyat | Issuer |
| suture | SU20 | The Missing Outfitter | `town_quest_personnel` | recovery | Pripyat | Issuer |
| suture | SU22 | The Return Journey Test | `town_quest_module` | sensor | Waystation | Issuer |
| suture | SU24 | The Outfitter's Pattern | `town_quest_official` | recovery | Waystation | Issuer |
| technut | TN02 | The Missing Toolbox | `town_quest_tools` | recovery | Marsh | Issuer |
| technut | TN04 | A Regulator for Gasket | `town_quest_control` | recovery | Marsh | gasket |
| technut | TN06 | The Misaligned Jig | `town_quest_official` | recovery | Marsh | Issuer |
| technut | TN08 | An Engineer's Notes | `town_quest_notebook` | recovery | Garbage | Issuer |
| technut | TN10 | Latch's Find | `town_quest_control` | recovery | Marsh | latch |
| technut | TN12 | The Precision Crate | `town_quest_tools` | recovery | Garbage | Issuer |
| technut | TN14 | Patterns in Metal | `town_quest_official` | recovery | Marsh | Issuer |
| technut | TN16 | The Missing Technician | `town_quest_tape` | recovery | Marsh | Issuer |
| technut | TN18 | The Test Assembly | `town_quest_research` | recovery | Waystation | Issuer |
| technut | TN20 | The Damaged Register | `town_quest_archive` | recovery | Marsh | carbon |
| technut | TN22 | The Machine's Origin | `town_quest_official` | recovery | Pripyat | Issuer |
| technut | TN24 | The Last Component | `town_quest_equipment` | recovery | Pripyat | Issuer |
| technut | TN26 | A Test Under Load | `town_quest_module` | sensor | Marsh | Issuer |
| technut | TN28 | The Engineer's Signature | `town_quest_official` | recovery | Marsh | Issuer |
| the-original | OR02 | Where It Fed | `town_quest_notebook` | recovery | Marsh | Issuer |
| the-original | OR04 | The First Account | `town_quest_diary` | recovery | Marsh | Issuer |
| the-original | OR06 | The Wrong Tracks | `town_quest_tape` | recovery | Marsh | Issuer |
| the-original | OR08 | The Scarred Tree | `town_quest_notebook` | recovery | Garbage | Issuer |
| the-original | OR10 | A Story With Dates | `town_quest_diary` | recovery | Marsh | carbon |
| the-original | OR12 | The Second Witness | `town_quest_tape2` | recovery | Marsh | Issuer |
| the-original | OR14 | The Camp Before This One | `town_quest_notebook` | recovery | Waystation | Issuer |
| the-original | OR16 | The Name He Forgot | `town_quest_diary` | recovery | Marsh | Issuer |
| the-original | OR18 | The Route He Remembers | `town_quest_official` | recovery | Pripyat | atlas |
| the-original | OR20 | Under the Old Mark | `town_quest_evidence` | recovery | Pripyat | Issuer |
| the-original | OR22 | The Place in the Story | `town_quest_tape` | recovery | Pripyat | Issuer |
| the-original | OR24 | What Actually Happened | `town_quest_personnel` | recovery | Marsh | Issuer |
| vesper | VE02 | The Quiet Edge | `town_quest_module` | sensor | Garbage | Issuer |
| vesper | VE04 | Beanstalk's Baseline | `town_quest_module2` | recovery | Garbage | spool |
| vesper | VE06 | The Second Field | `town_quest_module` | sensor | Garbage | Issuer |
| vesper | VE08 | The Abandoned Detector | `town_quest_research` | recovery | Garbage | Issuer |
| vesper | VE10 | The Unstable Reading | `town_quest_tape` | recovery | Garbage | Issuer |
| vesper | VE12 | The Control Run | `town_quest_module2` | sensor | Garbage | Issuer |
| vesper | VE14 | The Lost Team's Notes | `town_quest_diary` | recovery | Waystation | wake |
| vesper | VE16 | The First Pripyat Field | `town_quest_module` | sensor | Pripyat | Issuer |
| vesper | VE18 | The Team's Cache | `town_quest_equipment` | recovery | Garbage | Issuer |
| vesper | VE20 | The Field They Chose | `town_quest_module2` | sensor | Garbage | Issuer |
| vesper | VE22 | A Different Explanation | `town_quest_tape` | recovery | Pripyat | carbon |
| vesper | VE24 | The Last Recorder | `town_quest_tape2` | recovery | Garbage | Issuer |
| wake | WA02 | The Unmarked Camp | `town_quest_personnel` | recovery | Garbage | Issuer |
| wake | WA04 | The Name on the Strap | `town_quest_photo` | recovery | Garbage | Issuer |
| wake | WA06 | The Convoy List | `town_quest_personnel` | recovery | Garbage | brass |
| wake | WA08 | The Last Check-in | `town_quest_tape` | recovery | Garbage | Issuer |
| wake | WA10 | Atlas' Missing Mark | `town_quest_notebook` | recovery | Garbage | atlas |
| wake | WA12 | The Diverted Convoy | `town_quest_evidence` | recovery | Garbage | Issuer |
| wake | WA14 | The Withheld Copy | `town_quest_official` | recovery | Garbage | carbon |
| wake | WA16 | The Pripyat Camp | `town_quest_equipment` | recovery | Pripyat | Issuer |
| wake | WA18 | The Last Transmission | `town_quest_tape2` | recovery | Pripyat | Issuer |
| wake | WA20 | Personal Effects | `town_quest_photo` | recovery | Garbage | Issuer |
| wake | WA22 | The Final Name | `town_quest_personnel` | recovery | Garbage | Issuer |
