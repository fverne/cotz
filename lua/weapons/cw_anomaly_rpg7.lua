-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "RPG-7"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/rpg7.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_rpg7_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 4

SWEP.SlotPos = 73

SWEP.NormalHoldType = "rpg"

SWEP.RunHoldType = "passive"

SWEP.FireModes = {
	[1] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 1,
	["DefaultClip"] = 5,
	["Automatic"] = false,
	["Ammo"] = "",
}

SWEP.FireDelay = 0.3

SWEP.FireSound = "TFA_ANOMALY.RPG7.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.RPG7.FIRE"

SWEP.Damage = 100

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.033

SWEP.AimSpread = 0.033

SWEP.Recoil = 0.25

SWEP.SpreadPerShot = 0.0165

SWEP.MaxSpreadInc = 0.0165

SWEP.SpreadCooldown = 0.25

SWEP.VelocitySensitivity = 0

SWEP.SpeedDec = 0

SWEP.ClumpSpread = 0.033

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.333333

SWEP.ReloadTime_Empty = 3.333333

SWEP.ReloadHalt = 3.333333

SWEP.ReloadHalt_Empty = 3.333333

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = false

SWEP.IronsightPos = Vector(-4.97, 1, -1.202)

SWEP.IronsightAng = Vector(1.9, 0, 0)

SWEP.SprintPos = Vector(5.8, -6.1, 0.2)

SWEP.SprintAng = Vector(-14, 50, -10)

SWEP.ZoomAmount = 20

SWEP.AimViewModelFOV = 55

SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_reload",
	["anm_hide"] = "anm_hide",
	["anm_hide_empty"] = "anm_hide_empty",
	["anm_idle"] = "anm_idle",
	["anm_idle_empty"] = "anm_idle_empty",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_aim_empty"] = "anm_idle_aim_empty",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_empty"] = "anm_idle_sprint_empty",
	["anm_reload"] = "anm_reload",
	["anm_shots"] = "anm_shots",
	["anm_show"] = "anm_show",
	["anm_show_empty"] = "anm_show_empty",
	["anm_show_first"] = "anm_show_first",
}

SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPG7.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPG7.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPG7.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPG7.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPG7.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPG7.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.833333,
	["anm_hide_empty"] = 0.833333,
	["anm_idle"] = 12.666667,
	["anm_idle_empty"] = 12.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_aim_empty"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_idle_sprint_empty"] = 0.8,
	["anm_reload"] = 3.333333,
	["anm_shots"] = 0.666667,
	["anm_show"] = 1.033333,
	["anm_show_empty"] = 1.033333,
	["anm_show_first"] = 1.033333,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots"

SWEP.AnomalyProjectile = "anomaly_rpg7_rocket"

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
		["Knockback"] = 0,
		["KickDown"] = 0.25,
		["Automatic"] = false,
		["IronAccuracy"] = 0.033,
		["Ammo"] = "",
		["RPM"] = 200,
		["Sound"] = "TFA_ANOMALY.RPG7.FIRE",
		["KickHorizontal"] = 0.55,
		["DefaultClip"] = 5,
		["Damage"] = 100,
		["ClipSize"] = 1,
		["Spread"] = 0.033,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {},
	["RunSightsAng"] = Vector(-14, 50, -10),
	["RunSightsPos"] = Vector(5.8, -6.1, 0.2),
	["IronSightsAng"] = Vector(1.9, 0, 0),
	["IronSightsPos"] = Vector(-4.97, 1, -1.202),
	["IronSightTime"] = 0.46,
	["VElements"] = {},
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_rpg7_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.3, -1.1892, -4.4132)

SWEP.WMAng = Vector(-5, 0, 180)

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_rpg7")
	killicon.Add("cw_anomaly_rpg7", "vgui/killicons/tfa_anomaly_rpg7", Color(255, 255, 255))
end

SWEP.AnomalyAmmoUnavailable = true
