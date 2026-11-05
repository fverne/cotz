# Squads

Squad creation and management live in the **SQUADS** section of the Tab menu, alongside YOU and
TASKS. Players without a squad see a creation button; members see the embedded management panel.
The plugin no longer handles `gm_showspare2` (normally F4).

The STALKERnet scoreboard shows active characters across all connected maps by default, grouped by
squad name. **Local area** toggles a current-map filter. Players without a squad appear under
**loners**. Empty groups disappear, and existing scoreboard visibility rules still apply.
Grouping uses stable squad IDs, so squads with identical names remain separate groups. The
`simplecrossserverdata` plugin owns presence leases, travel handoffs, roster networking and shared
status labels; squads supply authoritative public grouping metadata. See its [README](../simplecrossserverdata/README.md).

## Loading and state

Helix loads `languages/` and `derma/` automatically. `sh_plugin.lua` explicitly includes the squad
metatable and server entry point; the server entry point includes its hooks.

Cross-server membership and presence are enabled by default. See the
[cross-server deployment and architecture guide](CROSS_MAP_PLAN.md) before deploying to shared maps.
Every map must use the same database and schema and run this build. Shared storage imports existing
squads without resetting them; ambiguous legacy leaders still require an explicit character mapping.

The backend reuses Helix's account/character caches for connected players, including their inactive
characters. Remote members remain lightweight roster records. Shared membership is authoritative;
normal Helix character saves cannot overwrite a remote kick, promotion, or disband. The menu displays
online map, travelling destination, offline and unavailable states for remote members. Updates normally
propagate within five seconds; crashed sessions expire after 45 seconds. Nearby invitations persist
across travel and remain available through **Accept invite**.

`squadID` is now public character metadata. The new public `squadName` variable is display-only,
with no database column; synchronization derives it from the authoritative squad record. It updates
on restore, creation, joining and renaming, and clears when online membership is removed. Full squad
records continue to use the existing member synchronization messages.

Membership, leadership, invitations and moderation use Helix character IDs. The roster uses saved
character names and PDA portraits, including when those characters have no local player entity.
It does not use account names, Steam avatars or profile links. Local private messages resolve the
currently active target character.

The menu follows the equipment and Tasks UI: translucent dark cards, olive borders, muted labels,
`alsina` typography, and green/teal accents. The summary shows squad identity and the number of
members on this server. Personnel appear in rank-ordered character cards; select or right-click a
card for the existing member actions. Remote status becomes unavailable if shared reads stop succeeding.

Leaders edit the name, message and color inline, then use **Save changes**. Closing the menu
also submits pending edits. Settings are coalesced around the server cooldown and delayed submissions
are discarded if the active character or squad changes. The creation view includes an inline name
field. Wide menus show separate scrolling details and personnel columns; narrow menus stack them.
Fonts and control heights refresh when resolution changes.

## Verification

Run from the repository root:

```sh
luatex --luaonly tests/squads_menu_scoreboard_spec.lua
luatex --luaonly tests/squads_characters_spec.lua
luatex --luaonly gamemodes/ix_cotz/plugins/simplecrossserverdata/tests/squads_crossserver_spec.lua
luatex --luaonly tests/crossserver_presence_spec.lua
```

The standalone spec checks Tab registration, menu state transitions, public metadata updates,
squad grouping, renames, membership changes, hidden players, and empty-group removal using mocks.
The character spec covers account alternates, character-scoped persistence, permissions, invitations,
legacy leadership, offline edits and disbanding. UI checks additionally cover wide/narrow pane
bounds, inline editing, draft preservation across roster updates, and queued settings after closing.
It does not establish Garry's Mod runtime correctness.

In a multiplayer development session, verify creation and management through Tab, F4 behavior,
join/leave/kick/disband, name edits, reconnects, late joiners, character switching, hidden players,
and layout at different resolutions. Verify names are visible to players outside the squad.

Squad personnel use the same character PDA avatar as the scoreboard, including saved avatars for
unloaded members. Scoreboard squad headings use the public squad color; loners retain the default
grey theme. Squads cannot select Imgur logos; legacy logo columns remain unused for save compatibility.

PDA portraits use the scoreboard's 96:64 aspect ratio. The squad header has no icon.
Invitations appear in the SQUADS creation view with an **Accept invite** button and disappear
on expiry or character change. Acceptance uses a rate-limited server request with the same
character, membership, inviter and expiry checks; the `/saccept` command is removed.

## Compass and presence

Equip a compass and join a squad to see local squadmates' names and distances below their bearings.
Dead squadmates follow the revive ragdoll until respawn; their marker says DEAD. Squad visibility
keeps those local entities updated outside the ordinary viewing area. Other-map members appear in
the roster, without a local compass bearing. Online status is green on this map, teal on another map,
amber while travelling, and muted when unavailable/offline, matching STALKERnet. Status labels use
simplecrossserver's map names, for example ONLINE: SWAMPS. Invitations notify both sender and recipient;
shared invitation receipts are sent only after the stored invitation is confirmed.

## Hideout ownership

The hideouts plugin owns squad interiors, shared entrances, contextual officer building privileges,
vendor stock and treasury. See its [runtime guide](../hideouts/README.md). The squad refresh also
retains provisioned local hideout owners when every member is offline, with a freshness timestamp
for hideout authorization. Disbanded squads lose access while their assets remain recoverable.

Leaders/officers use **Tab → Squads → Squad hideout** to place or relocate their hideout entrance
without chat commands. Entrance, interior exit and vendor menus provide the local management actions;
container installation and sharing belong to the individual container's owner menu.
