AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

		--SWEP.magType = "NONE"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1917"
	SWEP.CSMuzzleFlashes = true
	SWEP.UseHands = false
	
	SWEP.HUD_MagText = "CYLINDER: "
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	SWEP.SightWithRail = true
	
	SWEP.EffectiveRange_Orig = 130 * 39.37
	SWEP.DamageFallOff_Orig = .62
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .425
	SWEP.NoShells = true
	
	SWEP.ForegripOverridePos = {
	["bipod"] = {
	["A_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(180, 0, 0) }},
}

	SWEP.RMRPos = Vector(-2.7082, -1.5, 0.7)
	SWEP.RMRAng = Vector(-1.53, 0.05, 4.4)

	SWEP.IronsightPos = Vector(-2.7682, -1, 1.29)
	SWEP.IronsightAng = Vector(-1.53, 0.05, 4.4)
	
	SWEP.AltIronPos = Vector(-2.769, -1, 1.20)
	SWEP.AltIronAng = Vector(-1.3, 0.035, 4.4)
	
	SWEP.SprintPos = Vector(2.8409, -10.9318, -8.5227)
	SWEP.SprintAng = Vector(59.3182, 2.0455, 2.0455)
	
	SWEP.CustomizePos = Vector(10, -5, .5)
	SWEP.CustomizeAng = Vector(15, 45, 20)

	SWEP.AlternativePos = Vector(-.8, 0, -0.3)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SwimPos = Vector(0.5, -2.1053, -0.5)
	SWEP.SwimAng = Vector(-50.8947, -3.7895, -46.5263)
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = .8
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = .25, roll = 2, forward = 0, pitch = .4}
	SWEP.CustomizationMenuScale = 0.016 --  0.017
	
	SWEP.AttachmentModelsVM = {
		["md_cobram2"] = {model = "models/cw2/attachments/cobra_m2.mdl", bone = "A_Muzzle", pos = Vector(-2.2, 0, 0.002), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255)},
		["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "A_Muzzle", pos = Vector(10, 4.05, -0.33), angle = Angle(180, 0, -90), size = Vector(0.8, 0.8, 0.8)},
	}
	

end

SWEP.ShellsBGs = {main = 1, zero = 0, one = 1, two = 2, three = 3, four = 4, five = 5, six = 6}
SWEP.BulletsBGs = {main = 2,  zero = 0, one = 1, two = 2, three = 3, four = 4, five = 5, six = 6}
SWEP.BarrelBGs = {main = 5, default = 0, ext = 1, snub = 2}

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.FullAimViewmodelRecoil = true

SWEP.MuzzleVelocity = 250

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-350, -200}, atts = {"md_cobram2"}},
	[2] = {header = "Sight", offset = {300, -300}, atts = {"md_rmr"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"base_fire","base_fire2"},
	fire_aim = {"iron_fire_1"},
	fire_last = {"base_fire_last"},
	fire_last_aim = {"iron_fire_last"},
	reload_start = "base_reload_start",
	insert = "base_reload_insert",
	reload_end = "base_reload_end",
	reload = "base_reload_clip",
	reload_empty = "base_reload_clip_empty",
	idle = "base_reload_end",
	draw = "base_draw"}
	
SWEP.ReloadViewBobEnabled = true

SWEP.SpeedDec = 0

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
SWEP.NearWallEnabled = false

SWEP.ViewModelFOV	= 65
SWEP.AimViewModelFOV = 65
SWEP.ZoomAmount = 5
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/doipack/sw1917.mdl"
SWEP.WorldModel		= "models/khrcw2/doipack/w_sw1917.mdl"

SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/khrcw2/doipack/w_sw1917.mdl"
SWEP.WMPos = Vector(-1.4, 4, 2.95)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ReloadViewBobEnabled = true
SWEP.RVBPitchMod = .5
SWEP.RVBYawMod = .5
SWEP.RVBRollMod = .5

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Chamberable			= false

SWEP.Primary.Ammo			= ".45 ACP"

SWEP.FireDelay = 0.8
SWEP.FireSound = "DOIM1917_FIRE"
SWEP.FireSoundSuppressed = "CW_M1911_FIRE_SUPPRESSED"
SWEP.Recoil = 2.9
SWEP.FOVPerShot = 0.25 -- = .5

SWEP.WearDamage = 0.22
SWEP.WearEffect = 0.05

SWEP.HipSpread = 0.125
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 5
SWEP.MaxSpreadInc = 0.4
SWEP.ClumpSpread_Orig = nil
SWEP.ClumpSpread = nil
SWEP.SpreadPerShot = 0.015
SWEP.SpreadCooldown = 0.58
SWEP.Shots = 1
SWEP.Damage = 68
SWEP.DeployTime = .375
SWEP.HolsterTime = .35

SWEP.ADSFireAnim = true
SWEP.ShootWhileProne = true
SWEP.ShotgunReload = true
SWEP.HolsterOnLadder = false
SWEP.SprintingEnabled = false

SWEP.ReloadStartTime = 2.25
SWEP.InsertShellTime = .95
SWEP.ReloadFinishWait = 1.5

SWEP.ReloadSpeed = 1.5
SWEP.ReloadTime = 4.575
SWEP.ReloadHalt = 5.2
SWEP.ReloadTime_Empty = 5.15
SWEP.ReloadHalt_Empty = 5.3

function SWEP:IndividualThink()

if self.ActiveAttachments.doi_atow_revspeedstrip then
			if self:Clip1() == 0 or self:Clip1() == 2 or self:Clip1() == 4 then
				self.InsertShellTime = 0.3
			elseif self:Clip1() == 1 or self:Clip1() == 3 or self:Clip1() == 5 then
				self.InsertShellTime = 1.1
			else
				self.InsertShellTime = 0.95
			end
	end

self.Owner.ViewAff = 0
	self.EffectiveRange = 130 * 39.37
	self.DamageFallOff = .62
	self.ForegripOverride = true
	self.ForegripParent = "bipod"

	
	clip = self:Clip1()	
			
	if self.Sequence == self.Animations.insert and clip == 0 then
	self:setBodygroup(self.ShellsBGs.main, self.ShellsBGs.zero)
	end	
		if self.Sequence == self.Animations.insert and clip == 1 then
		self:setBodygroup(self.ShellsBGs.main, self.ShellsBGs.one)
		end
			if self.Sequence == self.Animations.insert and clip == 2 then
			self:setBodygroup(self.ShellsBGs.main, self.ShellsBGs.two)
			end
				if self.Sequence == self.Animations.insert and clip == 3 then
				self:setBodygroup(self.ShellsBGs.main, self.ShellsBGs.three)
				end
					if self.Sequence == self.Animations.insert and clip == 4 then
					self:setBodygroup(self.ShellsBGs.main, self.ShellsBGs.four)
					end
						if self.Sequence == self.Animations.insert and clip == 5 then
						self:setBodygroup(self.ShellsBGs.main, self.ShellsBGs.five)
						end
							if self.Sequence == self.Animations.insert and clip == 6 then
							self:setBodygroup(self.ShellsBGs.main, self.ShellsBGs.six)
							end
								if not self.IsReloading and clip == 6 then
								self:setBodygroup(self.ShellsBGs.main, self.ShellsBGs.six)
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
