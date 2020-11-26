AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1887"
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
	SWEP.WM = "models/weapons/w_shot_m1887.mdl"
	SWEP.WMPos = Vector(-1, 0, -3)
	SWEP.WMAng = Vector(-15, 0, 180)
	
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.IronsightPos = Vector(-3.2, 2, 1.688)
	SWEP.IronsightAng = Vector(0.026, 0.079, 0)

	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
		
	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)
		
	SWEP.AlternativePos = Vector(-0.64, 0.294, -0.978)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.ADSFireAnim = true

SWEP.Attachments = {
["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_slugrounds", "am_birdshot", "am_trishot", "am_dartrounds", "am_zoneloaded"}}
}

SWEP.Animations = {fire = {"fire1"},
	reload_start = "startreload",
	insert = "insert",
	reload_end = "endreload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {fire1 = {{time = 0.35, sound = "CW_M1887_PUMPFWD"},
							  {time = 0.55, sound = "CW_M1887_PUMPBCK"}},

	startreload = {{time = 0.05, sound = "CW_FOLEY_LIGHT"},
							  {time = 0.25, sound = "CW_M1887_PUMPFWD"}},

	insert = {{time = 0.1, sound = "CW_M1887_INSERT"}},
	
	endreload = {{time = 0.3, sound = "CW_M1887_PUMPBCK"},
	{time = 0.6, sound = "CW_FOLEY_LIGHT"}},
	
	draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"},
	{time = 0.55, sound = "CW_M1887_PUMPBCK"}}}

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
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_shot_m1887.mdl"
SWEP.WorldModel		= "models/weapons/w_shot_m1887.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 7
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.HealthDamage = 0.5
SWEP.HealthEffect = 0.05

SWEP.FireDelay = 0.7
SWEP.FireSound = "CW_M1887_FIRE"
SWEP.Recoil = 5

SWEP.HipSpread = 0.08
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 7
SWEP.MaxSpreadInc = 0.35
SWEP.ClumpSpread = 0.03
SWEP.SpreadPerShot = 0.25
SWEP.SpreadCooldown = 1.1
SWEP.Shots = 9
SWEP.Damage = 20
SWEP.DeployTime = 1

SWEP.SnapToIdlePostReload = true

SWEP.ReloadStartTime = 0.7
SWEP.InsertShellTime = 0.45
SWEP.ReloadFinishWait = 1
SWEP.ShotgunReload = true

SWEP.Chamberable = false