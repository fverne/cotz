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
Bleeding hits preserve the player's existing view-punch angles and velocity, suppressing the additional
damage punch without clearing weapon recoil. Bleeding pain sounds have a separate five-second cooldown,
starting only when a sound plays; ordinary damage retains Helix's normal pain-sound timing. Blocked hits
do not start the cooldown. The cooldown survives clotting or treatment but resets on character restore,
death, character switching and disconnect; it is not saved across sessions.
The HUD shows rounded-up severity in a heart icon, transitioning from yellow to red (255, 0, 0) at maximum severity. Settings are in Helix's Bleeding configuration category.

`ix.plugin.Get("buffs")` exposes server methods `GetBleeding(client)`, `AddBleeding(client, amount)` and
`HealBleeding(client, amount)`. Add/Heal accept finite positive amounts; Add applies directly without a chance roll.
`SetBleedingSeverity` is the internal setter shared by lifecycle and ticking logic.

Character data `bleedingSeverity` holds current severity without per-tick character-data replication.
Existing characters default to zero. Normal character saves and cross-server saves persist this field.
Offline time pauses severity; fractional HP and tick scheduling restart on load. Death clears bleeding,
including when a corpse remains revivable. Spawn restores severity instead of clearing it.
Only rounded severity changes are replicated through the owner's `bleedingSeverity` local variable.

Gauze, elastic, and compression bandages apply 20, 50, and 90 **additional** severity reduction
evenly over six seconds, alongside natural clotting. Both self-use and target-use take two seconds.
Successful application immediately heals the recipient for 6, 9, or 12 HP, capped at maximum health,
and starts `buff_bandageclotting`. No old bandage stamina or instant severity reduction is applied.
Medkits do not treat bleeding. Healing does not stop bleeding by itself.

Concrete bandages declare `bleedRestore`, `restoreduration`, `restore` and `applicationTime`.
The shared aid helper validates ownership/charges and locks overlapping actions. One charge is
consumed on starting either application, including a later cancellation or invalidated recipient.
Failed starts do not consume charges. Completion rechecks life, both character identities, range
(96 Source units) and line of sight, and can apply its effects only once.

`StartBandageClotting(client, total, duration)` starts the server-owned effect. It returns false for
invalid inputs or a stronger ongoing treatment. Equal strength refreshes duration, stronger treatment
replaces it and weaker treatment does not extend or downgrade it. Completed applications still grant
their own immediate heal. The treatment is active even if the wound clots before its duration ends.

`ProcessBandageClotting(client, now)` integrates elapsed time with a remaining-treatment budget,
including fractional time. It settles before buff expiry and saves so the expiry boundary cannot
lose a final tick. Its character buff snapshot saves remaining duration and treatment; live clock
anchors stay on the player. Reconnects and character switches pause/resume treatment without granting
the completion heal again. Death clears it. No SQL migration or character reset is needed.
The HUD displays a clotting countdown. [Item properties](../../../../docs/item-properties.md) describes
the cosmetic Anomaly conversion and property providers.

Run `luatex --luaonly tests/buffs_persistence_spec.lua` and
`luatex --luaonly tests/bleeding_spec.lua` from the repository root.
Mocks do not establish runtime correctness. Multiplayer checks: bullet/pellet and mutant slash damage,
armor and blocked hits, HUD/resolution changes, self/target bandages and cancellation, death/revive,
character switching, reconnect, and actual cross-server save/transfer. Check timed healing and damage,
remaining HUD durations, and restored jump, sprint, psyblock, and suppression effects; verify bonuses
apply once after equipment loadout and clear on expiry, death, and character switches.
Verify bleeding adds no view punch while firing, pain sounds occur at most once per five seconds,
and ordinary combat still causes normal recoil and pain sounds during the bleeding cooldown.

At defaults, severity 25/50/100 produces 1/2/4 HP per second before protection.
A severity-100 bleed clots in 100 seconds without further hits. Existing explicit server configuration
remains authoritative; set bleedingDamageScale to 0.04 and bleedingClotRate to 1 to adopt these defaults.
