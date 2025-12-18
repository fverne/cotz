AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Gepard PDW"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "l"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.InvertShellEjectAngle = true
	SWEP.Shell = "smallshell"
	SWEP.ShellPosOffset = {x = 2, y = -10, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/tfa_l4d2/w_gepard.mdl"
	SWEP.WMPos = Vector(-1, 3,2)
	SWEP.WMAng = Vector(-5, 0, 180)
	
	SWEP.MicroT1Pos = Vector(-2.9, 0, 0.93)
	SWEP.MicroT1Ang = Vector(0, 0.02, 0)
	
	SWEP.IronsightPos = Vector(-2.9, 0, 1.73)
	SWEP.IronsightAng = Vector(0, 0.1, 0)
	
	SWEP.EoTechPos = Vector(-2.9, -7, 0.9)
	SWEP.EoTechAng = Vector(0, 0.1, 0)
	
	SWEP.AimpointPos = Vector(-2.9, -5, 0.8)
	SWEP.AimpointAng = Vector(0, 0, 0)
		
	SWEP.ReflexPos = Vector(-2.9, -5, 1.07)
	SWEP.ReflexAng = Vector(0, 0.1, 0)
	
	SWEP.CmorePos = Vector(-2.9, -5, 0.79)
	SWEP.CmoreAng = Vector(0, 0.1, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0.273)
	SWEP.SprintAng = Vector(-12.132, 0, 0)

	SWEP.KobraPos = Vector(-3, -5, 0.5)
	SWEP.KobraAng = Vector(0, 0, 0)

	-- SWEP.SightBackUpPos = Vector(-2.9, 0, 1.73)
	-- SWEP.SightBackUpAng = Vector(0, 0.012, 0)

	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)
	
	SWEP.BoltBone = "f_bolt"
	SWEP.BoltShootOffset = Vector(0, -1, 0)
	SWEP.BoltBonePositionRecoverySpeed = 100
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.BoltReloadOffset = Vector(0, 0, 0)
	SWEP.ReloadBoltBonePositionRecoverySpeed = 8
	SWEP.ReloadBoltBonePositionMoveSpeed = 8
	SWEP.StopReloadBoneOffset = 0.57
	SWEP.HoldBoltWhileEmpty = true
	
	SWEP.CustomizationMenuScale = 0.01
	
	SWEP.AttachmentModelsVM = {
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "f_frame", pos = Vector(-0.5, -0.3, 0), angle = Angle(0, 0, 0), size = Vector(0.8, 0.7, 0.8)},
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "f_frame", pos = Vector(-0.25, -6, 2.9), angle = Angle(0, -90, 0), size = Vector(0.6, 1.1, 1)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "f_frame", pos = Vector(0.25, 1, -1), angle = Angle(0, 180, 0), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "f_frame", pos = Vector(0, -6, 4.9), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "f_frame", pos = Vector(-0.25, 5, -6.2), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "f_frame", pos = Vector(0, -12, 2), angle = Angle(0, 0, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "f_frame", pos = Vector(0, 14, -2), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "f_frame", rel = "", pos = Vector(0.03, -7.5, 4.9), angle = Angle(0, 180, 0), size = Vector(0.65, 0.65, 0.65), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "f_frame", rel = "", pos = Vector(0.03, -6, 4.7), angle = Angle(0, 180, 0), size = Vector(0.749, 0.749, 0.749), color = Color(255, 255, 255, 0)},
	}
	

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
end

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_kobra", "md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore"}},
	[2] = {header = "Barrel", offset = {-400, -500},  atts = {"md_tundra9mm"}},
	[3] = {header = "Handguard", offset = {-500, -200}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {-400, 330}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"fire", "fire2", "fire3"},
	reload = "reload",
	idle = "idle",
	draw = "deploy"}
	
SWEP.Sounds = {deploy = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {{time = 0.35, sound = "CW_MAC11_MAGOUT"},
	{time = 0.8, sound = "CW_FOLEY_LIGHT"},
	{time = 1.1, sound = "CW_MAC11_MAGIN"},
	{time = 1.6, sound = "CW_FOLEY_LIGHT"},
	{time = 1.7, sound = "CW_MAC11_BOLTBACK"},
	{time = 2.3, sound = "CW_FOLEY_LIGHT"}}
}

SWEP.SpeedDec =0

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "smg"
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi","auto"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/tfa_l4d2/c_gepard.mdl"
SWEP.WorldModel		= "models/weapons/tfa_l4d2/w_gepard.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 22
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x21MM"

SWEP.Chamberable = false

SWEP.UseHands = true

SWEP.FireDelay = 0.05
SWEP.FireSound = "CW_GEPPDW_FIRE"
SWEP.FireSoundSuppressed = "CW_MAC11_FIRE_SUPPRESSED"
SWEP.Recoil = 1.4

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 75
SWEP.DeployTime = 0.45

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.0
SWEP.ReloadTime_Empty = 2.0
SWEP.ReloadHalt = 2.3
SWEP.ReloadHalt_Empty = 2.3

SWEP.SnapToIdlePostReload = false
