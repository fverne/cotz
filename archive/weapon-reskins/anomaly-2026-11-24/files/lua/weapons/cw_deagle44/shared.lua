AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "IMI Desert Eagle .44"
	SWEP.CSMuzzleFlashes = true

	SWEP.IconLetter = "f"
	killicon.AddFont("cw_deagle", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01

end

SWEP.CanRestOnObjects = false

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(0.001645, -1.175399, 3.248842),
			angle = Angle(0.002576, 0, -89.999905),
			size = Vector(0.3, 0.3, 0.3),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(-0.208574, 6.716765, 11.075307),
			angle = Angle(-88.499903, 89.901632, -0.098399),
			size = Vector(0.7125, 0.7125, 0.7125),
		},
		["md_rmr"] = {
			model = "models/cw2/attachments/pistolholo.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(0.251832, 2.436341, 6.791113),
			angle = Angle(-89.997422, 90, 0),
			size = Vector(0.6375, 0.6375, 0.6375),
		},
		["md_rail"] = {
			model = "models/cw2/attachments/pistolrail.mdl",
			bone = "slide",
			staticBone = "wpn_body",
			pos = Vector(-0.003386, 1.332254, 1.844534),
			angle = Angle(-89.997501, 90, 0),
			size = Vector(0.150574, 0.124613, 0.145),
		},
		["md_cobram2"] = {
			model = "models/cw2/attachments/cobra_m2.mdl",
			bone = "wpn_body",
			pos = Vector(0, -1.8096, -10.609054),
			angle = Angle(89.997501, -90, 0),
			size = Vector(0.95, 0.95, 0.95),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {450, -350}, atts = {"md_microt1", "md_eotech", "md_rmr"}},
[2] = {header = "Barrel", offset = {-600, -350}, atts = {"md_cobram2"}},
["+reload"] = {header = "Ammo", offset = {450, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 5

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

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".44 Magnum"

SWEP.WearDamage = 0.14
SWEP.WearEffect = 0.05

SWEP.FireDelay = 0.12
SWEP.Recoil = 2.5

SWEP.HipSpread = 0.07
SWEP.AimSpread = 0.008
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.15
SWEP.SpreadPerShot = 0.06
SWEP.SpreadCooldown = 0.25
SWEP.Shots = 1
SWEP.Damage = 150
SWEP.DeployTime = 1
--SWEP.Chamberable = false

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_desert_eagle.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/desert_eagle.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_desert_eagle_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.75, -1, 1.853)
SWEP.IronsightAng = Vector(-0.3, 0, 0)

SWEP.MicroT1Pos = Vector(-3.833523, -2, 1.102484)
SWEP.MicroT1Ang = Vector(-0.3, 0, 0)
SWEP.EoTechPos = Vector(-3.808948, -8.198, 0.841519)
SWEP.EoTechAng = Vector(-0.3, 0, 0)
SWEP.RMRPos = Vector(-3.830037, -5, 1.133834)
SWEP.RMRAng = Vector(-0.3, 0, 0)
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
			["sound"] = "TFA_ANOMALY.DESERT_EAGLE.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.DESERT_EAGLE.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.DESERT_EAGLE.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.DESERT_EAGLE.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.DESERT_EAGLE.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.DESERT_EAGLE.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.DESERT_EAGLE.Draw",
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
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_desert_eagle_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 4.1828, -2.6747)
SWEP.WMAng = Vector(-7, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.DESERT_EAGLE.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.DESERT_EAGLE.FIRE"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_desert_eagle")
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(0, 0, 2.895)
	SWEP.BoltBonePositionRecoverySpeed = 44
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
end

function SWEP:fireAnimFunc()
end
