include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/bear.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/monsters/bear.mdl")
	self:DrawModel()
end