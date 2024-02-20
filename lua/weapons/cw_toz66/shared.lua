AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TOZ-66"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SelectIcon = surface.GetTextureID("weaponicons/mr96")
	killicon.Add("cw_mr96", "weaponicons/mr96", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.NoShells = true
		
	SWEP.IronsightPos = Vector(-5.78, -6.50, 3.05)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0.256, 0.01, 1.2)
	SWEP.SprintAng = Vector(-17.778, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.281, 1.325, -0.52)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 0.8
	SWEP.HUD_MagText = "TUBE: "

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.DisableSprintViewSimulation = true
end

SWEP.BarrelBGs = {main = 1, regular = 1, long = 2, short = 0}
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false
SWEP.ADSFireAnim = true
SWEP.UseHands = true

SWEP.Attachments = {
["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"}}
}
	
SWEP.Animations = {fire = "shoot",
	reload = "reload",
	reload_empty = "anm_reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.4, sound = "CW_TOZ_OPEN"},
	[2] = {time = 3.2, sound = "CW_TOZ_SHELL1"},
	[3] = {time = 4.5, sound = "CW_TOZ_CLOSE"}},
	
	anm_reload_empty = {[1] = {time = 0.4, sound = "CW_TOZ_OPEN"},
	[2] = {time = 3.2, sound = "CW_TOZ_SHELL1"},
	[3] = {time = 3.9, sound = "CW_TOZ_SHELL1"},
	[4] = {time = 4.7, sound = "CW_TOZ_CLOSE"},
	[5] = {time = 5.5, sound = "CW_TOZ_HAMMER"}}}

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

SWEP.ViewModelFOV	= 40
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/tfa_ins2/wpn_bm16_full_hud_v.mdl"
SWEP.WorldModel		= "models/dobytchick/weapons/gmzone/deadair/w_toz66.mdl"

SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/dobytchick/weapons/gmzone/deadair/w_toz66.mdl"
SWEP.WMPos = Vector(1, 0, 0)
SWEP.WMAng = Vector(-6, 180, 180)


SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 2
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_TOZ_FIRE"
SWEP.Recoil = 3

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.006
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.ClumpSpread = 0.0095
SWEP.SpreadPerShot = 0.3
SWEP.SpreadCooldown = 0.6
SWEP.Shots = 9
SWEP.Damage = 35
SWEP.DeployTime = 1
SWEP.Chamberable = false


SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 3.2
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadHalt = 5.8
SWEP.ReloadHalt_Empty = 6.6

function SWEP:IndividualInitialize()
	self:setBodygroup( 1 , 1 )
end
