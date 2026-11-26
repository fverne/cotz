-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "RPD"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/rpd.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_rpd_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 2

SWEP.SlotPos = 73

SWEP.NormalHoldType = "ar2"

SWEP.RunHoldType = "passive"

SWEP.FireModes = {
	[1] = "auto",
}

SWEP.Primary = {
	["ClipSize"] = 100,
	["DefaultClip"] = 400,
	["Automatic"] = true,
	["Ammo"] = "7.62x39MM",
}

SWEP.FireDelay = 0.1

SWEP.FireSound = "TFA_ANOMALY.RPD.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.RPD.FIRE"

SWEP.Damage = 85

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.1

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.3

SWEP.SpreadPerShot = 0.007

SWEP.MaxSpreadInc = 0.09

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 3

SWEP.SpeedDec = 25

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1
SWEP.ReloadChamberCuts = {
	anm_reload = {from = 5.700000, to = 6.966667},
}

SWEP.ReloadTime = 7.1

SWEP.ReloadTime_Empty = 7.1

SWEP.ReloadHalt = 7.1

SWEP.ReloadHalt_Empty = 7.1

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.858, 0, 2.013)

SWEP.IronsightAng = Vector(0.2, 0.05, 0)

SWEP.SprintPos = Vector(4, -10.2, 1.3)

SWEP.SprintAng = Vector(-14, 48, -10)

SWEP.ZoomAmount = 20

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
			["sound"] = "TFA_ANOMALY.RPD.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPD.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPD.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPD.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPD.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 1.033333,
	["anm_idle"] = 6.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_reload"] = 7.1,
	["anm_reload_empty"] = 7.1,
	["anm_shots"] = 0.433333,
	["anm_shots_aim"] = 0.433333,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
}

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

SWEP.Attachments = {
	[1] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -400,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_762x39_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_ammo_762x39_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV"] = 70,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 26775.0,
		["RPM"] = 600,
		["Ammo"] = "7.62x39MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.027264239028945,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.762,
		["Automatic"] = true,
		["Spread"] = 0.038,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.RPD.FIRE",
		["Damage"] = 29.5,
		["DefaultClip"] = 400,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 100,
		["IronAccuracy"] = 0.0038,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {},
	["VElements"] = {},
	["RunSightsAng"] = Vector(-14, 48, -10),
	["Silenced"] = false,
	["IronSightsAng"] = Vector(0.2, 0.05, 0),
	["IronSightsPos"] = Vector(-4.858, 0, 2.013),
	["RunSightsPos"] = Vector(4, -10.2, 1.3),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_rpd_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 5.9411, -3.2301)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_rpd")
	killicon.Add("cw_anomaly_rpd", "vgui/killicons/tfa_anomaly_rpd", Color(255, 255, 255))
end
