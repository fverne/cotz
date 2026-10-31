# Old Timer: worked progression example

[Design index](README.md) · [Rules](progression-and-rewards.md)

**Draft for review; not a ready-to-register quest list.** This revision reconciles the earlier
28-step story with the later requirement for regular hand-ins and job trackers. It replaces the
older step ordering; exact quantities, thresholds, destinations, and reward amounts remain open.

Home: Marsh. Preserve existing name, model, stern personality, and experienced voice.
Repeatable specialty: mutant hunting only. The finite story concerns survival lessons and a former
companion's failed expedition, concluding in Pripyat with return to Marsh.

## Structure

Steps 1–6 establish the relationship. Steps 7–12 (preparation) and 13–18 (fieldcraft) are parallel,
sequential branches. Both must finish before step 19; steps 19–28 then proceed in order.
Presentation numbers are design labels, not persistence IDs. Cross-NPC prerequisites should be shallow:
Ledger's involvement must not require completion of his entire freight storyline.

Mix: **7 hand-ins, 7 job trackers, 14 authored objectives**. Trackers share a cumulative Old Timer
hunting programme made available during the introduction; threshold values are not assigned yet.
Branch checkpoints must allow either branch to be completed first without resetting earned credit.
Threshold ordering across branches needs explicit design rather than assuming table order is play order.

## Steps and proposed rewards

| # | Title | Kind | Objective | Reward or unlock |
| ---: | --- | --- | --- | --- |
| 1 | Before You Leave | Hand-in | Supply modest basic provisions obtainable in Marsh. | Fixed food and water package. |
| 2 | Know Your Ground | Authored | Recover a field notebook near a local landmark. | Useful local scavenging directions. |
| 3 | Something With Teeth | Tracker | Reach the first Old Timer hunting-job checkpoint. | Kitchen Knife purchase access. |
| 4 | Bring Something Back | Authored | Investigate an abandoned hunting camp and recover its observations. | Modest medical supplies. |
| 5 | A Place to Hide | Hand-in | Supply ordinary materials used to prepare a small field cache. | One authored stash clue. |
| 6 | Ready Enough | Authored | Complete an expedition beyond the immediate camp outskirts. | Preparation supplies; opens both branches. |
| 7 | Look After Your Kit | Tracker | Reach a preparation-branch hunting checkpoint. | Sharpening Stone purchase access. |
| 8 | Travel Light | Authored | Recover a scout's abandoned pack from a search area. | Hatchet purchase access. |
| 9 | Bad Water | Hand-in | Supply existing water-treatment or exposure-preparation items, selected after source review. | Fixed anti-radiation supplies. |
| 10 | Enough for the Walk Home | Authored | Retrieve a lost supply case along an exposed return route. | Small stock increase for one existing provision he sells. |
| 11 | Old Habits | Tracker | Reach the next preparation-branch hunting checkpoint. | Modest Technut repair credit. |
| 12 | Keep Yourself Alive | Authored | Complete a longer Marsh expedition with two saved field objectives. | Survival Knife purchase access. |
| 13 | Tracks at the Fence | Hand-in | Deliver common harvested specimens for comparison. | Directions to a hunting ground. |
| 14 | Thin the Pack | Authored | Investigate a named hunting site and recover observer notes. | Hunting ammunition package. |
| 15 | What They Leave Behind | Tracker | Reach a fieldcraft-branch hunting checkpoint. | Fixed blade-maintenance supplies. |
| 16 | Not Normal Behaviour | Authored | Retrieve a recorder from a disturbed feeding ground. | Protective consumables. |
| 17 | The Empty Camp | Hand-in | Deliver specimens from accessible predator categories. | Second stash clue and missing-party lead. |
| 18 | Leave a Way Out | Authored | Investigate the party's last route and recover its abandoned observations. | Modest maintenance-supply stock increase. |
| 19 | An Old Name | Tracker | Reach the post-branches hunting checkpoint; Old Timer now trusts the player with a personal lead. | Fine Sharpening Stone purchase access; personal expedition story and Garbage destination revealed. |
| 20 | The Convoy That Never Arrived | Authored | Recover a case at the convoy's last stop in Garbage. | Expedition supplies. |
| 21 | Someone Kept Records | Hand-in | Supply ordinary administrative records requested to reconstruct the convoy; Ledger supplies narrative context. | Route information and courier preparation supplies. |
| 22 | A Voice on Tape | Authored | Recover a recording from a remote signal site. | Fixed expedition preparation package. |
| 23 | What He Was Carrying | Tracker | Reach the final pre-Pripyat hunting checkpoint. | Survival-supply barter and Pripyat lead, subject to ordinary travel access. |
| 24 | The Last Address | Authored | Retrieve the companion's notebook at the first Pripyat destination. | Medical supplies and next location clue. |
| 25 | Past the Turn Back Point | Hand-in | Supply ordinary research records whose availability at this stage is verified. | Modest repair credit; records narrow the search. |
| 26 | He Made It This Far | Authored | Locate the final equipment case and recover the companion's keepsake. | Final selected maintenance-stock improvement. |
| 27 | Bring Him Home | Tracker | Reach the final hunting checkpoint; the keepsake was already recovered at step 26. | One supplied Survival Knife, meaningful through dialogue, with no new item powers implied. |
| 28 | Nothing Left Unsaid | Authored | Return from the final field search with a second piece of personal evidence and conclude the story in Marsh. | Permanent recognition, changed greeting, final survival-supply barter. |

