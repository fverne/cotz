include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/cat.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/monsters/cat.mdl")
	self:DrawModel()
end