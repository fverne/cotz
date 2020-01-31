include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/maver1k_XVII/Stalker/mutants/karlik.mdl"
end

function ENT:Draw()

	self:SetModel("models/maver1k_XVII/Stalker/mutants/karlik.mdl")
	self:DrawModel()
end