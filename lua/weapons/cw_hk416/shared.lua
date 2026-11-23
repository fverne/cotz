
AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
util.PrecacheModel("models/weapons/v_cwkk_hk416.mdl")
util.PrecacheModel("models/weapons/w_cwkk_hk416.mdl")

local Vec0 = Vector(0,0,0)
local Vec1 = Vector(1,1,1)
local Ang0 = Angle(0,0,0)

if CLIENT then
	SWEP.PrintName = "HK416"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "w"
	killicon.Add( "cw_kk_hk416", "qq_icons/kills/cw_kk_hk416", Color(255, 80, 0, 150))

	SWEP.DontHoldWhenReloading = false

	SWEP.DrawCrosshair = false
	SWEP.AimSwayIntensity = 0.6

	SWEP.CustomizationMenuScale = 0.0135

end

	SWEP.Attachments = {
		-- {header = "Sight", offset = {550, -475}, atts = {"md_cod4_reflex","md_fas2_eotech","md_fas2_holo","md_cod4_acog_v2","md_fas2_leupold"}},
		{header = "Sight", offset = {550, -475}, atts = {
			"md_eotech",
			"md_microt1",
			"md_aimpoint",
			"md_reflex",
			"md_cmore",
			"md_schmidt_shortdot",
			"md_acog",
			"md_nightforce_nxs",
		}},
		{header = "Barrel ext", offset = {-600, -475}, atts = {"md_saker"}},
		["+reload"] = {header = "Ammo", offset = {1000, 510}, atts = {"am_hollowpoint", "am_armorpiercing"}},
	}

	SWEP.SpeedDec = 20

	SWEP.Slot = 3
	SWEP.HoldType = "ar2"
	SWEP.NormalHoldType = "ar2"
	SWEP.RunHoldType = "passive"
	SWEP.FireModes = {"auto", "3burst", "semi"}
	SWEP.Base = "cw_base"
	SWEP.Category = "STALKER Weapons"

	SWEP.Author			= ""
	SWEP.Contact		= ""
	SWEP.Purpose		= ""
	SWEP.Instructions	= ""

	-- SWEP.ShowWorldModel = false

	SWEP.Spawnable			= true
	SWEP.AdminSpawnable		= true

	SWEP.Primary.ClipSize		= 30
	SWEP.Primary.DefaultClip	= 0
	SWEP.Primary.Automatic		= true
	SWEP.Primary.Ammo			= "5.56x45MM"

	SWEP.FireDelay = 0.066666666666667
	SWEP.Recoil = 1.05

	SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
	SWEP.WearEffect = 0.007

	SWEP.HipSpread = 0.045
	SWEP.AimSpread = 0.004
	SWEP.VelocitySensitivity = 1.8
	SWEP.MaxSpreadInc = 0.08
	SWEP.SpreadPerShot = 0.007
	SWEP.SpreadCooldown = 0.2
	SWEP.Shots = 1
	SWEP.Damage = 86
	SWEP.DeployTime = 0.6

	-- SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_hk416.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/hk416.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_hk416_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.757, -4, 1.923)
SWEP.IronsightAng = Vector(-0.3, 0, 0)

