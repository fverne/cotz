# Character storage

COTZ registers `progression`, `vendorStock`, `vendorRestockClaims` and `jobs` as separate
persistent Helix character vars. Their SQL columns use `MEDIUMTEXT`, with a maximum size of
16,777,215 bytes instead of `TEXT`'s 65,535 bytes ([MySQL limits](https://dev.mysql.com/doc/refman/8.4/en/storage-requirements.html)).
The type mapping lives in COTZ's `schema/sv_schema.lua`; it extends the installed database
type registry with the named `cotzMediumText` type before plugins register their vars.
The bundled registry accepts named keys, and SQLite gives `MEDIUMTEXT` text affinity.
There are no changes inside the Helix folder.

Progression retains owner-only replication through the progression library's validated snapshot API.
Vendor stock and restock claims use `bNoNetworking`; vendor menus receive separate stock messages.
Jobs retain their existing visibility and `GetJobs`/`SetJobs` API. Shared world unlocks stay in plugin data.
STALKERnet reads the separate progression var/column for favourite-contact statistics.

This storage change targets a fresh database, as requested for the planned database reset.
Helix creates the four columns at startup. No legacy migration or fallback is included.
Changing a registered type does not enlarge existing columns; deploying these files alone does
not convert an existing save. The generic `data` column and unrelated keys retain their type.

Run `luatex --luaonly tests/character_storage_spec.lua` for installed registration/save API checks
with mocked engine/database boundaries. Gameplay regression commands remain in the progression
and vendor plugin READMEs. Live multiplayer verification still needs selection, hand-ins, private
stock, saving, hideout entry, reconnect and cross-map transfer on the server.

The survival, stamina and psy health plugins restore player variables synchronously in
`PlayerLoadedCharacter`. Their save hooks copy player variables only for the active character after
that plugin has restored its values. Earlier load-time saves, including fresh town NPC initialization,
retain the character's saved values and defaults. Missing player variables also fall back to character
state; actual zero values remain valid. This prevents first-login saves from persisting uninitialized
zeroes or a previous character's stats. Delayed survival/psy state updates check that the player is
still valid and using the same character.

Run `luatex --luaonly tests/character_vitals_spec.lua` for first-login save ordering, character switches,
missing values, genuine zeroes and disconnect checks. In multiplayer, verify fresh character creation,
switching, reconnecting and saving during loading. Already persisted zeroes are not automatically
reset: an administrator can use `/CharResetValues` while playing the affected character to restore
its stats. That command also restores health and clears radiation and drunkenness; no further wipe
is needed.
