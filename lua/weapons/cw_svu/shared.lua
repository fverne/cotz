AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo("7,62x54R", "7,62x54R Rounds", 7.62, 64.5)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Dragunov SVU"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.ZoomAmount = 10
	
	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_SUPPRESSED"
	
--	SWEP.MuzzleAttachmentName = "muzzle"
--	SWEP.MuzzleAttachment = true
	
--	SWEP.NoStockMuzzle = true
	
--	SWEP.WorldMuzzleAttachmentID = "muzzle"
	
	SWEP.PosBasedMuz = true
	SWEP.MuzzlePosMod = {x = -55, y = 50, z = -6}
	SWEP.MoveType = 1

	SWEP.SnapToGrip = false
	
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 1, y = 0, z = -4}
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_snip_svu.mdl"
	SWEP.WMPos = Vector(-1, -0.2, 1.3)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.IronsightPos = Vector(-3.096, -3.217, 0.726)
	SWEP.IronsightAng = Vector(0.179, 0.05, 0)
	
	SWEP.FoldSightPos = Vector(-2.208, -4.3, 0.143)
	SWEP.FoldSightAng = Vector(0.605, 0, -0.217)
		
	SWEP.EoTechPos = Vector(-2.21, -4.686, 0.239)
	SWEP.EoTechAng = Vector(0, 0, -0.217)
	
	SWEP.AimpointPos = Vector(-2.194, -4.686, 0.338)
	SWEP.AimpointAng = Vector(-1.951, 0, -0.217)
	
	SWEP.MicroT1Pos = Vector(-2.208, 1, 0.83)
	SWEP.MicroT1Ang = Vector(-1.938, 0, -0.217)
	
	SWEP.ACOGPos = Vector(-2.211, -4, 0.146)
	SWEP.ACOGAng = Vector(-1.4, 0, 0)
	
	SWEP.PSOPos = Vector(-2.914, 0, 0.449)
	SWEP.PSOAng = Vector(0, 0.349, 0)
	
	SWEP.KobraPos = Vector(-3.08, 0, 0.759)
	SWEP.KobraAng = Vector(-0.532, 0.15, 0)
	
	SWEP.ShortDotPos = Vector(-2.201, -4.148, 0.425)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(4.82, 0, 0)
    SWEP.CustomizeAng = Vector(5.859, 32.592, 0)
	
	SWEP.SprintPos = Vector(4.677, -2.023, -2.2)
    SWEP.SprintAng = Vector(1.069, 46.634, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.211, -4, -0.95), [2] = Vector(-2, 0, 0)}}

	SWEP.ACOGAxisAlign = {right = -0.5, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = -2, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.HUD_MagText = "CYLINDER: body "
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "body", rel = "", pos = Vector(0.1, 0.145, -1.596), angle = Angle(0, 180, 0), size = Vector(0.563, 0.563, 0.563)},
		["md_pso1"] = {model = "models/cw2/attachments/pso.mdl", bone = "body", rel = "", pos = Vector(-0.29, -5.244, -1.525), angle = Angle(0, 180, 0), size = Vector(0.838, 0.838, 0.838)},
	}
	
	SWEP.LaserPosAdjust = Vector(1, 0, 0)
	SWEP.LaserAngAdjust = Angle(2, 180, 0) 
	
	SWEP.BoltBone = "Bolt"
	SWEP.BoltShootOffset = Vector(-3, 0, 0)
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0, hor = 0, roll = 0, forward = 1.2, pitch = 1}
	
	SWEP.LuaViewmodelRecoil = false
    SWEP.LuaViewmodelRecoilOverride = false
    SWEP.FullAimViewmodelRecoil = true
	
	SWEP.PSO1AxisAlign = {right = 0, up = -0.7   , forward = 90}
end

SWEP.MuzzleVelocity = 880 -- in meter/s

SWEP.SightBGs = {main = 1, none = 1}

SWEP.Attachments = {
    [1] = {header = "Sight", offset = {-2920, -400},  atts = {"md_kobra", "md_pso1"}},
	["+reload"] = {header = "Ammo", offset = {-1700, 1600}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"shoot", "shoot2"},
	reload = "reload",
	idle = "idle1",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},
    draw = {{time = 0.6, sound = "CW_SVU_SAFE"}},

	reload = {[1] = {time = 0.75, sound = "CW_SVU_MAGOUT"},
	[2] = {time = 1.7, sound = "CW_SVU_CLOTH"},
	[3] = {time = 1.95, sound = "CW_SVU_MAGIN"},
	[4] = {time = 2.65, sound = "CW_SVU_MAGIN_FAST"},
	[5] = {time = 3.08, sound = "CW_SVU_BOLT"},
	[6] = {time = 3.32, sound = "CW_SVU_BOLT_FORWARD"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_snip_svu.mdl"
SWEP.WorldModel		= "models/weapons/w_snip_svu.mdl"
SWEP.ADSFireAnim = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x54MMR"

SWEP.FireDelay = 0.127
SWEP.FireSound = "CW_SVU_FIRE"
SWEP.FireSoundSuppressed = "CW_AR15_FIRE_SUPPRESSED"
SWEP.Recoil = 2.8

SWEP.HipSpread = 0.170
SWEP.AimSpread = 0.0015
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 200
SWEP.DeployTime = 1.3

SWEP.WearEffect = 0.08
SWEP.WearEffect = 0.007

-- SWEP.RecoilToSpread = .75

SWEP.RecoilToSpreadAuto = 0.1

SWEP.ReloadSpeed = 1.15
SWEP.ReloadTime = 2.6
SWEP.ReloadTime_Empty = 4.2
SWEP.ReloadHalt = 2.6
SWEP.ReloadHalt_Empty = 4.4
SWEP.SnapToIdlePostReload = true

-- SWEP.PenMod = 1
-- SWEP.CanPenetrate = true