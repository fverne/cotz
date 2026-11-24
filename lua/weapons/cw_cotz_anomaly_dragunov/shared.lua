AddCSLuaFile()
AddCSLuaFile("weapons/cw_dragunov/sh_sounds.lua")
include("weapons/cw_dragunov/sh_sounds.lua")
// SCK Name: svd
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Dragunov SVD"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "i"
	killicon.Add("cw_cotz_anomaly_dragunov", "vgui/kills/cw_dragnov", Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 0.6

	SWEP.DontHoldWhenReloading = true

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}

	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

	SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -300},  atts = {
		"md_kobra",
		"md_pso1",
		"md_schmidt_shortdot",
		"md_acog",
		"md_nightforce_nxs",
		"md_microt1",
		"md_eotech",
		"md_aimpoint",
		"md_cmore",
		"md_reflex",
	}},
		[2] = {header = "Barrel", offset = {-250, -300},  atts = {"md_pbs1"}},
		[3] = {header = "Handguard", offset = {-250, 150}, atts = {"md_foregrip"}},
		["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}
	}

SWEP.SpeedDec = 30

SWEP.AimBreathingIntensity = 1
SWEP.AimBreathingEnabled = false

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "Anomaly Reskins"
SWEP.AdminOnly = true

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x54MMR"
SWEP.Chamberable = false

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.FireDelay = 0.2
SWEP.Recoil = 1.8

SWEP.HipSpread = 0.12
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 6
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 190
SWEP.DeployTime = 1

SWEP.RecoilToSpread = 0.8 -- the M14 in particular will have 30% more recoil from continuous fire to give a feeling of "oh fuck I should stop firing 7.62x51MM in full auto at 750 RPM"

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_svd.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/svd.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_svd_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.726, 2, 1.6045)
SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.KobraPos = Vector(-3.904402, 0, 0.09909)
SWEP.KobraAng = Vector(0, 0, 0)
SWEP.PSOPos = Vector(-3.453249, 1, 0.950342)
SWEP.PSOAng = Vector(0, 0, 0)
SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ShortDotPos = Vector(-3.627808, 0.031, 0.554708)
SWEP.ShortDotAng = Vector(0, 0, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.645157, 0.921, 0.133706)
SWEP.ACOGAng = Vector(0, 0, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-3.703575, 0.921, 0.544448)
SWEP.NXSAng = Vector(0, 0, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.MicroT1Pos = Vector(-3.818087, 7.33, 0.571667)
SWEP.MicroT1Ang = Vector(0, 0, 0)
SWEP.EoTechPos = Vector(-3.674673, 2.337, 0.176119)
SWEP.EoTechAng = Vector(0, 0, 0)
SWEP.AimpointPos = Vector(-3.683032, 3.24, 0.575382)
SWEP.AimpointAng = Vector(0, 0, 0)
SWEP.CmorePos = Vector(-3.783629, 7.33, 0.130806)
SWEP.CmoreAng = Vector(0, 0, 0)
SWEP.ReflexPos = Vector(-3.793014, 2.007, 0.455415)
SWEP.ReflexAng = Vector(0, 0, 0)
SWEP.SightWithRail = true
SWEP.HasDovetailMount = true
SWEP.SprintPos = Vector(8, -6.6, 0.2)
SWEP.SprintAng = Vector(-15, 50.5, -10)
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
			["sound"] = "TFA_ANOMALY.SVD.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVD.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVD.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVD.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SVD.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 5.733333
SWEP.ReloadTime_Empty = 5.733333
SWEP.ReloadHalt = 5.733333
SWEP.ReloadHalt_Empty = 5.733333
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_svd_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 3.8105, -2.341)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.SVD.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.SVD.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_svd")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 4.563)
	SWEP.BoltBonePositionRecoverySpeed = 46
end

function SWEP:fireAnimFunc()
end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_kobra"] = {
			model = "models/cw2/attachments/kobra.mdl",
			bone = "wpn_body",
			pos = Vector(-0.86611, 0.082774, -2.322527),
			angle = Angle(-0.026997, -0.00003, -90.063966),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_pso1"] = {
			model = "models/cw2/attachments/pso.mdl",
			bone = "wpn_body",
			pos = Vector(-0.57611, -0.917226, 2.677473),
			angle = Angle(0.008371, 0.000001, -90.009204),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(-0.203913, -0.089214, 2.564736),
			angle = Angle(-89.999796, 90, 0),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(-0.1513, 0.453417, 2.576583),
			angle = Angle(-0.000203, 180, 89.999982),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(-0.335736, -5.756241, -2.110883),
			angle = Angle(-89.999796, 90, 0),
			size = Vector(1, 1, 1),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.340294, -4.880813, -1.977001),
			angle = Angle(-0.403279, 0, -89.999982),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.641502, 5.236968, 7.709728),
			angle = Angle(-89.596721, 179.997445, 89.997445),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(-0.181939, -0.026941, 2.238008),
			angle = Angle(0.403279, -180, 89.999982),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(-0.348756, -4.770023, -3.302139),
			angle = Angle(0.403279, -180, 89.999982),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(-0.350066, -5.017347, -5.044446),
			angle = Angle(0.403279, -180, 89.999982),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/akrailmount.mdl",
			bone = "wpn_body",
			pos = Vector(-0.289569, -3.163277, -2.110069),
			angle = Angle(0, 180, 90),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
		["md_pbs1"] = {
			model = "models/cw2/attachments/pbs1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.004907, -1.435102, -38.633164),
			angle = Angle(0.000203, 0, -89.999982),
			size = Vector(0.8, 0.8, 0.8),
		},
	}
end
