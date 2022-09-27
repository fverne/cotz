include( "shared.lua" )

sound.Add( {
	name = "tramplin_idle",
	channel = CHAN_STATIC,
	volume = 0.4,
	level = 70,
	pitch = 100,
	sound = "anomaly/voronka_idle.wav"
} )

--Wake variables
ENT.WakeRange = 600
ENT.SleepTimer = 0
ENT.IsSleeping = true --starts the anomaly out sleeping so it doesn't use a ton of server assets
ENT.PlayingSound = false

function ENT:Initialize()
	self.particle = CreateParticleSystem( self, "tramplin", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,0) )
	--self:EmitSound("tramplin_idle")
	self:SetModel("models/anomaly/anomaly_fix.mdl")	
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
		self:StopSound("tramplin_idle")
		self.PlayingSound = false
	end
	
	
	if self.IsSleeping then return end

	if self.PlayingSound == false then
		self:EmitSound("tramplin_idle")
		self.PlayingSound = true
	end

	if not self.particle:IsValid() and not self:GetNWBool("StopParticle", false) then
		self.particle = CreateParticleSystem( self, "tramplin", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,0) )
		--self:StopSound("tramplin_idle")
		--self:EmitSound("tramplin_idle")
		self:SetColor( Color( 0, 0, 0, 0 ) )
		self:SetRenderMode( RENDERMODE_TRANSALPHA )
		self:SetModel("models/anomaly/anomaly_fix.mdl")
	end

	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		dlight.pos = self:GetPos()
		dlight.r = 0
		dlight.g = 0
		dlight.b = 0
		dlight.brightness = 0
		dlight.Decay = 0
		dlight.Size = 0
		dlight.DieTime = CurTime() + 1
	end
if self:GetNWBool("Activated", false) then

local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		dlight.pos = self:GetPos()
		dlight.r = 30
		dlight.g = 30
		dlight.b = 90
		dlight.brightness = 1
		dlight.innerangle = 1
		dlight.Decay = 500
		dlight.Size = 1024 
		dlight.DieTime = CurTime() + FrameTime() * 2
	end
else

local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		dlight.pos = self:GetPos()
		dlight.r = 0
		dlight.g = 0
		dlight.b = 0
		dlight.brightness = 0
		dlight.Decay = 0
		dlight.Size = 0
		dlight.DieTime = CurTime() + 1
	end
end
end
function ENT:OnRemove()
	self:StopSound("tramplin_idle")
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
