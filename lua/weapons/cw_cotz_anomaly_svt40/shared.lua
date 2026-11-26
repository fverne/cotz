if CustomizableWeaponry then

AddCSLuaFile()
AddCSLuaFile("weapons/cw_svt40/sh_sounds.lua")
include("weapons/cw_svt40/sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "SVT-40"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 0.7

	SWEP.IconLetter = "w"
	killicon.Add("cw_cotz_anomaly_svt40", "weaponicons/svt40-k", Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 1

	SWEP.CustomizationMenuScale = 0.024

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}

	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end

end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_pbs1"] = {
			model = "models/cw2/attachments/pbs1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.004907, -1.616497, -36.094175),
			angle = Angle(0.000203, 0, -89.999982),
			size = Vector(0.8, 0.8, 0.8),
		},
	}
end

SWEP.Attachments = {
	[2] = {header = "Muzzle", offset = {0, -200}, atts = {"md_pbs1"}},
	["+reload"] = {header = "Ammo", offset = {-300, 300}, atts = {"am_hollowpoint", "am_armorpiercing"}},
	}

SWEP.SpeedDec = 25

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "Anomaly Reskins"
SWEP.AdminOnly = true

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x54MMR"

SWEP.FireDelay = 0.08
SWEP.Recoil = 2.5

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 7
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.033
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 140
SWEP.DeployTime = 1.5

SWEP.DurabilityDamage = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.RecoilToSpread = 0.8 -- the M14 in particular will have 30% more recoil from continuous fire to give a feeling of "oh fuck I should stop firing 7.62x51MM in full auto at 750 RPM"

SWEP.SnapToIdlePostReload = false

end

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_svt.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/svt40.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_svt40_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.972, -3, 3.158)
SWEP.IronsightAng = Vector(0.1, 0, 0)
SWEP.SprintPos = Vector(7, -7.5, 0.1)
SWEP.SprintAng = Vector(-13, 49.5, -13)
SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_reload",
	["reload_empty"] = "anm_reload_empty",
	["anm_hide"] = "anm_hide",
	["anm_idle"] = "anm_idle",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_reload"] = "anm_reload",
	["anm_reload_empty"] = "anm_reload_empty",
	["anm_shots"] = "anm_shots",
	["anm_shots_aim"] = "anm_shots_aim",
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
}
SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVT.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVT.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVT.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVT.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVT.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 5.733333
SWEP.ReloadTime_Empty = 5.733333
SWEP.ReloadHalt = 5.733333
SWEP.ReloadHalt_Empty = 5.733333
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_svt40_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 4.118, -2.2675)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.SVT.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.SVT.FIRE"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_svt")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0.027, -0.082, 3.957)
	SWEP.BoltBonePositionRecoverySpeed = 60
end

function SWEP:fireAnimFunc()
end
