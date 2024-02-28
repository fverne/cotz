AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "FN FAL"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	
	SWEP.FireMoveMod = 0.6
	
	SWEP.BoltBone = "FAL_Charginghandle"
	SWEP.BoltShootOffset = Vector( 0, 3, 0)
	
	SWEP.IronsightPos = Vector(-2.55, 0, 1.399)
	SWEP.IronsightAng = Vector(0.4, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.56, 0, 0.9)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.56, 0, 0.89)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.57, 4, 0.89)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-2.55, 4, 1.1)
	SWEP.ReflexAng = Vector(0, 0, 0)

	SWEP.CmorePos = Vector(-2.55, 4, 0.85)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.ShortDotPos = Vector(-2.54, -1, 0.88)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.578, -1, 0.73)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.SightWithRail = true
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.BaseArm = "Sporkehzord"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "FAL_Animations_By_Spork", pos = Vector(0, -1, 1.45), angle = Angle(0, 180, 0), adjustment = {min = -1.3, max = 0.5, inverseOffsetCalc = true, axis = "y"}, size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "FAL_Animations_By_Spork", pos = Vector(0.22, -9.7, -7.3), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "FAL_Animations_By_Spork", pos = Vector(-0.22, -5.63, -3.2), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "FAL_Animations_By_Spork", pos = Vector(0, 10, -1.4), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "FAL_Animations_By_Spork", pos = Vector(-0.278, -5.081, -3.2), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_rail"] = {model = "models/attachments/mosin/a_modkit_mosin.mdl", bone = "FAL_Animations_By_Spork", pos = Vector(0, 1.5, 0.2), angle = Angle(0, -90, 0), size = Vector(0.65, 0.65, 0.65)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "FAL_Animations_By_Spork", rel = "", pos = Vector(0, 1, 1.5), angle = Angle(0, 0, 0), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "FAL_Animations_By_Spork", rel = "", pos = Vector(0, -0.5, 1.3), angle = Angle(0, 0, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "FAL_Animations_By_Spork", pos = Vector(-0.3, -2.433, -2.721), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "FAL_Animations_By_Spork", pos = Vector(-0.3, -5, -2.95), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
	}
	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	
	SWEP.ForeGripHoldPos = {
	["Bone02"] = { scale = Vector(1, 1, 1), pos = Vector(-0.186, 2.036, 2.036), angle = Angle(0, 0, 98.888) },
	["Bone21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(12.222, 58.888, 38.888) },
	["Bone20"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(61.111, 0, 0) },
	["Bone03"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(45.555, 45.555, 0) }
	}
	
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {600, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore", "md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", offset = {-250, -300},  atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-300, 0}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {600, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	reload_empty = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload_full = {[1] = {time = 0.6, sound = "CW_G3A3_HANDLE"},
	[2] = {time = 0.9, sound = "CW_G3A3_MAGOUT"},
	[3] = {time = 2.3, sound = "CW_G3A3_MAGIN"}},
	
	reload = {[1] = {time = 0.6, sound = "CW_G3A3_BOLTBACK"},
	[2] = {time = 1.2, sound = "CW_G3A3_HANDLE"},
	[3] = {time = 1.4, sound = "CW_G3A3_MAGOUT"},
	[4] = {time = 1.4, sound = "CW_G3A3_MAGIN"},
	[5] = {time = 2.1, sound = "CW_FOLEY_MEDIUM"},
	[6] = {time = 2.2, sound = "CW_G3A3_BOLTFORWARD"}}}

SWEP.SpeedDec = 50

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
SWEP.ViewModel		= "models/hgn/srp/weapons/v_rif_fnfal.mdl"
SWEP.WorldModel		= "models/hgn/srp/weapons/w_rif_fnfal.mdl"

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/hgn/srp/weapons/w_rif_fnfal.mdl"
	SWEP.WMPos = Vector(0, 0, 0)
	SWEP.WMAng = Vector(-10, 0, 180)
	
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.WearDamage = 0.11
SWEP.WearEffect = 0.015

SWEP.FireDelay = 0.0923076923
SWEP.FireSound = "CW_G3A3_FIRE"
SWEP.FireSoundSuppressed = "CW_G3A3_FIRE_SUPPRESSED"
SWEP.Recoil = 1.5

SWEP.HipSpread = 0.13
SWEP.AimSpread = 0.004
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.014
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 130
SWEP.DeployTime = 0.8

SWEP.RecoilToSpread = 0.8 -- the M14 in particular will have 30% more recoil from continuous fire to give a feeling of "oh fuck I should stop firing 7.62x51MM in full auto at 750 RPM"

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.6
SWEP.ReloadTime_Empty = 1.6
SWEP.ReloadHalt = 1.8
SWEP.ReloadHalt_Empty = 3

SWEP.SnapToIdlePostReload = true