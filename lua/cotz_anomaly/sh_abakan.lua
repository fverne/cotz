-- Preserve the newer pack's AN-94 first-shot interval and second-shot recoil suppression.
function SWEP:PrimaryAttack()
	local now = CurTime()

	if now > (self.AnomalyLastShot or 0) + self.AnomalyRecoilResetDelay then
		self.AnomalyShotsFired = 0
	end

	local fired = self.AnomalyShotsFired or 0
	local automatic = self.FireMode == "auto"
	local burst = self.FireMode == "2burst"
	local firstShot = (automatic and fired == 0) or (burst and self.dt.Shots == 0)
	self.FireDelay = firstShot and 60 / self.AnomalyHyperburstRPM or self.FireDelay_Orig * self.FireDelayMult
	self.AnomalySkipRecoil = (automatic and fired == 1)
		or (burst and self.dt.Shots == 1 and self:Clip1() > 1)
	local clip = self:Clip1()
	baseclass.Get("cw_anomaly_gun_base").PrimaryAttack(self)

	if self:Clip1() < clip and IsFirstTimePredicted() then
		self.AnomalyLastShot = now + self.FireDelay
		self.AnomalyShotsFired = fired + 1
	end
end

function SWEP:simulateRecoil()
	if self.AnomalySkipRecoil then return end

	return baseclass.Get("cw_base").simulateRecoil(self)
end
