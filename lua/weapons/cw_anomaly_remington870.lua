-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Remington 870"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/remington870.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_remington870_w.mdl"

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
	["ClipSize"] = 8,
	["DefaultClip"] = 32,
	["Automatic"] = false,
	["Ammo"] = "12 Gauge",
}

SWEP.FireDelay = 1.3333333333333333

SWEP.FireSound = "TFA_ANOMALY.REMINGTON870.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.REMINGTON870.FIRE"

SWEP.Damage = 38

SWEP.Shots = 9

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.06

SWEP.AimSpread = 0.005

SWEP.Recoil = 3.0

SWEP.SpreadPerShot = 0.2

SWEP.MaxSpreadInc = 0.4

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 0.5

SWEP.SpeedDec = 20

SWEP.ClumpSpread = 0.018

SWEP.DeployTime = 0.7

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 0.6

SWEP.ReloadTime_Empty = 1

SWEP.ReloadHalt = 0.6

SWEP.ReloadHalt_Empty = 1

SWEP.ShotgunReload = true

SWEP.ReloadStartTime = 0.6

SWEP.InsertShellTime = 0.833333

SWEP.ReloadFinishWait = 1.233333

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = false

SWEP.IronsightPos = Vector(-4.482, 1, 3.385)

SWEP.IronsightAng = Vector(-3.7, -1.093, 0)

SWEP.SprintPos = Vector(7.6, -7.8, 1.1)

SWEP.SprintAng = Vector(-21, 50, -17)

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
			["sound"] = "TFA_ANOMALY.REMINGTON870.Holster",
		},
	},
	["anm_add_cartridge"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.REMINGTON870.ReloadInsert",
		},
	},
	["anm_close"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.REMINGTON870.ReloadEnd",
		},
	},
	["anm_shots"] = {
		[1] = {
			["time"] = 0.133333,
			["sound"] = "TFA_ANOMALY.REMINGTON870.Pump",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.REMINGTON870.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.REMINGTON870.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.7,
	["anm_idle"] = 6.7,
	["anm_idle_aim"] = 0.066667,
	["anm_idle_sprint"] = 0.766667,
	["anm_open"] = 0.6,
	["anm_add_cartridge"] = 0.833333,
	["anm_close"] = 1.233333,
	["anm_shots"] = 1.633333,
	["anm_show"] = 0.7,
	["anm_show_first"] = 0.7,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0

SWEP.DurabilityDamageChance = 0.01

SWEP.MuzzleAttachmentName = "muzzle"

SWEP.MuzzleEffect = "muzzleflash_ak74"

SWEP.Shell = false

SWEP.AttachmentModelsVM = {}

SWEP.Attachments = {
	[1] = {
		["header"] = "Attachments",
		["offset"] = {
			[1] = 300,
			[2] = -400,
		},
		["atts"] = {
			[1] = "cw_anomaly_eotech",
			[2] = "cw_anomaly_cmore",
			[3] = "cw_anomaly_barska",
		},
	},
	[2] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_12x76_zhekan",
			[2] = "cw_anomaly_ammo_12x76_dart",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_eotech",
	[2] = "cw_anomaly_cmore",
	[3] = "cw_anomaly_barska",
	[4] = "cw_anomaly_ammo_12x76_zhekan",
	[5] = "cw_anomaly_ammo_12x76_dart",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_Barska"] = 70,
		["IronFOV_Cmore"] = 70,
		["IronFOV_Eotech"] = 70,
		["IronFOV"] = 70,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {
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
			["pos"] = Vector(0, 2.65, -0.8),
		},
		["sight_anomaly_barska"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_aug_a3_barska_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.8, 0.8, 0.8),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 1.65, -5.5),
		},
		["sight_anomaly_cmore"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_ash12_c-more.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.8, 0.8, 0.8),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 7.58, -4.15),
		},
		["anomaly_ironsight_remington870"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_remington870_ironsight_w.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(0, 0, 0),
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
			["pos"] = Vector(0, 0, 0),
		},
	},
	["Primary"] = {
		["KickDown"] = 0.3,
		["HullSize"] = 0,
		["Range"] = 8925.0,
		["RPM"] = 45,
		["Ammo"] = "12 Gauge",
		["AmmoConsumption"] = 1,
		["NumShots"] = 9,
		["RangeFalloff"] = 0.036974789915966,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 2.0,
		["Automatic"] = false,
		["Spread"] = 0.0454,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.6,
		["Sound"] = "TFA_ANOMALY.REMINGTON870.FIRE",
		["Damage"] = 13.166666666667,
		["DefaultClip"] = 32,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 8,
		["IronAccuracy"] = 0.0424,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.3,
	},
	["VElements"] = {
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
			["pos"] = Vector(0, 0.2, -1.3),
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
			["pos"] = Vector(0, 0.2, -1.3),
		},
		["anomaly_ironsight_remington870"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_remington870_ironsight_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(0, 0, 0),
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
			["pos"] = Vector(0, 0, 0),
		},
		["sight_anomaly_cmore_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ash12_c-more_lense.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.8, 0.8, 0.8),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 1.85, -5),
		},
		["sight_anomaly_barska_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_aug_a3_barska_lense_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.8, 0.8, 0.8),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, -0.5, -6.1),
		},
		["sight_anomaly_cmore"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ash12_c-more.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.8, 0.8, 0.8),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 1.85, -5),
		},
		["sight_anomaly_barska"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_aug_a3_barska_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.8, 0.8, 0.8),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, -0.5, -6.1),
		},
	},
	["IronSightsAng_Barska"] = Vector(-3.7, -1.093, 0),
	["RunSightsAng"] = Vector(-21, 50, -17),
	["IronSightsPos_Eotech"] = Vector(-4.508, 1, 2.22),
	["IronSightsPos_Barska"] = Vector(-4.515, 1, 2.725),
	["Silenced"] = false,
	["IronSightsAng_Cmore"] = Vector(-3.7, -1.093, 0),
	["IronSightsAng"] = Vector(-3.7, -1.093, 0),
	["IronSightsPos_Cmore"] = Vector(-4.515, 1, 2.588),
	["IronSightsAng_Eotech"] = Vector(-3.7, -1.093, 0),
	["IronSightsPos"] = Vector(-4.482, 1, 3.385),
	["RunSightsPos"] = Vector(7.6, -7.8, 1.1),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_remington870_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 4.0222, -3.3634)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_remington870")
	killicon.Add("cw_anomaly_remington870", "vgui/killicons/tfa_anomaly_remington870", Color(255, 255, 255))
end
