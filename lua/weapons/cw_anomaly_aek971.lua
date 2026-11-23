-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "AEK-971"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/wpn_aek971_hud.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_aek971.mdl"

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
	["ClipSize"] = 30,
	["DefaultClip"] = 120,
	["Automatic"] = true,
	["Ammo"] = "5.45x39MM",
}

SWEP.FireDelay = 0.06666666666666667

SWEP.FireSound = "TFA_ANOMALY.AEK971.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.AEK971.FIRE_SILENCED"

SWEP.Damage = 78

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.09

SWEP.AimSpread = 0.008

SWEP.Recoil = 0.5

SWEP.SpreadPerShot = 0.012

SWEP.MaxSpreadInc = 0.1

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 3

SWEP.SpeedDec = 20

SWEP.DeployTime = 1.1

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.466667

SWEP.ReloadTime_Empty = 3.466667

SWEP.ReloadHalt = 3.466667

SWEP.ReloadHalt_Empty = 3.466667

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-3.823, -4.5, 2.055)

SWEP.IronsightAng = Vector(1.22, 0.06, 0)

SWEP.SprintPos = Vector(7.5, -7.5, 1.1)

SWEP.SprintAng = Vector(-14, 50, -9)

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
	["anm_hide_w_gl"] = "anm_hide_w_gl",
	["anm_hide_w_gl_setup"] = "anm_hide_w_gl_setup",
	["anm_idle"] = "anm_idle",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_w_gl"] = "anm_idle_w_gl",
	["anm_idle_w_gl_aim"] = "anm_idle_w_gl_aim",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_w_gl"] = "anm_idle_sprint_w_gl",
	["anm_reload_g"] = "anm_reload_g",
	["anm_reload"] = "anm_reload",
	["anm_reload_empty"] = "anm_reload_empty",
	["anm_reload_w_gl"] = "anm_reload_w_gl",
	["anm_reload_empty_w_gl"] = "anm_reload_empty_w_gl",
	["anm_shots"] = "anm_shots",
	["anm_shots_w_gl"] = "anm_shots_w_gl",
	["anm_shots_g"] = "anm_shots_g",
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
	["anm_show_w_gl"] = "anm_show_w_gl",
	["anm_show_w_gl_first"] = "anm_show_w_gl_first",
}

SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AEK973.Holster",
		},
	},
	["anm_hide_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AEK973.Holster",
		},
	},
	["anm_hide_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AEK973.Holster",
		},
	},
	["anm_reload_g"] = {
		[1] = {
			["time"] = 1.0,
			["sound"] = "TFA_ANOMALY.AEK973.ReloadG",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AEK973.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AEK973.Reload",
		},
	},
	["anm_reload_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AEK973.Reload",
		},
	},
	["anm_reload_empty_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AEK973.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AEK973.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AEK973.Draw",
		},
	},
	["anm_show_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AEK973.Draw",
		},
	},
	["anm_show_w_gl_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AEK973.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.566667,
	["anm_hide_w_gl"] = 0.566667,
	["anm_hide_w_gl_setup"] = 0.566667,
	["anm_idle"] = 0.033333,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_w_gl"] = 0.033333,
	["anm_idle_w_gl_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.866667,
	["anm_idle_sprint_w_gl"] = 0.866667,
	["anm_reload_g"] = 2.433333,
	["anm_reload"] = 3.466667,
	["anm_reload_empty"] = 3.466667,
	["anm_reload_w_gl"] = 3.466667,
	["anm_reload_empty_w_gl"] = 3.466667,
	["anm_shots"] = 0.366667,
	["anm_shots_w_gl"] = 0.366667,
	["anm_shots_g"] = 0.766667,
	["anm_show"] = 1.1,
	["anm_show_first"] = 1.1,
	["anm_show_w_gl"] = 1.1,
	["anm_show_w_gl_first"] = 1.1,
}

SWEP.AnomalyLauncherReloadTime = 2.433333

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots"

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
			[1] = "cw_anomaly_sil_tgpa",
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
		["header"] = "Attachments",
		["offset"] = {
			[1] = 300,
			[2] = -100,
		},
		["atts"] = {
			[1] = "cw_anomaly_gl",
		},
	},
	[4] = {
		["header"] = "Finish",
		["offset"] = {
			[1] = 300,
			[2] = 50,
		},
		["atts"] = {
			[1] = "cw_anomaly_aek971_sk1",
			[2] = "cw_anomaly_aek971_sk2",
		},
	},
	[5] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = 200,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_545x39_ep",
			[2] = "cw_anomaly_ammo_545x39_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sil_tgpa",
	[2] = "cw_anomaly_kobra",
	[3] = "cw_anomaly_pso1",
	[4] = "cw_anomaly_1p29",
	[5] = "cw_anomaly_gl",
	[6] = "cw_anomaly_aek971_sk1",
	[7] = "cw_anomaly_aek971_sk2",
	[8] = "cw_anomaly_ammo_545x39_ep",
	[9] = "cw_anomaly_ammo_545x39_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_1P29"] = 60,
		["IronFOV_PSO1"] = 60,
		["IronFOV_Kobra"] = 70,
		["IronFOV"] = 70,
	},
	["IronSightsAng_GL"] = Vector(8, -0.3, 0),
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {
		["anomaly_sil_tgpa"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/sil_tgpa_w.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.1, 1.1, 1.1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.1, 2.05, 4.18),
		},
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
			["pos"] = Vector(0.15, 7.325, -0.9),
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
			["pos"] = Vector(0.02, 6.55, 0.6),
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
			["pos"] = Vector(0, 6.2, -0.14),
		},
		["gl"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/gl_aek_w.mdl",
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
			["pos"] = Vector(0, 1.88, 1.8),
		},
		["anomaly_addon_rail"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_addon_rail_w.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-88, 90, 0),
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
			["pos"] = Vector(0.03, 2.29, 1),
		},
	},
	["VElements"] = {
		["anomaly_sil_tgpa"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/sil_tgpa.mdl",
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
			["pos"] = Vector(-0.1, -0.1, -1.2),
		},
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
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.15, -1.15, -1.65),
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
			["pos"] = Vector(-0.07, -1.15, -0.1),
		},
		["gl"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/gl_aek.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "wpn_launcher",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 0, 0),
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
			["pos"] = Vector(0.03, -1.6, -0.7),
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
			["pos"] = Vector(0.03, -1.6, -0.7),
		},
		["anomaly_addon_rail"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_addon_rail.mdl",
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
			["pos"] = Vector(-0.1, -0.1, -1.2),
		},
	},
	["IronSightsPos_Kobra"] = Vector(-3.774, -4.5, 0.352),
	["RunSightsAng"] = Vector(-14, 50, -9),
	["RunSightsPos"] = Vector(7.5, -7.5, 1.1),
	["Primary"] = {
		["GLSound"] = "TFA_ANOMALY.GRENADE.LAUNCH",
		["HullSize"] = 0,
		["Range"] = 29750.0,
		["RPM"] = 900,
		["Ammo"] = "5.45x39MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.AEK971.FIRE_SILENCED",
		["RangeFalloff"] = 0.029579831932773,
		["KickDown"] = 0.25,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.545,
		["Automatic"] = true,
		["DamageTypeHandled"] = true,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.AEK971.FIRE",
		["IronAccuracy"] = 0.0024,
		["DefaultClip"] = 120,
		["Damage"] = 25,
		["ClipSize"] = 30,
		["Spread"] = 0.024,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["IronSightsAng_Kobra"] = Vector(1.22, 0.06, 0),
	["IronSightsAng_1P29"] = Vector(0, 0, 0),
	["IronSightsPos_1P29"] = Vector(-3.992, -8, 0.99),
	["IronSightsPos_GL"] = Vector(0, 0, -2),
	["IronSightsPos_PSO1"] = Vector(-3.352, -5.5, 1.3965),
	["IronSightsAng"] = Vector(1.22, 0.06, 0),
	["IronSightsAng_PSO1"] = Vector(0, 0, 0),
	["Silenced"] = false,
	["IronSightsPos"] = Vector(-3.823, -4.5, 2.055),
	["IronSightTime"] = 0.46,
}

SWEP.AnomalySightReticles = {
	["scope_anomaly_1p29"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_1p29",
	["scope_anomaly_pso1"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_pso1",
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_aek971.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 3.8677, -0.5391)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_aek971")
	killicon.Add("cw_anomaly_aek971", "vgui/killicons/tfa_anomaly_aek971", Color(255, 255, 255))
end
