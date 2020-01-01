AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "SV-98"
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
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.ShellDelay = 0.8
	SWEP.FireMoveMod = 0.6
	
	SWEP.IronsightPos = Vector(-2.775, -1.701, 1.299)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.775, -1.701, 0.35)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-2.775, -1.701, 0.85)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-2.775, -1.701, 0.899)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-2.775, -1.701, 1.05)
	SWEP.ReflexAng = Vector(-1, 0, 0)
	
	SWEP.CmorePos = Vector(-2.775, -1.701, 0.92)
	SWEP.CmoreAng = Vector(-1, 0, 0)
	
	SWEP.ShortDotPos = Vector(-2.775, -1.701, 0.879)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.776, -2.701, 0.705)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.NXSPos = Vector(-2.775, -1.701, 0.75)
	SWEP.NXSAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(2.756, 0.236, 0.236)
	SWEP.SprintAng = Vector(-14.606, 52.638, 0.275)
	
	SWEP.CustomizePos = Vector(8.174, -1.27, -4.288)
	SWEP.CustomizeAng = Vector(17.954, 40.578, 0.357)
	
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.SightWithRail = true

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Body", rel = "", pos = Vector(-0.15, -5, -1.9), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), adjustment = {min = 4.7, max = 7.7, axis = "y", inverse = true, inverseOffsetCalc = true}},
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Body", rel = "", pos = Vector(0, 10, -1.4), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Body", rel = "", pos = Vector(0.29, -12, -9.2), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), adjustment = {min = -1, max = 2, axis = "y", inverse = true, inverseOffsetCalc = true}},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Body", rel = "", pos = Vector(0.008, -1, 1.62), angle = Angle(0, -180, 0), size = Vector(0.25, 0.25, 0.25), adjustment = {min = 9.9, max = 14.03, axis = "y", inverse = true, inverseOffsetCalc = true}},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Body", pos = Vector(-0.405, -3.5, -3.3), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "Body", pos = Vector(-0.2, -5.5, -1.6), angle = Angle(0, -90, 0), size = Vector(0.55, 0.55, 0.55)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "Body", pos = Vector(-0.07, -1.5, 2.32), angle = Angle(0, -90, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Body", rel = "", pos = Vector(0, 0, 1.65), angle = Angle(0, 0, 0), size = Vector(0.45, 0.45, 0.45), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Body", rel = "", pos = Vector(0, -1.5, 1.5), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0)},
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "Body", pos = Vector(-0.17, -2, 0.5), angle = Angle(180, 90, 180), size = Vector(0.55, 0.718, 0.55)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Body", pos = Vector(-0.2, -5.03, -1.6), angle = Angle(0, 0, 0), size = Vector(0.55, 0.55, 0.55)},
	}	
	
	SWEP.ForeGripHoldPos = {
		["l-forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-2.779, 2.407, -0.601), angle = Angle(-16.667, -40.445, 107.777) }
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 179.5, 0) 
	
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

	SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore", "md_schmidt_shortdot", "md_nightforce_nxs", "md_acog"}},
		[2] = {header = "Barrel", offset = {-250, -300},  atts = {"md_saker"}},
		[3] = {header = "Handguard", offset = {-300, 0}, atts = {"md_foregrip"}},
		["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_zoneloaded", "am_matchgrade"}}
	}

	
SWEP.Animations = {fire = {"fire"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {
	reload = {
	[1] = {time = 0.85, sound = "CW_SV98_MAGOUT"},
	[2] = {time = 2, sound = "CW_SV98_MAGIN"},
	[3] = {time = 2.1, sound = "CW_SV98_MAGTAP"},
	[4] = {time = 2.75, sound = "CW_SV98_BOLTBACK"},
	[5] = {time = 2.85, sound = "CW_SV98_BOLTIN"},
	[6] = {time = 2.95, sound = "CW_SV98_BOLTLOCK"}},
	
	fire = {
	[1] = {time = 0.3, sound = "CW_SV98_BOLTBACK"},
	[2] = {time = 0.4, sound = "CW_SV98_BOLTIN"}}}
	

SWEP.SpeedDec = 50

SWEP.ADSFireAnim = true
SWEP.BipodFireAnim = true
SWEP.AimBreathingIntensity = 1
SWEP.AimBreathingEnabled = true

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "some faggot & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_sv98_scopeless.mdl"
SWEP.WorldModel		= "models/weapons/w_sv98_scopeless.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/w_sv98_scopeless.mdl"
SWEP.WMPos = Vector(1, -16, 0.5)
SWEP.WMAng = Vector(-10,180,180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x54mmR"

SWEP.FireDelay = 1
SWEP.FireSound = "CW_SV98_FIRE"
SWEP.FireSoundSuppressed = "CW_SV98_SUB"
SWEP.Recoil = 6
SWEP.AimViewModelFOV = 55
SWEP.CustomizationMenuScale = 0.02
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.GlobalDelayOnShoot = 1.1

SWEP.HealthDamage = 0.1
SWEP.HealthEffect = 0.05

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 120
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.4
SWEP.ReloadTime_Empty = 2.4
SWEP.ReloadHalt = 2.5
SWEP.ReloadHalt_Empty = 3
SWEP.Chamberable = true
SWEP.SnapToIdlePostReload = true