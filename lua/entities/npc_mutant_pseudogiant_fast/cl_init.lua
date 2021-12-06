include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/gigant.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/monsters/gigant.mdl")
	self:DrawModel()
end