AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AN-94 Akaban"
	SWEP.CSMuzzleFlashes = true

	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

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
			pos = Vector(-0.581368, 0.63824, -0.446),
			angle = Angle(-0.027036, -0.000194, -90.063711),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_pso1"] = {
			model = "models/cw2/attachments/pso.mdl",
			bone = "wpn_body",
			pos = Vector(-0.291368, -0.36176, 4.554),
			angle = Angle(0.008332, -0.000163, -90.008948),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.073482, 0.296469, 4.314623),
			angle = Angle(-89.999681, 89.999836, 0),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.122425, 0.848299, 4.297715),
			angle = Angle(-0.000164, 179.999836, 89.999727),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(-0.061304, -5.085316, -0.233542),
			angle = Angle(-89.999681, 89.999836, 0),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.064038, -4.381703, -0.087338),
			angle = Angle(-0.403318, -0.000162, -89.999727),
			size = Vector(0.533333, 0.533333, 0.533333),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.430704, 9.933088, 14.057996),
			angle = Angle(-89.596682, 179.961025, 89.961188),
			size = Vector(1.333333, 1.333333, 1.333333),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.265296, 3.304319, 7.379329),
			angle = Angle(0.403318, 179.999838, 89.999727),
			size = Vector(1.333333, 1.333333, 1.333333),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(-0.064038, -4.207984, -1.420671),
			angle = Angle(0.403318, 179.999838, 89.999727),
			size = Vector(0.865333, 0.865333, 0.865333),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(-0.064037, -4.432696, -2.754004),
			angle = Angle(0.403318, 179.999838, 89.999727),
			size = Vector(0.733333, 0.733333, 0.733333),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/akrailmount.mdl",
			bone = "wpn_body",
			pos = Vector(-0.004827, -2.607811, -0.233542),
			angle = Angle(0, 180, 90),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
		["md_pbs1"] = {
			model = "models/cw2/attachments/pbs1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.002926, -0.476014, -30.691729),
			angle = Angle(0.000164, -0.000164, -89.999727),
			size = Vector(0.85, 0.85, 0.85),
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

SWEP.SpeedDec = 25

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"2burst", "semi", "auto"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.45x39MM"

SWEP.FireDelay = 0.03333333
SWEP.Recoil = 1.1

SWEP.HipSpread = 0.14
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.8
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 75
SWEP.DeployTime = 0.6

SWEP.SnapToIdlePostReload = true

function SWEP:IndividualThink()

	if self.FireMode == "2burst" then
		self.FireDelay = 0.03333333
		self.Recoil = 0.8
	else
		self.FireDelay = 0.1
		self.Recoil = 1.6
	end

end

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_abakan.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/abakan.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_abakan.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.425, -3.4, 2.88)
SWEP.IronsightAng = Vector(0.05, 0, 0)

SWEP.KobraPos = Vector(-4.298402, -5.4, 0.712137)
SWEP.KobraAng = Vector(0.05, 0, 0)
SWEP.PSOPos = Vector(-3.847243, -4.4, 1.57476)
SWEP.PSOAng = Vector(0.05, 0, 0)
SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ShortDotPos = Vector(-4.021803, -5.369, 1.145503)
SWEP.ShortDotAng = Vector(0.05, 0, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-4.039154, -4.479, 0.80376)
SWEP.ACOGAng = Vector(0.05, 0, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-4.097558, -4.479, 1.263239)
SWEP.NXSAng = Vector(0.05, 0, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.MicroT1Pos = Vector(-4.194893, 1.93, 0.886431)
SWEP.MicroT1Ang = Vector(0.05, 0, 0)
SWEP.EoTechPos = Vector(-4.068688, -3.063, 0.412524)
SWEP.EoTechAng = Vector(0.05, 0, 0)
SWEP.AimpointPos = Vector(-4.077031, -2.16, 0.575835)
SWEP.AimpointAng = Vector(0.05, 0, 0)
SWEP.CmorePos = Vector(-4.177613, 1.93, 0.792327)
SWEP.CmoreAng = Vector(0.05, 0, 0)
SWEP.ReflexPos = Vector(-4.186998, -3.393, 1.184436)
SWEP.ReflexAng = Vector(0.05, 0, 0)
SWEP.SightWithRail = true
SWEP.HasDovetailMount = true
SWEP.SprintPos = Vector(7, -8.5, 1)
SWEP.SprintAng = Vector(-14, 53, -9)
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
			["sound"] = "TFA_ANOMALY.ABAKAN.Holster",
		},
	},
	["anm_hide_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Holster",
		},
	},
	["anm_hide_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Holster",
		},
	},
	["anm_reload_g"] = {
		[1] = {
			["time"] = 1.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.ReloadG",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Reload_Empty",
		},
	},
	["anm_reload_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Reload",
		},
	},
	["anm_reload_empty_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Draw",
		},
	},
	["anm_show_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Draw",
		},
	},
	["anm_show_w_gl_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.ABAKAN.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.6
SWEP.ReloadTime_Empty = 5.433333
SWEP.ReloadHalt = 3.6
SWEP.ReloadHalt_Empty = 5.433333
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_abakan.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 4.3957, -1.3884)
SWEP.WMAng = Vector(-5, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.ABAKAN.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.ABAKAN.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_abakan")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 4.469)
	SWEP.BoltBonePositionRecoverySpeed = 68
end

function SWEP:fireAnimFunc()
end
