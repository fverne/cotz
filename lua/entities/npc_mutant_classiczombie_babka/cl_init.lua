include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/babka.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/monsters/babka.mdl")
	self:DrawModel()
end