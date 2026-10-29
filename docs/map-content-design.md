# Designing content for a new map

The [map setup guide](map-setup.md) explains how to populate, export, and deploy
a map. This companion guide explains what to put there, what can reuse existing
content, and what needs implementation before the map is ready for players.

A populated map needs a reason to visit, useful things to discover, and reasons
to return. Build connected activities: a town contact describes a location, the
player prepares for its hazards, finds something useful there, and returns to
trade, finish work, or unlock another opportunity.

This is a planning and implementation guide, not a commitment to add every
suggestion. Examples below are proposed content, not features already present.
Paths beginning with `plugins/` or `schema/` are relative to
`gamemodes/ix_cotz/`. Use active code there; `archive/plugins/` is archived code.

## 1. Write the map's brief

Decide these before making an item list:

| Question | Decision to record |
| --- | --- |
| Why come here? | Its place in the story, distinctive resources, services, or discoveries. |
| Who is it for? | Expected equipment, personal story progress, and whether it supports solo play or groups. |
| How is it reached? | Entry requirements, travel connections, safe arrivals, and the route home. |
| What does an ordinary visit involve? | Preparation → expedition → discovery → return → useful outcome. |
| What changes with familiarity? | Safer routes, optional tasks, specialist access, or knowledge of hidden locations. |
| Why return after the story? | Renewable work, replenishment, hunting, artifact expeditions, or social activity. |

Separate physical location from progression level. The current science contacts
Intern, Egghead, and Beanstalk are on map 1 but belong to progression after map 2
access. Placing a contact on an early map does not make its rewards early-game.
Likewise, a new map need not automatically introduce stronger equipment than
everything before it. A different resource mix or useful specialist service can
give it a role without replacing older maps.

Sketch districts and routes: town, ordinary scavenging, hunting grounds, anomaly
fields, dangerous objectives, secrets, and travel connections. Give each district
a purpose and a reason to cross into another. Consider the trip back while
injured, carrying heavy loot, or caught outside during a blowout.

## 2. Turn the brief into an implementation list

For each proposed feature, classify the work:

| Work type | Example | Deliverable |
| --- | --- | --- |
| Placement | Existing trader, container, mutant point, or anomaly field | FTS record or separately documented persistent placement. |
| Content definition | New contact, loot pool, delivery task, or artifact using supported behavior | Loaded definitions, valid IDs, dialogue, sources, and rewards. |
| New mechanic | New artifact effect, interaction, encounter rule, or service | Runtime code, saved-state rules, player feedback, and verification. |

An FTS preset does not implement dialogue, item behavior, job definitions, or
progression. A new definition also does nothing until something loads and uses
it. Track both halves: **the content exists** and **players can encounter it**.

Use a small register while planning:

| Content / stable ID | Purpose and access | Source / location | Use / destination | Dependencies | Work type | Acceptance check |
| --- | --- | --- | --- | --- | --- | --- |
| Proposed town researcher | Introduces local expeditions after entry | Town vendor | Research work and local information | Template, dialogue, jobs, reward profile, placement | Definition + placement | Eligible character can accept and finish a field trip. |
| Proposed industrial sample | Gives the factory a distinctive find | Factory loot pool | Research delivery or sale | Item, pool, spawn points, buyer/job | Definition + placement | Naturally found sample has a useful destination. |
| Proposed electrical artifact | Gives anomaly hunting a local goal | Eligible electrical field | Sale, research, or implemented utility | Item, anomaly definition, assets, optional effect code | Definition; mechanic if needed | Natural spawn, pickup, behavior, and hand-in work. |

These are design examples; replace them with actual IDs and scoped decisions.
Record an owner and status for each row in the map's own plan. Mark optional
ideas as deferred so they do not silently become launch requirements.

## 3. Town NPCs, services, and local identity

Start with the services players need, then assign personalities. Review food and
water, ammunition, medicine, repairs, storage, trade, information, and work.
Decide which must be local, which intentionally require travel, and how players
learn that. A specialist outpost may depend on another town, but players should
be able to understand and prepare for that dependency.

Useful contact roles include a local guide, general buyer, hunter, researcher,
technician, medic, faction representative, and collector. These are roles to
combine or select, not a requirement for eight new NPCs. Reuse a template when
its identity and behavior fit; create a new contact when it has a distinct role.

For every new town NPC, define:

- Identity: stable template ID, display name, model, skin, animations, sounds,
  personality, location, and relationship to existing contacts.
- Conversation: greeting, local information, directions, warnings, work,
  services, locked-access responses, and an exit from every branch.
