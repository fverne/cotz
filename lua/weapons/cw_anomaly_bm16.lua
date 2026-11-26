-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "TOZ-66 sawn-off shotgun"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/bm16.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_bm16_w.mdl"

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
	["ClipSize"] = 2,
	["DefaultClip"] = 8,
	["Automatic"] = false,
	["Ammo"] = "12 Gauge",
}

SWEP.FireDelay = 0.06

SWEP.FireSound = "TFA_ANOMALY.BM16.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.BM16.FIRE"

SWEP.Damage = 35

SWEP.Shots = 9

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.06

SWEP.AimSpread = 0.006

SWEP.Recoil = 4.7

SWEP.SpreadPerShot = 0.3

SWEP.MaxSpreadInc = 0.4

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 6

SWEP.SpeedDec = 0

SWEP.ClumpSpread = 0.0425

SWEP.DeployTime = 1.066667

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

SWEP.Chamberable = false

SWEP.IronsightPos = Vector(-2.97, -2, 2.495)

SWEP.IronsightAng = Vector(2, 0, 0)

SWEP.SprintPos = Vector(6.5, -7.5, 0.55)

SWEP.SprintAng = Vector(-13, 49, -10)

SWEP.ZoomAmount = 20

SWEP.AimViewModelFOV = 55

SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_reload",
	["reload_empty"] = "anm_reload_empty",
	["fire_dry"] = "anm_shots_last",
	["anm_hide"] = "anm_hide",
	["anm_hide_last"] = "anm_hide_last",
	["anm_hide_empty"] = "anm_hide_empty",
	["anm_idle"] = "anm_idle",
	["anm_idle_last"] = "anm_idle_last",
	["anm_idle_empty"] = "anm_idle_empty",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_aim_last"] = "anm_idle_aim_last",
	["anm_idle_aim_empty"] = "anm_idle_aim_empty",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_last"] = "anm_idle_sprint_last",
	["anm_idle_sprint_empty"] = "anm_idle_sprint_empty",
	["anm_reload"] = "anm_reload",
	["anm_reload_empty"] = "anm_reload_empty",
	["anm_shots"] = "anm_shots",
	["anm_shots_last"] = "anm_shots_last",
	["anm_show"] = "anm_show",
	["anm_show_last"] = "anm_show_last",
	["anm_show_empty"] = "anm_show_empty",
	["anm_show_first"] = "anm_show_first",
}

SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Holster",
		},
	},
	["anm_hide_last"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Draw",
		},
	},
	["anm_show_last"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.833333,
	["anm_hide_last"] = 0.833333,
	["anm_hide_empty"] = 0.833333,
	["anm_idle"] = 6.666667,
	["anm_idle_last"] = 6.666667,
	["anm_idle_empty"] = 6.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_aim_last"] = 0.033333,
	["anm_idle_aim_empty"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_idle_sprint_last"] = 0.8,
	["anm_idle_sprint_empty"] = 0.8,
	["anm_reload"] = 4.5,
	["anm_reload_empty"] = 4.5,
	["anm_shots"] = 0.666667,
	["anm_shots_last"] = 0.666667,
	["anm_show"] = 1.066667,
	["anm_show_last"] = 1.066667,
	["anm_show_empty"] = 1.066667,
	["anm_show_first"] = 1.066667,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0

SWEP.DurabilityDamage = 0.01

SWEP.MuzzleAttachmentName = "muzzle"

SWEP.MuzzleEffect = "muzzleflash_ak74"

SWEP.Shell = false

SWEP.AttachmentModelsVM = {}

SWEP.Attachments = {
	[1] = {
		["header"] = "Finish",
		["offset"] = {
			[1] = 300,
			[2] = -400,
		},
		["atts"] = {
			[1] = "cw_anomaly_bm16_sk1",
		},
	},
	[2] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_12x76_zhekan",
			[2] = "cw_anomaly_ammo_12x76_dart",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_bm16_sk1",
	[2] = "cw_anomaly_ammo_12x76_zhekan",
	[3] = "cw_anomaly_ammo_12x76_dart",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV"] = 70,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 5950.0,
		["RPM"] = 1000,
		["Ammo"] = "12 Gauge",
		["AmmoConsumption"] = 1,
		["NumShots"] = 9,
		["RangeFalloff"] = 0.050420168067227,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 3.3066666666667,
		["Automatic"] = false,
		["Spread"] = 0.085,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.BM16.FIRE",
		["Damage"] = 12.833333333333,
		["DefaultClip"] = 8,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 2,
		["IronAccuracy"] = 0.08,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {},
	["VElements"] = {},
	["RunSightsAng"] = Vector(-13, 49, -10),
	["Silenced"] = false,
	["IronSightsAng"] = Vector(2, 0, 0),
	["IronSightsPos"] = Vector(-2.97, -2, 2.495),
	["RunSightsPos"] = Vector(6.5, -7.5, 0.55),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_bm16_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 4.265, -2.8827)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_bm16")
	killicon.Add("cw_anomaly_bm16", "vgui/killicons/tfa_anomaly_bm16", Color(255, 255, 255))
end
