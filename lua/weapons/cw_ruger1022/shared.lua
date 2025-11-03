AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = true
	SWEP.PrintName = "Ruger 10/22"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "n"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.3
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -3, y = 1, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.65
	SWEP.FireMoveMod = 0.6
	
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(10, -10, 0)
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/tfa_nmrih/w_fa_ruger1022.mdl"
	SWEP.WMAng = Vector(-10, 0, 180)
	SWEP.WMPos = Vector(-0.5, 3, 1)
	
	SWEP.IronsightPos = Vector(-3, -7.321, 1.75)
	SWEP.IronsightAng = Vector(0.4, 0.05, 0)
	
	SWEP.AimpointPos = Vector(-3.03, -3, 0.8)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.97, -5, 0.9)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.CmorePos = Vector(-3.01, -5, 1.03)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-3.03, -3, 1)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-2.99, -5, 1.1)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-3.03, -7, 1.03)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.NXSPos = Vector(-3.03, -5, 0.92)
	SWEP.NXSAng = Vector(0, 0, 0)
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.ACOGPos = Vector(-3.011, -7, 0.835)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.SprintPos = Vector(2, -4, 0.119)
	SWEP.SprintAng = Vector(-10.628, 25.478, 0)
	
	SWEP.CustomizePos = Vector(2.68, -1.68, 1)
	SWEP.CustomizeAng = Vector(1.299, 5.8, 21.299)
	
	SWEP.SightWithRail = true
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.BoltBone = "Slide"
	SWEP.BoltShootOffset = Vector(-3, 0, 0)
	SWEP.HoldBoltWhileEmpty = true

	
	SWEP.AttachmentModelsVM = {
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "Ruger 1022", pos = Vector(0.4, -2.4, 3), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Ruger 1022", pos = Vector(0.17, -3.2, 5), angle = Angle(0, 180, 0), adjustment = {min = -1.3, max = 0.5, inverseOffsetCalc = true, axis = "y"}, size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Ruger 1022", pos = Vector(0.45, -14, -6), angle = Angle(0, 270, 0), size = Vector(1, 1, 1)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Ruger 1022", pos = Vector(0.2, 29, 2.7), angle = Angle(0, 180, 0), size = Vector(1, 1, 1)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Ruger 1022", pos = Vector(-0.1, -9.2, -0.8), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "Ruger 1022", pos = Vector(-0.147, -9.2, 0.3), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Ruger 1022", rel = "", pos = Vector(0.17, -2.2, 5.1), angle = Angle(180, 180, 180), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Ruger 1022", rel = "", pos = Vector(0.17, -3.2, 4.8), angle = Angle(180, 180, 180), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "Ruger 1022", pos = Vector(0.05, -4.3, 5.93), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Ruger 1022", pos = Vector(-0.11, -8.2, 0.6), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
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

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex", "md_schmidt_shortdot", "md_nightforce_nxs", "md_acog"}},
	[2] = {header = "Barrel", offset = {-450, -300},  atts = {"md_tundra9mm"}},
	["+reload"] = {header = "Ammo", offset = {-450, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = "Fire",
	reload = "Reload",
	reload_empty = "Reload_Dry",
	idle = "Idle",
	draw = "Draw"}
	
SWEP.Sounds = {Reload = {[1] = {time = 0.6, sound = "CW_R1022_MAGOUT"},
	[2] = {time = 0.8, sound = "CW_FOLEY_MEDIUM"},
	[3] = {time = 1.95, sound = "CW_R1022_MAGIN"}},
	
	Reload_Dry = {[1] = {time = 0.6, sound = "CW_R1022_MAGOUT"},
	[2] = {time = 1, sound = "CW_FOLEY_MEDIUM"},
	[3] = {time = 1.95, sound = "CW_R1022_MAGIN"},
	[4] = {time = 3.3, sound = "CW_R1022_BOLT"},
	[5] = {time = 3.5, sound = "CW_SKS_BOLTFORWARD"}},
	
	draw = {time = 0.5, sound = "CW_FOLEY_MEDIUM"}
	}
	

SWEP.SpeedDec = 5
SWEP.UseHands = true
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
SWEP.ViewModel		= "models/weapons/tfa_nmrih/v_fa_ruger1022.mdl"
SWEP.WorldModel		= "models/weapons/tfa_nmrih/w_fa_ruger1022.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".22LR"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_R1022_FIRE"
SWEP.FireSoundSuppressed = "CW_M14_FIRE_SUPPRESSED"
SWEP.Recoil = 1

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.002
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 35
SWEP.DeployTime = 0.6


SWEP.ReloadSpeed = 1.5
SWEP.ReloadTime = 2.3
SWEP.ReloadTime_Empty = 3.75
SWEP.ReloadHalt = 2.5
SWEP.ReloadHalt_Empty = 3.9

SWEP.SnapToIdlePostReload = true

SWEP.Chamberable = true
