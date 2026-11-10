# Mutant defense

Admin-started, session-only defense events reward transferable personal vendor restock vouchers.
The `eventcontroller`, `vendor_adv`, and `dialogue` plugins must be enabled. No world setup or database
migration is needed. Restart/changelevel to load the new plugin and item.

## Commands and encounter

- `/MutantDefenseStart`: aim at clear ground to place the center and begin preparation.
- `/MutantDefenseStatus`: report phase, wave, attackers still required, center coordinates and radius.
- `/MutantDefenseCancel`: remove surviving event attackers and end without rewards.

All three commands require Helix administrator command access. Only one event runs per server.
Edit `PLUGIN.settings` in `sh_plugin.lua` for tuning. Defaults are 30 seconds of preparation, 10 seconds
between waves, a 1,500-unit defense radius, 30 seconds of abandonment grace, and a 600-second overall timeout.
Nearby characters receive notifications at preparation, wave start/clear, abandonment, and completion/failure.
There is no automatic event scheduling or persistent event placement.

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

Spawn attempts use validated encounter placement, a 1,000–2,000-unit band around the center, and 256 units
of player clearance. At most two creation attempts occur per one-second update. Event attackers use isolated
combat packs, remain awake, and respect global/regional hard population limits, including queued spawns.
Blocked slots remain required. Only `OnNPCKilled` completes a slot; unexpected removal causes replacement.
The timeout prevents permanently blocked events. Clear navigation and approaches still require map testing.

Cancellation, timeout, abandonment, map cleanup, and plugin unload remove surviving event attackers without
rewards. Ordinary corpse cleanup manages killed mutants. Interrupted events do not resume after restart.

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

**Hand over a restock voucher** consumes one carried voucher after a successful restock of that character's
stock with that vendor. The server checks access, distance (192 units), possession and a one-second cooldown.
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
luatex --luaonly tests/vendor_stock_spec.lua
luatex --luaonly tests/task_rewards_spec.lua
luatex --luaonly tests/dialogue_order_spec.lua
luatex --luaonly tests/town_dialogue_menus_spec.lua
luatex --luaonly tests/population_performance_spec.lua
luatex --luaonly tests/npc_combat_spec.lua
luatex --luaonly tests/event_spawnplacement_spec.lua
```

In multiplayer, test all three waves with late arrivals/leavers, death/revive/respawn, character switches,
different group sizes and population caps. Check actual map navigation and blocked approaches, kill versus
removal, abandonment, cancellation and cleanup. Verify full inventories and bag insertion, reconnect delivery,
transfer to another character, silent/contact/vendor access, repeated dialogue requests, one-unit fractional
stock, progression-adjusted maxima and an already-open trade window. Standalone mocks cannot establish
engine, networking, navigation, live SQL ordering or multiplayer correctness. Never run first-time setup or
reset saves as validation.
