# Cross-server squads

Membership is implemented in `sv_crossserver.lua`; shared presence and query infrastructure now live
in `simplecrossserverdata/sv_presence.lua`. The original design proposed a global event log; this version
uses bounded subscription snapshots and conditional SQL mutations instead. A log and cursor-recovery
system are unnecessary for the current squad sizes and five-second update interval.

## Deployment and migration

All participating maps must share the same MySQL database and schema name. Use the existing mysqloo
adapter. SQLite supports standalone development and the regression suite, not multiple independent
server databases. No external service or new native module is required. Queries use the bundled
Helix third-party MySQL wrapper. The ix_cotz compatibility extension supports the joins, conditional
subqueries, database-time values, imports and composite keys needed here; the plugin does not build
SQL strings or execute queries through database adapters. See [the wrapper guide](../simplecrossserverdata/MYSQL_WRAPPER.md).

`squadCrossServer` and `crossServerPresence` default to enabled. Keep `simplecrossserverdata` enabled
on every participating server. Stop all maps, back up the database, deploy this build to every
server, then restart them together. Do not mix previous squad implementations with this version.
The first initialization creates four schema-scoped tables and imports existing assignments:

| Table | Authority |
| --- | --- |
| `ix_squads_state` | Squad identity, leader, color, message, revision and active/disbanded state |
| `ix_squads_members` | One squad and rank per character; removed memberships retain tombstones |
| `ix_squads_presence` | Expiring character session, map, transfer destination, visibility and live identity |
| `ix_squads_invites` | Character-specific invitation token, inviter and database expiry |

Imports use insert-if-missing and preserve existing primary keys. Unresolved legacy leader mappings
remain assigned and log a diagnostic; configure `ix.squad.legacyLeaders` and restart after resolving
an ambiguous record. No source rows are deleted. Repeating initialization does not resurrect removed
memberships or disbanded squads. New squad keys include a nonce so recreating a squad cannot reuse an
old group's identity. Tables are scoped by `Schema.folder`; unrelated schemas cannot share memberships.

After migration, `ix_characters.squad_id`, `ix_characters.squad_officer`, and `ix_squads_squads` are
legacy import sources, not current authority. Existing character accessor methods remain available.
The plugin sets the installed Helix `bSaveLoadInitialOnly` flag on the two persisted character variables,
then explicitly refreshes their live values from shared membership. The bundled `Character:Save` and
`RestoreVars` both skip those fields. This prevents a normal full save or an inactive cached character
from overwriting a remote kick/promotion. Other character data retains normal Helix persistence.

Do not hot-disable shared mode or roll back to an earlier squad build after migrating. Shared mode
stays locked on for the running process once initialization begins. A rollback requires a maintenance
export of current shared state to the old format, or restoring the complete pre-migration backup;
simply removing the four tables would discard current changes. Disabling the setting before the first
migration retains the original local implementation.

## Cache ownership and reads

`ix.char.loaded` remains the only local character-object cache. The backend uses Helix's
`ix.char.cache[SteamID64]` account index (or `client.ixCharList`) to find each connected player's
cached characters, including inactive alternatives. It updates those exact objects with the existing
accessors only when values change. Disconnected characters cached by Helix are refreshed when their
account reconnects; they are not polled forever. No remote account is restored with `ix.char.Restore`,
and no fabricated remote object is inserted into either Helix cache.

`ix.squad.list` caches only squads with local active members. Remote members use lightweight roster
records, not player entities. Membership reads are deduplicated, chunked at 128 character IDs, and
polled every five seconds. Squad reads are sequential and deduplicated, with snapshots evicted when
there are no local subscribers. In-flight invitation reads are deduplicated per character. Generation
checks discard snapshots overtaken by local mutations; state-revision checks reject mixed snapshots.

