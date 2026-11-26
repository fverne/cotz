AddCSLuaFile()
AddCSLuaFile("weapons/cw_striker/sh_sounds.lua")
include("weapons/cw_striker/sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Striker"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1

	SWEP.IconLetter = "k"
	killicon.AddFont("cw_cotz_anomaly_striker", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 1

	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}

end

SWEP.Attachments = {["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 3
SWEP.HoldType = "smg"
SWEP.NormalHoldType = "smg"
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

SWEP.Primary.ClipSize		= 12
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.18
SWEP.Recoil = 3

SWEP.DurabilityDamage = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.07
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 0.5
SWEP.MaxSpreadInc = 0.4
SWEP.ClumpSpread = 0.035
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 9
SWEP.Damage = 42
SWEP.DeployTime = 1

SWEP.Chamberable = false

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_protecta.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/protecta.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_protecta_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.298, -3, 0.145)
SWEP.IronsightAng = Vector(2.11, 0, 0)
SWEP.SprintPos = Vector(7.5, -6.45, 0)
SWEP.SprintAng = Vector(-15, 51, -15)
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
			["sound"] = "TFA_ANOMALY.PROTECTA.Holster",
		},
	},
	["anm_add_cartridge"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PROTECTA.ReloadInsert",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PROTECTA.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PROTECTA.Draw",
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
SWEP.InsertShellTime = 1.666667
SWEP.ReloadFinishWait = 0.5
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "shotshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_protecta_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.4642, -2.9001)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.PROTECTA.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.PROTECTA.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_protecta")
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(0, 0, 9.317)
	SWEP.BoltBonePositionRecoverySpeed = 140
end

function SWEP:fireAnimFunc()
end
