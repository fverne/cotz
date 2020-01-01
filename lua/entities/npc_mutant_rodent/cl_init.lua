include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/stalkertnb/rodent1.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/stalkertnb/rodent1.mdl")
	self:DrawModel()
end