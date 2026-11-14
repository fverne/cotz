# Mutant defense

Scheduled, session-only Supply-truck defense events reward transferable personal vendor trader supplys.
The `eventcontroller`, `jobsystem`, `advdupeint`, `vendor_adv`, and `dialogue` plugins must be enabled,
with AdvDupe2 installed. No world setup or database migration is needed. Restart/changelevel to load changes.

## Scheduling and crash scene

Each map/server rolls an independent 30–60 minute delay after startup and each event ends. One deploying,
warning or fighting event can exist at a time. The timer does not depend on the advanced event rotation.
At least one living eligible character must be on the map for an automatic crash. Empty maps, missing
dependencies, unsuitable sites or failed pastes retry after 60 seconds; identical startup failures are
reported once until the reason changes or a crash starts successfully. `automationEnabled = false` stops
automatic attempts; administrators can still start an event manually.

Supply-truck sites use the research-defense selector on the current map: named eventcontroller points tagged
`_outside_easy` or `_outside_hard`, with up to eight outdoor approaches 512–4,096 units away and within 256
vertical units. Saved map entries override read-only FTS coordinates, including explicitly empty saved tables.
The center must pass grounded placement checks and have 256 units of player clearance before pasting.
Selected coordinates, approach points and the `/eventadd` location text are retained for that encounter.

**Required deployment asset:** author/export a prop-only Supply-truck crash scene in Garry's Mod as
`event_mutantdefense_supplyvan.txt`, then install it in
`data/advdupe2/STALKERDupes/` (or the installed `AdvDupe2.DataFolder` equivalent).
Place the dupe's anchor at ground level. `dupeName` and `dupeOffset` in `PLUGIN.settings` select the filename
without its extension and placement offset; the default offset is zero. No substitute dupe is provided.
The van is scenery with no objective health; `noItems = true` suppresses dummy-item loot conversion.
Vouchers remain the encounter reward.

After a successful paste creates the scene, all loaded characters on this server receive LPDA news:

> The supply truck has crashed %s. Go secure the site if you want supplies back in town! Mutant waves begin in 10 minutes.

`%s` is the selected point's location text. No equipped PDA is required, and the message is not relayed to
other servers. The countdown starts after paste completion. Missing, failed or empty pastes do not announce
an event. A paste that never completes is cancelled after the retry interval; stale callbacks cannot restart
or announce a cancelled event.

The warning lasts 600 seconds. It does not accrue wave credit, abandonment or encounter timeout.
At its end, wave one begins as soon as a living defender is present, without an additional preparation
delay. If nobody arrives, the ordinary 30-second abandonment grace begins at the warning deadline.
The fight's 600-second timeout also starts at that deadline.

## Commands and encounter

- `/MutantDefenseStart`: select a research-defense site, paste the van and start the full warning countdown.
- `/MutantDefenseStatus`: report the next attempt or location, phase, countdown, dupe instance, wave,
  attackers still required/awaiting spawn, living defenders,
  center coordinates, radius and the last reason spawning was blocked (placement, player clearance or population).
- `/MutantDefenseCancel`: cancel deployment, warning or fighting; remove the scene and surviving attackers.

All three commands require Helix administrator command access. Only one event runs per server.
Edit `PLUGIN.settings` in `sh_plugin.lua` for tuning. Defaults include 10 seconds between waves,
a 1,500-unit defense radius, 30 seconds of abandonment grace, and a 600-second fight timeout.
Nearby characters receive notifications at wave start/clear, abandonment, and completion/failure.

Before each wave, count living, unrestricted defenders in the area, excluding noclip/observers and downed
players. Freeze that wave's count at `N = min(defenders, 8)`; everyone can participate beyond the scaling cap.

| Wave | Attackers |
| --- | --- |
| 1 | `2 + N` dogs |
| 2 | `1 + N` boars |
| 3 | `2 + N` dogs and `ceil(N / 2)` pseudodogs |

A character must start a wave alive and remain inside the area for its full duration to earn credit.
Presence is sampled once per second; character changes and disconnects invalidate the current wave immediately.
Downed characters retain presence at their Helix ragdoll or the revive plugin's corpse. Dead characters use
their recorded death location until respawn when no corpse exists. Death does not invalidate wave credit.
At completion, the same character must be connected and present; being downed/dead is allowed.
If no living defender remains for 30 consecutive seconds, the event fails. A final mutual kill may finish
successfully before that grace period expires.

