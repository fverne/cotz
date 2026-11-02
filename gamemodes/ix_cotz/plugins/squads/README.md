# Squads

Squad creation and management live in the **SQUADS** section of the Tab menu, alongside YOU and
TASKS. Players without a squad see a creation button; members see the embedded management panel.
The plugin no longer handles `gm_showspare2` (normally F4).

The STALKERnet scoreboard groups online players by squad name. Players without a squad appear
under **loners**. Empty groups disappear, and existing scoreboard visibility rules still apply.
Grouping uses stable squad IDs, so squads with identical names remain separate groups.

## Loading and state

Helix loads `languages/` and `derma/` automatically. `sh_plugin.lua` explicitly includes the squad
metatable and server entry point; the server entry point includes its hooks.

Squad definitions use `ix_squads_squads`. Membership and officer state use the existing character
columns `squad_id` and `squad_officer`. Changing the table name in code does not migrate an existing
`gmodz_squads` database table.

New squad keys are `char:<founder character ID>`. The existing `owner` column remains the primary
key for compatibility; it is an opaque squad identifier. Runtime `leaderID` and `members` keys are
character IDs. Existing keys and character assignments are retained without a destructive migration.
Legacy records resolve leadership only when exactly one member character belongs to the original
owner account. For ambiguous records, configure `ix.squad.legacyLeaders["<existing squad key>"] = <character ID>`
in `sh_plugin.lua` after that table is initialized, then restart. The mapped character must already be
a member. Unresolved records log an error and retain saved assignments; they are not silently reset.
Do not mix the old account-based server build with this build against the same shared database.

Offline edits now scope SQL to the exact character ID and schema. Disband also clears unloaded
members. This fixes account-wide updates; reliable concurrent cross-map moderation remains future work.
See [cross-map presence and synchronization plan](CROSS_MAP_PLAN.md).

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
card for the existing member actions. "Not on this server" does not imply a character is offline.

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
