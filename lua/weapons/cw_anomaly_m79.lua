-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "M79"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/m79.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_m79_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 4

SWEP.SlotPos = 73

SWEP.NormalHoldType = "ar2"

SWEP.RunHoldType = "passive"

SWEP.FireModes = {
	[1] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 1,
	["DefaultClip"] = 4,
	["Automatic"] = false,
	["Ammo"] = "40MM",
}

SWEP.FireDelay = 0.3

SWEP.FireSound = "TFA_ANOMALY.M79.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.M79.FIRE"

SWEP.Damage = 150

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.076

SWEP.AimSpread = 0.076

SWEP.Recoil = 0.25

SWEP.SpreadPerShot = 0.038

SWEP.MaxSpreadInc = 0.038

SWEP.SpreadCooldown = 0.25

SWEP.VelocitySensitivity = 0

SWEP.SpeedDec = 0

SWEP.ClumpSpread = 0.076

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.433333

SWEP.ReloadTime_Empty = 3.433333

SWEP.ReloadHalt = 3.433333

SWEP.ReloadHalt_Empty = 3.433333

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = false

SWEP.IronsightPos = Vector(-4.8265, 3, -3.493)

SWEP.IronsightAng = Vector(9.15, 0, 0)

SWEP.SprintPos = Vector(7, -4.8, 0.7)

SWEP.SprintAng = Vector(-15, 50, -11)

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
	["anm_reload1"] = "anm_reload1",
	["anm_reload1_empty"] = "anm_reload1_empty",
	["anm_shots"] = "anm_shots",
	["anm_shots_aim"] = "anm_shots_aim",
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
}

SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M79.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M79.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M79.Reload",
		},
	},
	["anm_reload1"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M79.Reload",
		},
	},
	["anm_reload1_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M79.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M79.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M79.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.5,
	["anm_idle"] = 6.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_reload"] = 3.433333,
	["anm_reload_empty"] = 3.433333,
	["anm_reload1"] = 3.433333,
	["anm_reload1_empty"] = 3.433333,
	["anm_shots"] = 0.3,
	["anm_shots_aim"] = 0.3,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots_aim"

SWEP.AnomalyProjectile = "anomaly_40mm_rocket"

SWEP.AnomalyProjectileVelocity = 15485.572666667

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.33

SWEP.DurabilityDamageChance = 0.01

SWEP.WearEffect = 0.005

SWEP.MuzzleAttachmentName = "1"

SWEP.MuzzleEffect = "muzzleflash_ak74"

SWEP.Shell = false

SWEP.AttachmentModelsVM = {}

SWEP.Attachments = {}

SWEP.AnomalyAttachmentOrder = {}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV"] = 70,
	},
	["Primary"] = {
		["KickDown"] = 0.25,
		["RPM"] = 200,
		["Ammo"] = "40MM",
		["AmmoConsumption"] = 1,
		["Knockback"] = 0,
		["Automatic"] = false,
		["KickHorizontal"] = 0.5,
		["Spread"] = 0.076,
		["Sound"] = "TFA_ANOMALY.M79.FIRE",
		["StaticRecoilFactor"] = 3.02,
		["IronAccuracy"] = 0.076,
		["Damage"] = 150,
		["ClipSize"] = 1,
		["DefaultClip"] = 4,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["RunSightsAng"] = Vector(-15, 50, -11),
	["IronSightsAng"] = Vector(9.15, 0, 0),
	["WElements"] = {},
	["RunSightsPos"] = Vector(7, -4.8, 0.7),
	["IronSightsPos"] = Vector(-4.8265, 3, -3.493),
	["IronSightTime"] = 0.46,
	["VElements"] = {},
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_m79_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.3, 4.3596, -4.0956)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_m79")
	killicon.Add("cw_anomaly_m79", "vgui/killicons/tfa_anomaly_m79", Color(255, 255, 255))
end
