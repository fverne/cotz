AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TOZ-106"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "k"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0.3
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/arc9/darsu_eft/w_toz106.mdl"
	SWEP.WMPos = Vector(-5.5, -11, 6)
	SWEP.WMAng = Vector(-5, 0, 180)
	
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true

	SWEP.IronsightPos = Vector(-4.28, -3.5, 0.92)
	SWEP.IronsightAng = Vector(0, 0, 0)
		
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(5, -5, 5)
		
	SWEP.SprintPos = Vector(3, 0, 0)
	SWEP.SprintAng = Vector(-15, 30, 0)

	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "v_weapon.M3_PARENT", pos = Vector(-0.1, -1.1, -1.481), angle = Angle(90, 0, 90), size = Vector(0.5, 0.5, 0.5)},
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "v_weapon.M3_PARENT", pos = Vector(-0.151, 3.299, 4.5), angle = Angle(-90, 90, 180), size = Vector(0.55, 0.718, 0.55)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "v_weapon.M3_PARENT", pos = Vector(0, 4.4, 4.5), angle = Angle(0, 0, 90), size = Vector(0.3, 0.3, 0.3)}
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}

	SWEP.UseHands				= true
end

SWEP.ADSFireAnim = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300}, atts = {"md_microt1", "md_eotech"}},
	["+reload"] = {header = "Ammo", offset = {800, -200}, atts = {"am_hollowpoint", "am_armorpiercing", "am_410buck"}}
}

SWEP.Animations = {fire = "cycle0",
	reload = "reload0",
	reload_empty = "reload_empty0",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {cycle0 = {{time = 0.27, sound = "CW_TOZ106_BOLTOUT"},
						{time = 0.55, sound = "CW_TOZ106_BOLTIN"}},
	
	reload0 = {{time = 0.77, sound = "CW_TOZ106_MAGOUT"},
	{time = 1.2, sound = "CW_FOLEY_LIGHT"},
	{time = 1.92, sound = "CW_TOZ106_MAGIN"},
	{time = 2.38, sound = "CW_FOLEY_LIGHT"}},
	
	reload_empty0 = {{time = 0.34, sound = "CW_TOZ106_BOLTOUT"},
	{time = 1.26, sound = "CW_TOZ106_MAGOUT"},
	{time = 2.35, sound = "CW_FOLEY_LIGHT"},
	{time = 2.75, sound = "CW_TOZ106_MAGIN"},
	{time = 4.22, sound = "CW_TOZ106_BOLTIN"}},

	draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}}


}

SWEP.SpeedDec = 10

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

SWEP.ViewModelFOV	= 55
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/arc9/darsu_eft/c_toz106.mdl"
SWEP.WorldModel		= "models/weapons/arc9/darsu_eft/w_toz106.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 2
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".45 ACP"

SWEP.WearDamage = 0.5
SWEP.WearEffect = 0.05

SWEP.FireDelay = 0.7
SWEP.FireSound = "CW_TOZ106_FIRE"
SWEP.Recoil = 4.5

SWEP.GlobalDelayOnShoot = 1.1

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.35
--SWEP.ClumpSpread = 0.025
SWEP.SpreadPerShot = 0.19
SWEP.SpreadCooldown = 1
SWEP.Shots = 5
SWEP.Damage = 85
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.8
SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt = 4.5
SWEP.ReloadHalt_Empty = 4.7

SWEP.Chamberable = true

function SWEP:IndividualInitialize()
	self:setBodygroup( 1 , 1 )
	self:setBodygroup( 4 , 1 )
	self:setBodygroup( 5 , 1 )
	self:setBodygroup( 6 , 1 )
end
