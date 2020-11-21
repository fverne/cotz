AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Mossberg 500"
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
	SWEP.WM = "models/weapons/w_shot_mossberg5.mdl"
	SWEP.WMPos = Vector(0, -13, 0)
	SWEP.WMAng = Vector(-10, 180, 180)
	
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
		
	SWEP.IronsightPos = Vector(5.719, 0, 3.24)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(5.739, 0, 2.48)
	SWEP.MicroT1Ang = Vector(0.2, 0, 0)
	
	SWEP.EoTechPos = Vector(5.76, -2, 2.65)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
		
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(5, -5, 5)
		
	SWEP.SprintPos = Vector(0, -5, 5)
	SWEP.SprintAng = Vector(-20, -30, -20)
		
	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "v_weapon.M3_PARENT", pos = Vector(-0.1, -1.1, -1.481), angle = Angle(90, 0, 90), size = Vector(0.5, 0.5, 0.5)},
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "v_weapon.M3_PARENT", pos = Vector(-0.151, 3.299, 4.5), angle = Angle(-90, 90, 180), size = Vector(0.55, 0.718, 0.55)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "v_weapon.M3_PARENT", pos = Vector(0, 4.4, 4.5), angle = Angle(0, 0, 90), size = Vector(0.3, 0.3, 0.3)}
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.ADSFireAnim = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300}, atts = {"md_microt1", "md_eotech"}},
["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_slugrounds", "am_birdshot", "am_trishot", "am_dartrounds", "am_zoneloaded"}}
}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "after_reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {start_reload = {{time = 0.05, sound = "CW_FOLEY_LIGHT"}},
	insert = {{time = 0.1, sound = "CW_M3SUPER90_INSERT"}},
	
	after_reload = {{time = 0.1, sound = "CW_M3SUPER90_PUMP"},
	{time = 0.6, sound = "CW_FOLEY_LIGHT"}},
	
	draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"},
	{time = 0.55, sound = "CW_M3SUPER90_PUMP"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "crossbow"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_shot_mossberg5.mdl"
SWEP.WorldModel		= "models/weapons/w_shot_mossberg5.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.WearDamage = 0.5
SWEP.WearEffect = 0.05

SWEP.FireDelay = 0.7
SWEP.FireSound = "CW_M3SUPER90_FIRE"
SWEP.Recoil = 3

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 0.5
SWEP.MaxSpreadInc = 0.4
SWEP.ClumpSpread = 0.040
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 9
SWEP.Damage = 15
SWEP.DeployTime = 1

SWEP.ReloadStartTime = 0.3
SWEP.InsertShellTime = 0.5
SWEP.ReloadFinishWait = 1
SWEP.ShotgunReload = true

SWEP.Chamberable = false