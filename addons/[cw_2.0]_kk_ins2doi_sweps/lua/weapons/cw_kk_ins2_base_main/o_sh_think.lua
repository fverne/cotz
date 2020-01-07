
//-----------------------------------------------------------------------------
// Think edited to finish shotgun reload using separate function
// SWEP:finishReloadShotgun()
//-----------------------------------------------------------------------------

local math = math

local SP = game.SinglePlayer()

local vm, CT, aim, cone, vel

local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length

local IFTP
local wl, ws
local timerdelay = 0

function SWEP:Think()
	-- in vehicle? can't do anything, also prevent needless calculations of stuff
	
	if timerdelay < CurTime() then
		timerdelay = CurTime() + 0.5
		local client = self.Owner
		hook.Run("AmmoCheck", client, self)
	end
	
	if self.Owner:InVehicle() and not self.Owner:GetAllowWeaponsInVehicle() then
		self.dt.State = CW_ACTION
		return
	end

	CustomizableWeaponry.actionSequence.process(self)

	if self.dt.State == CW_HOLSTER_START then
		return
	end

	CT = CurTime()

	if CLIENT then
		if self.SubCustomizationCycleTime then
			if UnPredictedCurTime() > self.SubCustomizationCycleTime then
				CustomizableWeaponry.cycleSubCustomization(self)
			end
		end
	end

	if self.HoldToAim then
		if (SP and SERVER) or not SP then
			if self.dt.State == CW_AIMING then
				if not self.Owner:OnGround() or Length(GetVelocity(self.Owner)) >= self.Owner:GetWalkSpeed() * self.LoseAimVelocity or not self.Owner:KeyDown(IN_ATTACK2) then
					self.dt.State = CW_IDLE
					self:SetNextSecondaryFire(CT + 0.2)
					self:EmitSound("CW_LOWERAIM")
					self:aimIdleAnimFunc()
				end
			end
		end
	end

	if self.IndividualThink then
		self:IndividualThink()

		if not IsValid(self) or not IsValid(self.Owner) then
			return
		end
	end

	vel = Length(GetVelocity(self.Owner))
	IFTP = IsFirstTimePredicted()

	if (not SP and IFTP) or SP then
		self:CalculateSpread(vel, FrameTime())
	end

	if CT > self.GlobalDelay then
		wl = self.Owner:WaterLevel()

		if self.Owner:OnGround() then
			if wl >= 3 and self.HolsterUnderwater then
				if self.ShotgunReloadState == 1 then
					self.ShotgunReloadState = 2
				end

				self.dt.State = CW_ACTION
				self.FromActionToNormalWait = CT + 0.3
			else
				ws = self.Owner:GetWalkSpeed()

				if ((vel > ws * self.RunStateVelocity and self.Owner:KeyDown(IN_SPEED)) or vel > ws * 3 or (self.ForceRunStateVelocity and vel > self.ForceRunStateVelocity)) and self.SprintingEnabled then
					self.dt.State = CW_RUNNING
				else
					if self.dt.State != CW_AIMING and self.dt.State != CW_CUSTOMIZE then
						if CT > self.FromActionToNormalWait then
							if self.dt.State != CW_IDLE then
								self.dt.State = CW_IDLE

								if not self.ReloadDelay then
									self:SetNextPrimaryFire(CT + 0.3)
									self:SetNextSecondaryFire(CT + 0.3)
									self.ReloadWait = CT + 0.3
								end
							end
						end
					end
				end
			end
		else
			if (wl > 1 and self.HolsterUnderwater) or (self.Owner:GetMoveType() == MOVETYPE_LADDER and self.HolsterOnLadder) then
				if self.ShotgunReloadState == 1 then
					self.ShotgunReloadState = 2
				end

				self.dt.State = CW_ACTION
				self.FromActionToNormalWait = CT + 0.3
			else
				if CT > self.FromActionToNormalWait then
					if self.dt.State != CW_IDLE then
						self.dt.State = CW_IDLE
						self:SetNextPrimaryFire(CT + 0.3)
						self:SetNextSecondaryFire(CT + 0.3)
						self.ReloadWait = CT + 0.3
					end
				end
			end
		end
	end

	if SERVER then
		if self.CurSoundTable then
			local t = self.CurSoundTable[self.CurSoundEntry]

			--[[if CLIENT then
				if CT >= self.SoundTime + t.time / self.SoundSpeed then
					self:EmitSound(t.sound, 70, 100)
					if self.CurSoundTable[self.CurSoundEntry + 1] then
						self.CurSoundEntry = self.CurSoundEntry + 1
					else
						self.CurSoundTable = nil
						self.CurSoundEntry = nil
						self.SoundTime = nil
					end
				end
			else]]--
			if CT >= self.SoundTime + t.time / self.SoundSpeed then
				self:EmitSound(t.sound, 70, 100)

				if self.CurSoundTable[self.CurSoundEntry + 1] then
					self.CurSoundEntry = self.CurSoundEntry + 1
				else
					self.CurSoundTable = nil
					self.CurSoundEntry = nil
					self.SoundTime = nil
				end
			end
			--end
		end
	end

	if self.dt.Shots > 0 then
		if not self.Owner:KeyDown(IN_ATTACK) then
			if self.BurstAmount and self.BurstAmount > 0 then
				self.dt.Shots = 0
				self:SetNextPrimaryFire(CT + self.FireDelay * self.BurstCooldownMul)
				self.ReloadWait = CT + self.FireDelay * self.BurstCooldownMul
			end
		end
	end

	if not self.ShotgunReload then
		if self.ReloadDelay and CT >= self.ReloadDelay then
			self:finishReload() -- more like finnishReload ;0
		end
	end

	if IFTP then
		self:finishReloadShotgun()
	end

	if SERVER then
		if self.dt.Safe then
			if self.CHoldType != self.RunHoldType then
				self:SetHoldType(self.RunHoldType)
				self.CHoldType = self.RunHoldType
			end
		else
			if self.dt.State == CW_RUNNING or self.dt.State == CW_ACTION then
				if self.CHoldType != self.RunHoldType then
					self:SetHoldType(self.RunHoldType)
					self.CHoldType = self.RunHoldType
				end
			else
				if self.CHoldType != self.NormalHoldType then
					self:SetHoldType(self.NormalHoldType)
					self.CHoldType = self.NormalHoldType
				end
			end
		end
	end

	if (SP and SERVER) or not SP then -- if it's SP, then we run it only on the server (otherwise shit gets fucked); if it's MP we predict it
		-- if the bipod DT var is true, or if we have a bipod deploy angle
		if self.dt.BipodDeployed or self.DeployAngle then
			-- check whether the bipod can be placed on the current surface (so we don't end up placing on nothing)

			if not self:CanRestWeapon(self.BipodDeployHeightRequirement) then
				self.dt.BipodDeployed = false
				self.DeployAngle = nil

				if not self.ReloadDelay then
					if CT > self.BipodDelay then
						self:performBipodDelay(self.BipodUndeployTime)
					else
						self.BipodUnDeployPost = true
					end
				else
					self.BipodUnDeployPost = true
				end
			end
		end

		if not self.ReloadDelay then
			if self.BipodUnDeployPost then
				if CT > self.BipodDelay then
					if not self:CanRestWeapon(self.BipodDeployHeightRequirement) then
						self:performBipodDelay(self.BipodUndeployTime)
						self.BipodUnDeployPost = false
					else
						self.dt.BipodDeployed = true

						self:setupBipodVars()
						self.BipodUnDeployPost = false
					end
				end
			end

			if self.Owner:KeyPressed(IN_USE) then
				if CT > self.BipodDelay and CT > self.ReloadWait then
					if self.BipodInstalled then
						if self.dt.BipodDeployed then
							self.dt.BipodDeployed = false
							self.DeployAngle = nil

							self:performBipodDelay(self.BipodUndeployTime)
						else
							self.dt.BipodDeployed = self:CanRestWeapon(self.BipodDeployHeightRequirement)

							if self.dt.BipodDeployed then
								self:performBipodDelay(self.BipodDeployTime)
								self:setupBipodVars()
							end
						end
					end
				end
			end
		end
	end

	if self.forcedState then
		if CT < self.ForcedStateTime then
			self.dt.State = self.forcedState
		else
			self.forcedState = nil
		end
	end
end
