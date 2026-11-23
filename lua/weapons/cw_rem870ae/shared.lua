AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Remington 870 AE"
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
	SWEP.DefaultSightModel = "models/flaymi/anomaly/weapons/attachments/v_models/wpn_remington870_ironsight_hud.mdl"

	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.530112, 8.027245, 8.274884),
			angle = Angle(-84.785503, -76.804994, -166.843921),
			size = Vector(1.21836, 1.21836, 1.21836),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(0.068264, -3.628782, -6.821001),
			angle = Angle(1.17777, 0.089936, -94.278315),
			size = Vector(0.487344, 0.487344, 0.487344),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.22776, 1.747308, 0.020786),
			angle = Angle(-1.18529, -179.908508, 95.078361),
			size = Vector(1.035606, 1.035606, 1.035606),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.193607, -3.492948, -9.864786),
			angle = Angle(-1.18529, -179.908508, 95.078361),
			size = Vector(0.791934, 0.791934, 0.791934),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.105967, -3.516312, -6.808666),
			angle = Angle(-1.18529, -179.908508, 95.078361),
			size = Vector(0.790715, 0.790715, 0.790715),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.375128, 2.285316, -0.522596),
			angle = Angle(-85.488462, -75.639464, -165.682128),
			size = Vector(1.095305, 1.095305, 1.095305),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.375128, 2.263741, -0.524245),
			angle = Angle(-1.114627, -179.914788, 94.371955),
			size = Vector(1.096524, 1.096524, 1.096524),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.177176, -4.376747, -5.663978),
			angle = Angle(-85.488462, -75.639464, -165.682128),
			size = Vector(0.91377, 0.91377, 0.91377),
		},
	}
end

SWEP.Attachments = {
	[1] = {header = "Sight", offset = {800, -300}, atts = {
		"md_eotech",
		"md_microt1",
		"md_aimpoint",
		"md_reflex",
		"md_cmore",
		"md_schmidt_shortdot",
		"md_acog",
		"md_nightforce_nxs",
	}},
["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"}}
}

SWEP.SpeedDec = 20

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 1.0
SWEP.Recoil = 3

SWEP.WearDamage = 0.33
SWEP.WearEffect = 0.005

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 0.5
SWEP.MaxSpreadInc = 0.4
SWEP.ClumpSpread = 0.018
SWEP.SpreadPerShot = 0.2
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 9
SWEP.Damage = 38
SWEP.DeployTime = 1

SWEP.ForceBackToHipAfterAimedShot = true

SWEP.Chamberable = false

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_remington870.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/remington870.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_remington870_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-4.482, 1, 3.385)
SWEP.IronsightAng = Vector(-3.7, -1.093, 0)

SWEP.EoTechPos = Vector(-4.331724, 1, 1.193869)
SWEP.EoTechAng = Vector(-3.7, -1.093, 0)
SWEP.MicroT1Pos = Vector(-4.538, 1, 2.688)
SWEP.MicroT1Ang = Vector(-3.7, -1.093, 0)
SWEP.AimpointPos = Vector(-4.484038, 1, 2.243618)
SWEP.AimpointAng = Vector(-3.7, -1.093, 0)
SWEP.ReflexPos = Vector(-4.64022, 1, 3.012791)
SWEP.ReflexAng = Vector(-3.7, -1.093, 0)
SWEP.CmorePos = Vector(-4.571553, 1, 2.655653)
SWEP.CmoreAng = Vector(-3.7, -1.093, 0)
SWEP.ShortDotPos = Vector(-4.457641, 1, 2.231128)
SWEP.ShortDotAng = Vector(-3.7, -1.093, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-4.518599, 1, 2.108)
SWEP.ACOGAng = Vector(-3.7, -1.093, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-4.562717, 1, 3.028977)
SWEP.NXSAng = Vector(-3.7, -1.093, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SprintPos = Vector(7.6, -7.8, 1.1)
SWEP.SprintAng = Vector(-21, 50, -17)
SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_open",
	["reload_start"] = "anm_open",
	["insert"] = "anm_add_cartridge",
	["reload_end"] = "anm_close",
	["anm_hide"] = "anm_hide",
	["anm_idle"] = "anm_idle",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_open"] = "anm_open",
	["anm_add_cartridge"] = "anm_add_cartridge",
	["anm_close"] = "anm_close",
	["anm_shots"] = "anm_shots",
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
}
SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.REMINGTON870.Holster",
		},
	},
	["anm_add_cartridge"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.REMINGTON870.ReloadInsert",
		},
	},
	["anm_close"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.REMINGTON870.ReloadEnd",
		},
	},
	["anm_shots"] = {
		[1] = {
			["time"] = 0.133333,
			["sound"] = "TFA_ANOMALY.REMINGTON870.Pump",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.REMINGTON870.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.REMINGTON870.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 0.6
SWEP.ReloadTime_Empty = 1
SWEP.ReloadHalt = 0.6
SWEP.ReloadHalt_Empty = 1
SWEP.ShotgunReload = true
SWEP.ReloadStartTime = 0.6
SWEP.InsertShellTime = 0.833333
SWEP.ReloadFinishWait = 1.233333
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = false
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_remington870_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.0222, -3.3634)
SWEP.WMAng = Vector(-5, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.REMINGTON870.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.REMINGTON870.FIRE"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_remington870")
end
