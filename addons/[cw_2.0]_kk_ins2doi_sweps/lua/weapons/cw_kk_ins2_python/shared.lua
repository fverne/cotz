if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

CustomizableWeaponry:registerAmmo(".357", ".357 Rounds", 9.1, 33)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Colt Python"
	SWEP.CSMuzzleFlashes = true
	SWEP.AimBreathingEnabled = true
	SWEP.Shell = "KK_INS2_762x33"
	SWEP.NoShells = true
	SWEP.DrawAmmo = false
	SWEP.ShellScale = 2

	SWEP.AttachmentModelsVM = {
		["kk_ins2_revolver_mag"] = {model = "models/weapons/upgrades/a_speedloader_rev.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		-- ["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_band.mdl", bone = "Weapon", pos = Vector(0, 3.437, 1.531), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		-- ["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_band.mdl", bone = "Weapon", pos = Vector(0, 3.437, 1.531), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		-- ["kk_ins2_anpeq15"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_anpeq_band.mdl", bone = "Weapon", pos = Vector(0, 3.437, 1.531), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_mak.mdl", bone = "Weapon", pos = Vector(0, 2.602, -0.06), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_mak.mdl", bone = "Weapon", pos = Vector(0, 2.602, -0.06), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
	}

	SWEP.IronsightPos = Vector(-1.8544, 0, 1.0093)
	SWEP.IronsightAng = Vector(-1.7862, 0.1, 0)

	SWEP.CustomizationMenuScale = 0.01

	SWEP.SprintAnimSpeed = 1.1
	SWEP.ReloadViewBobEnabled = false
	SWEP.DisableSprintViewSimulation = true
	SWEP.HUD_MagText = "CYLINDER: "
end

SWEP.MuzzleEffect = "muzzleflash_m9_1p_core"
SWEP.MuzzleEffectWorld = "muzzleflash_m9_3rd"

SWEP.Attachments = {
	{header = "Lasers", offset = {-400, -400}, atts = {"kk_ins2_lam", "kk_ins2_flashlight"}},
	-- {header = "Barrel", offset = {-500, -400}, atts = {"kk_ins2_suppressor_pistol"}},
	{header = "Reload Aid", offset = {500, -400}, atts = {"kk_ins2_revolver_mag"}},
	{header = "Upgrade 1-1", offset = {200, 0}, atts = {"fn_hndl1"}},
	{header = "Upgrade 1-2", offset = {100, 0}, atts = {"fn_acc1", "fn_rec1"}},
	{header = "Upgrade 1-3", offset = {200, 0}, atts = {"fn_rof1", "fn_stab1"}},
	{header = "Upgrade 2-1", offset = {200, 0}, atts = {"fn_acc2"}},
	{header = "Upgrade 2-2", offset = {200, 0}, atts = {"fn_hndl2", "fn_stab2"}},
	{header = "Upgrade 2-3", offset = {200, 0}, atts = {"fn_rec2", "fn_rof2"}},
	["+reload"] = {header = "Ammo", offset = {500, 150}, atts = {"am_zoneloaded", "am_matchgrade"}}
}

SWEP.Animations = {
	base_reload_start = "base_reload_start",
	base_reload_start_empty = "base_reload_start",
	base_insert = "base_reload_insert",
	base_reload_end = "base_reload_end",
	base_reload_end_empty = "base_reload_end",
	base_idle = "base_reload_end",

	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = {"base_fire","base_fire2"},
	base_fire_aim = "iron_fire",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload_speed",
	base_reload_empty = "base_reload_speed",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_crawl = "base_crawl",
}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "Ethereal Pistols"

SWEP.Author			= "Lt. Taylor"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/ethereal/v_python.mdl"
SWEP.WorldModel		= "models/weapons/ethereal/w_python.mdl"

SWEP.WMPos = Vector(4.309, 1.323, -1.616)
SWEP.WMAng = Vector(-3, -5, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".357"

SWEP.FireDelay = 60/380
SWEP.FireSound = "CW_KK_INS2_PYTHON_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_REVOLVER_FIRE_SUPPRESSED"
SWEP.Recoil = 3.2

SWEP.HipSpread = 0.049
SWEP.AimSpread = 0.0015
SWEP.VelocitySensitivity = 1.35
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.25
SWEP.Shots = 1
SWEP.Damage = 32

SWEP.FirstDeployTime = 2.5
SWEP.DeployTime = 0.4
SWEP.HolsterTime = 0.5

SWEP.CanRestOnObjects = false
SWEP.Chamberable = false
SWEP.WeaponLength = 16

SWEP.MuzzleVelocity = 400

SWEP.ReloadTimes = {
	base_reload_start = {1.6, 2.36, KK_INS2_REVOLVER_SLOW_UNLOAD},
	base_reload_insert = {0, 0.98},
	base_reload_end = {1.74, 1.74},
	base_reload_speed = {3.6, 4.2, KK_INS2_REVOLVER_SPEED_UNLOAD, 54/33.5},
}

function SWEP:IndividualInitialize()
	self.magType = "NONE"
	self.ShotgunReload = true

	if CLIENT then
		self:setBodygroup(1, self:Clip1())
		self:setBodygroup(2, self:Clip1())
	end
end