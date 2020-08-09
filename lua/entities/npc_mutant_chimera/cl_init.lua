include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/chimera.mdl"
end

function ENT:Draw()
	self:SetModel("models/monsters/chimera.mdl")
	self:DrawModel()
end