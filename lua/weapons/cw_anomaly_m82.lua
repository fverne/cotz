-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Barrett M82"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/m82.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_m82_w.mdl"

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
	["Ammo"] = "12.7x55mm",
}

SWEP.FireDelay = 0.6

SWEP.FireSound = "TFA_ANOMALY.M82.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.M82.FIRE"

SWEP.Damage = 650

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.015

SWEP.AimSpread = 0.005

SWEP.Recoil = 6.5

SWEP.SpreadPerShot = 0.007

SWEP.MaxSpreadInc = 0.4

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 12

SWEP.SpeedDec = 35

SWEP.DeployTime = 0.866667

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 4.6

SWEP.ReloadTime_Empty = 4.6

SWEP.ReloadHalt = 4.6

SWEP.ReloadHalt_Empty = 4.6

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-3.7515, -3, 2.213)

SWEP.IronsightAng = Vector(0, 0, -0.1)

SWEP.SprintPos = Vector(7.5, -8.5, 0.3)

SWEP.SprintAng = Vector(-12, 51, -11)

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
			["sound"] = "TFA_ANOMALY.M82.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M82.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M82.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M82.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M82.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.566667,
	["anm_idle"] = 3.333333,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.666667,
	["anm_reload"] = 4.6,
	["anm_reload_empty"] = 4.6,
	["anm_shots"] = 0.5,
	["anm_shots_aim"] = 0.5,
	["anm_show"] = 0.866667,
	["anm_show_first"] = 0.866667,
}

SWEP.AnomalyScopeZoom = 4

SWEP.AnomalyReticle = "models/flaymi/stalker/anomaly/weapons/m82/wpn_crosshair_m82"

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots_aim"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.33

SWEP.DurabilityDamageChance = 0.01

SWEP.FireMoveMod = 0.6

SWEP.WearEffect = 0.005

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
			[1] = "cw_anomaly_ammo_127x55_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_ammo_127x55_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["ScopeZoom"] = 4,
		["IronFOV"] = 60,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["RunSightsAng"] = Vector(-12, 51, -11),
	["RunSightsPos"] = Vector(7.5, -8.5, 0.3),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 53550.0,
		["RPM"] = 100,
		["Ammo"] = "12.7x55mm",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.015929038281979,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 4,
		["Automatic"] = false,
		["Spread"] = 0.03,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.M82.FIRE",
		["Damage"] = 150,
		["DefaultClip"] = 40,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 10,
		["IronAccuracy"] = 0.0001,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {},
	["VElements"] = {},
	["IronSightsAng"] = Vector(0, 0, -0.1),
	["Silenced"] = false,
	["IronSightsPos"] = Vector(-3.7515, -3, 2.213),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_m82_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.2824, -2.6834)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_m82")
	killicon.Add("cw_anomaly_m82", "vgui/killicons/tfa_anomaly_m82", Color(255, 255, 255))
end
