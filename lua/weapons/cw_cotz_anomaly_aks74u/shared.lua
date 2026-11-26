AddCSLuaFile()
AddCSLuaFile("weapons/cw_aks74u/sh_sounds.lua")
include("weapons/cw_aks74u/sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AKs-74u"
	SWEP.CSMuzzleFlashes = true

	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "b"
	killicon.AddFont("cw_cotz_anomaly_aks74u", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

end

--SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -50},  atts = {"md_kobra", "md_eotech", "md_aimpoint"}},
--	[2] = {header = "Barrel", offset = {-175, -100}, atts = {"md_pbs1"}},
--	[3] = {header = "Handguard", offset = {-100, 200}, atts = {"md_foregrip"}}}

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_kobra"] = {
			model = "models/cw2/attachments/kobra.mdl",
			bone = "body",
			pos = Vector(-0.645715, 0.374911, -1.279244),
			angle = Angle(-0.068796, -0.429392, -89.910173),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_pso1"] = {
			model = "models/cw2/attachments/pso.mdl",
			bone = "body",
			pos = Vector(-0.344685, -0.609459, 3.723205),
			angle = Angle(-0.033428, -0.429456, -89.85541),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "body",
			pos = Vector(0.021215, 0.221011, 3.607979),
			angle = Angle(-89.840576, 104.755794, 15.185284),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "body",
			pos = Vector(0.069768, 0.764067, 3.618332),
			angle = Angle(0.041596, 179.570565, 89.846189),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "body",
			pos = Vector(-0.071449, -5.459376, -1.05234),
			angle = Angle(-89.840576, 104.755794, 15.185284),
			size = Vector(1, 1, 1),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "body",
			pos = Vector(-0.082474, -4.583654, -0.920808),
			angle = Angle(-0.445076, -0.428352, -89.846184),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "body",
			pos = Vector(-0.452609, 5.557615, 8.73901),
			angle = Angle(-89.529095, 160.506521, 70.935471),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "body",
			pos = Vector(0.042504, 0.282596, 3.281076),
			angle = Angle(0.445076, 179.571648, 89.846184),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "body",
			pos = Vector(-0.092706, -4.476487, -2.24623),
			angle = Angle(0.445076, 179.571648, 89.846184),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "body",
			pos = Vector(-0.093397, -4.728511, -3.987866),
			angle = Angle(0.445076, 179.571648, 89.846184),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/akrailmount.mdl",
			bone = "body",
			pos = Vector(-0.044713, -2.866147, -1.058508),
			angle = Angle(0.041759, 179.570729, 89.846462),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
		["md_pbs1"] = {
			model = "models/cw2/attachments/pbs1.mdl",
			bone = "body",
			pos = Vector(-0.120384, -0.983215, -20.195985),
			angle = Angle(-0.041596, -0.429435, -89.846189),
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
	[4] = {header = "Handguard", offset = {-300, 0}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "Anomaly Reskins"
SWEP.AdminOnly = true

SWEP.Author			= "Spy"
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
SWEP.Primary.Ammo			= "5.45x39MM"

SWEP.FireDelay = 0.092307692307692
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.08
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 70
SWEP.DeployTime = 0.6

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_ak74u.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/ak74u.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_ak74u.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.481, 0, 1.435)
SWEP.IronsightAng = Vector(0.2, 0.05, 0)

SWEP.KobraPos = Vector(-4.520389, -2, -0.002632)
SWEP.KobraAng = Vector(0.2, 0.05, 0)
SWEP.PSOPos = Vector(-4.072721, -1, 0.870463)
SWEP.PSOAng = Vector(0.2, 0.05, 0)
SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ShortDotPos = Vector(-4.248028, -1.969, 0.477637)
SWEP.ShortDotAng = Vector(0.2, 0.05, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-4.261972, -1.079, 0.038261)
SWEP.ACOGAng = Vector(0.2, 0.05, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-4.318925, -1.079, 0.440585)
SWEP.NXSAng = Vector(0.2, 0.05, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.MicroT1Pos = Vector(-4.428781, 5.33, 0.450866)
SWEP.MicroT1Ang = Vector(0.2, 0.05, 0)
SWEP.EoTechPos = Vector(-4.297404, 0.337, 0.117089)
SWEP.EoTechAng = Vector(0.2, 0.05, 0)
SWEP.AimpointPos = Vector(-4.300181, 1.24, 0.485465)
SWEP.AimpointAng = Vector(0.2, 0.05, 0)
SWEP.CmorePos = Vector(-4.392349, 5.33, -0.001469)
SWEP.CmoreAng = Vector(0.2, 0.05, 0)
SWEP.ReflexPos = Vector(-4.404857, 0.007, 0.332874)
SWEP.ReflexAng = Vector(0.2, 0.05, 0)
SWEP.SightWithRail = true
SWEP.HasDovetailMount = true
SWEP.SprintPos = Vector(6.5, -7.5, 0)
SWEP.SprintAng = Vector(-13, 50, -12)
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
			["sound"] = "TFA_ANOMALY.AK74U.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK74U.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK74U.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK74U.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AK74U.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.233333
SWEP.ReloadTime_Empty = 3.233333
SWEP.ReloadHalt = 3.233333
SWEP.ReloadHalt_Empty = 3.233333
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.WorldAttachmentScale = 0.898
SWEP.WorldAttachmentShift = Vector(-0.25, 0, 0.74)
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_ak74u.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.4219, -1.0895)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.AK74U.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.AK74U.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_ak74u")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 5.75)
	SWEP.BoltBonePositionRecoverySpeed = 90
end

function SWEP:fireAnimFunc()
end
