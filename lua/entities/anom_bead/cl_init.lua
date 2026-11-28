include('shared.lua')

function ENT:Initialize()

	self.Emitter = ParticleEmitter( self.Entity:GetPos() )

end

function ENT:OnRemove()

	if self.Emitter then
	
		self.Emitter:Finish()
	
	end

end

function ENT:Think()

	local particle = self.Emitter:Add( "sprites/light_glow02_add", self.Entity:LocalToWorld( self.Entity:OBBCenter() ) + VectorRand() * 5 )
 	particle:SetVelocity( Vector(0,0,-50) ) 
 	particle:SetLifeTime( 0 )  
 	particle:SetDieTime( math.Rand( 0.50, 0.75 ) ) 
 	particle:SetStartAlpha( 50 ) 
 	particle:SetEndAlpha( 0 ) 
 	particle:SetStartSize( math.random( 4, 8 ) ) 
 	particle:SetEndSize( 0 ) 
 	particle:SetColor( 255, 255, 255 )
	particle:SetAirResistance( 10 )
	
end

function ENT:Draw()

	//self.Entity:SetModelScale( Vector( math.Rand( 0.85, 0.95 ), math.Rand( 0.85, 0.95 ), math.Rand( 0.85, 0.95 ) ), 1 )
	self.Entity:DrawModel()
	
end
