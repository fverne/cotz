AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AK-12"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IronsightPos = Vector(-3.381, -4.422, 0.72)
	SWEP.IronsightAng = Vector(0, 0.05, 0)
	
	SWEP.AimpointPos = Vector(-3.39, -4.422, 0.21)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-3.4, -4.422, 0.16)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(-3.37, -4.422, 0.36)
	SWEP.CmoreAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-3.35, -4.422, 0.26)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-3.37, -4.422, 0.56)
	SWEP.ReflexAng = Vector(0, 0, 0)
		
	SWEP.ShortDotPos = Vector(-3.375, -4.422, 0.45)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-3.365, -4.422, -0.06)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.AlternativePos = Vector(-0.24, 0, -0.48)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.MuzzleAttachmentName = "muzzle"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.SightWithRail = false
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(-3.6, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true

	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "body", pos = Vector(5, -4.6, 0.2), angle = Angle(90, -90, 0), adjustment = {min = -1.3, max = 0.5, inverseOffsetCalc = true, axis = "y"}, size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "body", pos = Vector(-6, 6.4, 0), adjustment = {min = 9, max = 11.609, axis = "x", inverse = true, inverseDisplay = true}, angle = Angle(0, 0, -90), size = Vector(1, 1, 1)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "body", pos = Vector(-2, 1.35, 0.5), adjustment = {min = 4, max = 6.6, axis = "x", inverse = true}, angle = Angle(270, 180, 90), size = Vector(1, 1, 1)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "body", pos = Vector(24, 0.5, -0.1), angle = Angle(90, 0, -90), size = Vector(0.75, 0.75, 0.75)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "body", pos = Vector(28, -2.55, -1), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "body", pos = Vector(0, 0.25, 0.55), angle = Angle(0, 0, -90), size = Vector(0.8, 0.8, 0.8)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "body", rel = "", pos = Vector(6, -4.5, 0.25), angle = Angle(-90, 90, 0), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "body", rel = "", pos = Vector(4, -4.3, 0.23), angle = Angle(-90, 90, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "body", pos = Vector(0, 1.4, 0.6), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1)},
	}

	SWEP.ForeGripHoldPos = {
	["Left12"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(23.333, 0, 0) },
	["Left11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(56.666, 0, 0) },
	["Left1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(67.777, -3.333, 30) },
	["Left13"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(92.222, 0, 0) },
	["Left7"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(56.666, 0, 0) },
	["Left8"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(72.222, 0, 0) },
	["Left5"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(18.888, 0, 0) },
	["Left14"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(36.666, 0, 0) },
	["Left10"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(76.666, 0, 0) },
	["Left2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-3.333, 72.222, 0) },
	["Dummy02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -3), angle = Angle(-50, 0, 0) },
	["Left4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(76.666, 0, 0) }
}

		
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
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

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex", "md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_pbs1"}},
	[4] = {header = "Handguard", offset = {-300, 0}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"fire1", "fire2", "fire3"},
	reload = "ak47_reload",
	idle = "ak47_idle",
	draw = "ak47_draw"}
	
SWEP.Sounds = {	ak47_draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	ak47_reload = {[1] = {time = 0.33, sound = "CW_AK74_MAGOUT"},
	[2] = {time = 1.13, sound = "CW_AK74_MAGIN"},
	[3] = {time = 1.9, sound = "CW_AK74_BOLTPULL"}}}

SWEP.SpeedDec = 30

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
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_rif_ak12.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_ak12.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/w_rif_ak12.mdl"
SWEP.WMPos = Vector(0, 2, -2)
SWEP.WMAng = Vector(-15, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.WearDamage = 0.11
SWEP.WearEffect = 0.015

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.45x39MM"

SWEP.FireDelay = 0.092307692307692
SWEP.FireSound = "CW_AK74_FIRE"
SWEP.FireSoundSuppressed = "CW_AK74_FIRE_SUPPRESSED"
SWEP.Recoil = 1.2

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 81
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 0.7
SWEP.ReloadTime = 1.5
SWEP.ReloadTime_Empty = 1.5
SWEP.ReloadHalt = 1.65
SWEP.ReloadHalt_Empty = 2.6
SWEP.SnapToIdlePostReload = true