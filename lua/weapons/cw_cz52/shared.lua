AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "CZ 52"
	SWEP.CSMuzzleFlashes = true

	SWEP.IconLetter = "y"
	killicon.Add( "khr_cz52", "icons/killicons/khr_cz52", Color(255, 80, 0, 150))

	SWEP.EffectiveRange_Orig = 42.38 * 39.37
	SWEP.DamageFallOff_Orig = .44

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 1
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 1, pitch = 1.5}
	SWEP.CustomizationMenuScale = 0.014

end

SWEP.MuzzleVelocity = 480 -- in meter/s
SWEP.CanRestOnObjects = false

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			bone = "wpn_body",
			pos = Vector(-0.041133, -0.586961, -8.353555),
			angle = Angle(-0.420356, -0.521478, -89.449159),
			size = Vector(0.7, 0.7, 0.7),
		},
	}
end

SWEP.Attachments = {[3] = {header = "Suppressor", offset = {-150, -500}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {550, 150}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 0

SWEP.Slot = 2
SWEP.HoldType = "pistol"
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x25MM"

SWEP.FireDelay = 60/500
SWEP.Recoil = 1.6
SWEP.FOVPerShot = 0.25

SWEP.WearDamage = 0.14
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.16
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 38
SWEP.DeployTime = 1

SWEP.SnapToIdlePostReload = false

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_cz52.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/cz52.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_cz52_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-2.807, -3, 2.495)
SWEP.IronsightAng = Vector(0.5, 0.4, 0)
SWEP.SprintPos = Vector(0, -2, 3.5)
SWEP.SprintAng = Vector(-19, 3, -6)
SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_reload",
	["reload_empty"] = "anm_reload_empty",
	["fire_dry"] = "anm_shots_last",
	["anm_hide"] = "anm_hide",
	["anm_hide_empty"] = "anm_hide_empty",
	["anm_idle"] = "anm_idle",
	["anm_idle_empty"] = "anm_idle_empty",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_aim_empty"] = "anm_idle_aim_empty",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_empty"] = "anm_idle_sprint_empty",
	["anm_reload"] = "anm_reload",
	["anm_reload_empty"] = "anm_reload_empty",
	["anm_shots"] = "anm_shots",
	["anm_shots_last"] = "anm_shots_last",
	["anm_show"] = "anm_show",
	["anm_show_empty"] = "anm_show_empty",
	["anm_show_first"] = "anm_show_first",
}
SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.CZ52.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.CZ52.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.CZ52.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.CZ52.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.CZ52.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.CZ52.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.CZ52.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.233333
SWEP.ReloadTime_Empty = 2.833333
SWEP.ReloadHalt = 2.233333
SWEP.ReloadHalt_Empty = 2.833333
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_cz52_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.3, 4.4817, -2.7009)
SWEP.WMAng = Vector(-7, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.CZ52.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.CZ52.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_cz52")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 1.793)
	SWEP.BoltBonePositionRecoverySpeed = 27
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
end

function SWEP:fireAnimFunc()
end
