include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/psydog2.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/monsters/psydog2.mdl")
	self:DrawModel()
end