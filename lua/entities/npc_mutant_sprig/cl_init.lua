include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/zanoza.mdl"
end

function ENT:Draw()
	
	self:DrawModel()
end