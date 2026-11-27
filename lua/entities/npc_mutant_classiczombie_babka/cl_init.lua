include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/babka.mdl"
end

function ENT:Draw()
	
	self:DrawModel()
end