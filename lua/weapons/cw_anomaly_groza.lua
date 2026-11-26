-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "OTs-14-4A"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/groza.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_groza_w.mdl"

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
	["ClipSize"] = 20,
	["DefaultClip"] = 80,
	["Automatic"] = true,
	["Ammo"] = "9x39MM",
}

SWEP.FireDelay = 0.08571428571428572

SWEP.FireSound = "TFA_ANOMALY.GROZA.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.GROZA.FIRE"

SWEP.Damage = 170

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.1

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.7

SWEP.SpreadPerShot = 0.015

SWEP.MaxSpreadInc = 0.15

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 3

SWEP.SpeedDec = 20

SWEP.DeployTime = 0.766667

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 2.533333

SWEP.ReloadTime_Empty = 4.466667

SWEP.ReloadHalt = 2.533333

SWEP.ReloadHalt_Empty = 4.466667

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-3.336, -5, 0.486)

SWEP.IronsightAng = Vector(0.6, 0, 0)

SWEP.SprintPos = Vector(7.5, -6.6, 0.5)

SWEP.SprintAng = Vector(-15, 52, -13)

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
	["anm_hide_w_gl_setup"] = "anm_hide_w_gl_setup",
	["anm_idle"] = "anm_idle",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_w_gl_setup"] = "anm_idle_w_gl_setup",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_w_gl_setup"] = "anm_idle_sprint_w_gl_setup",
	["anm_sw_on"] = "anm_sw_on",
	["anm_sw_off"] = "anm_sw_off",
	["anm_reload_g"] = "anm_reload_g",
	["anm_reload"] = "anm_reload",
	["anm_reload_empty"] = "anm_reload_empty",
	["anm_shots"] = "anm_shots",
	["anm_shots_g"] = "anm_shots_g",
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
	["anm_show_w_gl_setup"] = "anm_show_w_gl_setup",
	["anm_show_w_gl_setup_first"] = "anm_show_w_gl_setup_first",
}

SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GROZA.Holster",
		},
	},
	["anm_hide_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GROZA.Holster",
		},
	},
	["anm_sw_on"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GROZA.Switch",
		},
	},
	["anm_sw_off"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GROZA.Switch",
		},
	},
	["anm_reload_g"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GROZA.ReloadG",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GROZA.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GROZA.ReloadEmpty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GROZA.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GROZA.Draw",
		},
	},
	["anm_show_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GROZA.Draw",
		},
	},
	["anm_show_w_gl_setup_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GROZA.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.8,
	["anm_hide_w_gl_setup"] = 0.8,
	["anm_idle"] = 0.033333,
	["anm_idle_aim"] = 0.033333,
	["anm_idle_w_gl_setup"] = 0.033333,
	["anm_idle_sprint"] = 0.8,
	["anm_idle_sprint_w_gl_setup"] = 0.8,
	["anm_sw_on"] = 1.533333,
	["anm_sw_off"] = 1.6,
	["anm_reload_g"] = 2.0,
	["anm_reload"] = 2.533333,
	["anm_reload_empty"] = 4.466667,
	["anm_shots"] = 0.433333,
	["anm_shots_g"] = 0.433333,
	["anm_show"] = 0.766667,
	["anm_show_first"] = 0.766667,
	["anm_show_w_gl_setup"] = 0.766667,
	["anm_show_w_gl_setup_first"] = 0.766667,
}

SWEP.AnomalyLauncherReloadTime = 2.0

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0.05

SWEP.DurabilityDamage = 0.005

SWEP.FireMoveMod = 0.6

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
			[1] = "cw_anomaly_gl_groza",
		},
	},
	[2] = {
		["header"] = "Attachments",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_scope_po4x34",
		},
	},
	[3] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -100,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_9x39_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_gl_groza",
	[2] = "cw_anomaly_scope_po4x34",
	[3] = "cw_anomaly_ammo_9x39_ap",
}

SWEP.AnomalySource = {
	["Secondary"] = {
		["IronFOV_PO4X34"] = 60,
		["IronFOV"] = 70,
	},
	["IronSightsAng_GL"] = Vector(8, -0.3, 0),
	["MuzzleAttachmentSilenced"] = 2,
	["Primary"] = {
		["KickDown"] = 0.185,
		["HullSize"] = 0,
		["Range"] = 11900.0,
		["RPM"] = 700,
		["Ammo"] = "9x39MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["RangeFalloff"] = 0.025210084033613,
		["GLSound"] = "TFA_ANOMALY.GROZA.ShootGL",
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 0.5,
		["Automatic"] = true,
		["Damage"] = 31,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.37,
		["Sound"] = "TFA_ANOMALY.GROZA.FIRE",
		["IronAccuracy"] = 0.0037,
		["DefaultClip"] = 80,
		["DamageTypeHandled"] = true,
		["ClipSize"] = 20,
		["Spread"] = 0.037,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.185,
	},
	["WElements"] = {
		["scope_anomaly_po4x34"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_addon_scope_po4x34_w.mdl",
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
		["scope_anomaly_po4x34"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_addon_scope_po4x34.mdl",
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
	["RunSightsAng"] = Vector(-15, 52, -13),
	["IronSightsPos"] = Vector(-3.336, -5, 0.486),
	["Silenced"] = false,
	["IronSightsPos_GL"] = Vector(0, 0, -2),
	["IronSightsAng"] = Vector(0.6, 0, 0),
	["RunSightsPos"] = Vector(7.5, -6.6, 0.5),
	["IronSightsAng_PO4X34"] = Vector(0, 0, 0),
	["IronSightsPos_PO4X34"] = Vector(-3.334, -7, -0.653),
	["IronSightTime"] = 0.46,
}

SWEP.AnomalySightReticles = {
	["scope_anomaly_po4x34"] = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_po4x34",
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_groza_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1, 5.2861, -4.9797)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_groza")
	killicon.Add("cw_anomaly_groza", "vgui/killicons/tfa_anomaly_groza", Color(255, 255, 255))
end
