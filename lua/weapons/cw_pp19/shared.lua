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
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -1, y = 0, z = -4}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.8
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.87
	
	SWEP.IronsightPos = Vector(3.38, 0, 0.839)
	SWEP.IronsightAng = Vector(0.703, -0.405, 0)

	SWEP.KobraPos = Vector(3.39, 0, 0.55)
	SWEP.KobraAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-4.444, -1, 0.082)
	SWEP.SprintAng = Vector(-12.849, -39.23, 0)

	SWEP.CustomizePos = Vector(-8.174, -1.27, -1.288)
	SWEP.CustomizeAng = Vector(17.954, -40.578, -18.357)
	
	SWEP.AimpointPos = Vector(3.51, 0, -0.7)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(3.54, 1.5, -0.72)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(3.51, 1.5, -0.52)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.CmorePos = Vector(3.51, 1.5, -0.52)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(3.495, 1.5, -0.28)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(2.009, -5.844, 0.263)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.SightWithRail = true
	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 3, roll = 1, forward = 1, pitch = 1}
	SWEP.SprintViewNormals = {x = 1, y = -1, z = 1}

	SWEP.AttachmentModelsVM = {
		["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "a_bizon", pos = Vector(0.27, -1.4, 0.7), angle = Angle(180, 0, -90), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "a_bizon", pos = Vector(0.03, -3.4, 1), angle = Angle(180, 180, 90), adjustment = {min = -1.3, max = 0.5, inverseOffsetCalc = true, axis = "y"}, size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "a_bizon", pos = Vector(-0.2, 7.5, 11), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1)},
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "a_bizon", pos = Vector(-0.45, 0.7, 1.5), angle = Angle(180, 180, 90), size = Vector(0.5, 0.5, 0.5)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "a_bizon", pos = Vector(0.1, -0.1, -11.87), angle = Angle(0, 0, -90), size = Vector(0.6, 0.6, 0.6)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "a_bizon", rel = "", pos = Vector(0.04, -3.4, -1), angle = Angle(0, 180, 90), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "a_bizon", rel = "", pos = Vector(0.04, -3.2, 0), angle = Angle(0, 180, 90), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "a_bizon", pos = Vector(0.3, 2.4, 7), angle = Angle(180, 0, -90), size = Vector(1, 1, 1)},
	}

	SWEP.LaserPosAdjust = {x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = {p = 2, y = 180, r = 0}
	SWEP.SightWithRail = true
	SWEP.CustomizationMenuScale = 0.012
end

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {700, -400}, atts = {"md_kobra", "md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex"}},
[2] = {header = "Barrel", offset = {200, -400}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	reload_empty = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},
	
	reload = {[1] = {time = 0.4, sound = "CW_MP5_BOLTBACK"},
	[2] = {time = 1.5, sound = "CW_MP5_MAGOUT"},
	[3] = {time = 1.8, sound = "CW_MP5_MAGIN"},
	[4] = {time = 2.6, sound = "CW_MP5_BOLTFORWARD"}}}

SWEP.SpeedDec = 5

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "crossbow"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_smg_biz.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_biz.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 64
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x18MM"

SWEP.FireDelay = 0.075
SWEP.FireSound = "CW_BIZON_FIRE"
SWEP.FireSoundSuppressed = "CW_BIZON_FIRE_SUPPRESSED"
SWEP.Recoil = 1.5

SWEP.WearDamage = 0.0055
SWEP.WearEffect = 0.35

SWEP.HipSpread = 0.125
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 5
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.009
SWEP.SpreadCooldown = 0.5
SWEP.Shots = 1
SWEP.Damage = 44
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 1.3
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 2.2
SWEP.ReloadHalt = 2.6
SWEP.ReloadHalt_Empty = 3.5
