# Anomaly effects and performance

The controller owns field placement and artifact spawning. The field anomaly classes live in
`lua/entities/`; their client definitions include `lua/cotz/anomalies/cl_idle.lua` into their `ENT` tables.
The ten original classes keep their IDs, bases, field density, damage amounts, cooldowns and artifact settings.

## Trigger sizes

Triggers follow the idle particle: the horizontal area it spawns in, or the main sprite for effects emitted
from one point. Soft glow edges and drifting embers do not count. When an idle system changes, update its
trigger and the definition's `triggerRadius`. Values are box half-widths unless noted.

| Anomaly | Units |
| --- | --- |
| Burner, Burner 2 | 30 |
| Electro, Electro 2 | 60, 70 |
| Bubble, Bubble 2 | 120, 80 |
| Whirlgig (box, player and prop pull, corpse capture) | 120 |
| Fruitpunch, Fruitpunch 2 | 90, 50 |
| Karusel (box only; its 300-unit pull is unchanged) | 90 |
| Springboard (box; the launch still reaches 110) | 80 |
| Tesla (`DetectRadius`, sphere) | 150 |
| Psy Pocket (`BalanceRadius`, sphere: drain and distortion) | 150 |
| Smouldering Ground, Acid Mist, Static Ground | 130 |
| Comet, Ball Lightning (`HitRadius`, sphere) | 80, 60 |

## Anomaly types

| # | Definition | Class | Behaviour |
| --- | --- | --- | --- |
| 1 | Burner | `anom_jarka` | Flame column on contact |
| 2 | Burner 2 | `anom_par` | Steam jet on contact |
| 3, 4 | Electro, Electro 2 | `anom_electra_anomaly`, `_type2` | Discharge on contact |
| 5, 6 | Bubble, Bubble 2 | `anom_maysorubka_anomaly`, `_type2` | Crushing burst on contact |
| 7 | Whirlgig | `anom_voronka_anomaly` | Pulls in, then blasts |
| 8, 9 | Fruitpunch, Fruitpunch 2 | `anom_gazirovka_anomaly`, `anom_kisel_anomaly` | Acid burst on contact |
| 10 | Karusel | `anom_tramplin_anomaly` | Lifts and blasts everything around it |
| 11 | Springboard | `anom_springboard` | Throws everything nearby up and away after a short wind-up |
| 12 | Tesla | `anom_tesla` | Crackles for 2.5 s when someone comes within 150 units, then shocks everyone within 320 not behind cover |
| 13 | Psy Pocket | `anom_psyfield` | Drains PsyHealth from players inside, with periodic voice pulses and screen distortion |
| 14-16 | Smouldering Ground, Acid Mist, Static Ground | `anom_zone_fire`, `_acid`, `_electro` | Wide patches that hurt whatever stands in them every second |
| 17 | Comet | `anom_comet` | Burning sphere that circles its spawn point and scorches what it passes |
| 18 | Ball Lightning | `anom_comet_electra` | Faster, tighter-looping electrical comet |

Types 11-18 share `cotz_anomaly_base` (and `cotz_anomaly_zone` or `cotz_anomaly_comet`), which is never
spawned and lacks the `anom_` prefix the detector, controller and balance tooling look for. Their tuning uses
the usual `Balance*` fields. They have no `category` yet, so `/anomalyadd` cannot select them; only an
old-style mask longer than ten digits reaches them. Comets and Psy Pockets have a 1024-unit interval, so a
point spawns one of them.

## Spawn points

`/anomalyadd [radius] <selection...>` adds a point at the crosshair. The radius is optional (default 128);
the selection is any mix of categories and anomaly names:

| Category | Anomalies |
| --- | --- |
| `fire` | `burner1`, `burner2` |
| `electro` | `electro1`, `electro2` |
| `gravity` | `bubble1`, `bubble2`, `whirlgig`, `karusel` |
| `acid` | `fruitpunch1`, `fruitpunch2` |
| `all` | every anomaly above |

For example `/anomalyadd fire` or `/anomalyadd 256 burner1 "burner 2" electro2`. Names are the definition
`name` lowercased with spaces and punctuation removed; categories come from each definition's `category`.
Unknown words are rejected with the list of valid choices. `sh_anomalyselection.lua` owns parsing and
resolution.

The point stores the normalized selection as a space-separated string (`"fire burner2"`), so FTS presets
and exports keep the `{Vector(...), radius, "selection"}` shape, and a category point picks up anomalies
added to the category later. Strings of only `0` and `1` are the old per-index masks (`"0000111"` allows
definitions 5-7); the shipped presets and older saves use them and they still resolve.

Each spawn picks one of the point's allowed anomalies and places `ceil(radius / interval)` of it. Every
field definition with a category, and the Springboard, declares a `triggerRadius`: the half-diagonal of its
trigger box (43 to 170), or the Karusel's 300-unit pull. Other definitions use 85. A spot is rejected when
its trigger would overlap one of an anomaly already placed, from this point, another point or an earlier
spawn, unless the two are at least 128 units apart vertically. Each anomaly tries eight spots, then is
skipped rather than stacked, so a crowded point can spawn fewer anomalies than before. Anomalies removed
by `cleanAnomalies` in the same tick do not block placement.

