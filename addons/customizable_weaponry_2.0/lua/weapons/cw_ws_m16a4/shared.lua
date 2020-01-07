AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M16A4"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.Add("cw_ws_m16a4", "vgui/kills/cw_ws_m16a4", Color(255, 255, 255, 255))
	SWEP.SelectIcon = surface.GetTextureID("vgui/kills/cw_ws_m16a4")
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.4
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = -1, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6

	SWEP.IronsightPos = Vector(-1.903, 0, -0.12)
	SWEP.IronsightAng = Vector(0.8, 0.009, 0)	

	SWEP.EoTechPos = Vector(-1.9, 0, -0.091)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-1.92, 0, 0.119)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-1.905, 0, 0.079)
	SWEP.MicroT1Ang = Vector(0.8, 0.009, 0)
	
	SWEP.SprintPos = Vector(1.879, 0, 0.959)
	SWEP.SprintAng = Vector(-21.107, 30.954, -6.332)	
	
	SWEP.ShortDotPos = Vector(-1.9, 0, 0.079)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.ReflexPos = Vector(-1.92, 0, 0.2)
	SWEP.ReflexAng = Vector(0, 0, 0)

	SWEP.CmorePos = Vector(-1.905, 0, 0.179)
	SWEP.CmoreAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-1.898, 0, -0.235)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.CustomizePos = Vector(4.88, 0, -2.36)
	SWEP.CustomizeAng = Vector(17.587, 30.954, 8.442)

	SWEP.SightWithRail = false
			
	SWEP.AlternativePos = Vector(0.319, 1.325, -1.04)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BaseArm = "L_Arm_Controller"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "Receiver", rel = "", pos = Vector(0.3, 5.714, -2.651), angle = Angle(0, 90, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Receiver", rel = "", pos = Vector(-0.051, -7.901, -0.12), angle = Angle(0, -180, 0), size = Vector(0.55, 0.55, 0.55)},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Receiver", rel = "", pos = Vector(-0.301, 12.5, -8.25), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), adjustment = {min = 11, max = 13, axis = "y", inverse = true}},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Receiver", rel = "", pos = Vector(-0.051, 1, 2.596), adjustment = {min = -1, max = 2.4, axis = "y", inverse = true}, angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Receiver", rel = "", pos = Vector(0.189, 6.199, -2.31), angle = Angle(0, -180, 0), size = Vector(0.85, 0.85, 0.85), adjustment = {min = 4.5, max = 7.5, axis = "y", inverse = true}},
		["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "Receiver", rel = "", pos = Vector(-0.5, -13.8, -0.95), angle = Angle(0, 0, 0), size = Vector(0.55, 0.55, 0.55)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Receiver", rel = "", pos = Vector(0, -1.5, 2.7), angle = Angle(0, 180, 0), size = Vector(0.65, 0.65, 0.65), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Receiver", rel = "", pos = Vector(-0.02, 1, 2.4), angle = Angle(0, 180, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Receiver", pos = Vector(0.3, 5.714, -2.651), angle = Angle(0, 180, 0), size = Vector(0.9, 0.9, 0.9)},
	}

	
	SWEP.ForeGripHoldPos = {
	["Bone_L_LowerArm01"] = { scale = Vector(1, 1, 1), pos = Vector(-1.5, 1.264, 1.131), angle = Angle(18.113, -1.084, 68.313) },
	["Bone_L_UpperThumb01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(12.781, 0, 49.811) },
	["Bone05"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.354, 0), angle = Angle(78.817, -31.953, 0) },
	["Bone09"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.2, 0), angle = Angle(61.775, 0, 21.302) },
	["Bone01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.5, 0), angle = Angle(106.509, -14.912, 0) },
	["Bone14"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(59.645, 25.562, 0) },
	["Bone_L_LowerThumb01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(51.124, 0, 48.993) }
	}

	
	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(-0.1, 180, 3) 
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end


SWEP.BarrelBGs		={main = 4, regular = 0, none = 1, longris = 1, magpul = 1}
SWEP.SightBGs		= {main = 3, carryhandle = 0, foldsight = 2, none = 1, foldfold = 3}
SWEP.ForegripBGs	= {main = 3, regular = 0, covered = 1}
SWEP.MagBGs			= {main = 5, regular = 0, none = 1, cmag = 1, emag = 1, pmag = 1, round60 = 1}
SWEP.StockBGs		= {main = 2, regular = 0, lightweight = 1, moestock = 1, none = 1}
SWEP.SilencerBGs	= {main = 6, off = 0, on = 1, long_off = 2, long_on = 3}
//lua_run Entity(1):GetViewModel():SetBodygroup(3,1)
//SWEP.AimBreathingEnabled = true
SWEP.LuaViewmodelRecoil = true




	SWEP.Attachments = {
		[1] = {header = "Sight", offset = {400, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore","md_schmidt_shortdot", "md_acog"}},
		[3] = {header = "Silencer", offset = {-400, -200},  atts = {"md_saker"}},
		[4] = {header = "Handguard", offset = {-400, 200}, atts = {"md_foregrip"}}, 
		["+reload"] = {header = "Ammo", offset = {800, 150}, atts = {"am_zoneloaded", "am_matchgrade"}}
	}

	
SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {
	draw = {
	[1] = {time = 0, sound = "CW_WS_M16A4_DRAW"}},
	
	reload = {
	[1] = {time = 0.5, sound = "CW_WS_M16A4_MAGOUT"},
	[2] = {time = 1, sound = "CW_WS_M16A4_MAGOUT2"},
	[3] = {time = 1.6, sound = "CW_WS_M16A4_MAGIN"},
	[4] = {time = 1.8, sound = "CW_WS_M16A4_MAGIN2"},
	[5] = {time = 2.35, sound = "CW_WS_M16A4_BOLTBACK"},
	[6] = {time = 2.6, sound = "CW_WS_M16A4_BOLTBACK2"},}
	}

SWEP.SpeedDec = 30

SWEP.ADSFireAnim = false
SWEP.BipodFireAnim = true

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst" ,"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "some faggot & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.HealthDamage = 0.1
SWEP.HealthEffect = 0.05

SWEP.ViewModelFOV	= 70
SWEP.AimViewModelFOV = 60
SWEP.ViewModelFlip	= false		
SWEP.ViewModel		= "models/weapons/m16a4/v_rif_m16a4.mdl"
SWEP.WorldModel		= "models/weapons/m16a4/w_rif_m16a4.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/m16a4/w_rif_m16a4.mdl"
SWEP.WMPos = Vector(-1, -2, -0.2)
SWEP.WMAng = Vector(-3,1,180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30 
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"
SWEP.magType = "arMag"
SWEP.Chamberable = true

SWEP.FireDelay = 0.075
SWEP.FireSound = "CW_WS_M16A4_FIRE"
SWEP.FireSoundSuppressed = "CW_WS_M16A4_FIRE_SUPPRESSED"
SWEP.Recoil = 1.7

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 75
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1.25
SWEP.ReloadTime = 2.35
SWEP.ReloadTime_Empty = 3.7
SWEP.ReloadHalt = 0.1
SWEP.ReloadHalt_Empty = 0.1
SWEP.SnapToIdlePostReload = false
SWEP.BulletDiameter = 5.70 
SWEP.CaseLength = 44.70
SWEP.SnapToIdlePostReload = true