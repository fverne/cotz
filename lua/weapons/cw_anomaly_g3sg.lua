-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "G3A3"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/g3.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_g3_w.mdl"

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
	["ClipSize"] = 20,
	["DefaultClip"] = 80,
	["Automatic"] = true,
	["Ammo"] = "7.62x51MM",
}

SWEP.FireDelay = 0.1

SWEP.FireSound = "TFA_ANOMALY.G3SG.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.G3SG.FIRE_SILENCED"

SWEP.Damage = 135

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.13

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.7

SWEP.SpreadPerShot = 0.012

SWEP.MaxSpreadInc = 0.1

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 5

SWEP.SpeedDec = 30

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.066667

SWEP.ReloadTime_Empty = 3.066667

SWEP.ReloadHalt = 3.066667

SWEP.ReloadHalt_Empty = 3.066667

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-3.55, -1, 2.05)

SWEP.IronsightAng = Vector(0.15, 0.054, 0)

SWEP.SprintPos = Vector(6, -5.5, 0.1)

SWEP.SprintAng = Vector(-13, 48.5, -11)

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
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
}

SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G3SG.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G3SG.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G3SG.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G3SG.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G3SG.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.766667,
	["anm_idle"] = 6.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_reload"] = 3.066667,
	["anm_reload_empty"] = 3.066667,
	["anm_shots"] = 0.3,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0

SWEP.DurabilityDamage = 0.01

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
			[1] = "cw_anomaly_sil_nato",
		},
	},
	[2] = {
		["header"] = "Attachments",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_acog",
			[2] = "cw_anomaly_eotech",
			[3] = "cw_anomaly_ac10632",
		},
	},
	[3] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -100,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_762x51_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sil_nato",
	[2] = "cw_anomaly_acog",
	[3] = "cw_anomaly_eotech",
	[4] = "cw_anomaly_ac10632",
	[5] = "cw_anomaly_ammo_762x51_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_AC10632"] = 70,
		["IronFOV_ACOG"] = 40,
		["IronFOV_Eotech"] = 70,
		["IronFOV"] = 70,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {
		["sight_anomaly_ac10632"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_ac10632_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.1, 1.1, 1.1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 0.97, 5.7),
		},
		["g3sg_anomaly_rail"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_g3_mount_w.mdl",
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
			["pos"] = Vector(0, 0, 0),
		},
		["anomaly_sil_nato"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_sil_nato.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 1.55, -7),
		},
		["scope_anomaly_acog"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_acog_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.3, 1.3, 1.3),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.01, 1.6, 6.6),
		},
		["sight_anomaly_eotech"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_eot_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.05, 0.65, 4.5),
		},
	},
	["VElements"] = {
		["sight_anomaly_eotech_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_eot_lense_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.1, 1.1, 1.1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.01, -2.85, 3.1),
		},
		["g3sg_anomaly_rail"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_g3_mount.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 0, 0),
		},
		["anomaly_sil_nato"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_sil_nato.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, -2, -13),
		},
		["scope_anomaly_acog"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_acog_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.35, 1.35, 1.35),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.0295, -2.05, 5.4),
		},
		["sight_anomaly_ac10632_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_ac10632_lense_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.15, 1.15, 1.15),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, -2.73, 4.4),
		},
		["sight_anomaly_eotech"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_eot_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.1, 1.1, 1.1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.01, -2.85, 3.1),
		},
		["sight_anomaly_ac10632"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_ac10632_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.15, 1.15, 1.15),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, -2.73, 4.4),
		},
	},
	["IronSightsPos_AC10632"] = Vector(-3.58, 0, 0.24),
	["RunSightsAng"] = Vector(-13, 48.5, -11),
	["RunSightsPos"] = Vector(6, -5.5, 0.1),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 29750.0,
		["RPM"] = 600,
		["Ammo"] = "7.62x51MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.G3SG.FIRE_SILENCED",
		["RangeFalloff"] = 0.026823529411765,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 1.2,
		["Automatic"] = true,
		["Spread"] = 0.029,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.G3SG.FIRE",
		["Damage"] = 37.5,
		["DefaultClip"] = 80,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 20,
		["IronAccuracy"] = 0.0029,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["IronSightsAng_Eotech"] = Vector(0, 0, 0),
	["IronSightsAng_AC10632"] = Vector(0, 0, 0),
	["IronSightsPos_ACOG"] = Vector(-3.55, 20, 0.216),
	["IronSightsPos_Eotech"] = Vector(-3.593, -1, 0.103),
	["IronSightsAng"] = Vector(0.15, 0.054, 0),
	["Silenced"] = false,
	["IronSightsAng_ACOG"] = Vector(0, 0, 0),
	["IronSightsPos"] = Vector(-3.55, -1, 2.05),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_g3_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 4.7631, -2.9263)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_g3sg")
	killicon.Add("cw_anomaly_g3sg", "vgui/killicons/tfa_anomaly_g3sg", Color(255, 255, 255))
end
