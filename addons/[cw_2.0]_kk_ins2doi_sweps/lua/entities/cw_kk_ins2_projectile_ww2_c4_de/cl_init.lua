include("shared.lua")

function ENT:Initialize()
	ParticleEffectAttach(self.fuseParticles, PATTACH_POINT_FOLLOW, self, 1)
end

function ENT:Draw()
	self.Entity:DrawModel()
end
