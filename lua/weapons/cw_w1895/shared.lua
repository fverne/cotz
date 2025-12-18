AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Winchester 1895"
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
	
	SWEP.IronsightPos = Vector(-2.05, 0.839, 0.757)
	SWEP.IronsightAng = Vector(-0.094, -0.013, 0.28)
	
	SWEP.EoTechPos = Vector(-3.24, -12, 0.22)
	SWEP.EoTechAng = Vector(-0.15, 0.02, 0)
	
	SWEP.AimpointPos = Vector(-3.23, -12, 0.34)
	SWEP.AimpointAng = Vector(-0.15, 0.02, 0)

	SWEP.MicroT1Pos = Vector(-3.24, 0, 0.47)
	SWEP.MicroT1Ang = Vector(-0.15, 0.02, 0)
	
	SWEP.ReflexPos = Vector(-3.22, -12, 0.6)
	SWEP.ReflexAng = Vector(-0.15, 0.02, 0)
		
	SWEP.CmorePos = Vector(-3.21, -12, 0.5)
	SWEP.CmoreAng = Vector(-0.15, 0.02, 0)

	SWEP.ShortDotPos = Vector(-3.22, -17, 0.435)
	SWEP.ShortDotAng = Vector(-0.15, 0.02, 0)
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0.02, forward = 0}

	SWEP.NXSPos = Vector(-3.25, -14, 0.325)
	SWEP.NXSAng = Vector(-0.15, 0.02, 0)
	SWEP.NXSAlign = {right = 0, up = 0.02, forward = 0}

	SWEP.SprintPos = Vector(3.029, -0.805, -2.201)
	SWEP.SprintAng = Vector(-4.926, 38.693, -18.292)

	SWEP.CustomizePos = Vector(5.519, 0, -1.601)
	SWEP.CustomizeAng = Vector(21.106, 25.326, 10.553)
	SWEP.SightWithRail = true


	//SWEP.DisableSprintViewSimulation = true

	SWEP.AttachmentModelsVM = {

	}


	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 179.5, 0) 
	
	SWEP.WS_PistolLaserPosAdjust = Vector(0, 0, 0)
	SWEP.WS_PistolLaserAngAdjust = Angle(0, 0, 0) 
end

SWEP.LuaViewmodelRecoil = false

	SWEP.Attachments = {
		["+reload"] = {header = "Ammo", offset = {800, 150}, atts = {"am_hollowpoint", "am_armorpiercing"}}
	}

SWEP.Animations = {
	fire = {"shoot"},
	reload_start = "reload_start_empty",
	insert = "reload_insert",
	reload_end = "reload_end_empty",
	idle = "idle", //base_idle
	draw = "draw"}
	
SWEP.Sounds = {
	
	reload_start_empty = {[1] = {time = 0.5, sound = "CW_W9422_BOLTBACK"}},
	reload_insert = {[1] = {time = 0.4, sound = "CW_W9422_INSERT"}},
	reload_end_empty = {[1] = {time = 0.3, sound = "CW_W9422_BOLTFORWORD"}},

	shoot = {
	[1] = {time = 0.6, sound = "CW_W9422_BOLTBACK"},
	[2] = {time = 0.8, sound = "CW_W9422_BOLTFORWORD"}}}
	

SWEP.SpeedDec = 30

SWEP.ADSFireAnim = true
SWEP.BipodFireAnim = true
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
SWEP.ViewModel		= "models/weapons/c_rif_win1895.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_win1895.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/w_rif_win1895.mdl"
SWEP.WMPos = Vector(-1, 10, 1.5)
SWEP.WMAng = Vector(-9,1,180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x54MMR"

SWEP.FireDelay = 1.25
SWEP.FireSound = "CW_W9422_FIRE"
SWEP.FireSoundSuppressed = "CW_WS_MOSIN_SUB"
SWEP.Recoil = 3.1
SWEP.AimViewModelFOV = 50
SWEP.CustomizationMenuScale = 0.018
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.GlobalDelayOnShoot = 1.1

SWEP.HipSpread = 0.12
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 6
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.3
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 200
SWEP.DeployTime = 1
/*
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.4
SWEP.ReloadTime_Empty = 3.8
SWEP.ReloadHalt = 2.7
SWEP.ReloadHalt_Empty = 4.1
*/
SWEP.ReloadStartTime = 0.6
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.ShotgunReload = true
SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = false
