-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "OTs-03 SVU"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/svu.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_svu_w.mdl"

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

SWEP.FireDelay = 0.8571428571428571

SWEP.FireSound = "TFA_ANOMALY.SVU.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.SVU.FIRE_SILENCED"

SWEP.Damage = 200

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.17

SWEP.AimSpread = 0.0015

SWEP.Recoil = 2.8

SWEP.SpreadPerShot = 0.01

SWEP.MaxSpreadInc = 0.1

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 1.6

SWEP.SpeedDec = 30

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.566667

SWEP.ReloadTime_Empty = 5.5

SWEP.ReloadHalt = 3.566667

SWEP.ReloadHalt_Empty = 5.5

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.62, 2, 1.7715)

SWEP.IronsightAng = Vector(0.1, -0.7, 0)

SWEP.SprintPos = Vector(7, -8.5, 0.2)

SWEP.SprintAng = Vector(-13, 50.5, -13)

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
			["sound"] = "TFA_ANOMALY.SVU.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVU.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVU.ReloadEmpty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVU.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVU.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.8,
	["anm_idle"] = 6.633333,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_reload"] = 3.566667,
	["anm_reload_empty"] = 5.5,
	["anm_shots"] = 0.733333,
	["anm_shots_aim"] = 0.733333,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = true

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
			[1] = "cw_anomaly_kobra",
			[2] = "cw_anomaly_pso1",
			[3] = "cw_anomaly_1p29",
		},
	},
	[2] = {
		["header"] = "Finish",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_svu_sk1",
			[2] = "cw_anomaly_svu_sk_nimble",
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
	[1] = "cw_anomaly_kobra",
	[2] = "cw_anomaly_pso1",
	[3] = "cw_anomaly_1p29",
	[4] = "cw_anomaly_svu_sk1",
	[5] = "cw_anomaly_svu_sk_nimble",
	[6] = "cw_anomaly_ammo_762x54_ap",
	[7] = "cw_anomaly_ammo_762x54_7h14",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_1P29"] = 60,
		["IronFOV_PSO1"] = 60,
		["IronFOV_Kobra"] = 70,
		["IronFOV"] = 70,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {
		["scope_anomaly_1p29"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_9a91_1p29.mdl",
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
			["pos"] = Vector(0.07, 6.95, 1),
		},
		["anomaly_sil_kzrpz"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_addon_sil_kzrzp_w.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(0, 0, 0),
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
			["pos"] = Vector(0, 6.35, 2.6),
		},
		["ironsight_anomaly_svu_off"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_svu_sight_off_w.mdl",
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
			["pos"] = Vector(0, 5.15, 0),
		},
		["ironsight_anomaly_svu_on"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_svu_sight_on_w.mdl",
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
			["pos"] = Vector(0, 6.1, 2.7),
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
			["size"] = Vector(1.05, 1.05, 1.05),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.1, -0.75, 0.65),
		},
		["anomaly_sil_kzrpz"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_addon_sil_kzrzp.mdl",
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
			["pos"] = Vector(0, 0, 0),
		},
		["scope_anomaly_pso1"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_9a91_pso1_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.05, 1.05, 1.05),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.1, -0.8, 2.55),
		},
		["ironsight_anomaly_svu_off"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_svu_sight_off_hud.mdl",
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
		["ironsight_anomaly_svu_on"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_svu_sight_on_hud.mdl",
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
		["sight_anomaly_kobra_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_9a91_kobra_lense_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.05, 1.05, 1.05),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.015, -0.9, 2.5),
		},
		["sight_anomaly_kobra"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_9a91_kobra_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.05, 1.05, 1.05),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.015, -0.9, 2.5),
		},
	},
	["IronSightsPos_Kobra"] = Vector(-4.62, 2, 1.005),
	["RunSightsAng"] = Vector(-13, 50.5, -13),
	["RunSightsPos"] = Vector(7, -8.5, 0.2),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 31237.5,
		["RPM"] = 70,
		["Ammo"] = "7.62x54MMR",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.SVU.FIRE_SILENCED",
		["RangeFalloff"] = 0.025770308123249,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 1.94,
		["Automatic"] = false,
		["Spread"] = 0.092,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.SVU.FIRE",
		["Damage"] = 55,
		["DefaultClip"] = 40,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 10,
		["IronAccuracy"] = 0.00092,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["IronSightsAng_Kobra"] = Vector(0.1, -0.7, 0),
	["IronSightsAng_1P29"] = Vector(0, 0, 0),
	["IronSightsPos_1P29"] = Vector(-4.373, -6.5, 1.2),
	["IronSightsAng_PSO1"] = Vector(0, 0, 0),
	["IronSightsPos_PSO1"] = Vector(-3.9643, -3.5, 1.2995),
	["IronSightsAng"] = Vector(0.1, -0.7, 0),
	["Silenced"] = true,
	["IronSightsPos"] = Vector(-4.62, 2, 1.7715),
	["IronSightTime"] = 0.46,
}

SWEP.AnomalySightReticles = {
	["scope_anomaly_1p29"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_1p29",
	["scope_anomaly_pso1"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_pso1",
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_svu_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.265, -2.8827)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_svu")
	killicon.Add("cw_anomaly_svu", "vgui/killicons/tfa_anomaly_svu", Color(255, 255, 255))
end
