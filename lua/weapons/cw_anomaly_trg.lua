-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "Sako TRG-42"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/trg.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_trg_w.mdl"

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
	["Ammo"] = ".338 Lapua",
}

SWEP.FireDelay = 2.608695652173913

SWEP.FireSound = "TFA_ANOMALY.TRG.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.TRG.FIRE_SILENCED"

SWEP.Damage = 450

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.12

SWEP.AimSpread = 0.005

SWEP.Recoil = 4.2

SWEP.SpreadPerShot = 0.1

SWEP.MaxSpreadInc = 0.4

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 15

SWEP.SpeedDec = 30

SWEP.DeployTime = 1.066667

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 4.433333

SWEP.ReloadTime_Empty = 4.433333

SWEP.ReloadHalt = 4.433333

SWEP.ReloadHalt_Empty = 4.433333

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-4.4598, -10, 0.603)

SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.SprintPos = Vector(7.2, -6.5, -0.5)

SWEP.SprintAng = Vector(-13.5, 50.6, -13.5)

SWEP.ZoomAmount = 30

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
			["sound"] = "TFA_ANOMALY.TRG.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TRG.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TRG.Reload",
		},
	},
	["anm_shots"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TRG.Bolt",
		},
	},
	["anm_shots_aim"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TRG.Bolt",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TRG.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TRG.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.533333,
	["anm_idle"] = 6.7,
	["anm_idle_aim"] = 0.066667,
	["anm_idle_sprint"] = 0.8,
	["anm_reload"] = 4.433333,
	["anm_reload_empty"] = 4.433333,
	["anm_shots"] = 2.1,
	["anm_shots_aim"] = 2.1,
	["anm_show"] = 1.066667,
	["anm_show_first"] = 1.066667,
}

SWEP.AnomalyScopeZoom = 10

SWEP.AnomalyReticle = "models/flaymi/stalker/anomaly/weapons/trg/wpn_crosshair_findot"

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
			[1] = "cw_anomaly_sil_57",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sil_57",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["ScopeZoom"] = 10,
		["IronFOV"] = 60,
	},
	["MuzzleAttachmentSilenced"] = 2,
	["RunSightsAng"] = Vector(-13.5, 50.6, -13.5),
	["RunSightsPos"] = Vector(7.2, -6.5, -0.5),
	["Primary"] = {
		["KickDown"] = 0.25,
		["HullSize"] = 0,
		["Range"] = 44625.0,
		["RPM"] = 23,
		["Ammo"] = ".338 Lapua",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.TRG.FIRE_SILENCED",
		["RangeFalloff"] = 0.01884593837535,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 2.72,
		["Automatic"] = false,
		["Spread"] = 0.039,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.TRG.FIRE",
		["Damage"] = 67.5,
		["DefaultClip"] = 20,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 5,
		["IronAccuracy"] = 0.00039,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["WElements"] = {
		["anomaly_sil_57"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_trg_sil_w.mdl",
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
			["pos"] = Vector(0, 1.86, -0.8),
		},
	},
	["VElements"] = {
		["anomaly_sil_57"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_trg_sil_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(0, 0, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(1, 1, 1),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "wpn_silencer",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0, 0, 0),
		},
	},
	["IronSightsAng"] = Vector(0, 0, 0),
	["Silenced"] = false,
	["IronSightsPos"] = Vector(-4.4598, -10, 0.603),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_trg_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 3.7669, -2.8391)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_trg")
	killicon.Add("cw_anomaly_trg", "vgui/killicons/tfa_anomaly_trg", Color(255, 255, 255))
end
