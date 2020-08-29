AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Mateba"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SelectIcon = surface.GetTextureID("weaponicons/mr96")

	SWEP.BaseArm = "Bip01 L Clavicle"
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/cwc_mateba/w_pist_mateba.mdl"
	SWEP.WMPos = Vector(-1, 0, 0)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = false
	SWEP.NoShells = true
		
	SWEP.IronsightPos = Vector(-3.724, -0.376, 1.154)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-3.75, 3.7, -0.301)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.RMRPos = Vector(-3.75, 3.7, 0)
	SWEP.RMRAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0, -5.01, -5.2)
	SWEP.SprintAng = Vector(30, -10, -5)
	
	SWEP.CustomizePos = Vector(1, -5, -5)
	SWEP.CustomizeAng = Vector(40, 15, 10)
	
	SWEP.AlternativePos = Vector(-2.2, 2.0, -0.3)
	SWEP.AlternativeAng = Vector(0, 0, 0)

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
	SWEP.SightWithRail = true
	SWEP.ReticleInactivityPostFire = 0.3
end

SWEP.AttachmentModelsVM = {
	["md_rail"] = {model = "models/cw2/attachments/pistolrail.mdl", bone = "body", pos = Vector(8, -1.2, 0), angle = Angle(0, 0, -90), size = Vector(0.18, 0.18, 0.18)},
	["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "body",  pos = Vector(-1.25, -2.25, -1.8), angle = Angle(0, 90, 0), size = Vector(0.6, 0.6, 0.6)},
	["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "body", pos = Vector(7, -4.35, 0), angle = Angle(90, -90, 0), size = Vector(0.479, 0.479, 0.479)},
	["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "body", pos = Vector(3, 1.5, 0.37), angle = Angle(0, 0, -90), size = Vector(1, 1, 1)},

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
	[1] = {header = "Sight", offset = {500, -300}, atts = {"md_microt1", "md_rmr"}},
	["+reload"] = {header = "Ammo", offset = {800, 300}, atts = {"am_zoneloaded", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0.0, sound = "CWC_FOLEY_LIGHT"},
	{time = 0.3, sound = "CWC_MATEBA_CHAMBER_OUT"},
	{time = 0.6, sound = "CWC_MATEBA_CLICK"}},

	shoot1 = {{time = 0.0, sound = "CWC_MATEBA_CLICK"},
	{time = 0.1, sound = "CWC_MATEBA_CLICK"}},
	shoot2 = {{time = 0.0, sound = "CWC_MATEBA_CLICK"},
	{time = 0.1, sound = "CWC_MATEBA_CLICK"}},

	reload = {{time = 0.0, sound = "CWC_FOLEY_LIGHT"},
{time = 0.2, sound = "CWC_MATEBA_CHAMBER_OUT"},
{time = 0.5, sound = "CWC_MATEBA_ROUNDS_OUT"},
{time = 0.78, sound = "CWC_SHELL_SMALL"},
{time = 0.9, sound = "CWC_SHELL_SMALL"},
{time = 1.12, sound = "CWC_SHELL_SMALL"},
{time = 1.20, sound = "CWC_SHELL_SMALL"},
{time = 1.3, sound = "CWC_MATEBA_ROUNDS_IN"},
{time = 1.35, sound = "CWC_FOLEY_LIGHT"},
{time = 1.48, sound = "CWC_SHELL_SMALL"},
{time = 1.49, sound = "CWC_SHELL_SMALL"},
{time = 1.5, sound = "CWC_SHELL_SMALL"},
{time = 1.6, sound = "CWC_FOLEY_TOSS"},
{time = 1.8, sound = "CWC_MATEBA_CHAMBER_IN"},
{time = 2.0, sound = "CWC_MATEBA_SPIN"},
{time = 2.4, sound = "CWC_MAG_DROP_REVOLVER"}}}

SWEP.SpeedDec = 10

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.ADSFireAnim = true
SWEP.FullAimViewmodelRecoil = true
SWEP.LuaVMRecoilAxisMod = {vert = -0.1, hor = 1, roll = 4, forward = 1.5, pitch = -0.5} -- modifier for intensity of the recoil on varying axes


SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
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
SWEP.ViewModel		= "models/weapons/cwc_mateba/v_pist_mateba.mdl"
SWEP.WorldModel		= "models/weapons/cwc_mateba/w_pist_mateba.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ADSSpeed = 1.6
SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".44 Magnum"

SWEP.FireDelay = 0.28
SWEP.FireSound = "CWC_MATEBA_FIRE"
SWEP.FireSoundSuppressed = "CWC_MATEBA_FIRE_SUP"
SWEP.Recoil = 4

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 60
SWEP.DeployTime = 0.7
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.6
SWEP.ReloadHalt = 2.7

SWEP.ReloadTime_Empty = 1.6
SWEP.ReloadHalt_Empty = 2.7

SWEP.WearDamage = 0.1
SWEP.WearEffect = 0.05