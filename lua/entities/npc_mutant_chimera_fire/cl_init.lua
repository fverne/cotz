include('shared.lua')

function ENT:Initialize()
	self.particle = CreateParticleSystem( self, "kometa_trail", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,16) )
	self.RealModel = "models/monsters/chimera2.mdl"
end

function ENT:Draw()
	if not self.particle:IsValid() then
		self.particle = CreateParticleSystem( self, "kometa_trail", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,16) )
	end
	self:SetModel("models/monsters/chimera2.mdl")
	self:DrawModel()
end