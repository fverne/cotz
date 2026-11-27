include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/plot.mdl"
end

function ENT:Draw()
	
	self:DrawModel()
end