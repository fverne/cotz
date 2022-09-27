ENT.Base = "base_anim"
ENT.Type = "anim"  
ENT.PrintName		= "Jarka Anomaly" 
ENT.SetName		= "Jarka Anomaly" 
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.Category		= "S.T.A.L.K.E.R. Anomalies"
ENT.Author			= "ThatYellowPicturePony"
ENT.AutomaticFrameAdvance = true

--Wake variables
ENT.WakeRange = 600
ENT.SleepTimer = 0
ENT.IsSleeping = true --starts the anomaly out sleeping so it doesn't use a ton of server assets
ENT.PlayingSound = false

if CLIENT then
	language.Add ("jarka", "Jarka Anomaly")

	sound.Add( {
		name = "par_idle",
		channel = CHAN_STATIC,
		volume = 0.1,
		level = 70,
		pitch = 100,
		sound = "anomaly/par_idle.wav"
	} )

	function ENT:Initialize()
		self.particle = CreateParticleSystem( self, "jarka_inactive", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,0) )
		--self:EmitSound("par_idle")
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
			self:StopSound("par_idle")
			self.PlayingSound = false
		end
		
		
		if self.IsSleeping then return end

		if self.PlayingSound == false then
			self:EmitSound("par_idle")
			self.PlayingSound = true
		end

		if not self.particle:IsValid() then
			self.particle = CreateParticleSystem( self, "jarka_inactive", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,0) )

		end
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

end