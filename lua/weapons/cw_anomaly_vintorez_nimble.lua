-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "VSS Vintorez “Tide”"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/vintorez_nimble.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_vintorez_nimble_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 2

SWEP.SlotPos = 73

SWEP.NormalHoldType = "ar2"

SWEP.RunHoldType = "passive"

SWEP.FireModes = {
	[1] = "auto",
	[2] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 10,
	["DefaultClip"] = 40,
	["Automatic"] = true,
	["Ammo"] = "9x39MM",
}

SWEP.FireDelay = 0.07751937984496124

SWEP.FireSound = "TFA_ANOMALY.VINTOREZNIMBLE.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.VINTOREZNIMBLE.FIRE_SILENCED"

SWEP.Damage = 185

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.1

SWEP.AimSpread = 0.005

SWEP.Recoil = 2.2

SWEP.SpreadPerShot = 0.02

SWEP.MaxSpreadInc = 0.4

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 6

SWEP.SpeedDec = 20

SWEP.DeployTime = 0.566667

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 2.96

SWEP.ReloadTime_Empty = 2.96

SWEP.ReloadHalt = 2.96

SWEP.ReloadHalt_Empty = 2.96

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.321, -2, 1.1545)

SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.SprintPos = Vector(7, -7.3, 0)

SWEP.SprintAng = Vector(-13, 48, -12)

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
			["sound"] = "TFA_ANOMALY.VINTOREZNIMBLE.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VINTOREZNIMBLE.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VINTOREZNIMBLE.ReloadEmpty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VINTOREZNIMBLE.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VINTOREZNIMBLE.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.533333,
	["anm_idle"] = 3.366667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.833333,
	["anm_reload"] = 2.96,
	["anm_reload_empty"] = 2.96,
	["anm_shots"] = 0.666667,
	["anm_shots_aim"] = 0.666667,
	["anm_show"] = 0.566667,
	["anm_show_first"] = 0.566667,
}

SWEP.AnomalyScopeZoom = 4

SWEP.AnomalyReticle = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_pso1"

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = true

SWEP.AnomalyAimFire = "anm_shots_aim"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.05

SWEP.DurabilityDamage = 0.005

SWEP.FireMoveMod = 0.6

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
			[1] = "cw_anomaly_ammo_9x39_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_ammo_9x39_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["ScopeZoom"] = 4,
		["IronFOV"] = 60,
	},
	["RunSightsAng"] = Vector(-13, 48, -12),
	["RunSightsPos"] = Vector(7, -7.3, 0),
	["MuzzleAttachmentSilenced"] = 2,
	["Primary"] = {
		["KickDown"] = 0.23,
		["HullSize"] = 0,
		["Range"] = 17850.0,
		["RPM"] = 774,
		["Ammo"] = "9x39MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.VINTOREZNIMBLE.FIRE_SILENCED",
		["RangeFalloff"] = 0.028011204481793,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.5,
		["Automatic"] = true,
		["Spread"] = 0.016,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.46,
		["Sound"] = "TFA_ANOMALY.VINTOREZNIMBLE.FIRE",
		["Damage"] = 32,
		["DefaultClip"] = 40,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 10,
		["IronAccuracy"] = 0.0016,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.23,
	},
	["WElements"] = {},
	["VElements"] = {},
	["IronSightsAng"] = Vector(0, 0, 0),
	["Silenced"] = true,
	["IronSightsPos"] = Vector(-4.321, -2, 1.1545),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_vintorez_nimble_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 4.5638, -2.9088)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_vintorez_nimble")
	killicon.Add("cw_anomaly_vintorez_nimble", "vgui/killicons/tfa_anomaly_vintorez_nimble", Color(255, 255, 255))
end
