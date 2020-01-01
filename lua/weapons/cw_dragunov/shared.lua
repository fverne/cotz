AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
// SCK Name: svd
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Dragunov SVD"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.Add("cw_dragnov", "vgui/kills/cw_dragnov", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/kills/cw_dragnov")
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	
	SWEP.IronsightPos = Vector(-3.15, -2.01, 1.56)
	SWEP.IronsightAng = Vector(-0.15, 0.05, 0)
	
	SWEP.EoTechPos = Vector(-3.05, 0, 0.839)
	SWEP.EoTechAng = Vector(-1.5, 0, 2)
	
	SWEP.AimpointPos = Vector(-3, 0, 0.6)
	SWEP.AimpointAng = Vector(0, 0.25, 2)
	
	SWEP.MicroT1Pos = Vector(-3.15, 0, 1.32)
	SWEP.MicroT1Ang = Vector(-1.5, 0, 2)

	SWEP.PSOPos = Vector(-3, 0, 0.8)
	SWEP.PSOAng = Vector(0, 0, 2)
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}

	SWEP.KobraPos = Vector(-3.2, 0, 1.459)
	SWEP.KobraAng = Vector(-3 ,0 , 2)
		
	SWEP.ReflexPos = Vector(-3.1, -3.823, 1.4)
	SWEP.ReflexAng = Vector(-3, 0, 4)
		
	SWEP.CmorePos = Vector(-3.25, -3.823, 1.25)
	SWEP.CmoreAng = Vector(-3, 0, 4)

	SWEP.ShortDotPos = Vector(-3.025, -3, 0.96)
	SWEP.ShortDotAng = Vector(0, 0, 2)
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.ACOGPos = Vector(-3.025, -3.388, 0.36)
	SWEP.ACOGAng = Vector(0, 0, 2)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.NXSPos = Vector(-2.98, -3.388, 0.89)
	SWEP.NXSAng = Vector(0, 0, 2)
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}

	SWEP.AlternativePos = Vector(0.319, 1.325, -1.04)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SightWithRail = true
	
	SWEP.BoltBone = "Bolt"
	SWEP.BoltShootOffset = Vector(0, 5, 0)
	SWEP.HoldBoltWhileEmpty = false
	SWEP.DontHoldWhenReloading = true
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "Base", rel = "", pos = Vector(-0.25, -1.558, 0), angle = Angle(0, 3, 1), size = Vector(1, 1, 0.5)},
		["md_kobra"] = { type = "Model", model = "models/cw2/attachments/kobra.mdl", bone = "Base", rel = "", pos = Vector(0.419, 0, -2.401), angle = Angle(0, -178, 0), size = Vector(0.55, 0.55, 0.55)},
		["md_pso1"] = { type = "Model", model = "models/cw2/attachments/pso.mdl", bone = "Base", rel = "", pos = Vector(-0.25, -5, -1.601), angle = Angle(0, -178, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Base", rel = "", pos = Vector(-0.561, -7.792, -4), angle = Angle(0, 3, 0), size = Vector(0.898, 0.898, 0.898)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "Base", pos = Vector(1.5, 26, -1.38), angle = Angle(0, 186, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Base", rel = "", pos = Vector(-0.7, -12.988, -9.7), angle = Angle(0, -85, 0), size = Vector(1, 1, 1)},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Base", rel = "", pos = Vector(-0.051, -1.558, 1), angle = Angle(0, -177, 0), size = Vector(0.349, 0.349, 0.349)},
		["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "Base", rel = "", pos = Vector(0.1, -4, -3.3), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "Base", pos = Vector(-0.5, -6, -3.6), angle = Angle(0, -87, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Base", rel = "", pos = Vector(-0.05, 0, 1.15), angle = Angle(-2, 0, 0), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Base", rel = "", pos = Vector(-0.05, 0, 0.9), angle = Angle(-2, 0, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "Base", pos = Vector(0, 1, 1.97), angle = Angle(0, -88.5, 0), size = Vector(1, 1, 1)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Base", pos = Vector(-0.5, -4.4, -4.75), angle = Angle(0, 3, 0), size = Vector(1, 1, 1)},
	}
	
	SWEP.ForeGripHoldPos = {
		["l-pinky-tip"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(180, 0, 0) },
		["l-ring-mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(72.222, 0, 0) },
		["l-middle-tip"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(90, 0, 0) },
		["l-index-low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(34.444, 0, 0) },
		["l-forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-2, 1.296, -0.556), angle = Angle(-12.223, -21.112, 81.111)}
	}


	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(2.25, 182.5, 0) 
	
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

SWEP.SightBGs		= {main = 2, carryhandle = 0, foldsight = 2, none = 1, foldfold = 3}
SWEP.ForegripBGs	= {main = 3, regular = 0, covered = 1}
SWEP.MagBGs			= {main = 4, regular = 0, round34 = 1, round100 = 2, round100_empty = 3, none = 4, regular_empty = 5, round34_empty = 6}
SWEP.StockBGs		= {main = 5, regular = 0, heavy = 1, none = 2}
SWEP.SilencerBGs	= {main = 6, off = 0, on = 1, long_off = 2, long_on = 3}
SWEP.LuaViewmodelRecoil = true


	SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -300},  atts = {"md_microt1", "md_eotech", "md_kobra", "md_aimpoint", "md_reflex", "md_cmore", "md_schmidt_shortdot", "md_pso1", "md_nightforce_nxs", "md_acog"}},
		[2] = {header = "Barrel", offset = {-250, -300},  atts = {"md_pbs1"}},
		[3] = {header = "Handguard", offset = {-250, 150}, atts = {"md_foregrip"}},
		["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_zoneloaded", "am_matchgrade"}}
	}
	
