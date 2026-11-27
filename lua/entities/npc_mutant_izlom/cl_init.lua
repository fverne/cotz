include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/izlom.mdl"
end

function ENT:Draw()
	
	self:DrawModel()
end