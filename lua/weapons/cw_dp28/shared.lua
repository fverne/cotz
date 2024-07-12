if ( !CustomizableWeaponry ) then return end
AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "DP-28"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SprintPos = Vector(7.719, -5.881, -4.64)
	SWEP.SprintAng = Vector(-9.4, 57.7, -17.701)
	
	SWEP.IronsightPos = Vector(-4.801, 0, 2.319)
	SWEP.IronsightAng = Vector(-1.4, -0.14, 0)
	
	SWEP.AimpointPos = Vector(-2.221, -6.1, -0.301)
	SWEP.AimpointAng = Vector(-0.068, 0.014, 0)
	
	SWEP.EoTechPos = Vector(-2.215, -5.803, -0.78)
	SWEP.EoTechAng = Vector(-0.069, 0.014, 0)
	
	SWEP.MicroT1Pos = Vector(-2.211, -6.271, -0.364)
	SWEP.MicroT1Ang = Vector(0, 0.005, 0)
	
	SWEP.CmorePos = Vector(-2.25, -5.823, -0.38)
	SWEP.CmoreAng = Vector(-1.13, -0.058, 0)
	
	SWEP.ReflexPos = Vector(-2.211, -5.823, -0.101)
	SWEP.ReflexAng = Vector(-1.13, 0.057, 0)
	
	SWEP.AlternativePos = Vector(-0.24, 0, -0.48)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 3, y = -6, z = -2}
	
	SWEP.BoltBone = "j_bolt"
	SWEP.BoltShootOffset = Vector(-3.6, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true
	
	SWEP.SightWithRail = true
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_ro2_dp28.mdl"
	SWEP.WMPos = Vector(-0.75, 4.0, 0.5)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.AttachmentModelsVM = {}
	
function SWEP:drawViewModel()
	if not self.CW_VM then
		return
	end

	local FT = FrameTime()
	
	self.LuaVMRecoilIntensity = math.Approach(self.LuaVMRecoilIntensity, 0, FT * 10 * self.LuaVMRecoilLowerSpeed)
	self.LuaVMRecoilLowerSpeed = math.Approach(self.LuaVMRecoilLowerSpeed, 1, FT * 2)
	
	self:drawGrenade()
	self:applyOffsetToVM()
	self:_drawViewModel()
	
	if self.BoneMod then
		for key,value in pairs(self.BoneMod) do
			self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone(key), value.scale)
			self.CW_VM:ManipulateBonePosition(self.CW_VM:LookupBone(key), value.pos)
			self.CW_VM:ManipulateBoneAngles(self.CW_VM:LookupBone(key), value.angle)
		end
	end

end
end

SWEP.LuaViewmodelRecoil = false
SWEP.ADSFireAnim = false
SWEP.BipodFireAnim = true

SWEP.Chamberable = false

SWEP.Attachments = {["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"shoot_1", "shoot_2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {	draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0, sound = "CW_DP28_RSTART"},
	[2] = {time = 0.955, sound = "CW_DP28_MAGOUT"},
	[3] = {time = 2.16, sound = "CW_DP28_MAGIN"},
	[4] = {time = 2.53, sound = "CW_DP28_MAGTAP"},
	[5] = {time = 3.45, sound = "CW_DP28_BOLT"}}}

SWEP.SpeedDec = 40

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
SWEP.ViewModel		= "models/weapons/v_pach_m249para.mdl"
SWEP.WorldModel		= "models/weapons/w_ro2_dp28.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 47
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x54MMR"

SWEP.WearDamage = 0.08
SWEP.WearEffect = 0.007

SWEP.FireDelay = 0.09166666666
SWEP.FireSound = "CW_DP28_FIRE"
SWEP.FireSoundSuppressed = "CW_PKM_SUPPRESSED"
SWEP.Recoil = 1.1
SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.006
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 190
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1.0
SWEP.ReloadTime = 3
SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt = 3.2
SWEP.ReloadHalt_Empty = 3.2
SWEP.SnapToIdlePostReload = false