include( "shared.lua" )

--Wake variables
ENT.WakeRange = 600
ENT.SleepTimer = 0
ENT.IsSleeping = true --starts the anomaly out sleeping so it doesn't use a ton of server assets
ENT.PlayingSound = false

function ENT:Initialize()
	self.particle = CreateParticleSystem( self, "electra", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,0) )
	self:SetModel("models/anomaly/anomaly_fix.mdl")
	--self:EmitSound("electra_idle")
end

function ENT:Think()
	if self.SleepTimer < CurTime() then
		if self:ShouldWake(self.WakeRange) then
			self.IsSleeping = false
			self.SleepTimer = CurTime() + 5
		else
			self.IsSleeping = true
			self.SleepTimer = CurTime() + 5
		end
	end

	if self.IsSleeping == true then
		self:StopSound("electra_idle")
		self.PlayingSound = false
	end
	
	
	if self.IsSleeping then return end

	if self.PlayingSound == false then
		self:EmitSound("electra_idle")
		self.PlayingSound = true
	end

	if not self.particle:IsValid() and not self:GetNWBool("StopParticle", false) then
		self.particle = CreateParticleSystem( self, "electra", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,0) )
		self:EmitSound("electra_idle")
		self:SetColor( Color( 0, 0, 0, 0 ) )
		self:SetRenderMode( RENDERMODE_TRANSALPHA )
		self:SetModel("models/anomaly/anomaly_fix.mdl")
	end
end

function ENT:OnRemove()
	self:StopSound("electra_idle")
end

function ENT:ShouldWake( range )
	local entities = ents.FindInSphere(self:GetPos(), range)
	for _,v in pairs(entities) do
		if v:IsPlayer() then
			return true
		end
	end
	return false
end

function ENT:UpdateTransmitState()

	return TRANSMIT_ALWAYS
end
