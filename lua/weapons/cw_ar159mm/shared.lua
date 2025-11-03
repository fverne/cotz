AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AR15-9MM"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
	SWEP.IronsightPos = Vector(-2.523, -1.798, 0.69)
	SWEP.IronsightAng = Vector(0.349, 0, 0)

	SWEP.AimpointPos = Vector(-2.524, 4, 0.745)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.ReflexPos = Vector(-2.524, 0, 0.75)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(-2.524, 4, 0.45)
	SWEP.CmoreAng = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.524, 0, 0.745)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.524, 4, 0.745)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-2.524, 4, 0.5)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.ACOGAxisAlign = {right = -0.5, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Weapon", rel = "", pos = Vector(0.064, -5.547, 4.006), angle = Angle(0, 180, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "Weapon", pos = Vector(-0.42, -12, -3.3), angle = Angle(0, -90, 0), size = Vector(1.25, 1.25, 1.25)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Weapon", pos = Vector(0, 8, 1.3), angle = Angle(0, 180, 0), size = Vector(1.0, 1.0, 1.0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Weapon", rel = "", pos = Vector(0.05, -5, 3.85), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0)},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Weapon", rel = "", pos = Vector(0.32, -17, -6.9), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), adjustment = {min = 11, max = 13, axis = "y", inverse = true}},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Weapon", rel = "", pos = Vector(-0.2, -12, -1.8), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), adjustment = {min = 4.5, max = 7.5, axis = "y", inverse = true}},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Weapon", rel = "", pos = Vector(0.02, -2, 4.1), angle = Angle(0, 0, 0), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 0)},
	}
	
	SWEP.LaserPosAdjust = Vector(1, 0, 0)
	SWEP.LaserAngAdjust = Angle(2, 180, 0) 
end

SWEP.SightBGs = {main = 1, carryhandle = 0, foldsight = 1, none = 1}
SWEP.BarrelBGs = {main = 3, longris = 4, long = 3, magpul = 2, ris = 1, regular = 0}
SWEP.StockBGs = {main = 2, regular = 0, heavy = 1, sturdy = 2}
SWEP.MagBGs = {main = 5, regular = 0, round60 = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore","md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_tundra9mm"}},
	["+reload"] = {header = "Ammo", offset = {800, -150}, atts = {"am_hollowpoint", "am_armorpiercing"}}}
	
SWEP.Animations = {fire = {"shoot1_unsil", "shoot2_unsil", "shoot3_unsil"},
	reload_empty = "reload",
	reload = "reload_full",
	idle = "idle_unsil",
	draw = "draw_unsil"}
	
SWEP.Sounds = {draw_unsil = {{time = 0, sound = "CW_FOLEY_MEDIUM"},
	[2] = {time = 0.6, sound = "CW_M49MM_BOLTPULL"},
	[3] = {time = 0.9, sound = "CW_M49MM_BOLTRELA"}},

	reload_full = {[1] = {time = 0.6, sound = "CW_M49MM_MAGOUT"},
	[2] = {time = 1.9, sound = "CW_M49MM_MAGIN"},
	[3] = {time = 2.4, sound = "CW_M49MM_DATASS"}},	

	reload = {[1] = {time = 0.6, sound = "CW_M49MM_MAGOUT"},
	[2] = {time = 1.9, sound = "CW_M49MM_MAGIN"},
	[3] = {time = 2.4, sound = "CW_M49MM_DATASS"},
	[4] = {time = 3, sound = "CW_M49MM_BOLTPULL"},
	[5] = {time = 3.3, sound = "CW_M49MM_RELA"}}}

SWEP.SpeedDec = 5

SWEP.Slot = 3
SWEP.SlotPos = 0
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

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/v_cam_m49mm.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_cam_m49m.mdl"

SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/cw2/weapons/w_cam_m49m.mdl"
SWEP.WMPos = Vector(0,0,0)
SWEP.WMAng = Vector(-3,0,180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.FireDelay = 60/937
SWEP.FireSound = "CW_M49MM_FIRE"
SWEP.FireSoundSuppressed = "CW_M49MM_FIRE_SUPPRESSED"
SWEP.Recoil = 0.8

SWEP.HipSpread = 0.065
SWEP.AimSpread = 0.035
SWEP.VelocitySensitivity = 8
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.006
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 43
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1.3
SWEP.ReloadTime = 2.9
SWEP.ReloadTime_Empty = 3.5
SWEP.ReloadHalt = 3.1
SWEP.ReloadHalt_Empty = 3.7
SWEP.SnapToIdlePostReload = false
