AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "RPK"
	SWEP.CSMuzzleFlashes = true

	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.BipodInstalled = true

end

--SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -50},  atts = {"md_kobra", "md_eotech", "md_aimpoint"}},
--	[2] = {header = "Barrel", offset = {-175, -100}, atts = {"md_pbs1"}},
--	[3] = {header = "Handguard", offset = {-100, 200}, atts = {"md_foregrip"}}}

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_kobra"] = {
			model = "models/cw2/attachments/kobra.mdl",
			bone = "wpn_body",
			pos = Vector(-0.301824, -1.417578, -2.336651),
			angle = Angle(0.235184, 0.174056, -89.241113),
			size = Vector(0.6, 0.6, 0.6),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(0.073728, -5.085364, -2.00599),
			angle = Angle(-0.402845, 0.177458, -89.958074),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.211588, 5.662215, 8.45691),
			angle = Angle(-89.594979, 174.235759, 84.058448),
			size = Vector(1, 1, 1),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.315356, 0.611729, 3.517295),
			angle = Angle(0.402845, -179.822542, 89.958074),
			size = Vector(1, 1, 1),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.078114, -4.994657, -3.008472),
			angle = Angle(0.402845, -179.822542, 89.958074),
			size = Vector(0.649, 0.649, 0.649),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.081604, -5.193592, -4.006363),
			angle = Angle(0.402845, -179.822542, 89.958074),
			size = Vector(0.55, 0.55, 0.55),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.375561, -0.415567, 1.490464),
			angle = Angle(-89.95807, 90.177163, 0),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_pso1"] = {
			model = "models/cw2/attachments/pso.mdl",
			bone = "wpn_body",
			pos = Vector(0.240941, -1.278211, 2.460531),
			angle = Angle(-0.402845, 0.177458, -89.958074),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.475222, 0.708394, 1.916614),
			angle = Angle(-0.000637, -179.822837, 89.958075),
			size = Vector(1, 1, 1),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.074282, -5.714299, -2.117896),
			angle = Angle(-89.95807, 90.177163, 0),
			size = Vector(0.667408, 0.667408, 0.667408),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/akrailmount.mdl",
			bone = "wpn_body",
			pos = Vector(0.329017, -3.187589, -3.108419),
			angle = Angle(-0.235184, -179.825944, 89.241113),
			size = Vector(1, 1, 1),
		},
		["md_pbs1"] = {
			model = "models/cw2/attachments/pbs1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.011755, -0.463598, -35.813891),
			angle = Angle(0.000637, 0.177163, -89.958075),
			size = Vector(1, 1, 1),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500},  atts = {
	"md_kobra",
	"md_microt1",
	"md_eotech",
	"md_aimpoint",
	"md_cmore",
	"md_reflex",
	"md_schmidt_shortdot",
	"md_pso1",
	"md_acog",
	"md_nightforce_nxs",
}},
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_pbs1"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 25

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 45
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.45x39MM"

SWEP.FireDelay = 0.1
SWEP.Recoil = 1.65

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.12
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 83
SWEP.DeployTime = 0.6

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_rpk.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/rpk.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_rpk_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.283, -2, 2.207)
SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.KobraPos = Vector(-3.416434, -1.743, 0.401335)
SWEP.KobraAng = Vector(0, 0, 0)
SWEP.MicroT1Pos = Vector(-3.346361, 2.981, 0.517851)
SWEP.MicroT1Ang = Vector(0, 0, 0)
SWEP.EoTechPos = Vector(-3.228099, -2.012, 0.143981)
SWEP.EoTechAng = Vector(0, 0, 0)
SWEP.AimpointPos = Vector(-3.245482, -1.109, 0.201952)
SWEP.AimpointAng = Vector(0, 0, 0)
SWEP.CmorePos = Vector(-3.335571, 2.981, 0.410157)
SWEP.CmoreAng = Vector(0, 0, 0)
SWEP.ReflexPos = Vector(-3.344847, -2.342, 0.672808)
SWEP.ReflexAng = Vector(0, 0, 0)
SWEP.ShortDotPos = Vector(-3.334008, -2.626, 0.504058)
SWEP.ShortDotAng = Vector(0, 0, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.PSOPos = Vector(-3.384576, 2.131, 0.820439)
SWEP.PSOAng = Vector(0, 0, 0)
SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.352793, -0.626, -0.041677)
SWEP.ACOGAng = Vector(0, 0, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-3.273621, -3.079, 0.695326)
SWEP.NXSAng = Vector(0, 0, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SightWithRail = true
SWEP.HasDovetailMount = true
SWEP.SprintPos = Vector(6.2, -7.5, 1.2)
SWEP.SprintAng = Vector(-15, 48, -11)
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
			["sound"] = "TFA_ANOMALY.RPK.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPK.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPK.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPK.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.RPK.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.566667
SWEP.ReloadTime_Empty = 3.566667
SWEP.ReloadHalt = 3.566667
SWEP.ReloadHalt_Empty = 3.566667
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_rpk_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 4.9997, -5.9584)
SWEP.WMAng = Vector(-5, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.RPK.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.RPK.FIRE"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_rpk")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 5.414)
	SWEP.BoltBonePositionRecoverySpeed = 73
end

function SWEP:fireAnimFunc()
end
