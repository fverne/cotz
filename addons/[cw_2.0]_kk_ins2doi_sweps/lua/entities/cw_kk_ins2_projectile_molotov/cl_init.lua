include("shared.lua")

function ENT:Initialize()
	ParticleEffectAttach(self.fuseParticles, PATTACH_POINT_FOLLOW, self, 1)
end

function ENT:Draw()
	self.Entity:DrawModel()
end

function ENT:Think()
	if self:WaterLevel() == 0 then
		local dlight = DynamicLight(self:EntIndex())

		dlight.r = 255
		dlight.g = 110
		dlight.b = 74
		dlight.Brightness = 0
		dlight.Pos = self:GetPos()
		dlight.Size = 64
		dlight.Decay = 256
		dlight.DieTime = CurTime() + FrameTime()
	end
end
