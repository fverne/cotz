# Flashlight items

This plugin supplies the headlamp and handheld flashlight items. The handheld equips
`weapon_flashlight`, implemented in `lua/weapons/weapon_flashlight.lua`.
Both items share the equipment system's Light slot. Unequip one before equipping the other.

Both lights use the client projected-texture renderer in the standalone
`multiplayerflashlight.lua` plugin. Right-click toggles the handheld through its
server-owned `cotz/flashlight/active` weapon NWBool; it requires no headlamp.
Only the active, living player's handheld contributes light. Holstering, dropping,
and deploying clear its switch state. Headlamp power remains in the existing
`customFlashlight` player NWBool and takes precedence for the beam position when
both lights are on. Turning off or putting away the handheld preserves headlamp power.

Run `luatex --luaonly tests/flashlight_spec.lua` from the repository root for the
standalone state and renderer checks. In multiplayer, verify right-click toggling
without a headlamp, first- and third-person beam placement, visibility to another
player, switching weapons, dropping, death/respawn, and rejection of equipping either
light while the other occupies the Light slot. The standalone mocks do not establish rendering or replication correctness.
