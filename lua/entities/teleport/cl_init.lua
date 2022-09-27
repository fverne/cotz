include("shared.lua")

function ENT:Initialize()
	self.particle = CreateParticleSystem( self, "teleport", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,0) )
	self:EmitSound("teleport_idle")
end

function ENT:Think()
	if not self.particle:IsValid() and not self:GetNWBool("StopParticle", false) then
		self.particle = CreateParticleSystem( self, "teleport", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,0) )
		self:EmitSound("teleport_idle")
	end
end