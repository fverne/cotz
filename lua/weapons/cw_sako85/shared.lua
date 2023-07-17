AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Sako 85"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"

	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.MuzzleAttachmentName = "muzzle"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 2
	SWEP.ShellPosOffset = {x = 5, y = -200, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.ShellDelay = 0.8
	SWEP.FireMoveMod = 0.6
	
	SWEP.IronsightPos = Vector(-3.85, -3, 2.2)
	SWEP.IronsightAng = Vector(-0.7, 0.03, 0)

	SWEP.EoTechPos = Vector(-3.87, -12, 0.36)
	SWEP.EoTechAng = Vector(-0.7, 0.03, 0)
	
	SWEP.AimpointPos = Vector(-3.87, -3, 0.5)
	SWEP.AimpointAng = Vector(-0.7, 0.03, 0)

	SWEP.MicroT1Pos = Vector(-3.87, -3, 0.6)
	SWEP.MicroT1Ang = Vector(-0.7, 0.03, 0)
	
	SWEP.ReflexPos = Vector(-3.82, -7, 0.6)
	SWEP.ReflexAng = Vector(-0.7, 0.03, 0)
		
	SWEP.CmorePos = Vector(-3.85, -7, 0.5)
	SWEP.CmoreAng = Vector(-0.7, 0.03, 0)

	SWEP.SprintPos = Vector(3.029, -0.805, -2.201)
	SWEP.SprintAng = Vector(-4.926, 38.693, -18.292)

	SWEP.ShortDotPos = Vector(-3.83, -14, 0.47)
	SWEP.ShortDotAng = Vector(-0.7, 0.03, 0)
	SWEP.SchmidtShortDotAxisAlign = {right = 0.7, up = -0.03, forward = 0}
	
	SWEP.ACOGPos = Vector(-3.862, -14, 0.05)
	SWEP.ACOGAng = Vector(-0.7, 0.03, 0)
	SWEP.ACOGAxisAlign = {right = 0.7, up = -0.03, forward = 0}

	SWEP.NXSPos = Vector(-3.88, -12, 0.24)
	SWEP.NXSAng = Vector(-0.7, 0.03, 0)
	SWEP.NXSAlign = {right = 0.7, up = -0.03, forward = 0}

	SWEP.CustomizePos = Vector(5.519, 0, -1.601)
	SWEP.CustomizeAng = Vector(21.106, 25.326, 10.553)
	SWEP.SightWithRail = true


	//SWEP.DisableSprintViewSimulation = true

	SWEP.AttachmentModelsVM = {
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "v_fa_sako85", pos = Vector(-0.35, 1, -3.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "v_fa_sako85", pos = Vector(-0.3, 0, -4), angle = Angle(0, 0, 0), size = Vector(1.1, 1.1, 1.1)},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "v_fa_sako85", pos = Vector(0.3, -5, -10.8), angle = Angle(0, -90, 0), size = Vector(1.2, 1.2, 1.2)},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "v_fa_sako85", pos = Vector(0, 7, 2.35), angle = Angle(0, 180, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_rail"] = { type = "Model", model = "models/attachments/mosin/a_modkit_mosin.mdl", bone = "v_fa_sako85", pos = Vector(0, 10, 0.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "v_fa_sako85", pos = Vector(0, 16, -0.95), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "v_fa_sako85", pos = Vector(0, 10, 2.5), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "v_fa_sako85", pos = Vector(0, 7, 2.2), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "v_fa_sako85", pos = Vector(-0.15, 7, 3.6), angle = Angle(0, -90, 0), size = Vector(1.3, 1.3, 1.3)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "v_fa_sako85", pos = Vector(-0.38, 0.2, -3.4), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
	}


	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 179.5, 0) 
	
	SWEP.WS_PistolLaserPosAdjust = Vector(0, 0, 0)
	SWEP.WS_PistolLaserAngAdjust = Angle(0, 0, 0) 
end


	SWEP.Attachments = {
		[1] = {header = "Sight", offset = {-500, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore", "md_schmidt_shortdot", "md_nightforce_nxs", "md_acog"}},
		[2] = {header = "Barrel", offset = {-500, 150},  atts = {"md_saker"}},
		["+reload"] = {header = "Ammo", offset = {800, 150}, atts = {"am_hollowpoint", "am_armorpiercing"}}
	}

SWEP.Animations = {
	fire = {"Fire"}, //base_fire_start
	reload= "Reload_Ne",
	reload_empty = "Reload_Dry",
	idle = "Idle", //base_idle
	draw = "Draw"}
	
SWEP.Sounds = {
	
	Reload_Ne = {[1] = {time = 0.4, sound = "CW_SAKO85_MAGOUT"},
	[2] = {time = 0.9, sound = "CW_FOLEY_MEDIUM"},
	[3] = {time = 1.7, sound = "CW_SAKO85_MAGIN"}},
	Reload_Dry = {[1] = {time = 0.4, sound = "CW_SAKO85_MAGOUT"},
	[2] = {time = 0.9, sound = "CW_FOLEY_MEDIUM"},
	[3] = {time = 1.7, sound = "CW_SAKO85_MAGIN"},
	[4] = {time = 2.5, sound = "CW_SAKO85_BOLTBACK"},
	[5] = {time = 2.9, sound = "CW_SAKO85_BOLTFORWORD"}
	},

	Fire = {
	[1] = {time = 0.6, sound = "CW_SAKO85_BOLTBACK"},
	[2] = {time = 1, sound = "CW_SAKO85_BOLTFORWORD"}}}
	

SWEP.SpeedDec = 15

SWEP.ADSFireAnim = true
SWEP.BipodFireAnim = true
SWEP.AimBreathingIntensity = 1
SWEP.AimBreathingEnabled = false
SWEP.UseHands = true

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.WearDamage = 0.3
SWEP.WearEffect = 0.0001

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/tfa_nmrih/v_fa_sako85_ironsights.mdl"
SWEP.WorldModel		= "models/weapons/tfa_nmrih/w_fa_sako85_ironsights.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/tfa_nmrih/w_fa_sako85_ironsights.mdl"
SWEP.WMPos = Vector(-1, 4, 1.5)
SWEP.WMAng = Vector(-9,1,180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.FireDelay = 1.45
SWEP.FireSound = "CW_SAKO85_FIRE"
SWEP.FireSoundSuppressed = "CW_WS_MOSIN_SUB"
SWEP.Recoil = 2.2
SWEP.AimViewModelFOV = 50
SWEP.CustomizationMenuScale = 0.018
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.GlobalDelayOnShoot = 1.1

SWEP.HipSpread = 0.2
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 9
SWEP.MaxSpreadInc = 0.9
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 1
SWEP.Shots = 1
SWEP.Damage = 175
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.4
SWEP.ReloadTime_Empty = 3.8
SWEP.ReloadHalt = 2.7
SWEP.ReloadHalt_Empty = 4.1

SWEP.Chamberable = false
