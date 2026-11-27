include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/psydog.mdl"
end

function ENT:Draw()

	self:SetColor(Color(255,255,255,220))
	self:DrawShadow( false ) 

	self:DrawModel()
end