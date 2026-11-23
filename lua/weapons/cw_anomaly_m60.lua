-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "M60"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/m60.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_m60_w.mdl"

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
	["Ammo"] = "7.62x51MM",
}

SWEP.FireDelay = 0.12

SWEP.FireSound = "TFA_ANOMALY.M60.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.M60.FIRE"

SWEP.Damage = 135

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.14

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.4

SWEP.SpreadPerShot = 0.007

SWEP.MaxSpreadInc = 0.07

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 3

SWEP.SpeedDec = 40

SWEP.DeployTime = 0.866667

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 8.2

SWEP.ReloadTime_Empty = 8.2

SWEP.ReloadHalt = 8.2

SWEP.ReloadHalt_Empty = 8.2

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-5.655, 0, 0.055)

SWEP.IronsightAng = Vector(2.01, 0.5, 0)

SWEP.SprintPos = Vector(7, -7.5, 0.5)

SWEP.SprintAng = Vector(-15, 51, -11)

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
			["sound"] = "TFA_ANOMALY.M60.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M60.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M60.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M60.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M60.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.566667,
	["anm_idle"] = 3.366667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.833333,
	["anm_reload"] = 8.2,
	["anm_reload_empty"] = 8.2,
	["anm_shots"] = 0.3,
	["anm_shots_aim"] = 0.3,
	["anm_show"] = 0.866667,
	["anm_show_first"] = 0.866667,
}

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
			[1] = "cw_anomaly_ammo_762x51_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_ammo_762x51_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV"] = 70,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 29750.0,
		["RPM"] = 500,
		["Ammo"] = "7.62x51MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.028672268907563,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.8,
		["Automatic"] = true,
		["Spread"] = 0.025,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.M60.FIRE",
		["Damage"] = 39,
		["DefaultClip"] = 400,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 100,
		["IronAccuracy"] = 0.0025,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {},
	["VElements"] = {},
	["RunSightsAng"] = Vector(-15, 51, -11),
	["Silenced"] = false,
	["IronSightsAng"] = Vector(2.01, 0.5, 0),
	["IronSightsPos"] = Vector(-5.655, 0, 0.055),
	["RunSightsPos"] = Vector(7, -7.5, 0.5),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_m60_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 5.7506, -3.113)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_m60")
	killicon.Add("cw_anomaly_m60", "vgui/killicons/tfa_anomaly_m60", Color(255, 255, 255))
end
