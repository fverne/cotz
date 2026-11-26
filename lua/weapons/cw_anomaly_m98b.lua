-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Barrett M98B “Bravo”"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/m98b.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_m98b_w.mdl"

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
	["Ammo"] = ".338 Lapua",
}

SWEP.FireDelay = 3.0

SWEP.FireSound = "TFA_ANOMALY.M98B.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.M98B.FIRE"

SWEP.Damage = 450

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.08

SWEP.AimSpread = 0.003

SWEP.Recoil = 7.2

SWEP.SpreadPerShot = 0.007

SWEP.MaxSpreadInc = 0.9

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 18

SWEP.SpeedDec = 35

SWEP.DeployTime = 0.933333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 5.131579

SWEP.ReloadTime_Empty = 5.131579

SWEP.ReloadHalt = 5.131579

SWEP.ReloadHalt_Empty = 5.131579

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-3.7551, -5, 2.357)

SWEP.IronsightAng = Vector(0, 0, -0.1)

SWEP.SprintPos = Vector(7.5, -7, 0.3)

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
			["sound"] = "TFA_ANOMALY.M98B.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M98B.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M98B.Reload",
		},
	},
	["anm_shots"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M98B.Bolt",
		},
	},
	["anm_shots_aim"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M98B.Bolt",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M98B.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M98B.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.7,
	["anm_idle"] = 3.4,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.733333,
	["anm_reload"] = 5.131579,
	["anm_reload_empty"] = 5.131579,
	["anm_shots"] = 3.72,
	["anm_shots_aim"] = 3.72,
	["anm_show"] = 0.933333,
	["anm_show_first"] = 0.933333,
}

SWEP.AnomalyScopeZoom = 4

SWEP.AnomalyReticle = "models/flaymi/stalker/anomaly/weapons/m98b/wpn_crosshair_modern1"

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots_aim"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0

SWEP.DurabilityDamage = 0.01

SWEP.MuzzleAttachmentName = "muzzle"

SWEP.MuzzleEffect = "muzzleflash_ak74"

SWEP.Shell = "mainshell"

SWEP.AttachmentModelsVM = {}

SWEP.Attachments = {}

SWEP.AnomalyAttachmentOrder = {}

SWEP.AnomalySource = {
	["Secondary"] = {
		["ScopeZoom"] = 4,
		["IronFOV"] = 60,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["RunSightsAng"] = Vector(-12, 51, -11),
	["RunSightsPos"] = Vector(7.5, -7, 0.3),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 44625.0,
		["RPM"] = 20,
		["Ammo"] = ".338 Lapua",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.021176470588235,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 3.14,
		["Automatic"] = false,
		["Spread"] = 0.043,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.M98B.FIRE",
		["Damage"] = 67.5,
		["DefaultClip"] = 40,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 10,
		["IronAccuracy"] = 0.00043,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {},
	["VElements"] = {},
	["IronSightsAng"] = Vector(0, 0, -0.1),
	["Silenced"] = false,
	["IronSightsPos"] = Vector(-3.7551, -5, 2.357),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_m98b_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.2824, -2.6834)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_m98b")
	killicon.Add("cw_anomaly_m98b", "vgui/killicons/tfa_anomaly_m98b", Color(255, 255, 255))
end
