-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "CZ-75 Automatic"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/cz75_auto.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_cz75_auto_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 1

SWEP.SlotPos = 73

SWEP.NormalHoldType = "pistol"

SWEP.RunHoldType = "normal"

SWEP.FireModes = {
	[1] = "auto",
	[2] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 16,
	["DefaultClip"] = 64,
	["Automatic"] = true,
	["Ammo"] = "9x19MM",
}

SWEP.FireDelay = 0.06

SWEP.FireSound = "TFA_ANOMALY.CZ75AUTO.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.CZ75AUTO.FIRE_SILENCED"

SWEP.Damage = 55

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.05

SWEP.AimSpread = 0.025

SWEP.Recoil = 1.2

SWEP.SpreadPerShot = 0.012

SWEP.MaxSpreadInc = 0.08

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 1.5

SWEP.SpeedDec = 5

SWEP.DeployTime = 1.233333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.266667

SWEP.ReloadTime_Empty = 3.266667

SWEP.ReloadHalt = 3.266667

SWEP.ReloadHalt_Empty = 3.266667

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-3.865, -1, 3.073)

SWEP.IronsightAng = Vector(0.1, 0, 0)

SWEP.SprintPos = Vector(0.5, 0, 4.5)

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
			["sound"] = "TFA_ANOMALY.CZ75AUTO.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.CZ75AUTO.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.CZ75AUTO.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.CZ75AUTO.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.CZ75AUTO.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.733333,
	["anm_idle"] = 6.366667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.833333,
	["anm_reload"] = 3.266667,
	["anm_reload_empty"] = 3.266667,
	["anm_shots"] = 0.466667,
	["anm_show"] = 1.233333,
	["anm_show_first"] = 1.233333,
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
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -400,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_9x19_pbp",
			[2] = "cw_anomaly_ammo_9x19_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_ammo_9x19_pbp",
	[2] = "cw_anomaly_ammo_9x19_ap",
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
		["RPM"] = 1000,
		["Ammo"] = "9x19MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.CZ75AUTO.FIRE_SILENCED",
		["RangeFalloff"] = 0.031512605042017,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.6,
		["Automatic"] = true,
		["Spread"] = 0.045,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.CZ75AUTO.FIRE",
		["Damage"] = 23,
		["DefaultClip"] = 64,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 16,
		["IronAccuracy"] = 0.0045,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {},
	["VElements"] = {},
	["RunSightsAng"] = Vector(-19, 3, -6),
	["Silenced"] = false,
	["IronSightsAng"] = Vector(0.1, 0, 0),
	["IronSightsPos"] = Vector(-3.865, -1, 3.073),
	["RunSightsPos"] = Vector(0.5, 0, 4.5),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_cz75_auto_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.3, 3.9661, -2.8565)

SWEP.WMAng = Vector(-5, 0, 180)

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_cz75_auto")
	killicon.Add("cw_anomaly_cz75_auto", "vgui/killicons/tfa_anomaly_cz75_auto", Color(255, 255, 255))
end
