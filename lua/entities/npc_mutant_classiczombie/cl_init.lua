include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/zombie.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/monsters/zombie.mdl")
	self:DrawModel()
end