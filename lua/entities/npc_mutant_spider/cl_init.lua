include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/darkmessiah/spider_regular.mdl"
end

function ENT:Draw()
	
	self:DrawModel()
end