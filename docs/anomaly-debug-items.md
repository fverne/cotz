# Anomaly CW2.0 debug inventory items

The 160 `schema/items/newweapons/sh_debug_cw_anomaly_*.lua` definitions inherit COTZ's existing `base_newweapons` through the bundled Helix directory loader. They appear in **Debug - Anomaly CW2.0**, with `[DEBUG]` names and IDs such as `debug_cw_anomaly_ak103`.

Install the converted `cotz_anomaly_cw20` addon from the content workspace alongside COTZ and restart the server. These definitions do not install the SWEPs or their assets. Use the existing administrator item-spawning tools to obtain individual debug items.

Items use their matching SWEP world model and the existing primary, secondary, knife or grenade slot. Debug price and weight are explicitly zero; these are testing placeholders. Business-menu purchases, repairs and COTZ inventory attachment installation are disabled. Native SWEP customization remains available through CW controls. No vendor or loot pools were changed.

The normal weapon base handles equip, saved ammunition and condition. Firearms start empty; load compatible inventory ammunition. Throwable items use the base's grenade equip path. Test throwable consumption, reconnect restoration, weapon switching, reloads and customization in multiplayer before using these definitions beyond debugging.

All 160 definitions passed Lua syntax and class/model mapping checks. Garry's Mod equip, rendering and multiplayer behavior remain unverified. Remove or migrate saved debug instances before deleting these definitions later.

Only existing COTZ ammo types are used. The Kar98k, G43, RPG-7 and Gauss rifle have no equivalent ammunition and deliberately cannot load or fire. Their debug items remain available for inspecting models and equip behavior. The conversion uses `7.62x54MMR` for COTZ rifle ammunition.

## Viewmodel-recoil comparison items

147 further definitions, `sh_debug_cw_anomaly_<id>_vmrecoil.lua`, appear in **Debug - Anomaly CW2.0 VM recoil** with IDs such as `debug_cw_anomaly_ak74_vmrecoil`. Each one copies its source debug item (model, size, slot and zeroed debug values) and equips the matching `cw_anomaly_<id>_vmrecoil` SWEP. Those SWEPs use CW Lua viewmodel recoil and bolt/slide bone offsets instead of the source firing animation; see the content workspace's `packs/anomaly_cw20/README.md`. Melee weapons and throwables have no variants.

Original and variant share an equipment slot, so unequip one before equipping the other when comparing. These items need the variant SWEP files from the content workspace in the installed `cotz_anomaly_cw20` addon.
