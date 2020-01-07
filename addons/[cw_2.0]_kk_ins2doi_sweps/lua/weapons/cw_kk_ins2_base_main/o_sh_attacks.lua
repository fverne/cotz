local SP = game.SinglePlayer()

//-----------------------------------------------------------------------------
// PrimaryAttack edited to support
// - customized M203/grenade launcher
// - dry-fire animations
// - custom muzzle flash lua effect
//-----------------------------------------------------------------------------

local IFTP, CT

function SWEP:PrimaryAttack()
	if self.boltAction_isShot then return end
	
	if self:IsOwnerCrawling() then
		return false
	end

	if not self:canFireWeapon(1) then
		return false
	end

	if self.Owner:KeyDown(IN_USE) then
		if CustomizableWeaponry_KK.ins2.quickGrenade:canThrow(self) then
			CustomizableWeaponry_KK.ins2.quickGrenade:throw(self)
			return
		end
	end

	if not self:canFireWeapon(2) then
		return false
	end

	if not self:canFireWeapon(3) then
		return false
	end
	
	if self.dt.Safe then
		return false
	end

	IFTP = IsFirstTimePredicted()

	if self.dt.INS2GLActive then
		if IFTP and ((SP and SERVER) or (!SP and CLIENT)) then
			self:fireAnimFunc()
		end

		if self.M203Chamber then
			self:fireM203(IFTP)
		else
			self:SetNextPrimaryFire(CurTime() + 0.5)
		end

		return
	end

	if self:Clip1() == 0 then
		if IFTP and ((SP and SERVER) or (!SP and CLIENT)) then
			self:fireAnimFunc()
		end

		self:SetNextPrimaryFire(CurTime() + 0.3)

		return
	end

	if self.BurstAmount and self.BurstAmount > 0 then
		if self.dt.Shots >= self.BurstAmount then
			return
		end

		self.dt.Shots = self.dt.Shots + 1
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	CT = CurTime()

	if IFTP then
	    hook.Run("WeaponFired", self.Owner)
		if self.projectileClass then
			if ((SP and SERVER) or (!SP and CLIENT)) then
				self:fireAnimFunc()
			end

			local delay = self.hipBulletDelay or 0

			if self:isAiming() then
				delay = 0
			end

			CustomizableWeaponry.actionSequence.new(self, delay, nil, function()
				local muzzleData = EffectData()
				muzzleData:SetEntity(self)
				util.Effect("cw_kk_ins2_muzzleflash", muzzleData)

				self:EmitSound(self.FireSound, 105, 100)

				CustomizableWeaponry_KK.ins2.rpgs.fireShared(self, true, true)
				self:makeFireEffects()
				self:MakeRecoil()
			end)
		else
			local muzzleData = EffectData()
			muzzleData:SetEntity(self)
			util.Effect("cw_kk_ins2_muzzleflash", muzzleData)

			if self.dt.Suppressed then
				self:EmitSound(self.FireSoundSuppressed, 105, 100)
			else
				self:EmitSound(self.FireSound, 105, 100)
			end

			if ((SP and SERVER) or (!SP and CLIENT)) then
				self:fireAnimFunc()
			end

			self:FireBullet(self.Damage, self.CurCone, self.ClumpSpread, self.Shots)
			self:makeFireEffects()
			self:MakeRecoil()
		end

		self:addFireSpread(CT)

		if CLIENT then
			self:simulateRecoil()
		end

		if SP and SERVER then
			SendUserMessage("CW_Recoil", self.Owner)
		end

		-- apply a global delay after shooting, if there is one
		if self.GlobalDelayOnShoot then
			self.GlobalDelay = CT + self.GlobalDelayOnShoot
		end
	end

	CustomizableWeaponry.callbacks.processCategory(self, "postFire")

	local suppressAmmoUsage = CustomizableWeaponry.callbacks.processCategory(self, "shouldSuppressAmmoUsage")

	if not suppressAmmoUsage then
		self:TakePrimaryAmmo(self.AmmoPerShot)
		self.boltAction_isShot = self.Animations.base_bolt != nil // temp chk2
	end

	if self:Clip1() == 0 then
		self:SetNextPrimaryFire(CT + math.Clamp(self.FireDelay, 0.5, self.FireDelay))
	else
		self:SetNextPrimaryFire(CT + self.FireDelay)
	end

	-- either force the weapon back to hip after firing, or don't
	if self.ForceBackToHipAfterAimedShot then
		self.dt.State = CW_IDLE
		self:SetNextSecondaryFire(CT + self.ForcedHipWaitTime)
	else
		self:SetNextSecondaryFire(CT + self.FireDelay)
	end

	self.ReloadWait = CT + (self.WaitForReloadAfterFiring and self.WaitForReloadAfterFiring or self.FireDelay)

	self:postPrimaryAttack()
	CustomizableWeaponry.callbacks.processCategory(self, "postConsumeAmmo")

	if SP and SERVER then
		SendUserMessage("CW_PostFire", self.Owner)
	end
end

//-----------------------------------------------------------------------------
// SecondaryAttack edited to
// - support customized grenade launcher
// - ignore near-wall holster (like in INS2)
//-----------------------------------------------------------------------------

local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length

function SWEP:SecondaryAttack()
	if self:IsOwnerCrawling() then
		return
	end

	if self.ShotgunReloadState != 0 then
		return
	end

	if self.ReloadDelay then
		return
	end

	if CurTime() < self.GlobalDelay then
		return false
	end

	if self.dt.Safe then
		return false
	end

	if self.InactiveWeaponStates[self.dt.State] or (self.dt.State == CW_AIMING and self.HoldToAim) then
		return
	end

	IFTP = IsFirstTimePredicted()

	if self.Owner:KeyDown(IN_USE) then
		if self:hasInstalledGL() then
			if self.ToggleM203States[self.dt.State] then
				self:toggleGLMode(IFTP)

				return
			end
		end
	end

	if not self.Owner:OnGround() or Length(GetVelocity(self.Owner)) >= self.Owner:GetWalkSpeed() * self.RunStateVelocity then
		return
	end

	CT = CurTime()

	if self.dt.State ~= CW_AIMING then
		self.dt.State = CW_AIMING

		if self:filterPrediction() then
			self:aimIdleAnimFunc()
			self:EmitSound("CW_TAKEAIM")
		end
	else
		self.dt.State = CW_IDLE

		if self:filterPrediction() then
			self:aimIdleAnimFunc()
			self:EmitSound("CW_LOWERAIM")
		end
	end

	if IFTP then
		self.AimTime = UnPredictedCurTime() + 0.25

		if self.PreventQuickScoping then
			self.AddSpread = math.Clamp(self.AddSpread + 0.03, 0, self.MaxSpreadInc)
			self.SpreadWait = CT + 0.3
		end
	end

	if SP and SERVER then
		SendUserMessage("CW_AimTime", self.Owner)
	end

	self:SetNextSecondaryFire(CT + 0.1)
end