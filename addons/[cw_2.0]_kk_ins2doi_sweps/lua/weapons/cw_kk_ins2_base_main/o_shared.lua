local SP = game.SinglePlayer()

//-----------------------------------------------------------------------------
// SetupDataTables edited to initialize INS2LAMMode and INS2GLActive
//-----------------------------------------------------------------------------

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "State")
	self:NetworkVar("Int", 1, "Shots")
	-- self:NetworkVar("Int", 2, "INS2LAMMode")
	self:NetworkVar("Float", 0, "HolsterDelay")
	self:NetworkVar("Bool", 0, "Suppressed")
	self:NetworkVar("Bool", 1, "Safe")
	self:NetworkVar("Bool", 2, "BipodDeployed")
	self:NetworkVar("Bool", 3, "INS2GLActive")
	self:NetworkVar("Angle", 0, "ViewOffset")
	self:NetworkVar("Float", 4, "WeaponHP")
end

//-----------------------------------------------------------------------------
// simulateRecoil edited to not to clamp SWEP.FireMove
//-----------------------------------------------------------------------------

function SWEP:simulateRecoil()
	if self.dt.State ~= CW_AIMING and not self.freeAimOn then
		self.FOVHoldTime = UnPredictedCurTime() + self.FireDelay * 2

		if self.HipFireFOVIncrease then
			self.FOVTarget = math.Clamp(self.FOVTarget + 8 / (self.Primary.ClipSize_Orig * 0.75) * self.FOVPerShot, 0, 7)
		end
	end

	if self.freeAimOn and not self.dt.BipodDeployed then -- we only want to add the 'roll' view shake when we're not using a bipod in free-aim mode
		self.lastViewRoll = math.Clamp(self.lastViewRoll + self.Recoil * 0.5, 0, 15)
		self.lastViewRollTime = UnPredictedCurTime() + FrameTime() * 3
	end

	self.lastShotTime = CurTime() + math.Clamp(self.FireDelay * 3, 0, 0.3) -- save the last time we shot

	if self.BoltBone then
		self:offsetBoltBone()
	end

	if self.LuaViewmodelRecoil then
		if (self.dt.State ~= CW_AIMING and not self.FullAimViewmodelRecoil) or self.FullAimViewmodelRecoil then
			-- increase intensity of the viewmodel recoil with each shot
			self.LuaVMRecoilIntensity = math.Approach(self.LuaVMRecoilIntensity, 1, self.Recoil * 0.15)
			self.LuaVMRecoilLowerSpeed = 0

			if not self.dt.BipodDeployed then
				self:makeVMRecoil()
			end
		end
	end

	if self.ReticleInactivityPostFire then
		self.reticleInactivity = UnPredictedCurTime() + self.ReticleInactivityPostFire
	end
end

//-----------------------------------------------------------------------------
// CycleFiremodes edited to apply different delays depending on animation
//-----------------------------------------------------------------------------

SWEP.FireModeDelayNormal = 1
SWEP.FireModeDelayShort = 0.25
SWEP.FireModeDelayFromSafe = 0.2

