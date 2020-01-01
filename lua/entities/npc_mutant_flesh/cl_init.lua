include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/jerry/mutants/stalker_anomaly_flesh.mdl"
end

function ENT:Draw()
	
	self:SetModel("models/jerry/mutants/stalker_anomaly_flesh.mdl")
	self:DrawModel()
end