AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "S&W .500 Magnum"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SelectIcon = surface.GetTextureID("weaponicons/mr96")

	SWEP.BaseArm = "Bip01 L Clavicle"
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_erect_re500.mdl"
	SWEP.WMPos = Vector(-1, 0, 0)
	SWEP.WMAng = Vector(-10, 0, 180)
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = false
	SWEP.NoShells = true

	SWEP.IronsightPos = Vector(-2.018, 0, 0.1)
	SWEP.IronsightAng = Vector(-0.4, -0.01, 4.5)
	
	SWEP.ShortDotPos = Vector(-1.995, -5, -0.675)
	SWEP.ShortDotAng = Vector(-0.4, -0.01, 4.5)
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.RMRPos = Vector(-1.99, 0, -0.275)
	SWEP.RMRAng = Vector(-0.4, -0.01, 4.5)
	
	SWEP.SprintPos = Vector(0, -5.01, -5.2)
	SWEP.SprintAng = Vector(30, -10, -5)
	
	SWEP.CustomizePos = Vector(1, -5, -5)
	SWEP.CustomizeAng = Vector(40, 15, 10)
	
	SWEP.AlternativePos = Vector(-1.95, 2.0, -0.6)
	SWEP.AlternativeAng = Vector(0, 0, 4)

	SWEP.ViewModelMovementScale = 1
	SWEP.FullAimViewmodelRecoil = true
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.CustomizationMenuScale = 0.01
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LaserPosAdjust = Vector(0, 1, -2)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.LaserAngAdjustAim = Angle(0, 180, 0)
	
	SWEP.MoveType = 1
	
	SWEP.SlideBGs = {main = 1, pm = 0, pb = 1}
	SWEP.SuppressorBGs = {main = 2, pm = 1, pb = 2, none = 0}
	SWEP.MagBGs = {main = 3, regular = 0, extended = 1}
	SWEP.SightWithRail = false
	SWEP.ReticleInactivityPostFire = 0.3
end

SWEP.AttachmentModelsVM = {
	["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "sw500-gun",  pos = Vector(0, 3.8, -0.75), angle = Angle(0, 180, 0), size = Vector(0.6, 0.6, 0.6)},
	["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "sw500-gun", pos = Vector(0.25, 4.5, -2.35), angle = Angle(0, 90, 0), size = Vector(0.7, 0.7, 0.7)},
	["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "sw500-gun", pos = Vector(0.3, 5.019, -2.875), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8)},
}


SWEP.MuzzleVelocity = 414

SWEP.BarrelBGs = {main = 1, regular = 1, long = 2, short = 0}
SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.ForegripOverridePos = {
	["Singhand"] = {
	["l_upperarm"] = { scale = Vector(1, 1, 1), pos = Vector(-10, 5, -5), angle = Angle(0, -0, -0) }},
}	

SWEP.Attachments = {[2] = {header = "Barrel", offset = {-750, -200}, atts = {"md_saker"}},
	[1] = {header = "Sight", offset = {500, -300}, atts = {"md_microt1", "md_rmr", "md_schmidt_shortdot"}},
	["+reload"] = {header = "Ammo", offset = {800, 300}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0.0, sound = "CW_SW500_DEPLOY"}},

	reload = {{time = 0.0, sound = "CW_SW500_CLIPOUT"}}}

SWEP.SpeedDec = 10

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.ADSFireAnim = false
SWEP.FullAimViewmodelRecoil = true
SWEP.LuaVMRecoilAxisMod = {vert = -0.1, hor = 1, roll = 4, forward = 1.5, pitch = 0.5} -- modifier for intensity of the recoil on varying axes


SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "pistol"
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"double"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_pist_500.mdl"
SWEP.WorldModel		= "models/weapons/w_erect_re500.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ADSSpeed = 1.6
SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".500 Magnum"

SWEP.FireDelay = 0.28
SWEP.FireSound = "CW_SW500_FIRE"
SWEP.FireSoundSuppressed = "CWC_MATEBA_FIRE_SUP"
SWEP.Recoil = 8

SWEP.HipSpread = 0.07
SWEP.AimSpread = 0.00001
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.07
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 200
SWEP.DeployTime = 0.7
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.4
SWEP.ReloadHalt = 3.5

SWEP.ReloadTime_Empty = 3.4
SWEP.ReloadHalt_Empty = 3.5

SWEP.WearDamage = 0.22
SWEP.WearEffect = 0.05
