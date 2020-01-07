if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "brMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M14"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	SWEP.AimBreathingEnabled = true
	SWEP.Shell = "KK_INS2_762x51"
	SWEP.ShellDelay = 0.03
	SWEP.DrawAmmo = false

	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/ethereal/upgrades/a_m14_scope.mdl", pos = Vector(0,0.4,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), attachment = "Optic"},

		["kk_ins2_suppressor_sec"] = {model = "models/weapons/upgrades/a_suppressor_sec.mdl", pos = Vector(-2.4), angle = Angle(), size = Vector(1, 1, 1), attachment = "muzzle"},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_rail.mdl", pos = Vector(-9,0,-1), angle = Angle(), size = Vector(0.5, 0.5, 0.5), attachment = "muzzle"},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_rail.mdl", pos = Vector(-9,0,-1), angle = Angle(), size = Vector(0.5, 0.5, 0.5), attachment = "muzzle"},
		["kk_ins2_anpeq15"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_anpeq_rail.mdl", pos = Vector(-9,0,-1), angle = Angle(), size = Vector(0.5, 0.5, 0.5), attachment = "muzzle"},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x.mdl", rLight = true, pos = Vector(0,0.4,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), attachment = "Optic"},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0,0.4,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), attachment = "Optic"},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/a_optic_elcan_m.mdl", rLight = true, pos = Vector(0,0.4,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), attachment = "Optic", retSizeMult = 0.85},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/a_optic_eotech.mdl", pos = Vector(0,0.4,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), attachment = "Optic"},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra_l.mdl", pos = Vector(0,0.4,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), attachment = "Optic", retSizeMult = 1.2},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/a_optic_po4x24_m.mdl", rLight = true, pos = Vector(0,0.4,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), attachment = "Optic", retSizeMult = 0.85},
		["kk_ins2_scope_m40"] = {model = "models/weapons/upgrades/a_optic_m40_l.mdl", rLight = true, pos = Vector(0,0.4,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), attachment = "Optic"},

		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_cmore.mdl", pos = Vector(0,0.4,0.5), angle = Angle(180,0,90), size = Vector(1, 1, 1), attachment = "Optic"},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s.mdl", pos = Vector(0,0.4,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), attachment = "Optic"},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_microt1.mdl", pos = Vector(0,0.4,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), attachment = "Optic"},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_acog_m.mdl", rLight = true, pos = Vector(0,0.4,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), attachment = "Optic", retSizeMult = 0.85},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(0,0.4,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), attachment = "Optic"},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0,0.4,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), attachment = "Optic"},

	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/ethereal/upgrades/w_m14_scope.mdl", pos = Vector(-5,0.15,0), angle = Angle(0.5,0,-90), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_suppressor_sec"] = {model = "models/weapons/upgrades/w_sil_sec1.mdl", pos = Vector(-32,-0.25,6.9), angle = Angle(), size = Vector(1, 1, 1), attachment = "silencer"},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(-39.6,10.7,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(-50,10.7,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/w_elcan.mdl", pos = Vector(-58.4,10.5,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(-6.1,15.1), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/w_kobra.mdl", pos = Vector(-40,19,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/w_po.mdl", pos = Vector(-67.3,10.7,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_scope_m40"] = {model = "models/weapons/upgrades/w_scope_m40.mdl", pos = Vector(-10.2,2.8,0.75), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},

		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_cmore.mdl", pos = Vector(-39.8,18.95,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(-50,10.7,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(-50,10.7,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_acog.mdl", pos = Vector(-59.2,10.6,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(-6.1,15.1), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(-6,-0.4,34.5), angle = Angle(-90,0,-90), size = Vector(1, 1, 1), attachment = "optic"},

	}

	SWEP.IronsightPos = Vector(-1.51, -2, 0.7)
	SWEP.IronsightAng = Vector()

	SWEP.KKINS2KobraPos = Vector(-1.51, -2, -0.6561)
	SWEP.KKINS2KobraAng = Vector()

	SWEP.KKINS2EoTechPos = Vector(-1.51, -2, -0.5398)
	SWEP.KKINS2EoTechAng = Vector()

	SWEP.KKINS2AimpointPos = Vector(-1.51, -2, -0.5561)
	SWEP.KKINS2AimpointAng = Vector()

	SWEP.KKINS2ElcanPos = Vector(-1.51, -4, -0.7261)
	SWEP.KKINS2ElcanAng = Vector()

	SWEP.KKINS2PO4Pos = Vector(-1.46, -4.3, -0.311)
	SWEP.KKINS2PO4Ang = Vector()

	SWEP.KKINS2ScopeM40Pos = Vector(-1.52, -1.5, -0.6561)
	SWEP.KKINS2ScopeM40Ang = Vector()

	SWEP.KKINS2MagnifierPos = Vector(-1.51, -3, -0.5561)
	SWEP.KKINS2MagnifierAng = Vector()

	SWEP.KKINS2CSTMACOGPos = Vector(-1.51, -3.5, -0.6861)
	SWEP.KKINS2CSTMACOGAng = Vector()

	SWEP.KKINS2CSTMCMorePos = Vector(-1.51, -2, -0.5861)
	SWEP.KKINS2CSTMCMoreAng = Vector()

	SWEP.KKINS2CSTMBarskaPos = Vector(-1.51, -2, -0.5861)
	SWEP.KKINS2CSTMBarskaAng = Vector()

	SWEP.KKINS2CSTMMicroT1Pos = Vector(-1.51, -2, -0.5861)
	SWEP.KKINS2CSTMMicroT1Ang = Vector()

	SWEP.KKINS2CSTMEoTechXPSPos = Vector(-1.51, -2, -0.5861)
	SWEP.KKINS2CSTMEoTechXPSAng = Vector()

	SWEP.KKINS2CSTMCompM4SPos = Vector(-1.51, -2, -0.5861)
	SWEP.KKINS2CSTMCompM4SAng = Vector()
	
	SWEP.CustomizationMenuScale = 0.017
end

SWEP.StockBGs = {main = 0, foldable = 0, vss = 0}

SWEP.MuzzleEffect = "muzzleflash_m14_1p_core"
SWEP.MuzzleEffectWorld = "muzzleflash_m14_3rd"

SWEP.Attachments = {
	{header = "Sight", offset = {400, -500}, atts = {"kk_ins2_kobra", "kk_ins2_eotech", "kk_ins2_aimpoint", "kk_ins2_elcan", "kk_ins2_po4", "kk_ins2_scope_m40", "kk_ins2_cstm_cmore", "kk_ins2_cstm_barska", "kk_ins2_cstm_microt1", "kk_ins2_cstm_eotechxps", "kk_ins2_cstm_compm4s", "kk_ins2_cstm_acog"}},
	{header = "Barrel", offset = {-200, -500}, atts = {"kk_ins2_suppressor_sec"}},
	{header = "Lasers", offset = {125, 300}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	{header = "More Sight", offset = {1000, -50}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	{header = "Magazine", offset = {200, 0}, atts = {"fn_mag5"}},
	{header = "Upgrade 1-1", offset = {200, 0}, atts = {"fn_hndl1"}},
	{header = "Upgrade 1-2", offset = {100, 0}, atts = {"fn_acc1", "fn_rec1"}},
	{header = "Upgrade 1-3", offset = {200, 0}, atts = {"fn_rof1", "fn_stab1"}},
	{header = "Upgrade 2-1", offset = {200, 0}, atts = {"fn_acc2"}},
	{header = "Upgrade 2-2", offset = {200, 0}, atts = {"fn_hndl2", "fn_stab2"}},
	{header = "Upgrade 2-3", offset = {200, 0}, atts = {"fn_rec2", "fn_rof2"}},
	["+use"] = {header = "Sight Contract", offset = {400, -50}, atts = {"kk_ins2_sights_cstm"}},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_zoneloaded", "am_matchgrade"}}
}

SWEP.Animations = {
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_draw_empty = "base_draw_empty",
	base_fire = "base_fire",
	base_fire_aim = {"iron_fire_1","iron_fire_2","iron_fire_3","iron_fire_4"},
	base_fire_last = "base_fire_last",
	base_fire_last_aim = "iron_fire_last",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reloadempty",
	base_idle = "base_idle",
	-- base_idle = "deployed_idle",
	base_idle_empty = "base_idle_empty",
	base_holster = "base_holster",
	base_holster_empty = "base_holster_empty",
	base_firemode = "base_fireselect",
	base_firemode_empty = "base_fireselect_empty",
	base_firemode_aim = "iron_fireselect",
	base_firemode_empty_aim = "iron_fireselect_empty",
	base_sprint = "base_sprint",
	base_sprint_empty = "base_sprint_empty",
	base_safe = "base_down",
	base_safe_empty = "base_down_empty",
	base_safe_aim = "iron_down",
	base_safe_empty_aim = "iron_down_empty",
	base_crawl = "base_crawl",
	base_crawl_empty = "base_crawl_empty",
}

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "Ethereal Long Rifles"

SWEP.Author			= "Lt. Taylor"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/ethereal/v_m14_wood.mdl"
SWEP.WorldModel		= "models/weapons/ethereal/w_m14_wood.mdl"
-- SWEP.WorldModel		= "models/weapons/w_cw_kk_ins2_m14ebr.mdl"

SWEP.WMPos = Vector(5.072, 0.924, -0.537)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.FireDelay = 60/700
SWEP.FireSound = "CW_KK_INS2_M14WOOD_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_M14WOOD_FIRE_SUPPRESSED"
SWEP.Recoil = 2

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2.1
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.12
SWEP.Shots = 1
SWEP.Damage = 34

SWEP.FirstDeployTime = 1.5
SWEP.DeployTime = 0.7
SWEP.HolsterTime = 0.5

SWEP.SnapToIdlePostReload = false

SWEP.WeaponLength = 28

SWEP.KK_INS2_EmptyIdle = true

SWEP.MuzzleVelocity = 850

SWEP.ReloadTimes = {
	base_reload = {2.7, 3.4},
	base_reloadempty = {2.7, 5},

	foregrip_reload = {2.7, 3.4},
	foregrip_reloadempty = {2.7, 5},

	deployed_reload_half = {2.3, 3.2},
	deployed_reload_empty = {2.3, 4.5},
}