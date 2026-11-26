-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Galil AR"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/galil.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_galil_w.mdl"

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
	["Ammo"] = "7.62x51MM",
}

SWEP.FireDelay = 0.1

SWEP.FireSound = "TFA_ANOMALY.GALIL.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.GALIL.FIRE_SILENCED"

SWEP.Damage = 130

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.13

SWEP.AimSpread = 0.004

SWEP.Recoil = 1.6

SWEP.SpreadPerShot = 0.014

SWEP.MaxSpreadInc = 0.1

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 4

SWEP.SpeedDec = 30

SWEP.DeployTime = 1.033333

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

SWEP.IronsightPos = Vector(-3.28, -1, 2.125)

SWEP.IronsightAng = Vector(-0.224, 0.05, 0)

SWEP.SprintPos = Vector(8.5, -5.5, -0.4)

SWEP.SprintAng = Vector(-12, 52, -9)

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
			["sound"] = "TFA_ANOMALY.GALIL.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GALIL.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GALIL.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GALIL.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GALIL.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.5,
	["anm_idle"] = 6.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_reload"] = 3.466667,
	["anm_reload_empty"] = 3.466667,
	["anm_shots"] = 0.433333,
	["anm_shots_aim"] = 0.2,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

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
			[1] = "cw_anomaly_galilscope",
		},
	},
	[3] = {
		["header"] = "Finish",
		["offset"] = {
			[1] = 300,
			[2] = -100,
		},
		["atts"] = {
			[1] = "cw_anomaly_galil_sk1",
			[2] = "cw_anomaly_galil_sk2",
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
	[1] = "cw_anomaly_sil_pbs1",
	[2] = "cw_anomaly_galilscope",
	[3] = "cw_anomaly_galil_sk1",
	[4] = "cw_anomaly_galil_sk2",
	[5] = "cw_anomaly_ammo_762x51_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_GALILSCOPE"] = 60,
		["IronFOV"] = 70,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {
		["scope_anomaly_galilscope"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_galil_scope_w.mdl",
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
			["pos"] = Vector(0, 1.65, -3.55),
		},
	},
	["Primary"] = {
		["KickDown"] = 0.185,
		["HullSize"] = 0,
		["Range"] = 53550.0,
		["RPM"] = 600,
		["Ammo"] = "7.62x51MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.GALIL.FIRE_SILENCED",
		["RangeFalloff"] = 0.015592903828198,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 1.2,
		["Automatic"] = true,
		["Spread"] = 0.049,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.37,
		["Sound"] = "TFA_ANOMALY.GALIL.FIRE",
		["Damage"] = 38,
		["DefaultClip"] = 120,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 30,
		["IronAccuracy"] = 0.0049,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.185,
	},
	["VElements"] = {
		["scope_anomaly_galilscope"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_galil_scope.mdl",
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
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 0.1, -4.7),
		},
	},
	["IronSightsPos_GALILSCOPE"] = Vector(-3.436, -3, 0.5635),
	["RunSightsAng"] = Vector(-12, 52, -9),
	["Silenced"] = false,
	["IronSightsAng"] = Vector(-0.224, 0.05, 0),
	["IronSightsAng_GALILSCOPE"] = Vector(0, 0, 0),
	["IronSightsPos"] = Vector(-3.28, -1, 2.125),
	["RunSightsPos"] = Vector(8.5, -5.5, -0.4),
	["IronSightTime"] = 0.46,
}

SWEP.AnomalySightReticles = {
	["scope_anomaly_galilscope"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_m24",
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_galil_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 5.4978, -6.002)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_galil")
	killicon.Add("cw_anomaly_galil", "vgui/killicons/tfa_anomaly_galil", Color(255, 255, 255))
end
