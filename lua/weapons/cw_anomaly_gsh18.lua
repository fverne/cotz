-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "GSh-18"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/gsh18.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_gsh18_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 1

SWEP.SlotPos = 73

SWEP.NormalHoldType = "pistol"

SWEP.RunHoldType = "normal"

SWEP.FireModes = {
	[1] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 18,
	["DefaultClip"] = 72,
	["Automatic"] = false,
	["Ammo"] = "9x19MM",
}

SWEP.FireDelay = 0.08

SWEP.FireSound = "TFA_ANOMALY.GSH18.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.GSH18.FIRE"

SWEP.Damage = 60

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.05

SWEP.AimSpread = 0.02

SWEP.Recoil = 1.1

SWEP.SpreadPerShot = 0.02

SWEP.MaxSpreadInc = 0.08

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 2

SWEP.SpeedDec = 0

SWEP.DeployTime = 0.733333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.466667

SWEP.ReloadTime_Empty = 3.966667

SWEP.ReloadHalt = 3.466667

SWEP.ReloadHalt_Empty = 3.966667

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-3.81, -1, 2.24)

SWEP.IronsightAng = Vector(-0.4, 0, 0)

SWEP.SprintPos = Vector(0, -1, 3.6)

SWEP.SprintAng = Vector(-19, 3, -6)

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
	["anm_hide_empty"] = "anm_hide_empty",
	["anm_idle"] = "anm_idle",
	["anm_idle_empty"] = "anm_idle_empty",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_aim_empty"] = "anm_idle_aim_empty",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_empty"] = "anm_idle_sprint_empty",
	["anm_reload"] = "anm_reload",
	["anm_reload_empty"] = "anm_reload_empty",
	["anm_shots"] = "anm_shots",
	["anm_shots_last"] = "anm_shots_last",
	["anm_show"] = "anm_show",
	["anm_show_empty"] = "anm_show_empty",
	["anm_show_first"] = "anm_show_first",
}

SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GSH18.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GSH18.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GSH18.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GSH18.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GSH18.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GSH18.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GSH18.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.533333,
	["anm_hide_empty"] = 0.533333,
	["anm_idle"] = 6.366667,
	["anm_idle_empty"] = 6.366667,
	["anm_idle_aim"] = 6.366667,
	["anm_idle_aim_empty"] = 6.366667,
	["anm_idle_sprint"] = 0.833333,
	["anm_idle_sprint_empty"] = 0.833333,
	["anm_reload"] = 3.466667,
	["anm_reload_empty"] = 3.966667,
	["anm_shots"] = 0.466667,
	["anm_shots_last"] = 0.466667,
	["anm_show"] = 0.733333,
	["anm_show_empty"] = 0.733333,
	["anm_show_first"] = 0.733333,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.14

SWEP.DurabilityDamage = 0.01

SWEP.WearEffect = 0.05

SWEP.MuzzleAttachmentName = "muzzle"

SWEP.MuzzleEffect = "muzzleflash_pistol"

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
			[1] = "cw_anomaly_gsh18_sk1",
		},
	},
	[2] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_9x19_pbp",
			[2] = "cw_anomaly_ammo_9x19_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_gsh18_sk1",
	[2] = "cw_anomaly_ammo_9x19_pbp",
	[3] = "cw_anomaly_ammo_9x19_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV"] = 70,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 11900.0,
		["RPM"] = 280,
		["Ammo"] = "9x19MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.03109243697479,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.6,
		["Automatic"] = false,
		["Spread"] = 0.041,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.GSH18.FIRE",
		["Damage"] = 23,
		["DefaultClip"] = 72,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 18,
		["IronAccuracy"] = 0.0041,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {},
	["VElements"] = {},
	["RunSightsAng"] = Vector(-19, 3, -6),
	["Silenced"] = false,
	["IronSightsAng"] = Vector(-0.4, 0, 0),
	["IronSightsPos"] = Vector(-3.81, -1, 2.24),
	["RunSightsPos"] = Vector(0, -1, 3.6),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_gsh18_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.3, 4.3472, -3.0906)

SWEP.WMAng = Vector(-5, 0, 180)

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_gsh18")
	killicon.Add("cw_anomaly_gsh18", "vgui/killicons/tfa_anomaly_gsh18", Color(255, 255, 255))
end
