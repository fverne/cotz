AddCSLuaFile()
AddCSLuaFile("weapons/cw_trg42/sh_sounds.lua")
include("weapons/cw_trg42/sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Sako TRG-42"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "i"
	killicon.Add("cw_cotz_anomaly_trg42", "vgui/kills/cw_trg42", Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 0.6

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}

	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

	SWEP.Attachments = {
		[2] = {header = "Barrel", offset = {-250, -300},  atts = {"md_saker"}},
		["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}
	}

SWEP.SpeedDec = 30

SWEP.AimBreathingIntensity = 1
SWEP.AimBreathingEnabled = false

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "Anomaly Reskins"
SWEP.AdminOnly = true

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.WearDamage = 0.33
SWEP.WearEffect = 0.005

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".338 Lapua"
SWEP.magType = "srMag"

SWEP.FireDelay = 1
SWEP.Recoil = 4.2
SWEP.CustomizationMenuScale = 0.02
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.GlobalDelayOnShoot = 1.1

SWEP.HipSpread = 0.12
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 15
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.1
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 450
SWEP.DeployTime = 1

SWEP.Chamberable = false

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_trg.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/trg.mdl"
SWEP.AnomalyScopeZoom = 10
SWEP.AnomalyReticle = "models/flaymi/stalker/anomaly/weapons/trg/wpn_crosshair_findot"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_trg_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.4598, -10, 0.603)
SWEP.IronsightAng = Vector(0, 0, 0)
SWEP.SprintPos = Vector(7.2, -6.5, -0.5)
SWEP.SprintAng = Vector(-13.5, 50.6, -13.5)
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
			["sound"] = "TFA_ANOMALY.TRG.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TRG.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TRG.Reload",
		},
	},
	["anm_shots"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TRG.Bolt",
		},
	},
	["anm_shots_aim"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TRG.Bolt",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TRG.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TRG.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadChamberCuts = {
	anm_reload = {from = 2.533333, to = 4.133333},
}
SWEP.ReloadTime = 4.433333
SWEP.ReloadTime_Empty = 4.433333
SWEP.ReloadHalt = 4.433333
SWEP.ReloadHalt_Empty = 4.433333
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = false
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_trg_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 3.7669, -2.8391)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.TRG.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.TRG.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_trg")
end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_saker"] = {
			model = "models/cw2/attachments/556suppressor.mdl",
			bone = "wpn_body",
			pos = Vector(-0.013409, -1.193584, -22.835284),
			angle = Angle(0.036246, 179.57105, 89.84671),
			size = Vector(0.72, 0.72, 0.72),
		},
	}
end
