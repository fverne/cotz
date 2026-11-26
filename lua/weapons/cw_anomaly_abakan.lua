-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "AN-94"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = false

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/abakan.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_abakan.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 2

SWEP.SlotPos = 73

SWEP.NormalHoldType = "ar2"

SWEP.RunHoldType = "passive"

SWEP.FireModes = {
	[1] = "auto",
	[2] = "2burst",
	[3] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 30,
	["DefaultClip"] = 120,
	["Automatic"] = true,
	["Ammo"] = "5.45x39MM",
}

SWEP.FireDelay = 0.1

SWEP.FireSound = "TFA_ANOMALY.ABAKAN.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.ABAKAN.FIRE_SILENCED"

SWEP.Damage = 75

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.14

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.1

SWEP.SpreadPerShot = 0.007

SWEP.MaxSpreadInc = 0.8

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 3

SWEP.SpeedDec = 25

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.6

SWEP.ReloadTime_Empty = 5.433333

SWEP.ReloadHalt = 3.6

SWEP.ReloadHalt_Empty = 5.433333

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.425, -3.4, 2.88)

SWEP.IronsightAng = Vector(0.05, 0, 0)

SWEP.SprintPos = Vector(7, -8.5, 1)

SWEP.SprintAng = Vector(-14, 53, -9)

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
			["sound"] = "TFA_ANOMALY.ABAKAN.Holster",
		},
	},
	["anm_hide_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Holster",
		},
	},
	["anm_hide_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Holster",
		},
	},
	["anm_reload_g"] = {
		[1] = {
			["time"] = 1.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.ReloadG",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Reload_Empty",
		},
	},
	["anm_reload_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Reload",
		},
	},
	["anm_reload_empty_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Draw",
		},
	},
	["anm_show_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Draw",
		},
	},
	["anm_show_w_gl_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.833333,
	["anm_hide_w_gl"] = 0.833333,
	["anm_hide_w_gl_setup"] = 0.833333,
	["anm_idle"] = 0.033333,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_w_gl"] = 0.033333,
	["anm_idle_w_gl_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_idle_sprint_w_gl"] = 0.8,
	["anm_reload_g"] = 2.366667,
	["anm_reload"] = 3.6,
	["anm_reload_empty"] = 5.433333,
	["anm_reload_w_gl"] = 3.6,
	["anm_reload_empty_w_gl"] = 5.433333,
	["anm_shots"] = 0.433333,
	["anm_shots_w_gl"] = 0.433333,
	["anm_shots_g"] = 0.6,
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
			[1] = "cw_anomaly_kobra",
			[2] = "cw_anomaly_pso1",
			[3] = "cw_anomaly_1p29",
		},
	},
	[2] = {
		["header"] = "Attachments",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_gl",
		},
	},
	[3] = {
		["header"] = "Finish",
		["offset"] = {
			[1] = 300,
			[2] = -100,
		},
		["atts"] = {
			[1] = "cw_anomaly_abakan_sk1",
			[2] = "cw_anomaly_abakan_sk2",
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
	[1] = "cw_anomaly_kobra",
	[2] = "cw_anomaly_pso1",
	[3] = "cw_anomaly_1p29",
	[4] = "cw_anomaly_gl",
	[5] = "cw_anomaly_abakan_sk1",
	[6] = "cw_anomaly_abakan_sk2",
	[7] = "cw_anomaly_ammo_545x39_ep",
	[8] = "cw_anomaly_ammo_545x39_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_Kobra"] = 70,
		["UseParabolic"] = false,
		["IronFOV_1P29"] = 60,
		["UseSVD"] = false,
		["UseGreenDuplex"] = false,
		["IronFOV"] = 70,
		["IronFOV_PSO1"] = 60,
		["UseACOG"] = false,
		["UseElcan"] = false,
		["UseMilDot"] = false,
	},
	["Primary"] = {
		["GLSound"] = "TFA_ANOMALY.GRENADE.LAUNCH",
		["HullSize"] = 0,
		["Range"] = 29750.0,
		["RPM"] = 600,
		["Ammo"] = "5.45x39MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.ABAKAN.FIRE_SILENCED",
		["RangeFalloff"] = 0.030252100840336,
		["Damage"] = 25,
		["KickDown"] = 0.25,
		["Knockback"] = 0,
		["RPM_2nd"] = 1800,
		["Automatic"] = true,
		["IronAccuracy"] = 0.00265,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.ABAKAN.FIRE",
		["Spread"] = 0.0265,
		["DefaultClip"] = 120,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 30,
		["StaticRecoilFactor"] = 0.545,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.375,
	},
	["RunSightsAng"] = Vector(-14, 53, -9),
	["IronSightsAng_1P29"] = Vector(0, 0, 0),
	["Silenced"] = false,
	["IronSightsAng_PSO1"] = Vector(0, 0, 0),
	["IronSightTime"] = 0.46,
	["IronSightsAng_GL"] = Vector(8, -0.3, 0),
	["IronSightsPos_Kobra"] = Vector(-4.12, -3.4, 1.192),
	["IronSightsPos_1P29"] = Vector(-4.1965, -5.5, 1.298),
	["MuzzleAttachmentSilenced"] = 2,
	["IronSightsPos_GL"] = Vector(0, 0, -2),
	["WElements"] = {
		["gl"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_gl_abakan.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(0, 0, 0),
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
			["pos"] = Vector(-0.27, 6.3, -0.14),
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
			["pos"] = Vector(-0.27, 6.4, -0.9),
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
			["pos"] = Vector(-0.2, 6.5, 0.6),
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
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.1, -0.1, -1.2),
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
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.1, -0.1, 0.7),
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
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.1, -0.15, -0.25),
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
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.1, -0.15, -0.25),
		},
		["gl"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/gl_abakan.mdl",
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
	},
	["IronSightsPos_PSO1"] = Vector(-3.7775, -3, 1.464),
	["IronSightsAng"] = Vector(0.05, 0, 0),
	["RunSightsPos"] = Vector(7, -8.5, 1),
	["IronSightsAng_Kobra"] = Vector(0, 0, 0),
	["IronSightsPos"] = Vector(-4.425, -3.4, 2.88),
}

SWEP.AnomalySightReticles = {
	["scope_anomaly_1p29"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_1p29",
	["scope_anomaly_pso1"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_pso1",
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_abakan.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.3957, -1.3884)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

SWEP.AnomalyHyperburstRPM = 1800

SWEP.AnomalyRecoilResetDelay = 0.25

AddCSLuaFile("cotz_anomaly/sh_abakan.lua")

include("cotz_anomaly/sh_abakan.lua")

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_abakan")
	killicon.Add("cw_anomaly_abakan", "vgui/killicons/tfa_anomaly_abakan", Color(255, 255, 255))
end
