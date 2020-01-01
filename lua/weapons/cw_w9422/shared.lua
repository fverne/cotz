AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
if CLIENT then
	SWEP.DrawCrosshair = true
	SWEP.PrintName = "Winchester 9422"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"

	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.MuzzleAttachmentName = "muzzle"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 2
	SWEP.ShellPosOffset = {x = 5, y = -200, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.ShellDelay = 0.8
	SWEP.FireMoveMod = 0.6
	
	SWEP.IronsightPos = Vector(-3.221, 0, 1.639)
	SWEP.IronsightAng = Vector(-0.15, 0.02, 0)
	
	SWEP.EoTechPos = Vector(-3.24, -12, 0.22)
	SWEP.EoTechAng = Vector(-0.15, 0.02, 0)
	
	SWEP.AimpointPos = Vector(-3.23, -12, 0.34)
	SWEP.AimpointAng = Vector(-0.15, 0.02, 0)

	SWEP.MicroT1Pos = Vector(-3.24, 0, 0.47)
	SWEP.MicroT1Ang = Vector(-0.15, 0.02, 0)
	
	SWEP.ReflexPos = Vector(-3.22, -12, 0.6)
	SWEP.ReflexAng = Vector(-0.15, 0.02, 0)
		
	SWEP.CmorePos = Vector(-3.21, -12, 0.5)
	SWEP.CmoreAng = Vector(-0.15, 0.02, 0)

	SWEP.ShortDotPos = Vector(-3.22, -17, 0.435)
	SWEP.ShortDotAng = Vector(-0.15, 0.02, 0)
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0.02, forward = 0}

	SWEP.NXSPos = Vector(-3.25, -14, 0.325)
	SWEP.NXSAng = Vector(-0.15, 0.02, 0)
	SWEP.NXSAlign = {right = 0, up = 0.02, forward = 0}

	SWEP.SprintPos = Vector(3.029, -0.805, -2.201)
	SWEP.SprintAng = Vector(-4.926, 38.693, -18.292)

	SWEP.CustomizePos = Vector(5.519, 0, -1.601)
	SWEP.CustomizeAng = Vector(21.106, 25.326, 10.553)
	SWEP.SightWithRail = true


	//SWEP.DisableSprintViewSimulation = true

	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "v_fa_1887", pos = Vector(-41, 0, 0.7), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "v_fa_1887", rel = "", pos = Vector(-2, -0.37, -2.953), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), adjustment = {min = -8.2, max = -3, axis = "z", inverse = false, inverseOffsetCalc = true}},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "v_fa_1887", rel = "", pos = Vector(-1, -0.3, -3.5), angle = Angle(-180, 90, 180), size = Vector(1.1, 1.1, 1.1), adjustment = {min = -9, max = -5, axis = "z", inverse = false, inverseOffsetCalc = true}},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "v_fa_1887", rel = "", pos = Vector(5, 0.3, -10.2), angle = Angle(0, 180, 0), size = Vector(1.2, 1.2, 1.2), adjustment = {min = -15.4, max = -12, axis = "z", inverse = false, inverseOffsetCalc = true}},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "v_fa_1887", rel = "", pos = Vector(-9, 0, 2.9), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), adjustment = {min = -2.8, max = 2.5, axis = "z", inverse = false, inverseOffsetCalc = true}},
		["md_rail"] = { type = "Model", model = "models/attachments/mosin/a_modkit_mosin.mdl", bone = "v_fa_1887", rel = "", pos = Vector(-12, 0, 1), angle = Angle(0, 180, 0), size = Vector(1, 1, 1)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "v_fa_1887", rel = "", pos = Vector(-11, -0.03, 2.95), angle = Angle(0, -90, 0), size = Vector(0.749, 0.749, 0.749), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "v_fa_1887", rel = "", pos = Vector(-9, 0, 2.7), angle = Angle(0, -90, 0), size = Vector(0.749, 0.749, 0.749), color = Color(255, 255, 255, 0)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "v_fa_1887", pos = Vector(-8, -0.15, 4.05), angle = Angle(0, 180, 0), size = Vector(1.25, 1.25, 1.25)},
	}


	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 179.5, 0) 
	
	SWEP.WS_PistolLaserPosAdjust = Vector(0, 0, 0)
	SWEP.WS_PistolLaserAngAdjust = Angle(0, 0, 0) 
end

SWEP.LuaViewmodelRecoil = false

	SWEP.Attachments = {
		[1] = {header = "Sights", offset = {-100, -250},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore", "md_schmidt_shortdot", "md_nightforce_nxs"}},
		[2] = {header = "Barrel", offset = {-500, 150},  atts = {"md_tundra9mm"}},
		["+reload"] = {header = "Ammo", offset = {800, 150}, atts = {"am_zoneloaded", "am_matchgrade"}}
	}

SWEP.Animations = {
	fire = {"fire1"}, //base_fire_start
	reload_start = "reload_start",
	insert = "reload",
	reload_end = "reload_end",
	idle = "idle", //base_idle
	draw = "draw"}
	
SWEP.Sounds = {
	
	reload_start = {[1] = {time = 0.5, sound = "CW_W9422_BOLTBACK"}},
	reload = {[1] = {time = 0.4, sound = "CW_W9422_INSERT"}},
	reload_end = {[1] = {time = 0.3, sound = "CW_W9422_BOLTFORWORD"}},

	fire1 = {
	[1] = {time = 0.6, sound = "CW_W9422_BOLTBACK"},
	[2] = {time = 0.8, sound = "CW_W9422_BOLTFORWORD"}}}
	

SWEP.SpeedDec = 40

SWEP.ADSFireAnim = true
SWEP.BipodFireAnim = true
SWEP.UseHands = true

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

SWEP.HealthDamage = 0.1
SWEP.HealthEffect = 0.05

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/tfa_nmrih/v_fa_win1892.mdl"
SWEP.WorldModel		= "models/weapons/tfa_nmrih/w_fa_win1892.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/tfa_nmrih/w_fa_win1892.mdl"
SWEP.WMPos = Vector(-1, 4, 1.5)
SWEP.WMAng = Vector(-9,1,180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".22LR"

SWEP.FireDelay = 1.45
SWEP.FireSound = "CW_W9422_FIRE"
SWEP.FireSoundSuppressed = "CW_WS_MOSIN_SUB"
SWEP.Recoil = 1.5
SWEP.AimViewModelFOV = 50
SWEP.CustomizationMenuScale = 0.018
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.GlobalDelayOnShoot = 1.1

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 27
SWEP.DeployTime = 1
/*
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.4
SWEP.ReloadTime_Empty = 3.8
SWEP.ReloadHalt = 2.7
SWEP.ReloadHalt_Empty = 4.1
*/
SWEP.ReloadStartTime = 0.6
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.ShotgunReload = true

SWEP.Chamberable = false