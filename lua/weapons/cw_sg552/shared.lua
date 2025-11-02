AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "SIG SG 552"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
--	killicon.Add("cyn_cw_fas2_sg550", "cyn/icon/fas2_cw/sg550_kill", Color(255, 80, 0, 150))
--	SWEP.SelectIcon = surface.GetTextureID("cyn/icon/fas2_cw/sg550_select")
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -2}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	
	SWEP.BoltBone = "Bolt"
	SWEP.BoltShootOffset = Vector(0, 0, -3)
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.FOVPerShot = 0.3

	SWEP.IronsightPos = Vector(3.579, 0, 1.759)
	SWEP.IronsightAng = Vector(-2.6, -0.03, -1.3)

	SWEP.EoTechPos = Vector(3.579, -5, 0.659)
	SWEP.EoTechAng = Vector(-2.6, -0.03, -1.3)
	
	SWEP.AimpointPos = Vector(3.579, 0, 0.959)
	SWEP.AimpointAng = Vector(-2.6, -0.03, -1.3)
	
	SWEP.MicroT1Pos = Vector(3.579, 0, 1.059)
	SWEP.MicroT1Ang = Vector(-2.6, -0.03, -1.3)
	
	SWEP.SprintPos = Vector(1.879, 0, 0.959)
	SWEP.SprintAng = Vector(-21.107, -10.954, -6.332)	
	
	SWEP.ShortDotPos = Vector(3.579, -5, 0.659)
	SWEP.ShortDotAng = Vector(-2.6, -0.03, -1.3)
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = -1.3}

	SWEP.ACOGPos = Vector(3.555, -6, 0.573)
	SWEP.ACOGAng = Vector(-2.6, -0.03, -1.3)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = -1.3}
	
	SWEP.ReflexPos = Vector(3.579, 0, 0.959)
	SWEP.ReflexAng = Vector(-2.6, -0.03, -1.3)

	SWEP.CmorePos = Vector(3.579, 0, 0.859)
	SWEP.CmoreAng = Vector(-2.6, -0.03, -1.3)

	SWEP.CustomizePos = Vector(1.879, 0, 0.959)
	SWEP.CustomizeAng = Vector(5.107, -10.954, -6.332)

	SWEP.SightWithRail = false

	SWEP.BaseArm = "L_Arm_Controller"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "receiver", rel = "", pos = Vector(-13.607, 3.299, -5), angle = Angle(90, -90, 0), size = Vector(1.2, 1.2, 1.2)},
		["md_saker"] = { model = "models/cw2/attachments/556suppressor.mdl", bone = "receiver", pos = Vector(-13.16, 0.6, 1), angle = Angle(0, 0, -90), size = Vector(0.75, 0.75, 0.75)},
		["md_eotech"] = { adjustment = {min = -6.743, max = -5.5, axis = "y", inverseOffsetCalc = true}, model = "models/wystan/attachments/2otech557sight.mdl", bone = "receiver", pos = Vector(-12.86, 9.399, -13), angle = Angle(90, 0, -90), size = Vector(1.2, 1.2, 1.2)},
		["md_microt1"] = { adjustment = {min = 0.276, max = 2.5, axis = "y", inverseOffsetCalc = true}, model = "models/cw2/attachments/microt1.mdl", bone = "receiver", pos = Vector(-13.15, -3.721, 0), angle = Angle(180, 0, -90), size = Vector(0.5, 0.5, 0.5)},
		["md_aimpoint"] = {	adjustment = {min = -3.737, max = -2.35, axis = "y", inverseOffsetCalc = true},	model = "models/wystan/attachments/aimpoint.mdl", bone = "receiver", pos = Vector(-13.48, 3.299, -6), angle = Angle(0, 0, -90), size = Vector(1.2, 1.2, 1.2)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "receiver", rel = "", pos = Vector(-13.2, -3.85, 5), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "receiver", rel = "", pos = Vector(-13.18, -3.451, 2), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "receiver", pos = Vector(-13.527, 2.199, -5), angle = Angle(0, 0, -90), size = Vector(1, 1, 1)},
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(-0.1, 180, 3) 
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

SWEP.LuaViewmodelRecoil = true

	SWEP.Attachments = {
		[1] = {header = "Sight", offset = {400, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore","md_schmidt_shortdot", "md_acog"}},
		[3] = {header = "Silencer", offset = {-400, -200},  atts = {"md_saker"}},
		["+reload"] = {header = "Ammo", offset = {800, 150}, atts = {"am_hollowpoint", "am_armorpiercing"}}
	}

	
SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "Reload",
	idle = "Idle",
	draw = "Draw"}
	
SWEP.Sounds = {
	draw = {
	[1] = {time = 0, sound = "CW_WS_M16A4_DRAW"}},
	
	Reload = {
		[1] = {time = 0.64, sound = "CW_SG552_MAGOUT"},
		[2] = {time = 1, sound = "CW_FOLEY_LIGHT"},
		[3] = {time = 1.173333, sound = "CW_FOLEY_MEDIUM"},
		[4] = {time = 2.02, sound = "CW_SG552_MAGIN"}
	}
}
	
SWEP.SpeedDec = 20

SWEP.ADSFireAnim = false
SWEP.BipodFireAnim = true

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst" ,"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.AimViewModelFOV = 60
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_rif_tg552.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_tg552.mdl"
--SWEP.ViewModel		= "models/weapons/view/rifles/sg552.mdl"
--SWEP.WorldModel		= "models/weapons/w_sg550.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/w_rif_tg552.mdl"
SWEP.WMPos = Vector(1, -3, -0.5)
SWEP.WMAng = Vector(-6, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30 
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"
SWEP.Chamberable = true

SWEP.FireDelay = 0.085
SWEP.FireSound = "CW_SG552_FIRE"
SWEP.FireSoundSuppressed = "CW_SG552_FIRE_SUPPRESSED"
SWEP.Recoil = 1.7

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.09
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 75
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.12
SWEP.ReloadTime_Empty = 2.12
SWEP.ReloadHalt = 2.4
SWEP.ReloadHalt_Empty = 2.4
SWEP.BulletDiameter = 5.70 
SWEP.CaseLength = 44.70
SWEP.SnapToIdlePostReload = true

function SWEP:IndividualInitialize()
	--self:setBodygroup( 4 , 1 )
end