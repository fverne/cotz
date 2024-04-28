if CustomizableWeaponry then

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "G2 Contender (.500 Magnum)"
	SWEP.CSMuzzleFlashes = false
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "f"
	SWEP.SelectIcon = surface.GetTextureID("vgui/hud/cw_contender") -- Icon to use for weapon select (1,2,3, mousewheel etc.)	"
	killicon.Add("cw_contender", "vgui/hud/kill/cw_contender", Color(255, 255, 255, 150)) -- Kill icon
	killicon.Add("cw_bullet_30wcf", "vgui/hud/kill/cw_contender", Color(255, 255, 255, 150)) -- Kill icon for GDCW bullet
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.NoSilMuz = true
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.Shell = false -- Disables brass ejection
	SWEP.SightWithRail = false
	
	SWEP.IronsightPos = Vector(-2.81, 0, 1.32)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.AccuPos = Vector(-2.81, 0, 0.32)
	SWEP.AccuAng = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-2.81, 0, 0.22)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-2.82, 0, 0.6)
	SWEP.AimpointAng = Vector(0, 0, 0)	
	
	SWEP.EoTechPos = Vector(-2.81, 0, 0.45)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.LeupoldPos = Vector(-2.81, 0, 0.4)
	SWEP.LeupoldAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.82, 0, 0.48)
	SWEP.MicroT1Ang = Vector(0, 0, 0)	

	SWEP.AlternativePos = Vector(-2.81, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)	

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.AccuAxisAlign = {right = 1, up = 0, forward = 0}
	SWEP.LeupoldAxisAlign = {right = 0, up = 0.095, forward = 0}
	
	SWEP.AttachmentModelsVM = {
			["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "barrel", rel = "", pos = Vector(5.25, 3.44, -0.2), angle = Angle(90, 0, -90), size = Vector(0.8, 0.8, 0.8)},
			["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "barrel", rel = "", pos = Vector(8.8, 7.44, 0.24), angle = Angle(180, 0, -90), size = Vector(0.8, 0.8, 0.8)},
			["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "barrel", pos = Vector(-0.6, -1.3, 0.03), angle = Angle(-90, 0, -90), size = Vector(0.4, 0.4, 0.4)},
			["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "barrel", pos = Vector(0.7, 1.1, 0), angle = Angle(90, 0, -90), size = Vector(0.6, 0.6, 0.6)},
		}

	SWEP.LaserPosAdjust = Vector(1, 0, 0)
	SWEP.LaserAngAdjust = Angle(2, 180, 0)

end

SWEP.LuaViewmodelRecoil = false
SWEP.ADSFireAnim = true
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.GlobalDelayOnShoot = 0.5
SWEP.CustomizationMenuScale = 0.012

SWEP.Attachments = {[1] = {header = "Sight", offset = {0, -500},  atts = {"md_aimpoint", "md_eotech", "md_microt1"}},
	[2] = {header = "Barrel", offset = {-450, -300}, atts = {"md_saker"}},
	["+reload"] = {header = "Ammo", offset = {400, -100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = "shoot1",
	fireDry = "shoot1",
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
	SWEP.Sounds = {draw = {[1] = {time = 0, sound = "Contender.Deploy"},
		[2] = {time = 0.75, sound = "Contender.Cock"}},

		reload = {[1] = {time = 0, sound = "Contender.Foley"},
		[2] = {time = 0.2, sound = "Contender.Open"},
		[3] = {time = 0.75, sound = "Contender.Shell"},
		[4] = {time = 1.148, sound = "Contender.In1"},
		[5] = {time = 1.5, sound = "Contender.In2"},
		[6] = {time = 2.1, sound = "Contender.Close"},
		[7] = {time = 2.2, sound = "Contender.Cock"}}}

SWEP.SpeedDec = 0

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"break"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/pistols/v_contender.mdl"
SWEP.WorldModel		= "models/cw2/pistols/w_contender.mdl"
SWEP.DrawTraditionalWorldModel = false	--Whether to use world model's embedded/compiled origin
SWEP.WM = "models/cw2/pistols/w_contender.mdl"
SWEP.WMPos = Vector(0.5,-17.0,0.0)	--world model origin X,Y,Z
SWEP.WMAng = Vector(-20,179.5,180)	--world model angles X,Y,Z

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".500 Magnum"
SWEP.Chamberable = false

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_SW500_FIRE"
SWEP.FireSoundSuppressed = "CWC_MATEBA_FIRE_SUP"
SWEP.Recoil = 7

SWEP.WearDamage = 0.45
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.075
SWEP.AimSpread = 0.0125
SWEP.VelocitySensitivity = 12
SWEP.MaxSpreadInc = 0.5
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 200
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.5
SWEP.ReloadTime_Empty = 2.5
SWEP.ReloadHalt = 2.5
SWEP.ReloadHalt_Empty = 2.5
SWEP.SnapToIdlePostReload = true

end
