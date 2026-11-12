# Cross-server data and presence

With `townnpcs` enabled, the approved workbook plan gates STALKERnet tools through Mute.
The current character always sees their own complete dossier and location. STALKERnet selects
them on opening or character switch, even when list filters hide their row. Global tools and
other characters retain the gates below.
The initial directory shows local identities. Search, squad filtering, ranking, basic activity,
location tracking, the remote directory and the full dossier unlock at MU01/03/07/11/15/19/23.
The server filters every roster snapshot for the receiving character, including remote membership,
reputation, activity and travel destinations. An entitlement change changes the filtered snapshot,
so the next refresh replaces stale data. The client applies the same policy to local entity records.
Local voice mute and ordinary squad functionality retain their existing access.
The descriptions below of unrestricted all-map browsing apply after the corresponding unlocks.

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

STALKERnet defaults to all active maps. The local-area toggle and remote roster identities are
available without progression; rank, activity, locations and other STALKERnet tools keep their separate gates. **Local area: ON** filters by the current map; a traveller stays
associated with its source map until the destination claims the character. Shared online/map and
travelling/destination labels match squads. Offline/expired sessions disappear from the scoreboard;
private squad rosters retain offline members. After 15 seconds without a successful refresh, cached
remote entries show **STATUS UNAVAILABLE**, and their unverified maps cannot pass the local-area filter.
Local characters continue to update directly from their real entities.
Connected local players without a loaded character appear under their Steam name as
**TRAVELLING**, until character selection completes. Temporary connection rows replace any
cached character for that account and disappear on disconnect or character load.

The public roster selects only visible, unexpired online/travelling sessions in the current schema.
The source server applies `ShouldShowPlayerOnScoreboard` to presence; the client also applies that hook
to local entities. Squad metadata comes from the squad plugin's `cotz/crossserver/roster-query` hook,
which receives a MySQL query object and adds structured projection and join calls. No private squad member list is broadcast.
Remote rows use saved character names/PDA portraits. Right-click offers the account's Steam profile
using its SteamID64 from the character owner column. Voice mute and entity-based actions remain
available on local rows. The roster includes this public account ID as a string; deploy the updated
reader and writer together on every map. No database migration is required.

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
for voice mute and plugin context actions, or any character for its Steam profile.
The dossier moves below the list on narrow panels.

Personal mutant and human NPC kills and successfully handed-in tasks are stored in character data
under `leaderboardStats`. These counters begin with this update; nearby task kill credit does not
increment personal kills. Town assignments count once through the existing guarded hand-in path.
No historical totals are inferred from bonus progress. Existing saves need no reset or SQL migration.
Same-map profiles use live server-side statistics and progression at each roster refresh, including
unsaved changes. The client retains those public counters when attaching local player entities;
Helix's private character data and progression are available only to their owning client.
Remote profiles read saved character reputation and statistics; they can lag until character save
and the next roster refresh. Only the public counters and reputation enter the roster payload.
Deploy the updated roster reader and writer together on all maps.

Presence labels use simplecrossserver's friendly map names for local and remote characters, without
an ON THIS SERVER label. STALKERnet and squads share green local, teal remote, amber travelling and
muted unavailable colors. Loner squad labels remain grey. Character dossiers show one location line
and include the persistent mutantsPoached statistic (completed poaches only; old saves start at zero).
