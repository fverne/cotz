AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "P99"

	SWEP.IconLetter = "a"
	killicon.AddFont("cw_p99", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

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
			pos = Vector(0.009924, -0.716136, 0.250999),
			angle = Angle(0.005058, -0.000004, -89.920958),
			size = Vector(0.37, 0.37, 0.37),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "slide",
			pos = Vector(-0.221997, 10.04269, 10.672973),
			angle = Angle(-89.920796, 86.338446, -3.661553),
			size = Vector(1, 1, 1),
		},
		["md_rmr"] = {
			model = "models/cw2/attachments/pistolholo.mdl",
			bone = "slide",
			pos = Vector(0.388438, 5.099034, 5.753957),
			angle = Angle(-89.920796, 86.338446, -3.661553),
			size = Vector(1, 1, 1),
		},
		["md_rail"] = {
			model = "models/cw2/attachments/pistolrail.mdl",
			bone = "slide",
			pos = Vector(0.00955, 2.232027, -1.336883),
			angle = Angle(-89.997807, 90, 0),
			size = Vector(0.17, 0.17, 0.17),
		},
		["md_tundra9mm"] = {
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			bone = "wpn_body",
			pos = Vector(0.005783, -0.827795, -6.965238),
			angle = Angle(0.002587, 0, -89.999982),
			size = Vector(0.52, 0.52, 0.52),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-350, -200}, atts = {"md_tundra9mm"}},
	[2] = {header = "Sight", offset = {200, -200}, atts = {"md_microt1", "md_eotech", "md_rmr"}},
	[3] = {header = "Rail", offset = {-350, 200}, atts = {"md_insight_x2"}},
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

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.08
SWEP.Recoil = 1.67

SWEP.WearDamage = 0.14
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.16
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 60
SWEP.DeployTime = 0.4
--SWEP.Chamberable = false

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_walter.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/walter99.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_walter99_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.807, -1, 2.2735)
SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.MicroT1Pos = Vector(-3.900739, -3.469, 1.403133)
SWEP.MicroT1Ang = Vector(0, 0, 0)
SWEP.EoTechPos = Vector(-3.932597, -5.469, 0.953245)
SWEP.EoTechAng = Vector(0, 0, 0)
SWEP.RMRPos = Vector(-3.899574, -3.469, 1.471753)
SWEP.RMRAng = Vector(0, 0, 0)
SWEP.SightWithRail = true
SWEP.SprintPos = Vector(0, -2, 3.8)
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
			["sound"] = "TFA_ANOMALY.WALTER.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.WALTER.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.WALTER.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.WALTER.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.WALTER.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.WALTER.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.WALTER.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.466667
SWEP.ReloadTime_Empty = 3.966667
SWEP.ReloadHalt = 3.466667
SWEP.ReloadHalt_Empty = 3.966667
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_walter99_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.3, 4.3472, -3.0906)
SWEP.WMAng = Vector(-5, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.WALTER.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.WALTER.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_walter")
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(0, 0, 1.617)
	SWEP.BoltBonePositionRecoverySpeed = 25
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
end

function SWEP:fireAnimFunc()
end
