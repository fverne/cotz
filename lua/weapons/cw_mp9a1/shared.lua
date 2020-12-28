AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MP9A1"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "l"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "smallshell"
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_smg_mp9a1.mdl"
	SWEP.WMPos = Vector(0, 11.5, 4)
	SWEP.WMAng = Vector(-10, 0, 180)
	
	SWEP.ShortDotPos = Vector(-2.241, -3.516, -0.267)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(2.55, 0, 0.56)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.IronsightPos = Vector(2.519, 0, 1.48)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(2.55, -1.929, 0.54)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(2.5, -1.504, 0.6)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(2.53, 1.5, 0.65)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(2.53, -1.823, 0.89)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0.273)
	SWEP.SprintAng = Vector(-12.132, 0, 0)

	SWEP.CustomizePos = Vector(-12.121, 4.907, 0.461)
	SWEP.CustomizeAng = Vector(17.232, -58.485, -19.311)

	SWEP.SightWithRail = true
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(-0.64, 0.294, -0.978)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BoltBone = "A_MP9"
	SWEP.BoltShootOffset = Vector(0, 0, 0)
	SWEP.BoltBonePositionRecoverySpeed = 100
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.BoltReloadOffset = Vector(0, 0, 0)
	SWEP.ReloadBoltBonePositionRecoverySpeed = 8
	SWEP.ReloadBoltBonePositionMoveSpeed = 8
	SWEP.StopReloadBoneOffset = 0.57
	SWEP.HoldBoltWhileEmpty = true
	
	SWEP.CustomizationMenuScale = 0.01
	
	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "A_MP9", pos = Vector(-6, 3.3, 0.2), angle = Angle(270, 90, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "A_MP9", pos = Vector(-11, 9, -0.27), angle = Angle(0, 0, -90), size = Vector(1, 1, 1)},	
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "A_MP9", pos = Vector(1.557, -1.9, 0), angle = Angle(90, 270, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "A_MP9", pos = Vector(8, -0.89, -0.7), angle = Angle(0, -90, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "A_MP9", rel = "", pos = Vector(2, -2, 0), angle = Angle(-90, 90, 0), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "A_MP9", rel = "", pos = Vector(0.5, -1.8, 0), angle = Angle(-90, 90, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)}
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.BarrelBGs = {main = 2, extended = 1, regular = 0}
SWEP.StockBGs = {main = 1, unfolded = 1, folded = 0}
SWEP.RailBGs = {main = 3, on = 1, off = 0}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore"}},
	[2] = {header = "Barrel", offset = {-400, -500},  atts = {"md_tundra9mm"}},
	["+reload"] = {header = "Ammo", offset = {-400, 330}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = "fire1",
	reload_empty = "reload",
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {{time = 1, sound = "CW_MAC11_MAGOUT"},
	{time = 1.8, sound = "CW_MAC11_MAGIN"},
	{time = 2.1, sound = "CW_MAC11_BOLTBACK"},
	{time = 2.3, sound = "CW_FOLEY_LIGHT"}}
}

SWEP.SpeedDec = 5

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "smg"
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "crossbow"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_smg_mp9a1.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_mp9a1.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.Chamberable = true

SWEP.FireDelay = 0.05
SWEP.FireSound = "CW_MAC11_FIRE"
SWEP.FireSoundSuppressed = "CW_MAC11_FIRE_SUPPRESSED"
SWEP.Recoil = 1.9

SWEP.WearDamage = 0.1
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 45
SWEP.DeployTime = 0.45

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.26
SWEP.ReloadTime_Empty = 2.26
SWEP.ReloadHalt = 3
SWEP.ReloadHalt_Empty = 3

SWEP.SnapToIdlePostReload = false
