AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M14 EBR"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "n"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 0.6

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}

end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.30751, 5.640067, 5.063406),
			angle = Angle(-89.444358, -87.354362, -176.926197),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(0.006407, -4.363039, -5.899629),
			angle = Angle(0.022175, -0.42898, -89.754829),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.214239, 0.395076, -0.899963),
			angle = Angle(-0.029794, 179.571978, 90.554843),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.072574, -4.480296, -9.114127),
			angle = Angle(-0.029794, 179.571978, 90.554843),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.041944, -4.262918, -5.879798),
			angle = Angle(-0.029794, 179.571978, 90.554843),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.288101, 0.462861, -1.985121),
			angle = Angle(-89.843073, 104.771037, 15.1998),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.321392, 1.02573, -0.962241),
			angle = Angle(0.041144, 179.571291, 89.848563),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.154664, -5.265795, -4.491937),
			angle = Angle(-89.843073, 104.771037, 15.1998),
			size = Vector(1, 1, 1),
		},
		["md_saker"] = {
			model = "models/cw2/attachments/556suppressor.mdl",
			bone = "wpn_body",
			pos = Vector(-0.012401, -0.779746, -21.136057),
			angle = Angle(0.04044, 179.57129, 89.848563),
			size = Vector(0.72, 0.72, 0.72),
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
	[2] = {header = "Barrel", offset = {-450, -300},  atts = {"md_saker"}},
	["+reload"] = {header = "Ammo", offset = {-450, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

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

SWEP.FireDelay = 0.08
SWEP.Recoil = 1.8

SWEP.HipSpread = 0.13
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.2
SWEP.SpreadPerShot = 0.017
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 140
SWEP.DeployTime = 1.7

SWEP.RecoilToSpread = 0.8 -- the M14 in particular will have 30% more recoil from continuous fire to give a feeling of "oh fuck I should stop firing 7.62x51MM in full auto at 750 RPM"

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_mk14.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/mk14.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_mk14_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.724, -3, 2.041)
SWEP.IronsightAng = Vector(0.735, 0, 0)

SWEP.EoTechPos = Vector(-4.721561, -3, 1.161077)
SWEP.EoTechAng = Vector(0.735, 0, 0)
SWEP.MicroT1Pos = Vector(-4.711027, -3, 1.432307)
SWEP.MicroT1Ang = Vector(0.735, 0, 0)
SWEP.AimpointPos = Vector(-4.748711, -3, 1.470346)
SWEP.AimpointAng = Vector(0.735, 0, 0)
SWEP.ReflexPos = Vector(-4.748052, -3, 1.184195)
SWEP.ReflexAng = Vector(0.735, 0, 0)
SWEP.CmorePos = Vector(-4.727285, -3, 0.970501)
SWEP.CmoreAng = Vector(0.735, 0, 0)
SWEP.ShortDotPos = Vector(-4.707152, -3, 1.47946)
SWEP.ShortDotAng = Vector(0.735, 0, 0)
SWEP.ACOGPos = Vector(-4.708564, -3, 1.045332)
SWEP.ACOGAng = Vector(0.735, 0, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-4.740122, -3, 1.37569)
SWEP.NXSAng = Vector(0.735, 0, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SprintPos = Vector(6.7, -5.5, 0.3)
SWEP.SprintAng = Vector(-12, 51, -10)
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
			["sound"] = "TFA_ANOMALY.MK14.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MK14.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MK14.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MK14.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MK14.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.7
SWEP.ReloadTime_Empty = 3.7
SWEP.ReloadHalt = 3.7
SWEP.ReloadHalt_Empty = 3.7
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_mk14_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 4.9399, -4.3471)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.MK14.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.MK14.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_mk14")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0.001, 0.002, 4.019)
	SWEP.BoltBonePositionRecoverySpeed = 65
end

function SWEP:fireAnimFunc()
end
