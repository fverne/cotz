AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1928A1"
	SWEP.CSMuzzleFlashes = true
	SWEP.UseHands = false
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = true
	SWEP.SightWithRail = true
	
	SWEP.EffectiveRange_Orig = 130 * 39.37
	SWEP.DamageFallOff_Orig = .7
	
	SWEP.Shell = "khr9x19"
	SWEP.ShellScale = .51
	SWEP.ShellDelay = .05
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 5.35, y = -3.5, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = .825
	SWEP.ForeGripOffsetCycle_Reload_Empty = .825
	
	SWEP.IronsightPos = Vector(-2.236, -2.25, 1.048)
	SWEP.IronsightAng = Vector(0.1611, 0.0052, 0)
	
	SWEP.CustomizePos = Vector(10, -4, -2)
	SWEP.CustomizeAng = Vector(20, 45, 15)
	
	SWEP.SprintPos = Vector(2, 0, -1)
	SWEP.SprintAng = Vector(-15.478, 20.96, -15)

	SWEP.AlternativePos = Vector(-.6, .25, -0.45)
	SWEP.AlternativeAng = Vector(0.1611, 0.0052, 0)
	
	SWEP.Alternative1Pos = Vector(-.6, .25, -0.45)
	SWEP.Alternative1Ang = Vector(0.1611, 0.0052, 0)
	
	SWEP.Alternative2Pos = Vector(-.8, -1.2, -0.65)
	SWEP.Alternative2Ang = Vector(0.1611, 0.0052, -3)
	
	SWEP.SwimPos = Vector(0.5682, -1.7045, 1.0526)
	SWEP.SwimAng = Vector(-50.8947, 35.0455, -25.2273)
	
	SWEP.PronePos = Vector(0, -2, -4.5)
	SWEP.ProneAng = Vector(-10, 42.7368, -50.9474)
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = .9
	SWEP.DisableSprintViewSimulation = false
	
	SWEP.CustomizationMenuScale = 0.019 --  0.022

	SWEP.AttachmentModelsVM = {["md_cobram2"] = {model = "models/cw2/attachments/cobra_m2.mdl", bone = "M1928A1", pos = Vector(0, 17, 1.33), angle = Angle(0, 90, 0), size = Vector(1.3, 1.3, 1.3), color = Color(255, 255, 255, 255)}}

	SWEP.ForegripOverridePos = {
	["foregrip"] = {
	["L Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 14.444, 0) },
	["L ForeTwist2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 8.332) },
	["L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(.25, -0.301, .4), angle = Angle(-1.111, 3.332, 3.332) },
	["L Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(16.666, -10.111, 61.111) },
	["L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-5.557, 5.556, 16.666) },
	["L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(23.333, 10, 1.11) },
	["L Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 58.888, 0) },
	["L Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 36.666, 0) },
	["L Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 7.777, 0) },
	["L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 45.555, 0) },
	["L Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 16.666, 0) },
	["L ForeTwist4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 6) },
	["L ForeTwist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 2.444) },
	["L ForeTwist1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 15) },
	["L ForeTwist5"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 12) }},
	
	["nah"] = {
	["L Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L ForeTwist2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-.25, 0, 0), angle = Angle(0, 0, 0) },
	["L Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-5, -5, 0) },
	["L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 2, 0) },
	["L Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L ForeTwist4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L ForeTwist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L ForeTwist1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L ForeTwist3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }},
}
	
	SWEP.LuaVMRecoilAxisMod = {vert = -.15, hor = .15, roll = .2, forward = .3, pitch = .2}
end

SWEP.MuzzleVelocity = 250

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.FullAimViewmodelRecoil = false
SWEP.CanRestOnObjects = true

SWEP.GripBGs = {main = 2, off = 0, on = 1}
SWEP.MagBGs = {main = 3, twenty = 0, thirty = 1, fifty = 2}
SWEP.BarrelBGs = {main = 5, smg = 0, carbine = 1}
SWEP.StockBGs = {main = 4, off = 0, on = 1}

SWEP.Attachments = {[2] = {header = "Barrel Extension", offset = {-650, -450}, atts = {"md_cobram2"}},
["+reload"] = {header = "Ammo", offset = {-370, 70}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"base_fire_1"},
	fire_aim = {"iron_fire_1","iron_fire_2"},
	reload = "base_reload",
	reload_empty = "base_reload",
	idle = "base_idle",
	draw = "base_draw"}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "crossbow"
SWEP.FireModes = {"auto","semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""
SWEP.NearWallEnabled = true

SWEP.ViewModelFOV	= 67
SWEP.AimViewModelFOV = 65
SWEP.ZoomAmount = 10
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/doipack/thompson1928.mdl"
SWEP.WorldModel		= "models/khrcw2/doipack/w_thompson1928.mdl"

SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/khrcw2/doipack/w_thompson1928.mdl"
SWEP.WMPos = Vector(-.9, 4, 1.5)
SWEP.WMAng = Vector(-10, 1, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ReloadViewBobEnabled = true
SWEP.RVBPitchMod = .4
SWEP.RVBYawMod = 0
SWEP.RVBRollMod = .5

SWEP.Primary.ClipSize		= 50
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Chamberable			= false

SWEP.Primary.Ammo			= ".45 ACP"

SWEP.FireDelay = 60/750
SWEP.FireDelayAuto = 60/750
SWEP.FireDelaySemi = 60/700
SWEP.FireSound = "DOITHOM1928_FIRE"
SWEP.FireSoundSuppressed = "DOITHOM1928_FIRE_SUPPRESSED"
SWEP.Recoil = 1.45
SWEP.FOVPerShot = 0.1 -- = .62

SWEP.HipSpread = 0.056
SWEP.AimSpread = 0.016
SWEP.VelocitySensitivity = .4
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.013
SWEP.SpreadCooldown = 0.175
SWEP.Shots = 1
SWEP.Damage = 68
SWEP.DeployTime = .462
SWEP.HolsterTime = .6

SWEP.ADSFireAnim = true

SWEP.RecoilToSpread = .35


SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 2.4
SWEP.ReloadHalt = 3.2
SWEP.ReloadTime_Empty = 2.4
SWEP.ReloadHalt_Empty = 3.2

function SWEP:IndividualInitialize()
	self:setBodygroup(self.GripBGs.main, self.GripBGs.on)
	self.ForegripOverride = true
	self.ForegripParent = "foregrip"

	self:setBodygroup(self.MagBGs.main, self.MagBGs.fifty)

	self.Animations = {fire = {"base_fire_1"},
	fire_aim = {"iron_fire_1","iron_fire_2"},
	fire_last = {"base_firelast"},
	fire_last_aim = {"iron_firelast"},
	reload = "base_reload_drum",
	reload_empty = "base_reload_drum",
	idle = "base_idle",
	draw = "base_draw"}
	self.ReloadTime = 3.8
	self.ReloadHalt = 5.3
	self.ReloadTime_Empty = 3.8
	self.ReloadHalt_Empty = 5.3

	self.AlternativePos = self.Alternative1Pos
	self.AlternativeAng = self.Alternative1Ang
	
	self.EffectiveRange = 130 * 39.37
	self.DamageFallOff = .7

	self:setBodygroup(self.StockBGs.main, self.StockBGs.off)

end

function SWEP:IndividualThink()

	if self.FireMode == "semi" then
		self.Owner.ViewAff = 0
	end

	

end

function SWEP:fireAnimFunc()
	clip = self:Clip1()
	cycle = 0
	rate = 1
	anim = "safe"
	prefix = ""
	suffix = ""
	
	if self:isAiming() then
		suffix = suffix .. "_aim"
		cycle = self.ironFireAnimStartCycle
	end
	
	self:sendWeaponAnim(prefix .. "fire" .. suffix, rate, cycle)
end //*/

local simpleTextColor = Color(255, 210, 0, 255)
local mod = 25

function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
	if self.SelectIcon then
		surface.SetTexture(self.SelectIcon)
		
		wide = wide - mod
		
		x = x + (mod / 2)
		y = y + (mod / 4) + (wide / 8)
		
		surface.SetDrawColor(255, 255, 255, alpha)
		
		surface.DrawTexturedRect(x, y, wide, (wide / 2))
	else
		simpleTextColor.a = alpha
		draw.SimpleText(self.IconLetter, self.SelectFont, x + wide / 2, y + tall * 0.2, simpleTextColor, TEXT_ALIGN_CENTER)
	end
end

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