AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "SW Model 29"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_rgnbull", "icons/killicons/khr_rgnbull", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_rgnbull")
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = true
	SWEP.NoShells = true
	
	SWEP.EffectiveRange_Orig = 52 * 39.37
	SWEP.DamageFallOff_Orig = .38
	
	SWEP.IronsightPos = Vector(-1.6333, 1, 1)
	SWEP.IronsightAng = Vector(-1.7, -0.35, -0.3)
	
	SWEP.M29ShortPos = Vector(-1.6333, 1, 0.9)
	SWEP.M29ShortAng = Vector(-1.1, -0.35, -0.3)
	
    SWEP.M29LongPos = Vector(-1.636, 1, 0.866)
	SWEP.M29LongAng = Vector(-0.9, -0.35, -0.3)
	
	SWEP.CustomizePos = Vector(3.488, -2.627, -0.821)
	SWEP.CustomizeAng = Vector(17.009, 29.971, 16.669)
	
	SWEP.CSGOACOGPos = Vector(-1.835, -3, -.09)
	SWEP.CSGOACOGAng = Vector(0.603, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-15.478, 11.96, 0)
	
	SWEP.AlternativePos = Vector(0, -0.55, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_taurus_327p.mdl"
	SWEP.WMPos = Vector(-1, 0, -2)
	SWEP.WMAng = Vector(-10, 0, 180)

	SWEP.ViewModelMovementScale = 1
	SWEP.BoltBone = "hammer"
	SWEP.BoltShootOffset = Vector(0, 0, -.25)
	SWEP.BoltBonePositionRecoverySpeed = 5
	SWEP.FullAimViewmodelRecoil = false
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = .5, hor = 1, roll = 1, forward = .5, pitch = 2}
	SWEP.CustomizationMenuScale = 0.016
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.AttachmentModelsVM = {
}
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
end

SWEP.MuzzleVelocity = 410 -- in meter/s

SWEP.BarrelBGs = {main = 1, snub = 0, short = 1, long = 2}
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.FullAimViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {["+reload"] = {header = "Ammo", offset = {450, 0}, atts = {"am_armorpiercing", "am_hollowpoint"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle1",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0.2, sound = "29_CYLINDERCLOSE"}},

	reload = {[1] = {time = 0.15, sound = "29_CYLINDEROPEN"},
	[2] = {time = 0.8, sound = "29_ROUNDSOUT"},
	[3] = {time = 2, sound = "29_ROUNDSIN"},
	[4] = {time = 2.7, sound = "29_CYLINDERCLOSE"}}}

SWEP.SpeedDec = 0

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"double"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 75
SWEP.ViewModelFlip	= false
SWEP.OverallMouseSens = 1
SWEP.ViewModel		= "models/khrcw2/v_khri_model29.mdl"
SWEP.WorldModel		= "models/weapons/w_taurus_327p.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".44 Magnum"

SWEP.FireDelay = 0.275
SWEP.FireSound = "29_FIRE"
SWEP.Recoil = 4

SWEP.HipSpread = 0.125
SWEP.AimSpread = 0.016
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 140
SWEP.DeployTime = .8
SWEP.Chamberable = false
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = .9
SWEP.ReloadTime = 3.4
SWEP.ReloadHalt = 3.4

SWEP.ReloadTime_Empty = 3.4
SWEP.ReloadHalt_Empty = 3.4

SWEP.WearDamage = 0.22
SWEP.WearEffect = 0.05
