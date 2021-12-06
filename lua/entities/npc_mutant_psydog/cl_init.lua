include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/psydog.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/monsters/psydog.mdl")
	self:DrawModel()
end