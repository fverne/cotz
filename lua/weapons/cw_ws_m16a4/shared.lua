AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M16A4"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "i"
	killicon.Add("cw_ws_m16a4", "vgui/kills/cw_ws_m16a4", Color(255, 255, 255, 255))

	SWEP.FireMoveMod = 0.6

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

//lua_run Entity(1):GetViewModel():SetBodygroup(3,1)
//SWEP.AimBreathingEnabled = true

	SWEP.Attachments = {
		[1] = {header = "Sight", offset = {400, -300},  atts = {
			"md_eotech",
			"md_microt1",
			"md_aimpoint",
			"md_reflex",
			"md_cmore",
			"md_schmidt_shortdot",
			"md_acog",
			"md_nightforce_nxs",
		}},
		[3] = {header = "Silencer", offset = {-400, -200},  atts = {"md_saker"}},
		["+reload"] = {header = "Ammo", offset = {800, 150}, atts = {"am_hollowpoint", "am_armorpiercing"}}
	}

SWEP.SpeedDec = 20

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst" ,"semi"}
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

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"
SWEP.magType = "arMag"
SWEP.Chamberable = true

SWEP.FireDelay = 0.075
SWEP.Recoil = 1.4

SWEP.HipSpread = 0.11
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.009
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 83
SWEP.DeployTime = 0.6

SWEP.BulletDiameter = 5.70
SWEP.CaseLength = 44.70
SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_m16.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/m16.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_m16_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.315, -2, 2)
SWEP.IronsightAng = Vector(0.4, 0.0445, 0)

SWEP.EoTechPos = Vector(-4.355035, -2, 1.620824)
SWEP.EoTechAng = Vector(0.4, 0.0445, 0)
SWEP.MicroT1Pos = Vector(-4.338267, -2, 1.886811)
SWEP.MicroT1Ang = Vector(0.4, 0.0445, 0)
SWEP.AimpointPos = Vector(-4.374153, -2, 1.906622)
SWEP.AimpointAng = Vector(0.4, 0.0445, 0)
SWEP.ReflexPos = Vector(-4.367323, -2, 1.657433)
SWEP.ReflexAng = Vector(0.4, 0.0445, 0)
SWEP.CmorePos = Vector(-4.351692, -2, 1.469597)
SWEP.CmoreAng = Vector(0.4, 0.0445, 0)
SWEP.ShortDotPos = Vector(-4.337279, -2, 1.913638)
SWEP.ShortDotAng = Vector(0.4, 0.0445, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-4.336845, -2, 1.492447)
SWEP.ACOGAng = Vector(0.4, 0.0445, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-4.363767, -2, 1.817775)
SWEP.NXSAng = Vector(0.4, 0.0445, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SightWithRail = true
SWEP.SprintPos = Vector(6, -8, 0.6)
SWEP.SprintAng = Vector(-14, 48, -12)
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
	["anm_idle_w_gl_setup"] = "anm_idle_w_gl_setup",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_w_gl"] = "anm_idle_sprint_w_gl",
	["anm_idle_sprint_w_gl_setup"] = "anm_idle_sprint_w_gl_setup",
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
	["anm_show_w_gl_setup"] = "anm_show_w_gl_setup",
	["anm_show_w_gl_setup_first"] = "anm_show_w_gl_setup_first",
	["anm_sw_on"] = "anm_sw_on",
	["anm_sw_off"] = "anm_sw_off",
}
SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Holster",
		},
	},
	["anm_hide_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Holster",
		},
	},
	["anm_hide_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Holster",
		},
	},
	["anm_reload_g"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.ReloadG",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Reload",
		},
	},
	["anm_reload_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Reload",
		},
	},
	["anm_reload_empty_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Draw",
		},
	},
	["anm_show_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Draw",
		},
	},
	["anm_show_w_gl_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Draw",
		},
	},
	["anm_show_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Draw",
		},
	},
	["anm_show_w_gl_setup_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Draw",
		},
	},
	["anm_sw_on"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Switch",
		},
	},
	["anm_sw_off"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M16.Switch",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.166667
SWEP.ReloadTime_Empty = 3.166667
SWEP.ReloadHalt = 3.166667
SWEP.ReloadHalt_Empty = 3.166667
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_m16_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 4.6934, -3.7232)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.M16.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.M16.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_m16")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 3.024)
	SWEP.BoltBonePositionRecoverySpeed = 46
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
end

function SWEP:fireAnimFunc()
end

if CLIENT then
	SWEP.DefaultSightModel = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_m16_ironsight_hud.mdl"

	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.365967, 5.257128, 6.496703),
			angle = Angle(-89.446037, -87.303433, -176.874221),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.050043, -4.810038, -4.490041),
			angle = Angle(0.022587, -0.430024, -89.753125),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.152783, -0.046511, 0.562118),
			angle = Angle(-0.030206, 179.570934, 90.553139),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.011325, -4.932882, -7.714718),
			angle = Angle(-0.030206, 179.570934, 90.553139),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(-0.016945, -4.670609, -4.493258),
			angle = Angle(-0.030206, 179.570934, 90.553139),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.232203, 0.0124, -0.41572),
			angle = Angle(-89.841535, 104.464846, 14.894651),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.265126, 0.577385, 0.415328),
			angle = Angle(0.040732, 179.570249, 89.84686),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.094361, -5.721669, -3.271602),
			angle = Angle(-89.841535, 104.464846, 14.894651),
			size = Vector(1, 1, 1),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/rail.mdl",
			bone = "wpn_body",
			pos = Vector(0.241674, -2.629023, -3.457219),
			angle = Angle(-89.841535, 104.464846, 14.894651),
			size = Vector(1.056952, 1.582508, 1.094986),
		},
		["md_saker"] = {
			model = "models/cw2/attachments/556suppressor.mdl",
			bone = "wpn_body",
			pos = Vector(-0.012542, -0.683312, -13.793968),
			angle = Angle(0.040028, 179.570247, 89.84686),
			size = Vector(0.72, 0.72, 0.72),
		},
	}
end
