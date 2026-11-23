-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "M24 SWS “Green Dragon”"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/m24.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_m24_w.mdl"

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
	["Ammo"] = ".338 Lapua",
}

SWEP.FireDelay = 3.0

SWEP.FireSound = "TFA_ANOMALY.M24.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.M24.FIRE"

SWEP.Damage = 450

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.12

SWEP.AimSpread = 0.005

SWEP.Recoil = 4.6

SWEP.SpreadPerShot = 0.1

SWEP.MaxSpreadInc = 0.4

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 15

SWEP.SpeedDec = 30

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 4.033333

SWEP.ReloadTime_Empty = 4.033333

SWEP.ReloadHalt = 4.033333

SWEP.ReloadHalt_Empty = 4.033333

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.81, -7, 0.7905)

SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.SprintPos = Vector(8, -7, 0.8)

SWEP.SprintAng = Vector(-18, 50, -13)

SWEP.ZoomAmount = 30

SWEP.AimViewModelFOV = 55

SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_reload",
	["anm_hide"] = "anm_hide",
	["anm_idle"] = "anm_idle",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_reload"] = "anm_reload",
	["anm_shots"] = "anm_shots",
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
}

SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M24.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M24.Reload",
		},
	},
	["anm_shots"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M24.Bolt",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M24.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M24.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.5,
	["anm_idle"] = 6.7,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.833333,
	["anm_reload"] = 4.033333,
	["anm_shots"] = 2.766667,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
}

SWEP.AnomalyScopeZoom = 4

SWEP.AnomalyReticle = "models/flaymi/stalker/anomaly/weapons/l96/wpn_crosshair_mark4"

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.33

SWEP.DurabilityDamageChance = 0.01

SWEP.FireMoveMod = 0.6

SWEP.WearEffect = 0.005

SWEP.MuzzleAttachmentName = "muzzle"

SWEP.MuzzleEffect = "muzzleflash_ak74"

SWEP.Shell = false

SWEP.AttachmentModelsVM = {}

SWEP.Attachments = {}

SWEP.AnomalyAttachmentOrder = {}

SWEP.AnomalySource = {
	["Secondary"] = {
		["ScopeZoom"] = 4,
		["IronFOV"] = 60,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["RunSightsAng"] = Vector(-18, 50, -13),
	["RunSightsPos"] = Vector(8, -7, 0.8),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 44625.0,
		["RPM"] = 20,
		["Ammo"] = ".338 Lapua",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.018935574229692,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 3.14,
		["Automatic"] = false,
		["Spread"] = 0.054,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.M24.FIRE",
		["Damage"] = 68,
		["DefaultClip"] = 20,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 5,
		["IronAccuracy"] = 0.00054,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {},
	["VElements"] = {},
	["IronSightsAng"] = Vector(0, 0, 0),
	["Silenced"] = false,
	["IronSightsPos"] = Vector(-4.81, -7, 0.7905),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_m24_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 3.7669, -2.8391)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_m24")
	killicon.Add("cw_anomaly_m24", "vgui/killicons/tfa_anomaly_m24", Color(255, 255, 255))
end
