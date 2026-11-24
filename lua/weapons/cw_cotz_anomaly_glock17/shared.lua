AddCSLuaFile()
AddCSLuaFile("weapons/cw_glock17/sh_sounds.lua")
include("weapons/cw_glock17/sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Glock 17"
	SWEP.CSMuzzleFlashes = true

	killicon.Add("cw_cotz_anomaly_glock17", "weaponicons/glock", Color(255, 80, 0, 150))

	SWEP.NoShells = false

	//SWEP.CustomizePos = Vector(-9.74, -7.587, -1.78)
	//SWEP.CustomizeAng = Vector(35.25, -54.682, -21.025)

	SWEP.ViewModelMovementScale = 0.2
	SWEP.FullAimViewmodelRecoil = true
	SWEP.DontHoldWhenReloading = true
	SWEP.HUD_MagText = "MAGAZINE: "

	SWEP.LuaVMRecoilAxisMod = {vert = 0, hor = 0, roll = 0, forward = 0, pitch = 0}
	SWEP.CustomizationMenuScale = 0.007
	SWEP.DisableSprintViewSimulation = true

end

SWEP.CanRestOnObjects = true

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "zatvor",
			staticBone = "wpn_body",
			pos = Vector(0.002436, -0.756541, 0.196635),
			angle = Angle(0.004425, -0.000004, -89.920958),
			size = Vector(0.3, 0.3, 0.3),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "zatvor",
			staticBone = "wpn_body",
			pos = Vector(-0.149683, 7.009388, 7.276407),
			angle = Angle(-89.920834, 86.79607, -3.203929),
			size = Vector(0.7125, 0.7125, 0.7125),
		},
		["md_rmr"] = {
			model = "models/cw2/attachments/pistolholo.mdl",
			bone = "zatvor",
			staticBone = "wpn_body",
			pos = Vector(0.248652, 2.939628, 3.704374),
			angle = Angle(-89.920834, 86.79607, -3.203929),
			size = Vector(0.6375, 0.6375, 0.6375),
		},
		["md_rail"] = {
			model = "models/cw2/attachments/pistolrail.mdl",
			bone = "zatvor",
			staticBone = "wpn_body",
			pos = Vector(-0.001156, 1.829256, -1.165392),
			angle = Angle(-89.998441, 90, 0),
			size = Vector(0.146006, 0.120832, 0.145),
		},
		["md_tundra9mm"] = {
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			bone = "wpn_body",
			pos = Vector(0.000069, -0.514826, -7.961521),
			angle = Angle(0.001954, 0, -89.999982),
			size = Vector(0.7, 0.7, 0.7),
		},
	}
end

SWEP.Attachments = {
	[1] = {header = "Sight", offset = {600, -500}, atts = {"md_microt1", "md_eotech", "md_rmr"}},
	[3] = {header = "Barrel Extension", offset = {-400, 150}, atts = {"md_tundra9mm"}},
	["+reload"] = {header = "Ammo", offset = {1200, 200}, atts = {"am_hollowpoint", "am_armorpiercing"}}
}

SWEP.SpeedDec = 0

SWEP.Slot = 2
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.AddSafeMode = false
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "Anomaly Reskins"
SWEP.AdminOnly = true

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 17
SWEP.Primary.DefaultClip	= 17
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.08
SWEP.Recoil = 1
SWEP.RecoilToSpread = 0.5

SWEP.WearDamage = 0.14
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.02
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.08
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 63
SWEP.DeployTime = 0.1
SWEP.Chamberable = true

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_glock.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/glock.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_glock_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.545, -2, 2.562)
SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.MicroT1Pos = Vector(-4.603621, -4.469, 1.697549)
SWEP.MicroT1Ang = Vector(0, 0, 0)
SWEP.EoTechPos = Vector(-4.641456, -6.469, 1.53877)
SWEP.EoTechAng = Vector(0, 0, 0)
SWEP.RMRPos = Vector(-4.60808, -4.469, 1.844986)
SWEP.RMRAng = Vector(0, 0, 0)
SWEP.SightWithRail = true
SWEP.SprintPos = Vector(0, -3, 3.6)
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
			["sound"] = "TFA_ANOMALY.GLOCK.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GLOCK.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GLOCK.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GLOCK.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GLOCK.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GLOCK.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.GLOCK.Draw",
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
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_glock_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.3, 4.382, -2.6922)
SWEP.WMAng = Vector(-7, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.GLOCK.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.GLOCK.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_glock")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 1.684)
	SWEP.BoltBonePositionRecoverySpeed = 26
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
end

function SWEP:fireAnimFunc()
end
