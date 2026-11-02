# Cross-map squads and character presence

Status: proposed follow-up. Character identity is implemented; cross-map presence and synchronization
are not implemented by this change.

## Existing foundations and limits

- Helix character IDs identify characters across maps when servers share the same character database
  and schema. `ix.char.loaded` also contains inactive cached characters; it is not an online directory.
  Only `client:GetCharacter()` establishes which character is active on a local player entity.
- Squads now key membership, leadership and moderation by character ID. Squad IDs remain stable opaque
  strings; new IDs are `char:<founder ID>`, while existing keys are retained.
- `simplecrossserver` owns map destinations and transfers. It writes `character:GetData("curmap")`
  before redirecting, saves the character, then kicks it from the current server. `curmap` is therefore
  a saved destination/location, not proof of a live session on that map.
- `simplecrossserverdata` supplies shared JSON storage, but its polling Think is commented out and
  its reader does not dispatch data to consumers. Its timestamp cursor has only second precision.
  It provides neither character leases nor protection against stale writers. Do not build presence
  by treating it as an already-working event bus.
- Current offline squad edits operate on shared character rows. A character active on another server
  can retain stale membership/rank in memory and overwrite those columns during a later Helix save.
  Cross-map moderation must not be advertised as reliable until the authority/synchronization phase
  below is deployed on every participating server.

## User-facing behavior

The squad roster always lists all member characters, including those with no local player entity.
Display their character name, rank, portrait, and presence:

| State | Meaning | Presentation |
| --- | --- | --- |
| Here | This server has the active character entity | Online · current map |
| Elsewhere | Another server holds a fresh character lease | Online · map display name |
| Transferring | A live session has begun an explicit handoff | Travelling to destination |
| Offline | A successful shared-state read confirms no live lease | Offline · last seen |
| Unknown | Shared-state queries fail or cached information is too old | Status unavailable |

The current UI only distinguishes **On this server** from **Not on this server**. The latter deliberately
includes both remote characters and offline characters until presence is implemented.

Keep Steam account online status out of this logic: an account can be connected while a different
character is active. Never mark all characters on an account online.

The STALKERnet scoreboard should retain local entity rows and existing hidden-player rules. Add a
separate, clearly labelled list for remote active characters if global scoreboard visibility is wanted.
Remote records need their own VGUI row; entity methods, local mute, local PM, tooltips and proximity
checks cannot be applied to a character on another server. Offline members belong in the squad roster,
not the online scoreboard. Publish only permitted remote identities, with hidden-player state carried
in the presence record and enforced server-side.

## Shared authority and storage

Use the shared MySQL database, scoped by schema and a configured cluster ID. Add a stable server ID
independent of map name and a fresh boot/session token per process; multiple servers may run one map.
Keep these facilities in the squads plugin initially, with explicit integration points in the transfer
plugin. Do not rewrite the generic cross-server data plugin as part of this feature.

Proposed tables (names and migrations must be finalized before implementation):

- `ix_squads_members`: authoritative `(cluster, schema, character_id) -> squad_id, rank, revision`.
  The unique character key enforces one squad per character. Import existing character membership
  once; keep `squad_id`/`squad_officer` as compatibility mirrors, not independent sources of truth.
- `ix_squads_servers`: server ID, boot token, map, display name, heartbeat expiry.
- `ix_squads_presence`: unique character key, owning server/boot token, character session token,
  active squad ID, visibility, state, transfer destination, lease expiry, last seen.
- `ix_squads_events`: monotonic database event ID, squad ID, revision, event type and bounded payload.
  Events invalidate/update interested caches. They do not replace authoritative membership records.

Do not put `online = true` in long-lived character data. Presence is an expiring session claim, separate
from membership and saved map location. Use database time for expiry comparisons; do not compare
`CurTime()` between processes or assume their wall clocks agree.

## Presence lifecycle

1. After a character becomes active, atomically claim its presence row with a new character session
   token. Reject/conflict-resolve an existing fresh claim; do not silently allow two servers to own it.
