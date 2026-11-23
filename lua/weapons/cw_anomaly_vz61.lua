-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Skorpion vz.61"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/vz61.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_vz61_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 2

SWEP.SlotPos = 73

SWEP.NormalHoldType = "smg"

SWEP.RunHoldType = "passive"

SWEP.FireModes = {
	[1] = "auto",
	[2] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 20,
	["DefaultClip"] = 80,
	["Automatic"] = true,
	["Ammo"] = "9x19MM",
}

SWEP.FireDelay = 0.07058823529411765

SWEP.FireSound = "TFA_ANOMALY.VZ61.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.VZ61.FIRE_SILENCED"

SWEP.Damage = 44

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.06

SWEP.AimSpread = 0.025

SWEP.Recoil = 1.4

SWEP.SpreadPerShot = 0.01

SWEP.MaxSpreadInc = 0.05

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 5

SWEP.SpeedDec = 5

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 2.266667

SWEP.ReloadTime_Empty = 2.266667

SWEP.ReloadHalt = 2.266667

SWEP.ReloadHalt_Empty = 2.266667

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.861, -1, 2.249)

SWEP.IronsightAng = Vector(-0.5, 0.005, 0)

SWEP.SprintPos = Vector(6.8, -8.85, 0.95)

SWEP.SprintAng = Vector(-17, 50, -14)

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
			["sound"] = "TFA_ANOMALY.VZ61.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VZ61.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VZ61.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VZ61.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VZ61.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.8,
	["anm_idle"] = 6.7,
	["anm_idle_aim"] = 0.066667,
	["anm_idle_sprint"] = 0.833333,
	["anm_reload"] = 2.266667,
	["anm_reload_empty"] = 2.266667,
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
			[1] = "cw_anomaly_sil_9mm",
		},
	},
	[2] = {
		["header"] = "Finish",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_vz61_sk1",
			[2] = "cw_anomaly_vz61_sk2",
			[3] = "cw_anomaly_vz61_sk3",
		},
	},
	[3] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -100,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_9x19_pbp",
			[2] = "cw_anomaly_ammo_9x19_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sil_9mm",
	[2] = "cw_anomaly_vz61_sk1",
	[3] = "cw_anomaly_vz61_sk2",
	[4] = "cw_anomaly_vz61_sk3",
	[5] = "cw_anomaly_ammo_9x19_pbp",
	[6] = "cw_anomaly_ammo_9x19_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV"] = 70,
	},
	["Primary"] = {
		["KickDown"] = 0.155,
		["HullSize"] = 0,
		["Range"] = 11900.0,
		["RPM"] = 850,
		["Ammo"] = "9x19MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.VZ61.FIRE_SILENCED",
		["RangeFalloff"] = 0.03109243697479,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.42,
		["Automatic"] = true,
		["Spread"] = 0.064,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.31,
		["Sound"] = "TFA_ANOMALY.VZ61.FIRE",
		["Damage"] = 23,
		["DefaultClip"] = 80,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 20,
		["IronAccuracy"] = 0.0064,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.155,
	},
	["RunSightsAng"] = Vector(-17, 50, -14),
	["Silenced"] = false,
	["IronSightTime"] = 0.46,
	["MuzzleAttachmentSilenced"] = 2,
	["RunSightsPos"] = Vector(6.8, -8.85, 0.95),
	["IronSightsAng"] = Vector(-0.5, 0.005, 0),
	["WElements"] = {
		["anomaly_sil_9mm"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_addon_sil_9mm.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.025, 1.025, 1.025),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.01, 5.1, -4.7),
		},
	},
	["VElements"] = {
		["anomaly_sil_9mm"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_addon_sil_9mm.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.025, 1.025, 1.025),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(-0.01, -0.805, -4.7),
		},
	},
	["IronSightsPos"] = Vector(-4.861, -1, 2.249),
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_vz61_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 4.1081, -4.6758)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "smg"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_vz61")
	killicon.Add("cw_anomaly_vz61", "vgui/killicons/tfa_anomaly_vz61", Color(255, 255, 255))
end
