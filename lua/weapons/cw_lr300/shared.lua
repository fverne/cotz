AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	util.PrecacheModel("models/weapons/v_lr300.mdl")
	util.PrecacheModel("models/weapons/w_lr300.mdl")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "LR-300"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "w"
	SWEP.SelectIcon = surface.GetTextureID("vgui/lr300_select")
	killicon.Add( "cw_lr300", "vgui/lr300_kill", Color( 255, 255, 255, 255 ) )
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.45
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 1, y = 0, z = 0}
	
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.75
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.75
	
	SWEP.IronsightPos = Vector(-2.033, 0, 0.119)
	SWEP.IronsightAng = Vector(0, -0.02, 0)
	
	SWEP.AimpointPos = Vector(-2.01, -2.613, 0.575)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(-2.01, -2.613, 0.525)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-2.01, -2.613, 0.625)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.02, -2.5, 0.41)
	SWEP.EoTechAng = Vector(0.3, 0, 0)
	
	SWEP.LaserPosAdjust = Vector(0, 2, 0)
	SWEP.LaserAngAdjust = Angle(-.5, -180, 0) 
	
	SWEP.MicroT1Pos = Vector(-2.02, 0, 0.62)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.ShortDotPos = Vector(-2.01, -3, 0.6)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.0065, -3, 0.455)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.SchmidtShortDotAxisAlign = {right = -0, up = 0, forward = 0}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "Honey_Body", pos = Vector(-0.03, 9.2, 43.5), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Honey_Body", rel = "", pos = Vector(-0.172, 6, 43.26), angle = Angle(0, 0, 0), size = Vector(0.65, 0.65, 0.65)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Honey_Body", rel = "", pos = Vector(-0.4, 5.5, 42.7), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Honey_Body", pos = Vector(.01, 8.6, 47.02), angle = Angle(0, 180, 0), size = Vector(0.3, 0.3, 0.3)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "Honey_Body", pos = Vector(0.5, 20.8, 45.7), angle = Angle(0, 90, 90), size = Vector(0.5, 0.5, 0.5)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Honey_Body", rel = "", pos = Vector(.21, 0.9, 38.3), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "Honey_Body", pos = Vector(-.22, 7, 43.52), angle = Angle(0, -90, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Honey_Body", rel = "", pos = Vector(0, 10.6, 46.82), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Honey_Body", rel = "", pos = Vector(-0.01, 12.6, 47.1), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Honey_Body", pos = Vector(-.21, 7, 43.5), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6)},
	}
end

	SWEP.ForeGripHoldPos = {
		["Bip01 L Finger3"] = {pos = Vector(0, 0, 0), angle = Angle(0, 42.713, 0) },
		["Bip01 L Clavicle"] = {pos = Vector(0.8, 1.5, -0.9), angle = Angle(-36.667, -1.111, 5.556) },
		["Bip01 L Forearm"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 42.41) },
		["Bip01 L Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(0, 71.308, 0) },
		["Bip01 L Finger11"] = {pos = Vector(0, 0, 0), angle = Angle(0, 25.795, 0) },
		["Bip01 L Finger4"] = {pos = Vector(0, 0, 0), angle = Angle(0, 26.148, 0) },
		["Bip01 L Finger1"] = {pos = Vector(0, 0, 0), angle = Angle(6.522, 83.597, 0) },
		["Bip01 L Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(23.2, 16.545, 0) },
		["Bip01 L Finger42"] = {pos = Vector(0, 0, 0), angle = Angle(0, 31.427, 0) },
		["Bip01 L Finger32"] = {pos = Vector(0, 0, 0), angle = Angle(0, 29.565, 0) },
		["Bip01 L Hand"] = {pos = Vector(0, 0, 0), angle = Angle(9.491, 14.793, -15.926) },
		["Bip01 L Finger12"] = {pos = Vector(0, 0, 0), angle = Angle(0, 30, 0) },
		["Bip01 L Finger21"] = {pos = Vector(0, 0, 0), angle = Angle(0, 10.164, 0) },
		["Bip01 L Finger01"] = {pos = Vector(0, 0, 0), angle = Angle(0, 18.395, 0) },
		["Bip01 L Finger2"] = {pos = Vector(0, 0, 0), angle = Angle(2.411, 57.007, 0) }
	}

SWEP.SightBGs = {main = 2, none = 1}
SWEP.MagBGs = {main = 3, regular = 0, round60 = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-450, -500}, atts = {"md_saker"}},
	[2] = {header = "Sight", offset = {350, -500}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex", "md_schmidt_shortdot", "md_acog"}},
	[3] = {header = "Rail", offset = {-450, -100}, atts = {"md_anpeq15"}},
	[4] = {header = "Under", offset = {-450, 325}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_LR300_Deploy"}},

	reload = {[1] = {time = 0.20, sound = "CW_LR300_MAGOUT"},
	[2] = {time = 1.6, sound = "CW_LR300_MAGIN"}}}

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
SWEP.ViewModel		= "models/weapons/v_lr300.mdl"
SWEP.WorldModel		= "models/weapons/w_lr300.mdl"

SWEP.Pos = Vector(-1.7, 13, -3.9)
SWEP.Ang = Angle(-3, 180, 0)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.WearDamage = 0.1
SWEP.WearEffect = 0.08

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_LR300_FIRE"
SWEP.FireSoundSuppressed = "CW_LR300_FIRE_SILENCED"
SWEP.Recoil = 1.7

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 75
SWEP.DeployTime = 0.5

SWEP.ReloadSpeed = 1.15
SWEP.ReloadTime = 2.4
SWEP.ReloadTime_Empty = 2.4
SWEP.ReloadHalt = 1.9
SWEP.ReloadHalt_Empty = 3.1
SWEP.SnapToIdlePostReload = true