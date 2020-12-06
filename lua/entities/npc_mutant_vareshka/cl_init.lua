include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/vareshka.mdl"
end

function ENT:Draw()
	self:SetModel("models/monsters/vareshka.mdl")
	self:DrawModel()
end