-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "HK417"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/hk417.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_hk417_w.mdl"

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

SWEP.FireSound = "TFA_ANOMALY.HK417.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.HK417.FIRE_SILENCED"

SWEP.Damage = 135

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.13

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.5

SWEP.SpreadPerShot = 0.012

SWEP.MaxSpreadInc = 0.1

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 5

SWEP.SpeedDec = 30

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.2

SWEP.ReloadTime_Empty = 3.2

SWEP.ReloadHalt = 3.2

SWEP.ReloadHalt_Empty = 3.2

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-5.116, -2, 2.22)

SWEP.IronsightAng = Vector(0.19, 0, 0)

SWEP.SprintPos = Vector(7, -8.8, 0.5)

SWEP.SprintAng = Vector(-14, 51, -12)

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
	["anm_idle_w_gl_setup"] = "anm_idle_w_gl_setup",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_w_gl"] = "anm_idle_sprint_w_gl",
	["anm_idle_sprint_w_gl_setup"] = "anm_idle_sprint_w_gl_setup",
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
	["anm_show_w_gl_setup"] = "anm_show_w_gl_setup",
	["anm_show_w_gl_setup_first"] = "anm_show_w_gl_setup_first",
	["anm_sw_on"] = "anm_sw_on",
	["anm_sw_off"] = "anm_sw_off",
}

SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Holster",
		},
	},
	["anm_hide_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Holster",
		},
	},
	["anm_hide_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Holster",
		},
	},
	["anm_reload_g"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.ReloadG",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Reload",
		},
	},
	["anm_reload_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Reload",
		},
	},
	["anm_reload_empty_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Draw",
		},
	},
	["anm_show_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Draw",
		},
	},
	["anm_show_w_gl_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Draw",
		},
	},
	["anm_show_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Draw",
		},
	},
	["anm_show_w_gl_setup_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Draw",
		},
	},
	["anm_sw_on"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Switch",
		},
	},
	["anm_sw_off"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK417.Switch",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.5,
	["anm_hide_w_gl"] = 0.5,
	["anm_hide_w_gl_setup"] = 0.5,
	["anm_idle"] = 0.033333,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_w_gl"] = 0.033333,
	["anm_idle_w_gl_aim"] = 0.033333,
	["anm_idle_w_gl_setup"] = 6.666667,
	["anm_idle_sprint"] = 0.8,
	["anm_idle_sprint_w_gl"] = 0.8,
	["anm_idle_sprint_w_gl_setup"] = 0.8,
	["anm_reload_g"] = 3.2,
	["anm_reload"] = 3.2,
	["anm_reload_empty"] = 3.2,
	["anm_reload_w_gl"] = 3.2,
	["anm_reload_empty_w_gl"] = 3.2,
	["anm_shots"] = 0.433333,
	["anm_shots_w_gl"] = 0.433333,
	["anm_shots_g"] = 0.766667,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
	["anm_show_w_gl"] = 1.033333,
	["anm_show_w_gl_first"] = 1.033333,
	["anm_show_w_gl_setup"] = 1.033333,
	["anm_show_w_gl_setup_first"] = 1.033333,
	["anm_sw_on"] = 1.066667,
	["anm_sw_off"] = 1.066667,
}

SWEP.AnomalyLauncherReloadTime = 3.2

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.05

SWEP.DurabilityDamage = 0.005

SWEP.FireMoveMod = 0.6

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
		},
	},
	[3] = {
		["header"] = "Attachments",
		["offset"] = {
			[1] = 300,
			[2] = -100,
		},
		["atts"] = {
			[1] = "cw_anomaly_gl_m202",
		},
	},
	[4] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = 50,
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
	[4] = "cw_anomaly_gl_m202",
	[5] = "cw_anomaly_ammo_762x51_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_ACOG"] = 40,
		["IronFOV_Eotech"] = 70,
		["IronFOV"] = 70,
	},
	["IronSightsAng_GL"] = Vector(8, -0.3, 0),
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {
		["anomaly_sil_nato"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/addons_sil_762ar_w.mdl",
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
			["pos"] = Vector(0.05, 1.77, -4.5),
		},
		["scope_anomaly_acog"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_acog_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-94, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.25, 1.25, 1.25),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.02, 2.4, 3),
		},
		["anomaly_hk416_sights"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_hk417_ironsight_w.mdl",
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
			["active"] = true,
			["skin"] = 0,
			["pos"] = Vector(0.01, -1.47, -9.4),
		},
		["gl"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_hk417_gl_w.mdl",
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
		["sight_anomaly_eotech"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_eot_hud.mdl",
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
			["pos"] = Vector(0.02, 2.4, 2.2),
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
			["size"] = Vector(1.2, 1.2, 1.2),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.02, -0.5, 2.1),
		},
		["anomaly_sil_nato"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/addons_sil_762ar.mdl",
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
			["pos"] = Vector(0.02, -0.6, -3.1),
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
			["pos"] = Vector(0.02, -0.3, 3),
		},
		["anomaly_hk416_sights"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_hk417_ironsight_hud.mdl",
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
			["pos"] = Vector(0.01, -1.47, -9.4),
		},
		["gl"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_hk417_gl_hud.mdl",
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
			["pos"] = Vector(0, 0, 0),
		},
		["sight_anomaly_eotech"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_eot_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
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
			["pos"] = Vector(0.02, -0.5, 2.1),
		},
	},
	["RunSightsAng"] = Vector(-14, 51, -12),
	["RunSightsPos"] = Vector(7, -8.8, 0.5),
	["Primary"] = {
		["GLSound"] = "TFA_ANOMALY.HK417.ShootGL",
		["HullSize"] = 0,
		["Range"] = 14875.0,
		["RPM"] = 600,
		["Ammo"] = "7.62x51MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.HK417.FIRE_SILENCED",
		["RangeFalloff"] = 0.054924369747899,
		["KickDown"] = 0.185,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 2,
		["Automatic"] = true,
		["DamageTypeHandled"] = true,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.37,
		["Sound"] = "TFA_ANOMALY.HK417.FIRE",
		["IronAccuracy"] = 0.002,
		["DefaultClip"] = 80,
		["Damage"] = 38,
		["ClipSize"] = 20,
		["Spread"] = 0.02,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.185,
	},
	["IronSightsAng_Eotech"] = Vector(-0.3, 0, 0),
	["IronSightsPos_ACOG"] = Vector(-5.093, 15, 2.243),
	["IronSightsPos_GL"] = Vector(0, 0, -2),
	["IronSightsPos_Eotech"] = Vector(-5.1125, -1, 1.6645),
	["IronSightsAng"] = Vector(0.19, 0, 0),
	["Silenced"] = false,
	["IronSightsAng_ACOG"] = Vector(-0.3, 0, 0),
	["IronSightsPos"] = Vector(-5.116, -2, 2.22),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_hk417_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 4.6324, -4.4206)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_hk417")
	killicon.Add("cw_anomaly_hk417", "vgui/killicons/tfa_anomaly_hk417", Color(255, 255, 255))
end
