AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "PTRS-41"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "n"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -3, y = 22, z = -2}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(10, -10, 0)
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_grub_ptrs.mdl"
	SWEP.WMPos = Vector(0, -8, 4)
	SWEP.WMAng = Vector(-5, 180, 180)
	
	SWEP.IronsightPos = Vector(-6.99, 0, 2.96)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-2.08, 0, 0.119)
	SWEP.SprintAng = Vector(-5.628, 35.478, 0)
	
	SWEP.SightWithRail = true
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(3, 0, 0)

	
	SWEP.AttachmentModelsVM = {
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

SWEP.RailBGs = {main = 3, on = 1, off = 0}
SWEP.BipodBGs = {main = 4, on = 1, off = 0}
SWEP.SightBGs = {main = 2, sg1 = 1, none = 0}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_zoneloaded", "am_matchgrade"}}}


SWEP.Animations = {fire = "shoot",
	reload = "reload",
	idle = "idle",
	draw = "deploy"}
	
SWEP.Sounds = {reload = {{time = 0.4, sound = "CW_PTRS_OPEN"},
	{time = 2, sound = "CW_PTRS_CLIPIN"},
	{time = 2.76, sound = "CW_PTRS_CLOSE"},
	{time = 3.76, sound = "CW_PTRS_BOLTBACK"},
	{time = 4.13, sound = "CW_PTRS_BOLTRELEASE"},
	{time = 4.3, sound = "CW_PTRS_BOLTHIT"}},
	
	deploy = {{time = 0.5, sound = "CW_FOLEY_MEDIUM"}}
	
	}

SWEP.SpeedDec = 80

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "some faggot & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_grub_ptrs.mdl"
SWEP.WorldModel		= "models/weapons/w_grub_ptrs.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "14.5x114MM"
SWEP.Chamberable			= false

SWEP.FireDelay = 1
SWEP.FireSound = "CW_PTRS_FIRE"
SWEP.FireSoundSuppressed = "CW_M14_FIRE_SUPPRESSED"
SWEP.Recoil = 18

SWEP.HealthDamage = 0.1
SWEP.HealthEffect = 0.05

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 400
SWEP.DeployTime = 1.5

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 4.3
SWEP.ReloadTime_Empty = 4.8
SWEP.ReloadHalt = 4.3
SWEP.ReloadHalt_Empty = 4.8

SWEP.SnapToIdlePostReload = false