AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Makarov PM"

	SWEP.IconLetter = "f"
	killicon.AddFont("cw_deagle", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.FOVPerShot = 0.3

	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	--SWEP.FullAimViewmodelRecoil = true
	SWEP.CustomizationMenuScale = 0.01

end

SWEP.CanRestOnObjects = false

SWEP.Attachments = {["+reload"] = {header = "Ammo", offset = {-400, 330}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 0

SWEP.Slot = 2
SWEP.HoldType = "pistol"
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x18MM"

SWEP.FireDelay = 0.1
SWEP.Recoil = 1.5

SWEP.WearDamage = 0.14
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.013
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 47
SWEP.DeployTime = 1
--SWEP.Chamberable = false

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_pm.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/pm.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_pm_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.83, -1, 2.1115)
SWEP.IronsightAng = Vector(0, 0, 0)
SWEP.SprintPos = Vector(0, -1, 3.8)
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
			["sound"] = "TFA_ANOMALY.PM.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PM.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PM.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PM.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PM.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PM.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PM.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.3
SWEP.ReloadTime_Empty = 3.533333
SWEP.ReloadHalt = 3.3
SWEP.ReloadHalt_Empty = 3.533333
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_pm_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.3, 4.4817, -2.7009)
SWEP.WMAng = Vector(-7, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.PM.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.PM.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_pm")
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(0, 0, 1.348)
	SWEP.BoltBonePositionRecoverySpeed = 21
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
end

function SWEP:fireAnimFunc()
end
