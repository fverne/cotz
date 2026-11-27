include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/slep_dog2.mdl"
end

function ENT:Draw()
	
	self:DrawModel()
end