AddCSLuaFile()
AddCSLuaFile("weapons/cw_g36c/sh_sounds.lua")
include("weapons/cw_g36c/sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "H&K G36C"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	SWEP.CustomizationMenuScale = 0.012

	SWEP.IconLetter = "i"
	killicon.AddFont("cw_cotz_anomaly_g36c", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 0.6

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 1, pitch = 1}

end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_saker"] = {
			model = "models/cw2/attachments/556suppressor.mdl",
			bone = "wpn_body",
			pos = Vector(0.003677, -1.301837, -13.36434),
			angle = Angle(-0.000868, 179.999836, 89.999727),
			size = Vector(0.72, 0.72, 0.72),
		},
	}
end

SWEP.Attachments = {
	[2] = {header = "Barrel", offset = {-500, -600}, atts = {"md_saker"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "Anomaly Reskins"
SWEP.AdminOnly = true

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.DurabilityDamage = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.FireDelay = 0.08
SWEP.Recoil = 1.1

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.09
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 80
SWEP.DeployTime = 1

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_g36k.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/g36k.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_g36k_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.624, -4, 1.837)
SWEP.IronsightAng = Vector(0, 0, 0)
SWEP.SprintPos = Vector(7.5, -7.7, 0.15)
SWEP.SprintAng = Vector(-14, 52, -13)
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
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
}
SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G36K.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G36K.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G36K.ReloadEmpty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G36K.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G36K.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 4.5
SWEP.ReloadTime_Empty = 4.5
SWEP.ReloadHalt = 4.5
SWEP.ReloadHalt_Empty = 4.5
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_g36k_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.6324, -4.4206)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.G36K.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.G36K.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_g36k")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 4.738)
	SWEP.BoltBonePositionRecoverySpeed = 79
end

function SWEP:fireAnimFunc()
end
