AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "IMI Desert Eagle"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "f"
	killicon.AddFont("cw_deagle", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol_deagle"
	SWEP.PosBasedMuz = false
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = 1}
		
	SWEP.MicroT1Pos = Vector(-2.28, 0, -0.292)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.25, -6.198, -0.32)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.IronsightPos = Vector(-2.253, 1, 0.347)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.RMRPos = Vector(-2.27, -3, 0.15)
	SWEP.RMRAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.634, -8.28, -8.311)
	SWEP.SprintAng = Vector(70, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.88, 1.325, -0.561)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.BoltBone = "slider"
	SWEP.BoltShootOffset = Vector(-2, 0, 0)
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 25 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "weapon", pos = Vector(3.325, -1.075, 0.209), angle = Angle(90, 0, -90), size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "weapon", pos = Vector(-6.054, 8.47, -0.035), angle = Angle(0, 1.5, -90), size = Vector(0.85, 0.85, 0.85)},
		["md_cobram2"] = {model = "models/cw2/attachments/cobra_m2.mdl", bone = "weapon", pos = Vector(8, -0.5, 0.3), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255)},
		["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "weapon", pos = Vector(0, 2.5, 0.45), angle = Angle(0, 0, -90), size = Vector(0.6, 0.6, 0.6)},
	}
end

SWEP.BarrelBGs = {main = 1, regular = 0, compensator = 1, extended = 2}
SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {450, -350}, atts = {"md_microt1", "md_eotech", "md_rmr"}},
[2] = {header = "Barrel", offset = {-600, -350}, atts = {"md_cobram2"}},
["+reload"] = {header = "Ammo", offset = {450, 0}, atts = {"am_zoneloaded", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	reload_empty = "reload_2",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.42, sound = "CW_DEAGLE_MAGOUT"},
	[2] = {time = 1.5, sound = "CW_DEAGLE_MAGIN"}},
	
	reload_2 = {[1] = {time = 0.42, sound = "CW_DEAGLE_MAGOUT"},
	[2] = {time = 1.5, sound = "CW_DEAGLE_MAGIN"},
	[3] = {time = 2.36, sound = "CW_DEAGLE_SLIDEBACK"},
	[4] = {time = 2.47, sound = "CW_DEAGLE_SLIDEFORWARD"}}}

SWEP.SpeedDec = 15

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.HoldType = "pistol"
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "some faggot & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/pistols/deagle.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_deagle.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".50 AE"

SWEP.WearDamage = 0.125
SWEP.WearEffect = 0.05

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_DEAGLE_FIRE"
SWEP.FireSoundSuppressed = "CW_DEAGLE_FIRE_SUPPRESSED"
SWEP.Recoil = 2.8

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 65
SWEP.DeployTime = 1
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.98
SWEP.ReloadHalt = 2.49

SWEP.ReloadTime_Empty = 1.98
SWEP.ReloadHalt_Empty = 3.4