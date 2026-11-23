AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "SR-3M"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 0.6

	-- SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.021, -4.864, -1.122), [2] = Vector(0, 0, 0)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}

end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_kobra"] = {
			model = "models/cw2/attachments/kobra.mdl",
			bone = "wpn_body",
			pos = Vector(-0.594519, 0.776041, -3.114213),
			angle = Angle(-0.068388, -0.429574, -89.91067),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_pso1"] = {
			model = "models/cw2/attachments/pso.mdl",
			bone = "wpn_body",
			pos = Vector(-0.304519, -0.223959, 1.885787),
			angle = Angle(-0.033021, -0.429637, -89.855908),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.060512, 0.453262, 1.646474),
			angle = Angle(-89.84125, 104.607987, 15.037658),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.108755, 1.031516, 1.629317),
			angle = Angle(0.041188, 179.570384, 89.846686),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(-0.075216, -4.94908, -2.902027),
			angle = Angle(-89.84125, 104.607987, 15.037658),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.0854, -4.245986, -2.758477),
			angle = Angle(-0.444669, -0.428537, -89.846682),
			size = Vector(0.533333, 0.533333, 0.533333),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.450901, 10.110539, 11.387272),
			angle = Angle(-89.529642, 160.547445, 70.976577),
			size = Vector(1.333333, 1.333333, 1.333333),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.244451, 3.471571, 4.708375),
			angle = Angle(0.444669, 179.571463, 89.846682),
			size = Vector(1.333333, 1.333333, 1.333333),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(-0.08511, -4.018003, -4.091707),
			angle = Angle(0.444669, 179.571463, 89.846682),
			size = Vector(0.865333, 0.865333, 0.865333),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(-0.084456, -4.305256, -5.424807),
			angle = Angle(0.444669, 179.571463, 89.846682),
			size = Vector(0.733333, 0.733333, 0.733333),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/akrailmount.mdl",
			bone = "wpn_body",
			pos = Vector(-0.017978, -2.47001, -2.901755),
			angle = Angle(0, 180, 90),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
		["md_pbs1"] = {
			model = "models/cw2/attachments/pbs1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.014824, -0.467683, -17.881194),
			angle = Angle(-0.041188, -0.429616, -89.846686),
			size = Vector(0.899, 0.899, 0.899),
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
	[5] = {header = "Barrel", offset = {0, -50}, atts = {"md_pbs1"}},
	["+reload"] = {header = "Ammo", offset = {1400, 350}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x39MM"

SWEP.FireDelay = 0.066
SWEP.Recoil = 1.4

SWEP.SuppressedOnEquip = false

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.11
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 200
SWEP.DeployTime = 1.2

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_vihr.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/vihr.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_vihr_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.506, -3, 2.197)
SWEP.IronsightAng = Vector(0.4, 0.02, 0)

SWEP.KobraPos = Vector(-3.561107, -5, 0.634566)
SWEP.KobraAng = Vector(0.4, 0.02, 0)
SWEP.PSOPos = Vector(-3.100374, -4, 1.506007)
SWEP.PSOAng = Vector(0.4, 0.02, 0)
SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ShortDotPos = Vector(-3.28062, -4.969, 1.098108)
SWEP.ShortDotAng = Vector(0.4, 0.02, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.300186, -4.079, 0.759092)
SWEP.ACOGAng = Vector(0.4, 0.02, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-3.316149, -4.079, 1.175373)
SWEP.NXSAng = Vector(0.4, 0.02, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.MicroT1Pos = Vector(-3.409039, 2.33, 0.759457)
SWEP.MicroT1Ang = Vector(0.4, 0.02, 0)
SWEP.EoTechPos = Vector(-3.388653, -2.663, 0.408741)
SWEP.EoTechAng = Vector(0.4, 0.02, 0)
SWEP.AimpointPos = Vector(-3.348478, -1.76, 0.528357)
SWEP.AimpointAng = Vector(0.4, 0.02, 0)
SWEP.CmorePos = Vector(-3.394207, 2.33, 0.715048)
SWEP.CmoreAng = Vector(0.4, 0.02, 0)
SWEP.ReflexPos = Vector(-3.404381, -2.993, 1.072571)
SWEP.ReflexAng = Vector(0.4, 0.02, 0)
SWEP.SightWithRail = true
SWEP.HasDovetailMount = true
SWEP.SprintPos = Vector(6, -9.5, 1.1)
SWEP.SprintAng = Vector(-14, 49.85, -12)
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
			["sound"] = "TFA_ANOMALY.VIHR.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VIHR.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VIHR.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VIHR.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VIHR.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 4.5
SWEP.ReloadTime_Empty = 4.5
SWEP.ReloadHalt = 4.5
SWEP.ReloadHalt_Empty = 4.5
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_vihr_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.8142, -4.6372)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.VIHR.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.VIHR.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_vihr")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 3.297)
	SWEP.BoltBonePositionRecoverySpeed = 66
end

function SWEP:fireAnimFunc()
end
