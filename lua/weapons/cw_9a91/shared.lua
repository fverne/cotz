AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "9A-91"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/flaymi/anomaly/weapons/w_models/9a91.mdl"
	SWEP.WMPos = Vector(-1, 4, 0)
	SWEP.WMAng = Vector(-15, 0, 180)

	SWEP.IronsightPos = Vector(-3.805, -3, 2.098)
	SWEP.IronsightAng = Vector(0.24, 0.495, 0)
	
	SWEP.KobraPos = Vector(-2.587, -3.539, 0.509)
	SWEP.KobraAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.CustomizePos = Vector(12.121, -4.907, -0.461)
	SWEP.CustomizeAng = Vector(17.232, 58.485, 19.311)
		
	SWEP.SightWithRail = true
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.ForeGripOffsetCycle_Reload = 0.75
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9

	SWEP.AttachmentModelsVM = {
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "wpn_body", pos = Vector(1.649, -2.201, -18), angle = Angle(0, 90, -90), size = Vector(1.299, 1.299, 1.299)},
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}

	--SWEP.BoltBone = "ak46_bolt"
	--SWEP.BoltShootOffset = Vector(-2, 0, 0)
end
	
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[5] = {header = "Barrel", offset = {0, -50}, atts = {"md_pbs1"}},
	["+reload"] = {header = "Ammo", offset = {1400, 350}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = "anm_shots",
	reload = "anm_reload",
	idle = "anm_idle",
	draw = "anm_show"}
	
SWEP.Sounds = {anm_show = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},
	
	anm_reload = {{time = 0.4, sound = "CW_FOLEY_LIGHT"},
	{time = 0.5, sound = "CW_G3A3_HANDLE"},
	{time = 0.7, sound = "CW_VSS_MAGOUT"},
	{time = 1.4, sound = "CW_FOLEY_LIGHT"},
	{time = 1.6, sound = "CW_VSS_MAGIN"},
	{time = 2.5, sound = "CW_FOLEY_MEDIUM"},
	{time = 1.73, sound = "CW_VSS_BOLTBACK"},
	{time = 1.97, sound = "CW_VSS_BOLTFORWARD"},
	{time = 3, sound = "CW_FOLEY_LIGHT"}},
}

SWEP.UseHands = true

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/flaymi/anomaly/weapons/v_models/9a91.mdl"
SWEP.WorldModel		= "models/flaymi/anomaly/weapons/w_models/9a91.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x39MM"

SWEP.Chamberable = false

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_SR3M_FIRE"
SWEP.FireSoundSuppressed = "CW_SR3M_FIRE_SUPPRESSED"
SWEP.Recoil = 1.5

SWEP.SuppressedOnEquip = false

SWEP.WearDamage = 0.08
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.10
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.15
SWEP.SpreadPerShot = 0.015
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 160
SWEP.DeployTime = 1.2

SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 2.63
SWEP.ReloadTime_Empty = 2.63
SWEP.ReloadHalt = 3.4
SWEP.ReloadHalt_Empty = 3.4
