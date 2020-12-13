AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "smgMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "SR-2 Veresk"
	SWEP.CSMuzzleFlashes = true
	SWEP.SuppressedOnEquip = false
	
	SWEP.IconLetter = "w"
	killicon.Add( "", "", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = false
	SWEP.SightWithRail = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .4
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.FireMoveMod = 2

	SWEP.IronsightPos = Vector(-2.4476, -2, 1.41)
	SWEP.IronsightAng = Vector(0, 0.05, 0)
	
	SWEP.KR_CMOREPos = Vector(-2.45, -3.5, 0.74)
	SWEP.KR_CMOREAng = Vector(0, 0.05, 0)

	SWEP.FAS2AimpointPos = Vector(-2.429, -4, 0.868)
	SWEP.FAS2AimpointAng = Vector(0, 0.05, 0)

	SWEP.EoTech553Pos = Vector(-2.45, -3.5, 0.63)
	SWEP.EoTech553Ang = Vector(0, 0.05, 0)

	SWEP.MicroT1Pos = Vector(-2.46, -3.5, 0.85)
	SWEP.MicroT1Ang = Vector(0, 0.05, 0)
	
	SWEP.SprintPos = Vector(-0.5556, -0.5556, -1.6667)
	SWEP.SprintAng = Vector(-14, 26, -26)
	
	SWEP.CustomizePos = Vector(3.8889, -2.7778, 0)
	SWEP.CustomizeAng = Vector(14, 30, 18)
	
	SWEP.AlternativePos = Vector(-0.5556, -0.5556, 0.2)
	SWEP.AlternativeAng = Vector(0, 0.703, 0)
	
    SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 1
	SWEP.DisableSprintViewSimulation = false
	SWEP.FOVPerShot = 0.7
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1.25, hor = 0.2, roll = .75, forward = .65, pitch = 1.55}
	SWEP.CustomizationMenuScale = 0.015
	
	SWEP.AttachmentModelsVM = {
	["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-4.2, -15.5, 3.2), angle = Angle(0, -90, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.741, -11.948, 2.539), angle = Angle(-180, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.767, -9.87, 1.87), angle = Angle(180, 0, 0), size = Vector(0.28, 0.28, 0.28), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.567, -11.171, 3.545), angle = Angle(180, 90, 0), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_tundra9mm"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.75, -22, 4), angle = Angle(180, 0, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.83, -9.91, 1.899), angle = Angle(180, -90, 0), size = Vector(0.189, 0.189, 0.189), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.757, -12.5, 2.359), angle = Angle(180, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
end

SWEP.MuzzleVelocity = 423 -- in meter/s

SWEP.LaserPosAdjust = Vector(-.8, 0, 0)--{x = 1, y = 0, z = 0}
SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}

SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = true

SWEP.Attachments = {[3] = {header = "Optic", offset = {300, -500}, atts = {"md_microt1"}},
[2] = {header = "Barrel", offset = {-300, -600}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {-50, 350}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {reload = "reload",
	fire = {"shoot1", "shoot2"},
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0.45, sound = "VERESK_FOREGRIP"}},

	reload= {[1] = {time = 0.4, sound = "VERESK_MAGOUT"},
	[2] = {time = 1.7, sound = "VERESK_MAGIN"},
	[3] = {time = 1.8, sound = "VERESK_MAGIN2"},
	[4] = {time = 2.2, sound = "VERESK_BOLTREL"},
	[5] = {time = 2.7, sound = "VERESK_HANDLE"}}}

SWEP.SpeedDec = 25

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"auto","semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.OverallMouseSens = 1
SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_smg_sr2ve.mdl"
SWEP.WorldModel		= "models/sr-2m veresk/sr2.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/sr-2m veresk/sr2.mdl"
SWEP.WMPos = Vector(2.5, 1, -6)
SWEP.WMAng = Vector(0,270,180)


SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x21MM"

SWEP.FireDelay = 60/900
SWEP.FireSound = "VERESK_FIRE"
SWEP.FireSoundSuppressed = "VERESK_SUPFIRE"
SWEP.Recoil = 2.2

SWEP.HipSpread = 0.125
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.0915
SWEP.Damage = 75
SWEP.DeployTime = 1.5
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.4
SWEP.ReloadHalt = 3.4

SWEP.ReloadTime_Empty = 3.4
SWEP.ReloadHalt_Empty = 3.4