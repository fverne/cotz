-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Type 63"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/type63.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_type63_w.mdl"

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
	["ClipSize"] = 20,
	["DefaultClip"] = 80,
	["Automatic"] = true,
	["Ammo"] = "7.62x39MM",
}

SWEP.FireDelay = 0.08571428571428572

SWEP.FireSound = "TFA_ANOMALY.TYPE63.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.TYPE63.FIRE"

SWEP.Damage = 83

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.13

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.6

SWEP.SpreadPerShot = 0.012

SWEP.MaxSpreadInc = 0.11

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 8

SWEP.SpeedDec = 20

SWEP.DeployTime = 0.933333

SWEP.ReloadSpeed = 1
SWEP.ReloadChamberCuts = {
	anm_reload = {from = 2.666667, to = 4.166667},
}

SWEP.ReloadTime = 4.2

SWEP.ReloadTime_Empty = 4.2

SWEP.ReloadHalt = 4.2

SWEP.ReloadHalt_Empty = 4.2

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-5.169, -3, 2.025)

SWEP.IronsightAng = Vector(0.1, 0, 0)

SWEP.SprintPos = Vector(7, -6.8, 0)

SWEP.SprintAng = Vector(-15, 49.5, -15)

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
			["sound"] = "TFA_ANOMALY.TYPE63.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TYPE63.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TYPE63.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TYPE63.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TYPE63.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.933333,
	["anm_idle"] = 3.366667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.833333,
	["anm_reload"] = 4.2,
	["anm_reload_empty"] = 4.2,
	["anm_shots"] = 0.533333,
	["anm_shots_aim"] = 0.533333,
	["anm_show"] = 0.933333,
	["anm_show_first"] = 0.933333,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots_aim"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.05

SWEP.DurabilityDamageChance = 0.005

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
			[1] = "cw_anomaly_mosin",
		},
	},
	[2] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_762x39_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_mosin",
	[2] = "cw_anomaly_ammo_762x39_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_MOSINSCOPE"] = 55,
		["IronFOV"] = 70,
	},
	["IronSightsAng_MOSINSCOPE"] = Vector(0, 0, -1),
	["MuzzleAttachmentSilenced"] = 2,
	["WElements"] = {
		["scope_anomaly_mosinscope"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_mosin_scope.mdl",
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
			["pos"] = Vector(0.15, 6.85, 8.05),
		},
	},
	["VElements"] = {
		["scope_anomaly_mosinscope"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_mosin_scope_hud.mdl",
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
			["pos"] = Vector(-6.87, 1.2, 22.2),
		},
	},
	["IronSightsPos_MOSINSCOPE"] = Vector(-5.135, -3, 1),
	["RunSightsAng"] = Vector(-15, 49.5, -15),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 26775.0,
		["RPM"] = 700,
		["Ammo"] = "7.62x39MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.027450980392157,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.762,
		["Automatic"] = true,
		["Spread"] = 0.0244,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.TYPE63.FIRE",
		["Damage"] = 29,
		["DefaultClip"] = 80,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 20,
		["IronAccuracy"] = 0.00244,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["Silenced"] = false,
	["IronSightsAng"] = Vector(0.1, 0, 0),
	["IronSightsPos"] = Vector(-5.169, -3, 2.025),
	["RunSightsPos"] = Vector(7, -6.8, 0),
	["IronSightTime"] = 0.46,
}

SWEP.AnomalySightReticles = {
	["scope_anomaly_mosinscope"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_mosin",
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_type63_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.0222, -3.3634)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_type63")
	killicon.Add("cw_anomaly_type63", "vgui/killicons/tfa_anomaly_type63", Color(255, 255, 255))
end
