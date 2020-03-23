if CustomizableWeaponry then


AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "SVT-40"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 0.7
	
	SWEP.IconLetter = "w"
	killicon.Add("cw_ber_svt40", "weaponicons/svt40-k", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "ber_rifle_med"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.5
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 1, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0.4
	SWEP.ForeGripOffsetCycle_Reload = 0.74
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.88
	SWEP.FireMoveMod = 1
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_svt40.mdl"
	SWEP.WMPos = Vector(0.3, -14, 0)
	SWEP.WMAng = Vector(-10, 180, 180)
	
	SWEP.IronsightPos = Vector(-3.475, 0, 0.82)
	SWEP.IronsightAng = Vector(0.301, 0, -0.419)
	
	SWEP.PSOPos = Vector(-3.195, -4, -0.07)
	SWEP.PSOAng = Vector(0.301, 0, -0.419)
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 89.581}
	
	SWEP.SprintPos = Vector(0.07, -9.395, -5.41)
	SWEP.SprintAng = Vector(30.716, 43.631, 0)

	SWEP.AlternativePos = Vector(-0.514, -1.196, -0.482)
	SWEP.AlternativeAng = Vector(0, 1.554, -0.631)
	
	SWEP.CustomizePos = Vector(2.69, -3.198, -1.821)
	SWEP.CustomizeAng = Vector(9.949, 26.347, 8.168)

    SWEP.BaseArm = "L_Arm_Controller"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.024
	SWEP.SightWithRail = true

	SWEP.AttachmentModelsVM = {
	    ["md_pso1"] = {model = "models/cw2/attachments/pso.mdl", bone = "body", pos = Vector(0.15, -0.371, -1.678), angle = Angle(0, 180, 0), size = Vector(0.759, 0.759, 0.759)},		
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "body", pos = Vector(-0.008, 27.763, -0.597), angle = Angle(0, 180, 0), size = Vector(0.755, 0.755, 0.755)},
	}
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
	
end

SWEP.BoltBone = "bolt"
SWEP.BoltShootOffset = Vector(-2, 0, 0)
SWEP.BoltBonePositionRecoverySpeed = 20

SWEP.LuaViewmodelRecoil = false


SWEP.Attachments = {[1] = {header = "Sights", offset = {500, 100}, atts = {"md_pso1"}},
	[2] = {header = "Muzzle", offset = {0, -200}, atts = {"md_pbs1"}},
	["+reload"] = {header = "Ammo", offset = {-300, 300}, atts = {"am_zoneloaded", "am_matchgrade"}},
	}

SWEP.Animations = {fire = {"shoot", "shoot2"},
	reload = "reload_full",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "first_draw"}
	
SWEP.Sounds = {first_draw = {{time = 0, sound = "CW_BER_SVT40_DRAW"}, 
    {time = 0.7, sound = "CW_BER_SVT40_BOLTPULL"}},
	
	reload_full = {{time = 0.1, sound = "CW_FOLEY_LIGHT"},
	{time = 0.5, sound = "CW_BER_SVT40_MAGOUT"},
	{time = 1, sound = "CW_FOLEY_LIGHT"},
	{time = 1.7, sound = "CW_BER_SVT40_MAGIN"},
	{time = 2, sound = "CW_FOLEY_LIGHT"}},
	
	reload_empty = {{time = 0.1, sound = "CW_FOLEY_LIGHT"},
	{time = 0.5, sound = "CW_BER_SVT40_MAGOUT"},
	{time = 1, sound = "CW_FOLEY_LIGHT"},
	{time = 1.7, sound = "CW_BER_SVT40_MAGIN"},
	{time = 2.2, sound = "CW_FOLEY_LIGHT"},
	{time = 2.7, sound = "CW_BER_SVT40_MAGSLAP"},
	{time = 3.4, sound = "CW_BER_SVT40_BOLTBACK"},
	{time = 3.65, sound = "CW_BER_SVT40_BOLTFORWARD"},
	{time = 3.5, sound = "CW_FOLEY_LIGHT"}}}

SWEP.SpeedDec = 50

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "some faggot & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_dber_svt40.mdl"
SWEP.WorldModel		= "models/weapons/w_svt40.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x54MMR"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_BER_SVT40_FIRE"
SWEP.FireSoundSuppressed = "CW_BER_SVT40_FIRE_SUPPRESSED"
SWEP.Recoil = 2.5

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 118
SWEP.DeployTime = 1.5

SWEP.WearDamage = 0.1
SWEP.WearEffect = 0.05

SWEP.RecoilToSpread = 0.8 -- the M14 in particular will have 30% more recoil from continuous fire to give a feeling of "oh fuck I should stop firing 7.62x51MM in full auto at 750 RPM"

SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 2.8
SWEP.ReloadTime_Empty = 4.3
SWEP.ReloadHalt = 2.8
SWEP.ReloadHalt_Empty = 4.4

SWEP.SnapToIdlePostReload = false


end