function SWEP:CycleFiremodes()
	if self.dt.INS2GLActive then return end

	local lastFM = self.FireMode
	local t = self.FireModes

	if not t.last then
		t.last = 2
	else
		if not t[t.last + 1] then
			t.last = 1
		else
			t.last = t.last + 1
		end
	end

	if self.dt.State == CW_AIMING or self:isBipodDeployed() then
		if self.FireModes[t.last] == "safe" then
			t.last = 1
		end
	end

	local delay = self.FireModeDelayNormal

	if (#self.FireModes < 3) then // why # instead of table.Count?
		delay = self.FireModeDelayShort
	elseif lastFM == "safe" then
		delay = self.FireModeDelayFromSafe
	end

	if self.FireMode != self.FireModes[t.last] and self.FireModes[t.last] then
		local CT = CurTime()
		self:SelectFiremode(self.FireModes[t.last])
		self:SetNextPrimaryFire(CT + delay)
		self:SetNextSecondaryFire(CT + delay)
		self.ReloadWait = CT + delay
	end
end

//-----------------------------------------------------------------------------
// SelectFiremode edited to use renamed umsg
//-----------------------------------------------------------------------------

function SWEP:SelectFiremode(n)
	if CLIENT then
		return
	end

	local t = CustomizableWeaponry.firemodes.registeredByID[n]
	self.Primary.Automatic = t.auto
	self.FireMode = n
	self.BurstAmount = t.burstamt

	if self.FireMode == "safe" then
		self.dt.Safe = true
	else
		self.dt.Safe = false
	end
 
	umsg.Start("CW_KK_INS2_FIREMODE")
		umsg.Entity(self.Owner)
		umsg.String(n)
	umsg.End()
end

//-----------------------------------------------------------------------------
// CW_ReceiveFireMode edited to play firemode animation on client
//-----------------------------------------------------------------------------

if CLIENT then
	local ply, mode, wep, lastFM

	local function CW_ReceiveFireMode(um)
		ply = um:ReadEntity()
		mode = um:ReadString()

		if IsValid(ply) then
			wep = ply:GetActiveWeapon()
			lastFM = wep.FireMode
			wep.FireMode = mode

			if IsValid(ply) and IsValid(wep) and wep.CW20Weapon then
				if CustomizableWeaponry.firemodes.registeredByID[mode] then
					t = CustomizableWeaponry.firemodes.registeredByID[mode]

					wep.Primary.Automatic = t.auto
					wep.BurstAmount = t.burstamt
					wep.FireModeDisplay = t.display
					wep.BulletDisplay = t.buldis
					wep.CheckTime = CurTime() + 2

					if lastFM != "safe" and wep.Base == "cw_kk_ins2_base" then
						wep:firemodeAnimFunc()
					end
				end
			end
		end
	end

	usermessage.Hook("CW_KK_INS2_FIREMODE", CW_ReceiveFireMode)
end

//-----------------------------------------------------------------------------
// Reload edited to use customized grenade launcher reload logic
//-----------------------------------------------------------------------------

local CT, mag

function SWEP:Reload()
	if not self:IndividualReloadCheck() then
		return
	end

	CT = CurTime()

	if self.dt.State == CW_HOLSTER_START or self.dt.State == CW_HOLSTER_END then
		return
	end

	if self.ReloadDelay or CT < self.ReloadWait or self.dt.State == CW_ACTION or self.ShotgunReloadState != 0 then
		return
	end

	if CT < self.GlobalDelay then
		return
	end

	if self.dt.INS2GLActive then
		if not self.M203Chamber and self.Owner:GetAmmoCount("40MM") > 0 then
			self.dt.State = CW_IDLE

			self:beginReload()
		end

		return
	end

	if self.Owner:KeyDown(IN_USE) and self.dt.State != CW_RUNNING then
		self:CycleFiremodes()
		return
	end

	mag = self:Clip1()

	local cantReload, overrideMagCheck, overrideAmmoCheck = CustomizableWeaponry.callbacks.processCategory(self, "canReload", mag == 0)

	if cantReload then
		return
	end

	if not overrideMagCheck then
		if (self.Chamberable and mag >= self.Primary.ClipSize_Orig + 1) then
			return
		end
	end

	if not overrideAmmoCheck then
		if self.Owner:GetAmmoCount(self.Primary.Ammo) == 0 then
			return
		end
	end

	if not self.Chamberable and mag >= self.Primary.ClipSize then
		return
	end

	self.dt.State = CW_IDLE

	self:beginReload()
end

//-----------------------------------------------------------------------------
// beginReload edited to
// - support stripper clip reload logic
// - update reload times before using them
// - use different shotgun reload logic and animations
//-----------------------------------------------------------------------------

local CT, mag, ammo, reloadTime, reloadHalt, anim, animPrefix, animSuffix, flag, unloadTime

function SWEP:beginReload()
	if self.boltAction_isShot then
		return
	end

	CT = CurTime()
	mag, ammo = self:Clip1(), self.Owner:GetAmmoCount(self.Primary.Ammo)

	self.lastMag = mag

	if self.dt.INS2GLActive or (!self.ShotgunReload) then
		if self.dt.INS2GLActive then
			anim = "reload"
		elseif mag == 0 then
			if self.Chamberable then
				self.Primary.ClipSize = self.Primary.ClipSize_Orig
			end

			anim = "reload_empty"
		else
			if self.Chamberable then
				self.Primary.ClipSize = self.Primary.ClipSize_Orig + 1
			end

			anim = "reload"
		end

		if self.reloadAnimFunc then
			reloadTime, reloadHalt = self:reloadAnimFunc(mag)

			if not reloadTime or not reloadHalt then
				error("] (" .. string.upper(self:GetClass()) .. "):reloadAnimFunc() returns invalid values.")
				return
			end
		else
			animPrefix = self:getForegripMode()
			animSuffix = self._KK_INS2_customReloadSuffix

			if self.overrideReloadAnim then
				anim = self:overrideReloadAnim(animPrefix, animSuffix)
			else
				anim = animPrefix .. anim .. animSuffix
			end

			self:sendWeaponAnim(anim, self.ReloadSpeed, 0)

			reloadTime, reloadHalt, flag, unloadTime = self:getAnimTimes(anim)

			if not reloadTime or not reloadHalt then
				error("] (" .. string.upper(self:GetClass()) .. ") Invalid SWEP.ReloadTimes setup for SWEP.Animations." .. anim)
				return
			end

			if self.lastMag > 0 and flag == KK_INS2_STRIPPERCLIP_UNLOAD_ONE then
				CustomizableWeaponry.actionSequence.new(self, unloadTime, nil, function()
					if not self.ReloadDelay then return end	// melee attack interruption

					self:SetClip1(mag - 1)

					if !CustomizableWeaponry_KK.ins2.discardEjectedAmmo then
						self.Owner:SetAmmo(ammo + 1, self.Primary.Ammo)
					end
				end)
			end

			if flag == KK_INS2_REVOLVER_SPEED_UNLOAD then
				CustomizableWeaponry.actionSequence.new(self, unloadTime, nil, function()
					if not self.ReloadDelay then return end	// melee attack interruption

					self:SetClip1(0)

					if !CustomizableWeaponry_KK.ins2.discardEjectedAmmo then
						self.Owner:SetAmmo(ammo + mag, self.Primary.Ammo)
					end
				end)
			end
		end

		reloadTime = reloadTime / self.ReloadSpeed
		reloadHalt = reloadHalt / self.ReloadSpeed

		self.ReloadDelay = CT + reloadTime
		self:SetNextPrimaryFire(CT + reloadHalt)
		self:SetNextSecondaryFire(CT + reloadHalt)
		self.GlobalDelay = CT + reloadHalt
	elseif self:canDoStripperClipReload(ammo, mag) then
		anim = self:getStripperClipAnimation(ammo, mag)

		animPrefix = self:getForegripMode()
		animSuffix = self._KK_INS2_customReloadSuffix

		anim = animPrefix .. anim .. animSuffix

		self:sendWeaponAnim(anim, self.ReloadSpeed, 0)

		local insert1, insert2, insert3

		insert1, reloadHalt, flag, unloadTime, insert2, insert3 = self:getAnimTimes(anim)

		if self.lastMag > 0 and flag == KK_INS2_STRIPPERCLIP_UNLOAD_ONE then
			CustomizableWeaponry.actionSequence.new(self, unloadTime, nil, function()
				if not self.ReloadDelay then return end	// melee attack interruption

				self:SetClip1(mag - 1)

				if !CustomizableWeaponry_KK.ins2.discardEjectedAmmo then
					self.Owner:SetAmmo(ammo + 1, self.Primary.Ammo)
				end
			end)
		end

		if flag == KK_INS2_REVOLVER_SPEED_UNLOAD then
			CustomizableWeaponry.actionSequence.new(self, unloadTime, nil, function()
				if not self.ReloadDelay then return end	// melee attack interruption

				self:SetClip1(0)

				if !CustomizableWeaponry_KK.ins2.discardEjectedAmmo then
					self.Owner:SetAmmo(ammo + mag, self.Primary.Ammo)
				end
			end)
		end

		insert1 = insert1 / self.ReloadSpeed
		reloadHalt = reloadHalt / self.ReloadSpeed

		self.ReloadDelay = CT + insert1
		self.ReloadWait = CT + reloadHalt
		self:SetNextPrimaryFire(CT + reloadHalt)
		self:SetNextSecondaryFire(CT + reloadHalt)
		self.GlobalDelay = CT + reloadHalt
		self.ShotgunReloadState = 3

		self.ReloadDelays = {
			insert1 and (CT + insert1),
			insert2 and (CT + insert2),
			insert3 and (CT + insert3),
		}
		self.ReloadDelaysCur = 1
	else
		self.WasEmpty = mag == 0

		animPrefix = self:getForegripMode()
		animSuffix = self._KK_INS2_customReloadSuffix

		if self.WasEmpty then
			anim = "reload_start_empty"
		else
			anim = "reload_start"
		end

		anim = animPrefix .. anim .. animSuffix

		self:sendWeaponAnim(anim, self.ReloadSpeed, 0)

		reloadTime, reloadHalt, flag = self:getAnimTimes(anim)

		if not reloadTime or not reloadHalt then
			error("] (" .. string.upper(self:GetClass()) .. ") Invalid SWEP.ReloadTimes setup for SWEP.Animations." .. anim)
			return
		end

		self.ReloadFirstShell = self.WasEmpty and flag == KK_INS2_SHOTGUN_LOAD_FIRST
		self.ReloadingRevolver = flag == KK_INS2_REVOLVER_SLOW_UNLOAD

		reloadTime = reloadTime / self.ReloadSpeed
		reloadHalt = reloadHalt / self.ReloadSpeed

		if SERVER then
			if self.WasEmpty and flag == KK_INS2_SHOTGUN_LOAD_FIRST then
				CustomizableWeaponry.actionSequence.new(self, reloadTime, nil, function()
					if self.ShotgunReloadState == 0 then return end	// melee attack interruption

					self:SetClip1(mag + 1)
					self.Owner:SetAmmo(ammo - 1, self.Primary.Ammo)

					if ammo - 1 <= 0 then
						self.ShotgunReloadState = 2
					end
				end)
			end

			if !self.WasEmpty and flag == KK_INS2_SHOTGUN_UNLOAD_ONE then
				CustomizableWeaponry.actionSequence.new(self, reloadTime, nil, function()
					if self.ShotgunReloadState == 0 then return end	// melee attack interruption

					self:SetClip1(mag - 1)

					if !CustomizableWeaponry_KK.ins2.discardEjectedAmmo then
						self.Owner:SetAmmo(ammo + 1, self.Primary.Ammo)
					end
				end)
			end

			if flag == KK_INS2_REVOLVER_SLOW_UNLOAD then
				CustomizableWeaponry.actionSequence.new(self, reloadTime, nil, function()
					if self.ShotgunReloadState == 0 then return end // its also possible that its already 2 because user pressed attack button

					self:SetClip1(0)

					if !CustomizableWeaponry_KK.ins2.discardEjectedAmmo then
						self.Owner:SetAmmo(ammo + mag, self.Primary.Ammo)
					end

					self.ShotgunReloadState = 1
				end)
			end
		end

		self.ReloadDelay = CT + reloadHalt
		self:SetNextPrimaryFire(CT + reloadHalt)
		self:SetNextSecondaryFire(CT + reloadHalt)
		self.GlobalDelay = CT + reloadHalt
		self.ShotgunReloadState = 1
	end

	CustomizableWeaponry.callbacks.processCategory(self, "beginReload", mag == 0)

	self.Owner:SetAnimation(PLAYER_RELOAD)
end

//-----------------------------------------------------------------------------
// finishReloadINS2GL loads customized grenade launcher
//-----------------------------------------------------------------------------

function SWEP:finishReloadINS2GL()
	if self.dt.INS2GLActive then
		if SERVER then
			self.Owner:RemoveAmmo(1, "40MM")
			SendUserMessage("CW_KK_INS2_READYM203", self.Owner)
		end

		self.M203Chamber = true
		self.ReloadDelay = nil

		return true
	end
end

//-----------------------------------------------------------------------------
// finishReload edited to use customized grenade launcher reload logic
//-----------------------------------------------------------------------------

local mag, ammo

function SWEP:finishReload()
	if self:finishReloadINS2GL() then
		return
	end

	mag, ammo = self:Clip1(), self.Owner:GetAmmoCount(self.Primary.Ammo)

	local suppressReloadLogic = CustomizableWeaponry.callbacks.processCategory(self, "defaultReloadLogic", mag == 0)

	if not suppressReloadLogic then
		if self.ReloadAmount then
			if SERVER then
				self:SetClip1(math.Clamp(mag + self.ReloadAmount, 0, self.Primary.ClipSize))
				self.Owner:RemoveAmmo(self.ReloadAmount, self.Primary.Ammo)
			end
		else
			if mag > 0 then
				if ammo >= self.Primary.ClipSize - mag then
					if SERVER then
						self:SetClip1(math.Clamp(self.Primary.ClipSize, 0, self.Primary.ClipSize))
						self.Owner:RemoveAmmo(self.Primary.ClipSize - mag, self.Primary.Ammo)
					end
				else
					if SERVER then
						self:SetClip1(math.Clamp(mag + ammo, 0, self.Primary.ClipSize))
						self.Owner:RemoveAmmo(ammo, self.Primary.Ammo)
					end
				end
			else
				if ammo >= self.Primary.ClipSize then
					if SERVER then
						self:SetClip1(math.Clamp(self.Primary.ClipSize, 0, self.Primary.ClipSize))
						self.Owner:RemoveAmmo(self.Primary.ClipSize, self.Primary.Ammo)
					end
				else
					if SERVER then
						self:SetClip1(math.Clamp(ammo, 0, self.Primary.ClipSize))
						self.Owner:RemoveAmmo(ammo, self.Primary.Ammo)
					end
				end
			end
		end
	end

	CustomizableWeaponry.callbacks.processCategory(self, "finishReload")

	self.ReloadDelay = nil
end

//-----------------------------------------------------------------------------
// finishReloadShotgun edited to
// - support chambering on shotguns
// - allow loading 1st round during reload_start sequence
// - disallow reload interruption unless at least one round was loaded
//-----------------------------------------------------------------------------

local CT, keyDown, mag, ammo, anim, reloadTime, reloadHalt

function SWEP:finishReloadShotgun()
	CT = CurTime()

	if self.ReloadDelay and CT >= self.ReloadDelay then
		if self:finishReloadINS2GL() then
			return
		end
	end

	if self.ShotgunReloadState == 1 then
		keyDown = self.Owner:KeyDown(IN_ATTACK) or self.Owner:KeyDown(IN_ATTACK2)

		if (self.ReloadingRevolver and 0 or self.lastMag) < self:Clip1() and keyDown then
			self.ShotgunReloadState = 2
		end

		if CT > self.ReloadDelay then
			anim = self:getForegripMode() .. "insert"

			self:sendWeaponAnim(anim, self.ReloadSpeed, 0)

			if SERVER and not SP then
				self.Owner:SetAnimation(PLAYER_RELOAD)
			end

			mag, ammo = self:Clip1(), self.Owner:GetAmmoCount(self.Primary.Ammo)

			reloadTime, reloadHalt = self:getAnimTimes(anim)

			if SERVER then
				CustomizableWeaponry.actionSequence.new(self, reloadTime, nil, function()
					if not self.ReloadDelay then return end	// melee attack interruption

					self:SetClip1(mag + 1)
					self.Owner:SetAmmo(ammo - 1, self.Primary.Ammo)
				end)
			end

			self.ReloadDelay = CT + reloadHalt / self.ReloadSpeed

			local clipSize = self.Primary.ClipSize

			if self.Chamberable and (self.ReloadFirstShell or !self.WasEmpty) then
				clipSize = clipSize + 1
			end

			if (mag + 1) >= (clipSize) or ammo - 1 <= 0 then
				self.ShotgunReloadState = 2
			end
		end
	elseif self.ShotgunReloadState == 3 then
		if CT > self.ReloadDelay then

			self.ReloadDelaysCur = self.ReloadDelaysCur + 1
			self.ReloadDelay = self.ReloadDelays[self.ReloadDelaysCur]

			if not self.ReloadDelay then
				self.ShotgunReloadState = 0
			end

			if SERVER then
				mag, ammo = self:Clip1(), self.Owner:GetAmmoCount(self.Primary.Ammo)

				local load = math.Clamp(self.stripperCapacity, 0, ammo)

				self:SetClip1(mag + load)
				self.Owner:SetAmmo(ammo - load, self.Primary.Ammo)
			end
		end
	elseif self.ShotgunReloadState == 2 then
		if CT > self.ReloadDelay then
			self.ShotgunReloadState = 0

			if self.WasEmpty then
				anim = self:getForegripMode() .. "reload_end_empty"
			else
				anim = self:getForegripMode() .. "reload_end"
			end

			self:sendWeaponAnim(anim, self.ReloadSpeed)

			reloadTime, reloadHalt = self:getAnimTimes(anim)

			reloadHalt = CT + reloadHalt / self.ReloadSpeed

			self:SetNextPrimaryFire(reloadHalt)
			self:SetNextSecondaryFire(reloadHalt)
			self.ReloadWait = reloadHalt
			self.ReloadDelay = nil
		end
	end
end

//-----------------------------------------------------------------------------
// isNearWall edited to
// - use SWEP.WeaponLength in trace
// - return whole trace result if true
//-----------------------------------------------------------------------------

local mins, maxs = Vector(-8, -8, -1), Vector(8, 8, 1)

local td = {}
td.mins = mins
td.maxs = maxs

function SWEP:isNearWall()
	if not self.NearWallEnabled then
		-- return false
	end

	td.start = self.Owner:GetShootPos()
	td.endpos = td.start + self.Owner:EyeAngles():Forward() * (self.WeaponLength + 10)
	td.filter = self.Owner

	local tr = util.TraceLine(td)
	local ent = tr.Entity

	if tr.Hit then
		if IsValid(ent) then
			if ent:IsPlayer() then
				return false
			end

			if ent:IsNPC() then
				return false
			end

			if ent:GetOwner() == self.Owner then
				return false
			end
		end

		return true, tr
	end

	return false
end

//-----------------------------------------------------------------------------
// GetDeployTime edited to replace global delay calls used in older versions
// of PrepareForPickup
//-----------------------------------------------------------------------------

function SWEP:GetDeployTime()
	-- if self.oneTimeDeploySpeed then
		-- local tar = self.DeployTime / (self.DrawSpeed + self.oneTimeDeploySpeed)
		-- local out = tar * (self.DrawSpeed)

		-- self.oneTimeDeploySpeed = nil

		-- return out
	-- end

	if self.KKINS2Melee or self.KKINS2Nade then
		return self.DeployTime
	end

	if self._KK_INS2_PickedUp or (self.KK_INS2_EmptyIdle and self:Clip1() == 0) then
		if self:hasInstalledGL() and self._currentGrenadeLauncher.ww2GrenadeLauncher and self.dt.INS2GLActive then
			return self.DeployTime + 0.2
		else
			return self.DeployTime
		end
	end

	return self.FirstDeployTime + 0.2 // woot
end

//-----------------------------------------------------------------------------
//
//-----------------------------------------------------------------------------

function SWEP:GetHolsterTime()
	if self:hasInstalledGL() and self._currentGrenadeLauncher.ww2GrenadeLauncher and self.dt.INS2GLActive then
		return self.HolsterTime + 0.2
	else
		return self.HolsterTime
	end
end

//-----------------------------------------------------------------------------
// Holster edited to
// - check for dt.PinPulled
// - process custom callback category currently only used by one attachment
// - remove redundant holster sound (should be played from animation soundtable)
//-----------------------------------------------------------------------------

function SWEP:Holster(wep)
	if not IsValid(wep) and not IsValid(self.SwitchWep) then
		self.SwitchWep = nil
		return false
	end

	local CT = CurTime()

	if self.dt.PinPulled then
		return false
	end

	if CT < self.GlobalDelay or CT < self.HolsterWait then
		return false
	end

	if self.dt.HolsterDelay ~= 0 and CT < self.dt.HolsterDelay then
		return false
	end

	if #self._activeSequences > 0 then
		return false
	end

	if self.ReloadDelay then
		return false
	end

	if self.dt.State ~= CW_HOLSTER_START then
	    if isnumber(self.HolsterSpeedMult) then
		    self.dt.HolsterDelay = CT + (self:GetHolsterTime() / (self.HolsterSpeed * self.HolsterSpeedMult))
		elseif isnumber(self.HolsterSpeed) then
		    self.dt.HolsterDelay = CT + (self:GetHolsterTime() / self.HolsterSpeed) 
		end
	end

	self.dt.State = CW_HOLSTER_START

	if self.SwitchWep and self.dt.State == CW_HOLSTER_START and CT > self.dt.HolsterDelay then
		self.dt.State = CW_IDLE
		self.dt.HolsterDelay = 0

		CustomizableWeaponry.callbacks.processCategory(self, "holsterEnd", self.SwitchWep)

		return true
	end

	self.ShotgunReloadState = 0
	self.ReloadDelay = nil

	if self:filterPrediction() then
		if self.holsterSound then
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
end

//-----------------------------------------------------------------------------
// Initialize edited to initialize custom features
// - ActiveAttachment and WElement state networking
// - FirstDeploy animation logic
//-----------------------------------------------------------------------------

function SWEP:Initialize()
	self:updateReloadTimes()

	if CLIENT then
		self:setupReloadProgressAnims()
	end

	weapons.GetStored("cw_base").Initialize(self)

	self:PrepareForPickup()

	if CLIENT then
		self:drawAnimFunc()
		self:initNWAA()
		self:initNWWE()
	end
end

//-----------------------------------------------------------------------------
// unloadWeapon edited to
// - only unload weapon when in CW Menu - for spawn preset plugin
// - unload magazine if Mag System is installed
// - play idle animation in case loaded and empty idle animations differ
//-----------------------------------------------------------------------------

function SWEP:unloadWeapon(force)
	if !force and self.dt.State != CW_CUSTOMIZE then return end

	weapons.GetStored("cw_base").unloadWeapon(self)

	if SERVER then
		if self.usesMagazines and self:usesMagazines() then
			weapons.GetStored("cw_base").unloadMagazine(self)
		end
	end

	if CLIENT then
		if self.KK_INS2_EmptyIdle then
			self:idleAnimFunc()
		end
	end
end

//-----------------------------------------------------------------------------
// isReloading is only used for suppressing bipod angles during reload
// - we dont want that happening with INS2 SWEPs
//-----------------------------------------------------------------------------

function SWEP:isReloading()
	return false
end

//-----------------------------------------------------------------------------
// getReloadProgress
// - edited to show progress of any anim listed in SWEP.reloadProgressAnims
//-----------------------------------------------------------------------------

function SWEP:getReloadProgress()
	local length = self.reloadProgressAnims[self.Sequence]

	if length and self.Cycle <= 0.98 then
		return math.Clamp(math.ceil(self:getAnimSeek() / length * 100), 0, 100)
	end

	return nil
end

//-----------------------------------------------------------------------------
// CalculateSpread
// - edited to support prone mod
//-----------------------------------------------------------------------------

function SWEP:getProneSpreadModifier()
	return self.dt.State == CW_AIMING and 0.8 or 0.75
end

local CT, aim

local reg = debug.getregistry()
local GetAimVector = reg.Player.GetAimVector

function SWEP:CalculateSpread(vel, dt)
	if not self.AccuracyEnabled then
		return
	end

	aim = GetAimVector(self.Owner)
	CT = CurTime()

	if not self.Owner.LastView then
		self.Owner.LastView = aim
		self.Owner.ViewAff = 0
	else
		self.Owner.ViewAff = LerpCW20(dt * 10, self.Owner.ViewAff, (aim - self.Owner.LastView):Length() * 0.5)
		self.Owner.LastView = aim
	end

	local baseCone, maxSpreadMod = self:getBaseCone()
	self.BaseCone = baseCone

	if self:IsOwnerProne() then
		self.BaseCone = self.BaseCone * self:getProneSpreadModifier()
	else
		if self.Owner:Crouching() then
			self.BaseCone = self.BaseCone * self:getCrouchSpreadModifier()
		end
	end

	self.CurCone = self:getFinalSpread(vel, maxSpreadMod)

	if CT > self.SpreadWait then
		self.AddSpread = math.Clamp(self.AddSpread - 0.5 * self.AddSpreadSpeed * dt, 0, self:getMaxSpreadIncrease(maxSpreadMod))
		self.AddSpreadSpeed = math.Clamp(self.AddSpreadSpeed + 5 * dt, 0, 1)
	end
end

//-----------------------------------------------------------------------------
// setBodygroup
// - thanks to DOI updates we ve got outbreak of ani_bodies here
//-----------------------------------------------------------------------------

function SWEP:setBodygroup(main, sub)
	if SERVER then
		return
	end

	if IsValid(self.CW_VM) and self.CW_VM:SetBodygroup(main, sub) then
	end

	if self.AttachmentModelsVM and self.AttachmentModelsVM.ani_body then
		local ent = self.AttachmentModelsVM.ani_body.ent

		if IsValid(ent) and ent:SetBodygroup(main, sub) then
		end
	end
end