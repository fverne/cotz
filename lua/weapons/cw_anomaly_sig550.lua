-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "SIG SG550"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/sig550.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_sig550_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 2

SWEP.SlotPos = 73

SWEP.NormalHoldType = "ar2"

SWEP.RunHoldType = "passive"

SWEP.FireModes = {
	[1] = "semi",
	[2] = "auto",
}

SWEP.Primary = {
	["ClipSize"] = 30,
	["DefaultClip"] = 120,
	["Automatic"] = true,
	["Ammo"] = "5.56x45MM",
}

SWEP.FireDelay = 0.08571428571428572

SWEP.FireSound = "TFA_ANOMALY.SIG550.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.SIG550.FIRE_SILENCED"

SWEP.Damage = 80

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.1

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.2

SWEP.SpreadPerShot = 0.01

SWEP.MaxSpreadInc = 0.09

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 3

SWEP.SpeedDec = 20

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 4.0

SWEP.ReloadTime_Empty = 5.433333

SWEP.ReloadHalt = 4.0

SWEP.ReloadHalt_Empty = 5.433333

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-3.933, -2, 2.6185)

SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.SprintPos = Vector(5.5, -9.5, 0.5)

SWEP.SprintAng = Vector(-12, 49, -10)

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
			["sound"] = "TFA_ANOMALY.SIG550.Holster",
		},
	},
	["anm_hide_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.Holster",
		},
	},
	["anm_hide_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.Holster",
		},
	},
	["anm_reload_g"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.ReloadG",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.ReloadEmpty",
		},
	},
	["anm_reload_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.Reload",
		},
	},
	["anm_reload_empty_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.ReloadEmpty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.Draw",
		},
	},
	["anm_show_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.Draw",
		},
	},
	["anm_show_w_gl_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.Draw",
		},
	},
	["anm_show_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.Draw",
		},
	},
	["anm_show_w_gl_setup_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.Draw",
		},
	},
	["anm_sw_on"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.Switch",
		},
	},
	["anm_sw_off"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG550.Switch",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.8,
	["anm_hide_w_gl"] = 0.8,
	["anm_hide_w_gl_setup"] = 0.8,
	["anm_idle"] = 6.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_w_gl"] = 6.666667,
	["anm_idle_w_gl_aim"] = 0.033333,
	["anm_idle_w_gl_setup"] = 6.666667,
	["anm_idle_sprint"] = 0.8,
	["anm_idle_sprint_w_gl"] = 0.8,
	["anm_idle_sprint_w_gl_setup"] = 0.8,
	["anm_reload_g"] = 3.2,
	["anm_reload"] = 4.0,
	["anm_reload_empty"] = 5.433333,
	["anm_reload_w_gl"] = 4.0,
	["anm_reload_empty_w_gl"] = 5.433333,
	["anm_shots"] = 0.5,
	["anm_shots_w_gl"] = 0.5,
	["anm_shots_g"] = 0.666667,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
	["anm_show_w_gl"] = 1.033333,
	["anm_show_w_gl_first"] = 1.033333,
	["anm_show_w_gl_setup"] = 1.033333,
	["anm_show_w_gl_setup_first"] = 1.033333,
	["anm_sw_on"] = 0.533333,
	["anm_sw_off"] = 0.533333,
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
			[1] = "cw_anomaly_ac10632",
			[2] = "cw_anomaly_acog",
			[3] = "cw_anomaly_eotech",
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
		["header"] = "Finish",
		["offset"] = {
			[1] = 300,
			[2] = 50,
		},
		["atts"] = {
			[1] = "cw_anomaly_sig550_sk1",
			[2] = "cw_anomaly_sig550_sk4",
		},
	},
	[5] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = 200,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_556x45_ss190",
			[2] = "cw_anomaly_ammo_556x45_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sil_nato",
	[2] = "cw_anomaly_ac10632",
	[3] = "cw_anomaly_acog",
	[4] = "cw_anomaly_eotech",
	[5] = "cw_anomaly_gl_m202",
	[6] = "cw_anomaly_sig550_sk1",
	[7] = "cw_anomaly_sig550_sk4",
	[8] = "cw_anomaly_ammo_556x45_ss190",
	[9] = "cw_anomaly_ammo_556x45_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_AC10632"] = 70,
		["IronFOV_ACOG"] = 40,
		["IronFOV_Eotech"] = 70,
		["IronFOV"] = 70,
	},
	["IronSightsAng_GL"] = Vector(8, -0.3, 0),
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {
		["sight_anomaly_ac10632"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_ac10632_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.01, 1.01, 1.01),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.01, 1.85, 1.15),
		},
		["anomaly_sil_nato"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_sil_nato.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.75, 0.75, 0.75),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.005, 1.28, -9),
		},
		["scope_anomaly_acog"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_sig552_acog_hud.mdl",
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
			["pos"] = Vector(0, 1.86, 0.8),
		},
		["gl"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_sig550_gl_w.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.1, 1.1, 1.1),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.13, -2.8, -0.15),
		},
		["sight_anomaly_eotech"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_eot_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.01, 1.01, 1.01),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.01, 1.85, 0.9),
		},
	},
	["VElements"] = {
		["sight_anomaly_ac10632"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_ac10632_hud.mdl",
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
			["pos"] = Vector(0.05, -0.85, 0.35),
		},
		["anomaly_sil_nato"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_sil_nato.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.92, 0.92, 0.92),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.05, -1.34, -10.9),
		},
		["scope_anomaly_acog"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_sig552_acog_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_scope",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.001, -0.8, 0.15),
		},
		["gl"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_sig550_gl_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.1, 1.1, 1.1),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.13, -2.8, -0.15),
		},
		["sight_anomaly_ac10632_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_ac10632_lense_hud.mdl",
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
			["pos"] = Vector(0.05, -0.85, 0.35),
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
			["pos"] = Vector(0.01, -0.85, 0.15),
		},
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
			["pos"] = Vector(0.01, -0.85, 0.15),
		},
	},
	["Primary"] = {
		["GLSound"] = "TFA_ANOMALY.SIG550.ShootGL",
		["HullSize"] = 0,
		["Range"] = 29750.0,
		["RPM"] = 700,
		["Ammo"] = "5.56x45MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.SIG550.FIRE_SILENCED",
		["RangeFalloff"] = 0.030588235294118,
		["KickDown"] = 0.25,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.556,
		["Automatic"] = true,
		["DamageTypeHandled"] = true,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.SIG550.FIRE",
		["IronAccuracy"] = 0.00249,
		["DefaultClip"] = 120,
		["Damage"] = 25,
		["ClipSize"] = 30,
		["Spread"] = 0.0249,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["IronSightsPos_AC10632"] = Vector(-3.963, 0, 2.04),
	["RunSightsAng"] = Vector(-12, 49, -10),
	["RunSightsPos"] = Vector(5.5, -9.5, 0.5),
	["IronSightsAng_AC10632"] = Vector(0, 0, 0),
	["IronSightsPos_ACOG"] = Vector(-3.934, 15, 1.183),
	["IronSightsPos_GL"] = Vector(0, 0, -2),
	["IronSightsPos_Eotech"] = Vector(-3.95, 0, 1.776),
	["IronSightsAng_Eotech"] = Vector(0, 0, 0),
	["Silenced"] = false,
	["IronSightsAng"] = Vector(0, 0, 0),
	["IronSightsAng_ACOG"] = Vector(0, 0, 0),
	["IronSightsPos"] = Vector(-3.933, -2, 2.6185),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_sig550_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.4381, -3.199)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_sig550")
	killicon.Add("cw_anomaly_sig550", "vgui/killicons/tfa_anomaly_sig550", Color(255, 255, 255))
end
