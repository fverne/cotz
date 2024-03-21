AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Saiga Sport 5.45"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "n"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -3, y = 22, z = -2}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(10, -10, 0)
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_bfh_saiga308.mdl"
	SWEP.WMPos = Vector(0, 0, 0)
	SWEP.WMAng = Vector(-10, 0, 180)
	
	SWEP.IronsightPos = Vector(-2.32, -1.76, 0.929)
	SWEP.IronsightAng = Vector(0.1, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.33, -1.76, -1.27)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.33, -1.76, -1.27)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.KobraPos = Vector(-2.32, -3.76, -0.233)
	SWEP.KobraAng = Vector(0, 0, 0)

	SWEP.CmorePos = Vector(-2.33, -1.76, -1.07)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.PSOPos = Vector(-2.14, -1.76, -0.25)
	SWEP.PSOAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.33, -1.76, -1.07)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-2.33, -1.76, -0.8)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-2.33, -1.76, -1.02)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.NXSPos = Vector(-2.38, -1.76, -1.12)
	SWEP.NXSAng = Vector(0, 0, 0)
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}

	SWEP.ACOGPos = Vector(-2.339, -3.76, -1.22)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.SprintPos = Vector(2, -4, 0.119)
	SWEP.SprintAng = Vector(-10.628, 25.478, 0)
	
	SWEP.CustomizePos = Vector(2.68, -1.68, 1)
	SWEP.CustomizeAng = Vector(1.299, 5.8, 21.299)
	
	SWEP.SightWithRail = true
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(-3, 0, 0)

	
	SWEP.AttachmentModelsVM = {
		//["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "body", pos = Vector(-1.5, 0, 1.2), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "body", pos = Vector(-0.1, 1, 0.6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "body", pos = Vector(0.15, 1.24, 2.6), angle = Angle(0, 180, 0), adjustment = {min = -1.3, max = 0.5, inverseOffsetCalc = true, axis = "y"}, size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "body", pos = Vector(0.4, -10, -8.3), angle = Angle(0, 270, 0), size = Vector(1, 1, 1)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "body", pos = Vector(0.1, 20, -0.85), angle = Angle(0, 180, 0), size = Vector(0.62, 0.62, 0.62)},
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "body", pos = Vector(0.6, 0.6, -2), angle = Angle(0, 180, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "body", pos = Vector(-0.13, -5, -3.2), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "body", pos = Vector(-0.15, -4, -2.1), angle = Angle(0, 270, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_pso1"] = {model = "models/cw2/attachments/pso.mdl", bone = "body", pos = Vector(0.2, -3.9, -1.7), angle = Angle(0, 180, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "body", rel = "", pos = Vector(0.13, 3, 2.6), angle = Angle(180, 180, 180), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "body", rel = "", pos = Vector(0.13, 2, 2.4), angle = Angle(180, 180, 180), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "body", pos = Vector(-0.3, -2, -3), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "body", pos = Vector(0, 1, 3.5), angle = Angle(0, 270, 0), size = Vector(1, 1, 1)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "body", pos = Vector(-0.15, -3.2, -1.8), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
	}

	SWEP.ForeGripHoldPos = {
	["l_ring_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(63.333, 0, 0) },
	["l_middle_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(78.888, 0, 0) },
	["l_thumb_mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 27.777, 5.556) },
	["l_pinky_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(45.555, 0, 0) },
	["l_index_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(107.777, 0, 0) },
	["l_forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-4.334, 12.444, 81.111) },
	["l_thumb_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(23.333, 23.333, 81.111) }
	}
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

SWEP.RailBGs = {main = 3, on = 1, off = 0}
SWEP.BipodBGs = {main = 4, on = 1, off = 0}
SWEP.SightBGs = {main = 2, sg1 = 1, none = 0}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_kobra", "md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex", "md_schmidt_shortdot", "md_pso1", "md_nightforce_nxs", "md_acog"}},
	[2] = {header = "Barrel", offset = {-450, -300},  atts = {"md_pbs1"}},
	[3] = {header = "Handguard", offset = {-300, 0}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {-450, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"shoot", "shoot2"},
	reload = "reload_empty",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "first_draw"}
	
SWEP.Sounds = {reload = {{time = 0.2, sound = "CW_FOLEY_LIGHT"},
	{time = 0.5, sound = "CW_SAIGA308_MAGOUT"},
	{time = 0.8, sound = "CW_FOLEY_LIGHT"},
	{time = 1.6, sound = "CW_SAIGA308_MAGIN"},
	{time = 2.2, sound = "CW_FOLEY_LIGHT"},
	{time = 2.9, sound = "CW_SAIGA308_BOLT"}},
	
	reload_empty = {{time = 0.2, sound = "CW_FOLEY_LIGHT"},
	{time = 0.5, sound = "CW_SAIGA308_MAGOUT"},
	{time = 0.8, sound = "CW_FOLEY_LIGHT"},
	{time = 1.6, sound = "CW_SAIGA308_MAGIN"},
	{time = 2.2, sound = "CW_FOLEY_LIGHT"},
	{time = 2.9, sound = "CW_SAIGA308_BOLT"}},
	
	draw = {{time = 0.5, sound = "CW_FOLEY_MEDIUM"},
	{time = 2.9, sound = "CW_SAIGA308_BOLT"}}
	
	}

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_bfh_saiga308.mdl"
SWEP.WorldModel		= "models/weapons/w_bfh_saiga308.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "5.45x39MM"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_SAIGA308_FIRE"
SWEP.FireSoundSuppressed = "CW_M14_FIRE_SUPPRESSED"
SWEP.Recoil = 1.4

SWEP.WearDamage = 0.11
SWEP.WearEffect = 0.015

SWEP.HipSpread = 0.12
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 6
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.03
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 70
SWEP.DeployTime = 0.5


SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.7
SWEP.ReloadTime_Empty = 3.7
SWEP.ReloadHalt = 3
SWEP.ReloadHalt_Empty = 3.8

SWEP.SnapToIdlePostReload = true
