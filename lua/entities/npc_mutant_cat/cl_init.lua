include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/cat.mdl"
end

function ENT:Draw()
	
	self:DrawModel()
end