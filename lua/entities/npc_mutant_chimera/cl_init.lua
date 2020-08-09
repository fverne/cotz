include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/chimera2.mdl"
end

function ENT:Draw()
	self:SetModel("models/monsters/chimera2.mdl")
	self:DrawModel()
end