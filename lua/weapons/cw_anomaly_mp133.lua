-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "MP-133"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/mp133.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_mp133_w.mdl"

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
	["ClipSize"] = 6,
	["DefaultClip"] = 24,
	["Automatic"] = false,
	["Ammo"] = "12 Gauge",
}

SWEP.FireDelay = 1.0

SWEP.FireSound = "TFA_ANOMALY.MP133.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.MP133.FIRE_SILENCED"

SWEP.Damage = 38

SWEP.Shots = 9

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.06

SWEP.AimSpread = 0.015

SWEP.Recoil = 4.5

SWEP.SpreadPerShot = 0.19

SWEP.MaxSpreadInc = 0.35

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 4

SWEP.SpeedDec = 15

SWEP.ClumpSpread = 0.03

SWEP.DeployTime = 1.166667

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 0.8

SWEP.ReloadTime_Empty = 1

SWEP.ReloadHalt = 0.8

SWEP.ReloadHalt_Empty = 1

SWEP.ShotgunReload = true

SWEP.ReloadStartTime = 0.8

SWEP.InsertShellTime = 0.833333

SWEP.ReloadFinishWait = 1.5

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = false

SWEP.IronsightPos = Vector(-3.72, 0, 3.3)

SWEP.IronsightAng = Vector(0.268, 0, 0)

SWEP.SprintPos = Vector(6.5, -9.5, 1.6)

SWEP.SprintAng = Vector(-14, 49, -10)

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
			["sound"] = "TFA_ANOMALY.MP133.Holster",
		},
	},
	["anm_add_cartridge"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP133.ReloadInsert",
		},
	},
	["anm_close"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP133.ReloadEnd",
		},
	},
	["anm_shots"] = {
		[1] = {
			["time"] = 0.066667,
			["sound"] = "TFA_ANOMALY.MP133.Pump",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP133.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP133.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.833333,
	["anm_idle"] = 6.7,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.833333,
	["anm_open"] = 0.8,
	["anm_add_cartridge"] = 0.833333,
	["anm_close"] = 1.5,
	["anm_shots"] = 1.2,
	["anm_show"] = 1.166667,
	["anm_show_first"] = 1.166667,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.33

SWEP.DurabilityDamageChance = 0.01

SWEP.WearEffect = 0.005

SWEP.MuzzleAttachmentName = "muzzle"

SWEP.MuzzleEffect = "muzzleflash_ak74"

SWEP.Shell = false

SWEP.AttachmentModelsVM = {}

SWEP.Attachments = {
	[1] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -400,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_12x76_zhekan",
			[2] = "cw_anomaly_ammo_12x76_dart",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_ammo_12x76_zhekan",
	[2] = "cw_anomaly_ammo_12x76_dart",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV"] = 70,
	},
	["Primary"] = {
		["KickDown"] = 0.3,
		["HullSize"] = 0,
		["Range"] = 8925.0,
		["RPM"] = 60,
		["Ammo"] = "12 Gauge",
		["AmmoConsumption"] = 1,
		["NumShots"] = 9,
		["SilencedSound"] = "TFA_ANOMALY.MP133.FIRE_SILENCED",
		["RangeFalloff"] = 0.038095238095238,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 2.1333333333333,
		["Automatic"] = false,
		["Spread"] = 0.0454,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.6,
		["Sound"] = "TFA_ANOMALY.MP133.FIRE",
		["Damage"] = 13.166666666667,
		["DefaultClip"] = 24,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 6,
		["IronAccuracy"] = 0.0424,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.3,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {},
	["VElements"] = {},
	["RunSightsAng"] = Vector(-14, 49, -10),
	["Silenced"] = false,
	["IronSightsAng"] = Vector(0.268, 0, 0),
	["RunSightsPos"] = Vector(6.5, -9.5, 1.6),
	["IronSightsPos"] = Vector(-3.72, 0, 3.3),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_mp133_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 4.0309, -3.2637)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_mp133")
	killicon.Add("cw_anomaly_mp133", "vgui/killicons/tfa_anomaly_mp133", Color(255, 255, 255))
end
