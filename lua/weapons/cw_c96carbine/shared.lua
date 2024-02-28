AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "C96 M1932"
	SWEP.CSMuzzleFlashes = true
	SWEP.UseHands = false
	
	SWEP.MuzzleEffect = "muzzleflash_ak47"
	SWEP.PosBasedMuz = false
	SWEP.SightWithRail = true
	
	SWEP.EffectiveRange_Orig = 135 * 39.37
	SWEP.DamageFallOff_Orig = .33
	
	SWEP.Shell = "khr763"
	SWEP.ShellScale = .78
	SWEP.ShellDelay = .0225
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -3.35, y = -2.75, z = -.25}
	SWEP.ForeGripOffsetCycle_Draw = .3
	SWEP.ForeGripOffsetCycle_Reload = .85
	SWEP.ForeGripOffsetCycle_Reload_Empty = .85

	SWEP.RMRPos = Vector(-2.3262, -2, 0.5502)
	SWEP.RMRAng = Vector(0.2202, 0.0439, 0)

	SWEP.IronsightPos = Vector(-2.3262, -2, 1.1502)
	SWEP.IronsightAng = Vector(0.2202, 0.0439, 0)
	
	SWEP.ShortBarrelPos = Vector(-2.3262, -2, 1.1502)
	SWEP.ShortBarrelAng = Vector(0.2202, 0.0439, 0)

	SWEP.SprintPos = Vector(2, 0, 0)
	SWEP.SprintAng = Vector(-15.478, 20.96, 0)
	
	SWEP.CustomizePos = Vector(8, -2, -1)
	SWEP.CustomizeAng = Vector(15, 45, 10)

	SWEP.AlternativePos = Vector(-0.75, 0, -0.2)
	SWEP.AlternativeAng = Vector(0.2202, 0.0439, -1)
	
	SWEP.SwimPos = Vector(0.5682, -1.7045, 1.0526)
	SWEP.SwimAng = Vector(-65.8947, 42.0455, -15.2273)
	
	SWEP.PronePos = Vector(0, 0, -3.1579)
	SWEP.ProneAng = Vector(-2, 22.7368, -28.9474)
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 1
	SWEP.DisableSprintViewSimulation = false
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0, hor = 0, roll = 1.45, forward = .5, pitch = .5}
	
	SWEP.ForegripOverridePos = {
	["penos"] = {
	["L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(1.25, -.1, .75), angle = Angle(0, 0, 0) },
	["L Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-10, 5, -15) },
	["L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-2, 4, 7) },
	["L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-12, -15, 10) },
	["L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(8, 6, 0) }},
	}

	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Slide", pos = Vector(0.03, 16, -0.7), angle = Angle(0, 180, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "Slide", pos = Vector(-0.34, -8.3, -4.6), angle = Angle(0, -90, 0), size = Vector(0.9, 0.9, 0.9)},
	}
	
	SWEP.OverallMouseSens = 1 -- 1 --  1 --  .8
	SWEP.M82AxisAlign = {right = .02, up = -.015, forward = 0}
	SWEP.CustomizationMenuScale = 0.021 --  0.0225
end

SWEP.MuzzleVelocity = 450

SWEP.BarrelBGs = {main = 2, off = 0, on = 1}
SWEP.MagBGs = {main = 3, off = 0, on = 1}

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.FullAimViewmodelRecoil = false
SWEP.CanRestOnObjects = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {200, -200}, atts = {"md_rmr"}},
[2] = {header = "Barrel Extension", offset = {-650, -450}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {-370, 70}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"base_fire_3","base_fire_2"},
	fire_aim = {"iron_fire_3","iron_fire_2"},
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
SWEP.FireModes = {"semi","auto"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""
SWEP.NearWallEnabled = false

SWEP.ViewModelFOV	= 65
SWEP.AimViewModelFOV = 67
SWEP.ZoomAmount = 10
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/doipack/c96c.mdl"
SWEP.WorldModel		= "models/khrcw2/doipack/w_c96c.mdl"

SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/khrcw2/doipack/w_c96c.mdl"
SWEP.WMPos = Vector(-1, 4, .3)
SWEP.WMAng = Vector(-10, 1, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ReloadViewBobEnabled = true
SWEP.RVBPitchMod = .5
SWEP.RVBYawMod = 0
SWEP.RVBRollMod = .5

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Chamberable			= true

SWEP.Primary.Ammo			= "7.62x25MM"

SWEP.WearDamage = 0.11
SWEP.WearEffect = 0.015

SWEP.FireDelay = 60/1100
SWEP.FireDelayAuto = 60/1100
SWEP.FireDelaySemi = 60/750
SWEP.FireSound = "DOIC96_FIRE"
SWEP.FireSoundSuppressed = "TT_FIRE_SUPPRESSED"
SWEP.Recoil = 1.3
SWEP.FOVPerShot = .15 -- = .5

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.010
SWEP.VelocitySensitivity = 8
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.012
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 33
SWEP.DeployTime = .5
SWEP.HolsterTime = .5

SWEP.ADSFireAnim = true
--SWEP.AimBreathingEnabled = true
--SWEP.AimBreathingIntensity = .65

SWEP.RecoilToSpread = 1
SWEP.RecoilToSpreadAuto = 1
SWEP.RecoilToSpreadSemi = -.25

SWEP.ReloadSpeed = 1.3
SWEP.ReloadTime = 2.3
SWEP.ReloadHalt = 3
SWEP.ReloadTime_Empty = 3.4
SWEP.ReloadHalt_Empty = 4.2

function SWEP:IndividualThink()
	
	if self.FireMode == "semi" then
	self.Owner.ViewAff = 0
	self.FOVPerShot = 0
	else
	self.FOVPerShot = .15
	end
	
	self.EffectiveRange = 135 * 39.37
	self.DamageFallOff = .33
	
	if self.ActiveAttachments.am_atow_light then
	self.EffectiveRange = ((self.EffectiveRange + 58 * 39.37))
end
	if self.ActiveAttachments.am_atow_heavy then
	self.DamageFallOff = ((self.DamageFallOff - .1))
end
	
	if self.ActiveAttachments.doi_atow_c96cshortbarrel then
	self.EffectiveRange = ((self.EffectiveRange - 15 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .02))
end
end

function SWEP:fireAnimFunc()
	clip = self:Clip1()
	cycle = 0
	rate = 1
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
