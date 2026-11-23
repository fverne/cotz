AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TOZ-34 Sawn-off"
	SWEP.CSMuzzleFlashes = true

	killicon.Add("cw_mr96", "weaponicons/mr96", Color(255, 80, 0, 150))

	SWEP.NoShells = true

	SWEP.ViewModelMovementScale = 0.8
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 0.75, roll = 1, forward = 0.5, pitch = 1}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.DisableSprintViewSimulation = true
end

SWEP.CanRestOnObjects = false

if CLIENT then
end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.026767, -2.925642, -2.17169),
			angle = Angle(0.027673, -0.000801, -88.156097),
			size = Vector(0.4, 0.4, 0.4),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.104201, -3.84515, -2.05214),
			angle = Angle(-89.997215, 90, 0),
			size = Vector(1, 1, 1),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.295662, 7.606571, 8.025221),
			angle = Angle(-88.155889, 89.139672, -0.859972),
			size = Vector(0.95, 0.95, 0.95),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.176493, 2.048186, 2.589373),
			angle = Angle(-0.027673, 179.999199, 88.156097),
			size = Vector(0.83, 0.83, 0.83),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(-0.039525, -2.794518, -2.786589),
			angle = Angle(-0.027673, 179.999199, 88.156097),
			size = Vector(0.9, 0.9, 0.9),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(-0.041335, -3.167003, -5.383151),
			angle = Angle(-0.027673, 179.999199, 88.156097),
			size = Vector(0.84, 0.84, 0.84),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.286752, 1.880206, 2.17863),
			angle = Angle(-89.997215, 90, 0),
			size = Vector(0.82, 0.82, 0.82),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.330578, 2.441184, 2.776814),
			angle = Angle(-0.002785, 180, 89.999982),
			size = Vector(0.92, 0.92, 0.92),
		},
		["md_rail"] = {
			model = "models/wystan/attachments/rail.mdl",
			bone = "wpn_body",
			pos = Vector(0.356407, -0.08063, -1.447996),
			angle = Angle(-89.997215, 90, 0),
			size = Vector(0.804133, 1.582508, 1.461263),
		},
	}
end

SWEP.Attachments = {
	[1] = {header = "Sight", offset = {800, -300}, atts = {
		"md_microt1",
		"md_nightforce_nxs",
		"md_eotech",
		"md_aimpoint",
		"md_cmore",
		"md_reflex",
		"md_schmidt_shortdot",
		"md_acog",
	}},
["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"}}
}

SWEP.SpeedDec = 0

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"break"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

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
SWEP.Recoil = 5

SWEP.Chamberable = false

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.006
SWEP.VelocitySensitivity = 7
SWEP.MaxSpreadInc = 0.4
SWEP.ClumpSpread = 0.035
SWEP.SpreadPerShot = 0.3
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 9
SWEP.Shots_Base = 9
SWEP.Damage = 35
SWEP.DeployTime = 0.5

SWEP.FireModes = {"break","2burst"}

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

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_toz34_sawedoff.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/toz34_obrez.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_toz34_obrez_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.26, -1, 2.515)
SWEP.IronsightAng = Vector(0.485, 0, 0)

SWEP.MicroT1Pos = Vector(-3.230794, -1.371, 1.463904)
SWEP.MicroT1Ang = Vector(0.485, 0, 0)
SWEP.NXSPos = Vector(-3.249716, -1.371, 1.353176)
SWEP.NXSAng = Vector(0.485, 0, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.EoTechPos = Vector(-3.234895, -1.371, 1.174284)
SWEP.EoTechAng = Vector(0.485, 0, 0)
SWEP.AimpointPos = Vector(-3.234782, -1.371, 1.343226)
SWEP.AimpointAng = Vector(0.485, 0, 0)
SWEP.CmorePos = Vector(-3.234326, -1.371, 0.8888)
SWEP.CmoreAng = Vector(0.485, 0, 0)
SWEP.ReflexPos = Vector(-3.233877, -1.371, 1.039032)
SWEP.ReflexAng = Vector(0.485, 0, 0)
SWEP.ShortDotPos = Vector(-3.224866, -1.371, 1.46497)
SWEP.ShortDotAng = Vector(0.485, 0, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-3.233458, -2.371, 1.045464)
SWEP.ACOGAng = Vector(0.485, 0, 0)
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
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_toz34_obrez_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.4, 4.0097, -2.3584)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.TOZ34.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.TOZ34.FIRE"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_toz34_sawedoff")
end

function SWEP:fireAnimFunc()
end
