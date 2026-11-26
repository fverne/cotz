-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "PP-19 “Bison”"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/bizon.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_bizon_w.mdl"

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
	["ClipSize"] = 64,
	["DefaultClip"] = 256,
	["Automatic"] = true,
	["Ammo"] = "9x18MM",
}

SWEP.FireDelay = 0.08823529411764706

SWEP.FireSound = "TFA_ANOMALY.BIZON.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.BIZON.FIRE_SILENCED"

SWEP.Damage = 49

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.075

SWEP.AimSpread = 0.02

SWEP.Recoil = 1.2

SWEP.SpreadPerShot = 0.009

SWEP.MaxSpreadInc = 0.05

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 3

SWEP.SpeedDec = 10

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 4.233333

SWEP.ReloadTime_Empty = 4.233333

SWEP.ReloadHalt = 4.233333

SWEP.ReloadHalt_Empty = 4.233333

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-5.113, -2, 1.505)

SWEP.IronsightAng = Vector(1.1, -1.1, -1)

SWEP.SprintPos = Vector(5.5, -7.2, 0.5)

SWEP.SprintAng = Vector(-13, 49, -10)

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
			["sound"] = "TFA_ANOMALY.BIZON.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BIZON.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BIZON.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BIZON.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BIZON.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.5,
	["anm_idle"] = 6.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_reload"] = 4.233333,
	["anm_reload_empty"] = 4.233333,
	["anm_shots"] = 0.433333,
	["anm_shots_aim"] = 0.433333,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
}

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

SWEP.Attachments = {
	[1] = {
		["header"] = "Attachments",
		["offset"] = {
			[1] = 300,
			[2] = -400,
		},
		["atts"] = {
			[1] = "cw_anomaly_sil_pbs1",
		},
	},
	[2] = {
		["header"] = "Attachments",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_kobra",
			[2] = "cw_anomaly_pso1",
			[3] = "cw_anomaly_1p29",
		},
	},
	[3] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -100,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_9x18_pmm",
			[2] = "cw_anomaly_ammo_9x18_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sil_pbs1",
	[2] = "cw_anomaly_kobra",
	[3] = "cw_anomaly_pso1",
	[4] = "cw_anomaly_1p29",
	[5] = "cw_anomaly_ammo_9x18_pmm",
	[6] = "cw_anomaly_ammo_9x18_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_1P29"] = 60,
		["IronFOV_PSO1"] = 60,
		["IronFOV_Kobra"] = 70,
		["IronFOV"] = 70,
	},
	["Primary"] = {
		["KickDown"] = 0.225,
		["HullSize"] = 0,
		["Range"] = 8925.0,
		["RPM"] = 680,
		["Ammo"] = "9x18MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.BIZON.FIRE_SILENCED",
		["RangeFalloff"] = 0.035854341736695,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.53,
		["Automatic"] = true,
		["Spread"] = 0.057,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.43,
		["Sound"] = "TFA_ANOMALY.BIZON.FIRE",
		["Damage"] = 23,
		["DefaultClip"] = 256,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 64,
		["IronAccuracy"] = 0.0057,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.225,
	},
	["RunSightsAng"] = Vector(-13, 49, -10),
	["IronSightsAng_1P29"] = Vector(0, 0, 0),
	["Silenced"] = false,
	["IronSightsAng_PSO1"] = Vector(0, 0, 0),
	["IronSightTime"] = 0.46,
	["IronSightsPos_Kobra"] = Vector(-4.671, -3, 0.635),
	["IronSightsPos_1P29"] = Vector(-4.7485, -6, 1.074),
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {
		["anomaly_sil_pbs1"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/sil_pbs_w.mdl",
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
			["pos"] = Vector(-0.08, 1.9, 7.2),
		},
		["sight_anomaly_kobra"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_9a91_kobra.mdl",
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
			["pos"] = Vector(0.2, 6.4, 1.55),
		},
		["scope_anomaly_1p29"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_9a91_1p29.mdl",
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
			["pos"] = Vector(0.2, 6.75, 0.7),
		},
		["scope_anomaly_pso1"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_9a91_pso1.mdl",
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
			["pos"] = Vector(0.2, 6.75, 2.1),
		},
	},
	["VElements"] = {
		["scope_anomaly_1p29"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_9a91_1p29_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.2, -0.4, 0.4),
		},
		["scope_anomaly_pso1"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_9a91_pso1_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.2, -0.3, 2.3),
		},
		["sight_anomaly_kobra"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_9a91_kobra_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.2, -0.8, 1.3),
		},
		["sight_anomaly_kobra_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_9a91_kobra_lense_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.2, -0.8, 1.3),
		},
		["anomaly_sil_pbs1"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/sil_pbs.mdl",
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
			["pos"] = Vector(0, 0.07, 7.2),
		},
	},
	["IronSightsPos_PSO1"] = Vector(-4.33, -3, 1.3365),
	["RunSightsPos"] = Vector(5.5, -7.2, 0.5),
	["IronSightsAng"] = Vector(1.1, -1.1, -1),
	["IronSightsAng_Kobra"] = Vector(0, 0, 0),
	["IronSightsPos"] = Vector(-5.113, -2, 1.505),
}

SWEP.AnomalySightReticles = {
	["scope_anomaly_1p29"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_1p29",
	["scope_anomaly_pso1"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_pso1",
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_bizon_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.3, 5.5152, -5.8028)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_bizon")
	killicon.Add("cw_anomaly_bizon", "vgui/killicons/tfa_anomaly_bizon", Color(255, 255, 255))
end
