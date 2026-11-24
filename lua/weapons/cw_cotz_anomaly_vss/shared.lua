AddCSLuaFile()
AddCSLuaFile("weapons/cw_vss/sh_sounds.lua")
include("weapons/cw_vss/sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "VSS Vintorez"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "i"
	killicon.AddFont("cw_cotz_anomaly_vss", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 0.6

	-- SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.021, -4.864, -1.122), [2] = Vector(0, 0, 0)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}

end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_kobra"] = {
			model = "models/cw2/attachments/kobra.mdl",
			bone = "wpn_body",
			pos = Vector(-0.500204, 1.181394, -2.882425),
			angle = Angle(-0.067596, -0.429249, -89.914277),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_pso1"] = {
			model = "models/cw2/attachments/pso.mdl",
			bone = "wpn_body",
			pos = Vector(-0.210204, 0.181394, 2.117575),
			angle = Angle(-0.032229, -0.42931, -89.859514),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.160903, 1.04009, 2.004423),
			angle = Angle(-89.844938, 104.671507, 15.10085),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.212992, 1.597668, 2.016077),
			angle = Angle(0.040396, 179.57071, 89.850293),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.030305, -4.663307, -2.67074),
			angle = Angle(-89.844938, 104.671507, 15.10085),
			size = Vector(1, 1, 1),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(0.016966, -3.783429, -2.539916),
			angle = Angle(-0.443877, -0.428236, -89.850288),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.254674, 6.361988, 7.158162),
			angle = Angle(-89.531556, 160.933257, 71.362072),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.195181, 1.045146, 1.682929),
			angle = Angle(0.443877, 179.571764, 89.850288),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.009278, -3.619241, -3.86478),
			angle = Angle(0.443877, 179.571764, 89.850288),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.008515, -3.93084, -5.606795),
			angle = Angle(0.443877, 179.571764, 89.850288),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/akrailmount.mdl",
			bone = "wpn_body",
			pos = Vector(0.076337, -2.064657, -2.669967),
			angle = Angle(0, 180, 90),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -450},  atts = {
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
	["+reload"] = {header = "Ammo", offset = {1400, 350}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "Anomaly Reskins"
SWEP.AdminOnly = true

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x39MM"

SWEP.FireDelay = 60/850
SWEP.Recoil = 2.3

SWEP.SuppressedOnEquip = true

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 6
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 180
SWEP.DeployTime = 1.2

function SWEP:IndividualInitialize()
	--self:setBodygroup( 4 , 1 )
end

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_vintorez.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/vintorez.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_vintorez_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.095, -3, 2.595)
SWEP.IronsightAng = Vector(0, 0.04, 0)

SWEP.KobraPos = Vector(-4.245717, -5, 0.643515)
SWEP.KobraAng = Vector(0, 0.04, 0)
SWEP.PSOPos = Vector(-3.786312, -4, 1.487466)
SWEP.PSOAng = Vector(0, 0.04, 0)
SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ShortDotPos = Vector(-3.966882, -4.969, 1.119826)
SWEP.ShortDotAng = Vector(0, 0.04, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.985151, -4.079, 0.708568)
SWEP.ACOGAng = Vector(0, 0.04, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-4.000563, -4.079, 1.079179)
SWEP.NXSAng = Vector(0, 0.04, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.MicroT1Pos = Vector(-4.109069, 2.33, 1.112272)
SWEP.MicroT1Ang = Vector(0, 0.04, 0)
SWEP.EoTechPos = Vector(-4.073991, -2.663, 0.734532)
SWEP.EoTechAng = Vector(0, 0.04, 0)
SWEP.AimpointPos = Vector(-4.032211, -1.76, 1.083334)
SWEP.AimpointAng = Vector(0, 0.04, 0)
SWEP.CmorePos = Vector(-4.075973, 2.33, 0.724742)
SWEP.CmoreAng = Vector(0, 0.04, 0)
SWEP.ReflexPos = Vector(-4.087303, -2.993, 0.98689)
SWEP.ReflexAng = Vector(0, 0.04, 0)
SWEP.SightWithRail = true
SWEP.HasDovetailMount = true
SWEP.SprintPos = Vector(8, -9, 0)
SWEP.SprintAng = Vector(-13, 53.5, -13)
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
			["sound"] = "TFA_ANOMALY.VINTOREZ.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VINTOREZ.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VINTOREZ.ReloadEmpty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VINTOREZ.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VINTOREZ.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadChamberCuts = {
	anm_reload = {from = 2.428571, to = 3.342857},
}
SWEP.ReloadTime = 3.857143
SWEP.ReloadTime_Empty = 3.857143
SWEP.ReloadHalt = 3.857143
SWEP.ReloadHalt_Empty = 3.857143
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_vintorez_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.5638, -2.9088)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.VINTOREZ.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.VINTOREZ.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_vintorez")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, -0.004, 2.895)
	SWEP.BoltBonePositionRecoverySpeed = 52
end

function SWEP:fireAnimFunc()
end
