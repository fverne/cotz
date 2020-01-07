include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/stalkertnb/chimera1.mdl"
end

function ENT:Draw()
	self:SetModel("models/stalkertnb/chimera1.mdl")
	self:DrawModel()
end