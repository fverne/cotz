AddCSLuaFile()
AddCSLuaFile("sh_soundscript.lua")
include("sh_soundscript.lua")

		CustomizableWeaponry.shells:addNew("khr9x25", "models/khrcw2/doipack/shells/10x25mm.mdl", "CW_SHELL_SMALL")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MP34"
	SWEP.CSMuzzleFlashes = true
	SWEP.UseHands = false
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	SWEP.SightWithRail = true
	
	SWEP.EffectiveRange_Orig = 105 * 39.37
	SWEP.DamageFallOff_Orig = .43
	
	SWEP.Shell = "khr9x25"
	SWEP.ShellScale = .78
	SWEP.ShellDelay = .075
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2.75, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = .85
	SWEP.ForeGripOffsetCycle_Reload_Empty = .85

	SWEP.IronsightPos = Vector(-2.599, -1, 1.96)
	SWEP.IronsightAng = Vector(0.1, 0.056, 9)
	
	SWEP.SprintPos = Vector(2, 0, -1)
	SWEP.SprintAng = Vector(-15.478, 20.96, -15)
	
	SWEP.CustomizePos = Vector(10, -4, -2)
	SWEP.CustomizeAng = Vector(20, 45, 12)

	SWEP.AlternativePos = Vector(-.6, 1.5, .5)
	SWEP.AlternativeAng = Vector(0, -1, 9)
	
	SWEP.SwimPos = Vector(0.5682, -1.7045, 1.0526)
	SWEP.SwimAng = Vector(-30.8947, 33.0455, -10.2273)
	
	SWEP.PronePos = Vector(0, 0, -2.1579)
	SWEP.ProneAng = Vector(-2, 12.7368, -8.9474)

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = .9
	SWEP.DisableSprintViewSimulation = false
	
	
	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Weapon", pos = Vector(-3.57, 16, 1), angle = Angle(0, 180, 0), size = Vector(1, 1, 1)},
	}

	SWEP.ForegripOverridePos = {
	["nah"] = {
	["L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-3, -.34, -2.1), angle = Angle(0, 0, -5) },
	["L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-2, 10, 2) },
	["L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-5, -5, 0) },
	["L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }},
}
	
	SWEP.CustomizationMenuScale = 0.019 --  0.0195
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0, hor = 0, roll = .25, forward = .3, pitch = .25}
end

SWEP.MagBGs = {main = 2, twenty = 0, thirty = 1}

SWEP.MuzzleVelocity = 425

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.FullAimViewmodelRecoil = true
SWEP.CanRestOnObjects = true
--SWEP.AimBreathingEnabled = true
--SWEP.AimBreathingIntensity = .75

SWEP.Attachments = {[2] = {header = "Barrel Extension", offset = {-650, -450}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {-370, 70}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"base_fire"},
	fire_aim = {"iron_fire"},
	fire_last = {"base_firelast"},
	fire_last_aim = {"iron_firelast"},
	reload = "base_reload",
	reload_empty = "base_reloadempty",
	idle = "base_idle",
	draw = "base_draw"}
	

SWEP.SpeedDec = 5

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto","semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""
SWEP.NearWallEnabled = false

SWEP.ViewModelFOV	= 65
SWEP.AimViewModelFOV = 67
SWEP.ZoomAmount = 15
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/doipack/mp34.mdl"
SWEP.WorldModel		= "models/khrcw2/doipack/w_mp34.mdl"

SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/khrcw2/doipack/w_mp34.mdl"
SWEP.WMPos = Vector(-1.2, 7.5, -.5)
SWEP.WMAng = Vector(-12, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ReloadViewBobEnabled = true
SWEP.RVBPitchMod = .4
SWEP.RVBYawMod = 0
SWEP.RVBRollMod = .5

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= true
SWEP.Chamberable			= true

SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 60/700
SWEP.FireDelayAuto = 60/700
SWEP.FireDelaySemi = 60/780
SWEP.FireSound = "DOIMP40_FIRE"
SWEP.FireSoundSuppressed = "DOIMP40_FIRE_SUPPRESSED"
SWEP.Recoil = 1.4
SWEP.FOVPerShot = 0.05 -- = .6

SWEP.WearDamage = 0.11
SWEP.WearEffect = 0.015

SWEP.HipSpread = 0.065
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.08
SWEP.SpreadPerShot = 0.012
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 46
SWEP.DeployTime = .4
SWEP.HolsterTime = .5
SWEP.ADSFireAnim = true
SWEP.BurstCooldownMul = 3

SWEP.RecoilToSpread = .77

SWEP.ReloadSpeed = 1.325
SWEP.ReloadTime = 2.5
SWEP.ReloadHalt = 3.6
SWEP.ReloadTime_Empty = 3.5
SWEP.ReloadHalt_Empty = 4.6	

SWEP.NearWallEnabled = false

function SWEP:IndividualThink()
	if self.dt.BipodDeployed then
		self.ForegripOverride = true
		self.ForegripParent = "bipod"
	else
		self.ForegripOverride = true
		self.ForegripParent = "nah"
	end
	
	if self.FireMode == "semi" then
	self.Owner.ViewAff = 0
	end
	
	self.FireDelay = (self.FireMode == "3burst") and self.FireDelaySemi or self.FireDelayAuto
	
	self.EffectiveRange = 105 * 39.37
	self.DamageFallOff = .43
	
				if self.ActiveAttachments.am_atow_light then
	self.EffectiveRange = ((self.EffectiveRange + 42 * 39.37))
end
	if self.ActiveAttachments.am_atow_heavy then
	self.DamageFallOff = ((self.DamageFallOff - .129))
end
	
	if self.ActiveAttachments.doi_atow_stensuppressor then
	self.EffectiveRange = ((self.EffectiveRange - 10 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .05))
end
end

function SWEP:fireAnimFunc()
	clip = self:Clip1()
	cycle = 0
	rate = 1.1
	anim = "safe"
	prefix = ""
	suffix = ""
	
		if clip == 1 then
		suffix = suffix .. "_last"
	end
	
	if self:isAiming() then
		suffix = suffix .. "_aim"
		cycle = self.ironFireAnimStartCycle
	end
	
	self:sendWeaponAnim(prefix .. "fire" .. suffix, rate, cycle)
end //*/

local simpleTextColor = Color(255, 210, 0, 255)
local mod = 25

function SWEP:Holster(wep)
	-- can't switch if neither the weapon we want to switch to or the wep we're trying to switch to are not valid
	if not IsValid(wep) and not IsValid(self.SwitchWep) then
		self.SwitchWep = nil
		return false
	end
	
	local CT = CurTime()
	
	-- can't holster if we have a global delay on the weapon
	if CT < self.GlobalDelay or CT < self.HolsterWait then
		self.dt.HolsterDelay = CurTime() + self.HolsterTime
		self.dt.State = CW_HOLSTER_START
		self.dt.HolsterDelay = 0
	end
	
	if self.dt.HolsterDelay ~= 0 and CT < self.dt.HolsterDelay then
		return false
	end
	
	-- can't holster if there are sequenced actions
	if #self._activeSequences > 0 then
		return false
	end
	
	if self.ReloadDelay then
		self.dt.HolsterDelay = CurTime() + self.HolsterTime
		self.dt.State = CW_HOLSTER_START
		self.dt.HolsterDelay = 0
	end
	
	if self.dt.State ~= CW_HOLSTER_START then
		self.dt.HolsterDelay = CurTime() + self.HolsterTime
	end
	
	self.dt.State = CW_HOLSTER_START
	
	-- if holster sequence is over, let us select the desired weapon
	if self.SwitchWep and self.dt.State == CW_HOLSTER_START and CurTime() > self.dt.HolsterDelay then
		self.dt.State = CW_IDLE
		self.dt.HolsterDelay = 0
		
		return true
	end
	
	-- if it isn't, make preparations for it
	self.ShotgunReloadState = 0
	self.ReloadDelay = nil
	
	if self:filterPrediction() then
		if self.holsterSound then -- quick'n'dirty prediction fix
			self:EmitSound("CW_HOLSTER", 70, 100)
			self.holsterSound = false
			
			if IsFirstTimePredicted() then
				if self.holsterAnimFunc then
					self:holsterAnimFunc()
				else
					if self.Animations.holster then
						self:sendWeaponAnim("holster")
					end
				end
			end
		end
	end
	
	self.SwitchWep = wep
	self.SuppressTime = nil
	
	if self.dt.M203Active then
		if SERVER and SP then
			SendUserMessage("CW20_M203OFF", self.Owner)
		end
		
		if CLIENT then
			self:resetM203Anim()
		end
	end

	self.dt.M203Active = false
end
