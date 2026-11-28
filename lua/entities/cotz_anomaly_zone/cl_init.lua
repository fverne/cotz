include("shared.lua")

local zoneTint = include("cotz/anomalies/cl_zonetint.lua")

function ENT:OnIdleThink()
	if not self.ScreenTint then return end

	zoneTint.Track(self, self.ScreenTint, self.TriggerMaxs.x)
end

function ENT:OnIdleSleep()
	zoneTint.Untrack(self)
end
