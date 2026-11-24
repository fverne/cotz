AddCSLuaFile()
AddCSLuaFile("weapons/cw_svu/sh_sounds.lua")
include("weapons/cw_svu/sh_sounds.lua")

CustomizableWeaponry:registerAmmo("7,62x54R", "7,62x54R Rounds", 7.62, 64.5)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Dragunov SVU"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.ZoomAmount = 10

	SWEP.IconLetter = "w"
	killicon.AddFont("cw_cotz_anomaly_svu", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

--	SWEP.MuzzleAttachmentName = "muzzle"
--	SWEP.MuzzleAttachment = true

--	SWEP.NoStockMuzzle = true

--	SWEP.WorldMuzzleAttachmentID = "muzzle"

	SWEP.MoveType = 1

	SWEP.HUD_MagText = "CYLINDER: body "

	SWEP.LuaVMRecoilAxisMod = {vert = 0, hor = 0, roll = 0, forward = 1.2, pitch = 1}

    SWEP.FullAimViewmodelRecoil = true

end

SWEP.MuzzleVelocity = 880 -- in meter/s

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_kobra"] = {
			model = "models/cw2/attachments/kobra.mdl",
			bone = "wpn_body",
			pos = Vector(-0.213235, -0.37868, -1.320205),
			angle = Angle(0.69642, -0.007037, -89.487518),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_pso1"] = {
			model = "models/cw2/attachments/pso.mdl",
			bone = "wpn_body",
			pos = Vector(0.076765, -1.37868, 3.679795),
			angle = Angle(0.731786, -0.007361, -89.432752),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.447362, -0.490446, 3.565267),
			angle = Angle(-89.074839, 38.53691, -51.459449),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.499612, 0.072435, 3.576375),
			angle = Angle(-0.723618, 179.992719, 89.423531),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.317148, -6.223506, -1.108247),
			angle = Angle(-89.074839, 38.53691, -51.459449),
			size = Vector(1, 1, 1),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(0.312748, -5.345172, -0.986149),
			angle = Angle(0.320156, -0.003221, -89.423568),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(0.067722, 4.931724, 8.744141),
			angle = Angle(-89.340629, 60.949476, -29.048914),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.512123, -0.442305, 3.255808),
			angle = Angle(-0.320156, 179.996779, 89.423568),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.304183, -5.195053, -2.310222),
			angle = Angle(-0.320156, 179.996779, 89.423568),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.308039, -5.518539, -4.051292),
			angle = Angle(-0.320156, 179.996779, 89.423568),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/akrailmount.mdl",
			bone = "wpn_body",
			pos = Vector(0.363306, -3.624731, -1.107747),
			angle = Angle(0, 180, 90),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
	}
end

SWEP.Attachments = {
    [1] = {header = "Sight", offset = {-2920, -400},  atts = {
		"md_kobra",
		"md_pso1",
		"md_schmidt_shortdot",
		"md_acog",
		"md_nightforce_nxs",
		"md_microt1",
		"md_eotech",
		"md_aimpoint",
		"md_cmore",
		"md_reflex",
	}},
	["+reload"] = {header = "Ammo", offset = {-1700, 1600}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "Anomaly Reskins"
SWEP.AdminOnly = true

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x54MMR"

SWEP.FireDelay = 0.127
SWEP.Recoil = 2.8

SWEP.HipSpread = 0.170
SWEP.AimSpread = 0.0015
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 200
SWEP.DeployTime = 1.3

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

-- SWEP.RecoilToSpread = .75

SWEP.RecoilToSpreadAuto = 0.1

SWEP.SnapToIdlePostReload = true

-- SWEP.PenMod = 1
-- SWEP.CanPenetrate = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_svu.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/svu.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_svu_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.62, 2, 1.7715)
SWEP.IronsightAng = Vector(0.1, -0.7, 0)

SWEP.KobraPos = Vector(-5.01386, 0, 0.595592)
SWEP.KobraAng = Vector(0.1, -0.7, 0)
SWEP.PSOPos = Vector(-4.576989, 1, 1.411455)
SWEP.PSOAng = Vector(0.1, -0.7, 0)
SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ShortDotPos = Vector(-4.738093, 0.031, 1.078471)
SWEP.ShortDotAng = Vector(0.1, -0.7, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-4.802933, 0.921, 0.666008)
SWEP.ACOGAng = Vector(0.1, -0.7, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-4.824397, 0.921, 1.032287)
SWEP.NXSAng = Vector(0.1, -0.7, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.MicroT1Pos = Vector(-5.005958, 7.33, 1.053514)
SWEP.MicroT1Ang = Vector(0.1, -0.7, 0)
SWEP.EoTechPos = Vector(-4.873196, 2.337, 0.756711)
SWEP.EoTechAng = Vector(0.1, -0.7, 0)
SWEP.AimpointPos = Vector(-4.87519, 3.24, 1.08145)
SWEP.AimpointAng = Vector(0.1, -0.7, 0)
SWEP.CmorePos = Vector(-4.982321, 7.33, 0.657767)
SWEP.CmoreAng = Vector(0.1, -0.7, 0)
SWEP.ReflexPos = Vector(-4.931121, 2.007, 0.92724)
SWEP.ReflexAng = Vector(0.1, -0.7, 0)
SWEP.SightWithRail = true
SWEP.HasDovetailMount = true
SWEP.SprintPos = Vector(7, -8.5, 0.2)
SWEP.SprintAng = Vector(-13, 50.5, -13)
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
			["sound"] = "TFA_ANOMALY.SVU.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVU.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVU.ReloadEmpty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVU.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVU.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.566667
SWEP.ReloadTime_Empty = 5.5
SWEP.ReloadHalt = 3.566667
SWEP.ReloadHalt_Empty = 5.5
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_svu_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 4.265, -2.8827)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.SVU.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.SVU.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_svu")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 6.578)
	SWEP.BoltBonePositionRecoverySpeed = 99
end

function SWEP:fireAnimFunc()
end
