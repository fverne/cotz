AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "PP-19-01 Vityaz"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 0.7
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_smg_pp19vityaz.mdl"
	SWEP.WMPos = Vector(-1, -2, -1.5)
	SWEP.WMAng = Vector(-15, 0, 180)
	
	SWEP.IronsightPos = Vector(-3.116, -4.801, 1.1)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-3.066, 0, 0.518)
	SWEP.AimpointAng = Vector(-0.104, 0.165, 0)
	
	SWEP.MicroT1Pos = Vector(-3.056, 0, 0.40)
	SWEP.MicroT1Ang = Vector(0.8, 0.219, 0)
	
	SWEP.EoTechPos = Vector(-3.12, 0, 0.024)
	SWEP.EoTechAng = Vector(0.391, -0.04, 0)

	SWEP.CmorePos = Vector(-3.056, 0, 0.22)
	SWEP.CmoreAng = Vector(0.8, 0.219, 0)

	SWEP.ReflexPos = Vector(-3.056, 0, 0.35)
	SWEP.ReflexAng = Vector(0.8, 0.219, 0)
		
	SWEP.ShortDotPos = Vector(-3.105, -4, 0.55)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.24, 0, -0.48)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.IconLetter = "x"
	killicon.AddFont("cw_mp5", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	SWEP.ShellScale = 0.7
	SWEP.Shell = "smallshell"
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = -1, z = 3}
	
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(-1, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "wpn_body", rel = "", pos = Vector(0.31, -11.962, -10.155), angle = Angle(0, -90, 0), size = Vector(1.195, 1.195, 1.195)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "wpn_body", rel = "", pos = Vector(-0.231, -3.543, -2.3), angle = Angle(0, 0, 0), size = Vector(0.879, 0.879, 0.879)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "wpn_body", rel = "", pos = Vector(-0.02, 2.201, 2.828), angle = Angle(-0.002, 0, 0), size = Vector(0.358, 0.358, 0.358)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "wpn_body", pos = Vector(0, 14, 0), angle = Angle(0, 180, 0), size = Vector(1, 1, 1)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "wpn_body", pos = Vector(-0.3, -3.5, -1.9), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "wpn_body", rel = "", pos = Vector(0, 4, 2.9), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "wpn_body", rel = "", pos = Vector(0, 2.201, 2.628), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0)},

		}

	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end

end

SWEP.LuaViewmodelRecoil = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex", "md_schmidt_shortdot"}},
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_tundra9mm"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"},
    {time = 0.2, sound = "Weapon_PP19V_draw"}},
	
    reload = {[1] = {time = 0.35, sound = "CW_AR15_MAGOUT"},
	[2] = {time = 1.0, sound = "Weapon_PP19V_Cliprelease"},
    [3] = {time = 1.2, sound = "Weapon_Cloth2"},
	[4] = {time = 1.3, sound = "Weapon_PP19V_Clipout"},
    [5] = {time = 1.7, sound = "Weapon_Cloth1"},
    [6] = {time = 1.8, sound = "Weapon_PP19V_Clipin"},
    [7] = {time = 1.9, sound = "Weapon_Cloth3"},
    [8] = {time = 2.5, sound = "Weapon_Cloth4"},
	[9] = {time = 2.55, sound = "Weapon_PP19V_Slideback"}}}

SWEP.SpeedDec = 5

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_smg_pp19vityaz.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_pp19vityaz.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.076
SWEP.FireSound = "Weapon_PP19V"
SWEP.FireSoundSuppressed = "CW_PP19V_SUPPRESSED"
SWEP.Recoil = 1.25

SWEP.WearDamage = 0.11
SWEP.WearEffect = 0.015

SWEP.HipSpread = 0.065
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 53
SWEP.DeployTime = 1.5

SWEP.ReloadSpeed = 1.0
SWEP.ReloadTime = 2.45
SWEP.ReloadTime_Empty = 3.6
SWEP.ReloadHalt = 2.5
SWEP.ReloadHalt_Empty = 3.6
SWEP.SnapToIdlePostReload = true