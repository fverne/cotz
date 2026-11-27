# COTZ Mutant Tests

Copy the `cotz_mutant_test` folder into `garrysmod/addons/` on the test server or listen host and
restart the session. Mount COTZ (including `stalker_ai`), its usual Helix setup, `cotz_general` and `cotz_mutantnpc`
on the server and clients. The server sends the addon’s client Lua. Deliver the models, materials
and sounds through your existing COTZ content setup. The addon has no VJ runtime dependency.

Spawn these manually from **NPCs → COTZ Mutant Tests** using your usual COTZ NPC-spawn permissions.

| Mutant | Class | Fight |
| --- | --- | --- |
| Tarakan | `npc_mutant_test_tarakan` | A small, fragile insect with quick bites. Spawn several together to test a swarm. |
| Karlito | `npc_mutant_test_karlito` | A heavy mutant with a loud windup and a wide, hard-hitting melee swing. |
| Radogeist | `npc_mutant_test_radogeist` | A translucent ground mutant with a short-range radiation pulse. Break line of sight or back out when you hear its windup. Radiation gear mitigates the hit through COTZ’s damage system. |

The classes are absent from the live spawn pools. Manually spawned test NPCs count toward COTZ’s
existing population limits and use its combat, navigation and sleep systems. Tarakan and Radogeist
leave no server ragdolls. Karlito’s corpse uses the existing corpse budget. Each attack uses the
base’s single impact search. There are no additional periodic scans, spawned minions or custom
network messages.

## Multiplayer check

1. On a COTZ map with a ground nodegraph, join with a second client. Spawn one of each and check
   model rendering, locomotion, attack playback, pursuit around corners and death on both clients.
2. Spawn six Tarakan nearby. Check that they pursue players without attacking each other, can reach a
   standing target, and sleep and wake under the normal COTZ population manager. Check server frame
   time against an equivalent group of existing small mutants in the same area.
3. Bait Karlito’s swing, dodge behind it, and try fighting it with a human NPC nearby. Verify the
   result and confirm that death creates a tracked corpse.
4. Have both players stand near a Radogeist during a pulse. Repeat with one player behind a solid
   wall and with radiation protection equipped. Verify that the pulse reaches visible targets in
   range and that COTZ handles radiation and protection. Use test characters, since COTZ saves radiation.
5. Repeat a windup with the target disconnecting or the mutant removed before impact. Check the
   server console for Lua errors.

The models were checked against the mounted files on disk. Model rendering, attack timing against
the visible animation and server frame time still need the multiplayer check above.

## Sources

- Comrade Communist’s [VJ S.T.A.L.K.E.R. Mutants pack](https://steamcommunity.com/sharedfiles/filedetails/?id=2099952978)
  was the Workshop reference. The COTZ content install has the models and corresponding VJ spawn
  icons. The original VJ Lua was unavailable, so these are COTZ-native behaviors for those assets.
- [S.T.A.L.K.E.R. Life of the Zone](https://www.moddb.com/mods/stalker-life-of-the-zone) inspired
  the Radogeist’s radiation. This version ties the radiation to a telegraphed attack.
