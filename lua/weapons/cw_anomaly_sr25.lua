-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"

SWEP.PrintName = "SR-25"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/sr25.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_sr25_w.mdl"

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
	["Ammo"] = "7.62x51MM",
}

SWEP.FireDelay = 0.08571428571428572

SWEP.FireSound = "TFA_ANOMALY.SR25.FIRE"

SWEP.FireSoundSuppressed = "TFA_ANOMALY.SR25.FIRE_SILENCED"

SWEP.Damage = 150

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0.13

SWEP.AimSpread = 0.005

SWEP.Recoil = 1.7

SWEP.SpreadPerShot = 0.017

SWEP.MaxSpreadInc = 0.2

SWEP.SpreadCooldown = 0.2

SWEP.VelocitySensitivity = 4

SWEP.SpeedDec = 30

SWEP.DeployTime = 1.1

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 3.166667

SWEP.ReloadTime_Empty = 3.166667

SWEP.ReloadHalt = 3.166667

SWEP.ReloadHalt_Empty = 3.166667

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = true

SWEP.IronsightPos = Vector(-3.78, -7.5, 1.512)

SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.SprintPos = Vector(7, -6.2, 0)

SWEP.SprintAng = Vector(-19, 48.5, -20)

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
	["anm_hide_w_gl"] = "anm_hide_w_gl",
	["anm_hide_w_gl_setup"] = "anm_hide_w_gl_setup",
	["anm_idle"] = "anm_idle",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_w_gl"] = "anm_idle_w_gl",
	["anm_idle_w_gl_aim"] = "anm_idle_w_gl_aim",
	["anm_idle_w_gl_setup"] = "anm_idle_w_gl_setup",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_w_gl"] = "anm_idle_sprint_w_gl",
	["anm_idle_sprint_w_gl_setup"] = "anm_idle_sprint_w_gl_setup",
	["anm_reload_g"] = "anm_reload_g",
	["anm_reload"] = "anm_reload",
	["anm_reload_empty"] = "anm_reload_empty",
	["anm_reload_w_gl"] = "anm_reload_w_gl",
	["anm_reload_empty_w_gl"] = "anm_reload_empty_w_gl",
	["anm_shots"] = "anm_shots",
	["anm_shots_w_gl"] = "anm_shots_w_gl",
	["anm_shots_g"] = "anm_shots_g",
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
	["anm_show_w_gl"] = "anm_show_w_gl",
	["anm_show_w_gl_first"] = "anm_show_w_gl_first",
	["anm_show_w_gl_setup"] = "anm_show_w_gl_setup",
	["anm_show_w_gl_setup_first"] = "anm_show_w_gl_setup_first",
	["anm_sw_on"] = "anm_sw_on",
	["anm_sw_off"] = "anm_sw_off",
}

SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Holster",
		},
	},
	["anm_hide_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Holster",
		},
	},
	["anm_hide_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Holster",
		},
	},
	["anm_reload_g"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.ReloadG",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Reload",
		},
	},
	["anm_reload_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Reload",
		},
	},
	["anm_reload_empty_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Draw",
		},
	},
	["anm_show_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Draw",
		},
	},
	["anm_show_w_gl_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Draw",
		},
	},
	["anm_show_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Draw",
		},
	},
	["anm_show_w_gl_setup_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Draw",
		},
	},
	["anm_sw_on"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Switch",
		},
	},
	["anm_sw_off"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SR25.Switch",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 1.1,
	["anm_hide_w_gl"] = 1.1,
	["anm_hide_w_gl_setup"] = 1.1,
	["anm_idle"] = 6.733333,
	["anm_idle_aim"] = 0.1,
	["anm_idle_w_gl"] = 6.733333,
	["anm_idle_w_gl_aim"] = 0.1,
	["anm_idle_w_gl_setup"] = 6.733333,
	["anm_idle_sprint"] = 0.866667,
	["anm_idle_sprint_w_gl"] = 0.866667,
	["anm_idle_sprint_w_gl_setup"] = 0.866667,
	["anm_reload_g"] = 3.266667,
	["anm_reload"] = 3.166667,
	["anm_reload_empty"] = 3.166667,
	["anm_reload_w_gl"] = 3.133333,
	["anm_reload_empty_w_gl"] = 3.133333,
	["anm_shots"] = 0.4,
	["anm_shots_w_gl"] = 0.4,
	["anm_shots_g"] = 0.833333,
	["anm_show"] = 1.1,
	["anm_show_first"] = 1.1,
	["anm_show_w_gl"] = 1.1,
	["anm_show_w_gl_first"] = 1.1,
	["anm_show_w_gl_setup"] = 1.1,
	["anm_show_w_gl_setup_first"] = 1.1,
	["anm_sw_on"] = 1.133333,
	["anm_sw_off"] = 1.133333,
}

