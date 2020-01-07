include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/stalkertnb/snork1.mdl"
end

function ENT:Draw()
	self:SetModel("models/stalkertnb/snork1.mdl")
	self:DrawModel()
end