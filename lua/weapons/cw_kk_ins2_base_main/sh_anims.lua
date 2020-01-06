
local SP = game.SinglePlayer()
local MP = !SP
local isBipod, wasBipod, cycle, suffix, anim, prefix, rate, clip

if CLIENT then
	function SWEP:playSwitchBipod()
		if self.KKINS2Melee or self.KKINS2Nade then
			return
		end

		if not self.BipodInstalled then
			return
		end

		wasBipod = self._KK_INS2_wasBipod
		isBipod = self.dt.BipodDeployed
		cycle = self.CW_VM:GetCycle()

		if self:Clip1() == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		else
			suffix = ""
		end

		if isBipod != wasBipod and wasBipod != nil then
			if self.Sequence:find("reload") and cycle < 1 then
				self._KK_INS2_postReloadBipodSwitch = true
			else
				if isBipod then
					self:sendWeaponAnim("bipod_in" .. suffix)
				else
					self:sendWeaponAnim("bipod_out" .. suffix)
				end
			end
		end
		if self._KK_INS2_postReloadBipodSwitch and self.Sequence:find("reload") and cycle > 0.9 then
			if isBipod then
				self:sendWeaponAnim("bipod_in" .. suffix)
			else
				self:sendWeaponAnim("bipod_out" .. suffix)
			end
			self._KK_INS2_postReloadBipodSwitch = false
		end

		self._KK_INS2_wasBipod = isBipod
	end

	local canDoStuff, wasSprint, isSprint, wasSafe, isSafe, wasCrawling, isCrawling

	function SWEP:playHolsterTransitions()
		if not CustomizableWeaponry_KK.ins2.holsterTransitionsEnabled then
			return
		end

		canDoStuff =
			self:isReticleActive() and								// no swapping during "action" animation
			(self.dt.State != CW_CUSTOMIZE) and 					// no swapping in CW Menu
			not (self.KKINS2Nade and self.dt.PinPulled) and			// no swapping after pin-pull
			not (self.GlobalDelay > CurTime()) and					// ??
			self._KK_INS2_PickedUp and								// no swapping before unboxed (although it should be covered by pickup anim)
			true

		wasSprint = self._KK_INS2_wasSprint
		isSprint = self:isRunning()

		isSprint = isSprint and canDoStuff

		if isSprint != wasSprint and wasSprint != nil then
			if isSprint then
				self:sprintAnimFunc()
			elseif canDoStuff then
				self:idleAnimFunc()
			end
		end

		self._KK_INS2_wasSprint = isSprint

		if isSprint then return end

		if self.Owner.IsProne then
			local canDoStuff =
				self:isReticleActive() and
				not (self.KKINS2Nade and self.dt.PinPulled) and
				not (self.GlobalDelay > CurTime()) and
				self._KK_INS2_PickedUp

			wasCrawling = self._KK_INS2_wasCrawling
			isCrawling = self:IsOwnerCrawling() and canDoStuff // and not (self.dt.State == CW_HOLSTER_START or self.dt.State == CW_HOLSTER_END)

			if isCrawling != wasCrawling and wasCrawling != nil then
				if isCrawling then
					self:proneAnimFunc()
				elseif canDoStuff then
					self:idleAnimFunc()
				end
			end

			self._KK_INS2_wasCrawling = isCrawling

			if isCrawling then return end
		end

		if self.KKINS2Melee then return end

		wasSafe = self._KK_INS2_wasSafe
		isSafe = self.dt.Safe or self:isNearWall() or (self.dt.State == CW_ACTION)

		isSafe = isSafe and canDoStuff

		if canDoStuff then
			if isSafe then
				self:safetyAnimFunc()
			elseif isSafe != wasSafe then
				self:idleAnimFunc()
			end
		elseif wasSafe then
			if (self.dt.State == CW_CUSTOMIZE) then
				self:idleAnimFunc()
			end
		end

		self._KK_INS2_wasSafe = isSafe
	end

	local sth = CustomizableWeaponry_KK.ins2.conVars.main["cw_kk_ins2_sprint"]

	function SWEP:sprintAnimFunc()
		if sth:GetInt() == 0 and (self.Slot == 2 or self.Slot == 3) then
			anim = "safe"
			rate = 1
		else
			anim = "sprint"
			rate = 1 // self.SprintAnimSpeed
		end

		prefix = self:getForegripMode()
		suffix = ""
		cycle = 0

		clip = self:Clip1()

		if self.dt.INS2GLActive then
			if !self.M203Chamber and self.KK_INS2_EmptyIdleGL then
				suffix = "_empty" .. self._KK_INS2_customEmptySuffix
			end
		else
			if clip == 0 and self.KK_INS2_EmptyIdle then
				suffix = "_empty" .. self._KK_INS2_customEmptySuffix
			end
		end

		if self.ActiveAttachments.kk_ins2_ww2_knife or self.ActiveAttachments.kk_ins2_ww2_knife_fat then
			anim = "sprint_knife"
			rate = 1
			cycle = 0
		end

		if self.KKINS2Nade and self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then
			anim = "holster"
			rate = 1
			cycle = 1
		end

		self:sendWeaponAnim(prefix .. anim .. suffix, rate, cycle)
	end

	function SWEP:safetyAnimFunc()
		if self.KKINS2Nade then
			return
		end

		anim = "safe"
		prefix = self:getForegripMode()
		suffix = ""

		clip = self:Clip1()

		if self.dt.INS2GLActive then
			if !self.M203Chamber and self.KK_INS2_EmptyIdleGL then
				suffix = "_empty" .. self._KK_INS2_customEmptySuffix
			end
		else
			if clip == 0 and self.KK_INS2_EmptyIdle then
				suffix = "_empty" .. self._KK_INS2_customEmptySuffix
			end
		end

		if self:isAiming() /*or self.Slot == 1*/ then
			suffix = suffix .. "_aim"
		end

		self:sendWeaponAnim(prefix .. anim .. suffix, 1, 0)
	end

	function SWEP:firemodeAnimFunc()
		if self.KKINS2Nade then
			return
		end

		anim = "firemode"
		prefix = self:getForegripMode()
		suffix = ""

		clip = self:Clip1()

		if self.dt.INS2GLActive then
			if !self.M203Chamber and self.KK_INS2_EmptyIdleGL then
				suffix = "_empty" .. self._KK_INS2_customEmptySuffix
			end
		else
			if clip == 0 and self.KK_INS2_EmptyIdle then
				suffix = "_empty" .. self._KK_INS2_customEmptySuffix
			end
		end

		if self:isAiming() then
			suffix = suffix .. "_aim"
		end

		self:sendWeaponAnim(prefix .. anim .. suffix, 1, 0)
	end

	function SWEP:proneAnimFunc()
		prefix = self:getForegripMode()
		anim = "crawl"
		suffix = ""
		rate = 1
		cycle = 0

		clip = self:Clip1()

		if self.dt.INS2GLActive then
			if !self.M203Chamber and self.KK_INS2_EmptyIdleGL then
				suffix = "_empty" .. self._KK_INS2_customEmptySuffix
			end
		else
			if clip == 0 and self.KK_INS2_EmptyIdle then
				suffix = "_empty" .. self._KK_INS2_customEmptySuffix
			end
		end

		if self.KKINS2Nade and self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then
			anim = "holster"
			rate = 1
			cycle = 1
		end

		self:sendWeaponAnim(prefix .. anim .. suffix, rate, cycle)
	end
