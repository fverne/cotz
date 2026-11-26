-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Armsel Protecta"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/protecta.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_protecta_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 2

SWEP.SlotPos = 73

SWEP.NormalHoldType = "smg"

SWEP.RunHoldType = "passive"

SWEP.FireModes = {
	[1] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 12,
	["DefaultClip"] = 48,
	["Automatic"] = false,
	["Ammo"] = "12 Gauge",
}

SWEP.FireDelay = 0.3870967741935484

SWEP.FireSound = "TFA_ANOMALY.PROTECTA.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.PROTECTA.FIRE_SILENCED"

SWEP.Damage = 42

SWEP.Shots = 9

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.07

SWEP.AimSpread = 0.025

SWEP.Recoil = 3.0

SWEP.SpreadPerShot = 0.007

SWEP.MaxSpreadInc = 0.4

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 0.5

SWEP.SpeedDec = 20

SWEP.ClumpSpread = 0.035

SWEP.DeployTime = 1.033333

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

SWEP.Chamberable = false

SWEP.IronsightPos = Vector(-4.298, -3, 0.145)

SWEP.IronsightAng = Vector(2.11, 0, 0)

SWEP.SprintPos = Vector(7.5, -6.45, 0)

SWEP.SprintAng = Vector(-15, 51, -15)

SWEP.ZoomAmount = 20

SWEP.AimViewModelFOV = 55

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

SWEP.AnomalySequences = {
	["anm_hide"] = 0.8,
	["anm_idle"] = 6.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_open"] = 0.5,
	["anm_add_cartridge"] = 1.666667,
	["anm_close"] = 0.5,
	["anm_shots"] = 0.666667,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
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

SWEP.Shell = "shotshell"

SWEP.AttachmentModelsVM = {}

SWEP.Attachments = {
	[1] = {
		["header"] = "Finish",
		["offset"] = {
			[1] = 300,
			[2] = -400,
		},
		["atts"] = {
			[1] = "cw_anomaly_protecta_sk1",
			[2] = "cw_anomaly_protecta_sk2",
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
	[1] = "cw_anomaly_protecta_sk1",
	[2] = "cw_anomaly_protecta_sk2",
	[3] = "cw_anomaly_ammo_12x76_zhekan",
	[4] = "cw_anomaly_ammo_12x76_dart",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV"] = 70,
	},
	["Primary"] = {
		["KickDown"] = 0.3,
		["HullSize"] = 0,
		["Range"] = 8925.0,
		["RPM"] = 155,
		["Ammo"] = "12 Gauge",
		["AmmoConsumption"] = 1,
		["NumShots"] = 9,
		["SilencedSound"] = "TFA_ANOMALY.PROTECTA.FIRE_SILENCED",
		["RangeFalloff"] = 0.035854341736695,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 2.1533333333333,
		["Automatic"] = false,
		["Spread"] = 0.052,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.6,
		["Sound"] = "TFA_ANOMALY.PROTECTA.FIRE",
		["Damage"] = 13.0,
		["DefaultClip"] = 48,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 12,
		["IronAccuracy"] = 0.05,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.3,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {},
	["VElements"] = {},
	["RunSightsAng"] = Vector(-15, 51, -15),
	["Silenced"] = false,
	["IronSightsAng"] = Vector(2.11, 0, 0),
	["RunSightsPos"] = Vector(7.5, -6.45, 0),
	["IronSightsPos"] = Vector(-4.298, -3, 0.145),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_protecta_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 4.4642, -2.9001)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "smg"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_protecta")
	killicon.Add("cw_anomaly_protecta", "vgui/killicons/tfa_anomaly_protecta", Color(255, 255, 255))
end
