include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/maver1k_XVII/Stalker/mutants/karlik.mdl"
end

function ENT:Draw()

	self:SetModel("models/maver1k_XVII/Stalker/mutants/karlik.mdl")
	self:DrawModel()


	if self.Entity:GetNWBool( "Teleport", false ) then
		local TEMP_Emitter = ParticleEmitter(self:GetPos(), false)
	
		if(IsValid(TEMP_Emitter)) then
			local TEMP_Particle = TEMP_Emitter:Add( "effects/conc_warp", self.Entity:GetNWVector("OldPos", self:GetPos()))
			TEMP_Particle:SetDieTime( 4 )
			TEMP_Particle:SetStartAlpha( 255 )
			TEMP_Particle:SetEndAlpha( 10 )
			TEMP_Particle:SetStartSize( 100 )
			TEMP_Particle:SetEndSize( 1 )
			TEMP_Particle:SetColor( 50,255,50 )
			TEMP_Particle:SetGravity(Vector(0,0,0))
			--TEMP_Particle:SetVelocity((-self:GetVelocity():GetNormalized()*math.random(30,40))+
			--Vector(math.random(-28,28),math.random(-28,28),math.random(-28,28)))
			TEMP_Particle:SetCollide(true)
			
			
			TEMP_Emitter:Finish()
	
			self.Entity:SetNWBool( "Teleport", false )
		end
	end
end