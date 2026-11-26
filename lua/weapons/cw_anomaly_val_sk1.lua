-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Modern AS “Val”"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/val_sk1.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_val_sk1_w.mdl"

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
	["Ammo"] = "9x39MM",
}

SWEP.FireDelay = 0.07142857142857142

SWEP.FireSound = "TFA_ANOMALY.VAL.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.VAL.FIRE"

SWEP.Damage = 180

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.15

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.7

SWEP.SpreadPerShot = 0.014

SWEP.MaxSpreadInc = 0.09

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 3

SWEP.SpeedDec = 25

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1
SWEP.ReloadChamberCuts = {
	anm_reload = {from = 3.133333, to = 4.600000},
}

SWEP.ReloadTime = 4.9

SWEP.ReloadTime_Empty = 4.9

SWEP.ReloadHalt = 4.9

SWEP.ReloadHalt_Empty = 4.9

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.21, -4, 2.052)

SWEP.IronsightAng = Vector(0, 0.047, 0)

SWEP.SprintPos = Vector(6, -9.6, 0)

SWEP.SprintAng = Vector(-13, 49.85, -12)

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
			["sound"] = "TFA_ANOMALY.VAL.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VALSK1.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VALSK1.ReloadEmpty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VAL.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VAL.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 1.033333,
	["anm_idle"] = 6.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_reload"] = 4.9,
	["anm_reload_empty"] = 4.9,
	["anm_shots"] = 0.433333,
	["anm_shots_aim"] = 0.433333,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = true

SWEP.AnomalyAimFire = "anm_shots_aim"

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
			[1] = "cw_anomaly_kobra",
			[2] = "cw_anomaly_1p29",
			[3] = "cw_anomaly_pso1m21",
		},
	},
	[2] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_9x39_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_kobra",
	[2] = "cw_anomaly_1p29",
	[3] = "cw_anomaly_pso1m21",
	[4] = "cw_anomaly_ammo_9x39_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_1P29"] = 60,
		["IronFOV_PSO1M21"] = 60,
		["IronFOV_Kobra"] = 70,
		["IronFOV"] = 70,
	},
	["Primary"] = {
		["KickDown"] = 0.215,
		["HullSize"] = 0,
		["Range"] = 17850.0,
		["RPM"] = 840,
		["Ammo"] = "9x39MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.VAL.FIRE",
		["RangeFalloff"] = 0.028011204481793,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.5,
		["Automatic"] = true,
		["Spread"] = 0.03,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.43,
		["Sound"] = "TFA_ANOMALY.VAL.FIRE",
		["Damage"] = 31,
		["DefaultClip"] = 80,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 20,
		["IronAccuracy"] = 0.003,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.215,
	},
	["IronSightsPos_PSO1M21"] = Vector(-3.856, -6.5, 0.706),
	["RunSightsAng"] = Vector(-13, 49.85, -12),
	["RunSightsPos"] = Vector(6, -9.6, 0),
	["IronSightsAng_1P29"] = Vector(0, 0, 0),
	["Silenced"] = true,
	["IronSightTime"] = 0.46,
	["IronSightsAng_PSO1M21"] = Vector(0, 0, 0),
	["IronSightsPos_Kobra"] = Vector(-4.179, -3, 0.423),
	["IronSightsPos_1P29"] = Vector(-4.2, -7, 0.468),
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {
		["scope_anomaly_pso1m21"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_9a91_pso1m21.mdl",
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
			["pos"] = Vector(0.15, 6.95, -0.15),
		},
		["sight_anomaly_kobra"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_9a91_kobra.mdl",
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
			["pos"] = Vector(0.01, 6, 2.3),
		},
		["scope_anomaly_1p29"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_9a91_1p29.mdl",
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
			["pos"] = Vector(0.06, 6.55, 0.7),
		},
	},
	["VElements"] = {
		["scope_anomaly_pso1m21"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_9a91_pso1m21_hud.mdl",
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
			["pos"] = Vector(-0.08, 0.15, -0.35),
		},
		["sight_anomaly_kobra"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_9a91_kobra_hud.mdl",
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
			["pos"] = Vector(-0.1, -0.4, 3),
		},
		["sight_anomaly_kobra_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_9a91_kobra_lense_hud.mdl",
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
			["pos"] = Vector(-0.1, -0.4, 3),
		},
		["scope_anomaly_1p29"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_9a91_1p29_hud.mdl",
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
			["pos"] = Vector(-0.15, -0.15, 1.4),
		},
	},
	["IronSightsAng"] = Vector(0, 0.047, 0),
	["IronSightsAng_Kobra"] = Vector(0, 0, 0),
	["IronSightsPos"] = Vector(-4.21, -4, 2.052),
}

SWEP.AnomalySightReticles = {
	["scope_anomaly_1p29"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_1p29",
	["scope_anomaly_pso1m21"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_vss",
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_val_sk1_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 5.1043, -4.763)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_val_sk1")
	killicon.Add("cw_anomaly_val_sk1", "vgui/killicons/tfa_anomaly_val_sk1", Color(255, 255, 255))
end
