-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Gauss rifle"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/wpn_gauss.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/w_wpn_gauss.mdl"

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

SWEP.FireDelay = 2.0

SWEP.FireSound = "TFA_ANOMALY.GAUSS.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.GAUSS.FIRE"

SWEP.Damage = 500

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.0001

SWEP.AimSpread = 1e-05

SWEP.Recoil = 0.0125

SWEP.SpreadPerShot = 5e-05

SWEP.MaxSpreadInc = 5e-05

SWEP.SpreadCooldown = 0.25

SWEP.VelocitySensitivity = 0

SWEP.SpeedDec = 0

SWEP.ClumpSpread = 1e-05

SWEP.DeployTime = 0.666667

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 4.0

SWEP.ReloadTime_Empty = 4.0

SWEP.ReloadHalt = 4.0

SWEP.ReloadHalt_Empty = 4.0

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = false

SWEP.IronsightPos = Vector(-5.0265, -7, 0.669)

SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.SprintPos = Vector(8, -9, -0.1)

SWEP.SprintAng = Vector(-16, 53, -17)

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
			["sound"] = "TFA_ANOMALY.GAUSS.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GAUSS.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GAUSS.Reload",
		},
	},
	["anm_shots"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GAUSS.Wave",
		},
	},
	["anm_shots_aim"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GAUSS.Wave",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GAUSS.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GAUSS.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.5,
	["anm_idle"] = 3.333333,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 2.5,
	["anm_reload"] = 4.0,
	["anm_reload_empty"] = 4.0,
	["anm_shots"] = 0.666667,
	["anm_shots_aim"] = 0.666667,
	["anm_show"] = 0.666667,
	["anm_show_first"] = 0.666667,
}

SWEP.AnomalyScopeZoom = 4

SWEP.AnomalyReticle = "models/flaymi/stalker/anomaly/weapons/gauss/wpn_crosshair_gauss"

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots_aim"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.05

SWEP.DurabilityDamageChance = 0.005

SWEP.WearEffect = 0.007

SWEP.MuzzleAttachmentName = "muzzle"

SWEP.MuzzleEffect = false

SWEP.Shell = false

SWEP.AnomalyTracer = "cw_anomaly_gauss_tracer"

SWEP.AttachmentModelsVM = {}

SWEP.Attachments = {}

SWEP.AnomalyAttachmentOrder = {}

SWEP.AnomalySource = {
	["Secondary"] = {
		["ScopeZoom"] = 4,
		["IronFOV"] = 60,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["Primary"] = {
		["KickDown"] = 0.01,
		["HullSize"] = 0,
		["Range"] = 29750.0,
		["Force"] = 0,
		["Ammo"] = "",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.50420168067227,
		["DamageTypeHandled"] = true,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.5,
		["Automatic"] = false,
		["RPM"] = 30,
		["PenetrationMultiplier"] = 0.1,
		["KickHorizontal"] = 0.01,
		["Sound"] = "TFA_ANOMALY.GAUSS.FIRE",
		["IronAccuracy"] = 1e-05,
		["DefaultClip"] = 40,
		["Damage"] = 500,
		["ClipSize"] = 10,
		["Spread"] = 0.0001,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.015,
	},
	["RunSightsAng"] = Vector(-16, 53, -17),
	["RunSightsPos"] = Vector(8, -9, -0.1),
	["WElements"] = {},
	["VElements"] = {},
	["IronSightsAng"] = Vector(0, 0, 0),
	["Silenced"] = false,
	["IronSightsPos"] = Vector(-5.0265, -7, 0.669),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/w_wpn_gauss.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.5, 4.8502, -1.9301)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_gauss")
	killicon.Add("cw_anomaly_gauss", "vgui/killicons/tfa_anomaly_gauss", Color(255, 255, 255))
end

SWEP.AnomalyAmmoUnavailable = true
