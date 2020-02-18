AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
//SCK name: mosin
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Obrez"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.Add("cw_ws_mosin", "vgui/kills/cw_ws_mosin", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/kills/cw_ws_mosin")
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.MuzzleAttachmentName = "muzzle"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 2
	SWEP.ShellPosOffset = {x = 0, y = -200, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	
	SWEP.IronsightPos = Vector(-4.4, 15, 2.2)
	SWEP.IronsightAng = Vector(0.4, 1.6, -5.628)
	
	//SWEP.SprintPos = Vector(0, 0, 0)
	//SWEP.SprintAng = Vector(0, 0, 0)
	SWEP.SprintPos = Vector(3.029, -0.805, -2.201)
	SWEP.SprintAng = Vector(-4.926, 38.693, -18.292)
	
	SWEP.CustomizePos = Vector(5.519, 0, -1.601)
	SWEP.CustomizeAng = Vector(21.106, 25.326, 10.553)

	SWEP.SightWithRail = true

	//SWEP.DisableSprintViewSimulation = true

	SWEP.AttachmentModelsVM = {
	}
	
	function SWEP:getMuzzlePosition()
		return self.CW_VM:GetAttachment(self.CW_VM:LookupAttachment(self.MuzzleAttachmentName))
	end

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
end

SWEP.LuaViewmodelRecoil = false

	SWEP.Attachments = {
		["+reload"] = {header = "Ammo", offset = {800, 150}, atts = {"am_zoneloaded", "am_matchgrade"}}
	}

SWEP.Animations = {
	fire = {"shoot"}, //base_fire_start
	reload = "reload",
	idle = "idle1", //base_idle
	draw = "draw"}
	
SWEP.Sounds = {
	
	reload= {[1] = {time = 0.5, sound = "CW_WS_MOSIN_BOLTBACK"},
	[2] = {time = 1.3, sound = "CW_WS_MOSIN_INSERT"},
	[3] = {time = 2, sound = "CW_WS_MOSIN_BOLTFORWORD"}
	},

	shoot = {
	[1] = {time = 0.5, sound = "CW_WS_MOSIN_BOLTBACK"},
	[2] = {time = 0.8, sound = "CW_WS_MOSIN_BOLTFORWORD"}}}
	

SWEP.SpeedDec = 20

SWEP.ADSFireAnim = true
SWEP.BipodFireAnim = true
SWEP.AimBreathingIntensity = 1

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_obrez.mdl"
SWEP.WorldModel		= "models/weapons/w_obrez.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/w_obrez.mdl"
SWEP.WMPos = Vector(-1, -15, 1)
SWEP.WMAng = Vector(-3,180, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x54MMR"

SWEP.FireDelay = 1.45
SWEP.FireSound = "CW_WS_MOSIN_FIRE"
SWEP.FireSoundSuppressed = "CW_WS_MOSIN_SUB"
SWEP.Recoil = 3.5
SWEP.AimViewModelFOV = 50
SWEP.CustomizationMenuScale = 0.018
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.GlobalDelayOnShoot = 1.1

SWEP.HealthDamage = 0.1
SWEP.HealthEffect = 0.05

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 100
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 2
SWEP.ReloadHalt = 1
SWEP.ReloadHalt_Empty = 1

SWEP.ReloadStartTime = 0.5
SWEP.InsertShellTime = 0.7
SWEP.ReloadFinishWait = 0.6
SWEP.ShotgunReload = false

SWEP.Chamberable = false