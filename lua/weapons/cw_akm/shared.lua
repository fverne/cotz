AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AKM"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IronsightPos = Vector(3.519, 0, 2.009)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(3.53, 0, 0.7)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(3.54, -3, 0.78)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.KobraPos = Vector(3.52, 0, 1.3)
	SWEP.KobraAng = Vector(0, 0, 0)

	SWEP.CmorePos = Vector(3.53, 1.5, 0.905)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.PSOPos = Vector(3.35, 3.107, 1.32)
	SWEP.PSOAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(3.53, 1.5, 0.905)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(3.53, 1.5, 1.15)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(6, -15, 0)

	SWEP.SprintPos = Vector(-3.87, -2.613, 0.519)
	SWEP.SprintAng = Vector(-7.739, -35.88, 0)
	
	SWEP.ShortDotPos = Vector(3.5, -4.107, 0.93)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(3.54, -2.107, 0.68)
	SWEP.ACOGAng = Vector(0, 0, 0)
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
	SWEP.BoltShootOffset = Vector(0, -3, 0)
	SWEP.OffsetBoltOnBipodShoot = true
	
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
//	SWEP.SchmidtShortDotAxisAlign = {right = -0.2, up = -18.9, forward = 0}

	SWEP.AttachmentModelsVM = {
		["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "Rec", pos = Vector(0.2, -0.245, -0.5), angle = Angle(180, 0, 0), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Rec", pos = Vector(-0.05, 0, -2.5), angle = Angle(180, 180, 0), adjustment = {min = -1.3, max = 0.5, inverseOffsetCalc = true, axis = "y"}, size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Rec", pos = Vector(-0.3, -10.420, 8.5), angle = Angle(-180, 90, 0), size = Vector(1, 1, 1)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "Rec", pos = Vector(0, 21, -1.201), angle = Angle(0, 180, 0), size = Vector(0.82, 0.82, 0.82)},
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "Rec", pos = Vector(-0.5, 0, 1.7), angle = Angle(180, 180, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Rec", pos = Vector(0.23, -6.5, 3.3), angle = Angle(180, 0, 0), size = Vector(1, 1, 1)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "Rec", pos = Vector(0.23, -5.302, 2.2), angle = Angle(180, 90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_pso1"] = {model = "models/cw2/attachments/pso.mdl", bone = "Rec", pos = Vector(-0.1, -5.174, 1.4), angle = Angle(180, 180, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Rec", rel = "", pos = Vector(-0.03, 1, -2.5), angle = Angle(0, 180, 180), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Rec", rel = "", pos = Vector(-0.03, 0, -2.3), angle = Angle(0, 180, 180), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Rec", pos = Vector(0.4, -4.433, 2.721), angle = Angle(180, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Rec", pos = Vector(0.27, -5.302, 2.2), angle = Angle(180, 0, 0), size = Vector(0.8, 0.8, 0.8)},
	}
	
	SWEP.ForeGripHoldPos = {
		["left_underarm(mirrored)"] = { scale = Vector(1, 1, 1), pos = Vector(1.667, -0.926, 0), angle = Angle(0, 0, -50) },
		["right_thumb_base"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(34.444, -3.333, 12.222) },
		["right_index_base"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(36.666, -27.778, -27.778) },
		["right_thumb_mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-41.112, -45.556, -85.556) },
		["right_pinky_mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(65.555, -1.111, -12.223) },
		["right_middle_base"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(27.777, -10, -32.223) },
		["neuer bone(mirrored)"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -25.556) },
		["right_ring_base"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(27.777, 0, -25.556) },
		["right_pinky_base"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-10, -10, -23.334) }
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
	
SWEP.Sounds = {	draw = {[1] = {time = 0.1, sound = "CW_FOLEY_MEDIUM"},
	[2] = {time = 0.3, sound = "CW_AK74_BOLTPULL"}},

	reload = {[1] = {time = 0.85, sound = "CW_AK74_MAGOUT"},
	[2] = {time = 1.13, sound = "CW_AK74_MAGIN"},
	[3] = {time = 1.9, sound = "CW_AK74_BOLTPULL"}}}

SWEP.SpeedDec = 20

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
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_rif_ak74.mdl"
SWEP.WorldModel		= "models/weapons/w_ops_ak47.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/w_ops_ak47.mdl"
SWEP.WMPos = Vector(-1, 4, -1)
SWEP.WMAng = Vector(-10,0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x39MM"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_AK74_FIRE"
SWEP.FireSoundSuppressed = "CW_AK74_FIRE_SUPPRESSED"
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.13
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 8
SWEP.MaxSpreadInc = 0.11
SWEP.SpreadPerShot = 0.012
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 83
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 0.7
SWEP.ReloadTime = 1.5
SWEP.ReloadTime_Empty = 1.5
SWEP.ReloadHalt = 1.65
SWEP.ReloadHalt_Empty = 2.6
SWEP.SnapToIdlePostReload = true
