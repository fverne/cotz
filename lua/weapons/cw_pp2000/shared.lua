AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "PP-2000"
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
			bone = "zatvor",
			pos = Vector(0.312945, 9.087215, -16.589852),
			angle = Angle(89.369826, -75.26596, -14.305806),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "zatvor",
			pos = Vector(0.034207, -0.883638, -5.608266),
			angle = Angle(0.16333, -179.569971, 90.189377),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "zatvor",
			pos = Vector(-0.188215, 3.869526, -10.629306),
			angle = Angle(-0.155712, 0.429064, -89.389366),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "zatvor",
			pos = Vector(-0.020513, -1.07978, -2.390202),
			angle = Angle(-0.155712, 0.429064, -89.389366),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "zatvor",
			pos = Vector(-0.000962, -0.824377, -5.620501),
			angle = Angle(-0.155712, 0.429064, -89.389366),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "zatvor",
			pos = Vector(-0.260494, 3.939401, -9.579729),
			angle = Angle(89.753998, 23.30905, -112.879041),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "zatvor",
			pos = Vector(-0.296766, 4.502403, -10.539096),
			angle = Angle(-0.226649, 0.42982, -90.095643),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "zatvor",
			pos = Vector(-0.117356, -1.819322, -6.951567),
			angle = Angle(89.753998, 23.30905, -112.879041),
			size = Vector(1, 1, 1),
		},
		["md_tundra9mm"] = {
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			bone = "wpn_body",
			pos = Vector(-0.017472, -1.016076, -12.563674),
			angle = Angle(-0.041104, -0.429687, -89.847014),
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
["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 5

SWEP.Slot = 3
SWEP.HoldType = "smg"
SWEP.NormalHoldType = "pistol"
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

SWEP.Primary.ClipSize		= 44
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.08571428571
SWEP.Recoil = 1.3

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.065
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 48
SWEP.DeployTime = 0.8

SWEP.Chamberable = false

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_pp2000.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/pp2000.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_pp2000_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.921, -3, 2.617)
SWEP.IronsightAng = Vector(0, 0.15, 0)

SWEP.EoTechPos = Vector(-3.992598, -3, 1.528023)
SWEP.EoTechAng = Vector(0, 0.15, 0)
SWEP.MicroT1Pos = Vector(-3.956337, -3, 1.949963)
SWEP.MicroT1Ang = Vector(0, 0.15, 0)
SWEP.AimpointPos = Vector(-4.003032, -3, 1.935554)
SWEP.AimpointAng = Vector(0, 0.15, 0)
SWEP.ReflexPos = Vector(-3.98093, -3, 1.673203)
SWEP.ReflexAng = Vector(0, 0.15, 0)
SWEP.CmorePos = Vector(-3.969476, -3, 1.459127)
SWEP.CmoreAng = Vector(0, 0.15, 0)
SWEP.ShortDotPos = Vector(-3.960552, -3, 1.959566)
SWEP.ShortDotAng = Vector(0, 0.15, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.95652, -3, 1.552317)
SWEP.ACOGAng = Vector(0, 0.15, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-3.985214, -3, 1.855899)
SWEP.NXSAng = Vector(0, 0.15, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SprintPos = Vector(7, -7.25, 0.3)
SWEP.SprintAng = Vector(-13.3, 48.5, -10.5)
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
			["sound"] = "TFA_ANOMALY.PP2000.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PP2000.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PP2000.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PP2000.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.PP2000.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.9
SWEP.ReloadTime_Empty = 2.9
SWEP.ReloadHalt = 2.9
SWEP.ReloadHalt_Empty = 2.9
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_pp2000_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.4904, -2.6013)
SWEP.WMAng = Vector(-7, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.PP2000.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.PP2000.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_pp2000")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 3.121)
	SWEP.BoltBonePositionRecoverySpeed = 53
end

function SWEP:fireAnimFunc()
end