end

function SWEP:idleAnimFunc()
	prefix = self:getForegripMode()
	suffix = ""
	anim = "idle"
	rate = -1
	-- cycle = 0.45
	cycle = 0

	if self.KKINS2Melee then
		rate = 1
	elseif self.KKINS2Nade then
		rate = 1
		if self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then
			anim = "holster"
			cycle = 1
		end
	else
		anim = "idle" // only idle anims are for base_ prefix, it used to use draw anim for others anyway
		-- anim = "holster"
	end

	if self:IsOwnerCrawling() then
		anim = "crawl"
	end

	clip = self:Clip1()

	if self.dt.INS2GLActive then
		if !self.M203Chamber and self.KK_INS2_EmptyIdleGL then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
	else
		if clip == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
	end

	-- if self.dt.State == CW_CUSTOMIZE then
		-- cycle = 1
	-- end

	-- if self:isAiming() then
		-- rate = 2
		-- cycle = 0.5
	-- end

	if self:isAiming() and self.Animations[prefix .. anim .. suffix .. "_aim"] then
		suffix = suffix .. "_aim"
	end

	self:sendWeaponAnim(prefix .. anim .. suffix, rate, cycle)

	self:removeCurSoundTable()
end

function SWEP:aimIdleAnimFunc()
	if self.Animations[self:getForegripMode() .. "idle_aim"] then
		self:idleAnimFunc()
	end
