include('shared.lua')

function ENT:ChooseRandPoses()
	self.RandPoses = {}
	
	for P=1, 4 do
		self.RandPoses[P] = Vector(math.Rand(-1,1),math.Rand(-1,1),0):GetNormalized()*math.random(30,100)
	end
end

function ENT:Initialize()
	self:ChooseRandPoses()
end

function ENT:Draw()
	local TEMP_RealPos = self:GetPos()
	local TEMP_RealAng = self:GetAngles()
	local TEMP_RandVec = Vector(0,0,0)
	
	if( ix and LocalPlayer():GetCharacter() and LocalPlayer():Alive() and LocalPlayer():GetPsyHealth() < 75 and !LocalPlayer():GetNWBool("ix_psysuppressed")) then
		if(!istable(self.RandPoses)) then
			self:ChooseRandPoses()
		end
		
		TEMP_RandVec = (VectorRand()*math.random(5,10))
		
		for P=1, #self.RandPoses do
			render.SetBlend(((100-LocalPlayer():GetPsyHealth())/100)*2.2)
			self:SetPos(TEMP_RealPos+self.RandPoses[P]+(VectorRand()*math.random(5,10)))
			self:SetAngles(TEMP_RealAng)
			self:SetupBones()
			self:DrawModel()
		end
		
	else
	    self.RandPoses = nil
	end
	
	render.SetBlend(1)
	self:SetPos(TEMP_RealPos+TEMP_RandVec)
	self:SetAngles(TEMP_RealAng)
	self:SetupBones()
	self:DrawModel()
	
	
	self:SetPos(TEMP_RealPos)
end