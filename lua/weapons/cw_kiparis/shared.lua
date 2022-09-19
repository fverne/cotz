AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "OTs-02 Kiparis"
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

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/dobytchick/weapons/gmzone/deadair/w_kiparis.mdl"
	SWEP.WMPos = Vector(2, -3, 1)
	SWEP.WMAng = Vector(-5, 180, 180)

	SWEP.BoltBone = "Bolt"
	SWEP.BoltShootOffset = Vector(-2, 0, 0)

	SWEP.IronsightPos = Vector(-2.48, 0, 0.79)
	SWEP.IronsightAng = Vector(0, 0.05, 0)
	
	SWEP.MicroT1Pos = Vector(-3.045, 0, -0.6881)
	SWEP.MicroT1Ang = Vector(0.4029, 0, 0)
		
	SWEP.AimpointPos = Vector(-3.045, 0, -0.8881)
	SWEP.AimpointAng = Vector(0.4029, 0, 0)
		
	SWEP.ReflexPos = Vector(-3.045, 0, -0.62)
	SWEP.ReflexAng = Vector(0.4029, 0, 0)
	
	SWEP.SprintPos = Vector(2.605, -1.117, -0.559)
	SWEP.SprintAng = Vector(-39.535, 30.604, -32.931)
		
	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(20, 40.741, 15.277)

	SWEP.SightWithRail = true
	
	SWEP.CustomizationMenuScale = 0.012

	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "body", pos = Vector(-9.1, -0.4, 1.12), angle = Angle(90, 0, 90), size = Vector(0.5, 0.5, 0.5)},
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[2] = {header = "Barrel", offset = {-400, -300},  atts = {"md_tundra9mm"}},
	["+reload"] = {header = "Ammo", offset = {-400, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload1",
	idle = "draw",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload1 = {{time = 0.45, sound = "CW_SKORPION_MAGOUT"},
	{time = 1, sound = "CW_FOLEY_LIGHT"},
	{time = 1.8, sound = "CW_SKORPION_MAGIN"},
	{time = 2.4, sound = "CW_SKORPION_BOLTBACK"}},
}

SWEP.SpeedDec = 5

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 90
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_notmicro_kiparis.mdl"
SWEP.WorldModel		= "models/dobytchick/weapons/gmzone/deadair/w_kiparis.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x18MM"

SWEP.FireDelay = 0.0705
SWEP.FireSound = "CW_KIPARIS_FIRE"
SWEP.FireSoundSuppressed = "CW_SKORPION_FIRE_SUPPRESSED"
SWEP.Recoil = 1.9

SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.2

SWEP.HipSpread = 0.125
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.6
SWEP.SpreadPerShot = 0.08
SWEP.SpreadCooldown = 0.95
SWEP.Shots = 1
SWEP.Damage = 33
SWEP.DeployTime = 0.5

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.85
SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt = 1.85
SWEP.ReloadHalt_Empty = 3

SWEP.SnapToIdlePostReload = false
