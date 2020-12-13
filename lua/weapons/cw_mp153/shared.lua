AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MP-153"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "k"
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.35
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	
	SWEP.ShellPosOffset = {x = 1.2, y = -3, z = 0}
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
		
	SWEP.IronsightPos = Vector(-2.84, 0, 1.15)
	SWEP.IronsightAng = Vector(0.45, 0, 0.5)
	
	SWEP.MicroT1Pos = Vector(-1.821, -1.5, 0.549)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTech553Pos = Vector(-1.823, -.5, 0.26)
	SWEP.EoTech553Ang = Vector(0, 0, 0)	
	
	SWEP.CSGOACOGPos = Vector(-1.8112, -1.5, 0.465)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.KR_CMOREPos =  Vector(-1.821, -1.5, 0.44)
	SWEP.KR_CMOREAng =  Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-1.817, -1.5, 0.5045)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(-1.818, 0, 0.482)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
		
	SWEP.CustomizePos = Vector(5.711, -1.482, -1.5)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)
	
	SWEP.AlternativePos = Vector(-0.6711, 0.6711, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.022
	SWEP.ReticleInactivityPostFire = .8

	SWEP.AttachmentModelsVM = {
	
	["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "body", rel = "", pos = Vector(3.599, 0.029, -.8), angle = Angle(0, 180, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "body", rel = "", pos = Vector(0.518, 0, 1.565), angle = Angle(0, 90, 0), size = Vector(0.24, 0.24, 0.24), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "body", rel = "", pos = Vector(-1.4, 0, .97), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "body", rel = "", pos = Vector(-1, 0.175, 0.1), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "body", rel = "", pos = Vector(0, -0.051, 1.557), angle = Angle(0, 180, 0), size = Vector(0.16, 0.16, 0.16), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "body", rel = "", pos = Vector(3.099, -.2, -1.535), angle = Angle(0, -180, 0), size = Vector(0.53, 0.53, 0.53), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "body", rel = "", pos = Vector(-1.75, .00, 1.13), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/wick/weapons/stalker/stcopwep/w_mp153_model.mdl"
	SWEP.WMPos = Vector(1.7, -4, 2)
	SWEP.WMAng = Vector(0, 180, 180)

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 1, pitch = .5}
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 1.5, forward = 0}
end

SWEP.MuzzleVelocity = 350 -- in meter/s

SWEP.LuaViewmodelRecoil = true
SWEP.FullAimViewmodelRecoil = false
SWEP.LuaViewmodelRecoilOverride = true
SWEP.ADSFireAnim = true

SWEP.Attachments = {--[1] = {header = "Sight", offset = {600, -250},  atts = {"md_microt1kh", "odec3d_cmore_kry", "md_fas2_eotech", "md_fas2_aimpoint", "md_schmidt_shortdot", "md_uecw_csgo_acog"}},
	["+reload"] = {header = "Ammo", offset = {-400, 50}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds"}}}

SWEP.Animations = {fire = {"shoot1"},
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "after_reload",
	idle = "after_reload",
	draw = "draw"}
	
SWEP.Sounds = {start_reload = {{time = 0.05, sound = "CW_FOLEY_LIGHT"}},
	insert = {{time = 0.1, sound = "CW_M3SUPER90_INSERT"}},
	
	after_reload = {{time = 0, sound = "CW_FOLEY_LIGHT"}},
	
	draw = {{time = 0.1, sound = "CW_FOLEY_MEDIUM"}}}
	

SWEP.SpeedDec = 45

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "crossbow"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_bmp153.mdl"
SWEP.WorldModel		= "models/wick/weapons/stalker/stcopwep/w_mp153_model.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 3
SWEP.Primary.DefaultClip	= 3
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.4
SWEP.FireSound = "MP153_FIRE"
SWEP.Recoil = 2

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1.75
SWEP.MaxSpreadInc = 0.08
SWEP.ClumpSpread = 0.01
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.75
SWEP.Shots = 12
SWEP.Damage = 6
SWEP.DeployTime = .5

SWEP.ReloadStartTime = .5
SWEP.InsertShellTime = 0.65
SWEP.ReloadFinishWait = .7
SWEP.ShotgunReload = true

SWEP.Chamberable = false