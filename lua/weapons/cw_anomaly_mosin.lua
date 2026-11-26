-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Mosin rifle"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/mosin.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_mosin_w.mdl"

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
	["ClipSize"] = 5,
	["DefaultClip"] = 20,
	["Automatic"] = false,
	["Ammo"] = "7.62x54MMR",
}

SWEP.FireDelay = 2.4

SWEP.FireSound = "TFA_ANOMALY.MOSIN.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.MOSIN.FIRE"

SWEP.Damage = 190

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.15

SWEP.AimSpread = 0.005

SWEP.Recoil = 2.2

SWEP.SpreadPerShot = 0.09

SWEP.MaxSpreadInc = 0.9

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 9

SWEP.SpeedDec = 25

SWEP.DeployTime = 1.066667

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 5.4

SWEP.ReloadTime_Empty = 5.4

SWEP.ReloadHalt = 5.4

SWEP.ReloadHalt_Empty = 5.4

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.142, -5, 2.8)

SWEP.IronsightAng = Vector(0.029, 0, 0)

SWEP.SprintPos = Vector(6.3, -10.6, 0.4)

SWEP.SprintAng = Vector(-16, 49, -17)

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
			["sound"] = "TFA_ANOMALY.MOSIN.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MOSIN.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MOSIN.Reload",
		},
	},
	["anm_shots"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MOSIN.Bolt",
		},
	},
	["anm_shots_aim"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MOSIN.Bolt",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MOSIN.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MOSIN.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 1.0,
	["anm_idle"] = 6.7,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.833333,
	["anm_reload"] = 5.4,
	["anm_reload_empty"] = 5.4,
	["anm_shots"] = 2.533333,
	["anm_shots_aim"] = 2.533333,
	["anm_show"] = 1.066667,
	["anm_show_first"] = 1.066667,
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
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_762x54_ap",
			[2] = "cw_anomaly_ammo_762x54_7h14",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_mosin",
	[2] = "cw_anomaly_ammo_762x54_ap",
	[3] = "cw_anomaly_ammo_762x54_7h14",
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
			["bonemerge"] = true,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 0, 0),
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
			["bonemerge"] = true,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 0, 0),
		},
	},
	["IronSightsPos_MOSINSCOPE"] = Vector(-4.068, -10, 1.23),
	["RunSightsAng"] = Vector(-16, 49, -17),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 32725.0,
		["RPM"] = 25,
		["Ammo"] = "7.62x54MMR",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.025821237585943,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 1.98,
		["Automatic"] = false,
		["Spread"] = 0.012,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.MOSIN.FIRE",
		["Damage"] = 55,
		["DefaultClip"] = 20,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 5,
		["IronAccuracy"] = 0.0012,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["Silenced"] = false,
	["IronSightsAng"] = Vector(0.029, 0, 0),
	["IronSightsPos"] = Vector(-4.142, -5, 2.8),
	["RunSightsPos"] = Vector(6.3, -10.6, 0.4),
	["IronSightTime"] = 0.46,
}

SWEP.AnomalySightReticles = {
	["scope_anomaly_mosinscope"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_mosin",
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_mosin_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 3.6797, -3.8353)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_mosin")
	killicon.Add("cw_anomaly_mosin", "vgui/killicons/tfa_anomaly_mosin", Color(255, 255, 255))
end