SWEP.EoTechPos = Vector(-4.731719, -4, 1.397949)
SWEP.EoTechAng = Vector(-0.3, 0, 0)
SWEP.MicroT1Pos = Vector(-4.738583, -4, 1.89355)
SWEP.MicroT1Ang = Vector(-0.3, 0, 0)
SWEP.AimpointPos = Vector(-4.755645, -4, 1.881766)
SWEP.AimpointAng = Vector(-0.3, 0, 0)
SWEP.ReflexPos = Vector(-4.755475, -4, 2.051755)
SWEP.ReflexAng = Vector(-0.3, 0, 0)
SWEP.CmorePos = Vector(-4.737244, -4, 1.916305)
SWEP.CmoreAng = Vector(-0.3, 0, 0)
SWEP.ShortDotPos = Vector(-4.719565, -4, 1.821961)
SWEP.ShortDotAng = Vector(-0.3, 0, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-4.720871, -4, 1.489856)
SWEP.ACOGAng = Vector(-0.3, 0, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-4.748356, -4, 2.161458)
SWEP.NXSAng = Vector(-0.3, 0, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SprintPos = Vector(7.5, -7.7, 0.15)
SWEP.SprintAng = Vector(-14, 53, -12)
SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_reload",
	["reload_empty"] = "anm_reload_empty",
	["anm_hide"] = "anm_hide",
	["anm_hide_w_gl"] = "anm_hide_w_gl",
	["anm_hide_w_gl_setup"] = "anm_hide_w_gl_setup",
	["anm_idle"] = "anm_idle",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_w_gl"] = "anm_idle_w_gl",
	["anm_idle_w_gl_aim"] = "anm_idle_w_gl_aim",
	["anm_idle_w_gl_setup"] = "anm_idle_w_gl_setup",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_w_gl"] = "anm_idle_sprint_w_gl",
	["anm_idle_sprint_w_gl_setup"] = "anm_idle_sprint_w_gl_setup",
	["anm_reload_g"] = "anm_reload_g",
	["anm_reload"] = "anm_reload",
	["anm_reload_empty"] = "anm_reload_empty",
	["anm_reload_w_gl"] = "anm_reload_w_gl",
	["anm_reload_empty_w_gl"] = "anm_reload_empty_w_gl",
	["anm_shots"] = "anm_shots",
	["anm_shots_w_gl"] = "anm_shots_w_gl",
	["anm_shots_g"] = "anm_shots_g",
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
	["anm_show_w_gl"] = "anm_show_w_gl",
	["anm_show_w_gl_first"] = "anm_show_w_gl_first",
	["anm_show_w_gl_setup"] = "anm_show_w_gl_setup",
	["anm_show_w_gl_setup_first"] = "anm_show_w_gl_setup_first",
	["anm_sw_on"] = "anm_sw_on",
	["anm_sw_off"] = "anm_sw_off",
}
SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Holster",
		},
	},
	["anm_hide_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Holster",
		},
	},
	["anm_hide_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Holster",
		},
	},
	["anm_reload_g"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.ReloadG",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Reload",
		},
	},
	["anm_reload_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Reload",
		},
	},
	["anm_reload_empty_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Reload",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Draw",
		},
	},
	["anm_show_w_gl"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Draw",
		},
	},
	["anm_show_w_gl_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Draw",
		},
	},
	["anm_show_w_gl_setup"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Draw",
		},
	},
	["anm_show_w_gl_setup_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Draw",
		},
	},
	["anm_sw_on"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Switch",
		},
	},
	["anm_sw_off"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.HK416.Switch",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.933333
SWEP.ReloadTime_Empty = 3.933333
SWEP.ReloadHalt = 3.933333
SWEP.ReloadHalt_Empty = 3.933333
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_hk416_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.6324, -4.4206)
SWEP.WMAng = Vector(-5, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.HK416.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.HK416.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_hk416")
end

function SWEP:fireAnimFunc()
end

if CLIENT then
	SWEP.DefaultSightModel = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_hk416_hud_sights.mdl"

	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.335444, 8.523603, 10.459062),
			angle = Angle(-89.290422, -84.248866, -174.249138),
			size = Vector(1.21836, 1.21836, 1.21836),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.013428, -4.351219, -3.713447),
			angle = Angle(0.063484, -0.000268, -89.905992),
			size = Vector(0.487344, 0.487344, 0.487344),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.2711, 1.568946, 2.694333),
			angle = Angle(-0.0711, -179.99929, 90.706007),
			size = Vector(1.035606, 1.035606, 1.035606),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.052488, -4.397193, -6.760596),
			angle = Angle(-0.0711, -179.99929, 90.706007),
			size = Vector(0.791934, 0.791934, 0.791934),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.02434, -4.163107, -3.710457),
			angle = Angle(-0.0711, -179.99929, 90.706007),
			size = Vector(0.790715, 0.790715, 0.790715),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.407069, 2.054549, 2.108761),
			angle = Angle(-89.999681, 89.999836, 0),
			size = Vector(1.095305, 1.095305, 1.095305),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.407069, 2.057342, 2.108761),
			angle = Angle(-0.000164, 179.999836, 89.999727),
			size = Vector(1.096524, 1.096524, 1.096524),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.119081, -5.140087, -2.505133),
			angle = Angle(-89.999681, 89.999836, 0),
			size = Vector(0.91377, 0.91377, 0.91377),
		},
		["md_saker"] = {
			model = "models/cw2/attachments/556suppressor.mdl",
			bone = "wpn_body",
			pos = Vector(0.005108, 0.399689, -3.326522),
			angle = Angle(-0.000868, 179.999836, 89.999727),
			size = Vector(1, 1, 1),
		},
	}
end
