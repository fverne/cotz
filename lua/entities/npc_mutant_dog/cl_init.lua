include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/stalkertnb/dog1.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/stalkertnb/dog1.mdl")
	self:DrawModel()
end