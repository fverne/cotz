# Item hotkeys and moving actions

Settings → Hotkeys uses `sh_hotkeyitems.lua` to select the available F1–F4 items.
Items in that registry use moving timed actions by default, including when used from inventory.
The action bar and F cancellation remain; moving actions do not freeze the player or fade the screen.
Menus and overlapping item actions remain blocked until completion or cancellation. A world interaction
that starts stationary work cancels the moving action before starting its own timer. Death and character
changes cancel moving actions. Item charges retain their existing start-time consumption rules.

`sh_actionitems.lua` controls this independently of the hotkey assignments:

```lua
PLUGIN.useHotkeyActionDefaults = true
PLUGIN.mobileActionItems = {
	medic_medkit_1 = false,
	food_bread = true,
}
```

An explicit true/false entry overrides hotkey eligibility. Set `useHotkeyActionDefaults = false`
to use only this separate allowlist. Items absent from both retain black-screen actions.
Immediate item effects retain their existing timing.

Item-owned timed work calls `ix.util.PlayerPerformItemAction(client, item, text, seconds, callback)`.
Other callers can explicitly choose `PlayerPerformMobileAction` or `PlayerPerformBlackScreenAction`.
Stash tools also use this selection for searching and job digging; their completion-time location checks remain.

Run `luatex --luaonly tests/mobile_actions_spec.lua`, `tests/consumable_actions_spec.lua`,
`tests/bleeding_spec.lua`, `tests/equipment_slots_spec.lua` and `tests/field_tasks_spec.lua`.
In multiplayer, check F cancellation, movement, menus, repeated use, death/character switches,
target treatment, stash searches and both directions of the item overrides.