- Economy: what it buys and sells, prices, starting stock, capacity, refill
  policy, and any purchase unlocks.
- Work: available repeatable job categories, finite progression branches,
  completion responses, and useful rewards.
- Access and persistence: when it appears, who can use it, and which system
  owns its placement and saved state.

Implementation starts in
[`vendor_adv/libs/sh_npctemplates.lua`](../gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_npctemplates.lua)
and [`dialogue/dialogue/`](../gamemodes/ix_cotz/plugins/dialogue/dialogue/).
The template's `dialogueid` must resolve to the intended conversation. Dialogue
files are loaded by the dialogue library's directory loader; other definition
systems may require explicit includes. Use the
[dialogue source guide](balance/progression/dialogue-guide.md) to find existing
contacts, and use a current working contact as the reference for service and
reward flows. The `sh_00templatenpc.lua` showcase is useful for structure, but
should not be copied wholesale as the current service implementation.

Display names are also identifiers: progression, jobs, barters, and vendor stock
use them. Personal vendor stock keys include the map and display name. Renaming
an established NPC or creating two supposedly independent contacts with the
same name can affect identity and saved behavior. Choose names deliberately and
keep template IDs, dialogue IDs, and display names recorded together.

Decide whether the NPC is placed from the start through FTS or arrives through
progression. Story arrivals use `worldNPC` and `progMap`, handled in
[`progression/libs/sv_world.lua`](../gamemodes/ix_cotz/plugins/progression/libs/sv_world.lua).
Avoid independently placing a story arrival in FTS. A shared world arrival and
an individual character's permission to use that NPC are separate decisions.

## 4. Things to find: loot, supplies, and equipment

Build the map's loot identity before adding item definitions. Audit existing
items and choose what belongs in homes, workshops, military areas, laboratories,
and remote stashes. Different distributions of existing goods can make areas
feel different without filling inventories with redundant new items.

For each new item, answer:

1. What does the player do with it: use, sell, barter, hand in, or collect?
2. Where does it enter the economy, and how often can players obtain it?
3. Is it renewable? Can a mandatory task consume the only obtainable copy?
4. What are its size, weight, price, stack/use rules, and starting condition?
5. Which characters can acquire it, and can it travel to other maps?
6. What feedback explains its purpose without revealing every secret?

Candidate additions include local industrial salvage, research specimens,
documents, task equipment, regional consumables, or a collectible with an
explicit collector. New weapons or suits also need a supply chain: ammunition,
compatible attachments, repairs, and an appropriate acquisition gate. A new
consumable or tool needs implemented behavior; descriptive text alone cannot
make it functional.

Item definitions live under [`schema/items/`](../gamemodes/ix_cotz/schema/items/)
and some plugins' `items/` directories. Pick a compatible existing base, provide
the referenced assets, and verify the actual runtime item ID. Check inventory
icons, world models, descriptions, pickup/drop, and use behavior.

Connect items to the appropriate acquisition systems:

| Route | Definitions / integration |
| --- | --- |
| Loose loot, spawning containers, and boxes | `plugins/randomitem/pools/`, then pools assigned to the relevant spawner points or containers. |
| Vendor purchases | Vendor template catalogue and any progression purchase unlocks. |
| Barter | `plugins/npcbarter/sh_definitions.lua` and the contact's dialogue. |
| Repeatable work rewards | Jobsystem reward profiles and catalogue eligibility. |
| Finite commissions | Progression requirements and completion benefits. |
| Hunting and cooking | Poaching mappings, part/meat items, cookable outputs, and their consumers. |

Random-item entries carry relative weights and may carry instance data such as
quantity or wear. Weight is not a percentage and does not determine finds per
hour without spawn frequency, point availability, and competition. Missing pool
IDs fall back to `default` in `sh_randomitems.lua`, so apparently working loot
does not prove the intended pool was loaded. Add explicit includes there for new
pool files. Editing a shared pool affects every location using it; use a distinct
pool if the resource should be local to the new map.

Give valuable finds a destination. Check that buyers accept them, jobs consume
the right quantity, and barters return the advertised goods. Test purchase,
resale, barter, job payment, and repeatable rewards together for profitable
short loops that eliminate the need to explore.

## 5. Artifacts and anomaly expeditions

A new artifact needs three linked designs: how players find it, what it is worth
or does, and why they would keep it instead of selling it.

