AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Fort-12"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "f"
	killicon.AddFont("CW_fort12", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = false
	
	SWEP.BoltBone = "slider"
	SWEP.BoltShootOffset = Vector(-2, 0, 0)
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = 1}

	SWEP.IronsightPos = Vector(2.812, 5, 1.75)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(2.82, 3, 0.25)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(2.78, -4, 0.02)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.RMRPos = Vector(2.82, -5, 0.5)
	SWEP.RMRAng = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(-4.361, -5.829, -8.87)
	SWEP.SprintAng = Vector(70, 14.774, 0)
	
	SWEP.AlternativePos = Vector(-0.88, 1.325, -0.561)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(-10, 0, 0)
	SWEP.CustomizeAng = Vector(8.364, -45.741, 0.277)
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.SightWithRail = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 25 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "frame", pos = Vector(5, 0.5, -0.6), angle = Angle(0, 270, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_rail"] = {model = "models/cw2/attachments/slimpistolrail.mdl", bone = "frame", pos = Vector(3.5, -0.5, 0), angle = Angle(0, 0, 90), size = Vector(0.13, 0.13, 0.13)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "frame", pos = Vector(2.7, 1.8, 0), angle = Angle(270, 0, 90), size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "frame", pos = Vector(-8.3, -9.1, 0.3), angle = Angle(180, 180, -90), size = Vector(1, 1, 1)},
		["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "frame", pos = Vector(-2.3, -3.45, -0.35), angle = Angle(180, 180, -90), size = Vector(0.9, 0.9, 0.9)},
	}
end

SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {200, -200}, atts = {"md_microt1", "md_eotech", "md_rmr"}},
[2] = {header = "Barrel", offset = {-600, -350}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {-400, 330}, atts = {"am_zoneloaded", "am_matchgrade"}}}

SWEP.Animations = {fire = {"fire"},
	reload = "reload",
	reload_empty = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.42, sound = "CW_fort12_MAGOUT"},
	[2] = {time = 1.5, sound = "CW_fort12_MAGIN"}},
	
	reload_empty = {[1] = {time = 0.42, sound = "CW_fort12_MAGOUT"},
	[2] = {time = 1.5, sound = "CW_fort12_MAGIN"},
	[3] = {time = 2, sound = "CW_fort12_SLIDEFORWARD"}}}

SWEP.SpeedDec = 10

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

SWEP.ViewModelFOV	= 83
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/srp/weapons/v_fort12.mdl"
SWEP.WorldModel		= "models/srp/weapons/w_fort12.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 12
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x18MM"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_fort12_FIRE"
SWEP.FireSoundSuppressed = "CW_DEAGLE_FIRE_SUPPRESSED"
SWEP.Recoil = 1.4

SWEP.WearDamage = 0.125
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.125
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 5
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 42
SWEP.DeployTime = 1
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1.3
SWEP.ReloadTime = 2.1
SWEP.ReloadHalt = 2.7

SWEP.ReloadTime_Empty = 2.2
SWEP.ReloadHalt_Empty = 3

SWEP.SnapToIdlePostReload = true