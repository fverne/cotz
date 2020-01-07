AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TT-33 Tokarev"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = ""
	killicon.AddFont("", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	
	SWEP.Shell = "mainshell"
	SWEP.ShellScale = .28
	SWEP.ShellOffsetMul = 0
	SWEP.ShellPosOffset = {x = 2, y = 0, z = 0}

	SWEP.IronsightPos = Vector(-2.28, 0, 0.109)
	SWEP.IronsightAng = Vector(1.2, 0.021, 0)
	
	SWEP.SprintPos = Vector(0.602, -0.202, 0)
	SWEP.SprintAng = Vector(-11.961, 3.517, 0)
	
	SWEP.CustomizePos = Vector(5.427, -3.418, -2.01)
	SWEP.CustomizeAng = Vector(19.697, 27.437, 24.622)
	
	SWEP.AlternativePos = Vector(-0.64, -1, -1.121)
	SWEP.AlternativeAng = Vector(0, 0.703, 0)

	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(-1.5, 0, 0)
	SWEP.BoltReloadOffset = Vector(-0, 0, 0)
	SWEP.ReloadBoltBonePositionRecoverySpeed = 99999
	SWEP.ReloadBoltBonePositionMoveSpeed = 99999
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = false
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 1, pitch = 1.5}
	SWEP.CustomizationMenuScale = 0.013
	SWEP.BoltBonePositionRecoverySpeed = 35 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
	
	["md_tokasup"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "body", rel = "", pos = Vector(0, -2.86, -0.401), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Barrel Extension", offset = {-600, -450}, atts = {"md_tokasup"}},
["+reload"] = {header = "Ammo", offset = {400, -100}, atts = {"am_zoneloaded", "am_matchgrade"}}}


SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "TT_SLIDE"}},

	reload = {[1] = {time = 0.40, sound = "TT_CLIPOUT"},
	[2] = {time = 1.15, sound = "TT_CLIPIN"},
	[3] = {time = 1.6, sound = "TT_SLIDE"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "some faggot & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_khri_tt33tokar.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_tt38.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x25MM"

SWEP.FireDelay = 0.15
SWEP.FireSound = "TT_FIRE"
SWEP.FireSoundSuppressed = "TT_FIRE_SUPPRESSED"
SWEP.Recoil = 1.55
SWEP.FOVPerShot = 0.2

SWEP.HealthDamage = 0.125
SWEP.HealthEffect = 0.05

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 39
SWEP.DeployTime = .7
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1.5
SWEP.ReloadTime = 2.5
SWEP.ReloadHalt = 2.5

SWEP.ReloadTime_Empty = 2.5
SWEP.ReloadHalt_Empty = 2.5