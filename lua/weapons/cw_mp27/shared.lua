AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MP-27"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SelectIcon = surface.GetTextureID("weaponicons/mr96")
	killicon.Add("cw_mr96", "weaponicons/mr96", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.NoShells = true

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/tfa_ins2/wpn_mp27_w.mdl"
	SWEP.WMPos = Vector(-1.2, 3.5, -2.5)
	SWEP.WMAng = Vector(-12, 0, 180)
		
	SWEP.IronsightPos = Vector(-10.30, -9.50, 3.55)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0.256, 0.01, 1.2)
	SWEP.SprintAng = Vector(-17.778, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.281, 1.325, -0.52)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 0.8
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.DisableSprintViewSimulation = true
end

SWEP.BarrelBGs = {main = 1, regular = 1, long = 2, short = 0}
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false
SWEP.ADSFireAnim = false

SWEP.Attachments = {
--["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"}}
}
	
SWEP.Animations = {fire = "shoot",
	reload = "reload",
	reload_empty = "anm_reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.5, sound = "CW_TOZ34_OPEN"},
	[2] = {time = 2.0, sound = "CW_TOZ34_SHELL1"},
	[3] = {time = 3.0, sound = "CW_TOZ34_OPEN"}},
	
	anm_reload_empty = {[1] = {time = 0.5, sound = "CW_TOZ34_OPEN"},
	[2] = {time = 2.1, sound = "CW_TOZ_SHELL1"},
	[3] = {time = 2.5, sound = "CW_TOZ_SHELL2"},
	[4] = {time = 3.6, sound = "CW_TOZ34_OPEN"}}

	}

SWEP.SpeedDec = 10

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"break"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.WearDamage = 0.33
SWEP.WearEffect = 0.005

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 50
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/tfa_ins2/wpn_mp27_hud_v.mdl"
SWEP.WorldModel		= "models/weapons/tfa_ins2/wpn_mp27_w.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 2
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".45 ACP -41-"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_MP27_SHOT"
SWEP.Recoil = 3

SWEP.Chamberable = false

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.006
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.4
SWEP.ClumpSpread = 0.008
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 5
SWEP.Damage = 36
SWEP.DeployTime = 0.5

SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 3.5
SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt = 3.5
SWEP.ReloadHalt_Empty = 4.5

SWEP.SnapToIdlePostReload = false

function SWEP:IndividualInitialize()
	self:setBodygroup( 1 , 1 )
end
