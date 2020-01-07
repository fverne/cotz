CustomizableWeaponry_KK.ins2.conVars = CustomizableWeaponry_KK.ins2.conVars or {}
CustomizableWeaponry_KK.ins2.conVars.main = CustomizableWeaponry_KK.ins2.conVars.main or {}
CustomizableWeaponry_KK.ins2.conVars.other = CustomizableWeaponry_KK.ins2.conVars.other or {}

if CLIENT then
	local tab = CustomizableWeaponry_KK.ins2.conVars.main
	tab["cw_kk_ins2_rig"] = CreateClientConVar("cw_kk_ins2_rig", 1, true, true)
	tab["cw_kk_ins2_rigskin"] = CreateClientConVar("cw_kk_ins2_rigskin", 0, true, true)
	tab["cw_kk_ins2_shell_sound"] = CreateClientConVar("cw_kk_ins2_shell_sound", 3, true, false)
	tab["cw_kk_ins2_shell_time"] = CreateClientConVar("cw_kk_ins2_shell_time", 30, true, false)
	tab["cw_kk_ins2_shell_vm"] = CreateClientConVar("cw_kk_ins2_shell_vm", 1, true, false)
	tab["cw_kk_ins2_animate_reticle"] = CreateClientConVar("cw_kk_ins2_animate_reticle", 1, true, false)
	tab["cw_kk_ins2_ins_nade_ctrls"] = CreateClientConVar("cw_kk_ins2_ins_nade_ctrls", 1, true, true)
	tab["cw_kk_ins2_scopelightingfix"] = CreateClientConVar("cw_kk_ins2_scopelightingfix", 1, true, false)
	tab["cw_kk_ins2_sprint"] = CreateClientConVar("cw_kk_ins2_sprint", 1, true, false)
	tab["cw_kk_ins2_draw_vm_in_rt"] = CreateClientConVar("cw_kk_ins2_draw_vm_in_rt", 0, true, false)

	local tab = CustomizableWeaponry_KK.ins2.conVars.other
	tab["cw_kk_freeze_reticles"] = CreateClientConVar("cw_kk_freeze_reticles", 0, false, false)
end