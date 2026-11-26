-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "AKS-74UNB (custom)"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/ak74u_snag.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_ak74u_snag_w.mdl"

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
	["ClipSize"] = 45,
	["DefaultClip"] = 180,
	["Automatic"] = true,
	["Ammo"] = "5.45x39MM",
}

SWEP.FireDelay = 0.08

SWEP.FireSound = "TFA_ANOMALY.AK74USNAG.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.AK74USNAG.FIRE_SILENCED"

SWEP.Damage = 70

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.08

SWEP.AimSpread = 0.025

SWEP.Recoil = 1.6

SWEP.SpreadPerShot = 0.01

SWEP.MaxSpreadInc = 0.05

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 4

SWEP.SpeedDec = 10

SWEP.DeployTime = 1.033333

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.066667

SWEP.ReloadTime_Empty = 3.066667

SWEP.ReloadHalt = 3.066667

SWEP.ReloadHalt_Empty = 3.066667

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.518, 0, 0.748)

SWEP.IronsightAng = Vector(0.2, 0.05, 0)

SWEP.SprintPos = Vector(5, -8.5, 0.25)

SWEP.SprintAng = Vector(-13, 45, -12)

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
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
}

SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK74USNAG.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK74USNAG.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK74USNAG.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK74USNAG.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK74USNAG.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 1.033333,
	["anm_idle"] = 6.666667,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_reload"] = 3.066667,
	["anm_reload_empty"] = 3.066667,
	["anm_shots"] = 0.433333,
	["anm_show"] = 1.033333,
	["anm_show_first"] = 1.033333,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = true

SWEP.AnomalyAimFire = "anm_shots"

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
			[1] = "cw_anomaly_ammo_545x39_ep",
			[2] = "cw_anomaly_ammo_545x39_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_ammo_545x39_ep",
	[2] = "cw_anomaly_ammo_545x39_ap",
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
	["StencilSight_VElement"] = "sight_anomaly_kobra_lense",
	["StencilSight_UseMask"] = true,
	["RunSightsAng"] = Vector(-13, 45, -12),
	["RunSightsPos"] = Vector(5, -8.5, 0.25),
	["MuzzleAttachmentSilenced"] = 2,
	["Primary"] = {
		["KickDown"] = 0.205,
		["HullSize"] = 0,
		["Range"] = 26775.0,
		["RPM"] = 750,
		["Ammo"] = "5.45x39MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.AK74USNAG.FIRE_SILENCED",
		["RangeFalloff"] = 0.027936507936508,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.646,
		["Automatic"] = true,
		["Spread"] = 0.053,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.41,
		["Sound"] = "TFA_ANOMALY.AK74USNAG.FIRE",
		["Damage"] = 24.3,
		["DefaultClip"] = 180,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 45,
		["IronAccuracy"] = 0.0053,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.205,
	},
	["StencilSight"] = true,
	["WElements"] = {},
	["VElements"] = {
		["sight_anomaly_kobra_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_9a91_kobra_lense_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.9, 0.9, 0.9),
			["material"] = "",
			["bonemerge"] = false,
			["bone"] = "body",
			["rel"] = "",
			["active"] = true,
			["skin"] = 0,
			["pos"] = Vector(0, -0.65, 1),
		},
	},
	["IronSightsAng"] = Vector(0.2, 0.05, 0),
	["Silenced"] = true,
	["IronSightsPos"] = Vector(-4.518, 0, 0.748),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_ak74u_snag_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 5.4978, -6.002)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_ak74u_snag")
	killicon.Add("cw_anomaly_ak74u_snag", "vgui/killicons/tfa_anomaly_ak74u_snag", Color(255, 255, 255))
end
