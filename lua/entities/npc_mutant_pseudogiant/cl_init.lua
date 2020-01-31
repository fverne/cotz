include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/stalkertnb/pseudogiant2.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/stalkertnb/pseudogiant2.mdl")
	self:DrawModel()
end