end

function SWEP:pickupAnimFunc(mode)
	mode = mode or self:getForegripMode()
	clip = self:Clip1()

	if clip == 0 and self.KK_INS2_EmptyIdle then
		anim = "draw_empty"
		suffix = ""
	else
		anim = "pickup"
		suffix = self._KK_INS2_customPickupSuffix
	end

	if SERVER then
		self:sendWeaponAnim(mode .. anim .. suffix, self.DrawSpeed, 0)
	end

	if CLIENT then
		if self.Sequence != self.Animations[mode .. anim] or self.CW_VM:GetCycle() > 0.99 then
			self:sendWeaponAnim(mode .. anim .. suffix, self.DrawSpeed, 0)
		end
	end
end

function SWEP:drawAnimFunc()
	if not self._KK_INS2_PickedUp then
		return
	end

	prefix = self:getForegripMode()
	suffix = ""
	anim = "draw"
	rate = self.DrawSpeed
	cycle = 0

	clip = self:Clip1()

	if self.dt.INS2GLActive then
		if !self.M203Chamber and self.KK_INS2_EmptyIdleGL then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
	else
		if clip == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
	end

	if self.KKINS2Nade and self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then
		anim = "holster"
		cycle = 1
	end

	if MP and SERVER then
		return
	end

	self:sendWeaponAnim(prefix .. anim .. suffix, rate, cycle)
end

function SWEP:meleeAnimFunc()
	-- cycle = 0
	-- rate = 1
	-- prefix = self:getForegripMode()
	-- suffix = ""

	-- clip = self:Clip1()

	-- if self.dt.INS2GLActive then
		-- if !self.M203Chamber and self.KK_INS2_EmptyIdleGL then
			-- suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		-- end
	-- else
		-- if clip == 0 and self.KK_INS2_EmptyIdle then
			-- suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		-- end
	-- end

	-- anim = prefix .. "melee" .. suffix

	-- self:sendWeaponAnim(anim, rate, cycle)
end

function SWEP:bayonetAnimFunc()
	if self.KKINS2Nade then		// I believe grenades wont have bayonets any time soon
		return
	end

	cycle = 0
	rate = 1
	prefix = self:getForegripMode()
	suffix = ""

	clip = self:Clip1()

	if clip == 0 and self.KK_INS2_EmptyIdle then
		suffix = "_empty" .. self._KK_INS2_customEmptySuffix
	end

	self:sendWeaponAnim(prefix .. "stab" .. suffix, rate, cycle)
end //*/

