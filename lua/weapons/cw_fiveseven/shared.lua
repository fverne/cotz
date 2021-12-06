AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "FN Five-seveN"
	
	SWEP.IconLetter = "u"
	killicon.AddFont("cw_fiveseven", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = false

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.5
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = 0}
		
	SWEP.IronsightPos = Vector(-2.721, 0, 1.276)
	SWEP.IronsightAng = Vector(0.273, -1.461, 0)

	SWEP.SprintPos = Vector(3.632, -9.933, -8.775)
	SWEP.SprintAng = Vector(70, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.889, 0, -0.009)
	SWEP.MicroT1Ang = Vector(0, -1.943, 0)
	
	SWEP.EoTechPos = Vector(-2.41, -2, 0.1)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.RMRPos = Vector(-2.758, -4.185, 0.65)
	SWEP.RMRAng = Vector(0, -1.943, 0)
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.BoltBone = "Object014"
	SWEP.BoltShootOffset = Vector(-1.5, 0, 0)
	SWEP.BoltBonePositionRecoverySpeed = 25
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.BoltReloadOffset = Vector(0, 0, 0)
	SWEP.ReloadBoltBonePositionRecoverySpeed = 20
	SWEP.ReloadBoltBonePositionMoveSpeed = 100
	SWEP.StopReloadBoneOffset = 0.4
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DontMoveBoltOnHipFire = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.FOVPerShot = 0.3
	
	SWEP.SightWithRail = true

	SWEP.AttachmentModelsVM = {
		["md_rail"] = {model = "models/cw2/attachments/pistolrail.mdl", bone = "Object007", pos = Vector(0.076, 1.534, -0.343), angle = Angle(0, -90, 0), size = Vector(0.18, 0.18, 0.18)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Object007", pos = Vector(0, -4.5, 1), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Object007", pos = Vector(0.064, 0.805, 2.819), angle = Angle(0, 0, 0), size = Vector(0.479, 0.479, 0.479)},
		["md_insight_x2"] = {model = "models/cw2/attachments/pistollaser.mdl", bone = "Object007", pos = Vector(0.034, 0.37, 0.767), angle = Angle(0, -90, 0), size = Vector(0.14, 0.14, 0.14)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Object007", pos = Vector(-0.15, 10, -6.5), angle = Angle(0, 90, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "Object007", pos = Vector(0.3, 4, -0.8), angle = Angle(0, 90, 0), size = Vector(0.6, 0.6, 0.6)},
		}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 17 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, -2)
	SWEP.LaserAngAdjust = Angle(0, 180 + -1.7, 0) 
	
	SWEP.LaserAngAdjustAim = Angle(0, 180 - 0.5, 0)
	
	SWEP.SlideBGs = {main = 1, pm = 0, pb = 1}
	SWEP.SuppressorBGs = {main = 2, pm = 1, pb = 2, none = 0}
	SWEP.MagBGs = {main = 3, regular = 0, extended = 1}
	
	SWEP.AttachmentPosDependency = {["md_insight_x2"] = {["md_microt1"] = Vector(0.093, 0.37, 0.358)}}
end

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-350, -200}, atts = {"md_tundra9mm"}},
	[2] = {header = "Sight", offset = {400, -300}, atts = {"md_microt1", "md_eotech", "md_rmr"}},
	[3] = {header = "Rail", offset = {-350, 200}, atts = {"md_insight_x2"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {reload = "reload_cham",
	reload_empty = "reload",
	fire = {"shoot1", "shoot2", "shoot3"},
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},
	reload_cham = {{time = 0.15, sound = "CW_FIVESEVEN_MAGOUT"},
	{time = 1.2, sound = "CW_FIVESEVEN_MAGIN"}},
	
	reload = {{time = 0.15, sound = "CW_FIVESEVEN_MAGOUT"},
	{time = 1.2, sound = "CW_FIVESEVEN_MAGIN"},
	{time = 1.88, sound = "CW_FIVESEVEN_SLIDERELEASE"}}
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
SWEP.ViewModel		= "models/cw2/pistols/fiveseven.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_fiveseven.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "5.7x28MM"

SWEP.WearDamage = 0.125
SWEP.WearEffect = 0.05

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_FIVESEVEN_FIRE"
SWEP.FireSoundSuppressed = "CW_FIVESEVEN_FIRE_SUPPRESSED"
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 45
SWEP.DeployTime = 0.4
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.8
SWEP.ReloadHalt = 2.1

SWEP.ReloadTime_Empty = 1.69
SWEP.ReloadHalt_Empty = 2.3