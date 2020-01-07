include("shared.lua")

function ENT:OnRemove()
	self.Emitter:Finish()
end

function ENT:Think()
	if CurTime() - self.LunchTime < 10 then
		self:DrawTrailParticle()
	end
end

function ENT:Draw()
	self:DrawModel()
end

local ten = 5

function ENT:kkTime()
	self.LunchTime = self.LunchTime or CurTime()

	return ten - math.Clamp(CurTime() - self.LunchTime, 0, ten)
end

function ENT:DrawTrailParticle()
	local part = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self:GetPos())
	part:SetStartSize(12)
	part:SetEndSize(32)
	part:SetStartAlpha(25 * self:kkTime())
	part:SetEndAlpha(0)
	part:SetDieTime(10)
	part:SetRoll(math.random(0, 360))
	part:SetRollDelta(0.01)
	part:SetColor(220, 220, 230)
	part:SetLighting(true)
	part:SetVelocity(VectorRand() * 2)
end
