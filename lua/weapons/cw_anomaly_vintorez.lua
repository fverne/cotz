-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "VSS “Vintorez”"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/vintorez.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_vintorez_w.mdl"

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
	["ClipSize"] = 10,
	["DefaultClip"] = 40,
	["Automatic"] = true,
	["Ammo"] = "9x39MM",
}

SWEP.FireDelay = 0.075

SWEP.FireSound = "TFA_ANOMALY.VINTOREZ.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.VINTOREZ.FIRE_SILENCED"

SWEP.Damage = 180

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.1

SWEP.AimSpread = 0.005

SWEP.Recoil = 2.3

SWEP.SpreadPerShot = 0.02

SWEP.MaxSpreadInc = 0.4

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 6

SWEP.SpeedDec = 20

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.857143

SWEP.ReloadTime_Empty = 3.857143

SWEP.ReloadHalt = 3.857143

SWEP.ReloadHalt_Empty = 3.857143

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.095, -3, 2.595)

SWEP.IronsightAng = Vector(0, 0.04, 0)

SWEP.SprintPos = Vector(8, -9, 0)

SWEP.SprintAng = Vector(-13, 53.5, -13)

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
			["sound"] = "TFA_ANOMALY.VINTOREZ.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VINTOREZ.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VINTOREZ.ReloadEmpty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VINTOREZ.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VINTOREZ.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.8,
	["anm_idle"] = 6.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_reload"] = 3.857143,
	["anm_reload_empty"] = 3.857143,
	["anm_shots"] = 0.666667,
	["anm_shots_aim"] = 0.666667,
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
			[2] = "cw_anomaly_1p29",
			[3] = "cw_anomaly_pso1m21",
		},
	},
	[2] = {
		["header"] = "Finish",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_vintorez_sk1",
		},
	},
	[3] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -100,
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
	[4] = "cw_anomaly_vintorez_sk1",
	[5] = "cw_anomaly_ammo_9x39_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_1P29"] = 60,
		["IronFOV_PSO1M21"] = 60,
		["IronFOV_Kobra"] = 70,
		["IronFOV"] = 70,
	},
	["Primary"] = {
		["KickDown"] = 0.23,
		["HullSize"] = 0,
		["Range"] = 17850.0,
		["RPM"] = 800,
		["Ammo"] = "9x39MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.VINTOREZ.FIRE_SILENCED",
		["RangeFalloff"] = 0.028011204481793,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.5,
		["Automatic"] = true,
		["Spread"] = 0.02,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.46,
		["Sound"] = "TFA_ANOMALY.VINTOREZ.FIRE",
		["Damage"] = 31,
		["DefaultClip"] = 40,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 10,
		["IronAccuracy"] = 0.002,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.23,
	},
	["IronSightsPos_PSO1M21"] = Vector(-3.785, -6, 1.2175),
	["RunSightsAng"] = Vector(-13, 53.5, -13),
	["RunSightsPos"] = Vector(8, -9, 0),
	["IronSightsAng_1P29"] = Vector(0, 0, 0),
	["Silenced"] = true,
	["IronSightTime"] = 0.46,
	["IronSightsAng_PSO1M21"] = Vector(0, 0, 0),
	["IronSightsPos_Kobra"] = Vector(-4.095, -3, 1.02),
	["IronSightsPos_1P29"] = Vector(-4.1628, -7, 1.055),
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {
		["scope_anomaly_pso1m21"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_9a91_pso1m21.mdl",
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
			["pos"] = Vector(0, 6, 0.5),
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
			["pos"] = Vector(0, 6, 2),
		},
		["scope_anomaly_1p29"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_9a91_1p29.mdl",
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
			["pos"] = Vector(0, 6, 0.5),
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
			["size"] = Vector(0.9, 0.9, 0.9),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.0233, -0.1, 0.25),
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
			["pos"] = Vector(0.0233, -0.1, 1.3),
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
			["pos"] = Vector(0.0233, -0.1, 1.3),
		},
		["scope_anomaly_1p29"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_9a91_1p29_hud.mdl",
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
			["pos"] = Vector(0.0233, -0.1, 0.25),
		},
	},
	["IronSightsAng"] = Vector(0, 0.04, 0),
	["IronSightsAng_Kobra"] = Vector(0, 0, 0),
	["IronSightsPos"] = Vector(-4.095, -3, 2.595),
}

SWEP.AnomalySightReticles = {
	["scope_anomaly_1p29"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_1p29",
	["scope_anomaly_pso1m21"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_vss",
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_vintorez_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 4.5638, -2.9088)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_vintorez")
	killicon.Add("cw_anomaly_vintorez", "vgui/killicons/tfa_anomaly_vintorez", Color(255, 255, 255))
end
