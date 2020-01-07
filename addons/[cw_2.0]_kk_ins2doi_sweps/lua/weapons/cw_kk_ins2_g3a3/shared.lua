if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "brMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "G3A3"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	SWEP.AimBreathingEnabled = true
	SWEP.Shell = "KK_INS2_762x51"
	SWEP.DrawAmmo = false

	SWEP.BackupSights = {
		["kk_ins2_elcan"] = {
			Vector(-2.47, -2, -1.3036),
			Vector(-0.5, 0, 0)
		},
	}

	SWEP.AttachmentModelsVM = {
		--["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/a_standard_fal.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_modkit_05.mdl", bone = "A_Modkit", pos = Vector(0,-0.35,7), angle = Angle(89,90,0)},

		["kk_ins2_mag_fal_20"] = {model = "models/weapons/upgrades/a_magazine_fal_20.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, active = true},

		["kk_ins2_suppressor_ins"] = {model = "models/weapons/upgrades/a_suppressor_ins.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_bipod"] = {model = "models/weapons/upgrades/a_bipod_fal.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/a_foregrip_ins.mdl", pos = Vector(), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), attachment = "Foregrip"},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_band.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_band.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_anpeq15"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_anpeq_band.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x.mdl", rLight = true, bone = "A_Optic", pos = Vector(0,-.7,2), angle = Angle(90,90,0), size = Vector(1, 1, 1)},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", bone = "A_Optic", pos = Vector(0,-.8,2), angle = Angle(90,90,0), size = Vector(1, 1, 1)},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/a_optic_elcan_m.mdl", rLight = true, bone = "A_Optic", pos = Vector(0,-.8,2), angle = Angle(90,90,0), size = Vector(1, 1, 1), retSizeMult = 0.85},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/a_optic_eotech.mdl", bone = "A_Optic", pos = Vector(0,-.8,2), angle = Angle(90,90,0), size = Vector(1, 1, 1)},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra_l.mdl", bone = "A_Optic", pos = Vector(0,-.8,2), angle = Angle(90,90,0), size = Vector(1, 1, 1), retSizeMult = 1.2},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/a_optic_po4x24.mdl", rLight = true, bone = "A_Optic", pos = Vector(0,-.8,3), angle = Angle(90,90,0), size = Vector(1, 1, 1)},
		["kk_ins2_scope_mosin"] = {model = "models/weapons/upgrades/a_optic_mosin_l.mdl", rLight = true, bone = "A_Optic", pos = Vector(0,-.95,2), angle = Angle(90,90,0), size = Vector(1, 1, 1)},

		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_cmore.mdl", bone = "A_Optic", pos = Vector(0,-.8,2), angle = Angle(180,0,90), size = Vector(1, 1, 1)},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s.mdl", bone = "A_Optic", pos = Vector(0,-.8,2), angle = Angle(90,0,90), size = Vector(1, 1, 1)},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_microt1.mdl", bone = "A_Optic", pos = Vector(0,-.8,2), angle = Angle(90,0,90), size = Vector(1, 1, 1)},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_acog_m.mdl", rLight = true, bone = "A_Optic", pos = Vector(0,-.8,2), angle = Angle(90,0,90), size = Vector(1, 1, 1), retSizeMult = 0.85},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", bone = "A_Optic", pos = Vector(0,-.85,2), angle = Angle(90,0,90), size = Vector(1, 1, 1)},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl", bone = "A_Optic", pos = Vector(0,-.9,2), angle = Angle(90,0,90), size = Vector(1, 1, 1)},

	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/w_modkit_6.mdl", pos = Vector(-5.5,-0.2,0.06), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "modkit"},
		["kk_ins2_suppressor_ins"] = {model = "models/weapons/upgrades/w_sil_ins1.mdl", pos = Vector(-35,11.5,0), angle = Angle(0,0,90), size = Vector(1, 1, 1), attachment = "silencer"},

		["kk_ins2_bipod"] = {model = "models/weapons/upgrades/w_bipod_mosin.mdl", pos = Vector(-19,1.9,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "bipod"},
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/w_ins_foregrip.mdl", pos = Vector(-12,1.5,0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), attachment = "foregrip"},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(1,8.6,1), angle = Angle(180,0,-90), size = Vector(1, 1, 1), attachment = "laser"},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(1,8.6,1), angle = Angle(180,0,-90), size = Vector(1, 1, 1), attachment = "laser"},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(-32.5,10.75,0.06), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(-43,10.8,0.06), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/w_elcan.mdl", pos = Vector(-51,10.7,0.06), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0.75,15.3,0.06), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/w_kobra.mdl", pos = Vector(-33,19.05,0.06), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/w_po.mdl", pos = Vector(-59,10.8,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_scope_mosin"] = {model = "models/weapons/upgrades/w_scope_mosin.mdl", pos = Vector(-11,3.55,0.06), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},

		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_cmore.mdl", pos = Vector(-34,18.8,0.06), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(-43,10.8,0.06), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(-43,10.8,0.06), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_acog.mdl", pos = Vector(-51,10.6,0.03), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0.75,15.3,0.06), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "optic"},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(1,-0.35,34.5), angle = Angle(-90,-90,180), size = Vector(1, 1, 1), attachment = "optic"},
	}

	SWEP.IronsightPos = Vector(-2.065, -2, 0.2)
	SWEP.IronsightAng = Vector(1, 0, 0)

	SWEP.KKINS2KobraPos = Vector(-2.065, -2, -0.1)
	SWEP.KKINS2KobraAng = Vector()

	SWEP.KKINS2EoTechPos = Vector(-2.065, -2, 0)
	SWEP.KKINS2EoTechAng = Vector()

	SWEP.KKINS2AimpointPos = Vector(-2.065, -2, 0)
	SWEP.KKINS2AimpointAng = Vector()

	SWEP.KKINS2ElcanPos = Vector(-2.065, -4, -0.1)
	SWEP.KKINS2ElcanAng = Vector()

	SWEP.KKINS2PO4Pos = Vector(-1.99, -4, 0.1)
	SWEP.KKINS2PO4Ang = Vector()

	SWEP.KKINS2ScopeMosinPos = Vector(-2.035, -2, 0.22)
	SWEP.KKINS2ScopeMosinAng = Vector()

	SWEP.KKINS2MagnifierPos = Vector(-2.045, -2, -00.12)
	SWEP.KKINS2MagnifierAng = Vector()
	
	SWEP.KKINS2CSTMCMorePos = Vector(-2.065, -2, 0)
	SWEP.KKINS2CSTMCMoreAng = Vector()

	SWEP.KKINS2CSTMBarskaPos = Vector(-2.065, -2, 0)
	SWEP.KKINS2CSTMBarskaAng = Vector()

	SWEP.KKINS2CSTMMicroT1Pos = Vector(-2.065, -2, 0)
	SWEP.KKINS2CSTMMicroT1Ang = Vector()
	
	SWEP.KKINS2CSTMEoTechXPSPos = Vector(-2.065, -2, 0.1)
	SWEP.KKINS2CSTMEoTechXPSAng = Vector()

	SWEP.KKINS2CSTMCompM4SPos = Vector(-2.065, -2, 0)
	SWEP.KKINS2CSTMCompM4SAng = Vector()
	
	SWEP.KKINS2CSTMACOGPos = Vector(-2.065, -3, -0.1)
	SWEP.KKINS2CSTMACOGAng = Vector()

	SWEP.CustomizationMenuScale = 0.019
