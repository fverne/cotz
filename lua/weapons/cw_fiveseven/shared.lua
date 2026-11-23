AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "FN Five-seveN"

	SWEP.IconLetter = "u"
	killicon.AddFont("cw_fiveseven", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

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
			bone = "zatvor",
			staticBone = "wpn_body",
			pos = Vector(0.161955, -0.823761, 0.174686),
			angle = Angle(-0.053533, 0, -89.999982),
			size = Vector(0.3, 0.3, 0.3),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "zatvor",
			staticBone = "wpn_body",
			pos = Vector(-0.067984, 7.024151, 7.7837),
			angle = Angle(-88.003467, 179.999484, 89.999484),
			size = Vector(0.7125, 0.7125, 0.7125),
		},
		["md_rmr"] = {
			model = "models/cw2/attachments/pistolholo.mdl",
			bone = "zatvor",
			staticBone = "wpn_body",
			pos = Vector(0.404595, 2.917318, 3.594309),
			angle = Angle(-89.946467, 90, 0),
			size = Vector(0.6375, 0.6375, 0.6375),
		},
		["md_rail"] = {
			model = "models/cw2/attachments/pistolrail.mdl",
			bone = "zatvor",
			staticBone = "wpn_body",
			pos = Vector(0.152753, 1.762407, -1.046329),
			angle = Angle(-89.998441, 90, 0),
			size = Vector(0.1305, 0.105, 0.145),
		},
		["md_tundra9mm"] = {
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			bone = "wpn_body",
			pos = Vector(0.000069, -0.469826, -8.186521),
			angle = Angle(0.001954, 0, -89.999982),
			size = Vector(0.7, 0.7, 0.7),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-350, -200}, atts = {"md_tundra9mm"}},
	[2] = {header = "Sight", offset = {400, -300}, atts = {"md_microt1", "md_eotech", "md_rmr"}},
	[3] = {header = "Rail", offset = {-350, 200}, atts = {"md_insight_x2"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 10

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

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "5.7x28MM"

SWEP.WearDamage = 0.14
SWEP.WearEffect = 0.05

SWEP.FireDelay = 0.08
SWEP.Recoil = 0.9

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 75
SWEP.DeployTime = 0.4
--SWEP.Chamberable = false

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_fn57.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/fn57.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_fn57_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.1345, -3, 2.546)
SWEP.IronsightAng = Vector(-0.5, 0, 0)

SWEP.MicroT1Pos = Vector(-4.363286, -3, 1.780378)
SWEP.MicroT1Ang = Vector(-0.5, 0, 0)
SWEP.EoTechPos = Vector(-4.035491, -5, 1.632012)
SWEP.EoTechAng = Vector(-0.5, 0, 0)
SWEP.RMRPos = Vector(-4.378144, -7.185, 1.918467)
SWEP.RMRAng = Vector(-0.5, 0, 0)
SWEP.SightWithRail = true
SWEP.SprintPos = Vector(0, -1, 3.8)
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
			["sound"] = "TFA_ANOMALY.FN57.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FN57.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FN57.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FN57.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FN57.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FN57.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FN57.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.833333
SWEP.ReloadTime_Empty = 4.033333
SWEP.ReloadHalt = 2.833333
SWEP.ReloadHalt_Empty = 4.033333
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_fn57_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.3, 4.4817, -2.7009)
SWEP.WMAng = Vector(-7, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.FN57.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.FN57.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_fn57")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 1.684)
	SWEP.BoltBonePositionRecoverySpeed = 26
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
end

function SWEP:fireAnimFunc()
end
