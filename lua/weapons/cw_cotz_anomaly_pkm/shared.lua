if ( !CustomizableWeaponry ) then return end
AddCSLuaFile()
AddCSLuaFile("weapons/cw_pkm/sh_sounds.lua")
include("weapons/cw_pkm/sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "PKM"
	SWEP.CSMuzzleFlashes = true

	SWEP.ViewModelMovementScale = 1

	SWEP.IconLetter = "b"
	killicon.AddFont("cw_cotz_anomaly_pkm", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(0.034429, -5.846632, -3.635722),
			angle = Angle(-0.003097, 0, -89.999982),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.209002, 4.397301, 6.984359),
			angle = Angle(-89.929965, -99.946547, 170.053462),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.262035, -0.946589, 1.852922),
			angle = Angle(0.012097, 179.999983, 90.067982),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.398226, -0.264172, 1.651241),
			angle = Angle(-0.002143, 180, 89.999982),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.07608, -5.467487, -3.670559),
			angle = Angle(-0.059903, -179.998861, 91.129982),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.068589, -5.906772, -6.616148),
			angle = Angle(0.055097, 179.998871, 91.129982),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.35639, -0.810046, 0.697755),
			angle = Angle(-89.997857, 90, 0),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.141368, -6.431728, -2.942407),
			angle = Angle(-89.997857, 90, 0),
			size = Vector(1, 1, 1),
		},
		["md_pbs1"] = {
			model = "models/cw2/attachments/pbs1.mdl",
			bone = "wpn_body",
			pos = Vector(0.036072, -2.074371, -37.614003),
			angle = Angle(0.002143, 0, -89.999982),
			size = Vector(0.8, 0.8, 0.8),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -400},  atts = {
	"md_microt1",
	"md_eotech",
	"md_aimpoint",
	"md_acog",
	"md_cmore",
	"md_reflex",
	"md_schmidt_shortdot",
	"md_nightforce_nxs",
}},
	[2] = {header = "Muzzle", offset = {-400, -200}, atts = {"md_pbs1"}},
	[3] = {header = "Barrel", offset = {-600, 300}, atts = {"md_bipod"}},
	["+reload"] = {header = "Ammo", offset = {1500, 400}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 40

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

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x54MMR"

SWEP.FireDelay = 0.0923
SWEP.Recoil = 1.6

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.14
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 180
SWEP.DeployTime = 0.6

SWEP.SnapToIdlePostReload = false

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_pkm.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/pkm.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_pkm_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.481, 0, 1.6)
SWEP.IronsightAng = Vector(-0.285, 0, 0)

SWEP.MicroT1Pos = Vector(-3.463967, -2.84, 0.934654)
SWEP.MicroT1Ang = Vector(-0.285, 0, 0)
SWEP.EoTechPos = Vector(-3.459035, -2.372, 0.614559)
SWEP.EoTechAng = Vector(-0.285, 0, 0)
SWEP.AimpointPos = Vector(-3.465942, -2.669, 1.104791)
SWEP.AimpointAng = Vector(-0.285, 0, 0)
SWEP.ACOGPos = Vector(-3.472546, -1.839, 0.744254)
SWEP.ACOGAng = Vector(-0.285, 0, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.CmorePos = Vector(-3.489427, -2.392, 0.821488)
SWEP.CmoreAng = Vector(-0.285, 0, 0)
SWEP.ReflexPos = Vector(-3.462275, -2.392, 0.857691)
SWEP.ReflexAng = Vector(-0.285, 0, 0)
SWEP.ShortDotPos = Vector(-3.465938, 0, 1.165616)
SWEP.ShortDotAng = Vector(-0.285, 0, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-3.458386, 0, 1.21142)
SWEP.NXSAng = Vector(-0.285, 0, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SprintPos = Vector(6.6, -7.4, 0.7)
SWEP.SprintAng = Vector(-13, 50, -10)
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
			["sound"] = "TFA_ANOMALY.PKM.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PKM.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PKM.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PKM.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PKM.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 8.0
SWEP.ReloadTime_Empty = 8.0
SWEP.ReloadHalt = 8.0
SWEP.ReloadHalt_Empty = 8.0
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_pkm_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 5.768, -2.9138)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.PKM.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.PKM.FIRE"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_pkm")
end

function SWEP:fireAnimFunc()
end
