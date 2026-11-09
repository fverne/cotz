# COTZ configuration defaults

`sv_vendorcash.lua` disables NPC cash limits through the existing vendor use/trade hooks, including
standard Helix vendors with legacy saved balances. Both endpoints dispatch the trade hook before
checking vendor funds. The hooks clear the NPC balance and return nothing, preserving access and
weight checks. Advanced vendors also disable cash accounting in their owning implementation.
Player purchase costs and sale payouts remain active. Verify both vendor classes with
`luatex --luaonly tests/helix_vendor_trade_spec.lua` and live multiplayer selling after restart.

`sh_defaults.lua` contains the approved local installation's saved Helix settings as repository
fallbacks, including its fonts, inventory dimensions, weight limit, starting date and spawn counts.
The default inventory is 7 columns wide and 11 rows high.
`webUrl` (Discord relay webhook) and `communityURL` remain deployment-owned; `communityText` remains
"Discord". No endpoint values are copied into this repository.

The plugin applies these defaults during `InitializedPlugins`, before Helix's normal `config.Load`.
On initial startup it also seeds each initial value: the bundled `SetDefault` only changes the default
for already registered options. Normal saved global/schema configuration then takes precedence.
On Lua reload only defaults change, retaining live admin overrides. Registration metadata, callbacks,
networking flags and persistence scope remain owned by the original option. This does not force-save
configuration or reset date, character or world data.

Map thresholds are registered by their owning spawners through `ix.spawnPolicy`, defined in the schema.
Supported map suffixes are `rp_marsh_cs`, `rp_garbage_cotz`, `rp_waystation` and `rp_pripyat_remaster`.
`worldSpawnerThreshold`, `boxSpawnerThreshold`, `artifactSpawnerThreshold` and
`eventControllerAdvThreshold` use `<key>_<map>` overrides; `-1` inherits the shared value and `0` stops
that spawner. The routine event controller retains its corresponding mutant target/cap overrides.
Mutant cap zero means unlimited; routine target zero stops routine mutant spawning. Shared defaults
are 50 world items, 40 boxes, 5 artifacts, 1 advanced event, 70 routine mutants, 128 total mutants and
32 regional mutants. Existing shared and map-specific saved values remain authoritative.

For another map, add it to `ix.spawnPolicy.maps` and the routine controller's map list on all servers.
Spawn rates and artifact chances remain shared. No saved spawner points are moved or regenerated.

Run `luatex --luaonly tests/config_defaults_spec.lua` and
`luatex --luaonly tests/shared_commands_spec.lua`. Validate fresh/existing installs, hot reload and
client config synchronization in multiplayer before deployment.

Lowered hands right-click on a player toggles passage through other players. Right-click again
while lowered to switch it off. The `cotzHandsPassage` character data flag is saved immediately and
restored after loadout, including reconnects, respawns and server restarts. Existing characters default
to disabled; no saved data migration is needed. Switching characters uses that character's own setting.
`sh_handspassage.lua` uses a shared `ShouldCollide` rule for player pairs when either player has passage
enabled. Collision groups stay unchanged: changing only the mover's group does not change the group
used by player movement traces. The server and client cache the toggle and call `CollisionRulesChanged`
when it changes. A client NWBool proxy applies incoming values before invalidating the collision cache;
newly networked players initialize from their replicated value. Existing saved preferences are retained.
Disabling is refused while a normal movement hull trace starts solid or another living, solid player's
standing/crouched hull overlaps, including players with passage enabled. Move clear and try again.
If a loadout requests disabling while overlapping, a short retry restores collisions once clear without
changing the saved preference. There is no expiry timer. Raised-hand pushing is unchanged.
Run `luatex --luaonly tests/hands_passage_spec.lua`, then verify with two clients, props, doors and NPCs,
both movement directions, crouching, character switches and reconnect/restart persistence.
