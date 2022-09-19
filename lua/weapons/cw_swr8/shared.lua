AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")


if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "S&W M&P R8"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_rgnbull", "icons/killicons/khr_rgnbull", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_rgnbull")
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.NoShells = true
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_revolver_r8.mdl"
	SWEP.WMPos = Vector(-1, 0, -1.2)
	SWEP.WMAng = Vector(-20, 0, 180)
	
	SWEP.EffectiveRange_Orig = 51.3 * 39.37
	SWEP.DamageFallOff_Orig = .37
	
	SWEP.IronsightPos = Vector(-1.7, 1, 0.32)
	SWEP.IronsightAng = Vector(0.2, 0.05, 0)
	
	SWEP.CustomizePos = Vector(3.488, -2.627, -0.821)
	SWEP.CustomizeAng = Vector(12.009, 24.971, 16.669)
	
	SWEP.RMRPos = Vector(-1.7, -3, -0.178)
	SWEP.RMRAng = Vector(0.2, 0.05, 0)
	
	SWEP.SprintPos = Vector(0, 0, -1)
	SWEP.SprintAng = Vector(-15.478, 11.96, 0)
	
	SWEP.AlternativePos = Vector(0, 0, -0.6)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 1
	SWEP.FullAimViewmodelRecoil = true
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = .5, hor = 1, roll = 1, forward = .5, pitch = 2}
	SWEP.CustomizationMenuScale = 0.013
	SWEP.DisableSprintViewSimulation = true
	SWEP.ReticleInactivityPostFire = .55
	
	SWEP.AttachmentModelsVM = {
		["md_rmr"] = { type = "Model", model = "models/cw2/attachments/pistolholo.mdl", bone = "MR96", rel = "", pos = Vector(-0.301, -3.201, -1.55), angle = Angle(0, -90, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	}

end

SWEP.LaserPosAdjust = Vector(0, -5, -1)
SWEP.LaserAngAdjust = Angle(0, 180, 0) 

SWEP.MuzzleVelocity = 391 -- in meter/s

SWEP.BarrelBGs = {main = 1, norail = 0, rail = 1}
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.ADSFireAnim = false
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Optics", offset = {450, -400}, atts = {"md_rmr"}},
["+reload"] = {header = "Ammo", offset = {450, 200}, atts = {"am_armorpiercing", "am_hollowpoint"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle1",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "RB_DRAW"}},

	reload = {[1] = {time = 0.2, sound = "CWC_MATEBA_CHAMBER_OUT"},
	[2] = {time = .8, sound = "CWC_MATEBA_ROUNDS_OUT"},
	[3] = {time = 1.6, sound = "CWC_MATEBA_ROUNDS_IN"},
	[4] = {time = 1.85, sound = "CWC_MATEBA_CHAMBER_IN"}}}

SWEP.SpeedDec = 15

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

SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.OverallMouseSens = 1
SWEP.ViewModel		= "models/khrcw2/v_khri_swr8.mdl"
SWEP.WorldModel		= "models/weapons/w_revolver_r8.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".357 Magnum"

SWEP.FireDelay = 0.2
SWEP.FireSound = "R8_FIRE"
SWEP.Recoil = 3

SWEP.HipSpread = 0.125
SWEP.AimSpread = 0.0094
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 115
SWEP.DeployTime = 0.4
SWEP.FOVPerShot = 1
SWEP.Chamberable = false
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.5
SWEP.ReloadHalt = 2.5

SWEP.ReloadTime_Empty = 2.5
SWEP.ReloadHalt_Empty = 2.5

function SWEP:IndividualThink()
	self.EffectiveRange = 51.3 * 39.37
	self.DamageFallOff = .37

	self:setBodygroup(self.BarrelBGs.main,self.BarrelBGs.rail)
end

SWEP.WearDamage = 0.1
SWEP.WearEffect = 0.05