end

SWEP.MuzzleEffect = "muzzleflash_fal_1p_core"
SWEP.MuzzleEffectWorld = "muzzleflash_fal_3rd"

SWEP.Attachments = {
	{header = "Sight", offset = {650, -500}, atts = {"kk_ins2_kobra", "kk_ins2_eotech", "kk_ins2_aimpoint", "kk_ins2_elcan", "kk_ins2_po4", "kk_ins2_scope_mosin", "kk_ins2_cstm_cmore", "kk_ins2_cstm_barska", "kk_ins2_cstm_microt1", "kk_ins2_cstm_eotechxps", "kk_ins2_cstm_compm4s", "kk_ins2_cstm_acog"}},
	{header = "Barrel", offset = {-300, -500}, atts = {"kk_ins2_suppressor_ins"}},
	{header = "Under", offset = {-400, -25}, atts = {"kk_ins2_bipod", "kk_ins2_vertgrip"}},
	{header = "Lasers", offset = {250, -25}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	{header = "More Sight", offset = {1200, -25}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	{header = "Magazine", offset = {200, 0}, atts = {"fn_mag5"}},
	{header = "Upgrade 1-1", offset = {200, 0}, atts = {"fn_hndl1"}},
	{header = "Upgrade 1-2", offset = {100, 0}, atts = {"fn_acc1", "fn_rec1"}},
	{header = "Upgrade 1-3", offset = {200, 0}, atts = {"fn_rof1", "fn_stab1"}},
	{header = "Upgrade 2-1", offset = {200, 0}, atts = {"fn_acc2"}},
	{header = "Upgrade 2-2", offset = {200, 0}, atts = {"fn_hndl2", "fn_stab2"}},
	{header = "Upgrade 2-3", offset = {200, 0}, atts = {"fn_rec2", "fn_rof2"}},
	["+use"] = {header = "Sight Contract", offset = {200, -500}, atts = {"kk_ins2_sights_cstm"}},
	["+reload"] = {header = "Ammo", offset = {1000, 500}, atts = {"am_zoneloaded", "am_matchgrade"}}
}

SWEP.Animations = {
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = {"iron_fire","iron_fire_a","iron_fire_b","iron_fire_c","iron_fire_d","iron_fire_e","iron_fire_f"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reloadempty",
	base_reload_mm = "base_reload_ext",
	base_reload_empty_mm = "base_reloadempty_ext",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_firemode = "base_fireselect",
	base_firemode_aim = "iron_fireselect",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_crawl = "base_crawl",

	foregrip_pickup = "foregrip_ready",
	foregrip_draw = "foregrip_draw",
	foregrip_fire = "foregrip_fire",
	foregrip_fire_aim = "foregrip_iron_fire",
	foregrip_fire_empty = "foregrip_dryfire",
	foregrip_fire_empty_aim = "foregrip_iron_dryfire_b",
	foregrip_reload = "foregrip_reload",
	foregrip_reload_empty = "foregrip_reloadempty",
	foregrip_reload_mm = "foregrip_reload_ext",
	foregrip_reload_empty_mm = "foregrip_reloadempty_ext",
	foregrip_idle = "blend_idle_foregrip",
	foregrip_holster = "foregrip_holster",
	foregrip_firemode = "foregrip_fireselect",
	foregrip_firemode_aim = "foregrip_iron_fireselect_b",
	foregrip_sprint = "foregrip_sprint",
	foregrip_safe = "foregrip_down",
	foregrip_safe_aim = "foregrip_iron_down",
	foregrip_crawl = "foregrip_crawl",

	bipod_in = "deployed_in",
	bipod_fire = "deployed_fire",
	bipod_fire_aim = "deployed_iron_fire",
	bipod_fire_empty = "deployed_dryfire",
	bipod_fire_empty_aim = "deployed_iron_dryfire",
	bipod_reload = "deployed_reload",
	bipod_reload_empty = "deployed_reloadempty",
	bipod_reload_mm = "deployed_reload_ext",
	bipod_reload_empty_mm = "deployed_reloadempty_ext",
	bipod_firemode = "deployed_fireselect",
	bipod_firemode_aim = "deployed_iron_fireselect",
	bipod_out = "deployed_out",
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
SWEP.ViewModel		= "models/weapons/ethereal/v_g3a3.mdl"
SWEP.WorldModel		= "models/weapons/ethereal/w_g3a3.mdl"

SWEP.WMPos = Vector(4.65, 0.916, -1.754)
SWEP.WMAng = Vector(-8, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenade.models.f1
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnife.models.gurkha

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.FireDelay = 60/550
SWEP.FireSound = "CW_KK_INS2_G3A3_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_G3A3_FIRE_SUPPRESSED"
SWEP.Recoil = 1.5

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.17
SWEP.Shots = 1
SWEP.Damage = 33

SWEP.DeployTime = 0.7
SWEP.HolsterTime = 0.5

SWEP.BipodDeployTime = 1.15
SWEP.BipodUndeployTime = 1.15

SWEP.FirstDeployTime = 1.8
SWEP.WeaponLength = 28

SWEP.MuzzleVelocity = 800

SWEP.ReloadTimes = {
	base_reload = {2.3, 3.4},
	base_reloadempty = {2.3, 4.3},
	base_reload_ext = {2.3, 3.4},
	base_reloadempty_ext = {2.3, 4.3},

	foregrip_reload = {2.3, 3.4},
	foregrip_reloadempty = {2.3, 4.3},
	foregrip_reload_ext = {2.3, 3.4},
	foregrip_reloadempty_ext = {2.3, 4.3},

	deployed_reload = {2.2, 3.27},
	deployed_reloadempty = {2.2, 4},
	deployed_reload_ext = {2.2, 3.27},
	deployed_reloadempty_ext = {2.2, 4},
}