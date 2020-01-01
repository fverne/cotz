include('shared.lua')

local Emitter = ParticleEmitter( Vector(0,0,0) )

function ENT:Initialize()
	
	local trace = {}
	trace.start = self.Entity:GetPos()
	trace.endpos = trace.start + Vector( 0, 0, -500 )
	trace.filter = self.Entity
	local tr = util.TraceLine( trace )
	
	self.Normal = tr.HitNormal
	self.Timer = 0
	self.BurnTime = 0
	self.Size = 50
	
end

function ENT:Think()

	if self.Entity:GetNWBool( "Burn", false ) and self.BurnTime < CurTime() then
		
		self.BurnTime = CurTime() + 11
	
	end
	
	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
	
	if(dist < 1000) then
	
		if self.Timer < CurTime() then

			local particle = Emitter:Add( "sprites/heatwave", self.Entity:GetPos() + VectorRand() * 10 )
			particle:SetVelocity( self.Normal * 50 + VectorRand() * 5 + Vector(0,0,20) ) 
			particle:SetLifeTime( 0 )  
			particle:SetDieTime( math.Rand( 1.0, 1.5 ) ) 
			particle:SetStartAlpha( 255 ) 
			particle:SetEndAlpha( 255 ) 
			particle:SetStartSize( math.random( 20, 40 ) ) 
			particle:SetEndSize( 0 ) 
			particle:SetColor( 255, 255, 255 )
			particle:SetAirResistance( 50 )
			particle:SetGravity( Vector( 0, 0, 100 ) )
			
			if math.random(1,10) == 1 then
			
				local particle = Emitter:Add( "effects/fire_embers"..math.random(1,3), self.Entity:GetPos() + VectorRand() * 10 )
				particle:SetVelocity( self.Normal * 50 + VectorRand() * 10 + Vector(0,0,20) ) 
				particle:SetLifeTime( 0 )  
				particle:SetDieTime( math.Rand( 1.0, 2.0 ) ) 
				particle:SetStartAlpha( 255 ) 
				particle:SetEndAlpha( 255 ) 
				particle:SetStartSize( math.random( 3, 5 ) ) 
				particle:SetEndSize( 0 ) 
				particle:SetColor( 0, 0, 255 )
				particle:SetAirResistance( 50 )
				particle:SetGravity( Vector( 0, 0, 100 ) )
				
			end
			
			self.Timer = CurTime() + 0.5

		end
		
		if self.BurnTime > CurTime() then
		
			local particle = Emitter:Add( "effects/muzzleflash"..math.random(1,4), self.Entity:GetPos() + self.Normal * -5 )
			particle:SetVelocity( self.Normal * 150 + VectorRand() * 30 ) 
			particle:SetLifeTime( 0 )  
			particle:SetDieTime( math.Rand( 0.5, 1.0 ) ) 
			particle:SetStartAlpha( 255 ) 
			particle:SetEndAlpha( 0 ) 
			particle:SetStartSize( math.random( 10, 20 ) ) 
			particle:SetEndSize( math.random( 30, 40 ) ) 
			particle:SetColor( math.random(0,30), 0, 255 )
			particle:SetRoll( math.Rand( -360, 360 ) )
			particle:SetRollDelta( math.Rand( -5, 5 ) )
			particle:SetAirResistance( 0 )
			particle:SetGravity( Vector( 0, 0, 150 ) )
			
			local particle = Emitter:Add( "effects/muzzleflash"..math.random(1,4), self.Entity:GetPos() + self.Normal * 5 )
			particle:SetVelocity( self.Normal * 20 ) 
			particle:SetLifeTime( 0 )  
			particle:SetDieTime( math.Rand( 0.5, 1.0 ) ) 
			particle:SetStartAlpha( 200 ) 
			particle:SetEndAlpha( 0 ) 
			particle:SetStartSize( math.random( 5, 10 ) ) 
			particle:SetEndSize( math.random( 5, 10 ) ) 
			particle:SetColor( 200, 200, 255 )
			particle:SetRoll( math.Rand( -360, 360 ) )
			particle:SetRollDelta( math.Rand( -5, 5 ) )
			particle:SetAirResistance( 0 )
			particle:SetGravity( Vector( 0, 0, 20 ) )
			
		end
	end
end

function ENT:OnRemove()
		--Emitter:Finish()
end

local matRefract = Material( "sprites/heatwave" )

function ENT:Draw()

	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
	
	if(dist < 1000) then

		if render.GetDXLevel() >= 80 then
			
			render.UpdateRefractTexture()
			render.SetMaterial( matRefract )
			//render.DrawQuadEasy( self.Entity:GetPos(),
						 //( EyePos() - self.Entity:GetPos() ):GetNormal(),
						// self.Size + math.sin( CurTime() ) * 10, self.Size + math.sin( CurTime() ) * 10,
						// Color( 255, 255, 255, 255 ) )
			
		end
	end
end