2. Publish its map and visibility. Start with configurable 15-second heartbeats and a 45-second lease,
   batching active characters per server. Tune against measured database latency and desired UI delay.
3. On character switch/unload/disconnect, clear only the lease whose server, boot and session tokens
   still match. An old disconnect callback must not clear a newly acquired destination-server session.
4. On transfer, keep the source lease until save succeeds, mark travelling with a bounded timeout,
   then let the destination claim a new session. The old source may release only its own session.
   A failed connection eventually expires instead of leaving permanent online/travelling status.
5. A crashed process expires through leases. A querying server that loses database access reports
   Unknown from its own stale cache; it must not turn a query failure into a confirmed Offline result.
6. Check async results against character ID, owning session and current panel selection. A result for
   a previous character must never update the new character's roster or permissions.

Integrate through documented character lifecycle hooks where available, plus small explicit transfer
notifications around `RedirectPlayer` and `RedirectPlayerNoLoadZone`. Verify actual bundled hook timing,
including `Character:Kick()`, before choosing unload hooks. Do not rely solely on PlayerDisconnected,
since map transfer and switching can unload a character while the account remains connected.

## Membership changes across servers

Before allowing remote kicks, promotions, disbanding, or invitations:

- Mutate authoritative membership in a transaction, validating the actor's current character, rank,
  target membership, and expected revision. Increment revisions and append the invalidation event
  in the same transaction. Repeated request IDs must not apply twice.
- Refresh the target server's cached character mirrors before it can save old membership back.
  Apply membership events to loaded inactive characters too. Treat shared membership as authoritative
  on every load and never use a stale cache to grant permissions.
- For remote actors/targets, validate live session tokens against presence rather than trusting
  another client's claim that a character is online. Do not directly modify an entity on this server
  because it belongs to the same Steam account as the target character.
- Keep invitations character-bound and persist their squad/target/inviter IDs and expiry. Local
  proximity invitations can remain local; add an explicit remote invitation flow if desired.
- Key caches by squad ID plus revision, deduplicate outstanding reads, and make async completion
  verify that the squad still exists. Disband must revoke every membership, not just online members.

Poll events in bounded batches by increasing event ID, not `timestamp > lastSeen`. Retain a bounded
event history. A server whose cursor falls behind retention must reload its authoritative snapshots.
Recover safely after database failures and restart; never reset squads as recovery.

## Client synchronization and cost

Servers poll presence in batches for the squads with local subscribers, with only one outstanding query
per batch. Cache last-seen offline members; send clients typed changes only when visible fields change.
Bound roster sizes, request rates and payloads. Filter presence/visibility server-side. Do not send
entire account records, global character tables, connection addresses, or account activity to clients.

Use separate revisions for membership and presence so heartbeat renewal alone does not resend rosters
or rebuild the menu. A rename/portrait update should refresh identity independently of online status.
Local outlines and local entity interactions continue to use active local character IDs only.

## Delivery sequence and acceptance checks

1. **Storage and migration:** back up shared tables; rehearse legacy leader mapping and membership
   import on a copy. Deploy during maintenance with old server builds stopped. Preserve ambiguous
   records for explicit resolution; do not guess leaders or drop squads.
2. **Presence backend:** implement server/session leases, lifecycle integration and filtered readers.
   Test two servers, two characters on one account, switches, late joins, crashes, and database loss.
3. **Roster display:** add Here/Elsewhere/Transferring/Offline/Unknown and map names to the squad menu.
   Verify stale responses, identical names, hidden characters and screen-size changes.
4. **Cross-server mutations:** add revisions, transactional membership changes, event synchronization
   and recovery before enabling remote moderation. Test competing promotions, leave vs kick, disband
   during restore, full character saves, replayed requests and server restarts.
5. **Optional global scoreboard:** add remote rows and counts separately; verify hidden-player privacy
   and keep local voice/mute/profile/entity actions restricted to local rows.

No live database migration, presence service, cross-map polling, or remote scoreboard is introduced
by the character-ID conversion. A two-server multiplayer session is required to validate the follow-up.
