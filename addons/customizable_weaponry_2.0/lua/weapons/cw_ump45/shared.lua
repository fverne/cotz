AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "H&K UMP .45"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "q"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "smallshell"
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.ShortDotPos = Vector(-2.241, -3.516, -0.267)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.IronsightPos = Vector(-2.256, -1.532, 0.192)
	SWEP.IronsightAng = Vector(0.49, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.257, 1.5, -0.202)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.263, -3.159, -0.5)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.263, -3.159, -0.311)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(-2.22, 0, 0.12)
	SWEP.CmoreAng = Vector(-1.60, 0.2, 0)
			
	SWEP.ReflexPos = Vector(-2.26, 0, 0)
	SWEP.ReflexAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.2555, -1.516, -0.53)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
		
	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)
	
	SWEP.SightWithRail = true
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(-0.64, 0.294, -0.978)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.012

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "UMP_Body", pos = Vector(-0.222, -6.613, -3.714), angle = Angle(0, 0, 0), adjustment = {min = -6.613, max = -5.65, inverseOffsetCalc = true, axis = "y"}, size = Vector(0.899, 0.899, 0.899)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "UMP_Body", pos = Vector(0.273, -11.313, -9.931), angle = Angle(3.332, -90, 0), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "UMP_Body", pos = Vector(0.023, -1.3, 1.511), angle = Angle(0, 180, 0), adjustment = {min = -1.3, max = 0.5, inverseOffsetCalc = true, axis = "y"}, size = Vector(0.4, 0.4, 0.4)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "UMP_Body", rel = "", pos = Vector(0, 0, 1.3), angle = Angle(0, 0, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "UMP_Body", rel = "", pos = Vector(0, 2, 1.5), angle = Angle(0, 0, 0), size = Vector(0.65, 0.65, 0.65), color = Color(255, 255, 255, 0)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "UMP_Body", pos = Vector(-0.801, 5.666, -0.534), angle = Angle(0, 90, -90), size = Vector(0.5, 0.5, 0.5)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "UMP_Body", pos = Vector(0.004, -3.846, -2.388), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_cobram2"] = {model = "models/cw2/attachments/cobra_m2.mdl", bone = "UMP_Body", pos = Vector(0, 11.5, -0.3), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "UMP_Body", pos = Vector(-0.288, -4.851, -3.437), angle = Angle(0, -90, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "UMP_Body", pos = Vector(-0.305, -5.851, -3.437), angle = Angle(0, 0, 0), size = Vector(0.85, 0.85, 0.85)},
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex", "md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", offset = {-400, -300},  atts = {"md_cobram2"}},
	[3] = {header = "Rail", offset = {800, 150},  atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {-400, 100}, atts = {"am_zoneloaded", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {{time = 0.45, sound = "CW_UMP45_MAGOUT"},
	{time = 1, sound = "CW_FOLEY_LIGHT"},
	{time = 1.7, sound = "CW_UMP45_MAGIN"},
	{time = 2.3, sound = "CW_FOLEY_LIGHT"}},
	
	reload_empty = {{time = 0.45, sound = "CW_UMP45_MAGOUT"},
	{time = 1, sound = "CW_FOLEY_LIGHT"},
	{time = 1.7, sound = "CW_UMP45_MAGIN"},
	{time = 2.2, sound = "CW_FOLEY_LIGHT"},
	{time = 2.5, sound = "CW_UMP45_BOLTBACK"},
	{time = 2.8, sound = "CW_UMP45_BOLTFORWARD"},
	{time = 3, sound = "CW_FOLEY_LIGHT"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "smg"
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
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
SWEP.ViewModel		= "models/cw2/smgs/ump.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_ump45.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ".45 ACP"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_UMP45_FIRE"
SWEP.FireSoundSuppressed = "CW_UMP45_FIRE_SUPPRESSED"
SWEP.Recoil = 1.2

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 54
SWEP.DeployTime = 0.5

SWEP.ReloadSpeed = 0.9
SWEP.ReloadTime = 2.65
SWEP.ReloadTime_Empty = 3.5
SWEP.ReloadHalt = 2.65
SWEP.ReloadHalt_Empty = 3.5