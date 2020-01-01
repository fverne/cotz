AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Stechkin APS"
	SWEP.CSMuzzleFlashes = true
	SWEP.SelectIcon = surface.GetTextureID("VGUI/hud/ma85_wf_pt10")
	killicon.Add("cw_stechaps", "VGUI/hud/ma85_wf_pt10", Color(255, 255, 255, 255))
	
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.DryFire = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .6
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 1, z = 1}
	SWEP.MuzzlePosOffset = {x = -10, y = 0, z = 0}
	
		SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_ma85_wf_pt10.mdl"
	SWEP.WMPos = Vector(-10.5, -1, 3.8)
	SWEP.WMAng = Vector(0, 90, 180)
	
	SWEP.IronsightPos = Vector(-2.5212, 0, 0.3852)
	SWEP.IronsightAng = Vector(0.3044, 0, 0)

	SWEP.LaserPosAdjust = Vector(0, -6, -0.4)
	SWEP.LaserAngAdjust = Angle(0, 0, 0) 
	
	SWEP.SprintPos = Vector(0.920, 0, -1.960)
	SWEP.SprintAng = Vector(-13.9, 23.4, -28.3)
	
	SWEP.AlternativePos = Vector(-0.88, 1.325, -0.561)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizePos = Vector(14.88, -12.261, 1.88)
	SWEP.CustomizeAng = Vector(46.21, 56.1, 42.915)
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
  
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 20 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	

end
SWEP.SightBGs = {main = 1, none = 1}
SWEP.MuzzleBGs = {main = 0, off = 1, normal = 0}
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false
SWEP.ADSFireAnim = true


SWEP.AttachmentModelsVM = {
	["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "j_gun", pos = Vector(11, 0, 0.35), angle = Angle(0, 270, 0), size = Vector(1, 1, 1)},
}

SWEP.Attachments = {
[1] = {header = "Muzzle", offset = {0, 150}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {-400, 330}, atts = {"am_zoneloaded", "am_matchgrade"}}
}

SWEP.Animations = {fire = "fire",
	reload = "reload_full",
	reload_empty = "reload_empty",
	fire_dry = "firelast",
	idle = "idle",
	draw = "draw"}
	
	
	SWEP.Sounds = { reload_full = {[1] = {time = 0.3, sound = "WARFACE_pt10_MAGOUT"},
	[2] = {time = 1, sound = "WARFACE_pt10_MAGIN"}},
	
	reload_empty = {[1] = {time = 0.3, sound = "WARFACE_pt10_MAGOUT"},
	[2] = {time = 1, sound = "WARFACE_pt10_MAGIN"},
	[3] = {time = 1.4, sound = "WARFACE_pt10_BOLTBACK"},
	[4] = {time = 1.5, sound = "WARFACE_pt10_BOLTFORWARD"}}}
	
SWEP.DryFire = true
SWEP.AimViewModelFOV = 70
SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"
SWEP.SuppressedOnEquip = false


SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_ma85_wf_pt10.mdl"
SWEP.WorldModel		= "models/weapons/w_ma85_wf_pt10.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x18MM"

SWEP.FireDelay = 0.0923076923
SWEP.FireSound = "WARFACE_pt10_FIRE"
SWEP.FireSoundSuppressed = "WARFACE_pt10_FIRESIL"
SWEP.Recoil = 1.45

SWEP.HealthDamage = 0.1
SWEP.HealthEffect = 0.05

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 42
SWEP.DeployTime = 1
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.8
SWEP.ReloadHalt = 1.3

SWEP.ReloadTime_Empty = 2.1
SWEP.ReloadHalt_Empty = 1.8
SWEP.SnapToIdlePostReload = false