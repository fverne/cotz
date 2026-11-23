# COTZ Workshop Mutants

This test addon ports the NPC roster from Comrade Communist’s
[[VJ] S.T.A.L.K.E.R. “Mutants”](https://steamcommunity.com/sharedfiles/filedetails/?id=2099952978)
to COTZ’s `stalker_ai`. It registers 131 concrete NPC classes and the random Phantom entry.
The roster includes internal variants and summons from the original, alongside its spawnmenu NPCs.

## Install

1. Extract `cotz_workshop_mutants` into `garrysmod/addons/` on the test server or listen host.
2. Mount COTZ and the `cotz_general`, `cotz_projectstalker`, and `cotz_humannpc` content packs.
   Players need the same assets. The server sends the addon’s shared and client Lua.
3. Restart and open **NPCs → COTZ Workshop Mutants**. Use your usual COTZ NPC-spawn permissions.

Each class uses the `npc_mutant_workshop_` prefix. For example, `vj_mutant_tar` becomes
`npc_mutant_workshop_tar`. See [the roster](lua/cotz_workshop_mutants/roster.lua) for the model,
source class and combat settings for each entry. The original Workshop archive and VJ Base are
unnecessary with the COTZ content packs mounted. The classes are manual spawns and are outside the
stock COTZ spawn pools.

## Behavior

- Ground NPCs use COTZ schedules, navigation, melee and target validation. Melee and leap profiles
  use source damage and timing where those values work with the installed model. Several fully
  stationary or noncombat NPCs retain those roles.
- Flyers use short collision-checked movements and swimmers pursue within water. Neither builds its
  own nodegraph. Ranged attacks use a visible target, a windup and a cooldown. Source projectile
  damage is represented by direct damage or hitscan, with psychic damage routed through COTZ.
- Burer shields, Psydog phantoms and other ported summons use the COTZ spawn budget. A summoner can
  maintain one temporary child. Summoned NPCs cannot summon replacements themselves. Death bursts
  run one local search. Cloaking changes opacity at range and reveals the NPC when it attacks.
- The pack uses bounded updates and the COTZ population manager. It adds no periodic world scans,
  custom network messages, or per-attack projectile entities. Small creatures, ghosts and stationary
  actors skip server ragdolls.
- This is a roster-wide compatibility port. VJ-specific boss phase chains, prop throws and hazards,
  weapon inventory, scene effects, and exact projectile trajectories have been simplified or
  omitted. The Burer Shield’s original model is absent from the Workshop archive and the installed
  content. It uses the mounted Burer variant with reduced health and a finite lifetime.

## Playtest

On a test map with a ground nodegraph, try a mixed pack near two clients. Check sight loss during a
windup, player disconnects, ground jumps, model playback, and deaths. Use a water area for Rotan
and Vodyanoi, and test flyers near a low ceiling. Smoke-test a controller, Psydog, Burer and the two
armed impostors against both players and existing human NPCs. Compare server frame time to an
equivalent number of stock COTZ mutants, then move away and confirm they enter and leave sleep.

The dedicated-server smoke test loaded all 132 classes with COTZ’s NPC base in Sandbox and
confirmed Karlito’s melee damage, Pyrogeist’s ranged damage, and Blooind’s rifle damage. The two
Pseudobrain models lack compatible melee sequences and use a timed hit for close-range attacks.
Two-client rendering, full COTZ encounters and server frame time still need the playtest above.
