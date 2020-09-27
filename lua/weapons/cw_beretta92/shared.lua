AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Beretta 92"
	
	SWEP.IconLetter = "u"
	killicon.AddFont("cw_fiveseven", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = 0}
		
	SWEP.IronsightPos = Vector(3.16, 6, 1.559)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(-2, -9.933, -8.775)
	SWEP.SprintAng = Vector(70, 0, 0)
	
	SWEP.MicroT1Pos = Vector(3.15, 6, 0.2)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(3.12, -2, 0.1)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.RMRPos = Vector(3.18, 0, 0.6)
	SWEP.RMRAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(8.364, 0.741, 0.277)
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.BoltBone = "slidizzle"
	SWEP.BoltShootOffset = Vector(0, 1.5, 0)
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
		["md_rail"] = {model = "models/cw2/attachments/pistolrail.mdl", bone = "animooshiunzbysporkeh", pos = Vector(0, -1.2, -1.2), angle = Angle(0, -90, 0), size = Vector(0.18, 0.18, 0.18)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "animooshiunzbysporkeh", pos = Vector(0, -8, 0.45), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "animooshiunzbysporkeh", pos = Vector(0, -1.2, 2), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "animooshiunzbysporkeh", pos = Vector(-0.304, 10.126, -8.847), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "animooshiunzbysporkeh", pos = Vector(0.4, 3, -3.9), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 17 -- how fast does the bolt bone move back into it's initial position after the weapon has fired

end

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-350, -200}, atts = {"md_tundra9mm"}},
	[2] = {header = "Sight", offset = {400, -300}, atts = {"md_microt1", "md_eotech", "md_rmr"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_zoneloaded", "am_matchgrade"}}}

SWEP.Animations = {reload = "reload",
	reload_empty = "reload",
	fire = {"shoot1", "shoot2", "shoot3"},
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {
	draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {
	[1] = {time = 0.1, sound = "CW_BERETTA92_SLIDEBACK"},
	[2] = {time = 0.10, sound = "CW_BERETTA92_MAGOUT"},
	[3] = {time = 1.2, sound = "CW_BERETTA92_MAGIN"},
	[4] = {time = 2.1, sound = "CW_BERETTA92_SLIDEFORW"}}
	
}
SWEP.SpeedDec = 5

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
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_M92f_p228.mdl"
SWEP.WorldModel		= "models/weapons/w_M92f_p228.mdl"

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_M92f_p228.mdl"
	SWEP.WMPos = Vector(0, 0, 0)
	SWEP.WMAng = Vector(0, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.WearDamage = 0.125
SWEP.WearEffect = 0.05

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_BERETTA92_FIRE"
SWEP.FireSoundSuppressed = "CW_BERETTA92_FIRE_SUPPRESSED"
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 42
SWEP.DeployTime = 0.2
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.1
SWEP.ReloadHalt = 2.1

SWEP.ReloadTime_Empty = 1.69
SWEP.ReloadHalt_Empty = 2.3