AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "H&K UMP .45"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1

	SWEP.IconLetter = "q"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 1

	SWEP.CustomizationMenuScale = 0.012

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}

end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.418858, 9.145114, 12.502962),
			angle = Angle(-89.290096, -84.193626, -174.194058),
			size = Vector(1.401114, 1.401114, 1.401114),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.048381, -5.680436, -3.795484),
			angle = Angle(0.064195, -0.000104, -89.906247),
			size = Vector(0.560445, 0.560445, 0.560445),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.278754, 1.12385, 3.573497),
			angle = Angle(-0.071812, -179.999126, 90.706262),
			size = Vector(1.190947, 1.190947, 1.190947),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.027466, -5.733698, -7.299705),
			angle = Angle(-0.071812, -179.999126, 90.706262),
			size = Vector(0.910724, 0.910724, 0.910724),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(-0.004947, -5.450313, -3.792044),
			angle = Angle(-0.071812, -179.999126, 90.706262),
			size = Vector(0.909323, 0.909323, 0.909323),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.435129, 1.685707, 2.900093),
			angle = Angle(-89.999124, 90, 0),
			size = Vector(1.259601, 1.259601, 1.259601),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.435129, 1.688654, 2.900093),
			angle = Angle(-0.000876, 180, 89.999982),
			size = Vector(1.261002, 1.261002, 1.261002),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.103985, -6.586769, -2.405925),
			angle = Angle(-89.999124, 90, 0),
			size = Vector(1.050835, 1.050835, 1.050835),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/rail.mdl",
			bone = "wpn_body",
			pos = Vector(0.253418, -4.409352, -1.881483),
			angle = Angle(-89.999124, 90, 0),
			size = Vector(2.062953, 1.582508, 0.564372),
		},
		["md_cobram2"] = {
			model = "models/cw2/attachments/cobra_m2.mdl",
			bone = "wpn_body",
			pos = Vector(0, -3.026869, -19.121136),
			angle = Angle(89.999124, -90, 0),
			size = Vector(1, 1, 1),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {
	"md_eotech",
	"md_microt1",
	"md_aimpoint",
	"md_reflex",
	"md_cmore",
	"md_schmidt_shortdot",
	"md_acog",
	"md_nightforce_nxs",
}},
	[2] = {header = "Barrel", offset = {-400, -300},  atts = {"md_cobram2"}},
	[3] = {header = "Rail", offset = {800, 150},  atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {-400, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 5

SWEP.Slot = 3
SWEP.HoldType = "smg"
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ".45 ACP"

SWEP.FireDelay = 0.1
SWEP.Recoil = 1.3

SWEP.HipSpread = 0.085
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 68
SWEP.DeployTime = 0.5

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_ump45.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/ump45.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_ump45_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-2.8255, -1, 1.915)
SWEP.IronsightAng = Vector(0.5, 0, 0)

SWEP.EoTechPos = Vector(-2.802977, -1, 0.561889)
SWEP.EoTechAng = Vector(0.5, 0, 0)
SWEP.MicroT1Pos = Vector(-2.81087, -1, 0.96518)
SWEP.MicroT1Ang = Vector(0.5, 0, 0)
SWEP.AimpointPos = Vector(-2.830492, -1, 0.970151)
SWEP.AimpointAng = Vector(0.5, 0, 0)
SWEP.ReflexPos = Vector(-2.830297, -1, 1.01728)
SWEP.ReflexAng = Vector(0.5, 0, 0)
SWEP.CmorePos = Vector(-2.809331, -1, 0.924691)
SWEP.CmoreAng = Vector(0.5, 0, 0)
SWEP.ShortDotPos = Vector(-2.789, -1, 0.895385)
SWEP.ShortDotAng = Vector(0.5, 0, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-2.790502, -1, 0.45529)
SWEP.ACOGAng = Vector(0.5, 0, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-2.82211, -1, 1.21305)
SWEP.NXSAng = Vector(0.5, 0, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SightWithRail = true
SWEP.SprintPos = Vector(7, -6.5, 0.1)
SWEP.SprintAng = Vector(-13, 49.5, -13)
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
			["sound"] = "TFA_ANOMALY.UMP45.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.UMP45.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.UMP45.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.UMP45.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.UMP45.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.533333
SWEP.ReloadTime_Empty = 3.533333
SWEP.ReloadHalt = 2.533333
SWEP.ReloadHalt_Empty = 3.533333
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_ump45_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.6324, -4.4206)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.UMP45.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.UMP45.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_ump45")
end

function SWEP:fireAnimFunc()
end
