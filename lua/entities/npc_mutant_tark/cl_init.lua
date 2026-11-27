include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/tark.mdl"
end

function ENT:Draw()
	
	self:DrawModel()
end