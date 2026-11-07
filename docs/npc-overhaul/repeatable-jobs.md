# Repeatable NPC jobs — 6 November 2026

The revised `balancing.xlsx` job roster is implemented in townnpcs and jobsystem. The completed
workbook is `outputs/npc-jobs-2026-11-06/balancing-filled.xlsx`. Original entries and separator rows
are retained; H8–H10 retain their original text followed by implementation details. H10 corrects
the nuts example without changing the original note in F10.

## Roster and rewards

Twenty workbook rows use nineteen issuers: Atlas alternates between the two photography tasks.
Mute additionally offers triangulation, bringing the active issuer count to twenty.
The Eco Bunker is within Swamps, is the final access area, and requires the physical bunker card.
It is not a fifth map. Beanstalk, Egghead and Intern all live in the Swamps Eco Bunker. Their home
and claim map is `rp_marsh_cs`; retain their existing bunker placements. Beanstalk still offers
research defence, Egghead requests Garbage/Waystation/Pripyat specimens, and Intern offers sensors.

| Workbook row | Issuer | Work | Easy / medium / hard |
| --- | --- | --- | --- |
| 2 | Old Timer | Specific mutant kills | Swamps / Garbage / Waystation |
| 3 | Cleaner | Dead drops | Garbage→Garbage / Garbage→Swamps or Waystation / two different non-Garbage maps |
| 4 | Haggler | Hostile-human kills | Swamps / Garbage / Waystation |
| 5 | Vesper | Sensor deployment and retrieval | Garbage / Waystation / Pripyat |
| 6 | Intern | Sensor deployment and retrieval | Swamps / Waystation / Pripyat |
| 7 | Smartass | Computer extraction | Existing 1 / 2 / 5 computer types |
| 8 | Technut | Valuable courier | Swamps acquisition rules |
| 9 | Latch | Valuable courier | Garbage acquisition rules |
| 10 | Quartermaster | Valuable courier | Waystation acquisition rules |
| 11 | Ballast | Equipment recovery | Swamps light / Swamps heavy / Garbage or Waystation heavy |
| 12 | Beanstalk | Research defence | Random non-Pripyat / random region / random region; 3 / 4 / 5 waves |
| 13 | Spicy Lemon | Cooked mutant meals | Swamps / Waystation / Pripyat species |
| 14 | Jitters | Specific mutant specimens | Swamps / Garbage / Waystation species |
| 15 | Egghead | Specific mutant specimens | Garbage / Waystation / Pripyat species |
| 16 | Wake | Information courier and return | Swamps settlement / Waystation / Eco Bunker or Waystation |
| 17 | Spoor | Mutant category hunting | Garbage / Waystation / Pripyat |
| 18 | Boss | Hostile-human kills | Garbage / Waystation / Pripyat |
| 22 | Spool | Triangulation | Garbage 3 / Waystation 4 / Pripyat 5 readings |
| Additional | Mute | Triangulation | Swamps 3 / Waystation 4 / Pripyat 5 readings |
| 23 | Atlas | Mutant photography | Any supported map; 3 / 5 / 7 distinct living species |
| 24 | Atlas | Anomaly photography | Any supported map; 3 / 5 / 7 actual registered anomaly types |

