AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Nagant M1895"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "k"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.NoShells = true
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/tfa_ins2/wpn_m1895_w.mdl"
	SWEP.WMPos = Vector(-2, 5, -1.5)
	SWEP.WMAng = Vector(-10, 0, 180)
	
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
		
	SWEP.IronsightPos = Vector(-8.881, -10.24, 1.12)
	SWEP.IronsightAng = Vector(-0.301, 0.129, 0)

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

SWEP.Attachments = {["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_hollowpoint", "am_armorpiercing"}}
}

SWEP.Animations = {fire = "shot",
	reload_start = "open",
	insert = "load",
	reload_end = "close",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {open = {{time = 0.05, sound = "CW_NAGANT_OPEN"}},
	load = {{time = 0.1, sound = "CW_NAGANT_INSERT"}},
	
	close = {{time = 0.1, sound = "CW_NAGANT_CLOSE"},
	{time = 0.6, sound = "CW_FOLEY_LIGHT"}},
	
	draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}}}

SWEP.SpeedDec = 5

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "pistol"
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 50
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/tfa_ins2/nagant_v.mdl"
SWEP.WorldModel		= "models/weapons/tfa_ins2/wpn_m1895_w.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x25MM"

SWEP.WearDamage = 0.22
SWEP.WearEffect = 0.05

SWEP.FireDelay = 1.2
SWEP.FireSound = "CW_NAGANT_FIRE"
SWEP.Recoil = 1.1

SWEP.HipSpread = 0.03
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.35
SWEP.SpreadPerShot = 0.18
SWEP.SpreadCooldown = 0.2
SWEP.Damage = 35
SWEP.DeployTime = 1

SWEP.ReloadStartTime = 1.5
SWEP.InsertShellTime = 3.5
SWEP.ReloadFinishWait = 2.8
SWEP.ReloadSpeed = 1.5
SWEP.ShotgunReload = true
SWEP.AlwaysPlayReloadEnd = true
SWEP.SnapToIdlePostReload = true

SWEP.Chamberable = false
