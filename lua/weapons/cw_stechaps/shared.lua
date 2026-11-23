AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Stechkin APS"
	SWEP.CSMuzzleFlashes = true
	killicon.Add("cw_stechaps", "VGUI/hud/ma85_wf_pt10", Color(255, 255, 255, 255))

	SWEP.DryFire = true

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8

	SWEP.CustomizationMenuScale = 0.01

end
SWEP.CanRestOnObjects = false

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			bone = "wpn_body",
			pos = Vector(0.000098, -0.547721, -8.522987),
			angle = Angle(0.002769, 0, -89.999982),
			size = Vector(0.7, 0.7, 0.7),
		},
	}
end

SWEP.Attachments = {
[1] = {header = "Muzzle", offset = {0, 150}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {-400, 330}, atts = {"am_hollowpoint", "am_armorpiercing"}}
}

SWEP.DryFire = true
SWEP.SpeedDec = 0

SWEP.Slot = 2
SWEP.HoldType = "pistol"
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"
SWEP.SuppressedOnEquip = false

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x18MM"

SWEP.FireDelay = 0.0923076923
SWEP.Recoil = 1.45

SWEP.WearDamage = 0.14
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.02
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.006
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 47
SWEP.DeployTime = 1
SWEP.Chamberable = false

SWEP.SnapToIdlePostReload = false

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_aps.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/aps.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_aps.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.83, -1, 1.54)
SWEP.IronsightAng = Vector(0.45, -0.01, 0)
SWEP.SprintPos = Vector(0, -1, 3.5)
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
			["sound"] = "TFA_ANOMALY.APS.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.APS.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.APS.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.APS.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.APS.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.APS.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.APS.Draw",
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
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_aps.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.5, 3.7481, 2.6835)
SWEP.WMAng = Vector(-7, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.APS.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.APS.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_aps")
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(0, 0, 1.348)
	SWEP.BoltBonePositionRecoverySpeed = 21
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
end

function SWEP:fireAnimFunc()
end