function SWEP:fireAnimFunc()
	clip = self:Clip1()
	cycle = 0
	rate = 1
	prefix = self:getForegripMode()
	suffix = ""

	if clip == 1 and self.KK_INS2_EmptyIdle then
		suffix = "_last" .. self._KK_INS2_customEmptySuffix
	elseif (clip == 0 and not self.dt.INS2GLActive) or (self.dt.INS2GLActive and not self.M203Chamber) then
		suffix = "_empty" .. self._KK_INS2_customEmptySuffix
	end

	if self:isAiming() then
		suffix = suffix .. "_aim"

		if clip > 0 then
			cycle = self.ironFireAnimStartCycle
		end
	end

	self:sendWeaponAnim(prefix .. "fire" .. suffix, rate, cycle)
end //*/

function SWEP:holsterAnimFunc()
	prefix = self:getForegripMode()
	suffix = ""
	cycle = 0

	clip = self:Clip1()

	if self.dt.INS2GLActive then
		if !self.M203Chamber and self.KK_INS2_EmptyIdleGL then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
	else
		if clip == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
	end

	if self.KKINS2Nade and self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then
		cycle = 1
	end

	if MP and SERVER then
		return
	end

	self:sendWeaponAnim(prefix .. "holster" .. suffix, self.HolsterSpeed, cycle)
end

//-----------------------------------------------------------------------------
// reticle inactivity anims
//-----------------------------------------------------------------------------

