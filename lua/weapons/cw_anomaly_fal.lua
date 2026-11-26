-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "FN FAL"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/fal.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_fal_w.mdl"

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

SWEP.FireDelay = 0.08888888888888889

SWEP.FireSound = "TFA_ANOMALY.FAL.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.FAL.FIRE_SILENCED"

SWEP.Damage = 130

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.13

SWEP.AimSpread = 0.004

SWEP.Recoil = 1.5

SWEP.SpreadPerShot = 0.014

SWEP.MaxSpreadInc = 0.1

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 4

SWEP.SpeedDec = 30

SWEP.DeployTime = 1.1

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.1

SWEP.ReloadTime_Empty = 3.1

SWEP.ReloadHalt = 3.1

SWEP.ReloadHalt_Empty = 3.1

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-5.603, -2, 2.678)

SWEP.IronsightAng = Vector(-0.42, 0, 0)

SWEP.SprintPos = Vector(5, -8.7, 0.85)

SWEP.SprintAng = Vector(-13.2, 49.5, -10)

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
			["sound"] = "TFA_ANOMALY.FAL.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FAL.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FAL.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FAL.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FAL.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 1.033333,
	["anm_idle"] = 6.1,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.866667,
	["anm_reload"] = 3.1,
	["anm_reload_empty"] = 3.1,
	["anm_shots"] = 0.733333,
	["anm_shots_aim"] = 0.733333,
	["anm_show"] = 1.1,
	["anm_show_first"] = 1.1,
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
			[1] = "cw_anomaly_barska",
			[2] = "cw_anomaly_acog",
			[3] = "cw_anomaly_eotech",
			[4] = "cw_anomaly_cmore",
		},
	},
	[3] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -100,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_762x51_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sil_nato",
	[2] = "cw_anomaly_barska",
	[3] = "cw_anomaly_acog",
	[4] = "cw_anomaly_eotech",
	[5] = "cw_anomaly_cmore",
	[6] = "cw_anomaly_ammo_762x51_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_Eotech"] = 70,
		["IronFOV"] = 70,
		["IronFOV_ACOG"] = 40,
		["IronFOV_Barska"] = 70,
		["IronFOV_Cmore"] = 70,
	},
	["Primary"] = {
		["KickDown"] = 0.22,
		["HullSize"] = 0,
		["Range"] = 29750.0,
		["RPM"] = 675,
		["Ammo"] = "7.62x51MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.FAL.FIRE_SILENCED",
		["RangeFalloff"] = 0.028235294117647,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 1.5,
		["Automatic"] = true,
		["Spread"] = 0.021,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.44,
		["Sound"] = "TFA_ANOMALY.FAL.FIRE",
		["Damage"] = 38,
		["DefaultClip"] = 80,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 20,
		["IronAccuracy"] = 0.0021,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.22,
	},
	["IronSightsAng_Barska"] = Vector(0, 0, 0),
	["RunSightsAng"] = Vector(-13.2, 49.5, -10),
	["IronSightsPos_Barska"] = Vector(-5.624, -2, 1.51),
	["Silenced"] = false,
	["IronSightsPos_ACOG"] = Vector(-5.673, 15, 1.477),
	["IronSightsAng_Cmore"] = Vector(0, 0, 0),
	["IronSightsPos_Eotech"] = Vector(-5.592, -2, 1.216),
	["IronSightsPos_Cmore"] = Vector(-5.605, -2, 1.426),
	["IronSightTime"] = 0.46,
	["IronSightsAng_ACOG"] = Vector(0.2, -0.1, 0),
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {
		["anomaly_sil_nato"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_addon_silencer_phantom_w.mdl",
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
			["pos"] = Vector(0, 1.86, -0.8),
		},
		["scope_anomaly_acog"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_acog_hud.mdl",
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
			["pos"] = Vector(0.03, 1.68, 4.1),
		},
		["sight_anomaly_cmore"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_ash12_c-more.mdl",
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
			["pos"] = Vector(0, 9.2, -2.05),
		},
		["sight_anomaly_eotech"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_ace21_eot_hud.mdl",
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
			["pos"] = Vector(0.02, 1.73, 1.1),
		},
		["sight_anomaly_barska"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_aug_a3_barska_hud.mdl",
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
			["pos"] = Vector(0, 1.75, -1.5),
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
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, -0.2, 0.8),
		},
		["sight_anomaly_cmore"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ash12_c-more.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.97, 0.97, 0.97),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 2.65, -2.14),
		},
		["anomaly_sil_nato"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_addon_silencer_phantom_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(0, 0, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "wpn_silencer",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 0, 0),
		},
		["scope_anomaly_acog"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ace21_acog_hud.mdl",
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
			["pos"] = Vector(0.05, 4.28, 7.25),
		},
		["sight_anomaly_cmore_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_ash12_c-more_lense.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.97, 0.97, 0.97),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 2.65, -2.14),
		},
		["sight_anomaly_barska_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_aug_a3_barska_lense_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.97, 0.97, 0.97),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.02, -0.3, -2.5),
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
			["pos"] = Vector(0, -0.2, 0.8),
		},
		["sight_anomaly_barska"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_aug_a3_barska_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.97, 0.97, 0.97),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.02, -0.3, -2.5),
		},
	},
	["IronSightsAng_Eotech"] = Vector(0, 0, 0),
	["RunSightsPos"] = Vector(5, -8.7, 0.85),
	["IronSightsAng"] = Vector(-0.42, 0, 0),
	["IronSightsPos"] = Vector(-5.603, -2, 2.678),
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_fal_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.5551, -3.0085)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_fal")
	killicon.Add("cw_anomaly_fal", "vgui/killicons/tfa_anomaly_fal", Color(255, 255, 255))
end
