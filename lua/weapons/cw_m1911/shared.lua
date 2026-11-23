AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1911"

	SWEP.IconLetter = "f"
	killicon.AddFont("cw_deagle", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.FOVPerShot = 0.3

	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	SWEP.CustomizationMenuScale = 0.01

end

SWEP.CanRestOnObjects = false

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(0.030432, -0.563601, 3.778956),
			angle = Angle(-0.005316, -0.000019, -90.160721),
			size = Vector(0.3, 0.3, 0.3),
		},
		["md_rmr"] = {
			model = "models/cw2/attachments/pistolholo.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(0.261728, 3.136444, 7.082719),
			angle = Angle(-89.839192, -91.894387, 178.105625),
			size = Vector(0.6375, 0.6375, 0.6375),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(-0.167822, 7.378634, 10.914433),
			angle = Angle(-88.66071, 90.227536, 0.227437),
			size = Vector(0.7125, 0.7125, 0.7125),
		},
		["md_rail"] = {
			model = "models/cw2/attachments/pistolrail.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(0.031604, 2.00725, 2.556831),
			angle = Angle(-89.998441, 90, 0),
			size = Vector(0.1305, 0.105, 0.145),
		},
		["md_cobram2"] = {
			model = "models/cw2/attachments/cobra_m2.mdl",
			bone = "wpn_body",
			pos = Vector(0, -1.420708, -9.809582),
			angle = Angle(89.998441, -90, 0),
			size = Vector(0.95, 0.95, 0.95),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-350, -200}, atts = {"md_cobram2"}},
	[2] = {header = "Sight", offset = {300, -300}, atts = {"md_microt1", "md_rmr", "md_eotech"}, exclusions = {md_insight_x2 = true}},
	[3] = {header = "Rail", offset = {-350, 200}, atts = {"md_insight_x2"}, exclusions = {md_rmr = true}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 0

SWEP.Slot = 2
SWEP.HoldType = "pistol"
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".45 ACP"

SWEP.WearDamage = 0.14
SWEP.WearEffect = 0.05

SWEP.FireDelay = 0.08
SWEP.Recoil = 1.4

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.017
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 68
SWEP.DrawSpeed = 1.4
SWEP.DeployTime = 1.1
--SWEP.Chamberable = false

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_colt1911.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/colt1911.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_colt1911_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.74, -1, 2.058)
SWEP.IronsightAng = Vector(0.3, 0, 0)

SWEP.MicroT1Pos = Vector(-3.812216, -1.386, 1.261792)
SWEP.MicroT1Ang = Vector(0.3, 0, 0)
SWEP.RMRPos = Vector(-3.797669, -4.606, 1.427837)
SWEP.RMRAng = Vector(0.3, 0, 0)
SWEP.EoTechPos = Vector(-3.802941, -7.584, 1.172632)
SWEP.EoTechAng = Vector(0.3, 0, 0)
SWEP.SightWithRail = true
SWEP.SprintPos = Vector(0, -1, 3.5)
SWEP.SprintAng = Vector(-19, 3, -6)
SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_reload",
	["reload_empty"] = "anm_reload_empty",
	["fire_dry"] = "anm_shots_last",
	["anm_hide"] = "anm_hide",
	["anm_hide_empty"] = "anm_hide_empty",
	["anm_idle"] = "anm_idle",
	["anm_idle_empty"] = "anm_idle_empty",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_aim_empty"] = "anm_idle_aim_empty",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_empty"] = "anm_idle_sprint_empty",
	["anm_reload"] = "anm_reload",
	["anm_reload_empty"] = "anm_reload_empty",
	["anm_shots"] = "anm_shots",
	["anm_shots_last"] = "anm_shots_last",
	["anm_show"] = "anm_show",
	["anm_show_empty"] = "anm_show_empty",
	["anm_show_first"] = "anm_show_first",
}
SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.COLT1911.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.COLT1911.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.COLT1911.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.COLT1911.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.COLT1911.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.COLT1911.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.COLT1911.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.533333
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadHalt = 2.533333
SWEP.ReloadHalt_Empty = 3.2
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_colt1911_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.3, 4.4817, -2.7009)
SWEP.WMAng = Vector(-7, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.COLT1911.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.COLT1911.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_colt1911")
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(0, 0, 1.938)
	SWEP.BoltBonePositionRecoverySpeed = 30
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
end

function SWEP:fireAnimFunc()
end
