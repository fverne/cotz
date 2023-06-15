AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
//SCK name: mosin
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MP-18"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.MuzzleAttachmentName = "1"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 1.3
	SWEP.ShellOffsetMul = 2
	SWEP.ShellPosOffset = {x = 5, y = -200, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.ShellDelay = 2.43
	SWEP.FireMoveMod = 0.6
	
	SWEP.IronsightPos = Vector(-4.410, -4, 0.9)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.77, 0, -0.331)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.85, 0, -0.07)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-2.85, 0, -0.04)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-2.83, -7, 0.5)
	SWEP.ReflexAng = Vector(0, 0, 0)
		
	SWEP.CmorePos = Vector(-2.83, -7, 0.1)
	SWEP.CmoreAng = Vector(0, 0, 0)

	//SWEP.SprintPos = Vector(0, 0, 0)
	//SWEP.SprintAng = Vector(0, 0, 0)
	SWEP.SprintPos = Vector(3.029, -0.805, -2.201)
	SWEP.SprintAng = Vector(-4.926, 38.693, -18.292)

	SWEP.ShortDotPos = Vector(-2.81, -7, 0.039)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.ACOGPos = Vector(-2.8055, -9, -0.29)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.PSOPos = Vector(-2.721, -7, 0.079)
	SWEP.PSOAng = Vector(0, 0, 0)
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.NXSPos = Vector(-2.818, -3.388, 0.1)
	SWEP.NXSAng = Vector(0, 0, 0)
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}

	SWEP.CustomizePos = Vector(5.519, 0, -1.601)
	SWEP.CustomizeAng = Vector(21.106, 25.326, 10.553)
	SWEP.SightWithRail = true


	//SWEP.DisableSprintViewSimulation = true

	SWEP.AttachmentModelsVM = {
		["md_pso1"] = { type = "Model", model = "models/cw2/attachments/pso.mdl", bone = "A_Optic", rel = "", pos = Vector(0, -3.25, -2.597), angle = Angle(0, 0, 90), size = Vector(0.8, 0.8, 0.8)},
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "A_Optic", rel = "", pos = Vector(0.349, -5.75, -6.753), angle = Angle(90, 90, 0), size = Vector(1, 1, 1), adjustment = {min = -8.2, max = -3, axis = "z", inverse = false, inverseOffsetCalc = true}},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "A_Optic", rel = "", pos = Vector(0.3, -6.301, -7.792), angle = Angle(-180, 0, 90), size = Vector(1.1, 1.1, 1.1), adjustment = {min = -9, max = -5, axis = "z", inverse = false, inverseOffsetCalc = true}},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "A_Optic", rel = "", pos = Vector(-0.401, -12.851, -14.027), angle = Angle(90, 90, 0), size = Vector(1.2, 1.2, 1.2), adjustment = {min = -15.4, max = -12, axis = "z", inverse = false, inverseOffsetCalc = true}},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0.15, 0), angle = Angle(0, 0, 90), size = Vector(0.5, 0.5, 0.5), adjustment = {min = -2.8, max = 2.5, axis = "z", inverse = false, inverseOffsetCalc = true}},
		["md_rail"] = { type = "Model", model = "models/attachments/mosin/a_modkit_mosin.mdl", bone = "A_Modkit", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "A_Suppressor", pos = Vector(0, -4, -1.3), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 1.15), angle = Angle(0, 180, -90), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0.9), angle = Angle(0, 180, -90), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "A_Optic", pos = Vector(0.1, 1, 0), angle = Angle(90, -90, 180), size = Vector(1, 1, 1)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "A_Optic", pos = Vector(0.349, -5.75, -6.753), angle = Angle(180, 0, 90), size = Vector(1, 1, 1), adjustment = {min = -8.2, max = -3, axis = "z", inverse = false, inverseOffsetCalc = true}},
	}
	
	function SWEP:getMuzzlePosition()
		return self.CW_VM:GetAttachment(self.CW_VM:LookupAttachment(self.MuzzleAttachmentName))
	end


	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 179.5, 0) 
	
	SWEP.WS_PistolLaserPosAdjust = Vector(0, 0, 0)
	SWEP.WS_PistolLaserAngAdjust = Angle(0, 0, 0) 
end

SWEP.SightBGs		= {main = 2, carryhandle = 0, foldsight = 2, none = 1, foldfold = 3}
SWEP.ForegripBGs	= {main = 3, regular = 0, covered = 1}
SWEP.MagBGs			= {main = 4, regular = 0, round34 = 1, round100 = 2, round100_empty = 3, none = 4, regular_empty = 5, round34_empty = 6}
SWEP.StockBGs		= {main = 5, regular = 0, heavy = 1, none = 2}
SWEP.SilencerBGs	= {main = 6, off = 0, on = 1, long_off = 2, long_on = 3}
SWEP.LuaViewmodelRecoil = false

	SWEP.Attachments = {
		--[1] = {header = "Sight", offset = {-500, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore", "md_schmidt_shortdot", "md_pso1", "md_nightforce_nxs", "md_acog"}},
		["+reload"] = {header = "Ammo", offset = {800, 150}, atts = {"am_hollowpoint", "am_armorpiercing"}}
	}

SWEP.Animations = {
	fire = "fire",
	reload = "reload",
	idle = "reload_end", //base_idle
	draw = "base_draw"}
	
SWEP.Sounds = {
	
	reload = {{time = 0.89, sound = "CW_MP18_LOCK"},
				{time = 0.97, sound = "CW_MP18_OPEN"},
				{time = 2.05, sound = "CW_MP18_OUT"},
				{time = 2.3, sound = "CW_FOLEY_LIGHT"},
				{time = 3.41, sound = "CW_MP18_IN"},
				{time = 4.25, sound = "CW_MP18_CLOSE"}},
	}

SWEP.SpeedDec = 15

SWEP.ADSFireAnim = true
SWEP.BipodFireAnim = true

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.WearDamage = 0.1
SWEP.WearEffect = 0.05

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/arc9/darsu_eft/c_mp18.mdl"
SWEP.WorldModel		= "models/weapons/arc9/darsu_eft/w_mp18.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/arc9/darsu_eft/w_mp18.mdl"
	SWEP.WMPos = Vector(-5.5, -10, 6)
	SWEP.WMAng = Vector(-5, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x54MMR"

SWEP.FireDelay = 0.05
SWEP.FireSound = "CW_MP18_FIRE"
SWEP.FireSoundSuppressed = "CW_WS_MOSIN_SUB"
SWEP.Recoil = 2.2
SWEP.AimViewModelFOV = 50
SWEP.CustomizationMenuScale = 0.018

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 9
SWEP.MaxSpreadInc = 0.9
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 1
SWEP.Shots = 1
SWEP.Damage = 200
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 0.90
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 4.5
SWEP.ReloadHalt = 1
SWEP.ReloadHalt_Empty = 5

SWEP.UseHands = true

SWEP.Chamberable = false


function SWEP:IndividualInitialize()
	self:setBodygroup( 1 , 1 )
	self:setBodygroup( 2 , 1 )
	self:setBodygroup( 3 , 1 )
	self:setBodygroup( 5 , 1 )
end
