AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "FN P90"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "m"
	killicon.AddFont("cw_p90", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.CustomizePos = Vector(-2.980, -3.666, -0.195)
	SWEP.CustomizeAng = Vector(19.351, -29.664, -10)
	
	SWEP.IronsightPos = Vector(3.855, -3, 0.810)
	SWEP.IronsightAng = Vector(2, 0, 0)
		
	SWEP.EoTechPos = Vector(3.83, -7, 0.5)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(3.86, -7, 0.71) --LOL 69 xD
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(3.855, -7.3, 0.74)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(3.855, -2, 0.835)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(3.848, -8, 0.85)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(1.20, 0.795, -0.12)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-1.359, -1.962, 0)
	SWEP.SprintAng = Vector(-7.702, -28.283, 0) 

	SWEP.CustomizationMenuScale = 0.012
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Body", rel = "", pos = Vector(-2.38, -4.255, -7.04), angle = Angle(0, 180, 0), size = Vector(0.9, 0.9, 0.9)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Body", rel = "", pos = Vector(-2.9, 1.332, -13), angle = Angle(2, 90, 0), size = Vector(1, 1, 1)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Body", rel = "", pos = Vector(-2.61, -10.061, -2), angle = Angle(0, 180, 0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Body", rel = "", pos = Vector(-2.6, -12.519, -1.735), angle = Angle(0, 180, 0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Body", pos = Vector(-2.6, -18.668, -6.14), angle = Angle(0, 0, 0), size = Vector(1.2, 1.2, 1.2)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Body", pos = Vector(-2.62, -10.057, -1.82), angle = Angle(0, 0, 0), size = Vector(0.38, 0.38, 0.38)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "Body", pos = Vector(-3.15, -12, -2.5), angle = Angle(0, -90, 90), size = Vector(0.4, 0.4, 0.4)}
	}
	
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.SightBGs = {main = 1, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {500, -450}, atts = {"md_microt1", "md_cmore", "md_reflex", "md_eotech", "md_aimpoint"}},
	[2] = {header = "Barrel", offset = {-500, -450}, atts = {"md_tundra9mm"}},
	[3] = {header = "Rail", offset = {-500, 50}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_zoneloaded", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_P90_DRAW"}},

	reload = {[1] = {time = 0.4, sound = "CW_P90_MAGRELEASE"},
	[2] = {time = 0.6, sound = "CW_P90_MAGOUT"},
	[3] = {time = 1.75, sound = "CW_P90_MAGIN"},
	[4] = {time = 2.6, sound = "CW_P90_BOLT"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.HoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "some faggot & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/therambotnic09/v_cst_p90.mdl"
SWEP.WorldModel		= "models/weapons/therambotnic09/w_cst_p90.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/therambotnic09/w_cst_p90.mdl"
SWEP.WMPos = Vector(-1, -1, -1)
SWEP.WMAng = Vector(0, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 50
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.7x28MM"

SWEP.HealthDamage = 0.1
SWEP.HealthEffect = 0.05

SWEP.FireDelay = 0.07
SWEP.FireSound = "CW_P90_FIRE"
SWEP.FireSoundSuppressed = "CW_P90_FIRE_SUPPRESSED"
SWEP.Recoil = 1.2

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 47
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 0.93
SWEP.ReloadTime = 2.5
SWEP.ReloadTime_Empty = 3.3
SWEP.ReloadHalt = 2.5
SWEP.ReloadHalt_Empty = 3.3
SWEP.SnapToIdlePostReload = true