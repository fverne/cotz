include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/stalkertnb/zombie1.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/stalkertnb/zombie1.mdl")
	self:DrawModel()
end