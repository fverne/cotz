AddCSLuaFile()
AddCSLuaFile("weapons/cw_toz34/sh_sounds.lua")
include("weapons/cw_toz34/sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TOZ-34"
	SWEP.CSMuzzleFlashes = true

	killicon.Add("cw_cotz_anomaly_toz34", "weaponicons/mr96", Color(255, 80, 0, 150))

	SWEP.NoShells = true

	SWEP.ViewModelMovementScale = 0.8
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 0.75, roll = 1, forward = 0.5, pitch = 1}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.DisableSprintViewSimulation = true
end

SWEP.CanRestOnObjects = false

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "bend_reload",
			pos = Vector(-0.017994, -3.084015, 3.10034),
			angle = Angle(0.00315, 0, -89.97769),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "bend_reload",
			pos = Vector(0.113227, -4.001485, 3.197218),
			angle = Angle(-89.997215, 90, 0),
			size = Vector(1, 1, 1),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "bend_reload",
			pos = Vector(-0.273867, 7.104126, 13.630038),
			angle = Angle(-89.977469, 90, 0),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "bend_reload",
			pos = Vector(0.193625, 1.730315, 8.01977),
			angle = Angle(-0.00315, -180, 89.97769),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "bend_reload",
			pos = Vector(-0.015366, -2.916784, 2.498368),
			angle = Angle(-0.00315, -180, 89.97769),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "bend_reload",
			pos = Vector(-0.016309, -3.216929, -0.111841),
			angle = Angle(-0.00315, -180, 89.97769),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "bend_reload",
			pos = Vector(0.296484, 1.725661, 7.518137),
			angle = Angle(-89.997215, 90, 0),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "bend_reload",
			pos = Vector(0.340499, 2.287259, 8.111464),
			angle = Angle(-0.002785, -180, 89.999982),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/rail.mdl",
			bone = "bend_reload",
			pos = Vector(0.365371, -1.022586, 3.832809),
			angle = Angle(-89.997215, 90, 0),
			size = Vector(0.788252, 1.582508, 1.032406),
		},
	}
end

SWEP.Attachments = {
	[1] = {
		header = "Sight",
		offset = {300, -300},
		atts = {
		"md_microt1",
		"md_nightforce_nxs",
		"md_eotech",
		"md_aimpoint",
		"md_cmore",
		"md_reflex",
		"md_schmidt_shortdot",
		"md_acog",
	},
	},
	["+reload"] = {
		header = "Ammo",
		offset = {700, 325},
		atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"},
	},
}

SWEP.SpeedDec = 10

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"break","2burst"}
SWEP.Base = "cw_base"
SWEP.Category = "Anomaly Reskins"
SWEP.AdminOnly = true

SWEP.WearDamage = 0.33
SWEP.WearEffect = 0.005

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 2
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.08
SWEP.Recoil = 3

SWEP.Chamberable = false

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.006
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.4
SWEP.ClumpSpread = 0.008
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 9
SWEP.Shots_Base = 9
SWEP.Damage = 35
SWEP.DeployTime = 0.5

function SWEP:IndividualThink()
	if self.FireMode == "2burst" and self:Clip1() > 1 then
		self.AmmoPerShot = 2
		self.Shots = self.Shots_Base * 2
		self.Recoil = self.Recoil_Orig * 1.75
	else
		self.AmmoPerShot = 1
		self.Shots = self.Shots_Base
		self.Recoil = self.Recoil_Orig
	end
end

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_toz34.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/toz34.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_toz34_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.26, -1, 2.515)
SWEP.IronsightAng = Vector(0.305, 0, 0)

SWEP.MicroT1Pos = Vector(-3.239891, -1.371, 1.471616)
SWEP.MicroT1Ang = Vector(0.305, 0, 0)
SWEP.NXSPos = Vector(-3.258663, -1.371, 1.395813)
SWEP.NXSAng = Vector(0.305, 0, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.EoTechPos = Vector(-3.234322, -1.371, 1.217236)
SWEP.EoTechAng = Vector(0.305, 0, 0)
SWEP.AimpointPos = Vector(-3.234322, -1.371, 1.423268)
SWEP.AimpointAng = Vector(0.305, 0, 0)
SWEP.CmorePos = Vector(-3.234323, -1.371, 1.062806)
SWEP.CmoreAng = Vector(0.305, 0, 0)
SWEP.ReflexPos = Vector(-3.234323, -1.371, 1.256212)
SWEP.ReflexAng = Vector(0.305, 0, 0)
SWEP.ShortDotPos = Vector(-3.234523, -1.371, 1.496584)
SWEP.ShortDotAng = Vector(0.305, 0, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.243304, -2.371, 1.082158)
SWEP.ACOGAng = Vector(0.305, 0, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.SightWithRail = true
SWEP.SprintPos = Vector(6.5, -8.5, 0.6)
SWEP.SprintAng = Vector(-13, 50.5, -12)
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
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
}
SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TOZ34.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TOZ34.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TOZ34.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TOZ34.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.TOZ34.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.9
SWEP.ReloadTime_Empty = 4.0
SWEP.ReloadHalt = 2.9
SWEP.ReloadHalt_Empty = 4.0
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = false
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_toz34_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.4, 4.6846, -3.8228)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.TOZ34.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.TOZ34.FIRE"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_toz34")
end

function SWEP:fireAnimFunc()
end
