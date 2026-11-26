-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "HK MP7"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/mp7.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_mp7_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 2

SWEP.SlotPos = 73

SWEP.NormalHoldType = "smg"

SWEP.RunHoldType = "passive"

SWEP.FireModes = {
	[1] = "auto",
	[2] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 40,
	["DefaultClip"] = 160,
	["Automatic"] = true,
	["Ammo"] = "9x19MM",
}

SWEP.FireDelay = 0.06315789473684211

SWEP.FireSound = "TFA_ANOMALY.MP7.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.MP7.FIRE_SILENCED"

SWEP.Damage = 54

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.065

SWEP.AimSpread = 0.015

SWEP.Recoil = 1.1

SWEP.SpreadPerShot = 0.007

SWEP.MaxSpreadInc = 0.07

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 1

SWEP.SpeedDec = 0

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.7

SWEP.ReloadTime_Empty = 3.7

SWEP.ReloadHalt = 3.7

SWEP.ReloadHalt_Empty = 3.7

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.236, 1, 1.57)

SWEP.IronsightAng = Vector(0.143, 0.1, 0)

SWEP.SprintPos = Vector(7, -6, 0.4)

SWEP.SprintAng = Vector(-13.3, 50, -10)

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
			["sound"] = "TFA_ANOMALY.MP7.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP7.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP7.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP7.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP7.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.5,
	["anm_idle"] = 6.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_reload"] = 3.7,
	["anm_reload_empty"] = 3.7,
	["anm_shots"] = 0.2,
	["anm_shots_aim"] = 0.2,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots_aim"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.05

SWEP.DurabilityDamage = 0.005

SWEP.WearEffect = 0.007

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
			[1] = "cw_anomaly_sil_9p",
		},
	},
	[2] = {
		["header"] = "Attachments",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_ac10632",
			[2] = "cw_anomaly_acog",
			[3] = "cw_anomaly_eotech",
			[4] = "cw_anomaly_cmore",
		},
	},
	[3] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -100,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_9x19_pbp",
			[2] = "cw_anomaly_ammo_9x19_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sil_9p",
	[2] = "cw_anomaly_ac10632",
	[3] = "cw_anomaly_acog",
	[4] = "cw_anomaly_eotech",
	[5] = "cw_anomaly_cmore",
	[6] = "cw_anomaly_ammo_9x19_pbp",
	[7] = "cw_anomaly_ammo_9x19_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_Eotech"] = 70,
		["IronFOV"] = 70,
		["IronFOV_AC10632"] = 70,
		["IronFOV_ACOG"] = 40,
		["IronFOV_Cmore"] = 70,
	},
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 11900.0,
		["RPM"] = 950,
		["Ammo"] = "9x19MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.MP7.FIRE_SILENCED",
		["RangeFalloff"] = 0.033613445378151,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.8,
		["Automatic"] = true,
		["Spread"] = 0.024,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.MP7.FIRE",
		["Damage"] = 24,
		["DefaultClip"] = 160,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 40,
		["IronAccuracy"] = 0.0024,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {
		["sight_anomaly_ac10632"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_ac10632_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-94, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.9, 0.9, 0.9),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 2.43, 5.5),
		},
		["ironsight_anomaly_mp7_on"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_mp7_sight_on.mdl",
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
			["active"] = true,
			["skin"] = 0,
			["pos"] = Vector(-0.3855, -1.198, -0.2),
		},
		["scope_anomaly_acog"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_acog_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-94, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.2, 1.2, 1.2),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 3.15, 7.7),
		},
		["sight_anomaly_eotech"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_eot_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-94, 90, 0),
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
			["pos"] = Vector(0, 2.75, 5),
		},
		["sight_anomaly_cmore"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_ash12_c-more.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-94, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.9, 0.9, 0.9),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 9.4, 3),
		},
		["anomaly_sil_9p"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_sil_mp7.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 0, 0),
		},
	},
	["VElements"] = {
		["sight_anomaly_ac10632_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_ac10632_lense_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.9, 0.9, 0.9),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.005, -0.35, 4.5),
		},
		["sight_anomaly_cmore"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ash12_c-more.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.9, 0.9, 0.9),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.02, 2.4, 1),
		},
		["ironsight_anomaly_mp7_off"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_mp7_sight_off_hud.mdl",
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
			["pos"] = Vector(-0.3855, -1.198, -0.2),
		},
		["sight_anomaly_ac10632"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_ac10632_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.9, 0.9, 0.9),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.005, -0.35, 4.5),
		},
		["ironsight_anomaly_mp7_on"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_mp7_sight_on_hud.mdl",
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
			["active"] = true,
			["skin"] = 0,
			["pos"] = Vector(-0.3855, -1.198, -0.2),
		},
		["scope_anomaly_acog"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_acog_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.25, 1.25, 1.25),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_scope",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.005, 0.8, 7.1),
		},
		["sight_anomaly_cmore_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ash12_c-more_lense.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.9, 0.9, 0.9),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.02, 2.4, 1),
		},
		["sight_anomaly_eotech_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_eot_lense_hud.mdl",
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
			["pos"] = Vector(-0.02, 0, 3.4),
		},
		["sight_anomaly_eotech"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_eot_hud.mdl",
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
			["pos"] = Vector(-0.02, 0, 3.4),
		},
		["anomaly_sil_9p"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_mp7_sil_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "wpb_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.04, -0.4, -4.75),
		},
	},
	["IronSightsPos_AC10632"] = Vector(-4.26, 0, 1.94),
	["RunSightsAng"] = Vector(-13.3, 50, -10),
	["RunSightsPos"] = Vector(7, -6, 0.4),
	["IronSightsAng_AC10632"] = Vector(0.143, 0.1, 0),
	["IronSightsPos_ACOG"] = Vector(-4.238, 15, 1.591),
	["IronSightsAng_Cmore"] = Vector(0.143, 0.1, 0),
	["IronSightsPos_Eotech"] = Vector(-4.256, 0, 1.558),
	["IronSightsPos_Cmore"] = Vector(-4.26, 0, 1.87),
	["Silenced"] = false,
	["IronSightsAng"] = Vector(0.143, 0.1, 0),
	["IronSightsAng_ACOG"] = Vector(0.143, 0.1, 0),
	["IronSightsAng_Eotech"] = Vector(0.143, 0.1, 0),
	["IronSightsPos"] = Vector(-4.236, 1, 1.57),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_mp7_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 5.2475, -4.2736)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "smg"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_mp7")
	killicon.Add("cw_anomaly_mp7", "vgui/killicons/tfa_anomaly_mp7", Color(255, 255, 255))
end
