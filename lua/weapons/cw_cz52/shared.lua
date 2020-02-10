AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "CZ-52"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = ""
	killicon.AddFont("", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	
	SWEP.Shell = "mainshell"
	SWEP.ShellScale = .28
	SWEP.ShellOffsetMul = 0
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}

	SWEP.IronsightPos = Vector(3.375, 4, 1.69)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(3.45, 0, 0.45)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(3.4, -2, 0.25)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.RMRPos = Vector(3.4, -5, 0.7)
	SWEP.RMRAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(-4.37, -4.222, 1.799)
	SWEP.CustomizeAng = Vector(29.548, -26.031, -49.246)
	
	SWEP.AlternativePos = Vector(1, 1.5, -0.202)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0.602, -0.202, 0)
	SWEP.SprintAng = Vector(-11.961, 3.517, 0)

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 1
	SWEP.SnapToIdlePostReload = true
	SWEP.OffsetBoltDuringNonEmptyReload = false
	SWEP.BoltBone = "ber_slide"
	SWEP.BoltShootOffset = Vector(-2, 0, 0)
	SWEP.BoltReloadOffset = Vector(-2, 0, 0)
	SWEP.ReloadBoltBonePositionRecoverySpeed = 99999
	SWEP.ReloadBoltBonePositionMoveSpeed = 99999
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = false
	SWEP.DisableSprintViewSimulation = false
	SWEP.SightWithRail = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1.2, hor = 1, roll = 1, forward = 1, pitch = 1.5}
	SWEP.CustomizationMenuScale = 0.014
	SWEP.BoltBonePositionRecoverySpeed = 50 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "ber_body", pos = Vector(9.8, 2.2, -0.6), angle = Angle(0, 270, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_rail"] = {model = "models/cw2/attachments/slimpistolrail.mdl", bone = "ber_body", pos = Vector(6, 0.8, 0), angle = Angle(0, 0, 90), size = Vector(0.13, 0.13, 0.13)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "ber_body", pos = Vector(5, 3.1, 0), angle = Angle(270, 0, 90), size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "ber_body", pos = Vector(-6, -7.8, 0.3), angle = Angle(180, 180, -90), size = Vector(1, 1, 1)},
		["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "ber_body", pos = Vector(0, -2.15, -0.3), angle = Angle(180, 180, -90), size = Vector(0.9, 0.9, 0.9)},
	}
end

SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {200, -200}, atts = {"md_microt1", "md_eotech", "md_rmr"}},
[2] = {header = "Barrel Extension", offset = {-650, -450}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {550, -50}, atts = {"am_zoneloaded", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.2, sound = "TT_CLIPOUT"},
	[2] = {time = 1.2, sound = "TT_CLIPIN"},
	[3] = {time = 1.9, sound = "TT_SLIDE"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.HoldType = "pistol"
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "some faggot & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_khri_cz52.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_cz52.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62X25MM"

SWEP.FireDelay = 0.08
SWEP.FireSound = "TT_FIRE"
SWEP.FireSoundSuppressed = "TT_FIRE_SUPPRESSED"
SWEP.Recoil = 1.6
SWEP.FOVPerShot = 0.2

SWEP.WearDamage = 0.125
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 39
SWEP.DeployTime = 1
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1.25
SWEP.ReloadTime = 2.5
SWEP.ReloadHalt = 2.5

SWEP.ReloadTime_Empty = 2.5
SWEP.ReloadHalt_Empty = 2.5