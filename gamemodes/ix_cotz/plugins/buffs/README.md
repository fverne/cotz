# Buffs and bleeding

Timed buffs and debuffs persist per character in character data `buffs`, storing each effect's
remaining seconds and parameters. Normal character saves, disconnects, character switches, and
cross-server saves capture the current remaining duration. Offline time and time spent playing
another character pause these timers. Reconnecting resumes them against the destination server's
`CurTime()`; effects do not tick or expire while offline.

Restoration runs once after Helix finishes the character's loadouts so equipment resistance resets
cannot overwrite restored bonuses. Removal callbacks undo live bonuses before disconnect, switching,
or reapplication on spawn. Death clears saved and live effects, including before a revive; other
spawns restore them. Expired effects are removed before their next gameplay tick. Removed definitions
and invalid saved durations are discarded on restore. Existing negative-duration `AddBuff` calls
retain their current 1,000,000-second convention.

Existing characters need no reset or SQL migration: missing `buffs` data means no saved timed effects.
The separate `bleedingSeverity` save key and its behavior remain compatible. All timed-effect and
bleeding lifecycle hooks live in `sv_persistence.lua`, included server-side by `sh_plugin.lua`.

Bleeding is server-authoritative and independent of timed buffs. A successful, nonfatal bullet or slash
damage event rolls once, using post-mitigation damage: `min(damage / bleedingChanceScale, 1) ^ bleedingChanceExponent`.
Defaults are scale 100 and exponent 2. Separate pellet events roll separately; combined damage flags roll once.
A successful roll adds the damage amount to severity (maximum 100). Blocked and zero-damage events do not roll.

Every second, severity causes `severity * bleedingDamageScale` HP loss (default 0.04), with fractional HP
accumulated until whole damage can be applied. Severity then falls by `bleedingClotRate` (default 1).
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

Run `luatex --luaonly tests/buffs_persistence_spec.lua` and
`luatex --luaonly tests/bleeding_spec.lua` from the repository root.
Mocks do not establish runtime correctness. Multiplayer checks: bullet/pellet and mutant slash damage,
armor and blocked hits, HUD/resolution changes, self/target bandages and cancellation, death/revive,
character switching, reconnect, and actual cross-server save/transfer. Check timed healing and damage,
remaining HUD durations, and restored jump, sprint, psyblock, and suppression effects; verify bonuses
apply once after equipment loadout and clear on expiry, death, and character switches.

At defaults, severity 25/50/100 produces 1/2/4 HP per second before protection.
A severity-100 bleed clots in 100 seconds without further hits. Existing explicit server configuration
remains authoritative; set bleedingDamageScale to 0.04 and bleedingClotRate to 1 to adopt these defaults.
