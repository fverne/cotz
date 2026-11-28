include("shared.lua")

local psy = include("cotz/anomalies/cl_psy.lua")

function ENT:OnIdleThink()
	local distance = LocalPlayer():GetPos():Distance(self:GetPos())
	psy.SetDepth(self, 1 - math.min(distance / self.BalanceRadius, 1))
end

function ENT:OnIdleSleep()
	psy.SetDepth(self, 0)
end
