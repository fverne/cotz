include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/gigant3.mdl"
end

function ENT:Draw()
	
	self:DrawModel()
end