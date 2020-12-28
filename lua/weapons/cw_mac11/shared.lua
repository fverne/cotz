AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MAC-11"
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
	SWEP.WM = "models/weapons/w_cst_mac11.mdl"
	SWEP.WMPos = Vector(-1, -5, -1.5)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.ShortDotPos = Vector(-2.241, -3.516, -0.267)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.383, 0.5, -0.12)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.IronsightPos = Vector(-2.383, 0, 1.008)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.4, -2.59, -0.475)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.39, -3.929, -0.53)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(-2.4, 1.5, -0.230)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-2.4, -3.823, 0)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0.273)
	SWEP.SprintAng = Vector(-12.132, 0, 0)

	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)

	SWEP.SightWithRail = true
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(-0.64, 0.294, -0.978)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(0, 0, 1.5)
	SWEP.BoltBonePositionRecoverySpeed = 100
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.BoltReloadOffset = Vector(0, 0, -1.65)
	SWEP.ReloadBoltBonePositionRecoverySpeed = 8
	SWEP.ReloadBoltBonePositionMoveSpeed = 8
	SWEP.StopReloadBoneOffset = 0.57
	SWEP.HoldBoltWhileEmpty = true
	
	SWEP.CustomizationMenuScale = 0.01
	
	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "weapon", pos = Vector(0.037, -3.405, -0.942), angle = Angle(180, 0, -90), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 0)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "weapon", pos = Vector(0.282, 8.026, -10.797), angle = Angle(93.333, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "weapon", pos = Vector(0.018, -2.564, 6.34), angle = Angle(0, 0, 90), size = Vector(0.55, 0.55, 0.55)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "weapon", rel = "", pos = Vector(0, -3.4, 1), angle = Angle(0, 0, -90), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "weapon", rel = "", pos = Vector(0, -3.2, -0.55), angle = Angle(0, 0, -90), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "weapon", pos = Vector(-0.25, 2.35, -7), adjustment = {min = 4, max = 6.6, axis = "x", inverse = true}, angle = Angle(0, 0, -90), size = Vector(1, 1, 1)},
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.AttachmentPosDependency = {["md_tundra9mm"] = {["bg_mac11_extended_barrel"] = Vector(0.018, -2.57, 10.371)}}
end

SWEP.BarrelBGs = {main = 2, extended = 1, regular = 0}
SWEP.StockBGs = {main = 1, unfolded = 1, folded = 0}
SWEP.RailBGs = {main = 3, on = 1, off = 0}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex"}},
	[2] = {header = "Barrel", offset = {-400, -500},  atts = {"md_tundra9mm"}},
	["+reload"] = {header = "Ammo", offset = {-400, 330}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"mac10_fire", "mac10_fire2", "mac10_fire3"},
	reload = "mac10_reload",
	reload_rail = "mac10_reload_rail",
	idle = "mac10_idle",
	draw = "mac10_draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	mac10_reload = {{time = 0.35, sound = "CW_MAC11_MAGOUT"},
	{time = 0.8, sound = "CW_FOLEY_LIGHT"},
	{time = 1.37, sound = "CW_MAC11_MAGIN"},
	{time = 1.6, sound = "CW_FOLEY_LIGHT"},
	{time = 2, sound = "CW_MAC11_BOLTBACK"},
	{time = 2.3, sound = "CW_FOLEY_LIGHT"}}
}

SWEP.SpeedDec = 5

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "pistol"
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/smgs/mac11.mdl"
SWEP.WorldModel		= "models/weapons/w_cst_mac11.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 32
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.Chamberable = false -- MAC-11 is an open-bolt weapon

SWEP.WearDamage = 0.1
SWEP.WearEffect = 0.05

SWEP.FireDelay = 0.05
SWEP.FireSound = "CW_MAC11_FIRE"
SWEP.FireSoundSuppressed = "CW_MAC11_FIRE_SUPPRESSED"
SWEP.Recoil = 3.3

SWEP.HipSpread = 0.125
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 5
SWEP.MaxSpreadInc = 0.55
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 44
SWEP.DeployTime = 0.45

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.79
SWEP.ReloadTime_Empty = 2.26
SWEP.ReloadHalt = 2
SWEP.ReloadHalt_Empty = 3

SWEP.SnapToIdlePostReload = true

function SWEP:IndividualInitialize()
	self:setBodygroup( 1 , 1 )
end
