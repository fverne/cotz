AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "IMI UZI"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "l"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "smallshell"
	SWEP.ShellPosOffset = {x = 4, y = 0, z = 1}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_uzi.mdl"
	SWEP.WMPos = Vector(0, -15,0)
	SWEP.WMAng = Vector(0, 180, 180)
	
	SWEP.MicroT1Pos = Vector(-2.55, 8, -0.33)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.IronsightPos = Vector(-2.5646, 2, 0.6761)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.55, 0, -0.29)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.58, 0, -0.25)
	SWEP.AimpointAng = Vector(0, 0, 0)
		
	SWEP.ReflexPos = Vector(-2.55, -3.823, 0)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(-2.58, 1.5, -0.1)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0.273)
	SWEP.SprintAng = Vector(-12.132, 0, 0)

	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)
	
	SWEP.BoltBone = "Charging Handle"
	SWEP.BoltShootOffset = Vector(-2.5, 0, 0)
	SWEP.BoltBonePositionRecoverySpeed = 100
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.BoltReloadOffset = Vector(0, 0, 0)
	SWEP.ReloadBoltBonePositionRecoverySpeed = 8
	SWEP.ReloadBoltBonePositionMoveSpeed = 8
	SWEP.StopReloadBoneOffset = 0.57
	SWEP.HoldBoltWhileEmpty = true
	
	SWEP.CustomizationMenuScale = 0.01
	
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Main", pos = Vector(-0.04, -4, 2.6), angle = Angle(0, 180, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Main", pos = Vector(0.2, -15, -8.4), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Main", pos = Vector(-0.05, 9, 0), angle = Angle(0, 180, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Main", pos = Vector(-0.35, -10, -3.3), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "Main", pos = Vector(-0.35, -4, 0.5), angle = Angle(0, -90, 0), size = Vector(0.6, 1.1, 1)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Main", pos = Vector(0, 14, -2), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Main", rel = "", pos = Vector(-0.1, -2, 2.6), angle = Angle(0, 0, 0), size = Vector(0.65, 0.65, 0.65), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Main", rel = "", pos = Vector(-0.1, -3.5, 2.2), angle = Angle(0, 0, 0), size = Vector(0.749, 0.749, 0.749), color = Color(255, 255, 255, 0)},
	}
	
	SWEP.ForeGripHoldPos = {
		["Left12"] = {pos = Vector(0, 0, 0), angle = Angle(19.048, 0, 0) },
		["Left19"] = {pos = Vector(0, 0, 0), angle = Angle(7.56, -5.153, -33.453) },
		["Left3"] = {pos = Vector(0, 0, 0), angle = Angle(0, 98.859, 0) },
		["Left8"] = {pos = Vector(0, 0, 0), angle = Angle(28.447, 0, 0) },
		["Left18"] = {pos = Vector(0, 0, 0), angle = Angle(31.268, 8.871, -34.725) },
		["Left17"] = {pos = Vector(0, 0, 0), angle = Angle(4.524, 0.3, -39.885) },
		["Left11"] = {pos = Vector(0, 0, 0), angle = Angle(17.864, 0, 0) },
		["Left9"] = {pos = Vector(0, 0, 0), angle = Angle(8.972, 0, 0) },
		["Left_L_Arm"] = {pos = Vector(0.431, 1.017, -2.006), angle = Angle(0, 0, 87.377) },
		["Left24"] = {pos = Vector(0, 0, 0), angle = Angle(31.447, -4.021, -22.029) },
		["Left16"] = {pos = Vector(0, 0, 0), angle = Angle(7.047, 11.637, -22.139) },
		["Left14"] = {pos = Vector(0, 0, 0), angle = Angle(14.432, -4.611, 0) },
		["Left2"] = {pos = Vector(0, 0, 0), angle = Angle(0, 40.631, 0) },
		["Left_U_Arm"] = {pos = Vector(2.54, 0.004, 0), angle = Angle(0, 0, 0) }
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
end

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore"}},
	[2] = {header = "Barrel", offset = {-400, -500},  atts = {"md_tundra9mm"}},
	[3] = {header = "Handguard", offset = {-500, -200}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {-400, 330}, atts = {"am_zoneloaded", "am_matchgrade"}}}

SWEP.Animations = {fire = {"mac10_fire", "mac10_fire2", "mac10_fire3"},
	reload = "mac10_reload",
	reload_rail = "mac10_reload_rail",
	idle = "mac10_idle",
	draw = "mac10_draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	mac10_reload = {{time = 0.35, sound = "CW_MAC11_MAGOUT"},
	{time = 0.8, sound = "CW_FOLEY_LIGHT"},
	{time = 1.37, sound = "CW_MAC11_MAGIN"},
	{time = 1.6, sound = "CW_FOLEY_LIGHT"},
	{time = 2, sound = "CW_MAC11_BOLTBACK"},
	{time = 2.3, sound = "CW_FOLEY_LIGHT"}}
}

SWEP.SpeedDec = 10

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "revolver"
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "some faggot & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.HealthDamage = 0.1
SWEP.HealthEffect = 0.05

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_smg_mac11.mdl"
SWEP.WorldModel		= "models/weapons/w_uzi.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.Chamberable = false

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_MAC11_FIRE"
SWEP.FireSoundSuppressed = "CW_MAC11_FIRE_SUPPRESSED"
SWEP.Recoil = 1.2

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 44
SWEP.DeployTime = 0.45

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.79
SWEP.ReloadTime_Empty = 2.26
SWEP.ReloadHalt = 2
SWEP.ReloadHalt_Empty = 3

SWEP.SnapToIdlePostReload = true