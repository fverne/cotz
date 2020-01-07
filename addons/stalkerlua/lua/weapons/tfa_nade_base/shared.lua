DEFINE_BASECLASS("tfa_gun_base")

SWEP.MuzzleFlashEffect = ""
SWEP.data 				= {}
SWEP.data.ironsights			= 0

SWEP.Delay = 0.3 -- Delay to fire entity
SWEP.Primary.Round = ("") -- Nade Entity
SWEP.Velocity = 550 -- Entity Velocity


function SWEP:Initialize()
	
	self:SetWeaponHoldType(self.HoldType)
	
	self:SetHoldType(self.HoldType)
	
	if (!self.Primary.Damage) or (self.Primary.Damage<=0.01) then
		self:AutoDetectDamage()
	end
	
	if !self.Primary.Accuracy then
		if self.Primary.ConeSpray then
			self.Primary.Accuracy  = ( 5 / self.Primary.ConeSpray) / 90
		else
			self.Primary.Accuracy = 0.01
		end
	end
	
	if !self.Primary.IronAccuracy then
		self.Primary.IronAccuracy = self.Primary.Accuracy * 0.2
	end
	
	if GetConVarNumber("sv_tfa_blacklist_"..self.Gun,0)==1  then
		self.Spawnable				= false
		self.AdminSpawnable			= false
		
		if SERVER then
			timer.Simple(0, function()
				if IsValid(self) then
					if IsValid(self.Owner) then
						print("Blacklisted weapon was spawned by:")
						print(self.Owner)
						self.Owner:StripWeapon(self:GetClass())
						if self.Owner.SetAmmo then
							self.Owner:SetAmmo( math.Clamp(self:GetAmmoReserve()-self.Primary.DefaultClip,0,99999),self:GetPrimaryAmmoType())
						end
					end
				end
			end)
		end
	end
	
	if self.MuzzleAttachment == "1" then
		self.CSMuzzleFlashes = true
	end
	
	if self.Akimbo then
		self.AutoDetectMuzzleAttachment = true
		self.MuzzleAttachmentRaw = 2-self.AnimCycle
	end	
	
	self:CreateFireModes()
	
	self:AutoDetectMuzzle()
	
	self:AutoDetectRange()
	
	self.DefaultHoldType = self.HoldType
	self.ViewModelFOVDefault = self.ViewModelFOV
	
	self.DrawCrosshairDefault = self.DrawCrosshair
	
	self:SetUpSpread()
	
	self:CorrectScopeFOV( self.DefaultFOV and self.DefaultFOV or self.Owner:GetFOV() )
	
	if CLIENT then
		self:InitMods()
		self:IconFix()
	end
	self.drawcount=0
	self.drawcount2=0
	self.canholster=false
	
	self:DetectValidAnimations()
	self:SetDeploySpeed(self.SequenceLength[ACT_VM_DRAW])
	
	if !self.Primary.ClipMax then
		self.Primary.ClipMax = self.Primary.ClipSize * 3
	end
	
	self:ResetEvents()

	self.ProjectileEntity = self.Primary.Round --Entity to shoot
	self.ProjectileVelocity = self.Velocity and self.Velocity or 550 --Entity to shoot's velocity
	self.ProjectileModel = nil --Entity to shoot's model

end

function SWEP:ChooseShootAnim()
	if !self:OwnerIsValid() then return end
	--self:ResetEvents()
	local tanim=ACT_VM_THROW
	local success = true
	self:SendWeaponAnim(ACT_VM_THROW)
	
	if game.SinglePlayer() then
		self:CallOnClient("AnimForce",tanim)
	end
	
	self.lastact = tanim
	return success, tanim
end

function SWEP:DoAmmoCheck()
	if IsValid(self) then
		if SERVER then 
			local vm = self.Owner:GetViewModel()
			if !IsValid(vm) then return end
			if self:Clip1() <= 0 && self.Owner:GetAmmoCount( self:GetPrimaryAmmoType() ) == 0 then
				timer.Simple(vm:SequenceDuration(), function()
					if SERVER then
						if IsValid(self) then
							if IsValid(self.Owner) then
								self.Owner:StripWeapon(self.Gun)
							end
						end
					end
				end)
			elseif self:Clip1() == 0  and self.Owner:GetAmmoCount( self:GetPrimaryAmmoType() ) > 0 then
				self:TakePrimaryAmmo( 1 )
				self:SetClip1(1)
				timer.Simple(vm:SequenceDuration(), function()
					if IsValid(self) then
						self:ChooseDrawAnim()
					end
				end)
			end
		end
	end
end

