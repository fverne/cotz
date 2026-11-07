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
