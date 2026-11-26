-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "PPSh-41"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/ppsh41.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_ppsh41_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 2

SWEP.SlotPos = 73

SWEP.NormalHoldType = "smg"

SWEP.RunHoldType = "passive"

SWEP.FireModes = {
	[1] = "auto",
	[2] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 71,
	["DefaultClip"] = 284,
	["Automatic"] = true,
	["Ammo"] = "7.62x25MM",
}

SWEP.FireDelay = 0.06818181818181818

SWEP.FireSound = "TFA_ANOMALY.PPSH41.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.PPSH41.FIRE"

SWEP.Damage = 39

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.065

SWEP.AimSpread = 0.025

SWEP.Recoil = 0.55

SWEP.SpreadPerShot = 0.006

SWEP.MaxSpreadInc = 0.08

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 3

SWEP.SpeedDec = 5

SWEP.DeployTime = 1.066667

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 4.066667

SWEP.ReloadTime_Empty = 4.066667

SWEP.ReloadHalt = 4.066667

SWEP.ReloadHalt_Empty = 4.066667

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.55, 0, 1.983)

SWEP.IronsightAng = Vector(-0.1, 0, 0)

SWEP.SprintPos = Vector(6.5, -7.5, 0.4)

SWEP.SprintAng = Vector(-14, 52, -12)

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
			["sound"] = "TFA_ANOMALY.PPSH41.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PPSH41.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PPSH41.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PPSH41.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PPSH41.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 1.0,
	["anm_idle"] = 6.7,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.833333,
	["anm_reload"] = 4.066667,
	["anm_reload_empty"] = 4.066667,
	["anm_shots"] = 0.4,
	["anm_shots_aim"] = 0.4,
	["anm_show"] = 1.066667,
	["anm_show_first"] = 1.066667,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots_aim"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0

SWEP.DurabilityDamage = 0.01

SWEP.MuzzleAttachmentName = "muzzle"

SWEP.MuzzleEffect = "muzzleflash_ak74"

SWEP.Shell = "mainshell"

SWEP.AttachmentModelsVM = {}

SWEP.Attachments = {
	[1] = {
		["header"] = "Finish",
		["offset"] = {
			[1] = 300,
			[2] = -400,
		},
		["atts"] = {
			[1] = "cw_anomaly_ppsh41_sk1",
			[2] = "cw_anomaly_ppsh41_sk3",
		},
	},
	[2] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_762x25_ps",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_ppsh41_sk1",
	[2] = "cw_anomaly_ppsh41_sk3",
	[3] = "cw_anomaly_ammo_762x25_ps",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV"] = 70,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["Primary"] = {
		["KickDown"] = 0.195,
		["HullSize"] = 0,
		["Range"] = 14875.0,
		["RPM"] = 880,
		["Ammo"] = "7.62x25MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.032268907563025,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.72,
		["Automatic"] = true,
		["Spread"] = 0.065,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.39,
		["Sound"] = "TFA_ANOMALY.PPSH41.FIRE",
		["Damage"] = 23,
		["DefaultClip"] = 284,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 71,
		["IronAccuracy"] = 0.0065,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.195,
	},
	["WElements"] = {},
	["VElements"] = {},
	["RunSightsAng"] = Vector(-14, 52, -12),
	["Silenced"] = false,
	["IronSightsAng"] = Vector(-0.1, 0, 0),
	["IronSightsPos"] = Vector(-4.55, 0, 1.983),
	["RunSightsPos"] = Vector(6.5, -7.5, 0.4),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_ppsh41_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 5.5339, -3.2948)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "smg"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_ppsh41")
	killicon.Add("cw_anomaly_ppsh41", "vgui/killicons/tfa_anomaly_ppsh41", Color(255, 255, 255))
end
