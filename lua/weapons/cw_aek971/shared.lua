AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AEK-971"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IronsightPos = Vector(-2.641, 0, 0.28)
	SWEP.IronsightAng = Vector(0.4, 0.6, 0)
	
	SWEP.AimpointPos = Vector(-2.641, 0, -1.595)
	SWEP.AimpointAng = Vector(0.4, 0.6, 0)
	
	SWEP.EoTechPos = Vector(-2.641, 0, -1.595)
	SWEP.EoTechAng = Vector(0.4, 0.6, 0)
	
	SWEP.KobraPos = Vector(-2.641, 0, -1.10)
	SWEP.KobraAng = Vector(0.4, 0.6, 0)

	SWEP.CmorePos = Vector(-2.641, 0, -1.395)
	SWEP.CmoreAng = Vector(0.4, 0.6, 0)
	
	SWEP.PSOPos = Vector(-2.5, 4, -0.575)
	SWEP.PSOAng = Vector(0.4, 0.6, 0)
	
	SWEP.MicroT1Pos = Vector(-2.641, 0, -1.395)
	SWEP.MicroT1Ang = Vector(0.4, 0.6, 0)
	
	SWEP.ReflexPos = Vector(-2.641, 0, -1.165)
	SWEP.ReflexAng = Vector(0.4, 0.6, 0)
	
	SWEP.CustomizePos = Vector(5, 0, 0)
	SWEP.CustomizeAng = Vector(6, 25, 0)

	SWEP.SprintPos = Vector(2, -2, 0.119)
	SWEP.SprintAng = Vector(-10.628, 25.478, 0)
	
	SWEP.ShortDotPos = Vector(-2.641, 0, -1.325)
	SWEP.ShortDotAng = Vector(0.4, 0.6, 0)
	
	SWEP.ACOGPos = Vector(-2.65, 0, -1.525)
	SWEP.ACOGAng = Vector(0.4, 0.6, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = true
	SWEP.MuzzleAttachment = 1
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 1, y = 4, z = -3}
	SWEP.SightWithRail = true
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.BoltBone = "Slide"
	SWEP.BoltShootOffset = Vector(-3, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true
	
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
//	SWEP.SchmidtShortDotAxisAlign = {right = -0.2, up = -18.9, forward = 0}

	SWEP.AttachmentModelsVM = {
		["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "Plane02", pos = Vector(0.1, 0.28, 0.9), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Plane02", pos = Vector(-0.05, 0.03, 2.9), angle = Angle(0, 270, 0), adjustment = {min = -1.3, max = 0.5, inverseOffsetCalc = true, axis = "y"}, size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Plane02", pos = Vector(-10, -0.23, -8), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "Plane02", pos = Vector(19, 0.2, -0.8), angle = Angle(0, -90, 0), size = Vector(0.82, 0.82, 0.82)},
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "Plane02", pos = Vector(-0.5, -0.41, -1.2), angle = Angle(180, 90, 180), size = Vector(0.6, 0.6, 0.6)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Plane02", pos = Vector(-6, 0.3, -2.9), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "Plane02", pos = Vector(-5, 0.31, -1.8), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_pso1"] = {model = "models/cw2/attachments/pso.mdl", bone = "Plane02", pos = Vector(-5.2, 0, -1.4), angle = Angle(0, 270, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Plane02", rel = "", pos = Vector(2, 0.05, 2.9), angle = Angle(180, 270, 180), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Plane02", rel = "", pos = Vector(1, 0.065, 2.7), angle = Angle(180, 270, 180), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Plane02", pos = Vector(-5.432, 0.54, -2.7), angle = Angle(0, 90, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Plane02", pos = Vector(-4.039, 0.3, -1.5), angle = Angle(0, 90, 0), size = Vector(0.75, 0.75, 0.75)},
	}
	
	SWEP.ForeGripHoldPos = {
	["Left_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(1.11, -38.889, 27.777) },
	["Left_L_Arm"] = { scale = Vector(1, 1, 1), pos = Vector(-1.4, 0.185, -1.668), angle = Angle(-30.223, 1.11, 61.111) }
	}
	
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end
SWEP.LuaViewmodelRecoil = true

--SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -50},  atts = {"md_kobra", "md_eotech", "md_aimpoint"}},
--	[2] = {header = "Barrel", offset = {-175, -100}, atts = {"md_pbs1"}},
--	[3] = {header = "Handguard", offset = {-100, 200}, atts = {"md_foregrip"}}}

SWEP.BarrelBGs = {main = 2, rpk = 1, short = 4, regular = 0}
SWEP.StockBGs = {main = 1, regular = 0, heavy = 1, foldable = 2}
SWEP.ReceiverBGs = {main = 3, rpk = 1, regular = 0}
SWEP.MagBGs = {main = 4, regular = 0, rpk = 1}

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500},  atts = {"md_kobra", "md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex", "md_schmidt_shortdot", "md_pso1", "md_acog"}},
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_pbs1"}},
	[3] = {header = "Handguard", offset = {-300, 0}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"fire1", "fire2", "fire3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {	draw = {[1] = {time = 0.1, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = 0.65, sound = "CW_AK74_MAGOUT"},
	[2] = {time = 1.1, sound = "CW_AK74_MAGIN"},
	[3] = {time = 2, sound = "CW_AK74_BOLTPULL"}}}

SWEP.SpeedDec = 30

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

SWEP.WearDamage = 0.1
SWEP.WearEffect = 0.05

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_rif_aek97.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_aek97.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/w_rif_aek97.mdl"
SWEP.WMPos = Vector(0, 0, 0)
SWEP.WMAng = Vector(-10, 0, 180)
	
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.45x39MM"

SWEP.FireDelay = 0.0923076923
SWEP.FireSound = "CW_AEK971_FIRE"
SWEP.FireSoundSuppressed = "CW_AK74_FIRE_SUPPRESSED"
SWEP.Recoil = 1.7

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 70
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 0.7
SWEP.ReloadTime = 1.5
SWEP.ReloadTime_Empty = 1.5
SWEP.ReloadHalt = 1.65
SWEP.ReloadHalt_Empty = 2.6
SWEP.SnapToIdlePostReload = true