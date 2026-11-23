AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MP-153"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1

	SWEP.IconLetter = "k"

	SWEP.FireMoveMod = 1

	SWEP.CustomizationMenuScale = 0.022
	SWEP.ReticleInactivityPostFire = .8

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 1, pitch = .5}
end

SWEP.MuzzleVelocity = 350 -- in meter/s

SWEP.FullAimViewmodelRecoil = false

SWEP.Attachments = {--[1] = {header = "Sight", offset = {600, -250},  atts = {"md_microt1kh", "odec3d_cmore_kry", "md_fas2_eotech", "md_fas2_aimpoint", "md_schmidt_shortdot", "md_uecw_csgo_acog"}},
	["+reload"] = {header = "Ammo", offset = {-400, 50}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 7
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.4
SWEP.Recoil = 5.5

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.55
SWEP.ClumpSpread = 0.01
SWEP.SpreadPerShot = 0.012
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 9
SWEP.Damage = 40
SWEP.DeployTime = .5

SWEP.Chamberable = false

SWEP.WearDamage = 0.33
SWEP.WearEffect = 0.005

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_mp153.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/mp153.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_mp153_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.6225, -2, 2.8)
SWEP.IronsightAng = Vector(0.415, 0, 0)
SWEP.SprintPos = Vector(6.8, -9, 0)
SWEP.SprintAng = Vector(-13, 51, -13)
SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_open",
	["reload_start"] = "anm_open",
	["insert"] = "anm_add_cartridge",
	["reload_end"] = "anm_close",
	["anm_hide"] = "anm_hide",
	["anm_idle"] = "anm_idle",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_open"] = "anm_open",
	["anm_add_cartridge"] = "anm_add_cartridge",
	["anm_close"] = "anm_close",
	["anm_shots"] = "anm_shots",
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
}
SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP153.Holster",
		},
	},
	["anm_add_cartridge"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP153.ReloadInsert",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP153.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP153.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 0.5
SWEP.ReloadTime_Empty = 1
SWEP.ReloadHalt = 0.5
SWEP.ReloadHalt_Empty = 1
SWEP.ShotgunReload = true
SWEP.ReloadStartTime = 0.5
SWEP.InsertShellTime = 0.933333
SWEP.ReloadFinishWait = 0.6
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "shotshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_mp153_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.3864, -2.6424)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.MP153.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.MP153.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_mp153")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 3.977)
	SWEP.BoltBonePositionRecoverySpeed = 60
end

function SWEP:fireAnimFunc()
end
