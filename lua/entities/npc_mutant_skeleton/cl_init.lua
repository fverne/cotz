include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/skelet.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/monsters/skelet.mdl")
	self:DrawModel()
end