if CLIENT then
	SWEP.reticleInactivityCallbacksRaw = {
		-- ["reload"] = 0.1,			// Actually, reloads anims are only played using
		-- ["reload_empty"] = 0.1,		// these two. For now.
		// not anymoor ^^

		// I really should generate this from table of prefixes|anims|suffixes|suffixes|suffixes lol

		["base_pickup"] = 0.1,
		["base_draw"] = -0.2,
		["base_draw_empty"] = -0.2,
		["base_draw_empty_mm"] = -0.2,
		["base_bolt"] = 0.1,
		["base_bolt_aim"] = -0.2,
		["base_reload"] = 0.1,
		["base_reload_mm"] = 0.1,
		["base_reload_empty"] = 0.1,
		["base_reload_empty_mm"] = 0.1,
		["base_reload_start"] = 0.1,
		["base_reload_start_empty"] = 0.1,
		["base_reload_end"] = 0.1,
		["base_reload_end_empty"] = 0.1,
		["base_reload_stripper_1"] = 0.1,
		["base_reload_stripper_1_empty"] = 0.1,
		["base_reload_stripper_2"] = 0.1,
		["base_reload_stripper_2_empty"] = 0.1,
		["base_reload_stripper_3"] = 0.1, // yes, I know FAS2 SKS
		["base_reload_stripper_3_empty"] = 0.1,
		["base_insert"] = 0.1,
		-- ["base_holster"] = 0.1,
		-- ["base_holster_empty"] = 0.1,
		-- ["base_holster_empty_mm"] = 0.1,
		["base_firemode"] = 0.1,
		["base_firemode_aim"] = 0.1,
		["base_firemode_empty"] = 0.1,
		["base_firemode_empty_aim"] = 0.1,
		["base_firemode_empty_mm"] = 0.1,
		["base_firemode_empty_mm_aim"] = 0.1,

		["foregrip_pickup"] = 0.1,
		["foregrip_draw"] = -0.2,
		["foregrip_draw_empty"] = -0.2,
		["foregrip_draw_empty_mm"] = -0.2,
		["foregrip_bolt"] = 0.1,
		["foregrip_bolt_aim"] = 0.1,
		["foregrip_reload"] = 0.1,
		["foregrip_reload_mm"] = 0.1,
		["foregrip_reload_empty"] = 0.1,
		["foregrip_reload_empty_mm"] = 0.1,
		["foregrip_reload_start"] = 0.1,
		["foregrip_reload_start_empty"] = 0.1,
		["foregrip_reload_end"] = 0.1,
		["foregrip_reload_end_empty"] = 0.1,
		["foregrip_reload_stripper_1"] = 0.1,
		["foregrip_reload_stripper_1_empty"] = 0.1,
		["foregrip_reload_stripper_2"] = 0.1,
		["foregrip_reload_stripper_2_empty"] = 0.1,
		["foregrip_reload_stripper_3"] = 0.1,
		["foregrip_reload_stripper_3_empty"] = 0.1,
		["foregrip_insert"] = 0.1,
		-- ["foregrip_holster"] = 0.1,
		-- ["foregrip_holster_empty"] = 0.1,
		-- ["foregrip_holster_empty_mm"] = 0.1,
		["foregrip_firemode"] = 0.1,
		["foregrip_firemode_aim"] = 0.1,
		["foregrip_firemode_empty"] = 0.1,
		["foregrip_firemode_empty_aim"] = 0.1,
		["foregrip_firemode_empty_mm"] = 0.1,
		["foregrip_firemode_empty_mm_aim"] = 0.1,

		["bipod_in"] = 0.1,
		["bipod_in_empty"] = 0.1,
		["bipod_bolt"] = 0.1,
		["bipod_bolt_aim"] = 0.1,
		["bipod_reload"] = 0.1,
		["bipod_reload_mm"] = 0.1,
		["bipod_reload_empty"] = 0.1,
		["bipod_reload_empty_mm"] = 0.1,
		["bipod_reload_start"] = 0.1,
		["bipod_reload_start_empty"] = 0.1,
		["bipod_reload_end"] = 0.1,
		["bipod_reload_end_empty"] = 0.1,
		["bipod_reload_stripper_1"] = 0.1,
		["bipod_reload_stripper_1_empty"] = 0.1,
		["bipod_reload_stripper_2"] = 0.1,
		["bipod_reload_stripper_2_empty"] = 0.1,
		["bipod_reload_stripper_3"] = 0.1,
		["bipod_reload_stripper_3_empty"] = 0.1,
		["bipod_insert"] = 0.1,
		["bipod_firemode"] = 0.1,
		["bipod_firemode_aim"] = 0.1,
		["bipod_firemode_empty"] = 0.1,
		["bipod_firemode_empty_aim"] = 0.1,
		["bipod_out"] = 0.1,
		["bipod_out_empty"] = 0.1,

		["gl_off_pickup"] = 0.1,
		["gl_off_draw"] = -0.2,
		["gl_off_bolt"] = 0.1,
		["gl_off_bolt_aim"] = 0.1,
		["gl_off_reload"] = 0.1,
		["gl_off_reload_empty"] = 0.1,
		["gl_off_reload_start"] = 0.1,
		["gl_off_reload_start_empty"] = 0.1,
		["gl_off_reload_end"] = 0.1,
		["gl_off_reload_end_empty"] = 0.1,
		["gl_off_reload_stripper_1"] = 0.1,
		["gl_off_reload_stripper_1_empty"] = 0.1,
		["gl_off_reload_stripper_2"] = 0.1,
		["gl_off_reload_stripper_2_empty"] = 0.1,
		["gl_off_reload_stripper_3"] = 0.1,
		["gl_off_reload_stripper_3_empty"] = 0.1,
		["gl_off_insert"] = 0.1,
		-- ["gl_off_holster"] = 0.1,
		["gl_off_firemode"] = 0.1,
		["gl_off_firemode_aim"] = 0.1,

		["gl_on_draw"] = -0.2,
		["gl_on_reload"] = 0.1,
		["gl_on_reload_empty"] = 0.1,
		-- ["gl_on_holster"] = 0.1,

		["gl_turn_on"] = 0.1,
		["gl_turn_off"] = 0.1,
		["gl_turn_on_full"] = 0.1,
		["gl_turn_off_empty"] = 0.1,

		["throw"] = 0.1,
		["throw_cook"] = 0.1,
		["throw_short"] = 0.1,
	}

	// call me from init callback
	function SWEP:setupReticleInactivityCallbacks()
		self.animCallbacks = self.animCallbacks or {}

		local vm = self.CW_VM

		for animName,add in pairs(self.reticleInactivityCallbacksRaw) do
			if animName == "BaseClass" then
				continue
			end

			local seqName = self.Animations[animName]

			if not seqName then
				continue
			end

			if istable(seqName) then
				seqName = seqName[1]
			end

			local _, seqDur = vm:LookupSequence(seqName)

			if seqDur <= 0 then
				continue
			end

			local UnPredictedCurTime = UnPredictedCurTime
			local newFunc

			newFunc = function(wep)
				wep.reticleInactivity = UnPredictedCurTime() + seqDur + add
			end

			if self.animCallbacks[animName] then
				local oldFunc = self.animCallbacks[animName]
				self.animCallbacks[animName] = function(wep)
					newFunc(wep)
					oldFunc(wep)
				end
			else
				self.animCallbacks[animName] = newFunc
			end
		end

	end
