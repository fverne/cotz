include( "shared.lua" )

--Wake variables
ENT.WakeRange = 600
ENT.SleepTimer = 0
ENT.IsSleeping = true --starts the anomaly out sleeping so it doesn't use a ton of server assets
ENT.PlayingSound = false

function ENT:Initialize()
	self.particle = CreateParticleSystem( self, "kisel", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,0) )
	--self:EmitSound("buzz_idle")
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
		self:StopSound("buzz_idle")
		self.PlayingSound = false
	end
	
	
	if self.IsSleeping then return end

	if self.PlayingSound == false then
		self:EmitSound("buzz_idle")
		self.PlayingSound = true
	end

	if not self.particle:IsValid() and not self:GetNWBool("StopParticle", false) then
		self.particle = CreateParticleSystem( self, "kisel", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,0) )

	end

	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		dlight.pos = self:GetPos()
		dlight.r = 137
		dlight.g = 244
		dlight.b = 66
		dlight.brightness = 1
		dlight.Decay = 500
		dlight.Size = 128
		dlight.DieTime = CurTime() + 1
	end
	if self:GetNWBool("Activated", false) then

	local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = self:GetPos()
			dlight.r = 137
			dlight.g = 244
			dlight.b = 66
			dlight.brightness = 4
			dlight.Decay = 1000
			dlight.Size = 170
			dlight.DieTime = CurTime() + 1
		end
	else

	local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = self:GetPos()
			dlight.r = 137
			dlight.g = 244
			dlight.b = 66
			dlight.brightness = 1
			dlight.Decay = 500
			dlight.Size = 128
			dlight.DieTime = CurTime() + 1
		end
	end
end
function ENT:OnRemove()
	self:StopSound("buzz_idle")
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
