AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "SKS"
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
	SWEP.WM = "models/weapons/world/rifles/sks.mdl"
	SWEP.WMAng = Vector(-10, 180, 180)
	SWEP.WMPos = Vector(1, -2, 1)
	
	SWEP.IronsightPos = Vector(-2.11, -2.652, 1.5)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.11, -2.652, -1.2)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.11, -2.652, -1.25)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.KobraPos = Vector(-2.11, -2.652, -0.1)
	SWEP.KobraAng = Vector(0, 0, 0)

	SWEP.CmorePos = Vector(-2.11, -2.652, -1)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.PSOPos = Vector(-2.11, -2.652, 0.12)
	SWEP.PSOAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.11, -2.652, -1)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-2.11, -2.652, -0.75)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-2.11, -2.652, -0.98)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.097, -2.652, -1.12)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.NXSPos = Vector(-2.11, -2.652, -1.04)
	SWEP.NXSAng = Vector(0, 0, 0)
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.SprintPos = Vector(2, -4, 0.119)
	SWEP.SprintAng = Vector(-10.628, 25.478, 0)
	
	SWEP.CustomizePos = Vector(2.68, -1.68, 1)
	SWEP.CustomizeAng = Vector(1.299, 5.8, 21.299)
	
	SWEP.SightWithRail = true
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.BoltBone = "Bone09"
	SWEP.BoltShootOffset = Vector(-3, 0, 0)
	SWEP.HoldBoltWhileEmpty = true

	
	SWEP.AttachmentModelsVM = {
		//["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "Dummy01", pos = Vector(-1.5, 0, 1.2), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "Dummy01", pos = Vector(2, -1.4, 0.2), angle = Angle(270, 270, 180), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Dummy01", pos = Vector(3, -3.4, -0.03), angle = Angle(90, 0, 270), adjustment = {min = -1.3, max = 0.5, inverseOffsetCalc = true, axis = "y"}, size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Dummy01", pos = Vector(-8.5, 7.45, -0.3), angle = Angle(180, 180, 90), size = Vector(1, 1, 1)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "Dummy01", pos = Vector(22, -0.7, -0.73), angle = Angle(0, -90, 0), size = Vector(0.62, 0.62, 0.62)},
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "Dummy01", pos = Vector(2, 1.3, -0.46), angle = Angle(90, 90, 180), size = Vector(0.6, 0.6, 0.6)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Dummy01", pos = Vector(-4.5, 2.4, 0.24), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "Dummy01", pos = Vector(-3, 1.3, 0.28), angle = Angle(0, 0, -90), size = Vector(0.8, 0.8, 0.8)},
		["md_pso1"] = {model = "models/cw2/attachments/pso.mdl", bone = "Dummy01", pos = Vector(-1.5, 1.2, 0.113), angle = Angle(90, 90, 180), size = Vector(0.8, 0.8, 0.8)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Dummy01", rel = "", pos = Vector(4, -3.4, -0.005), angle = Angle(-90, 270, 180), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Dummy01", rel = "", pos = Vector(2, -3.2, -0.005), angle = Angle(-90, 270, 180), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Dummy01", pos = Vector(-2, 2, 0.5), angle = Angle(-90, 90, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "Dummy01", pos = Vector(3, -4.3, 0.08), angle = Angle(0, 0, -90), size = Vector(1, 1, 1)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Dummy01", pos = Vector(-3, 1.03, 0.25), angle = Angle(-90, 0, -90), size = Vector(0.75, 0.75, 0.75)},
	}

	SWEP.ForeGripHoldPos = {
	["Left Auricularis Phalanges1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 27.777, 0) },
	["Left Hand"] = { scale = Vector(1, 1, 1), pos = Vector(1, 0, 0), angle = Angle(-36.667, -32.223, 76.666) },
	["Left Polex Phalange2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-7.778, -30, 32.222) },
	["Left Polex Phalange1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-34.445, 25.555, 30) }
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
	["+reload"] = {header = "Ammo", offset = {-450, 100}, atts = {"am_zoneloaded", "am_matchgrade"}}}

SWEP.Animations = {fire = "Fire1",
	reload = "Reload_30",
	reload_empty = "Reload_30_empty",
	idle = "idle_scoped",
	draw = "Draw"}
	
SWEP.Sounds = {Reload_30 = {[1] = {time = 0.7, sound = "CW_SKS_BOLTBACK"},
	[2] = {time = 1.15, sound = "CW_SKS_MAGOUT"},
	[3] = {time = 1.7, sound = "CW_FOLEY_MEDIUM"},
	[4] = {time = 2.5, sound = "CW_SKS_MAGIN"},
	[5] = {time = 2.8, sound = "CW_SKS_BOLTFORWARD"}},
	
	Reload_30_empty = {[1] = {time = 0.9, sound = "CW_SKS_MAGOUT"},
	[2] = {time = 1.7, sound = "CW_FOLEY_MEDIUM"},
	[3] = {time = 2.35, sound = "CW_SKS_MAGIN"},
	[4] = {time = 3.3, sound = "CW_SKS_BOLTBACK"},
	[5] = {time = 3.5, sound = "CW_SKS_BOLTFORWARD"}},
	
	draw = {time = 0.5, sound = "CW_FOLEY_MEDIUM"}
	}
	

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "some faggot & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/view/rifles/sks.mdl"
SWEP.WorldModel		= "models/weapons/world/rifles/sks.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x39MM"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_SAIGA308_FIRE"
SWEP.FireSoundSuppressed = "CW_M14_FIRE_SUPPRESSED"
SWEP.Recoil = 3.6

SWEP.HealthDamage = 0.1
SWEP.HealthEffect = 0.05

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 74
SWEP.DeployTime = 0.6


SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.8
SWEP.ReloadTime_Empty = 3.8
SWEP.ReloadHalt = 4
SWEP.ReloadHalt_Empty = 4

SWEP.SnapToIdlePostReload = true

SWEP.Chamberable = false

function SWEP:IndividualInitialize()
	self:setBodygroup( 4 , 2 )
end