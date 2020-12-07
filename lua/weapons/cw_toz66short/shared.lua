AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TOZ BM-16 Sawnoff"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SelectIcon = surface.GetTextureID("weaponicons/mr96")
	killicon.Add("cw_mr96", "weaponicons/mr96", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.NoShells = true
		
	SWEP.IronsightPos = Vector(-2.523, -1.316, 1.098)
	SWEP.IronsightAng = Vector(1.115, -0.151, 0)
	
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
SWEP.ADSFireAnim = true

SWEP.Attachments = {
["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds"}}
}
	
SWEP.Animations = {fire = {"fire1", "firelast"},
	reload = "reload",
	reload_empty = "reloadempty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.2, sound = "CW_TOZ_OPEN"},
	[2] = {time = 1.3, sound = "CW_TOZ_SHELL1"},
	[3] = {time = 2, sound = "CW_TOZ_HAMMER"},
	[4] = {time = 2.8, sound = "CW_TOZ_CLOSE"}},
	
	reloadempty = {[1] = {time = 0.2, sound = "CW_TOZ_OPEN"},
	[2] = {time = 1.3, sound = "CW_TOZ_SHELL1"},
	[2] = {time = 1.5, sound = "CW_TOZ_SHELL1"},
	[3] = {time = 2, sound = "CW_TOZ_HAMMER"},
	[4] = {time = 2.8, sound = "CW_TOZ_CLOSE"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "crossbow"
SWEP.FireModes = {"break"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/tayley/v_bm16.mdl"
SWEP.WorldModel		= "models/dobytchick/weapons/gmzone/deadair/w_toz66_obrez.mdl"

SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/dobytchick/weapons/gmzone/deadair/w_toz66_obrez.mdl"
SWEP.WMPos = Vector(1.7, -2.5, -0.5)
SWEP.WMAng = Vector(-10, 180, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 2
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.01
SWEP.FireSound = "CW_TOZ_FIRE"
SWEP.Recoil = 4.7

SWEP.WearDamage = 0.5
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.006
SWEP.VelocitySensitivity = 6
SWEP.MaxSpreadInc = 0.4
SWEP.ClumpSpread = 0.0425
SWEP.SpreadPerShot = 0.3
SWEP.SpreadCooldown = 0.5
SWEP.Shots = 9
SWEP.Damage = 21
SWEP.DeployTime = 1
SWEP.Chamberable = false


SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 3.2
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadHalt = 3.5
SWEP.ReloadHalt_Empty = 3.5