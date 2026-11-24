AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Skorpion vz 61"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1

	SWEP.IconLetter = "q"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 1

	SWEP.CustomizationMenuScale = 0.012

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}

end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(0.007944, -4.144876, -1.128755),
			angle = Angle(0.002443, -0.000013, -89.597082),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.23336, 0.929402, 3.985525),
			angle = Angle(-0.002443, 179.999987, 89.597082),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.038772, -4.067174, -4.41589),
			angle = Angle(-0.002443, 179.999987, 89.597082),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.228083, 5.999685, 9.704512),
			angle = Angle(-89.290124, -84.215632, -174.216065),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.039553, -3.767464, -1.162816),
			angle = Angle(-0.071538, -179.999126, 90.706262),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.329729, 0.901307, 3.048021),
			angle = Angle(-89.999398, 90, 0),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.366058, 1.455421, 3.651423),
			angle = Angle(-0.000601, 180, 89.999982),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.113986, -4.969458, -0.319416),
			angle = Angle(-89.999398, 90, 0),
			size = Vector(1, 1, 1),
		},
		["md_tundra9mm"] = {
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			bone = "wpn_body",
			pos = Vector(0.000035, -1.841291, -13.668331),
			angle = Angle(0.000996, 0, -89.999982),
			size = Vector(0.7, 0.7, 0.7),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {
	"md_microt1",
	"md_aimpoint",
	"md_reflex",
	"md_eotech",
	"md_cmore",
	"md_schmidt_shortdot",
	"md_acog",
	"md_nightforce_nxs",
}},
	[2] = {header = "Barrel", offset = {-400, -300},  atts = {"md_tundra9mm"}},
	["+reload"] = {header = "Ammo", offset = {-400, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 5

SWEP.Slot = 3
SWEP.HoldType = "smg"
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
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
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x18MM"

SWEP.FireDelay = 0.0705
SWEP.Recoil = 1.4

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 5
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 40
SWEP.DeployTime = 0.5

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_vz61.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/vz61.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_vz61_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.861, -1, 2.249)
SWEP.IronsightAng = Vector(-0.5, 0.005, 0)

SWEP.MicroT1Pos = Vector(-4.840575, -1, 1.641895)
SWEP.MicroT1Ang = Vector(-0.5, 0.005, 0)
SWEP.AimpointPos = Vector(-4.841048, -1, 1.784829)
SWEP.AimpointAng = Vector(-0.5, 0.005, 0)
SWEP.ReflexPos = Vector(-4.84027, -1, 1.765672)
SWEP.ReflexAng = Vector(-0.5, 0.005, 0)
SWEP.EoTechPos = Vector(-4.861534, -1, 1.319442)
SWEP.EoTechAng = Vector(-0.5, 0.005, 0)
SWEP.CmorePos = Vector(-4.851192, -1, 1.473588)
SWEP.CmoreAng = Vector(-0.5, 0.005, 0)
SWEP.ShortDotPos = Vector(-4.842756, -1, 1.850965)
SWEP.ShortDotAng = Vector(-0.5, 0.005, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-4.843604, -1, 1.457865)
SWEP.ACOGAng = Vector(-0.5, 0.005, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-4.834273, -1, 1.659025)
SWEP.NXSAng = Vector(-0.5, 0.005, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SprintPos = Vector(6.8, -8.85, 0.95)
SWEP.SprintAng = Vector(-17, 50, -14)
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
			["sound"] = "TFA_ANOMALY.VZ61.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VZ61.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VZ61.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VZ61.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.VZ61.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.266667
SWEP.ReloadTime_Empty = 2.266667
SWEP.ReloadHalt = 2.266667
SWEP.ReloadHalt_Empty = 2.266667
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_vz61_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.1081, -4.6758)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.VZ61.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.VZ61.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_vz61")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 3.668)
	SWEP.BoltBonePositionRecoverySpeed = 70
end

function SWEP:fireAnimFunc()
end
