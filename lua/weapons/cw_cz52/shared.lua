AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"


if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "CZ 52"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_cz52", "icons/killicons/khr_cz52", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_cz52")
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/khrcw2/pistols/w_cz52.mdl"
	SWEP.WMPos = Vector(-1.5, 4.5, 1.5)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .95
	SWEP.ShellOffsetMul = 0
	SWEP.ShellPosOffset = {x = -.85, y = .5, z = 8}

	SWEP.IronsightPos = Vector(-1.967, 0, 0.3477)
	SWEP.IronsightAng = Vector(-0.2, 0.05, 0)
	
	SWEP.CompactPos = Vector(-1.967, 0, 0.43)
	SWEP.CompactAng = Vector(-0.122, 0.05, 0)

	SWEP.CustomizePos = Vector(5.1111, -3.5556, -1.2)
	SWEP.CustomizeAng = Vector(16, 34, 14)
	
	SWEP.AlternativePos = Vector(-.25, -1, -.555)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0.5556, 0.5556, -0.5556)
	SWEP.SprintAng = Vector(-18, 14, -10)

	SWEP.EffectiveRange_Orig = 42.38 * 39.37
	SWEP.DamageFallOff_Orig = .44
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 1
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(0, 1.83, 0)
	SWEP.BoltBonePositionRecoverySpeed = 35
	SWEP.EmptyBoltHoldAnimExclusion = "base_firelast"
    SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 1, pitch = 1.5}
	SWEP.CustomizationMenuScale = 0.014

	
	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Weapon", pos = Vector(4.185, -4.182, 18.478), angle = Angle(0, 0, 90), size = Vector(0.5, 0.5, 0.5)}
	}
end

SWEP.MuzzleVelocity = 480 -- in meter/s
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.MagBGs = {main = 1, none = 0, ext = 1}
SWEP.BodyBGs = {main = 0, full = 0, compact = 1}

SWEP.Attachments = {[3] = {header = "Suppressor", offset = {-150, -500}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {550, 150}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"base_fire","base_fire2","base_fire3"},
    fire_dry = "base_firelast",
	reload_empty = "base_reloadempty",
	reload = "base_reload",
	idle = "base_idle",
	draw = "base_ready"}
	
SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_FOLEY_LIGHT"},
		{time = 10/30, sound = "KHRMAK_SAFETY"},
		{time = 13/30, sound = "KHRMAK_BOLTBACK"},
		{time = 19/30, sound = "KHRMAK_BOLTRELEASE"},
	},

	base_draw = {
		{time = 0, sound = "CW_FOLEY_LIGHT"},
	},

	base_reload = {
		{time = 8/30, sound = "KHRMAK_MAGRELEASE"},
		{time = 14/30, sound = "KHRMAK_MAGOUT"},
		{time = 39/30, sound = "KHRMAK_MAGIN"},
		{time = 60/30, sound = "KHRMAK_MAGHIT"},
	},

	base_reload_extmag = {
		{time = 8/30, sound = "KHRMAK_MAGRELEASE"},
		{time = 14/30, sound = "KHRMAK_MAGOUT"},
		{time = 39/30, sound = "KHRMAK_MAGIN"},
		{time = 60/30, sound = "KHRMAK_MAGHIT"},
	},

	base_reloadempty = {
		{time = 8/30, sound = "KHRMAK_MAGRELEASE"},
		{time = 14/30, sound = "KHRMAK_MAGOUT"},
		{time = 39/30, sound = "KHRMAK_MAGIN"},
		{time = 60/30, sound = "KHRMAK_MAGHIT"},
		{time = 71/30, sound = "KHRMAK_BOLTRELEASE"},
	},

	base_reloadempty_extmag = {
		{time = 8/30, sound = "KHRMAK_MAGRELEASE"},
		{time = 14/30, sound = "KHRMAK_MAGOUT"},
		{time = 39/30, sound = "KHRMAK_MAGIN"},
		{time = 60/30, sound = "KHRMAK_MAGHIT"},
		{time = 71/30, sound = "KHRMAK_BOLTRELEASE"},
	},
}

SWEP.SpeedDec = 0

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "pistol"
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/pistols/cz52.mdl"
SWEP.WorldModel		= "models/khrcw2/pistols/w_cz52.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x25MM"

SWEP.FireDelay = 60/500
SWEP.FireSound = "KHRCZ_FIRE"
SWEP.FireSoundSuppressed = "KHRCZ_FIRE_SUPPRESSED"
SWEP.Recoil = 1.6
SWEP.FOVPerShot = 0.25

SWEP.WearDamage = 0.22
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.125
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.0085
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 38
SWEP.DeployTime = 1
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 2.45
SWEP.ReloadHalt = 2.45

SWEP.ReloadTime_Empty = 2.75
SWEP.ReloadHalt_Empty = 2.75

SWEP.SnapToIdlePostReload = false
