AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AN-94 Akaban"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IronsightPos = Vector(-1.8, -3, 0.7796)
	SWEP.IronsightAng = Vector(-0.85, 0.2, 0)
	
	SWEP.AimpointPos = Vector(-1.57, -2.224, -0.49)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-1.582, -3.224, -0.5)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.KobraPos = Vector(-1.99, -3.224, -0.69)
	SWEP.KobraAng = Vector(0.717, -0.638, 0)

	SWEP.PSOPos = Vector(-1.6, -0.224, -0.8)
	SWEP.PSOAng = Vector(0, 0, 0)

	SWEP.ShortDotPos = Vector(-1.54, -4.224, -0.64)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(-1.582, -0.224, -0.6)
	SWEP.CmoreAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-1.582, -0.224, -0.53)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-1.57, -0.224, -0.45)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.24, 0, -0.48)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-1.54, -4.224, -0.64)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.SightWithRail = true
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.85
	
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(-3, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true

	SWEP.AttachmentModelsVM = {
		["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "body", pos = Vector(0, 1, 1), angle = Angle(0, 0, 0), size = Vector(0.7, 0.7, 0.7)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "body", pos = Vector(0.3, -5, -3.1), angle = Angle(0, 270, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "body", pos = Vector(0.05, -2.45, -0.55), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "body", pos = Vector(-0.1, 21, 2), angle = Angle(0, 0, 180), size = Vector(0.85, 0.85, 0.85)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "body", pos = Vector(0.17, 1, 2.4), angle = Angle(0, 180, 0), adjustment = {min = -1.3, max = 0.5, inverseOffsetCalc = true, axis = "y"}, size = Vector(0.25, 0.25, 0.25)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "body", pos = Vector(-0.6, -4, -2.721), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "body", pos = Vector(0.3, 1, -1.6), angle = Angle(0, 180, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_pso1"] = {model = "models/cw2/attachments/pso.mdl", bone = "body", pos = Vector(0, -0.174, -1.107), angle = Angle(0, 180, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "body", pos = Vector(-0.04, -2.702, -1.1), angle = Angle(0, 270, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "body", rel = "", pos = Vector(0.16, 2, 2.4), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "body", rel = "", pos = Vector(0.16, 1.6, 2.2), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "body", pos = Vector(0, -2, -0.55), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5)},
	}

	
	SWEP.ForeGripHoldPos = {
	["l_ring_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(63.333, 0, 0) },
	["l_middle_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(78.888, 0, 0) },
	["l_thumb_mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 27.777, 5.556) },
	["l_pinky_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(45.555, 0, 0) },
	["l_index_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(107.777, 0, 0) },
	["l_forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-4.334, 14.444, 81.111) },
	["l_thumb_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(23.333, 23.333, 81.111) }

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
	
SWEP.Sounds = {	
	draw = {
	{time = 0, sound = "CW_FOLEY_MEDIUM"}
	},

	reload = {
	[1] = {time = 0.75, sound = "CW_AN94_MAGOUT"},
	[2] = {time = 1.75, sound = "CW_AN94_MAGIN"},
	[3] = {time = 2.65, sound = "CW_AN94_BOLTPULL"}
	}
}

SWEP.SpeedDec = 35

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"2burst", "semi", "auto"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_cstm_an94.mdl"
SWEP.WorldModel		= "models/srp/weapons/w_abakan.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.WearDamage = 0.11
SWEP.WearEffect = 0.015

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.45x39MM"

SWEP.FireDelay = 0.03333333
SWEP.FireSound = "CW_AK74_FIRE"
SWEP.FireSoundSuppressed = "CW_AK74_FIRE_SUPPRESSED"
SWEP.Recoil = 1.1

SWEP.HipSpread = 0.14
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.8
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 75
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.2
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadHalt = 2.3
SWEP.ReloadHalt_Empty = 3.4
SWEP.SnapToIdlePostReload = true

function SWEP:IndividualThink()
	
	if self.FireMode == "2burst" then
		self.FireDelay = 0.03333333
		self.Recoil = 0.8
	else
		self.FireDelay = 0.1
		self.Recoil = 1.6
	end

end