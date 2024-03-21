AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")


if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Browning Hi-Power"
	
	SWEP.IconLetter = "a"
	killicon.AddFont("cw_p99", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -5, y = 4, z = -5}
		
	SWEP.IronsightPos = Vector(-2.243, 2.494, 0.416)
	SWEP.IronsightAng = Vector(0.693, 0, 0)

	SWEP.MicroT1Pos = Vector(-2.243, 2.494, -0.95)
	SWEP.MicroT1Ang = Vector(0.693, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.243, -2.494, -1.12)
	SWEP.EoTechAng = Vector(0.693, 0, 0)
	
	SWEP.RMRPos = Vector(-2.243, -2.494, -0.6)
	SWEP.RMRAng = Vector(0.693, 0, 0)

	SWEP.SprintPos = Vector(0.602, -0.202, 0)
	SWEP.SprintAng = Vector(-21.961, 3.517, 0)
	
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(8.364, 0.741, 0.277)

	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.BoltBone = "Slidez"
	SWEP.BoltShootOffset = Vector(-1, 0, 0)
	SWEP.BoltBonePositionRecoverySpeed = 25
	SWEP.OffsetBoltDuringNonEmptyReload = false
	SWEP.BoltReloadOffset = Vector(0, 1.39, 0)
	SWEP.EmptyBoltHoldAnimExclusion = ""
	SWEP.ReloadBoltBonePositionRecoverySpeed = 20
	SWEP.ReloadBoltBonePositionMoveSpeed = 100
	SWEP.StopReloadBoneOffset = 0.8
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.SightWithRail = true
	SWEP.FOVPerShot = 0.3

	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Base", pos = Vector(0, 6, 1.05), angle = Angle(0, 180, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_rail"] = {model = "models/cw2/attachments/pistolrail.mdl", bone = "Base", pos = Vector(0, -0.601, 0.201), angle = Angle(0, 90, 0), size = Vector(0.15, 0.15, 0.15)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Base", pos = Vector(0, 0.018, 2.85), angle = Angle(0, 180, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Base", pos = Vector(0.25, -11, -8.047), angle = Angle(0, 270, 0), size = Vector(1, 1, 1)},
		["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "Base", pos = Vector(-0.35, -5, -2.45), angle = Angle(0, 270, 0), size = Vector(0.9, 0.9, 0.9)},
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
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {reload = "reload",
	fire = {"s1", "s2", "s3"},
	fire_dry = "sl",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {{time = 0.61, sound = "CW_BRHP_MAGOUT"},
	{time = 1.23, sound = "CW_BRHP_MAGIN"},
	{time = 1.99, sound = "CW_BRHP_SLIDEBACK"},
	{time = 2.12, sound = "CW_BRHP_SLIDEFORWARD"}}
}

SWEP.SpeedDec = 0

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "pistol"
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 90
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_baseplategsh18.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_brhp.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 13
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_BRHP_FIRE"
SWEP.FireSoundSuppressed = "CW_BRHP_FIRE_SUPPRESSED"
SWEP.Recoil = 1.1

SWEP.WearDamage = 0.22
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.075
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 58
SWEP.DeployTime = 0.4
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.5
SWEP.ReloadHalt = 2.8

SWEP.ReloadTime_Empty = 2.5
SWEP.ReloadHalt_Empty = 2.8

SWEP.SnapToIdlePostReload = false
