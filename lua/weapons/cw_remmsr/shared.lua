AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Remington MSR"
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
	
	SWEP.IronsightPos = Vector(-3.565, -3, 0.875)
	SWEP.IronsightAng = Vector(0, 0.045, 0)

	SWEP.FrontRearPos = Vector(-3.565, -3, 0.875)
	SWEP.FrontRearAng = Vector(0, 0.045, 0)

	SWEP.EoTechPos = Vector(-3.555, -7, 1.03)
	SWEP.EoTechAng = Vector(-0.7, 0.03, 0)
	
	SWEP.AimpointPos = Vector(-3.565, -4, 0.825)
	SWEP.AimpointAng = Vector(-0.7, 0.03, 0)

	SWEP.MicroT1Pos = Vector(-3.585, -2, 0.985)
	SWEP.MicroT1Ang = Vector(-0.7, 0.03, 0)
	
	SWEP.ReflexPos = Vector(-3.555, -4, 1.07)
	SWEP.ReflexAng = Vector(-0.7, 0.03, 0)
		
	SWEP.CmorePos = Vector(-3.555, -4, 0.825)
	SWEP.CmoreAng = Vector(-0.7, 0.03, 0)

	SWEP.SprintPos = Vector(3.029, -0.805, -2.201)
	SWEP.SprintAng = Vector(-4.926, 38.693, -18.292)

	SWEP.ShortDotPos = Vector(-3.565, -8, 0.75)
	SWEP.ShortDotAng = Vector(-0.7, 0.03, 0)
	SWEP.SchmidtShortDotAxisAlign = {right = 0.7, up = -0.03, forward = 0}
	
	SWEP.ACOGPos = Vector(-3.565, -6, 0.575)
	SWEP.ACOGAng = Vector(-0.7, 0.03, 0)
	SWEP.ACOGAxisAlign = {right = 0.7, up = -0.03, forward = 0}

	SWEP.NXSPos = Vector(-3.565, -6, 0.820)
	SWEP.NXSAng = Vector(-0.7, 0.03, 0)
	SWEP.NXSAlign = {right = 0.7, up = -0.03, forward = 0}

	SWEP.CustomizePos = Vector(5.519, 0, -1.601)
	SWEP.CustomizeAng = Vector(21.106, 25.326, 10.553)
	SWEP.SightWithRail = false


	//SWEP.DisableSprintViewSimulation = true

	SWEP.AttachmentModelsVM = {
		["md_rearsight"] = { type = "Model", model = "models/weapons/upgrades/a_standard_remington_msr.mdl", bone = "A_Optic", pos = Vector(-2.495, 1.8, -8.6), angle = Angle(90, 90, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255)},
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "A_Optic", pos = Vector(0.327, -5.9, -6), angle = Angle(90, 0, 90), size = Vector(1, 1, 1)},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "A_Optic", pos = Vector(0.2, -5.85, -6), angle = Angle(180, 0, 90), size = Vector(1, 1, 1)},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "A_Optic", pos = Vector(-0.26, -7.7, -9.5), angle = Angle(90, 0, 90), size = Vector(0.699, 0.699, 0.699)},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "A_Optic", pos = Vector(-0.051, -0.04, -1), angle = Angle(0, 0, 90), size = Vector(0.4, 0.4, 0.4)},
		["md_rail"] = { type = "Model", model = "models/attachments/mosin/a_modkit_mosin.mdl", bone = "A_Optic", pos = Vector(0, 10, 0.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "A_Muzzle", pos = Vector(-30, 4, 0), angle = Angle(-90, 90, 0), size = Vector(1.25, 1.25, 1.25)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "A_Optic", pos = Vector(-0.051, 0, 1), angle = Angle(180, 0, 90), size = Vector(0.649, 0.649, 0.649)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "A_Optic", pos = Vector(-0.051, -0.25, 1), angle = Angle(180, 0, 90), size = Vector(0.8, 0.8, 0.8)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "A_Optic", pos = Vector(0.05, 0.899, 0), angle = Angle(90, 0, 90), size = Vector(1, 1, 1)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "A_Optic", pos = Vector(0.3, -6, -6), angle = Angle(180, 0, 90), size = Vector(1, 1, 1)},
	}


	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 179.5, 0) 
	
	SWEP.WS_PistolLaserPosAdjust = Vector(0, 0, 0)
	SWEP.WS_PistolLaserAngAdjust = Angle(0, 0, 0) 
