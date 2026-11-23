AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "FAMAS F1"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "t"
	killicon.AddFont("cw_famasf1", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.188588, 3.051218, 7.683873),
			angle = Angle(-89.445764, -87.431758, -177.002252),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(0.12631, -7.014054, -3.286821),
			angle = Angle(0.021365, -0.430323, -89.753464),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.332451, -2.251826, 1.730271),
			angle = Angle(-0.028984, 179.570634, 90.553478),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.190685, -7.114303, -6.504764),
			angle = Angle(-0.028984, 179.570634, 90.553478),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.160743, -6.862204, -3.274778),
			angle = Angle(-0.028984, 179.570634, 90.553478),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.408146, -2.186142, 0.680875),
			angle = Angle(-89.841543, 104.922958, 15.353065),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.441321, -1.622638, 1.639805),
			angle = Angle(0.041954, 179.569949, 89.847198),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.273423, -7.933392, -1.942168),
			angle = Angle(-89.841543, 104.922958, 15.353065),
			size = Vector(1, 1, 1),
		},
		["md_saker"] = {
			model = "models/cw2/attachments/556suppressor.mdl",
			bone = "wpn_body",
			pos = Vector(-0.012262, -0.19496, -8.20599),
			angle = Angle(0.04125, 179.569947, 89.847198),
			size = Vector(0.72, 0.72, 0.72),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {500, -500}, atts = {
	"md_eotech",
	"md_microt1",
	"md_aimpoint",
	"md_reflex",
	"md_cmore",
	"md_schmidt_shortdot",
	"md_acog",
	"md_nightforce_nxs",
}},
	[2] = {header = "Barrel", offset = {-400, -500}, atts = {"md_saker"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 25

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.FireDelay = 0.075
SWEP.Recoil = 1.1

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 78
SWEP.DeployTime = 0.6

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_famas.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/famas3.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_famas3_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.81, 0, 1.714)
SWEP.IronsightAng = Vector(-0.2, 0.01, 0)

SWEP.EoTechPos = Vector(-3.817799, 0, -0.210672)
SWEP.EoTechAng = Vector(-0.2, 0.01, 0)
SWEP.MicroT1Pos = Vector(-3.805875, 0, 0.162619)
SWEP.MicroT1Ang = Vector(-0.2, 0.01, 0)
SWEP.AimpointPos = Vector(-3.842672, 0, 0.138117)
SWEP.AimpointAng = Vector(-0.2, 0.01, 0)
SWEP.ReflexPos = Vector(-3.840523, 0, -0.000604)
SWEP.ReflexAng = Vector(-0.2, 0.01, 0)
SWEP.CmorePos = Vector(-3.821255, 0, -0.2324)
SWEP.CmoreAng = Vector(-0.2, 0.01, 0)
SWEP.ShortDotPos = Vector(-3.802733, 0, 0.162619)
SWEP.ShortDotAng = Vector(-0.2, 0.01, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.803701, 0, -0.237855)
SWEP.ACOGAng = Vector(-0.2, 0.01, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-3.833778, 0, 0.082189)
SWEP.NXSAng = Vector(-0.2, 0.01, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SprintPos = Vector(7.2, -7.3, 0.85)
SWEP.SprintAng = Vector(-14, 49, -10)
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
			["sound"] = "TFA_ANOMALY.FAMAS.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FAMAS.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FAMAS.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FAMAS.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FAMAS.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.466667
SWEP.ReloadTime_Empty = 3.466667
SWEP.ReloadHalt = 3.466667
SWEP.ReloadHalt_Empty = 3.466667
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_famas3_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.1081, -4.6758)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.FAMAS.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.FAMAS.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_famas")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0.002, 4.788)
	SWEP.BoltBonePositionRecoverySpeed = 102
end

function SWEP:fireAnimFunc()
end
