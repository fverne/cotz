AddCSLuaFile()
AddCSLuaFile("weapons/cw_akm/sh_sounds.lua")
include("weapons/cw_akm/sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AKM"
	SWEP.CSMuzzleFlashes = true

	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "b"
	killicon.AddFont("cw_cotz_anomaly_akm", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

//	SWEP.SchmidtShortDotAxisAlign = {right = -0.2, up = -18.9, forward = 0}

	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

--SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -50},  atts = {"md_kobra", "md_eotech", "md_aimpoint"}},
--	[2] = {header = "Barrel", offset = {-175, -100}, atts = {"md_pbs1"}},
--	[3] = {header = "Handguard", offset = {-100, 200}, atts = {"md_foregrip"}}}

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_kobra"] = {
			model = "models/cw2/attachments/kobra.mdl",
			bone = "wpn_body",
			pos = Vector(-0.423508, 0.1939, -1.248854),
			angle = Angle(-0.069514, -0.430268, -89.910043),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_pso1"] = {
			model = "models/cw2/attachments/pso.mdl",
			bone = "wpn_body",
			pos = Vector(-0.133508, -0.8061, 3.751146),
			angle = Angle(-0.034147, -0.430331, -89.855281),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.237598, 0.052899, 3.63798),
			angle = Angle(-89.840349, 104.939418, 15.369786),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.289686, 0.610525, 3.64963),
			angle = Angle(0.042315, 179.56969, 89.846059),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.107001, -5.650861, -1.037168),
			angle = Angle(-89.840349, 104.939418, 15.369786),
			size = Vector(1, 1, 1),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(0.093641, -4.770939, -0.906431),
			angle = Angle(-0.445796, -0.429226, -89.846055),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.17805, 5.375356, 8.791964),
			angle = Angle(-89.528372, 160.51937, 70.949195),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.271818, 0.058011, 3.316637),
			angle = Angle(0.445796, 179.570774, 89.846055),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.085953, -4.606729, -2.231288),
			angle = Angle(0.445796, 179.570774, 89.846055),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.085182, -4.91871, -3.973295),
			angle = Angle(0.445796, 179.570774, 89.846055),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/akrailmount.mdl",
			bone = "wpn_body",
			pos = Vector(0.153033, -3.052151, -1.036396),
			angle = Angle(0, 180, 90),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
		["md_pbs1"] = {
			model = "models/cw2/attachments/pbs1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.020961, -1.338898, -24.335852),
			angle = Angle(-0.042315, -0.43031, -89.846059),
			size = Vector(0.8, 0.8, 0.8),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500},  atts = {
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
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_pbs1"}},
	[3] = {header = "Handguard", offset = {-300, 0}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 20

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

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.DurabilityDamage = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x39MM"

SWEP.FireDelay = 0.1
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.13
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 8
SWEP.MaxSpreadInc = 0.11
SWEP.SpreadPerShot = 0.012
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 83
SWEP.DeployTime = 0.6

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_akm.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/akm.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_akm.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.37, -2, 1.765)
SWEP.IronsightAng = Vector(0.3, 0.065, 0)

SWEP.KobraPos = Vector(-3.540146, -4, 0.108853)
SWEP.KobraAng = Vector(0.3, 0.065, 0)
SWEP.PSOPos = Vector(-3.082299, -3, 0.973361)
SWEP.PSOAng = Vector(0.3, 0.065, 0)
SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ShortDotPos = Vector(-3.263265, -3.969, 0.610518)
SWEP.ShortDotAng = Vector(0.3, 0.065, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.27984, -3.079, 0.178874)
SWEP.ACOGAng = Vector(0.3, 0.065, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-3.294564, -3.079, 0.540638)
SWEP.NXSAng = Vector(0.3, 0.065, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.MicroT1Pos = Vector(-3.40073, 3.33, 0.54582)
SWEP.MicroT1Ang = Vector(0.3, 0.065, 0)
SWEP.EoTechPos = Vector(-3.371479, -1.663, 0.240395)
SWEP.EoTechAng = Vector(0.3, 0.065, 0)
SWEP.AimpointPos = Vector(-3.327006, -0.76, 0.55562)
SWEP.AimpointAng = Vector(0.3, 0.065, 0)
SWEP.CmorePos = Vector(-3.366697, 3.33, 0.146561)
SWEP.CmoreAng = Vector(0.3, 0.065, 0)
SWEP.ReflexPos = Vector(-3.37963, -1.993, 0.4272)
SWEP.ReflexAng = Vector(0.3, 0.065, 0)
SWEP.SightWithRail = true
SWEP.HasDovetailMount = true
SWEP.SprintPos = Vector(6.5, -7.5, 0.5)
SWEP.SprintAng = Vector(-13, 50, -12)
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
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_w_gl"] = "anm_idle_sprint_w_gl",
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
}
SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AKM.Holster",
		},
	},
	["anm_hide_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AKM.Holster",
		},
	},
	["anm_hide_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AKM.Holster",
		},
	},
	["anm_reload_g"] = {
		[1] = {
			["time"] = 1.0,
			["sound"] = "TFA_ANOMALY.AKM.ReloadG",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AKM.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AKM.Reload_Empty",
		},
	},
	["anm_reload_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AKM.Reload",
		},
	},
	["anm_reload_empty_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AKM.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AKM.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AKM.Draw",
		},
	},
	["anm_show_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AKM.Draw",
		},
	},
	["anm_show_w_gl_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AKM.Draw",
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
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_akm.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.9112, -1.2327)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.AKM.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.AKM.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_akm")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 5.262)
	SWEP.BoltBonePositionRecoverySpeed = 79
end

function SWEP:fireAnimFunc()
end
