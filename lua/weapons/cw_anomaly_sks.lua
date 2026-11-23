-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "SKS-45"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/sks.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_sks_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 2

SWEP.SlotPos = 73

SWEP.NormalHoldType = "ar2"

SWEP.RunHoldType = "passive"

SWEP.FireModes = {
	[1] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 10,
	["DefaultClip"] = 40,
	["Automatic"] = false,
	["Ammo"] = "7.62x39MM",
}

SWEP.FireDelay = 0.3

SWEP.FireSound = "TFA_ANOMALY.SKS.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.SKS.FIRE"

SWEP.Damage = 82

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.11

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.9

SWEP.SpreadPerShot = 0.03

SWEP.MaxSpreadInc = 0.08

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 4

SWEP.SpeedDec = 15

SWEP.DeployTime = 1.133333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 4.266667

SWEP.ReloadTime_Empty = 4.266667

SWEP.ReloadHalt = 4.266667

SWEP.ReloadHalt_Empty = 4.266667

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.679, -3, 2.857)

SWEP.IronsightAng = Vector(-0.225, -0.03, 0)

SWEP.SprintPos = Vector(6, -6.9, 1)

SWEP.SprintAng = Vector(-13, 50, -10)

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
			["sound"] = "TFA_ANOMALY.SKS.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SKS.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SKS.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SKS.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SKS.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 1.133333,
	["anm_idle"] = 6.133333,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.9,
	["anm_reload"] = 4.266667,
	["anm_reload_empty"] = 4.266667,
	["anm_shots"] = 1.4,
	["anm_shots_aim"] = 1.4,
	["anm_show"] = 1.133333,
	["anm_show_first"] = 1.133333,
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

SWEP.Shell = false

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
		["header"] = "Finish",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_sks_sk1",
		},
	},
	[3] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -100,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_762x39_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_mosin",
	[2] = "cw_anomaly_sks_sk1",
	[3] = "cw_anomaly_ammo_762x39_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_MOSINSCOPE"] = 55,
		["IronFOV"] = 70,
	},
	["IronSightsAng_MOSINSCOPE"] = Vector(0, 0, 0),
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
			["pos"] = Vector(0.01, 5.15, 8.4),
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
			["pos"] = Vector(-6.8, 1.4, 22),
		},
	},
	["IronSightsPos_MOSINSCOPE"] = Vector(-4.704, -3, 1.699),
	["RunSightsAng"] = Vector(-13, 50, -10),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 26775.0,
		["RPM"] = 200,
		["Ammo"] = "7.62x39MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.027450980392157,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 1.6,
		["Automatic"] = false,
		["Spread"] = 0.0204,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.SKS.FIRE",
		["Damage"] = 29.25,
		["DefaultClip"] = 40,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 10,
		["IronAccuracy"] = 0.00204,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["Silenced"] = false,
	["IronSightsAng"] = Vector(-0.225, -0.03, 0),
	["IronSightsPos"] = Vector(-4.679, -3, 2.857),
	["RunSightsPos"] = Vector(6, -6.9, 1),
	["IronSightTime"] = 0.46,
}

SWEP.AnomalySightReticles = {
	["scope_anomaly_mosinscope"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_mosin",
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_sks_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.1691, -3.9785)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_sks")
	killicon.Add("cw_anomaly_sks", "vgui/killicons/tfa_anomaly_sks", Color(255, 255, 255))
end
