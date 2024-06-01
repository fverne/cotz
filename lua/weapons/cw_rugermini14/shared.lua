AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Ruger Mini-14"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "n"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 6, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.65
	SWEP.FireMoveMod = 0.6
	
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(10, -10, 0)
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_tfa_mn14_classic_hd.mdl"
	SWEP.WMAng = Vector(-22, 180, 180)
	SWEP.WMPos = Vector(1, -15, 0)
	
	SWEP.IronsightPos = Vector(-7.224, -9, 0.887)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-7.224, -16, 0.1)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-7.224, -16, 0)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.CmorePos = Vector(-7.224, -16, 0.25)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-7.224, 0, 0)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-7.224, -19, -0.1)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-7.224, -16, 0)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-7.224, -20, -0.25)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.NXSPos = Vector(-7.224, -20, 0.05)
	SWEP.NXSAng = Vector(0, 0, 0)
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.SprintPos = Vector(2, -4, 0.119)
	SWEP.SprintAng = Vector(-10.628, 25.478, 0)
	
	SWEP.CustomizePos = Vector(2.68, -1.68, 1)
	SWEP.CustomizeAng = Vector(1.299, 5.8, 21.299)
	
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.BaseArm = "ValveBiped.Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(0, 0, 0)
	SWEP.HoldBoltWhileEmpty = true

	
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "mini_14", pos = Vector(6.4, -14, 0), angle = Angle(-90, -10, 0), adjustment = {min = -1.3, max = 0.5, inverseOffsetCalc = true, axis = "y"}, size = Vector(0.5, 0.5, 0.5)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "mini_14", pos = Vector(-7, -1, 0.25), angle = Angle(180, 260, -90), size = Vector(1, 1, 1)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "mini_14", pos = Vector(1.5, -20, 0.23), angle = Angle(-90, -10, 0), size = Vector(1, 1, 1)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "mini_14", pos = Vector(-0.8, -7, -0.4), angle = Angle(180, -100, -90), size = Vector(1, 1, 1)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "mini_14", rel = "", pos = Vector(6.7, -15, -0.025), angle = Angle(90, -10, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "mini_14", rel = "", pos = Vector(5.4, -10, -0.025), angle = Angle(90, -10, 180), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 0)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "mini_14", pos = Vector(7, -12, -0.1), angle = Angle(0, 80, 90), size = Vector(1, 1, 1)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "mini_14", pos = Vector(-1, -6, -0.38), angle = Angle(90, 80, 90), size = Vector(1, 1, 1)},
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
SWEP.UseHands = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex", "md_schmidt_shortdot", "md_nightforce_nxs", "md_acog"}},
	["+reload"] = {header = "Ammo", offset = {-450, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = "shoot",
	fire_last = "shoot_last",
	reload = "reload",
	reload_empty = "reload1",
	idle = "idle_scoped",
	draw = "Draw"}
	
SWEP.Sounds = {reload = {[1] = {time = 0.7, sound = "CW_MINI14_BOLTBACK"},
	[2] = {time = 1.15, sound = "CW_MINI14_MAGOUT"},
	[3] = {time = 1.7, sound = "CW_FOLEY_MEDIUM"},
	[4] = {time = 2.5, sound = "CW_MINI14_MAGIN"},
	[5] = {time = 2.8, sound = "CW_SKS_BOLTFORWARD"}},
	
	reload = {[1] = {time = 0.9, sound = "CW_MINI14_MAGOUT"},
	[2] = {time = 1.7, sound = "CW_FOLEY_MEDIUM"},
	[3] = {time = 2.35, sound = "CW_MINI14_MAGIN"},
	[4] = {time = 3.3, sound = "CW_MINI14_BOLTBACK"},
	[5] = {time = 3.5, sound = "CW_MINI14_BOLTFORWARD"}},
	
	draw = {time = 0.5, sound = "CW_FOLEY_MEDIUM"}
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

SWEP.ViewModelFOV	= 50
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_tfa_mini14.mdl"
SWEP.WorldModel		= "models/weapons/w_tfa_mn14_classic_hd.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_MINI14_FIRE"
SWEP.FireSoundSuppressed = "CW_MINI14_FIRE_SUPPRESSED"
SWEP.Recoil = 1.4

SWEP.WearEffect = 0.08
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.12
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.09
SWEP.SpreadPerShot = 0.03
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 75
SWEP.DeployTime = 0.6


SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.8
SWEP.ReloadTime_Empty = 3.8
SWEP.ReloadHalt = 4
SWEP.ReloadHalt_Empty = 4

SWEP.SnapToIdlePostReload = true

SWEP.Chamberable = true