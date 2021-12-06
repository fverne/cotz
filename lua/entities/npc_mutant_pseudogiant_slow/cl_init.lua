include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/gigant3.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/monsters/gigant3.mdl")
	self:DrawModel()
end