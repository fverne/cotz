include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/stalker/new_izlom_spen.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/stalker/new_izlom_spen.mdl")
	self:DrawModel()
end