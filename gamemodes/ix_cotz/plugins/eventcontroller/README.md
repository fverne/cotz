# Routine encounter location tags

`difficulty` remains the encounter field name, but its entries are now string location tags.
An event point stores `{position, name, locationTag}`. Matching and encounter quantities are unchanged.

| Map prefix | Map |
| --- | --- |
| `swamps` | `rp_marsh_cs` |
| `garbage` | `mz_garbage` |
| `waystation` | `rp_waystation` |
| `pripyat` | `rp_pripyat_remaster` |

Append one of `_outside_easy`, `_outside_hard`, `_building`, `_sniperspot`, or `_underground`.
For example, `difficulty = {"swamps_outside_hard", "waystation_building"}`.
Outside easy/hard retain the previous nearby/distant wilderness assignments.

Use `/eventadd "Area name" swamps_outside_easy` to add a point at your crosshair.
FTS presets and exports use the same strings. The separate `eventcontrolleradv` plugin is unchanged.

Existing saved numeric event-point codes (11–15, 21–25, 31–35) are converted on load and written
as strings on the next normal save. Positions, names, and unknown/custom codes are preserved.
Do not rerun first-time setup to migrate an existing world.

Run the tag/migration/export regression checks from the repository root:

```sh
luatex --luaonly gamemodes/ix_cotz/plugins/eventcontroller/tests/location_tags_spec.lua
luatex --luaonly tests/population_performance_spec.lua
```
