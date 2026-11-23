AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Saiga-12"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1

	SWEP.IconLetter = "k"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 1

	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}

end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_kobra"] = {
			model = "models/cw2/attachments/kobra.mdl",
			bone = "wpn_body",
			pos = Vector(-0.745326, 0.29241, -1.202052),
			angle = Angle(-0.069071, -0.429379, -89.91067),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_pso1"] = {
			model = "models/cw2/attachments/pso.mdl",
			bone = "wpn_body",
			pos = Vector(-0.455326, -0.70759, 3.797948),
			angle = Angle(-0.033704, -0.429442, -89.855908),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(-0.090296, -0.030369, 3.558635),
			angle = Angle(-89.841071, 104.846077, 15.275555),
			size = Vector(0.8, 0.8, 0.8),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(-0.042052, 0.547884, 3.541478),
			angle = Angle(0.041872, 179.570578, 89.846686),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(-0.226023, -5.432712, -0.989866),
			angle = Angle(-89.841071, 104.846077, 15.275555),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.236204, -4.729617, -0.846316),
			angle = Angle(-0.445352, -0.428342, -89.846681),
			size = Vector(0.533333, 0.533333, 0.533333),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.601705, 9.626909, 13.299433),
			angle = Angle(-89.528996, 160.574731, 71.003669),
			size = Vector(1.333333, 1.333333, 1.333333),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.093653, 2.987174, 6.620537),
			angle = Angle(0.445352, 179.571658, 89.846681),
			size = Vector(1.333333, 1.333333, 1.333333),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(-0.235914, -4.501633, -2.179546),
			angle = Angle(0.445352, 179.571658, 89.846681),
			size = Vector(0.865333, 0.865333, 0.865333),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(-0.23526, -4.788886, -3.512646),
			angle = Angle(0.445352, 179.571658, 89.846681),
			size = Vector(0.733333, 0.733333, 0.733333),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/akrailmount.mdl",
			bone = "wpn_body",
			pos = Vector(-0.168785, -2.953641, -0.989594),
			angle = Angle(0, 180, 90),
			size = Vector(0.889878, 0.889878, 0.889878),
		},
	}
end

SWEP.Attachments = {
	[1] = {header = "Sight", offset = {800, -300}, atts = {
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
	}},["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
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
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.2
SWEP.Recoil = 3

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.08
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 0.5
SWEP.MaxSpreadInc = 0.1
SWEP.ClumpSpread = 0.014
SWEP.SpreadPerShot = 0.06
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 9
SWEP.Damage = 45
SWEP.DeployTime = 1

SWEP.SnapToIdlePostReload = true

SWEP.Chamberable = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_saiga.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/saiga12s.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_saiga12s_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.75, -3, 3.464)
SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.KobraPos = Vector(-3.710752, -5, 1.609942)
SWEP.KobraAng = Vector(0, 0, 0)
SWEP.PSOPos = Vector(-3.248604, -4, 2.453478)
SWEP.PSOAng = Vector(0, 0, 0)
SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ShortDotPos = Vector(-3.428591, -4.969, 2.04047)
SWEP.ShortDotAng = Vector(0, 0, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.449473, -4.079, 1.728209)
SWEP.ACOGAng = Vector(0, 0, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-3.466067, -4.079, 2.155805)
SWEP.NXSAng = Vector(0, 0, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.MicroT1Pos = Vector(-3.561142, 2.33, 1.783617)
SWEP.MicroT1Ang = Vector(0, 0, 0)
SWEP.EoTechPos = Vector(-3.533936, -2.663, 1.29902)
SWEP.EoTechAng = Vector(0, 0, 0)
SWEP.AimpointPos = Vector(-3.496472, -1.76, 1.470924)
SWEP.AimpointAng = Vector(0, 0, 0)
SWEP.CmorePos = Vector(-3.546781, 2.33, 1.748512)
SWEP.CmoreAng = Vector(0, 0, 0)
SWEP.ReflexPos = Vector(-3.555571, -2.993, 2.078186)
SWEP.ReflexAng = Vector(0, 0, 0)
SWEP.SightWithRail = true
SWEP.HasDovetailMount = true
SWEP.SprintPos = Vector(6.4, -10.5, 2)
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
			["sound"] = "TFA_ANOMALY.SAIGA.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SAIGA.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SAIGA.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SAIGA.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.SAIGA.Draw",
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
SWEP.Shell = "shotshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_saiga12s_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 5.0558, -6.4652)
SWEP.WMAng = Vector(-5, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.SAIGA.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.SAIGA.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_saiga")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 5.317)
	SWEP.BoltBonePositionRecoverySpeed = 40
end

function SWEP:fireAnimFunc()
end