end

//-----------------------------------------------------------------------------
// soundtable looping anims
//-----------------------------------------------------------------------------

if CLIENT then
	SWEP.soundTableLoopsRaw = {
		["base_crawl"] = true,
		["base_crawl_empty"] = true,
		["base_crawl_empty_mm"] = true,
		["foregrip_crawl"] = true,
		["foregrip_crawl_empty"] = true,
		["foregrip_crawl_empty_mm"] = true,
		["gl_off_crawl"] = true,
		["gl_off_crawl_empty"] = true,
		["gl_on_crawl"] = true,
		["gl_on_crawl_empty"] = true,
	}

	function SWEP:setupSoundTableLoops()
		local vm = self.CW_VM

		for animName,_ in pairs(self.soundTableLoopsRaw) do
			local seqName = self.Animations[animName]

			if not seqName or !isstring(seqName) then
				continue
			end

			local soundTable = self.Sounds[seqName]

			if not soundTable then
				continue
			end

			local _, seqDur = vm:LookupSequence(seqName)

			local patch = {
				kkwashere = true,
				time = seqDur,
				sound = "",
				callback = function(wep)
					wep.CurSoundTable = soundTable
					wep.CurSoundEntry = 0
					wep.SoundTime = UnPredictedCurTime()
					wep.SoundSpeed = 1
				end
			}

			local lastIndex = table.Count(soundTable)
			local lastEntry = soundTable[lastIndex]

			if lastEntry.kkwashere then // just to be sure we dont change weapons.GetStored
				soundTable[lastIndex] = patch
			else
				soundTable[lastIndex + 1] = patch
			end
		end
	end
end

//-----------------------------------------------------------------------------
// reload progress anims
//-----------------------------------------------------------------------------

