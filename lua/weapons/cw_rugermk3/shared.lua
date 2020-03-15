AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Ruger MKIII"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = ""
	killicon.AddFont("", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_suppressed"
	SWEP.PosBasedMuz = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .25
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}

	SWEP.IronsightPos = Vector(2.809, 0, 1.799)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.DocterPos = Vector(2.809, 0, 1.599)
	SWEP.DocterAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-15.478, -1.407, 9.145)
	
	SWEP.CustomizePos = Vector(-4.222, -4.624, -0.805)
	SWEP.CustomizeAng = Vector(25.326, -19.698, -30.251)
	
	SWEP.AlternativePos = Vector(.600, -2, 0.759)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	
    SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.3
	SWEP.FullAimViewmodelRecoil = true
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(-1.3, 0, 0)
	SWEP.BoltBonePositionRecoverySpeed = 5
	SWEP.BoltReloadOffset = Vector(0, 0, 0)
	SWEP.ReloadBoltBonePositionRecoverySpeed = 99999
	SWEP.ReloadBoltBonePositionMoveSpeed = 99999
	SWEP.StopReloadBoneOffset = 0
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = false
	SWEP.DisableSprintViewSimulation = false
	SWEP.FOVPerShot = 0.1
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0.55, hor = 0.5, roll = 2, forward = 0, pitch = 1.5}
	SWEP.CustomizationMenuScale = 0.02
	SWEP.BoltBonePositionRecoverySpeed = 50 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
	

	}
end

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {["+reload"] = {header = "Ammo", offset = {500, 200}, atts = {"am_zoneloaded", "am_matchgrade"}}}

SWEP.Animations = {reload = "reload",
	fire = {"fire1"},
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.40, sound = "MK3_CLIPOUT"},
	[2] = {time = 1.5, sound = "MK3_CLIPIN"},
	[3] = {time = 2.1, sound = "MK3_SLIDERELEASE"}}}

SWEP.SpeedDec = 10

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

SWEP.ViewModelFOV	= 90
SWEP.AimViewModelFOV = 80
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_khri_rugermark.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_ruger23a1.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".22LR"

SWEP.WearDamage = 0.125
SWEP.WearEffect = 0.05

SWEP.FireDelay = 0.15
SWEP.FireSound = "MK3_FIRE"
SWEP.FireSoundSuppressed = "MK3_FIRE_SUPPRESSED"
SWEP.Recoil = 1

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Damage = 25
SWEP.DeployTime = .7
SWEP.ADSFireAnim = true

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 2.9
SWEP.ReloadHalt = 2.9

SWEP.ReloadTime_Empty = 2.9
SWEP.ReloadHalt_Empty = 2.9