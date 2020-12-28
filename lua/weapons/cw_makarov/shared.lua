AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Makarov PM"
	
	SWEP.IconLetter = "f"
	killicon.AddFont("cw_deagle", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_OTS"
	SWEP.PosBasedMuz = false

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = 1}
	SWEP.MuzzleAttachmentName = "muzzle"
		
	SWEP.IronsightPos = Vector(-1.8, 3.067, 0.98)
	SWEP.IronsightAng = Vector(-0.29, 0, 0)
	
	SWEP.PBIronsightsPos = Vector(-1.8, -3.067, 0.584)
	SWEP.PBIronsightsAng = Vector(0.699, 0, 0)
	
	SWEP.SprintPos = Vector(0.602, -0.202, 0)
	SWEP.SprintAng = Vector(-21.961, 3.517, 0)
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.BoltBone = "__nmBa_0"
	SWEP.BoltShootOffset = Vector(-1, 0, 0)
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.FOVPerShot = 0.3
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/pistols/w_makarov.mdl"
	SWEP.WMPos = Vector(-2.5, -1.5, -1.25)
	SWEP.WMAng = Vector(-5, 90, 180)

	
	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	--SWEP.FullAimViewmodelRecoil = true
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 17 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.SlideBGs = {main = 1, pm = 0, pb = 1}
	SWEP.SuppressorBGs = {main = 2, pm = 1, pb = 2, none = 0}
	SWEP.MagBGs = {main = 3, regular = 0, extended = 1}
end

SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {["+reload"] = {header = "Ammo", offset = {-400, 330}, atts = {"am_hollowpoint", "am_armorpiercing"}}}
	

SWEP.Animations = {reload = "reloadfull",
	reload_empty = "reloadempty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reloadfull = {[1] = {time = 0.73, sound = "CW_MAKAROV_MAGOUT"},
	[2] = {time = 1.62, sound = "CW_MAKAROV_MAGIN_PARTIAL"},
	[3] = {time = 1.82, sound = "CW_MAKAROV_MAGIN"}},
	
	reloadempty = {[1] = {time = 0.73, sound = "CW_MAKAROV_MAGOUT_EMPTY"},
	[2] = {time = 1.62, sound = "CW_MAKAROV_MAGIN_PARTIAL"},
	[3] = {time = 1.82, sound = "CW_MAKAROV_MAGIN"},
	[4] = {time = 2.39, sound = "CW_MAKAROV_SLIDE"}}
}

SWEP.SpeedDec = 0

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "pistol"
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 80
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/pistols/makarov.mdl"
SWEP.WorldModel		= "models/cw2/pistols/w_makarov.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x18MM"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_MAKAROV_FIRE"
SWEP.FireSoundSuppressed = "CW_MAKAROV_FIRE_SUPPRESSED_PM"
SWEP.Recoil = 1.5

SWEP.WearDamage = 0.125
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.125
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 41
SWEP.DeployTime = 1
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1.3
SWEP.ReloadTime = 2.1
SWEP.ReloadHalt = 2.7

SWEP.ReloadTime_Empty = 2.2
SWEP.ReloadHalt_Empty = 3
