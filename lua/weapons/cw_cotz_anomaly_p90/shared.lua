AddCSLuaFile()
AddCSLuaFile("weapons/cw_p90/sh_sounds.lua")
include("weapons/cw_p90/sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "FN P90"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "m"
	killicon.AddFont("cw_cotz_anomaly_p90", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.CustomizationMenuScale = 0.012

end

if CLIENT then
	SWEP.DefaultSightModel = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_p90_sight_hud.mdl"

	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.29896, 4.762333, 8.333655),
			angle = Angle(-89.446255, -87.389709, -176.960716),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(0.015774, -5.292501, -2.636976),
			angle = Angle(0.02174, -0.429809, -89.752952),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.221954, -0.530029, 2.380074),
			angle = Angle(-0.029359, 179.571149, 90.552966),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.080183, -5.394637, -5.854912),
			angle = Angle(-0.029359, 179.571149, 90.552966),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.050226, -5.143122, -2.624927),
			angle = Angle(-0.029359, 179.571149, 90.552966),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.297636, -0.465743, 1.330682),
			angle = Angle(-89.841148, 104.744086, 15.173678),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.330812, 0.097448, 2.289608),
			angle = Angle(0.041579, 179.570464, 89.846686),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.16288, -6.213206, -1.292309),
			angle = Angle(-89.841148, 104.744086, 15.173678),
			size = Vector(1, 1, 1),
		},
		["md_tundra9mm"] = {
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			bone = "wpn_body",
			pos = Vector(-0.017472, -0.731643, -10.932158),
			angle = Angle(-0.041184, -0.429537, -89.846686),
			size = Vector(0.7, 0.7, 0.7),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {500, -450}, atts = {
	"md_eotech",
	"md_microt1",
	"md_aimpoint",
	"md_reflex",
	"md_cmore",
	"md_schmidt_shortdot",
	"md_acog",
	"md_nightforce_nxs",
}},
	[2] = {header = "Barrel", offset = {-500, -450}, atts = {"md_tundra9mm"}},
	[3] = {header = "Rail", offset = {-500, 50}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 5

SWEP.Slot = 3
SWEP.NormalHoldType = "smg"
SWEP.HoldType = "smg"
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

SWEP.Primary.ClipSize		= 50
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.7x28MM"

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.FireDelay = 0.07
SWEP.Recoil = 1.2

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 80
SWEP.DeployTime = 0.6

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_p90.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/p90.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_p90_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.155, 0, 0.35)
SWEP.IronsightAng = Vector(0.45, 0.1, 0)

SWEP.EoTechPos = Vector(-3.201467, 0, -0.22454)
SWEP.EoTechAng = Vector(0.45, 0.1, 0)
SWEP.MicroT1Pos = Vector(-3.173924, 0, 0.045188)
SWEP.MicroT1Ang = Vector(0.45, 0.1, 0)
SWEP.AimpointPos = Vector(-3.217076, 0, 0.067287)
SWEP.AimpointAng = Vector(0.45, 0.1, 0)
SWEP.ReflexPos = Vector(-3.202139, 0, -0.167066)
SWEP.ReflexAng = Vector(0.45, 0.1, 0)
SWEP.CmorePos = Vector(-3.187864, 0, -0.362824)
SWEP.CmoreAng = Vector(0.45, 0.1, 0)
SWEP.ShortDotPos = Vector(-3.175485, 0, 0.0785)
SWEP.ShortDotAng = Vector(0.45, 0.1, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.173254, 0, -0.345727)
SWEP.ACOGAng = Vector(0.45, 0.1, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-3.202448, 0, -0.032055)
SWEP.NXSAng = Vector(0.45, 0.1, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SprintPos = Vector(6.7, -9, 0.9)
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
			["sound"] = "TFA_ANOMALY.P90.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.P90.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.P90.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.P90.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.P90.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 4.1
SWEP.ReloadTime_Empty = 4.1
SWEP.ReloadHalt = 4.1
SWEP.ReloadHalt_Empty = 4.1
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_p90_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.6324, -4.4206)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.P90.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.P90.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_p90")
end

function SWEP:fireAnimFunc()
end
