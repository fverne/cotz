AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AUG A3"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.DrawTraditionalWorldModel = true
	SWEP.WM = "models/weapons/w_rif_aug.mdl"
	SWEP.WMPos = Vector(0, -6, 0)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.IconLetter = "w"
	killicon.AddFont("cw_aug", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
    SWEP.SelectIcon = surface.GetTextureID("weaponicons/gsmaug")
	killicon.Add("cw_aug", "weaponicons/gsmaug", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.SightWithRail = false

    SWEP.IronsightPos = Vector(-2.185, 0, 0.039)
    SWEP.IronsightAng = Vector(0.4, -0.201, 0)
	
    SWEP.EoTechPos = Vector(-2.12, -2.412, -0.48)
    SWEP.EoTechAng = Vector(0, 0, 0)
	
    SWEP.AimpointPos = Vector(-2.165, 0, -0.05)
    SWEP.AimpointAng = Vector(0.4, -0.201, 0)
	
    SWEP.MicroT1Pos = Vector(-2.165, 0, 0.01)
    SWEP.MicroT1Ang = Vector(0.4, -0.201, 0)

	SWEP.ReflexPos = Vector(-2.165, 0, -0.03)
	SWEP.ReflexAng = Vector(0.4, -0.201, 0)
	
	SWEP.CmorePos = Vector(-2.165, 0, -0.08)
	SWEP.CmoreAng = Vector(0.4, -0.201, 0)
	
	SWEP.ACOGPos = Vector(-2.14, -2, -0.28)
	SWEP.ACOGAng = Vector(0.4, -0.201, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.ShortDotPos = Vector(-2.165, 0, -0.13)
	SWEP.ShortDotAng = Vector(0.4, -0.201, 0)
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BoltBone = "a3_charger"
	SWEP.BoltShootOffset = Vector(-2.6, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
        ["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "A3_Body", pos = Vector(-2.38, -9.87, 0.94), angle = Angle(180, 0, 0), size = Vector(0.37, 0.37, 0.37)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "A3_Body", pos = Vector(-2.05, 3.635, 13.899), angle = Angle(180, -90, 0), size = Vector(1.2, 1.2, 1.2)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "A3_Body", pos = Vector(-2.6, -10.5, 0.8), angle = Angle(5.843, 180, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "A3_Body", pos = Vector(-2.597, -4.676, 5.599), angle = Angle(0, 0, 180), size = Vector(0.8, 0.8, 0.8)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "A3_Body", pos = Vector(-1.65, -17.143, 2.596), angle = Angle(0, -90, -90), size = Vector(0.5, 0.5, 0.5)},
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "A3_Body", rel = "", pos = Vector(-2.73, -4.87, 6.2), angle = Angle(180, 270, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "A3_Body", rel = "", pos = Vector(-2.4, -12.87, 0.85), angle = Angle(0, 0, 180), size = Vector(0.65, 0.65, 0.65), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "A3_Body", rel = "", pos = Vector(-2.4, -9.87, 1.1), angle = Angle(0, 0, 180), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "A3_Body", pos = Vector(-2.68, -5, 5.6), angle = Angle(180, 180, 0), size = Vector(0.8, 0.8, 0.8)},
	}
	
	
	SWEP.LaserPosAdjust = Vector(0, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}
	
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {200, -500}, atts = {"md_microt1", "md_eotech", "md_cmore", "md_reflex", "md_aimpoint", "md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", offset = {-300, -200}, atts = {"md_saker"}},
	[3] = {header = "Rail", offset = {250, 400}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_zoneloaded", "am_matchgrade"}}}
	
SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {reload = {[1] = {time = 0.8, sound = "CW_GSM_AUG_MAGOUT"},
	[2] = {time = 1.9, sound = "CW_GSM_AUG_MAGIN"},
	[3] = {time = 2.6, sound = "CW_GSM_AUG_BOLT"}},
	
	draw = {[1] = {time = 0.6, sound = "CW_GSM_AUG_DRAW"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "crossbow"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/gsm/v_gsm_auga3.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_aug.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.WearDamage = 0.1
SWEP.WearEffect = 0.05

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_GSM_AUG_FIRE"
SWEP.FireSoundSuppressed = "CW_GSM_AUG_FIRE_SUPPRESSED"
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 75
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3
SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt = 3
SWEP.ReloadHalt_Empty = 3
SWEP.SnapToIdlePostReload = true