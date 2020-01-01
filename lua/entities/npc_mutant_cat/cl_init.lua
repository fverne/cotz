include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/jerry/mutants/stalker_anomaly_ca1.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/jerry/mutants/stalker_anomaly_ca1.mdl")
	self:DrawModel()
end