AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo("Gauss Ammo", "Gauss Ammo", 8.58, 69.20)

util.PrecacheModel( "models/weapons/gauss/v_stalker_gauss.mdl" )
util.PrecacheModel( "models/weapons/gauss/w_stalker_gauss.mdl" )

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Gauss Rifle"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.SelectIcon = surface.GetTextureID("weaponicons/gauss_rifle")
	killicon.Add("cw_gauss_rifle", "weaponicons/gauss_rifle", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.PosBasedMuz = false
	SWEP.FireMoveMod = 0.6

	SWEP.ShellPosOffset = { x = -5000, y = -5000, z = -5000 }
	
	SWEP.IronsightPos = Vector(3.602, -3.119, 1.039)
	SWEP.IronsightAng = Vector(0.142, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0.3)
	SWEP.SprintAng = Vector(-10.778, -27.573, 0)
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.AimBreathingEnabled = true
	SWEP.CrosshairEnabled = false
	SWEP.AimViewModelFOV = 40

	SWEP.ACOGPos = Vector(3.602, -3.119, 0.2)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(3.602, -3.119, 0.5)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(3.602, -3.119, 0.5)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(3.602, -3.119, 0.5)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.ShortDotPos = Vector(3.602, -3.119, 0.5)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.CustomizePos = Vector(-10, -5, 0)
	SWEP.CustomizeAng = Vector(5, -50, 0)

	SWEP.ACOGAxisAlign = { right = 0, up = 0, forward = 0 }
	SWEP.SchmidtShortDotAxisAlign = { right = 0, up = 0, forward = 0 }

	--SWEP.BaseArm = "Right_U_Arm"
	--SWEP.BaseArmBoneOffset = Vector(-500, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_acog"] = { model = "models/wystan/attachments/2cog.mdl", bone = "wire1", pos = Vector(1.473, -9.537, 4.053), angle = Angle(180, 0, 0), size = Vector(1, 1, 1) },
		["md_eotech"] = { model = "models/wystan/attachments/2otech557sight.mdl", bone = "wire1", pos = Vector(0.871, -15.511, 9.116), angle = Angle(180, 90, 0), size = Vector(1, 1, 1) },
		["md_aimpoint"] = { model = "models/wystan/attachments/aimpoint.mdl", bone = "wire1", pos = Vector(1.37, -9.665, 4), angle = Angle(180, 0, 0), size = Vector(1, 1, 1) },
		["md_microt1"] = { model = "models/cw2/attachments/microt1.mdl", bone = "wire1", pos = Vector(1.072, -4.511, -1.736), angle = Angle(180, 180, 0), size = Vector(0.56, 0.56, 0.56) },
		["md_schmidt_shortdot"] = { model = "models/cw2/attachments/schmidt.mdl", bone = "wire1", pos = Vector(1.506, -10.016, 3.976), angle = Angle(0, -90, 180), size = Vector(1, 1, 1) },
	}

	SWEP.CustomizationMenuScale = 0.017
end

SWEP.MuzzleVelocity = 10000 -- in meter/s

SWEP.SightBGs = { main = 2, none = 1 }
SWEP.ADSFireAnim = true
SWEP.PreventQuickScoping = true
SWEP.QuickScopeSpreadIncrease = 0.2

SWEP.Attachments = {
	[1] = { header = "Sight", offset = { 1600, -700 },  atts = { "md_microt1", "md_eotech", "md_aimpoint", "md_schmidt_shortdot", "md_acog" } },
}

SWEP.Animations = { 
	fire = { "shot" },
	reload = "reload",
	idle = "idle",
	draw = "draw"
}
	
SWEP.Sounds = {
	draw = { 
		{ time = 0, sound = "CW_GAUSS_DRAW" } 
	},
	reload = {
		[1] = { time = 0.25, sound = "CW_GAUSS_MAGOUT" },
		[2] = { time = 1.15, sound = "CW_GAUSS_MAGIN" }
	}
}

SWEP.SpeedDec = 50

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = { "semi" }
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Gauss Rifle"

SWEP.Author			= "Taxin2012"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/gauss/v_stalker_gauss.mdl"
SWEP.WorldModel		= "models/weapons/gauss/w_stalker_gauss.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Gauss Ammo"

SWEP.FireDelay = 2
SWEP.FireSound = "CW_GAUSS_FIRE"
SWEP.Recoil = 0.5

SWEP.HipSpread = 0.075
SWEP.AimSpread = 0.001
SWEP.VelocitySensitivity = 2.5
SWEP.MaxSpreadInc = 0.2
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 1.55
SWEP.Shots = 1
SWEP.Damage = 500
SWEP.DeployTime = 2.3

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.4
SWEP.ReloadTime_Empty = 2.4
SWEP.ReloadHalt = 2.4
SWEP.ReloadHalt_Empty = 2.3