if CLIENT then
	SWEP.reloadProgressAnimsRaw = {
		["base_reload"] = true,
		["base_reload_mm"] = true,
		["base_reload_empty"] = true,
		["base_reload_empty_mm"] = true,
		["base_reload_start"] = true,
		["base_reload_start_empty"] = true,
		["base_reload_end"] = true,
		["base_reload_end_empty"] = true,
		["base_reload_stripper_1"] = true,
		["base_reload_stripper_1_empty"] = true,
		["base_reload_stripper_2"] = true,
		["base_reload_stripper_2_empty"] = true,
		["base_reload_stripper_3"] = true,
		["base_reload_stripper_3_empty"] = true,
		["base_insert"] = true,

		["foregrip_reload"] = true,
		["foregrip_reload_mm"] = true,
		["foregrip_reload_empty"] = true,
		["foregrip_reload_empty_mm"] = true,
		["foregrip_reload_start"] = true,
		["foregrip_reload_start_empty"] = true,
		["foregrip_reload_end"] = true,
		["foregrip_reload_end_empty"] = true,
		["foregrip_reload_stripper_1"] = true,
		["foregrip_reload_stripper_1_empty"] = true,
		["foregrip_reload_stripper_2"] = true,
		["foregrip_reload_stripper_2_empty"] = true,
		["foregrip_reload_stripper_3"] = true,
		["foregrip_reload_stripper_3_empty"] = true,
		["foregrip_insert"] = true,

		["bipod_reload"] = true,
		["bipod_reload_mm"] = true,
		["bipod_reload_empty"] = true,
		["bipod_reload_empty_mm"] = true,
		["bipod_reload_start"] = true,
		["bipod_reload_start_empty"] = true,
		["bipod_reload_end"] = true,
		["bipod_reload_end_empty"] = true,
		["bipod_reload_stripper_1"] = true,
		["bipod_reload_stripper_1_empty"] = true,
		["bipod_reload_stripper_2"] = true,
		["bipod_reload_stripper_2_empty"] = true,
		["bipod_reload_stripper_3"] = true,
		["bipod_reload_stripper_3_empty"] = true,
		["bipod_insert"] = true,

		["gl_off_reload"] = true,
		["gl_off_reload_empty"] = true,
		["gl_off_reload_start"] = true,
		["gl_off_reload_start_empty"] = true,
		["gl_off_reload_end"] = true,
		["gl_off_reload_end_empty"] = true,
		["gl_off_reload_stripper_1"] = true,
		["gl_off_reload_stripper_1_empty"] = true,
		["gl_off_reload_stripper_2"] = true,
		["gl_off_reload_stripper_2_empty"] = true,
		["gl_off_reload_stripper_3"] = true,
		["gl_off_reload_stripper_3_empty"] = true,
		["gl_off_insert"] = true,

		["gl_on_reload"] = true,

		// test
		["gl_turn_on"] = true,
		["gl_turn_off"] = true,
		["gl_turn_on_full"] = true,
		["gl_turn_off_empty"] = true,
	}

	function SWEP:setupReloadProgressAnims()
		self.reloadProgressAnims = {}

		for animName, _ in pairs(self.reloadProgressAnimsRaw) do
			local seqName = self.Animations[animName]

			if not seqName then
				continue
			end

			if istable(seqName) then
				for _, seqName in pairs(seqName) do
					self.reloadProgressAnims[seqName] = (self.ReloadTimes and self.ReloadTimes[seqName]) and self.ReloadTimes[seqName][2]
				end
			else
				self.reloadProgressAnims[seqName] = (self.ReloadTimes and self.ReloadTimes[seqName]) and self.ReloadTimes[seqName][2]
			end
		end
	end
end

-- //-----------------------------------------------------------------------------
-- // no fix for prediction
-- //-----------------------------------------------------------------------------

-- if SP then return end

-- local db = {}
-- local kek

-- if CLIENT then
	-- fnuk = function(ply, old, new)
		-- db[old] = db[old] or {}
		-- db[new] = db[new] or {}

		-- if IsFirstTimePredicted() then
			-- if not db[old].holster then
				-- print("holstering", old)
				-- kek = old.holsterAnimFunc and old:holsterAnimFunc(true)
				-- db[old].holster = true
				-- db[old].draw = false
			-- end

			-- if not db[new].draw then
				-- print("drawing", new)
				-- kek = new.drawAnimFunc and new:drawAnimFunc(true)
				-- db[new].holster = false
				-- db[new].draw = true
			-- end
		-- end
	-- end

	-- hook.Add("PlayerSwitchWeapon", "CW_KK_INS2_ANIMS", fnuk)
-- end

-- if CLIENT then
	-- local Player = FindMetaTable("Player")
	-- local switch = {}

	-- function Player:SelectWeapon(class)
		-- if (!self:HasWeapon(class)) then return end
		-- switch[self] = self:GetWeapon(class)
	-- end

	-- local ply

	-- hook.Add("CreateMove", "CW_KK_INS2_ANIMS", function(cmd)
		-- ply = LocalPlayer()

		-- if (!IsValid(switch[ply])) then return end

		-- cmd:SelectWeapon(switch[ply])

		-- if (ply:GetActiveWeapon() == switch[ply]) then
			-- switch[ply] = nil
		-- end
	-- end)
-- end
