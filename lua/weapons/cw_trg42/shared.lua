AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Sako TRG-42"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.Add("cw_trg42", "vgui/kills/cw_trg42", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/kills/cw_trg42")
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -4, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.ShellDelay = 0.7
	SWEP.FireMoveMod = 0.6
	
	SWEP.IronsightPos = Vector(3.5, -5, 1.6)
	SWEP.IronsightAng = Vector(0, 0.5, 0)


	SWEP.EoTechPos = Vector(3.519, 0, 1.12)
	SWEP.EoTechAng = Vector(0, 0.55, 0)

	SWEP.AimpointPos = Vector(3.599, 0, 1.2)
	SWEP.AimpointAng = Vector(0, 0.649, 0)

	SWEP.MicroT1Pos = Vector(3.58, 0, 1.6)
	SWEP.MicroT1Ang = Vector(-1, 0.6, 0)
	
	SWEP.ReflexPos = Vector(3.58, 0, 1.45)
	SWEP.ReflexAng = Vector(0, 0.6, 0)
	
	SWEP.CmorePos = Vector(3.62, 0, 1.2)
	SWEP.CmoreAng = Vector(0, 0.6, 0)
	
	SWEP.ShortDotPos = Vector(3.51, -3, 1.395)
	SWEP.ShortDotAng = Vector(0, 0.6, 0)
	
	SWEP.ACOGPos = Vector(3.52, -3, 1.1)
	SWEP.ACOGAng = Vector(0, 0.6, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.NXSPos = Vector(3.6, 0, 1.15)
	SWEP.NXSAng = Vector(0, 0.6, 0)
	
	SWEP.SprintPos = Vector(-4.444, -1, 0.082)
	SWEP.SprintAng = Vector(-12.849, -39.23, 0)
	
	SWEP.CustomizePos = Vector(-8.174, -1.27, -1.288)
	SWEP.CustomizeAng = Vector(17.954, -40.578, -18.357)
	
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.SightWithRail = false

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Body", rel = "", pos = Vector(-3.451, 5.714, -7.6), angle = Angle(0, 0, 0), size = Vector(0.898, 0.898, 0.898), adjustment = {min = 4.7, max = 7.7, axis = "y", inverse = true, inverseOffsetCalc = true}},
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Body", rel = "", pos = Vector(-2.95, 23.5, -4.901), angle = Angle(0, 0, 1), size = Vector(0.75, 0.75, 0.75)},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Body", rel = "", pos = Vector(-2.9, 0.518, -13.301), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), adjustment = {min = -1, max = 2, axis = "y", inverse = true, inverseOffsetCalc = true}},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Body", rel = "", pos = Vector(-3.211, 11, -2.401), angle = Angle(0, -180, 0), size = Vector(0.349, 0.349, 0.349), adjustment = {min = 9.9, max = 14.03, axis = "y", inverse = true, inverseOffsetCalc = true}},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Body", pos = Vector(-3.5, 5.74, -7.297), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "Body", pos = Vector(-3.475, 7, -6.47), angle = Angle(0, -90, 0), size = Vector(0.7, 0.7, 0.7)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "Body", pos = Vector(-3.35, 12, -1.4), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Body", rel = "", pos = Vector(-3.25, 13, -2.3), angle = Angle(0, 0, 0), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Body", rel = "", pos = Vector(-3.25, 13, -2.5), angle = Angle(0, 0, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Body", pos = Vector(-3.5, 7, -6.75), angle = Angle(0, 0, 0), size = Vector(0.7, 0.7, 0.7)},
	}	
	
	SWEP.ForeGripHoldPos = {
	["Bone22(mirrored)"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-38.889, -36.667, 96.666) },
	["Bone01(mirrored)"] = { scale = Vector(1, 1, 1), pos = Vector(-3.8, 0, 0), angle = Angle(2, 0, 0) },
	["Bone23(mirrored)"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(1.11, -50, 45.555) }
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 179.5, 0) 
	
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

SWEP.SightBGs		= {main = 2, carryhandle = 0, foldsight = 2, none = 1, foldfold = 3}
SWEP.ForegripBGs	= {main = 3, regular = 0, covered = 1}
SWEP.MagBGs			= {main = 4, regular = 0, round34 = 1, round100 = 2, round100_empty = 3, none = 4, regular_empty = 5, round34_empty = 6}
SWEP.StockBGs		= {main = 5, regular = 0, heavy = 1, none = 2}
SWEP.SilencerBGs	= {main = 6, off = 0, on = 1, long_off = 2, long_on = 3}
SWEP.LuaViewmodelRecoil = false


	SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore", "md_schmidt_shortdot", "md_nightforce_nxs", "md_acog"}},
		[2] = {header = "Barrel", offset = {-250, -300},  atts = {"md_saker"}},
		[3] = {header = "Handguard", offset = {-300, 0}, atts = {"md_foregrip"}},
		["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_zoneloaded", "am_matchgrade"}}
	}

	
SWEP.Animations = {fire = {"shoot"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {
	reload = {
	[1] = {time = 0.5, sound = "CW_TRG_BOLTBACK"},
	[2] = {time = 1, sound = "CW_TRG_MAGOUT"},
	[3] = {time = 1.85, sound = "CW_TRG_MAGIN"},
	[4] = {time = 2.35, sound = "CW_TRG_BOLTIN"}},
	
	shoot = {
	[1] = {time = 0.2, sound = "CW_TRG_BOLTBACK"},
	[2] = {time = 0.20, sound = "CW_TRG_BOLTIN"}}}
	

SWEP.SpeedDec = 50

SWEP.ADSFireAnim = true
SWEP.BipodFireAnim = true
SWEP.AimBreathingIntensity = 1
SWEP.AimBreathingEnabled = true

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "some faggot & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.HealthDamage = 0.1
SWEP.HealthEffect = 0.05

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/tgr/v_spin_scout.mdl"
SWEP.WorldModel		= "models/weapons/tgr/w_spin_scout.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/tgr/w_spin_scout.mdl"
SWEP.WMPos = Vector(-1, -1, -0.2)
SWEP.WMAng = Vector(-3,1,180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".338 Lapua"
SWEP.magType = "srMag"

SWEP.FireDelay = 1
SWEP.FireSound = "CW_TRG_FIRE"
SWEP.FireSoundSuppressed = "CW_TRG_SUB"
SWEP.Recoil = 2.2
SWEP.AimViewModelFOV = 55
SWEP.CustomizationMenuScale = 0.02
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.GlobalDelayOnShoot = 1.1

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 145
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 2
SWEP.ReloadHalt = 0
SWEP.ReloadHalt_Empty = 0
SWEP.Chamberable = false