function SWEP:PrimaryAttack()
	
	if ( self:GetHolstering() ) then
		if (self.ShootWhileHolster==false) then
			return
		else
			self:SetHolsteringEnd(CurTime()-0.1)
			self:SetHolstering(false)
		end
	end
	
	if (self:GetReloading() and self.Shotgun and !self:GetShotgunPumping() and !self:GetShotgunNeedsPump()) then
		self:SetShotgunCancel( true )
		--[[
		self:SetShotgunInsertingShell(true)
		self:SetShotgunPumping(false)
		self:SetShotgunNeedsPump(true)
		self:SetReloadingEnd(CurTime()-1)
		]]--
		return
	end
	
	if self:IsSafety() then self.Weapon:EmitSound("Weapon_AR2.Empty") return end
	
	if (self:GetChangingSilence()) then return end
	
	if (self:GetNearWallRatio()>0.05) then
		return
	end
	
	if !self:OwnerIsValid() then return end
	
	if self.FiresUnderwater == false and self.Owner:WaterLevel()>=3 then
		if self:CanPrimaryAttack() then
			self:SetNextPrimaryFire(CurTime()+0.5)
			self.Weapon:EmitSound("Weapon_AR2.Empty")
		end
		return
	end
	
	if (self.Owner:KeyDown(IN_USE) and self.CanBeSilenced and self.Owner:KeyPressed(ACT_VM_PRIMARYATTACK)  ) then
	
		if ( self:CanPrimaryAttack() and !self:GetChangingSilence() ) then
			--self:SetSilenced(!self:GetSilenced())
			local success, tanim = self:ChooseSilenceAnim(!self:GetSilenced())
			self:SetChangingSilence(true)
			self:SetNextSilenceChange(CurTime()+self.SequenceLength[tanim])
			self:SetNextPrimaryFire(CurTime()+1/(self:GetRPM()/60))
		end
		
		return
	end
	
	if self:GetNextPrimaryFire()>CurTime() then return end
	
	if self:GetReloading() then
		self:CompleteReload()
	end
	
	if !self:CanPrimaryAttack() then return end
	
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
		if  self:GetRunSightsRatio()<0.1 then--and self:GetReloading()==false then
			self:ResetEvents()
			self:SetInspecting(false)
			self:SetInspectingRatio(0)
			self:SetInspectingRatio(0)
			self:SendWeaponAnim(0)
			timer.Simple(self.Delay and self.Delay or 0.3, function()
				if IsValid(self) then
					self:ShootBulletInformation()
				end
			end)
			local success, tanim = self:ChooseShootAnim( ) -- View model animation
			if self:OwnerIsValid() and self.Owner.SetAnimation then
				self.Owner:SetAnimation( PLAYER_ATTACK1 ) -- 3rd Person Animation
			end
			self:TakePrimaryAmmo(1)
			self.PenetrationCounter = 0
			self:SetShooting(true)
			local vm = self.Owner:GetViewModel()
			if tanim then
				local seq = vm:SelectWeightedSequence(tanim)
				self:SetShootingEnd(CurTime()+vm:SequenceDuration( seq ))
			else
				self:SetShootingEnd(CurTime()+vm:SequenceDuration( ))
			end
			if self.BoltAction then
				self:SetBoltTimer(true)
				local t1, t2
				t1=CurTime()+self.BoltTimerOffset
				t2=CurTime()+vm:SequenceDuration( seq )
				if t1<t2 then
					self:SetBoltTimerStart(t1)
					self:SetBoltTimerEnd(t2)
				else
					self:SetBoltTimerStart(t2)
					self:SetBoltTimerEnd(t1)
				end
			end
			
			self:SetSpreadRatio(math.Clamp(self:GetSpreadRatio() + self.Primary.SpreadIncrement, 1, self.Primary.SpreadMultiplierMax))
			if ( CLIENT or game.SinglePlayer() ) and ( IsFirstTimePredicted() ) then
				self.CLSpreadRatio = math.Clamp(self.CLSpreadRatio + self.Primary.SpreadIncrement, 1, self.Primary.SpreadMultiplierMax)
			end
			self:SetBursting(true)
	
			self:SetNextBurst(CurTime()+1/(self:GetRPM()/60))
			self:SetBurstCount(self:GetBurstCount()+1)
			
			self:SetNextPrimaryFire(CurTime()+1/(self:GetRPM()/60))
			
			if !self:GetSilenced() then
				if self.Primary.Sound then
					self:PlaySound(self.Primary.SoundTable and self.Primary.SoundTable or self.Primary.Sound)
				end
			else
				if self.Primary.SilencedSound then
					self:PlaySound(self.Primary.SilencedSound)
				elseif self.Primary.Sound then
					self:PlaySound(self.Primary.SoundTable and self.Primary.SoundTable or self.Primary.Sound)
				end
			end
			
			self:DoAmmoCheck()
		end
	end
end