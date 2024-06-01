AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

		CustomizableWeaponry.shells:addNew("khr9x19", "models/khrcw2/doipack/shells/45acp.mdl", "CW_SHELL_SMALL")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MP40"
	SWEP.CSMuzzleFlashes = true
	SWEP.UseHands = false
	
	SWEP.SelectIcon = surface.GetTextureID("vgui/inventory/weapon_mp40")
	killicon.Add( "doi_atow_mp40", "vgui/inventory/killicons/weapon_mp40", Color(255, 80, 0, 0))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	SWEP.SightWithRail = true
	
	SWEP.EffectiveRange_Orig = 110 * 39.37
	SWEP.DamageFallOff_Orig = .35
	
	SWEP.Shell = "khr9x19"
	SWEP.ShellScale = .75
	SWEP.ShellDelay = .035
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 3.25, y = -4, z = -.5}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = .72
	SWEP.ForeGripOffsetCycle_Reload_Empty = .85

	SWEP.IronsightPos = Vector(-2.5062, -3, 0.5482)
	SWEP.IronsightAng = Vector(0.2105, 0.0425, 0)

	SWEP.SprintPos = Vector(2, 0, -1)
	SWEP.SprintAng = Vector(-15.478, 20.96, -15)
	
	SWEP.CustomizePos = Vector(9, -4, -2.5)
	SWEP.CustomizeAng = Vector(20, 40, 15)

	SWEP.AlternativePos = Vector(-0.55, 0, -0.84)
	SWEP.AlternativeAng = Vector(0.2105, 0.0425, 0)
	
	SWEP.SwimPos = Vector(0.5682, -1.7045, 1.0526)
	SWEP.SwimAng = Vector(-40.8947, 45.0455, 15.2273)
	
	SWEP.PronePos = Vector(0, 0, -5.1579)
	SWEP.ProneAng = Vector(-10, 32.7368, -50.9474)

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = .9
	SWEP.DisableSprintViewSimulation = false
	
	SWEP.CustomizationMenuScale = 0.021 --  0.025
	
	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Weapon", pos = Vector(0, 21, 0.3), angle = Angle(0, 180, 0), size = Vector(1, 1, 1)},
	}
	
	SWEP.ForegripOverridePos = {
	["nah"] = {
	["L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-.45, -1.25, .75), angle = Angle(5, 5, 0) },
	["L Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-1, 6, 0) },
	["L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }},
}

	SWEP.M82AxisAlign = {right = .02, up = -.015, forward = 0}
	SWEP.AP2XAxisAlign = {right = .025, up = .05, forward = 0}
	SWEP.PO42PAxisAlign = {right = .105, up = 0, forward = 0}
	SWEP.INS2AxisAlign = {right = .02, up = 0, forward = 0}
	SWEP.LuaVMRecoilAxisMod = {vert = 0, hor = 0, roll = .25, forward = .5, pitch = 0}
end

SWEP.ReloadViewBobEnabled = true

SWEP.MuzzleVelocity = 365

SWEP.SlingBGs = {main = 2, off = 0, on = 1}

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.FullAimViewmodelRecoil = true
SWEP.CanRestOnObjects = true
--SWEP.AimBreathingEnabled = true
--SWEP.AimBreathingIntensity = .75

SWEP.Attachments = {[2] = {header = "Barrel Extension", offset = {-650, -450}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {-370, 70}, atts = {"am_hollowpoint", "am_armorpiercing"}}}


SWEP.Animations = {fire = {"base_fire"},
	fire_aim = {"iron_fire_a"},
	fire_last = {"base_firelast"},
	fire_last_aim = {"base_firelast"},
	reload = "base_reload",
	reload_empty = "base_reloadempty",
	idle = "base_idle",
	draw = "base_draw"}
	

SWEP.SpeedDec = 10

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "smg"
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""
SWEP.NearWallEnabled = false

SWEP.ViewModelFOV	= 65
SWEP.AimViewModelFOV = 65
SWEP.ZoomAmount = 15
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/doipack/mp40.mdl"
SWEP.WorldModel		= "models/khrcw2/doipack/w_mp40.mdl"

SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/khrcw2/doipack/w_mp40.mdl"
SWEP.WMPos = Vector(-1.5, 3.75, 1)
SWEP.WMAng = Vector(-5, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ReloadViewBobEnabled = true
SWEP.RVBPitchMod = 1
SWEP.RVBYawMod = 1
SWEP.RVBRollMod = 1

SWEP.Primary.ClipSize		= 32
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Chamberable			= false

SWEP.Primary.Ammo			= "9x19MM"

SWEP.WearEffect = 0.08
SWEP.WearEffect = 0.007

SWEP.FireDelay = 60/535
SWEP.FireSound = "DOIMP40_FIRE"
SWEP.FireSoundSuppressed = "DOIMP40_FIRE_SUPPRESSED"
SWEP.Recoil = 2.9
SWEP.FOVPerShot = 0 -- = .6

SWEP.HipSpread = 0.125
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.55
SWEP.SpreadPerShot = 0.011
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 46
SWEP.DeployTime = .5
SWEP.HolsterTime = .5

SWEP.ADSFireAnim = true

SWEP.RecoilToSpread = .2

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 2.225
SWEP.ReloadHalt = 2.8
SWEP.ReloadTime_Empty = 4
SWEP.ReloadHalt_Empty = 4.4

function SWEP:IndividualThink()

	if self.dt.BipodDeployed then
		self.ForegripOverride = true
		self.ForegripParent = "bipod"
	else
		self.ForegripOverride = true
		self.ForegripParent = "nah"
	end
	
	self.EffectiveRange = 110 * 39.37
	self.DamageFallOff = .35
	
	if self.ActiveAttachments.am_atow_light then
	self.EffectiveRange = ((self.EffectiveRange + 45 * 39.37))
end
	if self.ActiveAttachments.am_atow_heavy then
	self.DamageFallOff = ((self.DamageFallOff - .105))
end
	
	if self.ActiveAttachments.doi_atow_unisuppressor then
	self.EffectiveRange = ((self.EffectiveRange - 10 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .13))
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
