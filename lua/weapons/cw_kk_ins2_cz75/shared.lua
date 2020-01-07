if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "pistolMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "CZ-75A"
	SWEP.CSMuzzleFlashes = true
	SWEP.AimBreathingEnabled = true
	SWEP.Shell = "KK_INS2_9x19"
	SWEP.ShellDelay = 0.06
	SWEP.ShellWorldAngleAlign = {Forward = 0, Right = 0, Up = 180}
	SWEP.DrawAmmo = false

	SWEP.AttachmentModelsVM = {
		["kk_ins2_suppressor_pistol"] = {model = "models/weapons/upgrades/a_suppressor_pistol.mdl", pos = Vector(), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_m9.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_m9.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight_legacy"] = {model = "models/weapons/upgrades/a_flashlight_m9.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_m6x"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_m6x.mdl", bone = "Weapon", pos = Vector(0, 1.455, -1.25), angle = Angle(0, -90, 0), size = Vector(0.85, 0.85, 0.85)},

		["kk_ins2_m6x_rail"] = {model = "models/cw2/attachments/lowerpistolrail.mdl", bone = "Weapon", pos = Vector(0, 1.171, -0.594), angle = Angle(0, 90, 0), size = Vector(0.109, 0.109, 0.109),
			material = "models/weapons/attachments/cw_kk_ins2_cstm_m6x/rail_bk",
		},
	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_suppressor_pistol"] = {model = "models/weapons/upgrades/w_sil_pistol.mdl", pos = Vector(), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0.5,7.9,0), angle = Angle(0, 180, 90), size = Vector(1, 1, 1), attachment = "laser"},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0.5,7.9,0), angle = Angle(0, 180, 90), size = Vector(1, 1, 1), attachment = "laser"},
	}

	SWEP.IronsightPos = Vector(-1.5521, 0, 0)
	SWEP.IronsightAng = Vector(0.65, 0.00, 0)

	SWEP.CustomizationMenuScale = 0.01
	SWEP.ReloadViewBobEnabled = false
	SWEP.DisableSprintViewSimulation = true
end

SWEP.MuzzleEffect = "muzzleflash_m9_1p_core"
SWEP.MuzzleEffectWorld = "muzzleflash_m9_3rd"

SWEP.Attachments = {
	{header = "Lasers", offset = {500, -400}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_m6x"}},
	{header = "Barrel", offset = {-500, -400}, atts = {"kk_ins2_suppressor_pistol"}},
	{header = "Caliber", offset = {-800, 350}, atts = {"am_cal_9x18"}},
	{header = "Magazine", offset = {200, 0}, atts = {"fn_mag3"}},
	{header = "Upgrade 1-1", offset = {200, 0}, atts = {"fn_hndl1"}},
	{header = "Upgrade 1-2", offset = {100, 0}, atts = {"fn_acc1", "fn_rec1"}},
	{header = "Upgrade 1-3", offset = {200, 0}, atts = {"fn_rof1", "fn_stab1"}},
	{header = "Upgrade 2-1", offset = {200, 0}, atts = {"fn_acc2"}},
	{header = "Upgrade 2-2", offset = {200, 0}, atts = {"fn_hndl2", "fn_stab2"}},
	{header = "Upgrade 2-3", offset = {200, 0}, atts = {"fn_rec2", "fn_rof2"}},
	["+reload"] = {header = "Ammo", offset = {500, 150}, atts = {"am_zoneloaded", "am_matchgrade"}}
}

SWEP.Animations = {
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_draw_empty = "empty_draw",
	base_fire = {"base_fire","base_fire2","base_fire3"},
	base_fire_aim = {"iron_fire_1","iron_fire_2","iron_fire_3"},
	base_fire_last = "base_firelast",
	base_fire_last_aim = "iron_firelast",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reloadempty",
	base_idle = "base_idle",
	base_idle_empty = "empty_idle",
	base_holster = "base_holster",
	base_holster_empty = "empty_holster",
	base_sprint = "base_sprint",
	base_sprint_empty = "empty_sprint",
	base_safe = "base_down",
	base_safe_empty = "empty_down",
	base_safe_aim = "iron_down",
	base_safe_empty_aim = "empty_iron_down",
	base_crawl = "base_crawl",
	base_crawl_empty = "empty_crawl",
}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"auto","semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "Ethereal Pistols"

SWEP.Author			= "Lt. Taylor"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/ethereal/v_cz75.mdl"
SWEP.WorldModel		= "models/weapons/ethereal/w_cz75.mdl"

SWEP.WMPos = Vector(4.209, 1.323, -1.821)
SWEP.WMAng = Vector(-3, -5, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)

SWEP.Primary.ClipSize		= 16
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.KK_INS2_EmptyIdle = true
SWEP.CanRestOnObjects = false
SWEP.WeaponLength = 16

SWEP.FireSound = "CW_KK_INS2_P99_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_P99_FIRE_SUPPRESSED"
SWEP.Recoil = 0.97

SWEP.HipSpread = 0.054
SWEP.AimSpread = 0.021
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.17
SWEP.Shots = 1
SWEP.Damage = 12

SWEP.FireDelay = 60/1000
SWEP.FirstDeployTime = 1.3

SWEP.DeployTime = 0.4
SWEP.HolsterTime = 0.4

SWEP.MuzzleVelocity = 360

SWEP.ReloadTimes = {
	base_reload = {2, 2.65},
	base_reloadempty = {2, 2.65},
}