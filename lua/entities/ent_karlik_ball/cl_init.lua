include('shared.lua')

function ENT:Initialize()
	self.TEMP_Emitter = ParticleEmitter(Vector(0,0,0), false)
end

--ENT.TEMP_Emitter = ParticleEmitter(Vector(0,0,0), false)


function ENT:Think()
	self.TEMP_Emitter:SetPos(self:GetPos(), false)
		
	if(IsValid(self.TEMP_Emitter)) then
		local TEMP_Particle = self.TEMP_Emitter:Add( "particles/conc_warp", self:GetPos()+
		Vector(math.Rand(-10,10),math.Rand(-10,10),math.Rand(-10,10)))
		TEMP_Particle:SetDieTime( 2 )
		TEMP_Particle:SetStartAlpha( 255 )
		TEMP_Particle:SetEndAlpha( 10 )
		TEMP_Particle:SetStartSize( 10 )
		TEMP_Particle:SetEndSize( 1 )
		TEMP_Particle:SetColor( 50,255,50 )
		TEMP_Particle:SetGravity(Vector(0,0,0))
		TEMP_Particle:SetVelocity((-self:GetVelocity():GetNormalized()*math.random(30,40))+
		Vector(math.random(-28,28),math.random(-28,28),math.random(-28,28)))
		TEMP_Particle:SetCollide(true)
		
	end
end

function ENT:Draw()
	cam.Start3D()
		render.SetMaterial( Material("particles/conc_warp") )
		render.DrawSprite( self:GetPos(), 70, 70, Color(50,255,50,155) ) -- Draw the sprite in the middle of the map, at 16x16 in it's original colour with full alpha.
	cam.End3D()
    //self:DrawModel()
end



function ENT:OnRemove()
	self.TEMP_Emitter:Finish()
end