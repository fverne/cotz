AddCSLuaFile()
AddCSLuaFile("weapons/cw_pp1901_vityaz/sh_sounds.lua")
include("weapons/cw_pp1901_vityaz/sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "PP-19-01 Vityaz"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 0.7

	SWEP.IconLetter = "x"
	killicon.AddFont("cw_cotz_anomaly_pp1901_vityaz", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end

end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.215298, 6.57915, 8.193127),
			angle = Angle(-89.282355, -94.864088, 174.961713),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.022943, -3.34967, -2.822357),
			angle = Angle(-0.070639, 0.172827, -89.91486),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.23796, 1.30049, 2.242816),
			angle = Angle(0.063023, -179.826194, 90.714872),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.031646, -3.550065, -6.047475),
			angle = Angle(0.063023, -179.826194, 90.714872),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.011311, -3.308528, -2.825251),
			angle = Angle(0.063023, -179.826194, 90.714872),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.316334, 1.357389, 1.265016),
			angle = Angle(-89.865766, -176.156391, 93.670678),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.356547, 1.91961, 2.097592),
			angle = Angle(0.133959, -179.827079, 90.008594),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.113676, -4.31736, -1.606732),
			angle = Angle(-89.865766, -176.156391, 93.670678),
			size = Vector(1, 1, 1),
		},
		["md_tundra9mm"] = {
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			bone = "wpn_body",
			pos = Vector(-0.1093, -0.615582, -20.76456),
			angle = Angle(-0.133564, 0.172921, -90.008594),
			size = Vector(0.7, 0.7, 0.7),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500},  atts = {
	"md_eotech",
	"md_microt1",
	"md_aimpoint",
	"md_reflex",
	"md_cmore",
	"md_schmidt_shortdot",
	"md_acog",
	"md_nightforce_nxs",
}},
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_tundra9mm"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 0

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "Anomaly Reskins"
SWEP.AdminOnly = true

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.076
SWEP.Recoil = 1.25

SWEP.DurabilityDamage = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.065
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 53
SWEP.DeployTime = 1.5

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_vityaz.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/vityaz.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_vityaz_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.015, -1, 1.992)
SWEP.IronsightAng = Vector(0.7, 0.15, 0)

SWEP.EoTechPos = Vector(-4.077244, -1, 1.249692)
SWEP.EoTechAng = Vector(0.7, 0.15, 0)
SWEP.MicroT1Pos = Vector(-4.022708, -1, 1.581397)
SWEP.MicroT1Ang = Vector(0.7, 0.15, 0)
SWEP.AimpointPos = Vector(-4.074103, -1, 1.522682)
SWEP.AimpointAng = Vector(0.7, 0.15, 0)
SWEP.ReflexPos = Vector(-4.036126, -1, 1.2477)
SWEP.ReflexAng = Vector(0.7, 0.15, 0)
SWEP.CmorePos = Vector(-4.032503, -1, 1.062103)
SWEP.CmoreAng = Vector(0.7, 0.15, 0)
SWEP.ShortDotPos = Vector(-4.033489, -1, 1.521438)
SWEP.ShortDotAng = Vector(0.7, 0.15, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-4.024753, -1, 1.09058)
SWEP.ACOGAng = Vector(0.7, 0.15, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-4.049217, -1, 1.462416)
SWEP.NXSAng = Vector(0.7, 0.15, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SprintPos = Vector(7, -6, 0)
SWEP.SprintAng = Vector(-15, 49, -15)
SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_reload",
	["reload_empty"] = "anm_reload_empty",
	["anm_hide"] = "anm_hide",
	["anm_hide_w_gl"] = "anm_hide_w_gl",
	["anm_hide_w_gl_setup"] = "anm_hide_w_gl_setup",
	["anm_idle"] = "anm_idle",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_w_gl"] = "anm_idle_w_gl",
	["anm_idle_w_gl_aim"] = "anm_idle_w_gl_aim",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_w_gl"] = "anm_idle_sprint_w_gl",
	["anm_reload_g"] = "anm_reload_g",
	["anm_reload"] = "anm_reload",
	["anm_reload_empty"] = "anm_reload_empty",
	["anm_reload_w_gl"] = "anm_reload_w_gl",
	["anm_reload_empty_w_gl"] = "anm_reload_empty_w_gl",
	["anm_shots"] = "anm_shots",
	["anm_shots_w_gl"] = "anm_shots_w_gl",
	["anm_shots_g"] = "anm_shots_g",
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
	["anm_show_w_gl"] = "anm_show_w_gl",
	["anm_show_w_gl_first"] = "anm_show_w_gl_first",
}
SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VITYAZ.Holster",
		},
	},
	["anm_hide_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VITYAZ.Holster",
		},
	},
	["anm_hide_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VITYAZ.Holster",
		},
	},
	["anm_reload_g"] = {
		[1] = {
			["time"] = 1.0,
			["sound"] = "TFA_ANOMALY.VITYAZ.ReloadG",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VITYAZ.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VITYAZ.Reload",
		},
	},
	["anm_reload_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VITYAZ.Reload",
		},
	},
	["anm_reload_empty_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VITYAZ.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VITYAZ.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VITYAZ.Draw",
		},
	},
	["anm_show_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VITYAZ.Draw",
		},
	},
	["anm_show_w_gl_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VITYAZ.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadChamberCuts = {
	anm_reload = {from = 2.233333, to = 2.933333},
	anm_reload_w_gl = {from = 2.233333, to = 2.933333},
}
SWEP.ReloadTime = 3.3
SWEP.ReloadTime_Empty = 3.3
SWEP.ReloadHalt = 3.3
SWEP.ReloadHalt_Empty = 3.3
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_vityaz_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 5.1815, -6.1751)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.VITYAZ.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.VITYAZ.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_vityaz")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0.012, 5)
	SWEP.BoltBonePositionRecoverySpeed = 78
end

function SWEP:fireAnimFunc()
end