Start from [`schema/items/artifacts/`](../gamemodes/ix_cotz/schema/items/artifacts/)
and [`schema/items/base/sh_artifacts.lua`](../gamemodes/ix_cotz/schema/items/base/sh_artifacts.lua).
Specify its model, description, size, randomized weight, value, and any active
or passive behavior. Check existing effect implementations before choosing a
base: some effects live in individual items, while Capacitor and Halo behavior
is handled by
[`helperplugins/sh_artifacthelperplugin.lua`](../gamemodes/ix_cotz/plugins/helperplugins/sh_artifacthelperplugin.lua).
Adding a new artifact file does not automatically give it a new power.

For a new effect, explicitly decide activation, costs, cooldown, stacking,
multiple-copy behavior, and what happens on drop, death, character switch,
reconnect, and map transfer. Effects involving movement or teleportation also
need tests against story barriers and travel restrictions. Define drawbacks
and combinations with existing artifacts before tuning raw power.

Natural artifact supply is controlled by `anomalycontroller`, not a separate
artifact-spawner preset table. Its
[`sh_anomalydefs.lua`](../gamemodes/ix_cotz/plugins/anomalycontroller/sh_anomalydefs.lua)
contains `commonArtifacts`, `rareArtifacts`, and `veryRareArtifacts` lists.
The runtime selects a definition from nearby live anomaly entities; it does not
simply read an artifact ID from the FTS point. Test actual fields, especially
where different anomaly types overlap.

Adding an artifact to an existing definition exposes it wherever that definition
is used. Map-exclusive artifacts need deliberate isolation of the eligible
definition/field or new selection logic. If adding an anomaly definition, preserve
existing numeric indices: point masks select ordered entries. Supply and verify
the anomaly entity, mask, field placement, artifact lists, and all assets together.

Check `artifactSpawnerThreshold`, `artifactSpawnerRate`, and
`artifactSpawnerChance` alongside field count and player collection rates. Avoid
mandatory progression depending on an extremely scarce artifact without a
viable acquisition plan. Connect the artifact to buyers, optional research work,
and any relevant requirement pools or artifact jobs. Verify natural spawning as
well as admin spawning; they test different parts of the chain.

## 6. Jobs, progression, and rewards

Give the map both a first-visit arc and repeatable work. A first visit might
introduce the town, send players to a nearby landmark, explain a distinctive
hazard, and lead to a specialist. Repeatable work should encourage varied trips
after that introduction is complete.

Use jobsystem for repeatable deliveries, hunting, and supported field tasks.
Definitions live in `plugins/jobsystem/definitions/sh_itemjobs_*.lua`, `definitions/sh_killjobs_*.lua`,
and `definitions/sh_specialjobs.lua`; loading is explicit in `sh_plugin.lua`. Registering a
job is only half the work: a contact must actually offer its category. Check its
dialogue's `possibleJobs`, difficulty offers, access, preview, completion, and
reward profile. New objective types need an authoritative completion event and
listener, rather than only a new task description.

Use progression for finite commissions, purchase access, services, and story
milestones. Review the
[progression runtime guide](../gamemodes/ix_cotz/plugins/progression/README.md)
and current definitions before authoring a branch. Record `keyNpc`, `progMap`,
starting activation, successors, requirement pools, and completion benefits.
New progression files need an include in `progression/sh_plugin.lua`.

For every required item or randomly assigned candidate, prove an accessible
source at that stage. Do not require a detector obtainable only from the research
it enables, equipment sold only after its own delivery, or a trophy from a
region locked behind the task. `lootMapTier` is a planning constraint, not proof
that every candidate really spawns. Check the full chain, including supplies
needed to survive the acquisition trip.

Keep personal progression, shared world unlocks, and physical barriers aligned.
Adding an alternative NPC or remote service must not accidentally bypass an
existing story gate. Decide whether a new branch is optional or part of the
main route, and identify every consumer of a changed story endpoint.

Reward implementation and rules are described in the
[jobsystem runtime guide](../gamemodes/ix_cotz/plugins/jobsystem/README.md).
Use current runtime values when balancing: older planning documents can retain
superseded numbers. New contacts may need reward-profile integration as well as
shop stock. Check cash, supplies, purchase authorizations, service credits, and
personal restocking together. A purchase unlock is useful only if its stock,
price, ammunition, and service support make it realistically usable.

## 7. Encounters, harvesting, and environmental gameplay

Plan threats around the activity they protect: ordinary scavenging, hunting,
anomaly recovery, or an optional expedition objective. Reusing existing mutants
in a different terrain or combination may be enough. A new mutant class adds
asset, AI, damage, movement, reward, and performance work.

