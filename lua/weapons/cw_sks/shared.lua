AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "SKS"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "n"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 0.6

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}

	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_pbs1"] = {
			model = "models/cw2/attachments/pbs1.mdl",
			bone = "wpn_body",
			pos = Vector(0.00497, -0.811896, -36.709729),
			angle = Angle(0.001672, 0, -89.999982),
			size = Vector(0.8, 0.8, 0.8),
		},
	}
end

SWEP.Attachments = {
	[2] = {header = "Barrel", offset = {-450, -300},  atts = {"md_pbs1"}},
	["+reload"] = {header = "Ammo", offset = {-450, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x39MM"

SWEP.FireDelay = 0.08
SWEP.Recoil = 1.9

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.11
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.08
SWEP.SpreadPerShot = 0.03
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 82
SWEP.DeployTime = 0.6

SWEP.SnapToIdlePostReload = true

SWEP.Chamberable = false

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_sks.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/sks.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_sks_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.679, -3, 2.857)
SWEP.IronsightAng = Vector(-0.225, -0.03, 0)
SWEP.SprintPos = Vector(6, -6.9, 1)
SWEP.SprintAng = Vector(-13, 50, -10)
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
			["sound"] = "TFA_ANOMALY.SKS.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SKS.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SKS.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SKS.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SKS.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 4.266667
SWEP.ReloadTime_Empty = 4.266667
SWEP.ReloadHalt = 4.266667
SWEP.ReloadHalt_Empty = 4.266667
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = false
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_sks_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 4.1691, -3.9785)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.SKS.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.SKS.FIRE"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_sks")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0.004, 5.059)
	SWEP.BoltBonePositionRecoverySpeed = 76
end

function SWEP:fireAnimFunc()
end
