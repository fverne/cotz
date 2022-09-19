AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M3 Super 90"
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
	SWEP.WM = "models/weapons/w_cstm_m3super90.mdl"
	SWEP.WMPos = Vector(-1, 1.5, 0)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
		
	SWEP.IronsightPos = Vector(-2.596, -3.201, 1.039)
	SWEP.IronsightAng = Vector(0.2, 0.119, 0)
	
	SWEP.MicroT1Pos = Vector(-2.618, 0, 0.25)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.613, -4.803, -0.06)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.613, -4.803, 0.064)
	SWEP.AimpointAng = Vector(0, 0, 0)
			
	SWEP.ACOGPos = Vector(-2.599, -4.803, -0.109)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
		
	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)
		
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.593, -4.803, -1.12), [2] = Vector(0, 0, 0)}}

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(-0.64, 0.294, -0.978)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Spas_Body", pos = Vector(-2.589, -4.256, 6.44), angle = Angle(0, 0, 180), size = Vector(1, 1, 1)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Spas_Body", pos = Vector(-2.053, 0.184, 12.067), angle = Angle(-3.333, 90, 180), size = Vector(1, 1, 1)},
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "Spas_Body", pos = Vector(-2.064, -11.19, 2.654), angle = Angle(0, -90, 180), size = Vector(0.6, 1.1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Spas_Body", pos = Vector(-2.32, -9.9, 0.635), angle = Angle(0, -180, -180), size = Vector(0.4, 0.4, 0.4), adjustment = {min = -11, max = -9.9, inverse = true, axis = "y"}},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Spas_foregrip", pos = Vector(-1.9, -30, 6), angle = Angle(0, 180, 180), size = Vector(0.75, 0.75, 0.75)},
	}
	
	SWEP.ForeGripHoldPos = {
	["Bip01 L Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 22.09, 27) },
	["Bip01 L Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -10.636, 22.09) },
	["Bip01 L Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 115.363, 0) },
	["Bip01 L Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 15.545, 0) },
	["Bip01 L Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 58.09, 43.363) },
	["Bip01 L Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 99, 0) },
	["Bip01 L Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 27, 22.09) },
	["Bip01 L Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 67.908) },
	["Bip01 L Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 76.091, 0) },
	["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-1.774, 0.954, 2.318), angle = Angle(0, 0, 0) },
	["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(17.181, 20.454, -25.365) },
	["Bip01 L Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 9, 0) },
	["Bip01 L Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 7.363, 0) },
	["Bip01 L Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 13.909, 0) },
	["Bip01 L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-25.365, -12.273, 84.273) }
}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.ADSFireAnim = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300}, atts = {"md_microt1", "md_eotech", "md_aimpoint"}},
[3] = {header = "Handguard", offset = {-500, -200}, atts = {"md_foregrip"}},
["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"}}
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

SWEP.SpeedDec = 10

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/shotguns/m3.mdl"
SWEP.WorldModel		= "models/weapons/w_cstm_m3super90.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.WearDamage = 0.5
SWEP.WearEffect = 0.05

SWEP.FireDelay = 0.7
SWEP.FireSound = "CW_M3SUPER90_FIRE"
SWEP.Recoil = 3.9

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.35
SWEP.ClumpSpread = 0.025
SWEP.SpreadPerShot = 0.18
SWEP.SpreadCooldown = 1.1
SWEP.Shots = 9
SWEP.Damage = 15
SWEP.DeployTime = 1

SWEP.ReloadStartTime = 0.3
SWEP.InsertShellTime = 0.5
SWEP.ReloadFinishWait = 1
SWEP.ShotgunReload = true

SWEP.Chamberable = false