New reference cash budgets are 1,000 / 2,000 / 3,000 rubles; reputation is 15 / 25 / 35.
Reference cash is not a guaranteed payout. Non-item jobs currently pay 55% of reference cash
(550 / 1,100 / 1,650 rubles); hand-ins pay 500 / 1,000 / 1,500 plus 50% of the required
items' value. This added payment is separate from supplies and bonus allowance. Rewards are chosen
at completed hand-in and remain hidden beforehand. The new consumable/currency packages and five-task
bonuses are documented in the [jobsystem reward guide](../../gamemodes/ix_cotz/plugins/jobsystem/README.md#task-rewards-and-existing-kits).
Medium/hard reputation gates and equipment purchase gates remain.
Supply allowance minimums and rounding still apply independently to item packages.

Arena Master, Brass, Carbon, Gasket, Ledger, Suture and The Original have no new ordinary offers.
The Original is no longer used; Jitters now owns his specimen requests, using Jitters's existing
medical reward packages. The other contacts retain their shops, services, incoming-delivery categories
and finite progression.

## Definition and runtime ownership

Each concrete town contact declares its current `job`. `legacyJob` retains the former registration
data solely to complete accepted work and preserve existing thematic receiver categories. Its IDs
are marked `completionOnly`, removed from ordinary categories, and rejected on new acceptance.
Reputation terms for accepted old work remain 15 / 30 / 45; its cargo and assignment progress are retained. Unpaid item hand-ins use the current cash formula;
old acceptance-time reward reservations migrate to completion-time choices.
New IDs are `cotz/town/v2/<contact>/<difficulty>/<target>`. Finite commission IDs are unchanged.
The Original's `retiredRegionalJob` also retains the superseded v2 specimen definitions without
offering them. Existing assignment identities are not erased or silently transferred between characters
or issuers. This compatibility data does not restore The Original's world placement.

The shared jobsystem regional library handles eligibility, species identity, receiver matching and
map-valid research waves. Its server module owns loan/courier insertion, regional kill progress,
photography progress and cleanup. The town regional library compiles offers from concrete contact
settings. New hooks follow the installed Helix dispatcher; no bundled framework files are changed.

The static `jobsystem/definitions/sh_regionalcatalogue.lua` is generated from active encounter
definitions, harvest mappings and the existing offline FTS loot/availability extractor. There are no runtime
source-file scans. Rebuild with:

```sh
python3 docs/npc-overhaul/tools/regional_job_catalogue.py
```

Rebuild after loot sources change; the generator reads current checked-in presets directly. It excludes
currency, money cargo and author-disabled items. World rates remain comparative source evidence,
not guaranteed player acquisition time. It does not deploy any map data.

Standard pack sizes are rounded-up medians of species counts per regional encounter. Pseudodogs
use a baseline of two. Human baselines exclude sniper-only encounters. Specific kills and cooked
meals use `ceil(1.1 × pack)`; specimens use the workbook's `ceil(0.8 × pack)` or `ceil(1 × pack)`.
Meals and specimens count whole items. Harvest chances are unchanged and human meals are excluded.

Kills save their map and species/faction or category weights. Only matching regional kills count;
nearby-player credit remains keyed per recipient. Spoor's four categories contain at least three
defined species each. A category needs three available regional species to be offered. Credit is `1 / species pack`,
with targets of two, three or a saved five–six packs. The PDA displays fractional pack progress.

Two temporary Garbage bandit patrols use three/four existing human NPCs. Replace their classes when
the new regional human NPCs arrive. Existing Garbage encounter-point coordinates are unchanged;
156 lowercase `vector` constructor calls were corrected to `Vector`.

## Deliveries, field work and photography

Valuable offers request one specific item: one minimum-yield batch on easy and two on medium/hard.
Nuts use three per batch and bolts four. Easy allows local/easier sources; medium is local;
hard requires a harder-map source and no modeled local/easier source. Owned or traded goods count.
Any permitted themed receiver on the issuer's current map can accept the requested item through
**I have a delivery for you**. The player chooses the issuer/assignment. Server checks enforce the
claim, current character, receiver category/access, region, proximity and remaining quantity.
Partial stacks retain surplus. Failed removal grants no progress. Payment, bonus and restock remain
with the issuer; intermediate deliveries award none of them.

Dead drops save both endpoint maps. Coordinate separation applies only on the same map. Cargo
appearance/name/description are chosen once, retained across travel and reused for lost-cargo recovery.
Recovery uses three light variants (0.5 / 0.75 / 1 kg) or three heavy variants (3.5 / 3.75 / 4 kg).
Wake issues information-only bound cargo, requires a named NPC handover and pays after return.
Easy recipients are Swamps settlement contacts, excluding all three bunker scientists; medium
recipients are in Waystation. Hard recipients include Beanstalk, Egghead and Intern in the Eco Bunker,
as well as Waystation contacts. Contact definitions use `bunker = true` to identify the gated receivers.
Hard courier previews and acceptance require permission to purchase `accesscard_bunker` from Carbon;
temporary stock depletion does not relock the offer. Lost parcels are reissued near Wake through the task list's
**Collect parcel from issuer** button. Inventory/weight failures leave issuance retryable.

Vesper/Intern's new repeatable sensors snapshot a 900-second recording duration and an absolute
`os.time()` completion deadline at deployment. They still require departure and retrieval.
Accepted old recording parameters remain unchanged. Triangulation uses 3/4/5 readings and the
existing 512-unit/15-degree separation requirements.

Research defence saves its map, valid regional mutant composition and rolled waves. Multipliers are
easy 1/1/1, medium 1/1/1.25/1.5, hard 1/1.25/1.5/1.75/2; counts round up. Existing population limits,
sampler health, retry rules, recording requirement and result return remain.

Atlas starts with mutant photography and alternates to anomaly photography only after completion.
Opening previews or abandoning work does not advance the saved sequence. One active job per issuer
still applies; the photo event supports simultaneous compatible assignments without consuming a shot.
The loan camera is 1×1, 0.75 kg, zero-price and character-bound, using `ix_camera` and Helix's weapon
item lifecycle. It survives inventory death-drop rules, restores after loadout/reconnect, and is
removed when the last photo assignment ends. The work menu can retry camera collection after a
failed insertion. Full inventories reject new acceptance; callbacks revalidate ownership/state.

The camera emits `cotz/camera/photo-taken` with authoritative server subjects. The jobsystem accepts
only the current character's loan camera. Living species use stable species keys; cosmetic variants
share a key and psychic projections have no eligible identity. Anomalies use actual controller entity
types, including separately registered variants. Corpses, duplicate types and empty spawnpoints
grant no credit. Saved type sets are bounded by the target count. Client JPEG/JSON files never grant
progress. Return to Atlas to finish and collect payment.

## Deferred progression and deployment

The user deferred progression rework. No beneficiary counters, checkpoint remapping, migrations or
save resets are added. Existing counts/completions remain, but unassigned contacts' cumulative
repeatable-job checkpoints can stall. This can also block progression-gated purchases for fresh
characters, including access required by later jobs. Resolve that in the planned progression pass
before treating this roster as a complete fresh-character progression release.

Deploy the same code to all map servers and restart together. Retain Beanstalk, Egghead and Intern
inside the gated Swamps Eco Bunker. The existing Swamps setup preset already contains their bunker
positions; do not rerun first-time setup. If a scientist is missing, use `/TownNPCPlace <slug>` at
the intended bunker position on Swamps. Remove and save any erroneous Waystation duplicates
separately. No live placement, server restart or deployment was performed by the offline implementation.

Run the existing jobsystem, loading, field-task, task-reward, town-NPC, vendor-plan, camera and
encounter-tag suites, plus `luatex --luaonly tests/regional_jobs_spec.lua`. The new coverage includes
regional eligibility, batches, kill credit, overlapping photos, duplicate subjects, camera insertion,
alternate receivers, surplus preservation, cross-map parcel delivery and persistent sensor deadlines.

Multiplayer checks remain required for NPC placement, navmesh/approaches, physical bunker access,
camera equipment/assets, full-inventory callbacks, map transfer, disconnect/restart and payment with
fresh/existing characters. Standalone mocks do not establish runtime correctness.

## Interaction update — 7 November 2026

Wake now issues the information couriers. Brass is characterised as an ammunition reloader and
has no new ordinary offers. Accepted Brass couriers retain completion-only definitions and their
saved issuer, destination and reward identity.

Spoken job offers and reminders use each contact's `jobBriefing`, `jobReminder` and `jobFinished`
text, with actual goods, recipients and regions. The task journal keeps its formal descriptions.
Incoming delivery dialogue requires the real usable item or matching bound parcel in inventory.
Finishing the final hand-in reveals reward choices immediately at the issuer; other completed
objectives reveal choices when speaking to the issuer. Reward selection still validates access,
distance, completion and cargo on the server.

Dead-drop pickup objects are invisible, non-solid and excluded from world persistence. A stash
digging tool's inventory action digs up or buries task parcels after an eight-second action. The
parcel also offers directions and burial in its inventory menu. Task digging does not consume tool
uses. Cancelling, changing character, losing the tool or moving away prevents the operation; inventory
failure leaves the saved pickup recoverable. These parcels never enter the permanent stash registry.
Field work in the task journal shows directions directly, with separate buttons for actions that
have no carried item, rather than opening another menu.
