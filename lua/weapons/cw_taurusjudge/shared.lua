AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Taurus Judge"
	SWEP.CSMuzzleFlashes = true
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.85
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.85

	SWEP.SightWithRail = true
	SWEP.IconLetter = "y"
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/cwc_judge/w_khri_410jury.mdl"

	SWEP.WMPos = Vector(-1.2, 3.5, 1)
	SWEP.WMAng = Vector(-5, 0, 180)
	
	SWEP.MuzzleEffect = "muzzleflash_pistol_deagle"
	SWEP.PosBasedMuz = true
	SWEP.NoShells = true
		
	SWEP.IronsightPos = Vector(-1.844, 1, 0.897)
	SWEP.IronsightAng = Vector(-1.56, 0.03, 0)
	
	SWEP.MicroT1Pos = Vector(-1.866, 1, -0.3)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-1.844, -1.5, -0.25)
	SWEP.ShortDotAng = Vector(-1.56, 0.03, 0)
	
	SWEP.JudgeLongPos = Vector(-1.844, 1, 0.818)
	SWEP.JudgeLongAng = Vector(-1.1, 0.03, 0)
	
	SWEP.JudgeLongerPos = Vector(-1.844, 1, 0.785)
	SWEP.JudgeLongerAng = Vector(-0.8, 0.03, 0)

	SWEP.CustomizePos = Vector(3.488, -2.627, -0.821)
	SWEP.CustomizeAng = Vector(17.009, 29.971, 16.669)
	
	SWEP.SprintPos = Vector(1, -2, -5)
	SWEP.SprintAng = Vector(30, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.4, 1, -0.5)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 1
	SWEP.BoltBone = "hammer"
	SWEP.BoltShootOffset = Vector(0, -.25, 0)
	SWEP.BoltBonePositionRecoverySpeed = 3
	SWEP.FullAimViewmodelRecoil = true
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.CustomizationMenuScale = 0.008
	SWEP.DisableSprintViewSimulation = true
	SWEP.ReticleInactivityPostFire = 0.3

end


SWEP.MoveType = 1
SWEP.MuzzleVelocity = 600 -- in meter/s

SWEP.MagBGs = {main = 2, shell2 = 1, shell = 0}
SWEP.BarrelBGs = {main = 1, one = 0, two = 1, three = 2}

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.FullAimViewmodelRecoil = true
SWEP.LuaVMRecoilAxisMod = {vert = -0.1, hor = 1, roll = 2, forward = -0.5, pitch = 1.5} -- modifier for intensity of the recoil on varying axes
SWEP.ADSFireAnim = true

SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -700}, atts = {"md_microt1"}},
["+reload"] = {header = "Ammo", offset = {800, -200}, atts = {"am_hollowpoint", "am_armorpiercing", "am_410buck"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CWC_JUDGE_DRAW"},
	{time = 0.0, sound = "CWC_JUDGE_IN"},
	{time = 0.7, sound = "CWC_JUDGE_CLICK"}},

	reload = {{time = 0, sound = "CWC_FOLEY_MEDIUM"},
	{time = 0.25, sound = "CWC_JUDGE_OUT"},
	{time = 0.5, sound = "CWC_FOLEY_TOSS"},
	{time = 0.8, sound = "CWC_JUDGE_EJECT"},
	{time = 1.2, sound = "CWC_JUDGE_CLICK"},
	{time = 1.25, sound = "CWC_SHELL_SMALL"},
	{time = 1.38, sound = "CWC_SHELL_SMALL"},
	{time = 1.49, sound = "CWC_SHELL_SMALL"},
	{time = 1.6, sound = "CWC_FOLEY_LIGHT"},
	{time = 2.5, sound = "CWC_JUDGE_INSERT"},
	{time = 3.1, sound = "CWC_FOLEY_TOSS"},
	{time = 3.25, sound = "CWC_JUDGE_IN"},
	{time = 3.7, sound = "CWC_FOLEY_TOSS"},
	{time = 3.8, sound = "CWC_MAG_DROP_REVOLVER"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "pistol"
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"double"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 80
SWEP.ViewModelFlip	= false
SWEP.OverallMouseSens = 1
SWEP.ViewModel		= "models/weapons/cwc_judge/v_khri_410jury.mdl"
SWEP.WorldModel		= "models/weapons/cwc_judge/w_khri_410jury.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".45 ACP"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CWC_JUDGE_FIRE"
SWEP.Recoil = 3.5

SWEP.HipSpread = 0.075
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.04
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 95
SWEP.DeployTime = 0.5
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1.3
SWEP.ReloadTime = 2.7
SWEP.ReloadHalt = 4

SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt_Empty = 4

SWEP.WearDamage = 0.14
SWEP.WearEffect = 0.05

SWEP.SoundLayer1 = Sound("CWC_JUDGE_CLICK")
SWEP.SoundLayer2 = Sound("CWC_JUDGE_IN")

function SWEP:IndividualInitialize()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.two)
end

function SWEP:fireAnimFunc()
	clip = self:Clip1()
	cycle = 0.05
	rate = 0.9
	anim = "fire"
	prefix = ""
	suffix = ""	
	self:EmitSound(self.SoundLayer1)
	
	
	if self:isAiming() then
	clip = self:Clip1()
	cycle = 0.3
	rate = 0.7
	anim = "fire"
	prefix = ""
	suffix = ""
	self:EmitSound(self.SoundLayer1)
	self:EmitSound(self.SoundLayer2)
	end
	
	self:sendWeaponAnim(prefix .. "fire" .. suffix, rate, cycle)
end //*/

function SWEP:IndividualThink()
	if self:isAiming() then
		self.Recoil = 5
		self.SpreadCooldown = 0.1
	   if self.ActiveAttachments.md_schmidt_shortdot then
	   	self.LuaVMRecoilAxisMod = {vert = 0, hor = 0.5, roll = 1, forward = -0.5, pitch = 1}
	   else
		self.LuaVMRecoilAxisMod = {vert = 0, hor = 0.5, roll = 1, forward = -0.3, pitch = -0.3}
		end
	else
		self.Recoil = 4
		self.SpreadCooldown = 0.18
		self.LuaVMRecoilAxisMod = {vert = -0.1, hor = 1, roll = 2, forward = 0.5, pitch = -1.5}
	end
	
		
if self.ActiveAttachments.am_410buck then
	    self.MuzzleVelocity = 259
	self:setBodygroup(self.MagBGs.main, self.MagBGs.shell)
	self.FireSound = "CWC_JUDGE_FIRE"
	self.MuzzleEffect = "muzzleflash_shotgun"
self.Sounds = {draw = {{time = 0, sound = "CWC_JUDGE_DRAW"},
	{time = 0.0, sound = "CWC_JUDGE_IN"},
	{time = 0.7, sound = "CWC_JUDGE_CLICK"}},

	reload = {{time = 0, sound = "CWC_FOLEY_MEDIUM"},
	{time = 0.25, sound = "CWC_JUDGE_OUT"},
	{time = 0.5, sound = "CWC_FOLEY_TOSS"},
	{time = 0.8, sound = "CWC_JUDGE_EJECT"},
	{time = 1.2, sound = "CWC_JUDGE_CLICK"},
	{time = 1.25, sound = "CWC_SHELL_SHOT"},
	{time = 1.38, sound = "CWC_SHELL_SHOT"},
	{time = 1.49, sound = "CWC_SHELL_SHOT"},
	{time = 1.6, sound = "CWC_FOLEY_LIGHT"},
	{time = 2.5, sound = "CWC_JUDGE_INSERT"},
	{time = 3.1, sound = "CWC_FOLEY_TOSS"},
	{time = 3.25, sound = "CWC_JUDGE_IN"},
	{time = 3.7, sound = "CWC_FOLEY_TOSS"},
	{time = 3.8, sound = "CWC_MAG_DROP_REVOLVER"}}}


	else
    self.MuzzleVelocity = 680
	self:setBodygroup(self.MagBGs.main, self.MagBGs.shell2)
	self.FireSound = "CWC_JUDGE_FIRE_SLUG"
	self.MuzzleEffect = "muzzleflash_pistol_deagle"
	self.Sounds = {draw = {{time = 0, sound = "CWC_JUDGE_DRAW"},
		{time = 0.0, sound = "CWC_JUDGE_IN"},
		{time = 0.7, sound = "CWC_JUDGE_CLICK"}},
	
		reload = {{time = 0, sound = "CWC_FOLEY_MEDIUM"},
		{time = 0.25, sound = "CWC_JUDGE_OUT"},
		{time = 0.5, sound = "CWC_FOLEY_TOSS"},
		{time = 0.8, sound = "CWC_JUDGE_EJECT"},
		{time = 1.2, sound = "CWC_JUDGE_CLICK"},
		{time = 1.25, sound = "CWC_SHELL_SMALL"},
		{time = 1.38, sound = "CWC_SHELL_SMALL"},
		{time = 1.49, sound = "CWC_SHELL_SMALL"},
		{time = 1.6, sound = "CWC_FOLEY_LIGHT"},
		{time = 2.5, sound = "CWC_JUDGE_INSERT"},
		{time = 3.1, sound = "CWC_FOLEY_TOSS"},
		{time = 3.25, sound = "CWC_JUDGE_IN"},
		{time = 3.7, sound = "CWC_FOLEY_TOSS"},
		{time = 3.8, sound = "CWC_MAG_DROP_REVOLVER"}}}
		
	end
end