-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "RPK"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/rpk.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_rpk_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 2

SWEP.SlotPos = 73

SWEP.NormalHoldType = "ar2"

SWEP.RunHoldType = "passive"

SWEP.FireModes = {
	[1] = "semi",
	[2] = "auto",
}

SWEP.Primary = {
	["ClipSize"] = 40,
	["DefaultClip"] = 160,
	["Automatic"] = true,
	["Ammo"] = "7.62x39MM",
}

SWEP.FireDelay = 0.1

SWEP.FireSound = "TFA_ANOMALY.RPK.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.RPK.FIRE"

SWEP.Damage = 88

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.12

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.7

SWEP.SpreadPerShot = 0.005

SWEP.MaxSpreadInc = 0.1

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 3

SWEP.SpeedDec = 25

SWEP.DeployTime = 0.9

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.566667

SWEP.ReloadTime_Empty = 3.566667

SWEP.ReloadHalt = 3.566667

SWEP.ReloadHalt_Empty = 3.566667

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-3.283, -2, 2.207)

SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.SprintPos = Vector(6.2, -7.5, 1.2)

SWEP.SprintAng = Vector(-15, 48, -11)

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
			["sound"] = "TFA_ANOMALY.RPK.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPK.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPK.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPK.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPK.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.9,
	["anm_idle"] = 3.4,
	["anm_idle_aim"] = 0.1,
	["anm_idle_sprint"] = 0.866667,
	["anm_reload"] = 3.566667,
	["anm_reload_empty"] = 3.566667,
	["anm_shots"] = 0.6,
	["anm_shots_aim"] = 0.6,
	["anm_show"] = 0.9,
	["anm_show_first"] = 0.9,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots_aim"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0

SWEP.DurabilityDamageChance = 0.01

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
		["RangeFalloff"] = 0.027637721755369,
		["DamageTypeHandled"] = true,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.762,
		["Automatic"] = true,
		["RPM_2nd"] = 1800,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.RPK.FIRE",
		["IronAccuracy"] = 0.0033,
		["DefaultClip"] = 160,
		["Damage"] = 39.25,
		["ClipSize"] = 40,
		["Spread"] = 0.033,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {},
	["VElements"] = {},
	["RunSightsAng"] = Vector(-15, 48, -11),
	["Silenced"] = false,
	["IronSightsAng"] = Vector(0, 0, 0),
	["IronSightsPos"] = Vector(-3.283, -2, 2.207),
	["RunSightsPos"] = Vector(6.2, -7.5, 1.2),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_rpk_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.9997, -5.9584)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_rpk")
	killicon.Add("cw_anomaly_rpk", "vgui/killicons/tfa_anomaly_rpk", Color(255, 255, 255))
end
