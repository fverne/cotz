-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "SVT-40"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/svt40.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_svt40_w.mdl"

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

SWEP.FireDelay = 0.4

SWEP.FireSound = "TFA_ANOMALY.SVT.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.SVT.FIRE"

SWEP.Damage = 140

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.15

SWEP.AimSpread = 0.005

SWEP.Recoil = 2.5

SWEP.SpreadPerShot = 0.033

SWEP.MaxSpreadInc = 0.1

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 7

SWEP.SpeedDec = 25

SWEP.DeployTime = 1.066667

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 5.733333

SWEP.ReloadTime_Empty = 5.733333

SWEP.ReloadHalt = 5.733333

SWEP.ReloadHalt_Empty = 5.733333

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-3.972, -3, 3.158)

SWEP.IronsightAng = Vector(0.1, 0, 0)

SWEP.SprintPos = Vector(7, -7.5, 0.1)

SWEP.SprintAng = Vector(-13, 49.5, -13)

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
			["sound"] = "TFA_ANOMALY.SVT.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVT.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVT.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVT.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVT.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.9,
	["anm_idle"] = 6.733333,
	["anm_idle_aim"] = 0.1,
	["anm_idle_sprint"] = 1.133333,
	["anm_reload"] = 5.733333,
	["anm_reload_empty"] = 5.733333,
	["anm_shots"] = 0.466667,
	["anm_shots_aim"] = 0.466667,
	["anm_show"] = 1.066667,
	["anm_show_first"] = 1.066667,
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
		["header"] = "Attachments",
		["offset"] = {
			[1] = 300,
			[2] = -400,
		},
		["atts"] = {
			[1] = "cw_anomaly_mosin",
		},
	},
	[2] = {
		["header"] = "Finish",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_svt_sk1",
		},
	},
	[3] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -100,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_762x54_ap",
			[2] = "cw_anomaly_ammo_762x54_7h14",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_mosin",
	[2] = "cw_anomaly_svt_sk1",
	[3] = "cw_anomaly_ammo_762x54_ap",
	[4] = "cw_anomaly_ammo_762x54_7h14",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_MOSINSCOPE"] = 55,
		["IronFOV"] = 70,
	},
	["IronSightsAng_MOSINSCOPE"] = Vector(0, 0, -1),
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {
		["scope_anomaly_mosinscope"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_svt40_scope_pu.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.01, 5.15, 8.4),
		},
	},
	["VElements"] = {
		["scope_anomaly_mosinscope"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_svt40_scope_pu_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-6.8, 1.4, 22),
		},
	},
	["IronSightsPos_MOSINSCOPE"] = Vector(-3.972, -4, 2.1755),
	["RunSightsAng"] = Vector(-13, 49.5, -13),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 29750.0,
		["RPM"] = 150,
		["Ammo"] = "7.62x54MMR",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.027899159663866,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 1.98,
		["Automatic"] = false,
		["Spread"] = 0.0105,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.SVT.FIRE",
		["Damage"] = 38.5,
		["DefaultClip"] = 40,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 10,
		["IronAccuracy"] = 0.00105,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["Silenced"] = false,
	["IronSightsAng"] = Vector(0.1, 0, 0),
	["IronSightsPos"] = Vector(-3.972, -3, 3.158),
	["RunSightsPos"] = Vector(7, -7.5, 0.1),
	["IronSightTime"] = 0.46,
}

SWEP.AnomalySightReticles = {
	["scope_anomaly_mosinscope"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_pu",
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_svt40_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.118, -2.2675)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_svt")
	killicon.Add("cw_anomaly_svt", "vgui/killicons/tfa_anomaly_svt", Color(255, 255, 255))
end
