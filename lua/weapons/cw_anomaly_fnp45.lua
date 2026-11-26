-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "FNP-45"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/fnp45.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_fnp45_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 1

SWEP.SlotPos = 73

SWEP.NormalHoldType = "pistol"

SWEP.RunHoldType = "normal"

SWEP.FireModes = {
	[1] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 15,
	["DefaultClip"] = 60,
	["Automatic"] = false,
	["Ammo"] = ".45 ACP",
}

SWEP.FireDelay = 0.08

SWEP.FireSound = "TFA_ANOMALY.FNP45.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.FNP45.FIRE_SILENCED"

SWEP.Damage = 68

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.05

SWEP.AimSpread = 0.025

SWEP.Recoil = 1.35

SWEP.SpreadPerShot = 0.017

SWEP.MaxSpreadInc = 0.05

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 1.5

SWEP.SpeedDec = 0

SWEP.DeployTime = 0.7

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 2.4

SWEP.ReloadTime_Empty = 2.8

SWEP.ReloadHalt = 2.4

SWEP.ReloadHalt_Empty = 2.8

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-3.827, -1, 2.217)

SWEP.IronsightAng = Vector(-0.5, 0, 0)

SWEP.SprintPos = Vector(0, -1, 3.8)

SWEP.SprintAng = Vector(-19, 3, -6)

SWEP.ZoomAmount = 20

SWEP.AimViewModelFOV = 55

SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_reload",
	["reload_empty"] = "anm_reload_empty",
	["fire_dry"] = "anm_shots_last",
	["anm_hide"] = "anm_hide",
	["anm_hide_empty"] = "anm_hide_empty",
	["anm_idle"] = "anm_idle",
	["anm_idle_empty"] = "anm_idle_empty",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_aim_empty"] = "anm_idle_aim_empty",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_empty"] = "anm_idle_sprint_empty",
	["anm_reload"] = "anm_reload",
	["anm_reload_empty"] = "anm_reload_empty",
	["anm_shots"] = "anm_shots",
	["anm_shots_last"] = "anm_shots_last",
	["anm_show"] = "anm_show",
	["anm_show_empty"] = "anm_show_empty",
	["anm_show_first"] = "anm_show_first",
}

SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FNP45.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FNP45.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FNP45.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FNP45.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FNP45.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FNP45.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FNP45.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.533333,
	["anm_hide_empty"] = 0.533333,
	["anm_idle"] = 6.333333,
	["anm_idle_empty"] = 6.333333,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_aim_empty"] = 0.033333,
	["anm_idle_sprint"] = 0.833333,
	["anm_idle_sprint_empty"] = 0.833333,
	["anm_reload"] = 2.4,
	["anm_reload_empty"] = 2.8,
	["anm_shots"] = 0.433333,
	["anm_shots_last"] = 0.433333,
	["anm_show"] = 0.7,
	["anm_show_empty"] = 0.7,
	["anm_show_first"] = 0.7,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.14

SWEP.DurabilityDamage = 0.01

SWEP.WearEffect = 0.05

SWEP.MuzzleAttachmentName = "muzzle"

SWEP.MuzzleEffect = "muzzleflash_pistol"

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
			[1] = "cw_anomaly_sil_gemtech",
		},
	},
	[2] = {
		["header"] = "Finish",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_fnp45_sk1",
		},
	},
	[3] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -100,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_1143x23_hydro",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sil_gemtech",
	[2] = "cw_anomaly_fnp45_sk1",
	[3] = "cw_anomaly_ammo_1143x23_hydro",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV"] = 70,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 8925.0,
		["RPM"] = 253,
		["Ammo"] = ".45 ACP",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.FNP45.FIRE_SILENCED",
		["RangeFalloff"] = 0.03249299719888,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.25,
		["Automatic"] = false,
		["Spread"] = 0.04,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.FNP45.FIRE",
		["Damage"] = 27.5,
		["DefaultClip"] = 60,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 15,
		["IronAccuracy"] = 0.004,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {
		["anomaly_sil_gemtech"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/addon_sil_gemtech_w.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 0, -90),
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
			["pos"] = Vector(0, 1.33, -0.39),
		},
	},
	["VElements"] = {
		["anomaly_sil_gemtech"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/addon_sil_gemtech.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(0, 0, 0),
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
	},
	["RunSightsAng"] = Vector(-19, 3, -6),
	["Silenced"] = false,
	["IronSightsAng"] = Vector(-0.5, 0, 0),
	["IronSightsPos"] = Vector(-3.827, -1, 2.217),
	["RunSightsPos"] = Vector(0, -1, 3.8),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_fnp45_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.3, 4.4817, -2.7009)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "pistol"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_fnp45")
	killicon.Add("cw_anomaly_fnp45", "vgui/killicons/tfa_anomaly_fnp45", Color(255, 255, 255))
end
