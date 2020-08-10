include('shared.lua')

function ENT:Initialize()
	self.particle = CreateParticleSystem( self, "gazirovka", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,32) )
	self.RealModel = "models/monsters/zombie2.mdl"
end

function ENT:Draw()
	if (!self.particle and !self.particle:IsValid())  then
		self.particle = CreateParticleSystem( self, "gazirovka", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,32) )
	end
	self:SetModel("models/monsters/zombie2.mdl")
	self:DrawModel()
end