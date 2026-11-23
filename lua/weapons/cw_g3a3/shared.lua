AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "G3A3"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 0.6

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.468715, 7.129805, 12.928591),
			angle = Angle(-89.446418, -87.381426, -176.952006),
			size = Vector(1.340196, 1.340196, 1.340196),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.018859, -7.125872, -2.62335),
			angle = Angle(0.021816, -0.430236, -89.752785),
			size = Vector(0.536078, 0.536078, 0.536078),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.250232, -0.592271, 4.407538),
			angle = Angle(-0.029435, 179.570722, 90.552799),
			size = Vector(1.139166, 1.139166, 1.139166),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.051653, -7.184379, -5.975121),
			angle = Angle(-0.029435, 179.570722, 90.552799),
			size = Vector(0.871127, 0.871127, 0.871127),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.020955, -6.894611, -2.62071),
			angle = Angle(-0.029435, 179.570722, 90.552799),
			size = Vector(0.869787, 0.869787, 0.869787),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.395293, -0.053695, 3.76186),
			angle = Angle(-89.841007, 104.701716, 15.131734),
			size = Vector(1.204836, 1.204836, 1.204836),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.39528, -0.052004, 3.761856),
			angle = Angle(0.041503, 179.570037, 89.84652),
			size = Vector(1.206176, 1.206176, 1.206176),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.134395, -7.995207, -1.291979),
			angle = Angle(-89.841007, 104.701716, 15.131734),
			size = Vector(1.005147, 1.005147, 1.005147),
		},
		["md_rail"] = {
			model = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_g3_mount.mdl",
			bone = "wpn_scope",
			pos = Vector(0, 7.76088, 3.28734),
			angle = Angle(-89.999681, 89.999836, 0),
			size = Vector(1, 1, 1),
		},
		["md_saker"] = {
			model = "models/cw2/attachments/556suppressor.mdl",
			bone = "wpn_body",
			pos = Vector(-0.012483, -1.578027, -19.030922),
			angle = Angle(0.0408, 179.570035, 89.84652),
			size = Vector(0.75, 0.75, 0.75),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {600, -300},  atts = {
	"md_eotech",
	"md_microt1",
	"md_aimpoint",
	"md_reflex",
	"md_cmore",
	"md_schmidt_shortdot",
	"md_acog",
	"md_nightforce_nxs",
}},
	[2] = {header = "Barrel", offset = {-250, -300},  atts = {"md_saker"}},
	["+reload"] = {header = "Ammo", offset = {600, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 30

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

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.FireDelay = 0.10909090909
SWEP.Recoil = 1.7

SWEP.HipSpread = 0.13
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 5
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.012
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 135
SWEP.DeployTime = 0.8

SWEP.RecoilToSpread = 0.8 -- the M14 in particular will have 30% more recoil from continuous fire to give a feeling of "oh fuck I should stop firing 7.62x51MM in full auto at 750 RPM"

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_g3sg.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/g3.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_g3_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.55, -1, 2.05)
SWEP.IronsightAng = Vector(0.15, 0.054, 0)

SWEP.EoTechPos = Vector(-3.605249, -1, 0.113417)
SWEP.EoTechAng = Vector(0.15, 0.054, 0)
SWEP.MicroT1Pos = Vector(-3.597494, -1, 0.558681)
SWEP.MicroT1Ang = Vector(0.15, 0.054, 0)
SWEP.AimpointPos = Vector(-3.623173, -1, 0.524358)
SWEP.AimpointAng = Vector(0.15, 0.054, 0)
SWEP.ReflexPos = Vector(-3.612786, -1, 0.629938)
SWEP.ReflexAng = Vector(0.15, 0.054, 0)
SWEP.CmorePos = Vector(-3.596026, -1, 0.530763)
SWEP.CmoreAng = Vector(0.15, 0.054, 0)
SWEP.ShortDotPos = Vector(-3.582857, -1, 0.458555)
SWEP.ShortDotAng = Vector(0.15, 0.054, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.580428, -1, 0.060767)
SWEP.ACOGAng = Vector(0.15, 0.054, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-3.609535, -1, 0.780537)
SWEP.NXSAng = Vector(0.15, 0.054, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SightWithRail = true
SWEP.SprintPos = Vector(6, -5.5, 0.1)
SWEP.SprintAng = Vector(-13, 48.5, -11)
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
			["sound"] = "TFA_ANOMALY.G3SG.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G3SG.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G3SG.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G3SG.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.G3SG.Draw",
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
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_g3_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.7631, -2.9263)
SWEP.WMAng = Vector(-5, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.G3SG.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.G3SG.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_g3sg")
end

function SWEP:fireAnimFunc()
end
