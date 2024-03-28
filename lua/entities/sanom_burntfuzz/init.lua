AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

ENT.AutomaticFrameAdvance = true 

ENT.damageCooldown = 0
ENT.shouldResetSequence = true

--Wake variables
ENT.WakeRange = 2500
ENT.SleepTimer = 0
ENT.IsSleeping = true --starts the anomaly out sleeping so it doesn't use a ton of server assets


function ENT:ShouldWake( range )
	local entities = ents.FindInSphere(self:GetPos(), range)
	for _, v in pairs(entities) do
		if v:IsPlayer() then
			return true
		end
	end

	return false
end

function ENT:Initialize()
	self.Entity:SetModel( "models/comrade/anomalies/puh.mdl" ) --Set its model
	self.Entity:ResetSequenceInfo() 
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
	
	if self.IsSleeping then return end

	if self.shouldResetSequence then
		self.shouldResetSequence = false
		timer.Simple(self:SequenceDuration(), function() 
			if IsValid(self.Entity) then
				self:ResetSequence("idle") 
				self.shouldResetSequence = true
			end
		end)
	end

	if self.damageCooldown < CurTime() then
		self.damageCooldown = CurTime() + 0.3
		for k, v in pairs( ents.FindInBox( self:GetPos() + Vector(-32,-32,0), self:GetPos() + Vector(32,32,180))) do
			
			if v:IsPlayer() and v:Alive() and v:IsValid() then
				local b = DamageInfo()
				b:SetDamage( 20 )
				b:SetDamageType( DMG_ACID )
				b:SetAttacker( self.Entity )
				b:SetInflictor( self.Entity )

				v:TakeDamageInfo( b )
			
			self:EmitSound("ambient/levels/canals/toxic_slime_sizzle3.wav")
			end
		end
	end
	
	self:NextThink(CurTime())
	return true
end
