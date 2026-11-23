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

## Firearms staged for administrator testing

The 82 regular items named `anomaly_<id>` cover the installed pack's firearm and launcher variants
without a regular CotZ counterpart. They equip the pack's VM-recoil SWEPs and use its world models and
inventory cameras. Earlier CotZ counterparts, melee weapons, throwables and debug IDs are unchanged.
The new items have provisional inventory prices and weights and are available through administrator
item spawning. Business purchases are disabled and the items have no loot, vendor, reward or
progression entries.

Spawn matching `anomaly_attachment_<id>` items and use the inventory **Install** and **Detach**
actions. The 31 hardware definitions use the pack's own sight alignments, mounts and suppressor
effects. Firearms with fixed optics or without compatible hardware retain their pack configuration.
Installed hardware is saved with the weapon. CW cycling and presets stay disabled on the regular
inventory variants so attachment changes follow the inventory actions. Debug weapons keep their
native CW customization options.

The Kar98k, G43, RPG-7 and Gauss rifle still have their pack ammunition disabled. The M79, RG-6
and underbarrel launchers have no CotZ inventory ammunition supply in this rollout. The pack's
ammunition and cosmetic customization entries do not have inventory attachment items.

Run `tests/run.sh anomaly_inventory` for the item and attachment checks. In multiplayer, spawn
`anomaly_ak74m` and `anomaly_attachment_kobra`, then check install, aim, detach and restoration after
unequipping and reconnecting. Check the installed hardware from a second client and repeat with a
rail optic and suppressor.
