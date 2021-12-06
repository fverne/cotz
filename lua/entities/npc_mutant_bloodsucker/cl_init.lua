include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/krovosos.mdl"
end

function ENT:Draw()
	self:SetModel("models/monsters/krovosos.mdl")
	local TEMP_SelfMat = self:GetMaterial()
	local distance = (self:GetPos():Distance(LocalPlayer():GetPos()))
	if distance > 150 then
		self:SetMaterial("models/shadertest/predator")
		self:DrawShadow( false ) 
	else
		self:SetMaterial(TEMP_SelfMat)
		self:DrawShadow( true ) 
	end
	self:DrawModel()
end