Roster payloads are sent only when visible data changes or a local character first needs a snapshot.
A small typed freshness message renews the client's confidence without rebuilding an unchanged roster.
Query failures do not empty caches or reset assignments. The query boundary uses the wrapper's
optional `OnError` callback plus a timeout guard, so failed reads release their pending state without
confusing failure with an empty result. Late results
cannot complete a timed-out request a second time.

## Presence and travel

A character holds a random session token. Heartbeats renew a database-time lease every 15 seconds;
leases expire after 45 seconds. A second server cannot claim a fresh session unless it is the named
destination of a travelling session. Old heartbeats, disconnects and transfer callbacks are conditional
on their original token, so they cannot clear or overwrite the destination's session. Lost ownership
is detected on heartbeat verification and unloads the obsolete character session.

Character switches and disconnects release their session through Helix hooks. A five-second lifecycle
check also catches character-menu kicks, which the bundled implementation does not report through the
disconnect hook. Shutdown attempts release; lease expiry remains the crash/restart fallback.

The two `simplecrossserver` redirect functions now wait for character save completion, then publish
the handoff before kicking and asking the client to connect. Database failure cancels that redirect
and restores the saved current-map location. Travelling sessions have bounded leases, so a failed
connection does not leave a character permanently online. Saved `curmap` remains a location/destination,
not proof that a character is online there.

The roster distinguishes local presence, remote Online/map, Travelling/destination, Offline, and
Status unavailable. A client with no fresh successful snapshot for 15 seconds reports remote status
as unavailable. Hidden players do not publish remote online state or map. Local voice/mute/private
message actions continue to require a real local active character entity. STALKERnet uses the shared
presence service to show all active online/travelling characters, including loners, across maps.
The Local area button filters by the presence map, including travellers still leaving that map.
Expired/offline characters are excluded from STALKERnet; they remain in private squad membership rosters.

## Mutations and invitations

Membership, rank changes, settings, leave and disband operate on canonical tables. Their conditional
SQL checks the actor's current database membership/permissions and the target's expected membership
or rank, rather than trusting cached UI permissions. Rank requests carry the desired rank so repeating
an old request cannot toggle someone back. Disbanding tombstones the state row; every server treats
that state as inactive even if it missed the original request. Full character saves cannot undo it.

Nearby invitations keep their existing proximity requirement, but are persisted in shared storage.
They survive the inviter or recipient travelling before acceptance. Acceptance checks the stored token,
expiry, target character, inviter's current rank and active squad, and the target's current assignment
in the database. A successful join makes subsequent acceptance a no-op. The token is removed after the
attempt. Creating a new remote invitation from a global character directory is not introduced.

## Verification

Run the squad and shared presence specs from the repository root (Python 3 is needed by the SQL bridge):

```sh
luatex --luaonly gamemodes/ix_cotz/plugins/simplecrossserverdata/tests/mysql_builder_spec.lua
luatex --luaonly gamemodes/ix_cotz/plugins/simplecrossserverdata/tests/squads_crossserver_spec.lua
luatex --luaonly tests/squads_characters_spec.lua
luatex --luaonly tests/squads_menu_scoreboard_spec.lua
luatex --luaonly tests/crossserver_presence_spec.lua
```

The cross-server spec loads the actual bundled MySQL wrapper and runs its generated SQL against
a temporary SQLite database,
with two simulated server contexts. It covers migration, schema isolation, cache updates, lease claims,
transfer takeover, stale disconnects, remote moderation, shared invitations, settings, hidden presence,
expiry, restart tombstones, new group creation, failure/timeout completion, and the installed Helix save
implementation. The other suites exercise the retained local mode and client/menu behavior.

These checks do not validate MySQL locking under contention or actual Garry's Mod networking. Before
production deployment, use two multiplayer servers sharing a test database. Verify simultaneous
promotions/kicks/leaves, full character saves after remote changes, cross-map invitation acceptance,
normal travel and failed connections, database loss/recovery, process crashes, reconnects, character
switching and hidden-player privacy. Observe the five-second propagation and 45-second crash timeout.
No live database migration or world setup is run by the automated tests.
