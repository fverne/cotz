AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "P08"
	SWEP.CSMuzzleFlashes = true
	SWEP.UseHands = true

	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	SWEP.SightWithRail = true
	
	SWEP.EffectiveRange_Orig = 100 * 39.37
	SWEP.DamageFallOff_Orig = .36
	
	SWEP.Shell = "khr9x19"
	SWEP.ShellScale = .64
	SWEP.ShellDelay = .035
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -3, y = -2.35, z = -.25}

	SWEP.IronsightPos = Vector(-1.803, -3, 0.914)
	SWEP.IronsightAng = Vector(0.3, 0.05, 6.5882)
	
	SWEP.AltIronPos = Vector(-1.803, -3, 0.914)
	SWEP.AltIronAng = Vector(0.3, 0.0047, 6.5882)
	
	SWEP.SprintPos = Vector(3.8409, -11.9318, -9.5227)
	SWEP.SprintAng = Vector(59.3182, -2.0455, 2.0455)
	
	SWEP.CustomizePos = Vector(9.75, -7.5, 2.7)
	SWEP.CustomizeAng = Vector(15, 47, 30)

	SWEP.AlternativePos = Vector(-.45, -2.5, -0.15)
	SWEP.AlternativeAng = Vector(0.3, 0.0047, 3)
	
	SWEP.SwimPos = Vector(0.5, -2.1053, -0.5)
	SWEP.SwimAng = Vector(-50.8947, -3.7895, -46.5263)
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = .8
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 2, roll = 2, forward = 1.5, pitch = 2}
	SWEP.CustomizationMenuScale = 0.0135 --  0.0165
	
	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "P80_Barrel", pos = Vector(0, 9.3, -0.65), angle = Angle(0, 180, 0), size = Vector(0.52, 0.52, 0.52)},
	}
end
SWEP.BarrelBGs = {main = 4, off = 0, on = 1}
SWEP.SightBGs = {main = 3, off = 0, on = 1}

SWEP.MuzzleVelocity = 350
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = true

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-350, -200}, atts = {"md_tundra9mm"}},
	[2] = {header = "Finish", offset = {350, -350}, atts = {"doi_atow_c96goldfinish"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_zoneloaded", "am_matchgrade"}}}

SWEP.Animations = {fire = {"base_fire","base_fire3"},
	fire_aim = {"iron_fire_2","iron_fire_3"},
	fire_last = {"base_firelast"},
	fire_last_aim = {"iron_firelast"},
	reload = "base_reload",
	reload_empty = "base_reloadempty",
	idle = "base_idle",
	draw = "base_draw"}
	

SWEP.SpeedDec = 5

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
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
SWEP.ViewModel		= "models/khrcw2/doipack/lugerp08.mdl"
SWEP.WorldModel		= "models/khrcw2/doipack/w_lugerp08.mdl"

SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/khrcw2/doipack/w_lugerp08.mdl"
SWEP.WMPos = Vector(-1.35, 4.5, 3.5)
SWEP.WMAng = Vector(-2, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ReloadViewBobEnabled = true
SWEP.RVBPitchMod = .5
SWEP.RVBYawMod = 0
SWEP.RVBRollMod = .25

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Chamberable			= true

SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 60/500
SWEP.FireSound = "DOIP08_FIRE"
SWEP.FireSoundSuppressed = "CW_P99_FIRE_SUPPRESSED"
SWEP.Recoil = .93
SWEP.FOVPerShot = 0 -- = .57

SWEP.HipSpread = 0.042
SWEP.AimSpread = 0.006
SWEP.VelocitySensitivity = .3
SWEP.MaxSpreadInc = 0.055
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 20
SWEP.DeployTime = .2
SWEP.HolsterTime = .30

SWEP.ADSFireAnim = true
SWEP.ShootWhileProne = true
SWEP.HolsterOnLadder = false
SWEP.SprintingEnabled = false

SWEP.ReloadSpeed = 1.45
SWEP.ReloadTime = 2.15
SWEP.ReloadHalt = 2.9
SWEP.ReloadTime_Empty = 2.95
SWEP.ReloadHalt_Empty = 4

function SWEP:IndividualInitialize()
	self:setBodygroup(self.SightBGs.main, self.SightBGs.off)
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.on)
end

function SWEP:IndividualThink()
	self.Owner.ViewAff = 0

	self.EffectiveRange = ((self.EffectiveRange + 5 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .03))

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