end


	SWEP.Attachments = {
		[1] = {header = "Sight", offset = {-500, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore", "md_schmidt_shortdot", "md_nightforce_nxs", "md_acog"}},
		[2] = {header = "Barrel", offset = {-500, 150},  atts = {"md_saker"}},
		[3] = {header = "Hack", offset = {-500, 150},  atts = {"md_rearsight"}},
		["+reload"] = {header = "Ammo", offset = {800, 150}, atts = {"am_hollowpoint", "am_armorpiercing"}}
	}

SWEP.Animations = {
	fire = {"base_fire_start"}, //base_fire_start
	reload= "base_reload",
	reload_empty = "base_reloadempty",
	idle = "base_idle", //base_idle
	draw = "base_idle",
	bolt = "base_fire_end"}
	
SWEP.Sounds = {
	
	base_reload = {[1] = {time = 1.15, sound = "CW_RMSR_MAGOUT"},
	[2] = {time = 1.3, sound = "CW_FOLEY_MEDIUM"},
	[3] = {time = 1.9, sound = "CW_RMSR_MAGIN"}},

	base_reloadempty = {[1] = {time = 0.4, sound = "CW_RMSR_BOLTUP"},
	[2] = {time = 0.55, sound = "CW_RMSR_BOLTBACK"},
	[3] = {time = 0.9, sound = "CW_FOLEY_MEDIUM"},
	[4] = {time = 2.0, sound = "CW_RMSR_MAGOUT"},
	[5] = {time = 2.75, sound = "CW_RMSR_MAGIN"},
	[6] = {time = 3.35, sound = "CW_RMSR_BOLTFORWARD"},
	[7] = {time = 3.5, sound = "CW_RMSR_BOLTDOWN"}
	},

	base_fire_end = {
	[1] = {time = 0.2, sound = "CW_RMSR_BOLTUP"},
	[2] = {time = 0.3, sound = "CW_RMSR_BOLTBACK"},
	[3] = {time = 0.6, sound = "CW_RMSR_BOLTFORWARD"},
	[4] = {time = 0.7, sound = "CW_RMSR_BOLTDOWN"}}}
	

SWEP.SpeedDec = 35

SWEP.ADSFireAnim = true
SWEP.BipodFireAnim = true
SWEP.AimBreathingIntensity = 1
SWEP.AimBreathingEnabled = false
SWEP.UseHands = true

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

SWEP.WearDamage = 0.33
SWEP.WearEffect = 0.005

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/c_ins2_pd2_msr.mdl"
SWEP.WorldModel		= "models/weapons/w_ins2_pd2_msr.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/w_ins2_pd2_msr.mdl"
SWEP.WMPos = Vector(-1, 2, 1)
SWEP.WMAng = Vector(-9,1,180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".338 Lapua"

SWEP.FireDelay = 1.4
SWEP.FireSound = "CW_RMSR_FIRE"
SWEP.FireSoundSuppressed = "CW_RMSR_SUB"
SWEP.Recoil = 7.2
SWEP.AimViewModelFOV = 50
SWEP.CustomizationMenuScale = 0.018
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.GlobalDelayOnShoot = 1.4

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 18
SWEP.MaxSpreadInc = 0.9
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 550
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.8
SWEP.ReloadTime_Empty = 3.1
SWEP.ReloadHalt = 3.1
SWEP.ReloadHalt_Empty = 3.9

SWEP.Chamberable = true

function SWEP:IndividualThink()
	if (SERVER) then
		if not self.ActiveAttachments.md_rearsight and not self:hasAttachmentInCategory(1) then
			self:attachSpecificAttachment("md_rearsight")
		end

		if( self.ActiveAttachments.md_rearsight and self:hasAttachmentInCategory(1)) then
			self:detachSpecificAttachment("md_rearsight")
		end
	end
end

function SWEP:postPrimaryAttack()
	if CLIENT then
		timer.Simple(0.2, function() 
			self:sendWeaponAnim("bolt", 0.8, 0)
		end)
	end
end