include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/chimera2.mdl"
end

function ENT:Draw()
	self:DrawModel()
end