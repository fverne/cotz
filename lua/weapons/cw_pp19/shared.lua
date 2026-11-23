AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "PP-19 Bizon"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "x"
	killicon.AddFont("cw_mp5", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 3, roll = 1, forward = 1, pitch = 1}
	SWEP.SprintViewNormals = {x = 1, y = -1, z = 1}

	SWEP.CustomizationMenuScale = 0.012
end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_kobra"] = {
			model = "models/cw2/attachments/kobra.mdl",
			bone = "wpn_body",
			pos = Vector(-0.324783, -0.008515, -1.904732),
			angle = Angle(-0.068189, -0.429555, -89.91067),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_pso1"] = {
			model = "models/cw2/attachments/pso.mdl",
			bone = "wpn_body",
			pos = Vector(-0.034783, -1.008515, 3.095268),
			angle = Angle(-0.032822, -0.429618, -89.855908),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.336322, -0.149563, 2.982105),
			angle = Angle(-89.841301, 104.538612, 14.968264),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.388411, 0.408053, 2.993754),
			angle = Angle(0.040989, 179.570403, 89.846686),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.205726, -5.853267, -1.693047),
			angle = Angle(-89.841301, 104.538612, 14.968264),
			size = Vector(1, 1, 1),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(0.192381, -4.97335, -1.562297),
			angle = Angle(-0.44447, -0.428518, -89.846682),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.080983, 5.172811, 8.136055),
			angle = Angle(-89.52983, 160.539559, 70.968671),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.36939, -0.14446, 2.660737),
			angle = Angle(0.44447, 179.571482, 89.846682),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.184711, -4.809145, -2.887154),
			angle = Angle(0.44447, 179.571482, 89.846682),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.183964, -5.121068, -4.629162),
			angle = Angle(0.44447, 179.571482, 89.846682),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/akrailmount.mdl",
			bone = "wpn_body",
			pos = Vector(0.251758, -3.254566, -1.692274),
			angle = Angle(0, 180, 90),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
		["md_tundra9mm"] = {
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			bone = "wpn_body",
			pos = Vector(-0.017449, -1.335557, -19.516564),
			angle = Angle(-0.040595, -0.429598, -89.846686),
			size = Vector(0.7, 0.7, 0.7),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {700, -400}, atts = {
	"md_kobra",
	"md_pso1",
	"md_schmidt_shortdot",
	"md_acog",
	"md_nightforce_nxs",
	"md_microt1",
	"md_eotech",
	"md_aimpoint",
	"md_cmore",
	"md_reflex",
}},
[2] = {header = "Barrel", offset = {200, -400}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
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

SWEP.Primary.ClipSize		= 64
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x18MM"

SWEP.FireDelay = 0.075
SWEP.Recoil = 1.2

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.075
SWEP.AimSpread = 0.020
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.009
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 49
SWEP.DeployTime = 0.8

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_bizon.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/bizon.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_bizon_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-5.113, -2, 1.505)
SWEP.IronsightAng = Vector(1.1, -1.1, -1)

SWEP.KobraPos = Vector(-5.114452, -4, -0.01741)
SWEP.KobraAng = Vector(1.1, -1.1, -1)
SWEP.PSOPos = Vector(-4.574284, -3, 0.901525)
SWEP.PSOAng = Vector(1.1, -1.1, -1)
SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ShortDotPos = Vector(-4.737505, -3.969, 0.550349)
SWEP.ShortDotAng = Vector(1.1, -1.1, -1)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-4.834631, -3.079, 0.065562)
SWEP.ACOGAng = Vector(1.1, -1.1, -1)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-4.88391, -3.079, 0.404501)
SWEP.NXSAng = Vector(1.1, -1.1, -1)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.MicroT1Pos = Vector(-5.100461, 3.33, 0.336937)
SWEP.MicroT1Ang = Vector(1.1, -1.1, -1)
SWEP.EoTechPos = Vector(-4.785217, -1.663, 0.219128)
SWEP.EoTechAng = Vector(1.1, -1.1, -1)
SWEP.AimpointPos = Vector(-4.873051, -0.76, 0.447347)
SWEP.AimpointAng = Vector(1.1, -1.1, -1)
SWEP.CmorePos = Vector(-5.113107, 3.33, -0.093145)
SWEP.CmoreAng = Vector(1.1, -1.1, -1)
SWEP.ReflexPos = Vector(-5.051927, -1.993, 0.236347)
SWEP.ReflexAng = Vector(1.1, -1.1, -1)
SWEP.SightWithRail = true
SWEP.HasDovetailMount = true
SWEP.SprintPos = Vector(5.5, -7.2, 0.5)
SWEP.SprintAng = Vector(-13, 49, -10)
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
			["sound"] = "TFA_ANOMALY.BIZON.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BIZON.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BIZON.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BIZON.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BIZON.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 4.233333
SWEP.ReloadTime_Empty = 4.233333
SWEP.ReloadHalt = 4.233333
SWEP.ReloadHalt_Empty = 4.233333
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_bizon_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.3, 5.5152, -5.8028)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.BIZON.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.BIZON.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_bizon")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, -0.001, 4.748)
	SWEP.BoltBonePositionRecoverySpeed = 72
end

function SWEP:fireAnimFunc()
end
