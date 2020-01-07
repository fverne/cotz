if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Saiga-12"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	SWEP.AimBreathingEnabled = true
	SWEP.NoShells = false
	SWEP.Shell = "KK_INS2_12guage"
	SWEP.DrawAmmo = false

	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_modkit_05.mdl", pos = Vector(-0.02,-0.5,2.1), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Modkit"},
		
		["kk_ins2_mag_saiga_8"] = {model = "models/weapons/mags/a_saiga_mag.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_mag_saiga_20"] = {model = "models/weapons/mags/a_saiga_drum_mag.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_suppressor_shotgun"] = {model = "models/weapons/upgrades/a_suppressor_12ga.mdl", pos = Vector(-33.7,-2.35,1.85), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Muzzle_Supp"},
		["kk_ins2_flashhider_big_shotgun"] = {model = "models/weapons/upgrades/a_mb_saiga_big.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashhider_small_shotgun"] = {model = "models/weapons/upgrades/a_mb_saiga_small.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), active = true, merge = true},

		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/a_foregrip_sec2.mdl", pos = Vector(), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), attachment = "Foregrip"},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_sec_shotgun.mdl", pos = Vector(), angle = Angle(), size = Vector(0.5, 0.5, 0.5), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_sec_shotgun.mdl", pos = Vector(), angle = Angle(), size = Vector(0.5, 0.5, 0.5), merge = true},
		["kk_ins2_anpeq15"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_anpeq_shotgun.mdl", pos = Vector(), angle = Angle(), size = Vector(0.5, 0.5, 0.5), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x.mdl", pos = Vector(0,0.24,1), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0,0.24,1), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/a_optic_eotech.mdl", pos = Vector(0,0.25,1), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra_l.mdl", pos = Vector(0,0.24,1), angle = Angle(90,0,90), size = Vector(1, 1, 1), retSizeMult = 1.2, bone = "A_Optic"},

		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_cmore.mdl", pos = Vector(0,0.25,-0.1), angle = Angle(0,180,-90), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s.mdl", pos = Vector(0,0.24,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_microt1.mdl", pos = Vector(0,0.24,-0.3), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(0,0.24,0.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0,0.24,-1), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},
	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/w_modkit_4.mdl", pos = Vector(0,-0.4,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "modkit"},

		["kk_ins2_mag_saiga_8"] = {model = "models/weapons/mags/w_saiga_mag.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_mag_saiga_20"] = {model = "models/weapons/mags/w_saiga_drum.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_suppressor_shotgun"] = {model = "models/weapons/upgrades/w_sil_pistol.mdl", pos = Vector(-33.2,-0.1,9.25), angle = Angle(), size = Vector(1, 1, 1), bone = "ATTACH_Muzzle"},
		["kk_ins2_flashhider_big_shotgun"] = {model = "models/weapons/ethereal/upgrades/w_mb_saiga_big.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashhider_small_shotgun"] = {model = "models/weapons/ethereal/upgrades/w_mb_saiga_small.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), active = true, merge = true},

		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/w_foregrip_sec2.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(-32.8,10.5,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "modkit"},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(-43,10.5,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "modkit"},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,15,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "modkit"},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/w_kobra.mdl", pos = Vector(-33.5,18.85,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "modkit"},

		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_cmore.mdl", pos = Vector(-33.5,18.6,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "modkit"},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(-43,10.5,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "modkit"},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(-43,10.5,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "modkit"},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,15,0), angle = Angle(0,0,-90), size = Vector(1, 1, 1), attachment = "modkit"},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0.7,-0.55,34.45), angle = Angle(-90,0,-90), size = Vector(1, 1, 1), attachment = "modkit"},
	}

	SWEP.IronsightPos = Vector(-2.298, -2.5, 0.335)
	SWEP.IronsightAng = Vector(0.0713, -0.0056, 0)

	SWEP.KKINS2KobraPos = Vector(-2.305, -1, -0.785)
	SWEP.KKINS2KobraAng = Vector()

	SWEP.KKINS2EoTechPos = Vector(-2.305, -1, -0.665)
	SWEP.KKINS2EoTechAng = Vector()

	SWEP.KKINS2AimpointPos = Vector(-2.305, -1, -0.695)
	SWEP.KKINS2AimpointAng = Vector()

	SWEP.KKINS2MagnifierPos = Vector(-2.305, -1, -0.695)
	SWEP.KKINS2MagnifierAng = Vector()
	
	SWEP.KKINS2CSTMCMorePos = Vector(-2.305, -1, -0.695)
	SWEP.KKINS2CSTMCMoreAng = Vector()

	SWEP.KKINS2CSTMBarskaPos = Vector(-2.305, -1, -0.695)
	SWEP.KKINS2CSTMBarskaAng = Vector()

	SWEP.KKINS2CSTMMicroT1Pos = Vector(-2.305, -1, -0.695)
	SWEP.KKINS2CSTMMicroT1Ang = Vector()
	
	SWEP.KKINS2CSTMEoTechXPSPos = Vector(-2.305, -1, -0.695)
	SWEP.KKINS2CSTMEoTechXPSAng = Vector()

	SWEP.KKINS2CSTMCompM4SPos = Vector(-2.305, -1, -0.695)
	SWEP.KKINS2CSTMCompM4SAng = Vector()

	SWEP.CustomizationMenuScale = 0.015
end

SWEP.MuzzleEffect = "muzzleflash_m590_1p_core"
SWEP.MuzzleEffectWorld = "muzzleflash_m590_3rd"


SWEP.Attachments = {
	{header = "Sight", offset = {400, -450}, atts = {"kk_ins2_kobra", "kk_ins2_eotech", "kk_ins2_aimpoint", "kk_ins2_cstm_cmore", "kk_ins2_cstm_barska", "kk_ins2_cstm_microt1", "kk_ins2_cstm_eotechxps", "kk_ins2_cstm_compm4s"}},
	{header = "Barrel", offset = {-200, -450}, atts = {"kk_ins2_suppressor_shotgun", "kk_ins2_flashhider_big_shotgun"}},
	{header = "Under", offset = {-400, 0}, atts = {"kk_ins2_vertgrip"}},
	{header = "Lasers", offset = {125, 400}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	{header = "More Sight", offset = {1000, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	{header = "Magazine", offset = {-150, 500}, atts = {"kk_ins2_mag_saiga_20"}},
	{header = "Upgrade 1-1", offset = {200, 0}, atts = {"fn_hndl1"}},
	{header = "Upgrade 1-2", offset = {100, 0}, atts = {"fn_acc1", "fn_rec1"}},
	{header = "Upgrade 1-3", offset = {200, 0}, atts = {"fn_rof1", "fn_stab1"}},
	{header = "Upgrade 2-1", offset = {200, 0}, atts = {"fn_acc2"}},
	{header = "Upgrade 2-2", offset = {200, 0}, atts = {"fn_hndl2", "fn_stab2"}},
	{header = "Upgrade 2-3", offset = {200, 0}, atts = {"fn_rec2", "fn_rof2"}},
	["+use"] = {header = "Sight Contract", offset = {400, 0}, atts = {"kk_ins2_sights_cstm"}},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_slugrounds", "am_birdshot", "am_trishot", "am_zoneloaded"}}
}

SWEP.Animations = {
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = {"iron_fire", "iron_fire_a", "iron_fire_b", "iron_fire_c", "iron_fire_d", "iron_fire_e", "iron_fire_f"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reloadempty",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_crawl = "base_crawl",

	foregrip_pickup = "foregrip_ready",
	foregrip_draw = "foregrip_draw",
	foregrip_fire = "foregrip_fire",
	foregrip_fire_aim = {"foregrip_iron_fire", "foregrip_iron_fire_2"},
	foregrip_fire_empty = "foregrip_dryfire",
	foregrip_fire_empty_aim = "foregrip_iron_dryfire_b",
	foregrip_reload = "foregrip_reload",
	foregrip_reload_empty = "foregrip_reloadempty",
	foregrip_idle = "foregrip_holster",
	foregrip_holster = "foregrip_holster",
	foregrip_sprint = "foregrip_sprint",
	foregrip_safe = "foregrip_down",
	foregrip_safe_aim = "foregrip_iron_down",
	foregrip_crawl = "foregrip_crawl",
}

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "Ethereal Shotguns"

SWEP.Author			= "Lt. Taylor"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/ethereal/v_saiga_12k.mdl"
SWEP.WorldModel		= "models/weapons/ethereal/w_saiga_12k.mdl"

SWEP.WMPos = Vector(4.063, 0.935, -0.945)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.2
SWEP.FireSound = "CW_KK_INS2_SPAS_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_M590_FIRE_SUPPRESSED"
SWEP.Recoil = 3

SWEP.Chamberable = true
SWEP.SnapToIdlePostReload = false
SWEP.ShotgunReload = false
SWEP.ReticleInactivityPostFire = SWEP.FireDelay + 0.3
SWEP.GlobalDelayOnShoot = SWEP.FireDelay

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.ClumpSpread = 0.023
SWEP.SpreadPerShot = 0.05
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 9
SWEP.Damage = 6.5

SWEP.FirstDeployTime = 2.2
SWEP.DeployTime = 0.7
SWEP.HolsterTime = 0.5

SWEP.WeaponLength = 18

SWEP.MuzzleVelocity = 260

if CLIENT then
	function SWEP:updateStandardParts()
		self:setElementActive("kk_ins2_mag_saiga_8", !self.ActiveAttachments.kk_ins2_mag_saiga_20)
		self:setElementActive("kk_ins2_flashhider_small_shotgun", !self.ActiveAttachments.kk_ins2_suppressor_shotgun and !self.ActiveAttachments.kk_ins2_flashhider_big_shotgun)
	end
end

SWEP.ReloadTimes = {
	base_reload = {2.2, 3.15},
	base_reloadempty = {2.2, 4.35},

	foregrip_reload = {2.2, 3.15},
	foregrip_reloadempty = {2.2, 4.35}
}