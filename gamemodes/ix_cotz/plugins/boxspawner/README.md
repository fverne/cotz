# Breakable box loot

Metal, wooden and paper boxes share `PLUGIN:SpawnBoxLoot` in `sh_plugin.lua`.
The entity captures the owning plugin during Helix loading. The helper snapshots the box's
position and world bounds before removal, then uses the spawned item's final world bounds
to raise its bottom above the box top with a small clearance. This accounts for large models,
random rotation, custom instance models and fallback item collision bounds. Placement runs
in the Helix spawn callback before the next physics step and does not access the removed box.

Loot pools, roll counts/chances, instance data and temporary-item flags are unchanged.
No save migration or world setup is required.

Run `luatex --luaonly tests/box_loot_placement_spec.lua` from the repository root.
The standalone test covers all three entities, delayed creation after box removal, large and
small bounds, custom pools/data, temporary flags and repeated damage.

Multiplayer checks: break each box type on a floor and a slope with both small and large
loot models; confirm loot settles above the map and can be picked up. Also check rotated
boxes, nearby walls, low ceilings, multiple simultaneous drops and custom-model loot.
The bounds correction prevents initial floor intersection; it does not search for space
around walls or ceilings. Standalone mocks do not verify Source physics or model assets.
