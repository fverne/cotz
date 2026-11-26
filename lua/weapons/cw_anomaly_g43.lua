-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Karabiner 43"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/g43.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_g43_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 2

SWEP.SlotPos = 73

SWEP.NormalHoldType = "ar2"

SWEP.RunHoldType = "passive"

SWEP.FireModes = {
	[1] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 10,
	["DefaultClip"] = 40,
	["Automatic"] = false,
	["Ammo"] = "",
}

SWEP.FireDelay = 0.08

SWEP.FireSound = "TFA_ANOMALY.G43.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.G43.FIRE"

SWEP.Damage = 140

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.15

SWEP.AimSpread = 0.005

SWEP.Recoil = 2.5

SWEP.SpreadPerShot = 0.033

SWEP.MaxSpreadInc = 0.1

SWEP.SpreadCooldown = 0.25

SWEP.VelocitySensitivity = 7

SWEP.SpeedDec = 25

SWEP.ClumpSpread = 0.0014

SWEP.DeployTime = 1.066667

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.466667

SWEP.ReloadTime_Empty = 3.466667

SWEP.ReloadHalt = 3.466667

SWEP.ReloadHalt_Empty = 3.466667

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.6123, -6.5, 1.583)

SWEP.IronsightAng = Vector(0, 0, -0.2)

SWEP.SprintPos = Vector(7.5, -7.5, 0.4)

SWEP.SprintAng = Vector(-15, 51.5, -14)

SWEP.ZoomAmount = 30

SWEP.AimViewModelFOV = 55

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
			["sound"] = "TFA_ANOMALY.G43.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G43.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G43.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G43.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G43.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 1.066667,
	["anm_idle"] = 6.066667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.833333,
	["anm_reload"] = 3.466667,
	["anm_reload_empty"] = 3.466667,
	["anm_shots"] = 0.7,
	["anm_shots_aim"] = 0.7,
	["anm_show"] = 1.066667,
	["anm_show_first"] = 1.066667,
}

SWEP.AnomalyScopeZoom = 4

SWEP.AnomalyReticle = "models/flaymi/stalker/anomaly/weapons/g43/wpn_crosshair_g43"

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots_aim"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.05

SWEP.DurabilityDamage = 0.005

SWEP.WearEffect = 0.007

SWEP.MuzzleAttachmentName = "muzzle"

SWEP.MuzzleEffect = "muzzleflash_ak74"

SWEP.Shell = "mainshell"

SWEP.AttachmentModelsVM = {}

SWEP.Attachments = {}

SWEP.AnomalyAttachmentOrder = {}

SWEP.AnomalySource = {
	["Secondary"] = {
		["ScopeZoom"] = 4,
		["IronFOV"] = 60,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["RunSightsAng"] = Vector(-15, 51.5, -14),
	["RunSightsPos"] = Vector(7.5, -7.5, 0.4),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 29750.0,
		["RPM"] = 70,
		["Ammo"] = "",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.024873949579832,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 2.3,
		["Automatic"] = false,
		["Spread"] = 0.014,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.G43.FIRE",
		["Damage"] = 40.5,
		["DefaultClip"] = 40,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 10,
		["IronAccuracy"] = 0.0014,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {},
	["VElements"] = {},
	["IronSightsAng"] = Vector(0, 0, -0.2),
	["Silenced"] = false,
	["IronSightsPos"] = Vector(-4.6123, -6.5, 1.583),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_g43_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 2.6212, 1.2764)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_g43")
	killicon.Add("cw_anomaly_g43", "vgui/killicons/tfa_anomaly_g43", Color(255, 255, 255))
end

SWEP.AnomalyAmmoUnavailable = true
