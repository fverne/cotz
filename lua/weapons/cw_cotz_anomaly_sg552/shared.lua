AddCSLuaFile()
AddCSLuaFile("weapons/cw_sg552/sh_sounds.lua")
include("weapons/cw_sg552/sh_sounds.lua")
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "SIG SG 552"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "i"
--	killicon.Add("cw_cotz_anomaly_sg552", "cyn/icon/fas2_cw/sg550_kill", Color(255, 80, 0, 150))
--	SWEP.SelectIcon = surface.GetTextureID("cyn/icon/fas2_cw/sg550_select")

	SWEP.FireMoveMod = 0.6

	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.FOVPerShot = 0.3

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

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
SWEP.Category = "Anomaly Reskins"
SWEP.AdminOnly = true

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

--SWEP.ViewModel		= "models/weapons/view/rifles/sg552.mdl"
--SWEP.WorldModel		= "models/weapons/w_sg550.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"
SWEP.Chamberable = true

SWEP.FireDelay = 0.085
SWEP.Recoil = 1.7

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.09
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 75
SWEP.DeployTime = 0.6

SWEP.BulletDiameter = 5.70
SWEP.CaseLength = 44.70
SWEP.SnapToIdlePostReload = true

function SWEP:IndividualInitialize()
	--self:setBodygroup( 4 , 1 )
end

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_sig552.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/sig552.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_sig552_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.8025, 0, 1.895)
SWEP.IronsightAng = Vector(0.177, 0.025, 0)

SWEP.EoTechPos = Vector(-4.83838, 0, 0.837222)
SWEP.EoTechAng = Vector(0.177, 0.025, 0)
SWEP.MicroT1Pos = Vector(-4.824062, 0, 1.158606)
SWEP.MicroT1Ang = Vector(0.177, 0.025, 0)
SWEP.AimpointPos = Vector(-4.861832, 0, 1.162229)
SWEP.AimpointAng = Vector(0.177, 0.025, 0)
SWEP.ReflexPos = Vector(-4.857725, 0, 0.965937)
SWEP.ReflexAng = Vector(0.177, 0.025, 0)
SWEP.CmorePos = Vector(-4.839223, 0, 0.757639)
SWEP.CmoreAng = Vector(0.177, 0.025, 0)
SWEP.ShortDotPos = Vector(-4.821641, 0, 1.172631)
SWEP.ShortDotAng = Vector(0.177, 0.025, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-4.822121, 0, 0.7606)
SWEP.ACOGAng = Vector(0.177, 0.025, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-4.852059, 0, 1.088381)
SWEP.NXSAng = Vector(0.177, 0.025, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SightWithRail = true
SWEP.SprintPos = Vector(6, -6.5, 0.2)
SWEP.SprintAng = Vector(-13, 48, -10)
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
			["sound"] = "TFA_ANOMALY.SIG552.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG552.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG552.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG552.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SIG552.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
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
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_sig552_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 4.6373, -3.2164)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.SIG552.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.SIG552.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_sig552")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, -0.002, 2.187)
	SWEP.BoltBonePositionRecoverySpeed = 38
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
end

function SWEP:fireAnimFunc()
end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.284083, 5.143185, 6.935443),
			angle = Angle(-89.446232, -87.345186, -176.915716),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(0.030847, -4.907913, -4.035195),
			angle = Angle(0.022176, -0.430284, -89.752952),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.236915, -0.144428, 0.981854),
			angle = Angle(-0.029795, 179.570674, 90.552966),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.095283, -5.010275, -7.253131),
			angle = Angle(-0.029795, 179.570674, 90.552966),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.065278, -4.755907, -4.023153),
			angle = Angle(-0.029795, 179.570674, 90.552966),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.312676, -0.08595, -0.067522),
			angle = Angle(-89.841261, 104.59189, 15.021956),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.345821, 0.479596, 0.891397),
			angle = Angle(0.041143, 179.569989, 89.846686),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.177883, -5.819681, -2.690552),
			angle = Angle(-89.841261, 104.59189, 15.021956),
			size = Vector(1, 1, 1),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/rail.mdl",
			bone = "wpn_body",
			pos = Vector(0.318902, -3.363265, -2.983845),
			angle = Angle(-89.841261, 104.59189, 15.021956),
			size = Vector(1.056952, 1.582508, 0.747796),
		},
		["md_saker"] = {
			model = "models/cw2/attachments/556suppressor.mdl",
			bone = "wpn_body",
			pos = Vector(0.022643, -0.205766, -4.750363),
			angle = Angle(0.040439, 179.569987, 89.846686),
			size = Vector(0.72, 0.72, 0.72),
		},
	}
end
