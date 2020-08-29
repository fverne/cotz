AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Skorpion vz 61"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "q"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "smallshell"
	SWEP.ShellPosOffset = {x = -6, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1

	SWEP.BoltBone = "Bolt"
	SWEP.BoltShootOffset = Vector(-2, 0, 0)

	SWEP.IronsightPos = Vector(-3.045, 0, 0.4781)
	SWEP.IronsightAng = Vector(0.4029, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-3.045, 0, -0.6881)
	SWEP.MicroT1Ang = Vector(0.4029, 0, 0)
		
	SWEP.AimpointPos = Vector(-3.045, 0, -0.8881)
	SWEP.AimpointAng = Vector(0.4029, 0, 0)
		
	SWEP.ReflexPos = Vector(-3.045, 0, -0.62)
	SWEP.ReflexAng = Vector(0.4029, 0, 0)
	
	SWEP.SprintPos = Vector(2.605, -1.117, -0.559)
	SWEP.SprintAng = Vector(-19.535, 30.604, -32.931)
		
	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(20, 40.741, 15.277)

	SWEP.SightWithRail = true
	
	SWEP.CustomizationMenuScale = 0.012

	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Controller", pos = Vector(-0.75, -3.7, 0.058), angle = Angle(-90, 180, 90), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 0)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Controller", pos = Vector(-9.5, -3, 0.1), angle = Angle(90, 0, 90), size = Vector(0.5, 0.5, 0.5)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Controller", pos = Vector(5.5, 2.1, -0.21), angle = Angle(90, 180, 90), size = Vector(1, 1, 1)},
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "Controller", pos = Vector(-0.75, -1.7, -0.24), angle = Angle(0, 180, 90), size = Vector(0.4, 1.2, 1)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Controller", rel = "", pos = Vector(-3.3, -3.8, 0.03), angle = Angle(90, 0, -90), size = Vector(0.65, 0.65, 0.65), color = Color(255, 255, 255, 0)},
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_microt1", "md_aimpoint", "md_reflex"}},
	[2] = {header = "Barrel", offset = {-400, -300},  atts = {"md_tundra9mm"}},
	["+reload"] = {header = "Ammo", offset = {-400, 100}, atts = {"am_zoneloaded", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "fullreload",
	reload_empty = "emptyreload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	fullreload = {{time = 0.45, sound = "CW_SKORPION_MAGOUT"},
	{time = 1, sound = "CW_FOLEY_LIGHT"},
	{time = 1.8, sound = "CW_SKORPION_MAGIN"}},
	
	emptyreload = {{time = 0.45, sound = "CW_SKORPION_MAGOUT"},
	{time = 1, sound = "CW_FOLEY_LIGHT"},
	{time = 1.8, sound = "CW_SKORPION_MAGIN"},
	{time = 2.4, sound = "CW_SKORPION_BOLTBACK"}}
	
}

SWEP.SpeedDec = 30

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "smg"
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "some faggot & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_smg_vz61.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_skorp.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x18MM"

SWEP.FireDelay = 0.0705
SWEP.FireSound = "CW_SKORPION_FIRE"
SWEP.FireSoundSuppressed = "CW_SKORPION_FIRE_SUPPRESSED"
SWEP.Recoil = 1.9

SWEP.WearDamage = 0.1
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 75
SWEP.DeployTime = 0.5

SWEP.ReloadSpeed = 0.9
SWEP.ReloadTime = 2.4
SWEP.ReloadTime_Empty = 3.5
SWEP.ReloadHalt = 2.65
SWEP.ReloadHalt_Empty = 3.5