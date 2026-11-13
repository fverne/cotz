# Anomaly effects and performance

The controller owns field placement and artifact spawning. The ten field anomaly classes live in
`lua/entities/`; their client definitions include `lua/cotz/anomalies/cl_idle.lua` into their existing
`ENT` tables. Class IDs, bases, field density, damage amounts, cooldowns and artifact settings are unchanged.

## Damage types

| Field anomaly | Damage type |
| --- | --- |
| Burner / Burner 2 (steam) | `DMG_BURN` |
| Electro / Electro 2 | `DMG_SHOCK` |
| Bubble / Bubble 2 | `DMG_CRUSH` |
| Whirlgig / Karusel | `DMG_CRUSH` |
| Fruitpunch / Fruitpunch 2 | `DMG_ACID` |

Red Razor and passive anomaly damage also use `DMG_ACID`. Whirlgig and Karusel use
`util.BlastDamageInfo` with crush damage, retaining their radial damage amounts, origins and radii.
Burners, Fruitpunch and Bubble no longer use generic damage, so suit protection applies to their hits.
Burners use thermal resistance, Electros use electrical, Fruitpunch and Red Razor use chemical, and
Bubbles, Whirlgig and Karusel use gravitational. See the [suit protection fields](../suits/README.md#protection-and-use).
Crush damage is included in gravitational resistance and environmental headgear wear; this
classification also applies to other crush damage, including physics impacts.

## Client effects

The existing `lua/autorun/stalker_anomaly_particles.lua` entry point distributes the helper and
handles client PVS transitions. It uses an explicit engine hook because these resource entities can
also load outside Helix. No additional plugin or autorun entry point is needed.

Idle particles and sounds start within 2,500 units of the local player's view entity. Once awake,
they stop beyond 2,750 units. Awake entities check every 0.1 seconds; sleeping entities check every
0.5 seconds. PVS exit stops owned effects immediately, and reentry schedules a fresh proximity check.
The server's `StopParticle` cooldown state suppresses idle particles. Removal also cleans up owned
particles, sound and lighting. Activation effects remain server-triggered. Burner/steam cooldowns
let the client recreate their idle particles instead of creating a second server-driven idle system.

Dynamic lights update once per awake check, only when visible lighting is required. Clients can toggle
**Anomaly Lights** under **Performance** in the Helix settings. The option is saved locally and
defaults to enabled. Outside Helix, or before its option library is available, lighting stays enabled. It does not hide anomaly particles or affect damage.
Floating beads, hoverstones and warp entities have separate effects and are outside this helper.
Particle asset density is unchanged; `particles/stalker_anomaly.pcf` is supplied by mounted content.

Run from the repository root:

```sh
luatex --luaonly tests/anomaly_client_spec.lua
luatex --luaonly tests/anomaly_performance_spec.lua
luatex --luaonly tests/anomaly_damage_spec.lua
luatex --luaonly tests/anomaly_resistance_spec.lua
luatex --luaonly tests/headgear_durability_spec.lua
```

These mock checks cover lifecycle, scheduling, damage callbacks and resistance, not rendering performance.
In multiplayer:

1. Compare client frame time from the same position looking at a dense field, with lights enabled
   and disabled. Compare idle and activated states separately.
2. Approach from beyond 2,750 units, move across both distance boundaries, and leave/reenter the PVS.
   Verify one idle effect returns, without missing close-range hazard cues or accumulating sound.
3. Keep another player beside the field while the viewer leaves. Only the viewer's proximity should
   control that client's idle effects. Check an alternate view entity as well.
4. Activate every type, including both electrical and bubble variants. Check cooldown recovery and
   burner/steam idle recovery after their 11-second effect cleanup. Damage and artifacts must still work.
5. Remove awake entities and repeat entry/exit several times; check for lingering particles, lights,
   sounds or Lua errors. Compare frame times before and after under the same field population.
6. Trigger each field type with and without anomaly protection. Verify burn, shock, acid and crush
   damage, suit/headgear wear, and Whirlgig/Karusel range, obstruction and falloff behavior.

The detector has its own [scan policy and checks](../anomalydetector/README.md).
