-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Desert Eagle “Steppe Eagle”"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/desert_eagle_nimble.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_desert_eagle_nimble_w.mdl"

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
	["ClipSize"] = 9,
	["DefaultClip"] = 36,
	["Automatic"] = false,
	["Ammo"] = ".357 Magnum",
}

SWEP.FireDelay = 0.08

SWEP.FireSound = "TFA_ANOMALY.DESERT_EAGLE.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.DESERT_EAGLE.FIRE"

SWEP.Damage = 125

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.07

SWEP.AimSpread = 0.008

SWEP.Recoil = 2.3

SWEP.SpreadPerShot = 0.06

SWEP.MaxSpreadInc = 0.15

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 2

SWEP.SpeedDec = 5

SWEP.DeployTime = 0.7

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 2.533333

SWEP.ReloadTime_Empty = 3.2

SWEP.ReloadHalt = 2.533333

SWEP.ReloadHalt_Empty = 3.2

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-3.755, -1, 1.45)

SWEP.IronsightAng = Vector(-0.3, 0, 0)

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
			["sound"] = "TFA_ANOMALY.DESERT_EAGLE.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.DESERT_EAGLE.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.DESERT_EAGLE.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.DESERT_EAGLE.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.DESERT_EAGLE.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.DESERT_EAGLE.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.DESERT_EAGLE.Draw",
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
	["anm_reload"] = 2.533333,
	["anm_reload_empty"] = 3.2,
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

SWEP.Attachments = {}

SWEP.AnomalyAttachmentOrder = {}

SWEP.AnomalySource = {
	["StencilSight_MinPercent"] = 0.7,
	["Secondary"] = {
		["IronFOV"] = 70,
	},
	["StencilSight_FollowRecoil"] = true,
	["StencilSight_ReticleSize"] = 75,
	["StencilSight_ReticleMaterial"] = "models/flaymi/stalker/anomaly/weapons/desert_eagle/wpn_addon_scope_c-more_crosshair_dot",
	["StencilSight_ReticleType"] = "RETICLE_FLAT",
	["StencilSight_VElement"] = "sight_anomaly_deagle_lense",
	["StencilSight_UseMask"] = true,
	["MuzzleAttachmentSilenced"] = 2,
	["RunSightsAng"] = Vector(-19, 3, -6),
	["RunSightsPos"] = Vector(0, -1, 3.8),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 14875.0,
		["RPM"] = 263,
		["Ammo"] = ".357 Magnum",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.029579831932773,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 2.0,
		["Automatic"] = false,
		["Spread"] = 0.058,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.DESERT_EAGLE.FIRE",
		["Damage"] = 30,
		["DefaultClip"] = 36,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 9,
		["IronAccuracy"] = 0.0058,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {},
	["VElements"] = {
		["sight_anomaly_deagle_lense"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_desert_eagle_nimble_lense_hud.mdl",
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
	},
	["StencilSight"] = true,
	["IronSightsAng"] = Vector(-0.3, 0, 0),
	["Silenced"] = false,
	["IronSightsPos"] = Vector(-3.755, -1, 1.45),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_desert_eagle_nimble_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.1828, -2.6747)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "pistol"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_desert_eagle_nimble")
	killicon.Add("cw_anomaly_desert_eagle_nimble", "vgui/killicons/tfa_anomaly_desert_eagle_nimble", Color(255, 255, 255))
end
