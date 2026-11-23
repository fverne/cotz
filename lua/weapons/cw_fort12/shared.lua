AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Fort-12"
	SWEP.CSMuzzleFlashes = true

	SWEP.IconLetter = "f"
	killicon.AddFont("CW_fort12", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 0.75, roll = 1, forward = 0.5, pitch = 1}
	SWEP.CustomizationMenuScale = 0.01

end

SWEP.CanRestOnObjects = false

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(-0.000752, -0.773828, 2.951999),
			angle = Angle(0.004425, -0.000004, -89.920958),
			size = Vector(0.3, 0.3, 0.3),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(-0.149676, 7.017479, 9.935216),
			angle = Angle(-89.920834, 86.79607, -3.203929),
			size = Vector(0.7125, 0.7125, 0.7125),
		},
		["md_rmr"] = {
			model = "models/cw2/attachments/pistolholo.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(0.24588, 2.968123, 6.461037),
			angle = Angle(-89.920834, 86.79607, -3.203929),
			size = Vector(0.6375, 0.6375, 0.6375),
		},
		["md_rail"] = {
			model = "models/cw2/attachments/pistolrail.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(-0.005742, 1.811971, 1.73153),
			angle = Angle(-89.998441, 90, 0),
			size = Vector(0.1305, 0.105, 0.145),
		},
		["md_tundra9mm"] = {
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			bone = "wpn_body",
			pos = Vector(0.000069, -0.650861, -7.689586),
			angle = Angle(0.001954, 0, -89.999982),
			size = Vector(0.7, 0.7, 0.7),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {200, -200}, atts = {"md_microt1", "md_eotech", "md_rmr"}},
[2] = {header = "Barrel", offset = {-600, -350}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {-400, 330}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

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

SWEP.Primary.ClipSize		= 12
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x18MM"

SWEP.FireDelay = 0.08
SWEP.Recoil = 1.4

SWEP.WearDamage = 0.14
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.020
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.12
SWEP.SpreadPerShot = 0.015
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 50
SWEP.DeployTime = 1
--SWEP.Chamberable = false

SWEP.Chamberable = false

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_fort.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/fort.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_fort_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.8, -1, 2.297)
SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.MicroT1Pos = Vector(-3.858158, -3.469, 1.443528)
SWEP.MicroT1Ang = Vector(0, 0, 0)
SWEP.EoTechPos = Vector(-3.899154, -5.469, 1.310619)
SWEP.EoTechAng = Vector(0, 0, 0)
SWEP.RMRPos = Vector(-3.863003, -3.469, 1.636917)
SWEP.RMRAng = Vector(0, 0, 0)
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
			["sound"] = "TFA_ANOMALY.FORT.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FORT.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FORT.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FORT.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FORT.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FORT.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FORT.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.133333
SWEP.ReloadTime_Empty = 2.266667
SWEP.ReloadHalt = 2.133333
SWEP.ReloadHalt_Empty = 2.266667
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_fort_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.3, 4.4206, -3.3982)
SWEP.WMAng = Vector(-7, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.FORT.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.FORT.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_fort")
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(0, 0, 0.988)
	SWEP.BoltBonePositionRecoverySpeed = 15
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
end

function SWEP:fireAnimFunc()
end