SWEP.AnomalyScopeZoom = 10

SWEP.AnomalyReticle = "models/flaymi/stalker/anomaly/weapons/l96/wpn_crosshair_mark4"

SWEP.AnomalyLauncherReloadTime = 3.266667

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
			[1] = "cw_anomaly_sil_sr25",
		},
	},
	[2] = {
		["header"] = "Attachments",
		["offset"] = {
			[1] = 300,
			[2] = -250,
		},
		["atts"] = {
			[1] = "cw_anomaly_gl_m202",
		},
	},
	[3] = {
		["header"] = "Ammunition",
		["offset"] = {
			[1] = 300,
			[2] = -100,
		},
		["atts"] = {
			[1] = "cw_anomaly_ammo_762x51_ap",
		},
	},
}

SWEP.AnomalyAttachmentOrder = {
	[1] = "cw_anomaly_sil_sr25",
	[2] = "cw_anomaly_gl_m202",
	[3] = "cw_anomaly_ammo_762x51_ap",
}

SWEP.AnomalySource = {
	["IronSightsAng_GL"] = Vector(8, -0.3, 0),
	["MuzzleAttachmentSilenced"] = 2,
	["Secondary"] = {
		["ScopeZoom"] = 10,
		["IronFOV"] = 70,
	},
	["Primary"] = {
		["GLSound"] = "TFA_ANOMALY.SR25.ShootGL",
		["HullSize"] = 0,
		["Range"] = 29750.0,
		["RPM"] = 700,
		["Ammo"] = "7.62x51MM",
		["AmmoConsumption"] = 1,
		["NumShots"] = 1,
		["SilencedSound"] = "TFA_ANOMALY.SR25.FIRE_SILENCED",
		["RangeFalloff"] = 0.028235294117647,
		["KickDown"] = 0.25,
		["Knockback"] = 0,
		["StaticRecoilFactor"] = 1.58,
		["Automatic"] = false,
		["DamageTypeHandled"] = true,
		["PenetrationMultiplier"] = 1,
		["KickHorizontal"] = 0.5,
		["Sound"] = "TFA_ANOMALY.SR25.FIRE",
		["IronAccuracy"] = 0.0023,
		["DefaultClip"] = 40,
		["Damage"] = 50,
		["ClipSize"] = 10,
		["Spread"] = 0.023,
		["SpreadIncrement"] = 0.5,
		["SpreadRecovery"] = 4,
		["SpreadMultiplierMax"] = 1.5,
		["KickUp"] = 0.25,
	},
	["RunSightsAng"] = Vector(-19, 48.5, -20),
	["RunSightsPos"] = Vector(7, -6.2, 0),
	["WElements"] = {
		["gl"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_sr25_gl_w.mdl",
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
			["pos"] = Vector(0.13, -2.8, -0.15),
		},
		["anomaly_sil_sr25"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/w_models/wpn_sr25_sil_w.mdl",
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
		["gl"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_sr25_gl_hud.mdl",
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
			["pos"] = Vector(0.13, -2.8, -0.15),
		},
		["anomaly_sil_sr25"] = {
			["model"] = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_sr25_sil_hud.mdl",
			["surpresslightning"] = false,
			["angle"] = Angle(-90, 90, 0),
			["bodygroup"] = {},
			["color"] = Color(255, 255, 255, 255),
			["type"] = "Model",
			["size"] = Vector(0.92, 0.92, 0.92),
			["material"] = "",
			["bonemerge"] = true,
			["bone"] = "wpn_body",
			["rel"] = "",
			["active"] = false,
			["skin"] = 0,
			["pos"] = Vector(0.05, -1.34, -10.9),
		},
	},
	["IronSightsPos_GL"] = Vector(0, 0, -2),
	["IronSightsAng"] = Vector(0, 0, 0),
	["Silenced"] = false,
	["IronSightsPos"] = Vector(-3.78, -7.5, 1.512),
	["IronSightTime"] = 0.46,
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_sr25_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.2, 4.6324, -4.4206)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_sr25")
	killicon.Add("cw_anomaly_sr25", "vgui/killicons/tfa_anomaly_sr25", Color(255, 255, 255))
end
