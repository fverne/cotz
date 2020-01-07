
include('shared.lua')

ENT.Size = 15

function ENT:Initialize()

	self.Emitter = ParticleEmitter( self.Entity:GetPos() )
	self.Pos = self.Entity:GetPos() + Vector(0,0,25)
	self.Timer = 0
	self.Alpha = 0

end

function ENT:Think()

	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
	
	if(dist < 3000) then

		if self.Timer < CurTime() then
		
			self.Timer = CurTime() + 0.5
		
			local particle = self.Emitter:Add( "effects/yellowflare", self.Pos + VectorRand() * 20 )
			particle:SetVelocity( VectorRand() * 150 )
			particle:SetColor( 150, 0, 255 )
			particle:SetDieTime( 5 )
			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( 4 )
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand( -360, 360 ) )
			particle:SetRollDelta( math.Rand( -30, 30 ) )
			particle:SetCollide( true )
			particle:SetBounce( 1.0 )
			particle:SetThinkFunction( WarpThink )
			particle:SetNextThink( CurTime() + 0.1 )
			particle.Pos = self.Pos
		
		end
	end
end

function WarpThink( part )

	local dir = ( part.Pos - part:GetPos() ):GetNormal()
	
	part:SetNextThink( CurTime() + 0.1 )
	part:SetGravity( dir * 400 )

end

function ENT:OnRemove()

	if self.Emitter then
	
		self.Emitter:Finish()
	
	end

end

local matGlow = Material( "effects/blueflare1" )

function ENT:Draw()
	
	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
	
	if(dist < 3000) then
	
		self.Alpha = 100 + math.sin( CurTime() ) * 100
		
		render.SetMaterial( matGlow )
		render.DrawSprite( self.Pos, self.Size + math.sin( CurTime() * 3 ) * 5, self.Size + math.sin( CurTime() * 3 ) * 5, Color( 150, 0, 255, self.Alpha ) )
	end	
end
