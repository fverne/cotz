include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/vareshka.mdl"
end

function ENT:Draw()
	self:DrawModel()
end