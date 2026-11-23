-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Karabiner 98 Kurz"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/kar98k.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_kar98k_w.mdl"

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
	["Ammo"] = "",
}

SWEP.FireDelay = 2.142857142857143

SWEP.FireSound = "TFA_ANOMALY.K98.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.K98.FIRE_SILENCED"

SWEP.Damage = 190

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.15

SWEP.AimSpread = 0.005

SWEP.Recoil = 2.2

SWEP.SpreadPerShot = 0.09

SWEP.MaxSpreadInc = 0.9

SWEP.SpreadCooldown = 0.25

SWEP.VelocitySensitivity = 9

SWEP.SpeedDec = 25

SWEP.ClumpSpread = 0.0013

SWEP.DeployTime = 1.066667

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 1.033333

SWEP.ReloadTime_Empty = 1

SWEP.ReloadHalt = 1.033333

SWEP.ReloadHalt_Empty = 1

SWEP.ShotgunReload = true

SWEP.ReloadStartTime = 1.033333

SWEP.InsertShellTime = 1.233333

SWEP.ReloadFinishWait = 1.2

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = false

SWEP.IronsightPos = Vector(-4.07, 0, 3)

SWEP.IronsightAng = Vector(-0.25, -0.02, 0)

SWEP.SprintPos = Vector(8, -7.1, 0.15)

SWEP.SprintAng = Vector(-14, 52, -13)

SWEP.ZoomAmount = 20

SWEP.AimViewModelFOV = 55

SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_open",
	["reload_start"] = "anm_open",
	["insert"] = "anm_add_cartridge",
	["reload_end"] = "anm_close",
	["anm_hide"] = "anm_hide",
	["anm_idle"] = "anm_idle",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_open"] = "anm_open",
	["anm_add_cartridge"] = "anm_add_cartridge",
	["anm_close"] = "anm_close",
	["anm_shots"] = "anm_shots",
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
}

SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.K98.Holster",
		},
	},
	["anm_open"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.K98.ReloadStart",
		},
	},
	["anm_add_cartridge"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.K98.ReloadInsert",
		},
	},
	["anm_close"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.K98.ReloadEnd",
		},
	},
	["anm_shots"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.K98.Bolt",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.K98.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.K98.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 1.0,
	["anm_idle"] = 6.7,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.833333,
	["anm_open"] = 1.033333,
	["anm_add_cartridge"] = 1.233333,
	["anm_close"] = 1.2,
	["anm_shots"] = 2.666667,
	["anm_show"] = 1.066667,
	["anm_show_first"] = 1.066667,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.33

SWEP.DurabilityDamageChance = 0.01

SWEP.FireMoveMod = 0.6

SWEP.WearEffect = 0.005

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
			[1] = "cw_anomaly_scope_zf4",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sil_nato",
	[2] = "cw_anomaly_scope_zf4",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_ZF4"] = 60,
		["IronFOV"] = 70,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["Primary"] = {
		["KickDown"] = 0.3,
		["HullSize"] = 0,
		["Range"] = 32725.0,
		["RPM"] = 28,
		["Ammo"] = "",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.K98.FIRE_SILENCED",
		["RangeFalloff"] = 0.023223834988541,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 2.35,
		["Automatic"] = false,
		["Spread"] = 0.013,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.6,
		["Sound"] = "TFA_ANOMALY.K98.FIRE",
		["Damage"] = 57.5,
		["DefaultClip"] = 20,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 5,
		["IronAccuracy"] = 0.0013,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.3,
	},
	["WElements"] = {
		["anomaly_sil_nato"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_k98_sil_w.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.1, 1.1, 1.1),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 1.69, -0.1),
		},
		["scope_anomaly_zf4"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_k98_stock_w.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.15, 0.25, 2),
		},
	},
	["VElements"] = {
		["anomaly_sil_nato"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_k98_sil.mdl",
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
			["pos"] = Vector(0, -0.3, -2.5),
		},
		["scope_anomaly_zf4"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_k98_stock.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.15, 0.25, 2),
		},
	},
	["RunSightsAng"] = Vector(-14, 52, -13),
	["IronSightsAng_ZF4"] = Vector(0, 0, 0),
	["Silenced"] = false,
	["IronSightsPos_ZF4"] = Vector(-3.9912, -5.5, 2.053),
	["IronSightsAng"] = Vector(-0.25, -0.02, 0),
	["RunSightsPos"] = Vector(8, -7.1, 0.15),
	["IronSightsPos"] = Vector(-4.07, 0, 3),
	["IronSightTime"] = 0.46,
}

SWEP.AnomalySightReticles = {
	["scope_anomaly_zf4"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_zf9",
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_kar98k_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 7.8824, -1.6934)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_k98")
	killicon.Add("cw_anomaly_k98", "vgui/killicons/tfa_anomaly_k98", Color(255, 255, 255))
end

SWEP.AnomalyAmmoUnavailable = true
