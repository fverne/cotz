include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/izlom.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/monsters/izlom.mdl")
	self:DrawModel()
end