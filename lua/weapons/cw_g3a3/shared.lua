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
			pos = Vector(-0.328257, 3.005004, 8.333925),
			angle = Angle(-89.446418, -87.381426, -176.952006),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.013246, -7.068064, -2.636627),
			angle = Angle(0.021816, -0.430236, -89.752785),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.192849, -2.302988, 2.380402),
			angle = Angle(-0.029435, 179.570722, 90.552799),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.051146, -7.167174, -5.854572),
			angle = Angle(-0.029435, 179.570722, 90.552799),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.021075, -6.901253, -2.624626),
			angle = Angle(-0.029435, 179.570722, 90.552799),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.268567, -2.240204, 1.331014),
			angle = Angle(-89.841007, 104.701716, 15.131734),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.301736, -1.676903, 2.289939),
			angle = Angle(0.041503, 179.570037, 89.84652),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.13386, -7.988129, -1.29196),
			angle = Angle(-89.841007, 104.701716, 15.131734),
			size = Vector(1, 1, 1),
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
			pos = Vector(-0.012367, -1.66882, -19.597313),
			angle = Angle(0.0408, 179.570035, 89.84652),
			size = Vector(0.72, 0.72, 0.72),
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

SWEP.EoTechPos = Vector(-3.600721, -1, 0.561701)
SWEP.EoTechAng = Vector(0.15, 0.054, 0)
SWEP.MicroT1Pos = Vector(-3.581334, -1, 0.865893)
SWEP.MicroT1Ang = Vector(0.15, 0.054, 0)
SWEP.AimpointPos = Vector(-3.621168, -1, 0.869164)
SWEP.AimpointAng = Vector(0.15, 0.054, 0)
SWEP.ReflexPos = Vector(-3.612902, -1, 0.678449)
SWEP.ReflexAng = Vector(0.15, 0.054, 0)
SWEP.CmorePos = Vector(-3.596025, -1, 0.480171)
SWEP.CmoreAng = Vector(0.15, 0.054, 0)
SWEP.ShortDotPos = Vector(-3.580445, -1, 0.884369)
SWEP.ShortDotAng = Vector(0.15, 0.054, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.57988, -1, 0.471064)
SWEP.ACOGAng = Vector(0.15, 0.054, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-3.609534, -1, 0.787178)
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
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.G3SG.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.G3SG.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_g3sg")
end

function SWEP:fireAnimFunc()
end
