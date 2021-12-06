include('shared.lua')

function ENT:Initialize()
	self.particle = CreateParticleSystem( self, "electra_static", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,16) )
	self.RealModel = "models/monsters/controler_big.mdl"
end

function ENT:Draw()
	if not self.particle:IsValid() then
		self.particle = CreateParticleSystem( self, "electra_static", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,16) )
	end
	self:SetModel("models/monsters/controler_big.mdl")
	self:DrawModel()
end