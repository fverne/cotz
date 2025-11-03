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
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.6
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -5, y = -2, z = -2.5}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.IronsightPos = Vector(-3.75, -3.623, 0.220)
	SWEP.IronsightAng = Vector(1, -0.1, 0)
		
	SWEP.EoTechPos = Vector(-3.725, -6.634, -1.400)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-3.725, -6.714, -1.18)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(-3.725, -1, -1.24)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-3.725, -1, -1.15)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-3.725, -1, -1.04)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-3.725, -5.874, -1.15)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(-1.040, 0.583, -0.520)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-3.719, -5.874, -1.29)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.SightWithRail = true
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 1, forward = 0}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.BoltBone = "bolt_mesh"
	SWEP.BoltShootOffset = Vector(0, 3.014, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "body", rel = "", pos = Vector(0.335, 4.854, 0.84), angle = Angle(0, 90, 0), size = Vector(1.5, 1, 1.5)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "body", rel = "", pos = Vector(-0.14, -3.444, -1.525), angle = Angle(0, 0, 0), size = Vector(0.9, 0.9, 0.9)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "body", rel = "", pos = Vector(0.37, -8.363, -7.08), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "body", rel = "", pos = Vector(-0.209, -5.477, -3.270), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "body", pos = Vector(0.12, 2.460, -1.4), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "body", pos = Vector(0.110, 2.214, 3.75), angle = Angle(0, 180, 0), size = Vector(0.35, 0.35, 0.35)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "body", pos = Vector(-0.2, -1.9, -0.9), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "body", rel = "", pos = Vector(0.1, 3, 3.6), angle = Angle(0, 0, 0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "body", rel = "", pos = Vector(0.09, 5, 3.85), angle = Angle(0, 0, 0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "body", pos = Vector(-0.17, -0.38, -0.65), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
	}

	SWEP.ForeGripHoldPos = {
		["l-thumb-low"] = {pos = Vector(0, 0, 0), angle = Angle(13.333, -22.858, 0) },
		["l-pinky-low"] = {pos = Vector(0, 0, 0), angle = Angle(-43.811, 0, 0) },
		["l-thumb-mid"] = {pos = Vector(0, 0, 0), angle = Angle(3.809, 0, 0) },
		["l-middle-low"] = {pos = Vector(0, 0, 0), angle = Angle(32.381, 0, 5.714) },
		["l-ring-mid"] = {pos = Vector(0, 0, 0), angle = Angle(22.857, 0, 0) },
		["l-middle-tip"] = {pos = Vector(0, 0, 0), angle = Angle(47.618, 0, 0) },
		["l-forearm"] = {pos = Vector(-2.411, 0.609, 1.241), angle = Angle(0, -20.952, 28.57) },
		["lwrist"] = {pos = Vector(0, 0, 0), angle = Angle(-11.429, 9.524, 57.143) },
		["l-middle-mid"] = {pos = Vector(0, 0, 0), angle = Angle(5.714, 0, 0) },
		["l-pinky-tip"] = {pos = Vector(0, 0, 0), angle = Angle(106.666, 0, 0) },
		["l-thumb-tip"] = {pos = Vector(0, 0, 0), angle = Angle(78.095, 0, 0) },
		["l-index-mid"] = {pos = Vector(0, 0, 0), angle = Angle(55.237, 0, 0) },
		["l-index-low"] = {pos = Vector(0, 0, 0), angle = Angle(53.333, -7.619, 1.904) },
		["l-ring-tip"] = {pos = Vector(0, 0, 0), angle = Angle(59.048, 0, 0) }
	}
	
	SWEP.LaserPosAdjust = Vector(1, 0, 0)
	SWEP.LaserAngAdjust = Angle(2, 180, 0) 
end

SWEP.SightBGs = {main = 4, none = 2}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {500, -500}, atts = {"md_microt1", "md_cmore", "md_reflex", "md_eotech", "md_aimpoint", "md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", offset = {-400, -500}, atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-400, 100}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FAMAS_DRAW"}},

	reload = {[1] = {time = 0.6, sound = "CW_FAMAS_MAGOUT"},
	[2] = {time = 1.6, sound = "CW_FAMAS_MAGIN"},
	[3] = {time = 2.3, sound = "CW_FAMAS_BOLTPULL"},
	[4] = {time = 2.5, sound = "CW_FAMAS_BOLTRELEASE"}}}

SWEP.SpeedDec = 25

SWEP.Slot = 3
SWEP.SlotPos = 0
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

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/therambotnic09/v_cstmfamas.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_famas.mdl"

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
SWEP.FireSound = "CW_FAMAS_FIRE"
SWEP.FireSoundSuppressed = "CW_AR15_FIRE_SUPPRESSED"
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

SWEP.ReloadSpeed = 1.15
SWEP.ReloadTime = 3.6
SWEP.ReloadTime_Empty = 3.6
SWEP.ReloadHalt = 3.6
SWEP.ReloadHalt_Empty = 3.6
SWEP.SnapToIdlePostReload = true