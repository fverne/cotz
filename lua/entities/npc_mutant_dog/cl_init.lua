include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/slep_dog2.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/monsters/slep_dog2.mdl")
	self:DrawModel()
end