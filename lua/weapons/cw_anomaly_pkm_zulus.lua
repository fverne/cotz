-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Zulu's PKM"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/pkm_zulus.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_pkm_zulus_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 2

SWEP.SlotPos = 73

SWEP.NormalHoldType = "ar2"

SWEP.RunHoldType = "passive"

SWEP.FireModes = {
	[1] = "auto",
}

SWEP.Primary = {
	["ClipSize"] = 100,
	["DefaultClip"] = 400,
	["Automatic"] = true,
	["Ammo"] = "7.62x54MMR",
}

SWEP.FireDelay = 0.08823529411764706

SWEP.FireSound = "TFA_ANOMALY.PKM.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.PKM.FIRE"

SWEP.Damage = 180

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.14

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.6

SWEP.SpreadPerShot = 0.007

SWEP.MaxSpreadInc = 0.07

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 3

SWEP.SpeedDec = 40

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 8.0

SWEP.ReloadTime_Empty = 8.0

SWEP.ReloadHalt = 8.0

SWEP.ReloadHalt_Empty = 8.0

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-3.4759, 0, 0.5925)

SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.SprintPos = Vector(7, -7.6, 1)

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
			["sound"] = "TFA_ANOMALY.PKM.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PKM.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PKM.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PKM.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PKM.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.8,
	["anm_idle"] = 6.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_reload"] = 8.0,
	["anm_reload_empty"] = 8.0,
	["anm_shots"] = 0.5,
	["anm_shots_aim"] = 0.5,
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

SWEP.WearEffect = 0.007

SWEP.MuzzleAttachmentName = "muzzle"

SWEP.MuzzleEffect = "muzzleflash_ak74"

SWEP.Shell = "mainshell"

SWEP.AttachmentModelsVM = {}

SWEP.Attachments = {
	[1] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -400,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_762x54_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_ammo_762x54_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV"] = 70,
	},
	["StencilSight_MinPercent"] = 0.7,
	["StencilSight_FollowRecoil"] = true,
	["StencilSight_ReticleSize"] = 150,
	["StencilSight_ReticleMaterial"] = "models/flaymi/stalker/anomaly/attachments/wpn_addon_scope_ko",
	["StencilSight_ReticleType"] = "RETICLE_FLAT",
	["StencilSight_VElement"] = "sight_anomaly_pkm_lense",
	["StencilSight_UseMask"] = true,
	["MuzzleAttachmentSilenced"] = 2,
	["RunSightsAng"] = Vector(-13, 50, -10),
	["RunSightsPos"] = Vector(7, -7.6, 1),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 29750.0,
		["RPM"] = 680,
		["Ammo"] = "7.62x54MMR",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.027731092436975,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.762,
		["Automatic"] = true,
		["Spread"] = 0.034,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.PKM.FIRE",
		["Damage"] = 38.5,
		["DefaultClip"] = 400,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 100,
		["IronAccuracy"] = 0.0034,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["StencilSight"] = true,
	["WElements"] = {},
	["VElements"] = {
		["sight_anomaly_pkm_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_pkm_zulus_lense_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.9, 0.9, 0.9),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "body",
			["rel"] = "",
			["active"] = true,
			["skin"] = 0,
			["pos"] = Vector(0, -0.65, 1),
		},
	},
	["IronSightsAng"] = Vector(0, 0, 0),
	["Silenced"] = false,
	["IronSightsPos"] = Vector(-3.4759, 0, 0.5925),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_pkm_zulus_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 5.768, -2.9138)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_pkm_zulus")
	killicon.Add("cw_anomaly_pkm_zulus", "vgui/killicons/tfa_anomaly_pkm_zulus", Color(255, 255, 255))
end
