AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Beretta 92"

	SWEP.IconLetter = "u"
	killicon.AddFont("cw_fiveseven", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	--SWEP.FullAimViewmodelRecoil = false
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.FOVPerShot = 0.3

	--SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	SWEP.CustomizationMenuScale = 0.01

end

SWEP.CanRestOnObjects = false

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(0.004948, -0.336933, 0.146965),
			angle = Angle(0.00383, -0.000004, -89.920958),
			size = Vector(0.3, 0.3, 0.3),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(-0.133239, 7.471297, 6.808337),
			angle = Angle(-89.920865, 87.225986, -2.774013),
			size = Vector(0.7125, 0.7125, 0.7125),
		},
		["md_rmr"] = {
			model = "models/cw2/attachments/pistolholo.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(0.253013, 3.414568, 3.660332),
			angle = Angle(-89.920865, 87.225986, -2.774013),
			size = Vector(0.6375, 0.6375, 0.6375),
		},
		["md_rail"] = {
			model = "models/cw2/attachments/pistolrail.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(-0.004777, 2.248878, -1.07349),
			angle = Angle(-89.999036, 90, 0),
			size = Vector(0.1305, 0.105, 0.145),
		},
		["md_tundra9mm"] = {
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			bone = "wpn_body",
			pos = Vector(0.000048, -0.922481, -8.847932),
			angle = Angle(0.001359, 0, -89.999982),
			size = Vector(0.7, 0.7, 0.7),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-350, -200}, atts = {"md_tundra9mm"}},
	[2] = {header = "Sight", offset = {400, -300}, atts = {"md_microt1", "md_eotech", "md_rmr"}},
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

SWEP.WearDamage = 0.14
SWEP.WearEffect = 0.05

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.08
SWEP.Recoil = 1.1

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.02
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.075
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 58
SWEP.DeployTime = 0.2
SWEP.Chamberable = false

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_beretta.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/beretta92fs.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_beretta92fs.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.85, -1, 2.158)
SWEP.IronsightAng = Vector(-0.5, 0, 0)

SWEP.MicroT1Pos = Vector(-3.90479, -3.469, 1.357516)
SWEP.MicroT1Ang = Vector(-0.5, 0, 0)
SWEP.EoTechPos = Vector(-3.95665, -5.469, 1.172283)
SWEP.EoTechAng = Vector(-0.5, 0, 0)
SWEP.RMRPos = Vector(-3.911092, -3.469, 1.535865)
SWEP.RMRAng = Vector(-0.5, 0, 0)
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
			["sound"] = "TFA_ANOMALY.BERETTA.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BERETTA.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BERETTA.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BERETTA.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BERETTA.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BERETTA.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BERETTA.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.833333
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadHalt = 2.833333
SWEP.ReloadHalt_Empty = 3.2
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_beretta92fs.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.3, 4.4817, -2.7009)
SWEP.WMAng = Vector(-7, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.BERETTA.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.BERETTA.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_beretta")
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(0, 0, 1.871)
	SWEP.BoltBonePositionRecoverySpeed = 29
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
end

function SWEP:fireAnimFunc()
end