Living/observer eligibility follows the mutant combat system's movement-type checks. A revived player who
is walking counts as living even if an observer camera field remains set or the old corpse still exists
until the next tick. Living players use their own position rather than a surviving corpse reference.
The `/charrevive` command captures the body's position before spawning, because the revive plugin's
`PlayerSpawn` schedules that body's removal. It does not rely on the corpse remaining usable after spawn hooks.
Reviving within the abandonment grace period resumes the encounter; it does not restart the current wave.

Spawn attempts share `ix.jobs.field.FindDefenceSpawn` with research defense, shuffling the selected approaches
and calling eventcontroller's nodegraph/floor placement service with its default 750-unit radius. Validated
positions are used directly, with 256 units of player clearance and no separate center-ring restriction.
At most two creation attempts occur per one-second update. Event attackers use isolated
combat packs, remain awake, and respect global/regional hard population limits, including queued spawns.
Blocked slots remain required. Only `OnNPCKilled` completes a slot; unexpected removal causes replacement.
The timeout prevents permanently blocked events. Clear navigation and approaches still require map testing.

Every event ending removes its tracked crash scene. Cancellation, timeout, abandonment, map cleanup, and
own/required plugin unload or reload also remove surviving attackers without rewards. Ordinary corpse cleanup
manages killed mutants. Interrupted events and timers do not resume after restart.

## Rewards and vendors

Each qualified character earns one `mutant_defense_voucher`. It is a 1×1, 0.01 kg item with zero price,
excluded from business purchases, normal vendor trades, and random loot pools. Players can transfer it.

Delivery starts immediately. Full inventories preserve an entitlement in the character's existing data under
`mutantDefenseRewards`: a pending count, monotonically increasing serial, and current delivery token.
Inventory slot reservation is not delivery confirmation: `InventoryItemAdded` acknowledges the inserted item
before decrementing the count. Matching tokens reconcile existing items after reconnects. This uses the
installed inventory API and normal asynchronous character/item saves, without a new database transaction system.
An in-flight insert stays locked until its callback; database failures require normal server diagnosis/recovery.
Character load retries delivery. **Collect defense rewards** in vendor dialogue also retries stored rewards.

**Hand over a trader supply** consumes one carried voucher after a successful restock of that character's
stock with that vendor and pays 1,000 rubles to the redeeming character (`voucherReward` in settings).
Failed hand-ins keep the voucher and pay nothing. The server checks access, distance (192 units), possession and a one-second cooldown.
NPC responses remain empty; transaction notifications explain the result, including for silent contacts.

Restocking uses `ix.vendorStock.RestockFraction(character, vendor, 0.5)`. Existing task completions use the
same calculation at `0.2`, retaining their claim deduplication. Only currently unlocked sale goods with positive
maximum stock, interval and restock amount qualify. Buy-only goods, quest/access-card IDs, Sherpas and hideout
vendors are excluded. Capacity includes progression bonuses. Stock is capped at maximum; fractional units
carry over using the existing restock credit. If no eligible count/credit can increase, keep the voucher.
Other characters' stock and catalogue unlocks are unaffected.

## Verification

Run from the repository root:

```sh
luatex --luaonly tests/mutant_defense_spec.lua
luatex --luaonly tests/field_tasks_spec.lua
luatex --luaonly tests/vendor_stock_spec.lua
luatex --luaonly tests/task_rewards_spec.lua
luatex --luaonly tests/dialogue_order_spec.lua
luatex --luaonly tests/town_dialogue_menus_spec.lua
luatex --luaonly tests/population_performance_spec.lua
luatex --luaonly tests/npc_combat_spec.lua
luatex --luaonly tests/event_spawnplacement_spec.lua
```

The defense spec also executes the installed `/charrevive` callback and corpse-removing `PlayerSpawn` hook
through wave-two death, revival and wave-three spawning, including a stale observer camera mode.
It uses the actual research selector and placement helper, with mocked AdvDupe2 completion, to check timing,
missing dependencies, failure/retry, empty pastes, cancellation, stale callbacks, cleanup and local recipients.

In multiplayer, install the new van dupe and verify grounded placement and approach navigation at representative
outdoor points. Check warning delivery to distant characters without PDAs, isolation from other servers,
the full countdown, unattended crashes and cleanup during warning or fighting.
Test all three waves with late arrivals/leavers, death/revive/respawn, character switches,
different group sizes and population caps. Check actual map navigation and blocked approaches, kill versus
removal, abandonment, cancellation and cleanup. Verify full inventories and bag insertion, reconnect delivery,
transfer to another character, silent/contact/vendor access, repeated dialogue requests, one-unit fractional
stock, progression-adjusted maxima and an already-open trade window. Standalone mocks cannot establish
engine, networking, navigation, live SQL ordering or multiplayer correctness. Never run first-time setup or
reset saves as validation.
