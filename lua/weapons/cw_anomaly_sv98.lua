-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "SV-98"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/sv98.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_sv98_w.mdl"

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
	["Ammo"] = "7.62x54MMR",
}

SWEP.FireDelay = 2.0

SWEP.FireSound = "TFA_ANOMALY.SV98.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.SV98.FIRE_SILENCED"

SWEP.Damage = 210

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.1

SWEP.AimSpread = 0.005

SWEP.Recoil = 6.0

SWEP.SpreadPerShot = 0.007

SWEP.MaxSpreadInc = 0.4

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 12

SWEP.SpeedDec = 25

SWEP.DeployTime = 1.1

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 4.466667

SWEP.ReloadTime_Empty = 4.466667

SWEP.ReloadHalt = 4.466667

SWEP.ReloadHalt_Empty = 4.466667

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.3185, -9, 2.3925)

SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.SprintPos = Vector(6.2, -8.5, 0)

SWEP.SprintAng = Vector(-15, 49, -16.5)

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
			["sound"] = "TFA_ANOMALY.SV98.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SV98.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SV98.Reload",
		},
	},
	["anm_shots"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SV98.Bolt",
		},
	},
	["anm_shots_aim"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SV98.Bolt",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SV98.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SV98.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.566667,
	["anm_idle"] = 6.733333,
	["anm_idle_aim"] = 0.1,
	["anm_idle_sprint"] = 0.866667,
	["anm_reload"] = 4.466667,
	["anm_reload_empty"] = 4.466667,
	["anm_shots"] = 2.133333,
	["anm_shots_aim"] = 2.133333,
	["anm_show"] = 1.1,
	["anm_show_first"] = 1.1,
}

SWEP.AnomalyScopeZoom = 10

SWEP.AnomalyReticle = "models/flaymi/stalker/anomaly/weapons/sv98/wpn_crosshair_sv98"

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
		["header"] = "Finish",
		["offset"] = {
			[1] = 300,
			[2] = -400,
		},
		["atts"] = {
			[1] = "cw_anomaly_sv98_sk1",
		},
	},
	[2] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_762x54_ap",
			[2] = "cw_anomaly_ammo_762x54_7h14",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sv98_sk1",
	[2] = "cw_anomaly_ammo_762x54_ap",
	[3] = "cw_anomaly_ammo_762x54_7h14",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["ScopeZoom"] = 10,
		["IronFOV"] = 70,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["RunSightsAng"] = Vector(-15, 49, -16.5),
	["RunSightsPos"] = Vector(6.2, -8.5, 0),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 35700.0,
		["RPM"] = 30,
		["Ammo"] = "7.62x54MMR",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.SV98.FIRE_SILENCED",
		["RangeFalloff"] = 0.024089635854342,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 2.81,
		["Automatic"] = false,
		["Spread"] = 0.03,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.SV98.FIRE",
		["Damage"] = 55,
		["DefaultClip"] = 40,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 10,
		["IronAccuracy"] = 0.0008,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {},
	["VElements"] = {},
	["IronSightsAng"] = Vector(0, 0, 0),
	["Silenced"] = false,
	["IronSightsPos"] = Vector(-4.3185, -9, 2.3925),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_sv98_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.3086, -2.3846)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_sv98")
	killicon.Add("cw_anomaly_sv98", "vgui/killicons/tfa_anomaly_sv98", Color(255, 255, 255))
end
