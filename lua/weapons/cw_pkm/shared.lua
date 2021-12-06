if ( !CustomizableWeaponry ) then return end
AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "PKM"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IronsightPos = Vector(-2.217, -3.431, 0.381)
	SWEP.IronsightAng = Vector(-0.426, 0.02, 0)
	
	SWEP.AimpointPos = Vector(-2.221, -6.1, -0.301)
	SWEP.AimpointAng = Vector(-0.068, 0.014, 0)
	
	SWEP.EoTechPos = Vector(-2.215, -5.803, -0.78)
	SWEP.EoTechAng = Vector(-0.069, 0.014, 0)
	
	SWEP.MicroT1Pos = Vector(-2.211, -6.271, -0.364)
	SWEP.MicroT1Ang = Vector(0, 0.005, 0)
	
	SWEP.CmorePos = Vector(-2.25, -5.823, -0.38)
	SWEP.CmoreAng = Vector(-1.13, -0.058, 0)
	
	SWEP.ReflexPos = Vector(-2.211, -5.823, -0.101)
	SWEP.ReflexAng = Vector(-1.13, 0.057, 0)
	
	SWEP.ACOGPos = Vector(-2.234, -5.27, -0.635)
	SWEP.ACOGAng = Vector(-0.069, 0.014, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(-0.24, 0, -0.48)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 3, y = -6, z = -2}
	
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(-3.6, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true
	
	SWEP.SightWithRail = true
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_mach_pkmbenis.mdl"
	SWEP.WMPos = Vector(-0.75, 4.0, 0.5)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.AttachmentModelsVM = {
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "back", pos = Vector(-0.027, 3.04, -0.315), angle = Angle(0, 90, 0), size = Vector(0.537, 0.949, 0.75)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "back", pos = Vector(-0.52, 13.728, -9.604), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "back", pos = Vector(-0.055, 7.493, -3.145), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_bipod"] = {model = "models/wystan/attachments/bipod.mdl", bone = "PKM", pos = Vector(0.449, -11.905, -1.346), angle = Angle(0, -180, 0), size = Vector(1, 1, 1)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "PKM", pos = Vector(0.351, -21.949, -0.51), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "back", pos = Vector(-0.26, 2.519, 1.207), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "back", rel = "", pos = Vector(-0.22, 2.52, 1.067), angle = Angle(0, 180, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "back", rel = "", pos = Vector(-0.234, 0.666, 1.21), angle = Angle(0, 180, 0), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "back", pos = Vector(0.039, 6.934, -3.188), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75)}
	}
end

SWEP.LuaViewmodelRecoil = false
SWEP.ADSFireAnim = false
SWEP.BipodFireAnim = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -400},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog", "md_cmore", "md_reflex"}},
	[2] = {header = "Muzzle", offset = {-400, -200}, atts = {"md_pbs1"}},
	[3] = {header = "Barrel", offset = {-600, 300}, atts = {"md_bipod"}},
	["+reload"] = {header = "Ammo", offset = {1500, 400}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle1",
	draw = "draw"}
	
SWEP.Sounds = {	draw = {{time = 0, sound = ""}},

	reload = {[1] = {time = 0.6, sound = "CW_PKM_COVEROPEN"},
	[2] = {time = 0.8, sound = "CW_PKM_BELTOUT"},
	[3] = {time = 0.8, sound = "CW_FOLEY_LIGHT"},
	[4] = {time = 1.4, sound = "CW_PKM_BELTMOVE"},
	[5] = {time = 2.4, sound = "CW_PKM_MAGOUT"},
	[6] = {time = 2.6, sound = "CW_FOLEY_MEDIUM"},
	[7] = {time = 3.3, sound = "CW_PKM_MAGIN"},
	[8] = {time = 3.8, sound = "CW_PKM_BELTOUT"},
	[9] = {time = 4.0, sound = "CW_PKM_BELTMOVE"},
	[10] = {time = 4.8, sound = "CW_PKM_COVERCLOSE"},
	[11] = {time = 5.2, sound = "CW_PKM_COVERSMACK"},
	[12] = {time = 5.8, sound = "CW_PKM_BOLT"},
	[13] = {time = 6.0, sound = "CW_FOLEY_MEDIUM"}}}

SWEP.SpeedDec = 50

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "crossbow"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_lmg_weaponrpk.mdl"
SWEP.WorldModel		= "models/weapons/w_mach_pkmbenis.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x54MMR"

SWEP.FireDelay = 0.0923
SWEP.FireSound = "CW_PKM_FIRE"
SWEP.FireSoundSuppressed = "CW_PKM_SUPPRESSED"
SWEP.Recoil = 2.2

SWEP.WearDamage = 0.1
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 110
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1.0
SWEP.ReloadTime = 6.0
SWEP.ReloadTime_Empty = 6.0
SWEP.ReloadHalt = 6.2
SWEP.ReloadHalt_Empty = 6.2
SWEP.SnapToIdlePostReload = false