include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/boar.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/monsters/boar.mdl")
	self:DrawModel()
end