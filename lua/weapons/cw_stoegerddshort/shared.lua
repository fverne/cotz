AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Stoeger Double Defense Short"
	
	SWEP.IconLetter = "k"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.PosBasedMuz = true

	SWEP.NoShells = true
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_pist_lyxn_dualb.mdl"
	SWEP.WMPos = Vector(-1, 2, -1)
	SWEP.WMAng = Vector(-4, -5, 180)
	
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.90
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.90
	
	SWEP.IronsightPos = Vector(-2.572, 0, 0.8)
	SWEP.IronsightAng = Vector(2.55, -0.045, 0)
	
	SWEP.LongPos = Vector(-2.572, 0, 1.169)
	SWEP.LongAng = Vector(0.9, -0.041, 0)
	
	SWEP.MicroT1Pos = Vector(-2.529, 0, 0.385)
	SWEP.MicroT1Ang = Vector(-0.661, 0.25, 0)

	SWEP.EoTechPos = Vector(-2.546, 0, -0.57)
	SWEP.EoTechAng = Vector(-0.159, 0.076, 0)
	
	SWEP.AimpointPos = Vector(-2.582, 0, 0.143)
	SWEP.AimpointAng = Vector(-0.65, 0.128, 0)
	
	SWEP.RMRPos = Vector(-2.545, 0, 0)
	SWEP.RMRAng = Vector(2.092, 0, 0)
	
	SWEP.SprintPos = Vector(5.971, -1.524, -2.044)
	SWEP.SprintAng = Vector(-2.412, 34.646, 0)

    SWEP.CustomizePos = Vector(5.65, 0, -0.731)
	SWEP.CustomizeAng = Vector(5.111, 27, 0)

	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 0.65 -- 0.85
	SWEP.FullAimViewmodelRecoil = true
	SWEP.FOVPerShot = 0.3
	
	SWEP.DisableSprintViewSimulation = false
	
	SWEP.ReticleInactivityPostFire = 0.41
	
	SWEP.AttachmentModelsVM = {
	    ["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "double_barrel", rel = "", pos = Vector(-0.67, -5.516, -4.534), angle = Angle(0, -90, 0), size = Vector(1.164, 1.164, 1.164)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "double_barrel", rel = "", pos = Vector(-0.561, -8.296, -4.992), angle = Angle(0.345, -0, 0), size = Vector(1.248, 1.248, 1.248)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "double_barrel", rel = "", pos = Vector(0.2, -19.119, -15.891), angle = Angle(0.345, -90, 0), size = Vector(1.669, 1.669, 1.669)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "double_barrel", rel = "", pos = Vector(-0.25, -0.194, 2.255), angle = Angle(0, 180, 0), size = Vector(0.492, 0.492, 0.492)},
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	SWEP.CustomizationMenuScale = 0.01
	
end

SWEP.BarrelBGs = {main = 1, long = 1, short = 2, regular = 0}
SWEP.StockBGs = {main = 2, regular = 0, retractable = 0, none = 0, Stock = 1}

SWEP.MuzzleVelocity = 420-- in meter/s

SWEP.LuaViewmodelRecoilOverride = false
SWEP.CanRestOnObjects = false


SWEP.Attachments = {
    [1] = {header = "Sight", offset = {800, -500}, atts = {"md_rmr", "md_microt1", "md_aimpoint", "md_eotech"}},
    ["+reload"] = {header = "Ammo", offset = {0, 400}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"}}
}

SWEP.Animations = {reload = "reload1",
	fire = {"shoot1", "shoot2"},
	fire_dry = {"shoot_empty"},
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {
    draw = {
    {time = 0, sound = "CW_FOLEY_LIGHT"},
	{time = 0.52, sound = "CW_LYNXDB_RATTLE"}},
	
    draw_one_hand = {
    {time = 0, sound = "CW_FOLEY_LIGHT"}},
	
    reload_one_hand = {
	[1] = {time = 0.2, sound = "CW_LYNXDB_OUT1"},
	[2] = {time = 0.35, sound = "CW_LYNXDB_OPEN"},
	[3] = {time = 0.8, sound = "CW_LYNXDB_OUT"},
	[4] = {time = 0.8, sound = "CW_LYNXDB_OUT1"},
	[5] = {time = 0.85, sound = "CW_LYNXDB_OUT2"},
	[6] = {time = 1.7, sound = "CW_LYNXDB_IN"},
	[7] = {time = 1.75, sound = "CW_LYNXDB_BULLET_RELEASE"},
	[8] = {time = 2.1, sound = "CW_LYNXDB_IN2"},
	[9] = {time = 2.38, sound = "CW_LYNXDB_BULLET_RELEASE"},
	[10] = {time = 2.4, sound = "CW_LYNXDB_OUT1"},
	[11] = {time = 3.05, sound = "CW_LYNXDB_CLOSE"}},

    reload1 = {
	[1] = {time = 0.2, sound = "CW_LYNXDB_OUT1"},
	[2] = {time = 0.35, sound = "CW_LYNXDB_OPEN"},
	[3] = {time = 0.8, sound = "CW_LYNXDB_OUT"},
	[4] = {time = 0.8, sound = "CW_LYNXDB_OUT1"},
	[5] = {time = 0.85, sound = "CW_LYNXDB_OUT2"},
	[6] = {time = 1.7, sound = "CW_LYNXDB_IN"},
	[7] = {time = 1.88, sound = "CW_LYNXDB_BULLET_RELEASE"},
	[8] = {time = 2.05, sound = "CW_LYNXDB_IN2"},
	[9] = {time = 2.5, sound = "CW_LYNXDB_BULLET_RELEASE"},
	[10] = {time = 2.4, sound = "CW_LYNXDB_OUT1"},
	[11] = {time = 3.01, sound = "CW_LYNXDB_CLOSE"}}}

SWEP.SpeedDec = 5

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"break"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_pist_lyxn_dualb.mdl" 
SWEP.WorldModel		= "models/weapons/w_pist_lyxn_dualb.mdl"
SWEP.ADSFireAnim = true
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 2
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_LYNXDB"
SWEP.Recoil = 4

SWEP.ClumpSpread = 0.04

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.006
SWEP.VelocitySensitivity = 5
SWEP.MaxSpreadInc = 0.35
SWEP.SpreadPerShot = 0.3
SWEP.SpreadCooldown = 0.5
SWEP.Shots = 9
SWEP.Damage = 35
SWEP.DeployTime = 0.4
SWEP.Chamberable = false

SWEP.WearDamage = 0.33
SWEP.WearEffect = 0.005

SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 3.5
SWEP.ReloadHalt = 3.5

SWEP.ReloadTime_Empty = 3.5
SWEP.ReloadHalt_Empty = 3.5

SWEP.SnapToIdlePostReload = true

function SWEP:IndividualInitialize()
	self:setBodygroup( 1 , 2 )
end
