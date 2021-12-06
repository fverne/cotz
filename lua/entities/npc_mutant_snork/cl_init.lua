include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/snork2.mdl"
end

function ENT:Draw()
	self:SetModel("models/monsters/snork2.mdl")
	self:DrawModel()
end