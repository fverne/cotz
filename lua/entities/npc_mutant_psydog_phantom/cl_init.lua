include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/jerry/mutants/stalker_anomaly_pseudodog.mdl"
end

function ENT:Draw()

	self:SetColor(Color(255,255,255,220))
	self:DrawShadow( false ) 

	self:SetModel("models/jerry/mutants/stalker_anomaly_pseudodog.mdl")
	self:DrawModel()
end