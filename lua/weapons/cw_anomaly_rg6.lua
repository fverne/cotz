-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "RG-6"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/rg6.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_rg6_w.mdl"

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
	["ClipSize"] = 6,
	["DefaultClip"] = 24,
	["Automatic"] = false,
	["Ammo"] = "40MM",
}

SWEP.FireDelay = 0.5217391304347826

SWEP.FireSound = "TFA_ANOMALY.RG6.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.RG6.FIRE"

SWEP.Damage = 150

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.036

SWEP.AimSpread = 0.036

SWEP.Recoil = 0.25

SWEP.SpreadPerShot = 0.018

SWEP.MaxSpreadInc = 0.018

SWEP.SpreadCooldown = 0.25

SWEP.VelocitySensitivity = 0

SWEP.SpeedDec = 0

SWEP.ClumpSpread = 0.036

SWEP.DeployTime = 0.666667

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 2.0

SWEP.ReloadTime_Empty = 1

SWEP.ReloadHalt = 2.0

SWEP.ReloadHalt_Empty = 1

SWEP.ShotgunReload = true

SWEP.ReloadStartTime = 2.0

SWEP.InsertShellTime = 1.666667

SWEP.ReloadFinishWait = 2.333333

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = false

SWEP.IronsightPos = Vector(-4.5, 3, -3)

SWEP.IronsightAng = Vector(10, 0, 0)

SWEP.SprintPos = Vector(6.8, -7.2, 0.5)

SWEP.SprintAng = Vector(-11, 50, -10.5)

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
			["sound"] = "TFA_ANOMALY.RG6.Holster",
		},
	},
	["anm_open"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RG6.ReloadStart",
		},
	},
	["anm_add_cartridge"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RG6.ReloadInsert",
		},
	},
	["anm_close"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RG6.ReloadEnd",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RG6.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RG6.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.5,
	["anm_idle"] = 20.0,
	["anm_idle_aim"] = 0.2,
	["anm_idle_sprint"] = 2.5,
	["anm_open"] = 2.0,
	["anm_add_cartridge"] = 1.666667,
	["anm_close"] = 2.333333,
	["anm_shots"] = 0.666667,
	["anm_show"] = 0.666667,
	["anm_show_first"] = 0.666667,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots"

SWEP.AnomalyProjectile = "anomaly_rg6_rocket"

SWEP.AnomalyProjectileVelocity = 15485.572666667

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.05

SWEP.DurabilityDamageChance = 0.005

SWEP.WearEffect = 0.007

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
		["RPM"] = 115,
		["Ammo"] = "40MM",
		["AmmoConsumption"] = 1,
		["Knockback"] = 0,
		["Automatic"] = false,
		["KickHorizontal"] = 0.5,
		["Spread"] = 0.036,
		["Sound"] = "TFA_ANOMALY.RG6.FIRE",
		["StaticRecoilFactor"] = 3.02,
		["IronAccuracy"] = 0.036,
		["Damage"] = 150,
		["ClipSize"] = 6,
		["DefaultClip"] = 24,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["RunSightsAng"] = Vector(-11, 50, -10.5),
	["IronSightsAng"] = Vector(10, 0, 0),
	["WElements"] = {},
	["RunSightsPos"] = Vector(6.8, -7.2, 0.5),
	["IronSightsPos"] = Vector(-4.5, 3, -3),
	["IronSightTime"] = 0.46,
	["VElements"] = {},
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_rg6_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.3, 4.3596, -4.0956)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_rg6")
	killicon.Add("cw_anomaly_rg6", "vgui/killicons/tfa_anomaly_rg6", Color(255, 255, 255))
end
