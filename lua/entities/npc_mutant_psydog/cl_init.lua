include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/psydog.mdl"
end

function ENT:Draw()
	
	self:DrawModel()
end