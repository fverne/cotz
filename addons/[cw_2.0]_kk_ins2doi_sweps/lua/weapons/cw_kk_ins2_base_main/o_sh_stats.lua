
function SWEP:recalculateHolsterTime()
	self.HolsterSpeed = self.HolsterSpeed_Orig * self.HolsterSpeedMult
end

function SWEP:recalculateBoltActionSpeed()
	self.BoltActionSpeed = self.BoltActionSpeed_Orig * self.BoltActionSpeedMult
end

function SWEP:recalculateStats()
	-- recalculates all stats
	self:recalculateDamage()
	self:recalculateRecoil()
	self:recalculateFirerate()
	self:recalculateVelocitySensitivity()
	self:recalculateAimSpread()
	self:recalculateHipSpread()
	self:recalculateDeployTime()
	self:recalculateReloadSpeed()
	self:recalculateClumpSpread()

	if CLIENT then
		self:recalculateMouseSens()
	end

	self:recalculateMaxSpreadInc()

	self:recalculateHolsterTime()
	self:recalculateBoltActionSpeed()
end
