AddCSLuaFile()
AddCSLuaFile("weapons/cw_lr300/sh_sounds.lua")
include("weapons/cw_lr300/sh_sounds.lua")

	util.PrecacheModel("models/weapons/v_lr300.mdl")
	util.PrecacheModel("models/weapons/w_lr300.mdl")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "LR-300"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "w"
	killicon.Add( "cw_cotz_anomaly_lr300", "vgui/lr300_kill", Color( 255, 255, 255, 255 ) )

end

if CLIENT then
	SWEP.DefaultSightModel = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_lr300_ironsight_hud.mdl"

	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.322122, 5.104909, 6.330933),
			angle = Angle(-89.44621, -87.302588, -176.873376),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.005367, -4.985517, -4.667807),
			angle = Angle(0.022586, -0.430024, -89.752952),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.195013, -0.21982, 0.410659),
			angle = Angle(-0.030205, 179.570934, 90.552966),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.053403, -5.086253, -7.897641),
			angle = Angle(-0.030205, 179.570934, 90.552966),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.026446, -4.817304, -4.68257),
			angle = Angle(-0.030205, 179.570934, 90.552966),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.277144, -0.155641, -0.513547),
			angle = Angle(-89.841367, 104.449186, 14.878991),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.309924, 0.406423, 0.221605),
			angle = Angle(0.040733, 179.570249, 89.846686),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.13709, -5.899238, -3.544012),
			angle = Angle(-89.841367, 104.449186, 14.878991),
			size = Vector(1, 1, 1),
		},
		["md_saker"] = {
			model = "models/cw2/attachments/556suppressor.mdl",
			bone = "wpn_body",
			pos = Vector(-0.012542, -1.070091, -8.680623),
			angle = Angle(0.04003, 179.570248, 89.846686),
			size = Vector(0.72, 0.72, 0.72),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-450, -500}, atts = {"md_saker"}},
	[2] = {header = "Sight", offset = {350, -500}, atts = {
		"md_eotech",
		"md_microt1",
		"md_aimpoint",
		"md_reflex",
		"md_cmore",
		"md_schmidt_shortdot",
		"md_acog",
		"md_nightforce_nxs",
	}},
	[3] = {header = "Rail", offset = {-450, -100}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 25

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "Anomaly Reskins"
SWEP.AdminOnly = true

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Pos = Vector(-1.7, 13, -3.9)
SWEP.Ang = Angle(-3, 180, 0)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.DurabilityDamage = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.FireDelay = 0.075
SWEP.Recoil = 1.4

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.008
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 83
SWEP.DeployTime = 0.5

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_lr300.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/lr300.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_lr300_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.705, -4, 2.383)
SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.EoTechPos = Vector(-3.702178, -4, 2.812754)
SWEP.EoTechAng = Vector(0, 0, 0)
SWEP.MicroT1Pos = Vector(-3.693777, -4, 3.125944)
SWEP.MicroT1Ang = Vector(0, 0, 0)
SWEP.AimpointPos = Vector(-3.72406, -4, 3.119022)
SWEP.AimpointAng = Vector(0, 0, 0)
SWEP.ReflexPos = Vector(-3.723589, -4, 2.947821)
SWEP.ReflexAng = Vector(0, 0, 0)
SWEP.CmorePos = Vector(-3.706864, -4, 2.744141)
SWEP.CmoreAng = Vector(0, 0, 0)
SWEP.ShortDotPos = Vector(-3.690648, -4, 3.137982)
SWEP.ShortDotAng = Vector(0, 0, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.691794, -4, 2.729455)
SWEP.ACOGAng = Vector(0, 0, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-3.717167, -4, 3.053153)
SWEP.NXSAng = Vector(0, 0, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SprintPos = Vector(6.5, -8.5, 1.3)
SWEP.SprintAng = Vector(-14, 49.5, -11)
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
			["sound"] = "TFA_ANOMALY.LR300.Holster",
		},
	},
	["anm_hide_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.Holster",
		},
	},
	["anm_hide_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.Holster",
		},
	},
	["anm_reload_g"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.ReloadG",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.Reload",
		},
	},
	["anm_reload_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.Reload",
		},
	},
	["anm_reload_empty_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.Draw",
		},
	},
	["anm_show_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.Draw",
		},
	},
	["anm_show_w_gl_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.Draw",
		},
	},
	["anm_show_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.Draw",
		},
	},
	["anm_show_w_gl_setup_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.Draw",
		},
	},
	["anm_sw_on"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.Switch",
		},
	},
	["anm_sw_off"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.LR300.Switch",
		},
	},
}
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
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_lr300_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 4.6324, -4.4206)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.LR300.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.LR300.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_lr300")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 3.481)
	SWEP.BoltBonePositionRecoverySpeed = 72
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
end

function SWEP:fireAnimFunc()
end