Routine encounters use `eventcontroller/sh_eventdefs.lua`; advanced encounters
use `eventcontrolleradv/sh_eventdefs.lua`, its map difficulty mapping, and matching
point IDs. A placed advanced-event point alone does not create an encounter.
Verify NPC movement and spawn clearance in the actual district, then tune
population limits under realistic player counts. A visually suitable room may
still be unusable by the NPC's movement system.

If hunting is part of the loop, inspect
[`mutantpoaching/sv_plugin.lua`](../gamemodes/ix_cotz/plugins/mutantpoaching/sv_plugin.lua).
Harvesting maps corpse models to mutant types and then to meat and parts. A new
NPC class or model is not automatically covered. Add or verify part/meat item
definitions, cooking outputs, kill-job recognition, buyer acceptance, and trophy
tasks. Test the full kill → corpse → harvest → use/hand-in route.

Use radiation, water, anomalies, darkness, and blowouts to create preparation
choices and alternative routes. Explain critical hazards through the environment
or local information. Provide tested shelter and a viable return route. A new
hazard interaction or scripted set piece needs its own implementation and
persistence plan beyond controller placement.

## 8. Exploration, secrets, and player information

Give landmarks both a recognisable name and a gameplay reason to visit. Mix
obvious routes with optional clues: local rumours, documents, unusual scenery,
hidden stashes, or a terminal at a dangerous destination. Useful rewards can be
knowledge, a shortcut, a contact introduction, or supplies as well as equipment.
Any proposed shortcut or interactive terminal must have working behavior.

Hidden stash rewards need reachable points, useful location descriptions, and
appropriate map-specific note/PDA items under `hidestashspawner/items/`. Cyclic
containers are a separate system with their own category definitions. Keep task
destinations, stash clues, and actual landmarks consistent.

Review `inworldtasks/sh_plugin.lua` for GPS offsets and destination selection,
and `jobsystem/sh_specialjobs.lua` for explicit target maps. The setup guide
documents an existing gas-analyzer/radiation point-format mismatch; resolve or
verify that path before depending on it. A new map does not fix that mismatch.

Update NPC directions, item descriptions, PDA/help text, notices, and travel
descriptions where they refer to the new content. Distinguish intentional mystery
from missing information: players can discover where a rare find lies while
still understanding how to accept work and where to return it.

## 9. Implement one complete expedition first

Build a small playable slice before expanding the map:

1. Reach a safe arrival and speak to one working contact.
2. Understand and accept a local assignment with a visible reward.
3. Obtain the preparation supplies through accessible routes.
4. Visit one authored district, encounter its threat, and obtain its find.
5. Return, complete the assignment, and use the reward.
6. Repeat a renewable version, then save/restart and travel away and back.

An example might connect a researcher, factory salvage, an electrical field,
and optional artifact research. Start with supported salvage and field tasks;
scope a new artifact effect separately if the expedition needs it. This reveals
missing links earlier than independently making many NPCs, items, and locations.

After that slice works, add the remaining districts, optional branches, secrets,
and encounter variety. Capture the final placements through the setup guide.
Keep definition changes, required assets, external configuration, and any live
world migration steps with the map's release plan. Preset edits do not update
an already initialized world automatically.

## Launch checklist

- [ ] The map has a written purpose, expected access level, and repeatable loop.
- [ ] Each launch feature has a source, useful outcome, dependencies, and owner.
- [ ] Required models, textures, sounds, entity classes, and definitions load.
- [ ] Town services and their travel dependencies support the intended visits.
- [ ] New contacts have working dialogue, offered jobs, rewards, and access checks.
- [ ] Every new item can be acquired naturally and used, sold, bartered, or handed in.
- [ ] Shared loot/anomaly edits have been checked for effects on existing maps.
- [ ] Artifacts spawn naturally; their effects and multiple-copy rules behave as designed.
- [ ] Every mandatory requirement and random alternative has an accessible source.
- [ ] New encounters work on the terrain; hunting and trophy jobs recognize their results.
- [ ] Stash clues, field-task destinations, and local directions lead to reachable places.
- [ ] `/ProgressionAudit` passes, followed by actual acquisition and access playtests.
- [ ] A fresh eligible character completes the first expedition without admin help.
- [ ] A returning veteran has useful optional or repeatable activity.
- [ ] Rewards, stock, service benefits, and item state survive the relevant restart/transfer paths.
- [ ] The map setup guide's deployment and world-persistence checks also pass.

Definition audits can catch missing IDs and broken dependencies. Multiplayer
playtesting must establish actual travel time, scarcity, encounter difficulty,
economic returns, and whether the map is worth revisiting.
