AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "P99"
	
	SWEP.IconLetter = "a"
	killicon.AddFont("cw_p99", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = false

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = 1}
		
	SWEP.IronsightPos = Vector(-2.105, -1.469, 0.68)
	SWEP.IronsightAng = Vector(0.6, 0, 0)

	SWEP.MicroT1Pos = Vector(-2.135, 0, -0.237)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.17, -2, -0.55)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.RMRPos = Vector(-2.135, 0, -0.12)
	SWEP.RMRAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(2.526, -9.506, -8.24)
	SWEP.SprintAng = Vector(70, 0, 0)

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(0, -1.2, 0)
	SWEP.BoltBonePositionRecoverySpeed = 25
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.BoltReloadOffset = Vector(0, 1.39, 0)
	SWEP.EmptyBoltHoldAnimExclusion = "fire_last"
	SWEP.ReloadBoltBonePositionRecoverySpeed = 20
	SWEP.ReloadBoltBonePositionMoveSpeed = 100
	SWEP.StopReloadBoneOffset = 0.8
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.SightWithRail = true
	SWEP.FOVPerShot = 0.3

	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "wpn_body", pos = Vector(-0.203, -9.6, 1.97), angle = Angle(0, 0, 0), size = Vector(0.52, 0.52, 0.52)},
		["md_rail"] = {model = "models/cw2/attachments/pistolrail.mdl", bone = "wpn_body", pos = Vector(-0.173, -4.663, 0.777), angle = Angle(0, -90, 0), size = Vector(0.15, 0.15, 0.15)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "wpn_body", pos = Vector(-0.179, -5.311, 3.41), angle = Angle(0, 0, 0), size = Vector(0.37, 0.37, 0.37)},
		["md_insight_x2"] = {model = "models/cw2/attachments/pistollaser.mdl", bone = "wpn_body", pos = Vector(-0.188, -5.661, 1.715), angle = Angle(0, -90, 0), size = Vector(0.14, 0.14, 0.14)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "wpn_body", pos = Vector(-0.41, 5.126, -7.46), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "wpn_body", pos = Vector(0.2, 0.2, -2.44), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
	}
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, -2)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 17 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.SlideBGs = {main = 1, pm = 0, pb = 1}
	SWEP.SuppressorBGs = {main = 2, pm = 1, pb = 2, none = 0}
	SWEP.MagBGs = {main = 3, regular = 0, extended = 1}
	
	SWEP.AttachmentPosDependency = {["md_insight_x2"] = {["md_microt1"] = Vector(-0.188, -5.661, 1.4)}}
end

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-350, -200}, atts = {"md_tundra9mm"}},
	[2] = {header = "Sight", offset = {200, -200}, atts = {"md_microt1", "md_eotech", "md_rmr"}},
	[3] = {header = "Rail", offset = {-350, 200}, atts = {"md_insight_x2"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {reload = "reload",
	fire = {"fire1", "fire2", "fire3"},
	fire_dry = "fire_last",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {{time = 0.61, sound = "CW_P99_MAGOUT"},
	{time = 1.23, sound = "CW_P99_MAGIN"},
	{time = 1.99, sound = "CW_P99_SLIDEBACK"},
	{time = 2.12, sound = "CW_P99_SLIDEFORWARD"}}
}

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

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/pistols/p99.mdl"
SWEP.WorldModel		= "models/srp/weapons/w_p99.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_P99_FIRE"
SWEP.FireSoundSuppressed = "CW_P99_FIRE_SUPPRESSED"
SWEP.Recoil = 1.67

SWEP.WearDamage = 0.125
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.125
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 42
SWEP.DeployTime = 0.4
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.59
SWEP.ReloadHalt = 1.8

SWEP.ReloadTime_Empty = 2.78
SWEP.ReloadHalt_Empty = 3

SWEP.SnapToIdlePostReload = true