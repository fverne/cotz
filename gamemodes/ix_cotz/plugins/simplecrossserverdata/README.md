# Cross-server data and presence

The existing key/value API remains available. The shared presence service (`ix.crossserver`) also
owns character session claims, lease renewal, release and travel handoffs, SQL failure/timeout
handling, STALKERnet snapshots and the status labels used by both STALKERnet and squads.
`sh_plugin.lua` explicitly includes `sh_presence.lua` on both realms and `sv_presence.lua` on the server.

All maps must use the same schema name and MySQL database with mysqloo, and run this build with
`simplecrossserverdata` enabled. `crossServerPresence` defaults to true. SQLite is supported for local
development/tests, not for connecting independent server databases. Shared squads additionally require
`squadCrossServer`; see the [squad deployment guide](../squads/CROSS_MAP_PLAN.md).

The service retains `ix_squads_presence` and its original keys and columns so existing leases survive
an upgrade. Initialization uses `CREATE TABLE IF NOT EXISTS`; it neither resets presence nor changes
saved character or squad identities. Deploy all maps together. Presence works independently of squad
membership, including characters with no squad and deployments with the squads plugin disabled.

Sessions heartbeat every 15 seconds and expire after 45 seconds using database time. Character switches,
disconnects and shutdown release sessions. The five-second lifecycle poll also catches character-menu
kicks. `BeginTransfer(character, destination, callback)` publishes a bounded travelling session before
`simplecrossserver` redirects. Session tokens prevent an old server from overwriting the destination's
session after a handoff. All database work uses the bundled Helix third-party MySQL wrapper's query objects and `Execute`.
The service uses `OnError` and its own timeout guard to complete callbacks once. SQL generation,
escaping, adapter selection and execution remain inside the wrapper. See the
[wrapper extension guide](MYSQL_WRAPPER.md).

STALKERnet defaults to all active maps. **Local area: ON** filters by the current map; a traveller stays
associated with its source map until the destination claims the character. Shared online/map and
travelling/destination labels match squads. Offline/expired sessions disappear from the scoreboard;
private squad rosters retain offline members. After 15 seconds without a successful refresh, cached
remote entries show **STATUS UNAVAILABLE**, and their unverified maps cannot pass the local-area filter.
Local characters continue to update directly from their real entities.

The public roster selects only visible, unexpired online/travelling sessions in the current schema.
The source server applies `ShouldShowPlayerOnScoreboard` to presence; the client also applies that hook
to local entities. Squad metadata comes from the squad plugin's `cotz/crossserver/roster-query` hook,
which receives a MySQL query object and adds structured projection and join calls. No private squad member list is broadcast.
Remote rows use saved character names/PDA portraits and have no local voice, Steam profile or
entity-based actions. Local rows retain their existing actions and reputation display.

Snapshots are polled every five seconds, sent only when changed or needed by a newly loaded character,
and split into typed chunks of at most 32 records. Clients replace the roster atomically after the
last chunk; unchanged reads send only a freshness acknowledgement. Failed reads retain cached data.

Run from the repository root:

```sh
luatex --luaonly gamemodes/ix_cotz/plugins/simplecrossserverdata/tests/mysql_builder_spec.lua
luatex --luaonly tests/crossserver_presence_spec.lua
luatex --luaonly gamemodes/ix_cotz/plugins/simplecrossserverdata/tests/squads_crossserver_spec.lua
luatex --luaonly tests/squads_menu_scoreboard_spec.lua
luatex --luaonly tests/squads_characters_spec.lua
```

The specs cover chunked snapshot round trips, freshness, empty snapshots, shared labels, schema and
visibility filtering, lease expiry, authoritative squad grouping, remote rows, local filtering and
row cleanup. SQL checks require Python 3. Mocks/SQLite do not establish Garry's Mod or MySQL runtime
correctness. Verify two live servers: late joins, character switches, hidden players, loners, renames,
travel/failure/reconnect, database loss/recovery, expiry after a crash, both filter settings, local
voice actions and portrait/status layout at different resolutions.

## Character leaderboard

STALKERnet now lists active characters by descending reputation, with character ID breaking ties.
Filters retain the overall position. Select a row for its PDA dossier; right-click local characters
for voice mute and plugin context actions. The dossier moves below the list on narrow panels.

Personal mutant and human NPC kills and successfully handed-in tasks are stored in character data
under `leaderboardStats`. These counters begin with this update; nearby task kill credit does not
increment personal kills. Town assignments count once through the existing guarded hand-in path.
No historical totals are inferred from bonus progress. Existing saves need no reset or SQL migration.
Remote profiles read saved character reputation and statistics; they can lag until character save
and the next roster refresh. Only the public counters and reputation enter the roster payload.
Deploy the updated roster reader and writer together on all maps.
