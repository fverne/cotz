AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Barret M98b"
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
	
	SWEP.IronsightPos = Vector(-2.61, 0, 0.2)
	SWEP.IronsightAng = Vector(0.25, 0.025, 0)

	SWEP.FrontRearPos = Vector(-2.61, 0, 0.2)
	SWEP.FrontRearAng = Vector(0.25, 0.025, 0)

	SWEP.EoTechPos = Vector(-2.62, -5, 0.6)
	SWEP.EoTechAng = Vector(0.25, 0.025, 0)
	
	SWEP.AimpointPos = Vector(-2.62, -3, 0.5)
	SWEP.AimpointAng = Vector(0.25, 0.025, 0)

	SWEP.MicroT1Pos = Vector(-2.62, -1, 0.5)
	SWEP.MicroT1Ang = Vector(0.25, 0.025, 0)
	
	SWEP.ReflexPos = Vector(-2.62, -1, 0.55)
	SWEP.ReflexAng = Vector(0.25, 0.025, 0)
		
	SWEP.CmorePos = Vector(-2.62, -1, 0.35)
	SWEP.CmoreAng = Vector(0.25, 0.025, 0)

	SWEP.SprintPos = Vector(3.029, -0.805, -2.201)
	SWEP.SprintAng = Vector(-4.926, 38.693, -18.292)

	SWEP.ShortDotPos = Vector(-2.61, -3, 0.5)
	SWEP.ShortDotAng = Vector(0.25, 0.025, 0)
	SWEP.SchmidtShortDotAxisAlign = {right = 0.25, up = 0.025, forward = 0}
	
	SWEP.ACOGPos = Vector(-2.62, -3, 0.25)
	SWEP.ACOGAng = Vector(0.25, 0.025, 0)
	SWEP.ACOGAxisAlign = {right = 0.25, up = 0.025, forward = 0}

	SWEP.NXSPos = Vector(-2.62, -0.5, 0.4)
	SWEP.NXSAng = Vector(0, 0, 0)
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}

	SWEP.CustomizePos = Vector(5.519, 0, -1.601)
	SWEP.CustomizeAng = Vector(21.106, 25.326, 10.553)
	SWEP.SightWithRail = false


	//SWEP.DisableSprintViewSimulation = true

	SWEP.AttachmentModelsVM = {
		["md_rearsight"] = { type = "Model", model = "models/weapons/upgrades/a_standard_barret_m98b.mdl", bone = "A_Optic", pos = Vector(-2.64, 1.40, -11.6), angle = Angle(90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "A_Optic", pos = Vector(0.275, -4.5, -6), angle = Angle(90, 0, 90), size = Vector(0.8, 0.8, 0.8)},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "A_Optic", pos = Vector(0.21, -4.55, -6), angle = Angle(180, 0, 90), size = Vector(0.8, 0.8, 0.8)},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "A_Optic", pos = Vector(-0.19, -7.5, -9.5), angle = Angle(90, 0, 90), size = Vector(0.699, 0.699, 0.699)},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "A_Optic", pos = Vector(-0.021, 0.15, -2), angle = Angle(0, 0, 90), size = Vector(0.4, 0.4, 0.4)},
		["md_rail"] = { type = "Model", model = "models/attachments/mosin/a_modkit_mosin.mdl", bone = "A_Optic", pos = Vector(0, 10, 0.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "A_Muzzle", pos = Vector(-30, 3.775, 0), angle = Angle(-90, 90, 0), size = Vector(1.25, 1.25, 1.25)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "A_Optic", pos = Vector(0.01, 0.2, 1), angle = Angle(180, 0, 90), size = Vector(0.649, 0.649, 0.649)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "A_Optic", pos = Vector(-0.01, 0, -2), angle = Angle(180, 0, 90), size = Vector(0.7, 0.7, 0.7)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "A_Optic", pos = Vector(0.07, 1.1, -2), angle = Angle(90, 0, 90), size = Vector(1, 1, 1)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "A_Optic", pos = Vector(0.29, -4.5, -7), angle = Angle(180, 0, 90), size = Vector(0.8, 0.8, 0.8)},
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
	fire = {"base_fire"}, //base_fire_start
	reload= "base_reload",
	reload_empty = "base_reloadempty",
	idle = "base_idle", //base_idle
	draw = "base_idle",
	bolt = "base_fire_cock"}
	
SWEP.Sounds = {
	
	base_reload = {[1] = {time = 0.95, sound = "CW_M98B_MAGOUT"},
	[2] = {time = 1.3, sound = "CW_FOLEY_MEDIUM"},
	[3] = {time = 2.2, sound = "CW_M98B_MAGIN"}},

	base_reloadempty = {[1] = {time = 0.95, sound = "CW_M98B_MAGOUT"},
	[2] = {time = 1.3, sound = "CW_FOLEY_MEDIUM"},
	[3] = {time = 2.2, sound = "CW_M98B_MAGIN"},
	[4] = {time = 3.5, sound = "CW_RMSR_BOLTUP"},
	[5] = {time = 3.6, sound = "CW_RMSR_BOLTBACK"},
	[6] = {time = 3.9, sound = "CW_RMSR_BOLTFORWARD"},
	[7] = {time = 4.0, sound = "CW_RMSR_BOLTDOWN"}
	},

	base_fire_cock = {
	[1] = {time = 0.2, sound = "CW_RMSR_BOLTUP"},
	[2] = {time = 0.3, sound = "CW_RMSR_BOLTBACK"},
	[3] = {time = 0.6, sound = "CW_RMSR_BOLTFORWARD"},
	[4] = {time = 0.7, sound = "CW_RMSR_BOLTDOWN"}}}
	

SWEP.SpeedDec = 15

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
SWEP.ViewModel		= "models/weapons/c_ins2_warface_barret_m98b.mdl"
SWEP.WorldModel		= "models/weapons/w_ins2_warface_barret_m98b.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/w_ins2_warface_barret_m98b.mdl"
SWEP.WMPos = Vector(-1, 3.5, 0)
SWEP.WMAng = Vector(-9,1,180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".338 Lapua"

SWEP.FireDelay = 1.6
SWEP.FireSound = "CW_M98B_FIRE"
SWEP.FireSoundSuppressed = "CW_M98B_SUB"
SWEP.Recoil = 7.2
SWEP.AimViewModelFOV = 50
SWEP.CustomizationMenuScale = 0.018
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.GlobalDelayOnShoot = 1.5

SWEP.HipSpread = 0.08
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 18
SWEP.MaxSpreadInc = 0.9
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 450
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.7
SWEP.ReloadTime_Empty = 4.0
SWEP.ReloadHalt = 3.0
SWEP.ReloadHalt_Empty = 4.5

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
		timer.Simple(0.6, function() 
			self:sendWeaponAnim("bolt", 0.7, 0)
		end)
	end
end