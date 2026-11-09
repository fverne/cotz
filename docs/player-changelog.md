# COTZ player changelog

General highlights from the current development checkout, compared with the saved `origin/master`
reference (`1aa477d9`, 22 October 2026). Includes local changes in progress as of 9 November 2026.
This describes the development build; availability on a live server depends on deployment and map setup.

## Town contacts and progression

- Expanded the town roster with 12 new contacts and substantially more dialogue, advice, personal
  conversations and gossip across the settlements.
- Rebuilt town progression around separate branches for equipment, supplies and services. Contacts
  request salvage suited to their specialties, with early Swamps work using locally obtainable items
  and later requests gradually drawing on harder regions.
- Reorganised who sells weapons, armour, medicine, detectors and other equipment. Equipment and
  ammunition unlocks follow tier chains that can involve several traders.
- Added a dedicated **Progression** tab. Discuss work with a contact to add their available topics;
  relevant outstanding hand-in items receive purple inventory highlighting. Briefings show assigned
  items, remaining quantities and unlock benefits.
- Trader stock is now personal to each character. Repeatable work helps replenish eligible stock,
  while progression can increase its maximum capacity. Other players' purchases do not empty yours.
- Wake offers optional permanent carrying-capacity and inventory-space upgrades alongside backpack
  progression, totalling up to **+5 kg and +2 inventory rows**.
- Brass and Carbon provide progression-gated HP and AP ammunition exchanges using regular ammunition.
  Haggler's gunpowder-for-ammo-kit deals and Quartermaster's two equivalent kit deals have been removed.

## Jobs and rewards

- Expanded repeatable work with regional hunts, specimen and meal requests, salvage deliveries,
  recovery, dead drops, information couriers, sensor recording, research defence and triangulation.
- Atlas offers mutant and anomaly photography assignments with a loan camera, a live preview
  and captured-subject progress in the PDA journal.
- Jobs use regional targets and destinations, including cross-map deliveries. Triangulation records
  reading positions and bearings; photography lists the types already captured.
- Choose supply rewards when completing a job. Consumable and currency choices accompany the ordinary
  payment, with additional bonuses after every five completed jobs for the same contact. Item-return work also pays for
  the value handed in; partial stacks retain their surplus.
- Added a dedicated **Tasks** tab with progress, fieldwork actions and confirmed abandonment. Completion
  notifications and PDA sounds make finished objectives easier to notice. Earned item rewards can wait
  for collection when the backpack is full.

## Personal and squad hideouts

- Added persistent personal rooms through Ballast in Swamps, Cleaner in Garbage and Ledger in
  Waystation, where locations have been configured. Rooms start with a small private storage crate.
  New Swamps claims require Ballast's crowbar-or-bat hand-in.
- Unlock and purchase larger general, ammunition, medical and weapon storage, extra loose-item space
  and furnishing access. Invite guests and control access separately for each container.
- Added squad headquarters with shared storage, rank-based container permissions, furnishings and
  configurable visitor access. Officers can place or relocate the squad entrance.
- Squad hideout vendors sell actual donated items and put sale proceeds into a shared treasury.
  Shops can remain available while squad members are offline, subject to visitor access.
- Hideout interiors provide safe-zone protection and passive recovery. Supported artifact bookmarks
  and bedroll checkpoints can return players to authorised interiors, including across maps.

## Equipment and survival

- Added a dedicated equipment layout beside the backpack, with slots for protection, weapons,
  backpacks and field devices. Equipped items use separate slot space; returning them requires room
  in the backpack. Drag-and-drop, condition bars and a protection summary simplify loadout management.
- Manage item hotkeys from the equipment heading. Equipped Geiger counters and anomaly detectors can
  be switched off without unequipping them, and retain their power setting.
- Technut previews and applies supported suit and wearable finishes. Suture provides progression-gated
  suit variant conversions.
- Added bleeding from bullet and slash wounds, with a severity indicator and ongoing health loss.
  Bandages reduce bleeding; medkits do not stop it. Self-bandaging now takes two seconds.
- Poaching wears down knife sharpness. Sharpening stones restore it, dull knives cannot harvest,
  and sharpening beyond normal condition briefly improves the effective poaching tier.
- Helmets and gasmasks now lose durability through damage, with their condition affecting protection.

## Squads and STALKERnet

- Reworked squad creation, invitations and management into the **Squads** tab, with character portraits,
  rank controls and membership shared across connected maps.
- STALKERnet shows characters across maps, groups them by squad, and provides search, filters,
  rankings and character dossiers. Statistics include combat, poaching and completed work.
- Equipped compasses show nearby squadmates' names and distances, including fallen teammates awaiting
  revival. The roster distinguishes local, remote, travelling and offline members.
- Scoreboard tools are immediately available. Mute's progression instead unlocks regional mutant
  activity reports and emission warnings.

## Exploration, loot and encounters

- Added hundreds of salvage and valuable items, with expanded descriptions and regional loot themes.
  Human pocket loot reflects faction and role; hidden caches offer tiered documents and rare valuables.
- Added Garbage map support between Swamps and Waystation, including regional loot, contacts, jobs
  and encounter definitions. Routine encounters still require authored map spawn points.
- Rebalanced regional mutant encounters so Swamps excludes several tougher packs and Garbage provides
  an intermediate step toward Waystation.
- Human squads share threats and regroup. Mutant packs can hunt or feud with other species near
  players; distant encounters sleep to reduce unnecessary simulation.
- Optimised mutant activity, anomaly effects and detector scans. Added an **Anomaly Lights** performance
  setting and removed duplicate anomaly-detector beeps.
- Addressed ammunition and reload persistence problems, character hunger/thirst/stamina restoration,
  equipment interactions and cross-map character synchronisation.
