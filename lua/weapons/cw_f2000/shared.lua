AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "FN F2000"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.6
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 4, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_cw2_efi.mdl"
	SWEP.WMPos = Vector( -0.6, -3, -1.4)
	SWEP.WMAng = Vector(-10, 0, 180)
	
	SWEP.IronsightPos = Vector(3.356, -2.5, 0.936)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(3.356, -4.4, 0.439)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(3.356, -3.2, 0.734)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(3.356, -4.4, 0.56)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(3.356, -3.2, 0.734)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.ReflexPos = Vector(3.356, -3.2, 1.034)
	SWEP.ReflexAng = Vector(0, 0, 0)

	SWEP.CmorePos = Vector(3.356, -3.2, 0.89)
	SWEP.CmoreAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(3.327, -3.2, 0.33)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.SprintPos = Vector(0.925, 0, 2.036)
	SWEP.SprintAng = Vector(-23.334, -25.556, 0)

	SWEP.CustomizePos = Vector(-6.091, 0, -3.144)
	SWEP.CustomizeAng = Vector(10.612, -34.972, 10.635)
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BaseArm = "L_Dummy"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "bone_body", rel = "", pos = Vector(10.8, -1.3, 0.157), angle = Angle(-90, 0, 90), size = Vector(1.169, 1.169, 1.169)},
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "bone_body", rel = "", pos = Vector(4, 3.3, -1.9), angle = Angle(0, 90, 0), size = Vector(0.55, 0.55, 0.55)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "bone_body", rel = "", pos = Vector(2.38, 5.498, -0.142), angle = Angle(-90, 0, 90), size = Vector(0.43, 0.43, 0.43)},
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "bone_body", rel = "", pos = Vector(-3, 0.2, -0.5), angle = Angle(0, 0, 90), size = Vector(0.899, 0.899, 0.899)},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "bone_body", rel = "", pos = Vector(-7, -5.4, 0.1), angle = Angle(0, 0, 90), size = Vector(1, 1, 1), adjustment = {min = 11, max = 13, axis = "y", inverse = true}},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "bone_body", rel = "", pos = Vector(5, 5.4, -0.17), angle = Angle(90, 180, -90), size = Vector(0.65, 0.65, 0.65), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "bone_body", rel = "", pos = Vector(2, 5.2, -0.17), angle = Angle(90, 180, -90), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "bone_body", pos = Vector(-2, -0.38, -0.5), angle = Angle(90, 90, 0), size = Vector(1, 1, 1)},
	}
	
	SWEP.LaserPosAdjust = Vector(1, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

SWEP.SightBGs = {main = 1, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {450, -500}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore","md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", offset = {0, -500}, atts = {"md_saker"}},
	["+reload"] = {header = "Ammo", offset = {200, 250}, atts = {"am_hollowpoint", "am_armorpiercing"}}}
	
	if CustomizableWeaponry_KK_HK416 then
		table.insert(SWEP.Attachments[1].atts, 2, "md_cod4_reflex")
end

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = 0.18, sound = "CW_F2000_BOLTBACK"},
	[2] = {time = .85, sound = "CW_F2000_MAGOUT"},
	[3] = {time = 1.95, sound = "CW_F2000_MAGIN"},
	[4] = {time = 2.7, sound = "CW_F2000_BOLTFORWARD"}}}
	

SWEP.SpeedDec = 25

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/cw2/weapons/v_cw2_effie.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_cw2_efi.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.WearDamage = 0.08
SWEP.WearEffect = 0.007

SWEP.FireDelay = 0.0705882352941176
SWEP.FireSound = "CW_F2000_FIRE"
SWEP.FireSoundSuppressed = "CW_F2000_FIRE_SUPPRESSED"
SWEP.Recoil = 1

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.09
SWEP.SpreadPerShot = 0.008
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 80
SWEP.DeployTime = 0.4

SWEP.ReloadSpeed = 1.25
SWEP.ReloadTime = 3.45
SWEP.ReloadTime_Empty = 3.45
SWEP.ReloadHalt = 1.9
SWEP.ReloadHalt_Empty = 3.1
SWEP.SnapToIdlePostReload = false

SWEP.Chamberable = false