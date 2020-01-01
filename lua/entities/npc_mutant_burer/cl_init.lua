include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/GSC/S.T.A.L.K.E.R/Monsters/Burer.mdl"
end

function ENT:Draw()
	if(self:GetSequence()==self:LookupSequence("S_Shield_Idle")) then
		local TEMP_SelfModel = self:GetModel()
		local TEMP_SelfMat = self:GetMaterial()
		local TEMP_SelfPos = self:GetPos()
		local TEMP_SelfAng = self:GetAngles()
		local TEMP_SelfScale = self:GetModelScale()
		local TEMP_SelfAnim = self:GetSequence()
		
		self:SetupBones()
		self:DrawModel(TEMP_SelfModel)
		
		self:SetModel( "models/props_phx/misc/smallcannonball.mdl" )
		self:SetMaterial("models/shadertest/predator")
		self:SetPos(self:GetPos()+(self:GetForward()*30)+Vector(0,0,30))
		self:SetModelScale(8)
		self:SetupBones()
		self:DrawModel()
		
		
		self:SetModel(TEMP_SelfModel)
		self:SetMaterial(TEMP_SelfMat)
		self:SetPos(TEMP_SelfPos)
		self:SetAngles(TEMP_SelfAng)
		self:SetModelScale(TEMP_SelfScale)
		self:SetSequence(TEMP_SelfAnim)
		
		return
	end
	
	self:SetModel("models/GSC/S.T.A.L.K.E.R/Monsters/Burer.mdl")
	self:DrawModel()
end