SWEP.Animations = {fire = {"shoot", "shoot2"},
	reload = "reload",
	idle = "idle1",
	draw = "draw"}
	
SWEP.Sounds = {
	draw = {
	[1] = {time = 0, sound = "CW_SVD_DRAW"}},
	
	reload = {
	[1] = {time = 0.6, sound = "CW_SVD_MAGOUT"},
	[2] = {time = 1.8, sound = "CW_SVD_TAP"},
	[3] = {time = 1.85, sound = "CW_SVD_MAGIN"},
	[4] = {time = 2.35, sound = "CW_SVD_BOLTBACK"}}}

SWEP.SpeedDec = 50

SWEP.BipodFireAnim = true
SWEP.AimBreathingIntensity = 1
SWEP.AimBreathingEnabled = true

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"
SWEP.AimViewModelFOV = 50

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/drag/v_snip_dragn.mdl"
SWEP.WorldModel		= "models/weapons/drag/w_snip_dragn.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.ADSFireAnim = false
SWEP.WM = "models/weapons/drag/w_snip_dragn.mdl"
SWEP.WMPos = Vector(-1, -1, -0.2)
SWEP.WMAng = Vector(-3,1,180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x54mmR"

SWEP.HealthDamage = 0.1
SWEP.HealthEffect = 0.05

SWEP.FireDelay = 0.2
SWEP.FireSound = "CW_SVD_FIRE"
SWEP.FireSoundSuppressed = "CW_AK74_FIRE_SUPPRESSED"
SWEP.Recoil = 2.2

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 120
SWEP.DeployTime = 1

SWEP.RecoilToSpread = 0.8 -- the M14 in particular will have 30% more recoil from continuous fire to give a feeling of "oh fuck I should stop firing 7.62x51MM in full auto at 750 RPM"

SWEP.ReloadSpeed = 1.10
SWEP.ReloadTime = 2.35
SWEP.ReloadTime_Empty = 3.8
SWEP.ReloadHalt = 0.1
SWEP.ReloadHalt_Empty = 0.1
SWEP.SnapToIdlePostReload = true