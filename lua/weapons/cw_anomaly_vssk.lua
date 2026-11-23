-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "VSSK “Vykhlop”"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/vssk.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_vssk_w.mdl"

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
	["ClipSize"] = 5,
	["DefaultClip"] = 20,
	["Automatic"] = false,
	["Ammo"] = "12.7x55mm",
}

SWEP.FireDelay = 2.0

SWEP.FireSound = "TFA_ANOMALY.VSSK.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.VSSK.FIRE_SILENCED"

SWEP.Damage = 650

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.015

SWEP.AimSpread = 0.005

SWEP.Recoil = 2.8

SWEP.SpreadPerShot = 0.007

SWEP.MaxSpreadInc = 0.4

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 12

SWEP.SpeedDec = 35

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.633333

SWEP.ReloadTime_Empty = 3.633333

SWEP.ReloadHalt = 3.633333

SWEP.ReloadHalt_Empty = 3.633333

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.505, -5, 2.104)

SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.SprintPos = Vector(8, -6.7, 0)

SWEP.SprintAng = Vector(-12.5, 50, -12)

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
			["sound"] = "TFA_ANOMALY.VSSK.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VSSK.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VSSK.Reload",
		},
	},
	["anm_shots"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VSSK.Bolt",
		},
	},
	["anm_shots_aim"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VSSK.Bolt",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VSSK.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VSSK.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 1.033333,
	["anm_idle"] = 6.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_reload"] = 3.633333,
	["anm_reload_empty"] = 3.633333,
	["anm_shots"] = 1.6,
	["anm_shots_aim"] = 1.6,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
}

SWEP.AnomalyScopeZoom = 10

SWEP.AnomalyReticle = "models/flaymi/stalker/anomaly/weapons/vssk/wpn_crosshair_nspu"

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = true

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
			[1] = "cw_anomaly_ammo_127x55_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_ammo_127x55_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["ScopeZoom"] = 10,
		["IronFOV"] = 60,
	},
	["RunSightsAng"] = Vector(-12.5, 50, -12),
	["RunSightsPos"] = Vector(8, -6.7, 0),
	["MuzzleAttachmentSilenced"] = 2,
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 29750.0,
		["RPM"] = 30,
		["Ammo"] = "12.7x55mm",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.VSSK.FIRE_SILENCED",
		["RangeFalloff"] = 0.025210084033613,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 3.08,
		["Automatic"] = false,
		["Spread"] = 0.0398,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.VSSK.FIRE",
		["Damage"] = 112.5,
		["DefaultClip"] = 20,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 5,
		["IronAccuracy"] = 0.00098,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {},
	["VElements"] = {},
	["IronSightsAng"] = Vector(0, 0, 0),
	["Silenced"] = true,
	["IronSightsPos"] = Vector(-4.505, -5, 2.104),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_vssk_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 4.732, -4.4293)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_vssk")
	killicon.Add("cw_anomaly_vssk", "vgui/killicons/tfa_anomaly_vssk", Color(255, 255, 255))
end
