-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "AK-12"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = false

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/ak12.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_ak12.mdl"

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

SWEP.FireDelay = 0.09230769230769231

SWEP.FireSound = "TFA_ANOMALY.AK12.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.AK12.FIRE_SILENCED"

SWEP.Damage = 81

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.11

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.2

SWEP.SpreadPerShot = 0.01

SWEP.MaxSpreadInc = 0.1

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 3

SWEP.SpeedDec = 25

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.4

SWEP.ReloadTime_Empty = 3.4

SWEP.ReloadHalt = 3.4

SWEP.ReloadHalt_Empty = 3.4

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.6, -8, 2.24)

SWEP.IronsightAng = Vector(0, 0.06, 0)

SWEP.SprintPos = Vector(6, -9, 0.35)

SWEP.SprintAng = Vector(-13, 50, -11)

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
			["sound"] = "TFA_ANOMALY.AK12.Holster",
		},
	},
	["anm_hide_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK12.Holster",
		},
	},
	["anm_hide_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK12.Holster",
		},
	},
	["anm_reload_g"] = {
		[1] = {
			["time"] = 1.0,
			["sound"] = "TFA_ANOMALY.AK12.ReloadG",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK12.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK12.Reload_Empty",
		},
	},
	["anm_reload_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK12.Reload",
		},
	},
	["anm_reload_empty_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK12.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK12.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK12.Draw",
		},
	},
	["anm_show_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK12.Draw",
		},
	},
	["anm_show_w_gl_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK12.Draw",
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
	["anm_idle_sprint"] = 0.866667,
	["anm_idle_sprint_w_gl"] = 0.866667,
	["anm_reload_g"] = 2.366667,
	["anm_reload"] = 3.4,
	["anm_reload_empty"] = 3.4,
	["anm_reload_w_gl"] = 3.4,
	["anm_reload_empty_w_gl"] = 3.4,
	["anm_shots"] = 0.3,
	["anm_shots_w_gl"] = 0.566667,
	["anm_shots_g"] = 0.7,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
	["anm_show_w_gl"] = 1.033333,
	["anm_show_w_gl_first"] = 1.033333,
}

SWEP.AnomalyLauncherReloadTime = 2.366667

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
			[1] = "cw_anomaly_gl",
		},
	},
	[4] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = 50,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_545x39_ep",
			[2] = "cw_anomaly_ammo_545x39_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sil_pbs1",
	[2] = "cw_anomaly_ac10632",
	[3] = "cw_anomaly_acog",
	[4] = "cw_anomaly_eotech",
	[5] = "cw_anomaly_gl",
	[6] = "cw_anomaly_ammo_545x39_ep",
	[7] = "cw_anomaly_ammo_545x39_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_Eotech"] = 70,
		["UseParabolic"] = false,
		["UseElcan"] = false,
		["UseACOG"] = false,
		["UseGreenDuplex"] = false,
		["IronFOV"] = 70,
		["IronFOV_AC10632"] = 70,
		["IronFOV_ACOG"] = 40,
		["UseSVD"] = false,
		["UseMilDot"] = false,
	},
	["Primary"] = {
		["GLSound"] = "TFA_ANOMALY.GRENADE.LAUNCH",
		["HullSize"] = 0,
		["Range"] = 29750.0,
		["RPM"] = 650,
		["Ammo"] = "5.45x39MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.AK12.FIRE_SILENCED",
		["RangeFalloff"] = 0.030084033613445,
		["Damage"] = 25,
		["KickDown"] = 0.25,
		["Knockback"] = 0,
		["RPM_2nd"] = 1800,
		["Automatic"] = true,
		["IronAccuracy"] = 0.003,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.AK12.FIRE",
		["Spread"] = 0.03,
		["DefaultClip"] = 120,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 30,
		["StaticRecoilFactor"] = 0.545,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["RunSightsAng"] = Vector(-13, 50, -11),
	["Silenced"] = false,
	["IronSightsPos_ACOG"] = Vector(-4.543, 20, 1.614),
	["IronSightsPos_Eotech"] = Vector(-4.6, -4, 1.077),
	["IronSightTime"] = 0.46,
	["IronSightsAng_GL"] = Vector(8, -0.3, 0),
	["IronSightsPos_AC10632"] = Vector(-4.6, -8, 1.37),
	["IronSightsAng_ACOG"] = Vector(0, 0.07, 0),
	["MuzzleAttachmentSilenced"] = 2,
	["IronSightsAng_AC10632"] = Vector(0, 0.06, 0),
	["IronSightsPos_GL"] = Vector(0, 0, -2),
	["WElements"] = {
		["sight_anomaly_ac10632"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_ac10632_hud.mdl",
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
			["pos"] = Vector(0.11, 2.2, 0),
		},
		["scope_anomaly_acog"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_acog_hud.mdl",
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
			["pos"] = Vector(0.01, 2.1, 2.3),
		},
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
			["pos"] = Vector(0, 2, -1.2),
		},
		["sight_anomaly_eotech"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_eot_hud.mdl",
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
			["pos"] = Vector(0, 2.1, 1),
		},
		["gl"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_gl_abakan.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.95, 0.95, 0.95),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 7.9, 2.2),
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
			["size"] = Vector(1.2, 1.2, 1.2),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.04, 0, -2),
		},
		["gl"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/gl_ak12.mdl",
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
			["pos"] = Vector(0, 0, -1),
		},
		["scope_anomaly_acog"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_acog_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.2, 1.2, 1.2),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.01, 0, 1.2),
		},
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
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.018, 0, 0.3),
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
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 0.05, -4.2),
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
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.018, 0, 0.3),
		},
		["sight_anomaly_ac10632_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_ac10632_lense_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.2, 1.2, 1.2),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.04, 0, -2),
		},
	},
	["RunSightsPos"] = Vector(6, -9, 0.35),
	["IronSightsAng"] = Vector(0, 0.06, 0),
	["IronSightsAng_Eotech"] = Vector(0, 0.06, 0),
	["IronSightsPos"] = Vector(-4.6, -8, 2.24),
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_ak12.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.3957, -1.3884)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_ak12")
	killicon.Add("cw_anomaly_ak12", "vgui/killicons/tfa_anomaly_ak12", Color(255, 255, 255))
end
