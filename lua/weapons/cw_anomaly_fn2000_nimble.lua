-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "FN F2000 “EOTech”"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/fn2000_nimble.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_fn2000_nimble_w.mdl"

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
	["Ammo"] = "5.56x45MM",
}

SWEP.FireDelay = 0.0670391061452514

SWEP.FireSound = "TFA_ANOMALY.FN2000.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.FN2000.FIRE_SILENCED"

SWEP.Damage = 80

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.1

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.0

SWEP.SpreadPerShot = 0.008

SWEP.MaxSpreadInc = 0.09

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 3

SWEP.SpeedDec = 25

SWEP.DeployTime = 1.0

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.333333

SWEP.ReloadTime_Empty = 3.333333

SWEP.ReloadHalt = 3.333333

SWEP.ReloadHalt_Empty = 3.333333

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-5.55, -6, -0.765)

SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.SprintPos = Vector(7, -8.2, 0)

SWEP.SprintAng = Vector(-15, 50, -14)

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
			["sound"] = "TFA_ANOMALY.FN2000.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FN2000.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FN2000.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FN2000.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FN2000.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 1.3,
	["anm_idle"] = 3.333333,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_reload"] = 3.333333,
	["anm_reload_empty"] = 3.333333,
	["anm_shots"] = 0.5,
	["anm_shots_aim"] = 0.5,
	["anm_show"] = 1.0,
	["anm_show_first"] = 1.0,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots_aim"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.05

SWEP.DurabilityDamage = 0.005

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
			[1] = "cw_anomaly_sil_nato",
		},
	},
	[2] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_556x45_ss190",
			[2] = "cw_anomaly_ammo_556x45_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sil_nato",
	[2] = "cw_anomaly_ammo_556x45_ss190",
	[3] = "cw_anomaly_ammo_556x45_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV"] = 70,
	},
	["StencilSight_MinPercent"] = 0.7,
	["StencilSight_FollowRecoil"] = true,
	["StencilSight_ReticleSize"] = 75,
	["StencilSight_ReticleMaterial"] = "models/flaymi/stalker/anomaly/attachments/wpn_addon_scope_eot_sight",
	["StencilSight_ReticleType"] = "RETICLE_FLAT",
	["StencilSight_VElement"] = "sight_anomaly_fn2000_lense",
	["StencilSight_UseMask"] = true,
	["MuzzleAttachmentSilenced"] = 2,
	["RunSightsAng"] = Vector(-15, 50, -14),
	["RunSightsPos"] = Vector(7, -8.2, 0),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 29750.0,
		["RPM"] = 895,
		["Ammo"] = "5.56x45MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.FN2000.FIRE_SILENCED",
		["RangeFalloff"] = 0.030924369747899,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.7,
		["Automatic"] = true,
		["Spread"] = 0.029,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.FN2000.FIRE",
		["Damage"] = 25.5,
		["DefaultClip"] = 120,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 30,
		["IronAccuracy"] = 0.0029,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {
		["anomaly_sil_nato"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/w_wpn_sil_nato.mdl",
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
			["pos"] = Vector(0, -0.04, 3.9),
		},
	},
	["StencilSight"] = true,
	["VElements"] = {
		["sight_anomaly_fn2000_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_fn2000_nimble_lense_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(0, 0, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "body",
			["rel"] = "",
			["active"] = true,
			["skin"] = 0,
			["pos"] = Vector(0, 0, 0),
		},
		["anomaly_sil_nato"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_sil_nato.mdl",
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
			["pos"] = Vector(0, -0.7, 2.6),
		},
	},
	["IronSightsAng"] = Vector(0, 0, 0),
	["Silenced"] = false,
	["IronSightsPos"] = Vector(-5.55, -6, -0.765),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_fn2000_nimble_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.6498, -4.2213)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_fn2000_nimble")
	killicon.Add("cw_anomaly_fn2000_nimble", "vgui/killicons/tfa_anomaly_fn2000_nimble", Color(255, 255, 255))
end
