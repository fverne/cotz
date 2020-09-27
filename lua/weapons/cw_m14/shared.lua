AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M14 EBR"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "n"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_cstm_m14.mdl"
	SWEP.WMPos = Vector(0, -0.5, 1)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.IronsightPos = Vector(-2.231, -3.428, 1.207)
	SWEP.IronsightAng = Vector(0, -0.008, 0)
	
	SWEP.NXSPos = Vector(-2.218, -3.388, 0.225)
	SWEP.NXSAng = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.237, -4.617, 0.079)
	SWEP.EoTechAng = Vector(0, -0.008, 0)
	
	SWEP.AimpointPos = Vector(-2.24, -3.856, 0.144)
	SWEP.AimpointAng = Vector(0, -0.008, 0)
	
	SWEP.MicroT1Pos = Vector(-2.241, 0.5, 0.395)
	SWEP.MicroT1Ang = Vector(0, -0.008, 0)
	
	SWEP.ReflexPos = Vector(-2.241, 0.5, 0.595)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(-2.241, 0.5, 0.33)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-2.211, -4.624, 0.221)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-2.227, -4.624, -0.01)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.SightWithRail = true
	SWEP.NXSAlign = {right = 0.35, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0.2, up = 0, forward = 0}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.BoltBone = "M14_Charger"
	SWEP.BoltShootOffset = Vector(-3, 0, 0)
	
	SWEP.M203HoldPos = {
		["Bip01 L Clavicle"] = {pos = Vector(4.461, 0.308, -2.166), angle = Angle(0, 0, 0)}
	}
	
	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "M14_Body", pos = Vector(-0.253, -5.233, -4.358), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), adjustment = {min = -5.233, max = -2.5, axis = "y", inverseOffsetCalc = true}},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "M14_Body", pos = Vector(0.284, -9.179, -10.056), angle = Angle(3.332, -90, 0), size = Vector(1, 1, 1), adjustment = {min = -9.179, max = -6, axis = "y", inverseOffsetCalc = true}},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "M14_Body", pos = Vector(0.01, 0.93, 1.373), angle = Angle(0, 180, 0), size = Vector(0.4, 0.4, 0.4), adjustment = {min = 0.93, max = 4, axis = "y", inverseOffsetCalc = true}},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "M14_Body", pos = Vector(0.039, 1.595, -1.653), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "M14_Body", pos = Vector(-0.173, 6.684, 1.22), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "M14_Body", pos = Vector(-0.419, -5.74, -3.297), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "M14_Body", pos = Vector(-0.322, -3.846, -3.984), angle = Angle(0, -90, 0), size = Vector(0.93, 0.93, 0.93)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "M14_Body", pos = Vector(-0.071, 2.74, 2.388), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "M14_Body", rel = "", pos = Vector(-0.03, 3, 1.4), angle = Angle(0, 0, 0), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "M14_Body", rel = "", pos = Vector(0, 2, 1.25), angle = Angle(0, 0, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "M14_Body", pos = Vector(-0.322, -2.846, -3.85), angle = Angle(0, 0, 0), size = Vector(0.9, 0.9, 0.9)},
	}
	
	SWEP.ForeGripHoldPos = {
		["Bip01 L Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 22.09, 27) },
		["Bip01 L Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -10.636, 22.09) },
		["Bip01 L Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 115.363, 0) },
		["Bip01 L Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 15.545, 0) },
		["Bip01 L Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 58.09, 43.363) },
		["Bip01 L Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 99, 0) },
		["Bip01 L Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 27, 22.09) },
		["Bip01 L Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 67.908) },
		["Bip01 L Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 76.091, 0) },
		["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.954, -1.318), angle = Angle(0, 0, 0) },
		["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(17.181, 20.454, -25.365) },
		["Bip01 L Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 9, 0) },
		["Bip01 L Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 7.363, 0) },
		["Bip01 L Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 13.909, 0) },
		["Bip01 L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-25.365, -12.273, 84.273) }
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.RailBGs = {main = 3, on = 1, off = 0}
SWEP.BipodBGs = {main = 4, on = 1, off = 0}
SWEP.SightBGs = {main = 2, sg1 = 1, none = 0}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore", "md_schmidt_shortdot", "md_nightforce_nxs", "md_acog"}},
	[2] = {header = "Barrel", offset = {-450, -300},  atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-300, 0}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {-450, 100}, atts = {"am_zoneloaded", "am_matchgrade"}}}

SWEP.Animations = {fire = {"M14_Fire1", "M14_Fire2"},
	reload = "M14_Reload",
	idle = "idle",
	draw = "M14_Deploy"}
	
SWEP.Sounds = {M14_Reload = {{time = 0.6, sound = "CW_FOLEY_LIGHT"},
	{time = 0.8, sound = "CW_M14_MAGOUT"},
	{time = 1.4, sound = "CW_FOLEY_LIGHT"},
	{time = 2.1, sound = "CW_M14_MAGIN"},
	{time = 2.7, sound = "CW_FOLEY_LIGHT"},
	{time = 3.15, sound = "CW_M14_BOLT"}},
	
	M14_Deploy = {{time = 0, sound = "CW_FOLEY_MEDIUM"},
	{time = 0.7, sound = "CW_M14_BOLT"}}}

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
SWEP.ViewModel		= "models/cw2/rifles/m14.mdl"
SWEP.WorldModel		= "models/weapons/w_cstm_m14.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.WearDamage = 0.1
SWEP.WearEffect = 0.05

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_M14_FIRE"
SWEP.FireSoundSuppressed = "CW_M14_FIRE_SUPPRESSED"
SWEP.Recoil = 2.2

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.07
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 102
SWEP.DeployTime = 1.7

SWEP.RecoilToSpread = 0.8 -- the M14 in particular will have 30% more recoil from continuous fire to give a feeling of "oh fuck I should stop firing 7.62x51MM in full auto at 750 RPM"

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.5
SWEP.ReloadTime_Empty = 3.3
SWEP.ReloadHalt = 3.05
SWEP.ReloadHalt_Empty = 4.85

SWEP.SnapToIdlePostReload = true