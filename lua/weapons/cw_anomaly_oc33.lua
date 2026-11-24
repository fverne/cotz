-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "OTs-33 “Pernach”"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/oc33.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_oc33_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 1

SWEP.SlotPos = 73

SWEP.NormalHoldType = "pistol"

SWEP.RunHoldType = "normal"

SWEP.FireModes = {
	[1] = "auto",
	[2] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 27,
	["DefaultClip"] = 108,
	["Automatic"] = true,
	["Ammo"] = "9x18MM",
}

SWEP.FireDelay = 0.075

SWEP.FireSound = "TFA_ANOMALY.OC33.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.OC33.FIRE_SILENCED"

SWEP.Damage = 46

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.05

SWEP.AimSpread = 0.02

SWEP.Recoil = 1.25

SWEP.SpreadPerShot = 0.006

SWEP.MaxSpreadInc = 0.05

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 3

SWEP.SpeedDec = 0

SWEP.DeployTime = 0.566667

SWEP.ReloadSpeed = 1
SWEP.ReloadChamberCuts = {
	anm_reload = {from = 2.100000, to = 2.866667},
}

SWEP.ReloadTime = 3.2

SWEP.ReloadTime_Empty = 3.2

SWEP.ReloadHalt = 3.2

SWEP.ReloadHalt_Empty = 3.2

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.26, -1, 2.604)

SWEP.IronsightAng = Vector(0.35, 0.4, 0)

SWEP.SprintPos = Vector(0, -2, 4.1)

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
			["sound"] = "TFA_ANOMALY.OC33.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.OC33.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.OC33.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.OC33.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.OC33.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.566667,
	["anm_idle"] = 6.333333,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.833333,
	["anm_reload"] = 3.2,
	["anm_reload_empty"] = 3.2,
	["anm_shots"] = 0.3,
	["anm_shots_aim"] = 0.3,
	["anm_show"] = 0.566667,
	["anm_show_first"] = 0.566667,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots_aim"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.14

SWEP.DurabilityDamageChance = 0.01

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
			[1] = "cw_anomaly_sil_aps",
		},
	},
	[2] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_9x18_pmm",
			[2] = "cw_anomaly_ammo_9x18_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sil_aps",
	[2] = "cw_anomaly_ammo_9x18_pmm",
	[3] = "cw_anomaly_ammo_9x18_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV"] = 70,
	},
	["Primary"] = {
		["KickDown"] = 0.155,
		["HullSize"] = 0,
		["Range"] = 8925.0,
		["RPM"] = 800,
		["Ammo"] = "9x18MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.OC33.FIRE_SILENCED",
		["RangeFalloff"] = 0.03249299719888,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 1,
		["Automatic"] = true,
		["Spread"] = 0.049,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.31,
		["Sound"] = "TFA_ANOMALY.OC33.FIRE",
		["Damage"] = 22.5,
		["DefaultClip"] = 108,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 27,
		["IronAccuracy"] = 0.0049,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.155,
	},
	["RunSightsAng"] = Vector(-19, 3, -6),
	["Silenced"] = false,
	["IronSightTime"] = 0.46,
	["MuzzleAttachmentSilenced"] = 2,
	["RunSightsPos"] = Vector(0, -2, 4.1),
	["IronSightsAng"] = Vector(0.35, 0.4, 0),
	["WElements"] = {
		["anomaly_sil_aps"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_sil_aps.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1.1, 1.1, 1.1),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 1.73, -0.28),
		},
	},
	["VElements"] = {
		["anomaly_sil_aps"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/sil_aps.mdl",
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
			["pos"] = Vector(0.044, 0.2, 0.23),
		},
	},
	["IronSightsPos"] = Vector(-4.26, -1, 2.604),
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_oc33_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 4.5813, -2.7096)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "pistol"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_oc33")
	killicon.Add("cw_anomaly_oc33", "vgui/killicons/tfa_anomaly_oc33", Color(255, 255, 255))
end
