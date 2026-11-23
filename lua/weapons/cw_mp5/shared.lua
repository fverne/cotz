AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "HK MP5"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "x"
	killicon.AddFont("cw_mp5", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 3, roll = 1, forward = 1, pitch = 1}

	SWEP.SprintViewNormals = {x = 1, y = -1, z = 1}

	SWEP.CustomizationMenuScale = 0.012
end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.278502, 4.034336, 6.507227),
			angle = Angle(-89.290093, -84.190663, -174.191095),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.03182, -5.918671, -4.473974),
			angle = Angle(0.064232, -0.000104, -89.906247),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.209564, -1.180272, 0.520878),
			angle = Angle(-0.071849, -179.999126, 90.706262),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.037448, -6.026459, -7.685326),
			angle = Angle(-0.071849, -179.999126, 90.706262),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.005158, -5.833849, -4.446206),
			angle = Angle(-0.071849, -179.999126, 90.706262),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.282926, -1.107171, -0.599758),
			angle = Angle(-89.999087, 90, 0),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.31974, -0.544634, 0.488513),
			angle = Angle(-0.000912, 180, 89.999982),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.109907, -6.836727, -3.005469),
			angle = Angle(-89.999087, 90, 0),
			size = Vector(1, 1, 1),
		},
		["md_rail"] = {
			model = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_mp5_mount_hud.mdl",
			bone = "wpn_body",
			pos = Vector(0, 0, 0),
			angle = Angle(-89.999681, 89.999836, 0),
			size = Vector(1, 1, 1),
		},
		["md_tundra9mm"] = {
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			bone = "wpn_body",
			pos = Vector(0.000046, -2.330666, -17.810896),
			angle = Angle(0.001307, 0, -89.999982),
			size = Vector(0.7, 0.7, 0.7),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {700, -400}, atts = {
	"md_eotech",
	"md_microt1",
	"md_aimpoint",
	"md_reflex",
	"md_cmore",
	"md_schmidt_shortdot",
	"md_acog",
	"md_nightforce_nxs",
}},
[2] = {header = "Barrel", offset = {200, -400}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}},
[3] = {header = "Upgrade1", offset = {700, 0}, atts = {"up_firerate1"}}}

SWEP.SpeedDec = 5

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.075
SWEP.Recoil = 1.1

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.08
SWEP.SpreadPerShot = 0.009
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 56
SWEP.DeployTime = 0.8

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_mp5.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/mp5.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_mp5_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.26, 1, 1.948)
SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.EoTechPos = Vector(-3.23905, 1, 0.343838)
SWEP.EoTechAng = Vector(0, 0, 0)
SWEP.MicroT1Pos = Vector(-3.228686, 1, 0.766916)
SWEP.MicroT1Ang = Vector(0, 0, 0)
SWEP.AimpointPos = Vector(-3.267762, 1, 0.748006)
SWEP.AimpointAng = Vector(0, 0, 0)
SWEP.ReflexPos = Vector(-3.267558, 1, 0.573472)
SWEP.ReflexAng = Vector(0, 0, 0)
SWEP.CmorePos = Vector(-3.24568, 1, 0.301912)
SWEP.CmoreAng = Vector(0, 0, 0)
SWEP.ShortDotPos = Vector(-3.224464, 1, 0.774017)
SWEP.ShortDotAng = Vector(0, 0, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.226032, 1, 0.368157)
SWEP.ACOGAng = Vector(0, 0, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-3.259014, 1, 0.693839)
SWEP.NXSAng = Vector(0, 0, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SightWithRail = true
SWEP.SprintPos = Vector(6.7, -7.6, 0.5)
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
			["sound"] = "TFA_ANOMALY.MP5.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP5.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP5.ReloadEmpty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP5.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MP5.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.5
SWEP.ReloadTime_Empty = 3.4
SWEP.ReloadHalt = 2.5
SWEP.ReloadHalt_Empty = 3.4
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_mp5_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.5888, -4.9187)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.MP5.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.MP5.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_mp5")
end

function SWEP:fireAnimFunc()
end
