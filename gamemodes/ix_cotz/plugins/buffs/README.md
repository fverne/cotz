# Buffs and bleeding

Bleeding is server-authoritative and independent of timed buffs. A successful, nonfatal bullet or slash
damage event rolls once, using post-mitigation damage: `min(damage / bleedingChanceScale, 1) ^ bleedingChanceExponent`.
Defaults are scale 100 and exponent 2. Separate pellet events roll separately; combined damage flags roll once.
A successful roll adds the damage amount to severity (maximum 100). Blocked and zero-damage events do not roll.

Every second, severity causes `severity * bleedingDamageScale` HP loss (default 0.01), with fractional HP
accumulated until whole damage can be applied. Severity then falls by `bleedingClotRate` (default 0.2).
Damage is world-attributed generic damage and can kill through normal death/revive handling.
The HUD shows rounded-up severity in a heart icon, transitioning from yellow to red (255, 0, 0) at maximum severity. Settings are in Helix's Bleeding configuration category.

`ix.plugin.Get("buffs")` exposes server methods `GetBleeding(client)`, `AddBleeding(client, amount)` and
`HealBleeding(client, amount)`. Add/Heal accept finite positive amounts; Add applies directly without a chance roll.
`SetBleedingSeverity` is the internal setter shared by lifecycle and ticking logic.

Character data `bleedingSeverity` holds current severity without per-tick character-data replication.
Existing characters default to zero. Normal character saves and cross-server saves persist this field.
Offline time pauses severity; fractional HP and tick scheduling restart on load. Death clears bleeding,
including when a corpse remains revivable. Spawn restores severity instead of clearing it.
Only rounded severity changes are replicated through the owner's `bleedingSeverity` local variable.

Gauze, elastic, and compression bandages remove 20, 50, and 90 severity, on both self and target use.
Their concrete definitions declare `bleedRestore`. Existing healing and consumption remain unchanged:
self-use consumes on starting the ten-second action, even if canceled; target-use is immediate.
Medkits do not treat bleeding. Healing does not stop bleeding by itself.

Run `luatex --luaonly tests/bleeding_spec.lua` from the repository root.
Mocks do not establish runtime correctness. Multiplayer checks: bullet/pellet and mutant slash damage,
armor and blocked hits, HUD/resolution changes, self/target bandages and cancellation, death/revive,
character switching, reconnect, and actual cross-server save/transfer.
