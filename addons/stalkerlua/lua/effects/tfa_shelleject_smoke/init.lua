function EFFECT:Init( data )
	
	self.Position = data:GetOrigin()
	self.WeaponEnt = data:GetEntity()
	if !IsValid(self.WeaponEnt) then return end
	self.Attachment = data:GetAttachment()
	
	local owent = self.WeaponEnt.Owner or self.WeaponEnt:GetOwner()
	if !IsValid(owent) then owent = self.WeaponEnt:GetParent() end
	if IsValid(owent) and owent:IsPlayer() then
		if owent!=LocalPlayer() or owent:ShouldDrawLocalPlayer() then
			self.WeaponEnt = owent:GetActiveWeapon()
			if !IsValid(self.WeaponEnt) then return end
		else
			self.WeaponEnt = owent:GetViewModel()
			if !IsValid(self.WeaponEnt) then return end		
		end
	end
		
	-- Keep the start and end pos - we're going to interpolate between them
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self.vOffset = self.StartPos
	
	local emitter = ParticleEmitter( self.vOffset )
	
	local dir = data:GetNormal()
		
		for i=0, 6 do
		
			local particle = emitter:Add( "particles/smokey", self.vOffset + dir * math.Rand(2, 4 ))
			if (particle) then
				particle:SetVelocity(VectorRand() * 5 + dir * math.Rand(7,10) )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( math.Rand( 0.6, 0.7 ) )
				particle:SetStartAlpha( math.Rand( 6, 10 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand(2,3) )
				particle:SetEndSize( math.Rand(6,8) )
				particle:SetRoll( math.rad(math.Rand(0, 360)) )
				particle:SetRollDelta( math.Rand(-0.8, 0.8) )
				particle:SetLighting(true)
				
				particle:SetAirResistance( 20 ) 
 				 
 				particle:SetGravity( Vector( 0, 0, 30 ) ) 
				
				particle:SetColor( 255 , 255 , 255 ) 
			end
			
		end
		
		if GetTFAGasEnabled() then
			for i=0, 1 do
				local particle = emitter:Add( "sprites/heatwave", self.vOffset + (dir * i) )
				if (particle) then
					particle:SetVelocity((dir * 25 * i) + VectorRand()*5 )
					particle:SetLifeTime( 0 )
					particle:SetDieTime( math.Rand( 0.05, 0.15 ) )
					particle:SetStartAlpha( math.Rand( 200, 225 ) )
					particle:SetEndAlpha( 0 )
					particle:SetStartSize( math.Rand(1,3) )
					particle:SetEndSize( math.Rand(8,10) )
					particle:SetRoll( math.Rand(0, 360) )
					particle:SetRollDelta( math.Rand(-2, 2) )
					
					particle:SetAirResistance( 5 )
					 
					particle:SetGravity( Vector( 0, 0, 40 ) ) 
					
					particle:SetColor( 255 , 255 , 255 ) 
				end
			end
		end
		
	emitter:Finish() 
end

function EFFECT:Think( )
	return false
end

function EFFECT:Render()
end

 