include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/boar.mdl"
end

function ENT:Draw()
	
	self:DrawModel()
end