Anomalies are placed at ground level: the spawner picks a random spot in the point's radius, traces straight
down against the world and puts the origin 5 units above the hit. It does not use `DropToFloor`, which would
rest the whole trigger box on the highest thing under it. `triggerRadius` only controls the horizontal spacing
between anomalies and has no effect on their height. Entities and clip brushes do not count as ground.

## Particles

The anomalies use the `cotz_anom_*` systems in `particles/cotz_anomalies.pcf`, which
`tools/anomaly_pcf.py` builds from the particle packs in `cotz_general`. The copy gives every effect a COTZ
name, so the overlapping `wick_*` files no longer decide which version loads, and repoints the few materials
the packs reference but do not ship. Artefact effects are not used for anomalies.

- Gravity anomalies mostly use `anarchycell_gravity_anomaly.pcf`, whose systems are grouped by anomaly name
  (`static` idles, `blast` triggers). Bubbles burst with `tramplin_blast`; the first
  idles as the mincer, Bubble 2 as `wick_anomaly_tramplin_static_2`. The
  Whirlgig plays `voronka_blast`, one system holding the whole pull-in and burst. The Springboard idles as
  `tramplin_static_2` and releases with `tramplin_blast`.
- The Karusel uses the `wick_anomaly_karusel_*` systems. Its charge holds the release too.
- `wick_anomaly_gravity_shield_part_1` (`cotz_anom_gravity_shield`) marks Bubble and Comet victims, and
  shows hits on the Burer's shield.
- Electrical, thermal, chemical and field effects come from the `wick_stalker_anomaly_*` files; the acid
  bursts use the original `gazirovka_activated`, and the comets the original `kometa` systems.
- The Psy Pocket glow and pulse are electrical field effects recoloured purple.

Edit
`SYSTEMS` in the tool and rebuild rather than editing the binary:

```sh
python3 tools/anomaly_pcf.py ../cotz_general
```

The tool writes into the content addon, which must then be republished so clients receive the file.
`lua/autorun/stalker_anomaly_particles.lua` registers it, along with `anarchycell_bloodspash.pcf` for
the `wick_gore_bloodsplash_new` gibs that the anomalies already used but nothing loaded.

Burner and steam flares now last three seconds after the last contact rather than eleven. The Karusel's charge
effect never ends by itself, so it is attached to the anomaly and stopped after the blast instead of being left
in the world. Damage waits for the burst in the particles: 2.3 seconds for the Whirlgig, 6.15 for the Karusel. Shocks, crushing hits and comet contact also play a short effect on the victim.

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
Bubbles, Whirlgig and Karusel use impact. See the [suit protection fields](../suits/README.md#protection-and-use).
Crush damage is an impact combat stat: it is reduced like bullets and wears suits and headgear at combat rates,
including crush from physics impacts.

## NPCs in pulling anomalies

Whirlgig and Karusel kill any live `npc_mutant_*` or `npc_human_*` inside their pull sphere (120 units around
the Whirlgig; 300 units around the Karusel's core, 300 above it), regardless of health, resistances or damage
immunities. Bears and both pseudogiants are exempt: they are never captured and only take the blast's ordinary
damage. A captured corpse is dragged to the core and held there, slowly spinning, without gravity until the next
blast gibs it. A corpse caught while the anomaly recharges waits for the following blast. Removing the anomaly
drops its corpses. As with other anomaly deaths, no player gets kill credit. A gibbed mutant cannot be poached,
and a gibbed human's body loot is lost; the weapon a human drops on death is spawned as usual.

`lua/cotz/anomalies/sv_mutantcapture.lua` owns this. NPCs without a ragdoll only die. Captured corpses
start the Karusel's blast cycle themselves; its touch trigger for everything else is unchanged.

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

Dynamic lights update once per awake check, only when visible lighting is required. Each class names a light
preset in `cl_idle.lua`. A light only shows while the server flags the anomaly as activated (the burner's
flare, an electrical discharge, a gravity burst, Kisel's chemical flare, Tesla's discharge, Psy Pocket's
surge). Idle anomalies emit no dynamic light, and floating beads never do. A class can add `IdleLayers`, extra systems started and stopped with its idle particle. Clients can toggle
**Anomaly Lights** under **Performance** in the Helix settings. The option is saved locally and
defaults to enabled. Outside Helix, or before its option library is available, lighting stays enabled. It does not hide anomaly particles or affect damage.
Floating beads, hoverstones and warp entities have separate effects and are outside this helper.
Particle density follows the source packs; the particle files are supplied by mounted content.

Run from the repository root:

```sh
luatex --luaonly tests/anomaly_client_spec.lua
luatex --luaonly tests/anomaly_types_spec.lua
luatex --luaonly tests/anomaly_selection_spec.lua
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
6. Look at every type idle and activated, including the eight new ones, and check for missing-material
   checkerboards, effects that never end, and lights that stay on after activation.
7. Stand in the open and behind cover during a Tesla discharge; walk through a Psy Pocket and check that the
   distortion fades out at its edge and after leaving. Follow a Comet around its loop near walls.
8. Trigger each field type with and without anomaly protection. Verify burn, shock, acid and crush
   damage, suit/headgear wear, and Whirlgig/Karusel range, obstruction and falloff behavior.

The detector has its own [scan policy and checks](../anomalydetector/README.md).