Step 28 includes a real field conclusion; the final conversation does not inflate the step count.
Review the late tracker at 27 during playtesting: cumulative credit should minimise an awkward
interruption after recovering the keepsake. The exact personal evidence and locations are not selected.
No authored notebook or keepsake is counted as one of the seven ordinary hand-ins.

## Preserve and redistribute his current vendor unlocks

Verified against the current
[Old Timer definitions](../../gamemodes/ix_cotz/plugins/progression/definitions/sh_oldtimerprog.lua).
Seller assignments below are proposed. All item IDs must remain valid; no rename is implied.

| Item ID | Current item name | Proposed seller | Proposed milestone |
| --- | --- | --- | --- |
| knife2 | Kitchen Knife | Old Timer | Step 3 |
| knife3 | Survival Knife | Old Timer | Step 12 |
| knife4 | Battered Bayonet | Quartermaster | Military equipment milestone AND completion of Old Timer step 12; exact local step open. |
| sharpening_stone | Sharpening Stone | Old Timer | Step 7 |
| sharpening_stone_fine | Fine Sharpening Stone | Old Timer | Step 19, after both branches and therefore after the ordinary stone at step 7. |
| bat | Bat | Haggler | Early practical protection unlock. |
| hatchet | Hatchet | Old Timer | Step 8 |
| machete | Machete | Spoor | Hunting equipment branch. |
| fireaxe | Fireaxe | Latch | Industrial tool branch. |
| fubar | FUBar | Latch | Later heavy tool unlock. |
| hidestasher_cleaningkit | Cleaning kit | Cleaner | First stash-equipment branch. |
| hidestasher_shovel | Shovel | Cleaner | Later stash-equipment branch. |

The stash Cleaning kit is not a weapon cleaning kit. Old Timer's current bandage capacity benefit
for medic_bandage_1 and medic_bandage_2 is proposed to move into Jitters' stock progression.
The table covers Old Timer's current vendor items, not the whole roster's audit or his complete
current story effects. Existing Haggler/Spicy Lemon/Mute arrival milestones also need explicit mapping.

The knife purchase chain is explicitly step 3 (knife2) → step 12 (knife3) → Quartermaster's
local knife4 milestone, which requires step 12 on the same player character. Quartermaster cannot
unlock the better knife through his own line alone. Show that prerequisite in his locked dialogue.
No purchase or possession check substitutes for the completed milestone.

Fine stone access moves from the earlier draft's parallel step 15 to the post-branches step 19,
so it cannot precede the ordinary stone. At step 27, check whether the player has already earned
knife4 access: if so, propose an equivalent useful maintenance package or service credit instead of
presenting a Survival Knife as an equipment upgrade. Final substitute and value remain to be authored.

## Dialogue samples

| Moment | Draft editable line |
| --- | --- |
| Opening | “Everyone asks where the good loot is. Nobody asks whether they can carry themselves home. Food, water, bandages. Start there.” |
| First hunting checkpoint | “You came back. Good. Don't let one dead mutant convince you that you know what you're doing.” |
| Companion introduced | “I know that name. Thought I'd stopped looking for it. Where exactly did you find this?” |
| Before Pripyat | “You've earned the right to make your own bad decisions. Take enough supplies to change your mind halfway there.” |
| Conclusion | “He kept it all that way… Leave it here. And sit down a minute. There's no hurry.” |
| Completed-story greeting | “Still in one piece? Good. Pull up a chair.” |

These lines, objective briefings, partial-progress replies, completion responses, reward explanations,
and conditional greetings belong in definitions. Shared mechanics must not contain Old Timer's story text.
