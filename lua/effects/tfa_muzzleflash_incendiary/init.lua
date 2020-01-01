local blankvec = Vector(0,0,0)
local AddVel = Vector()
local dif = Vector(0,0,0)
local ang

function EFFECT:Init( data )
	
	self.WeaponEnt = data:GetEntity()
	if !IsValid(self.WeaponEnt) then return end
	self.Attachment = data:GetAttachment()
	
	self.Position = self:GetTracerShootPos( data:GetOrigin(), self.WeaponEnt, self.Attachment )
	
	if IsValid(self.WeaponEnt.Owner) then
		if self.WeaponEnt.Owner == LocalPlayer() then
			if self.WeaponEnt.Owner:ShouldDrawLocalPlayer() then
				ang = self.WeaponEnt.Owner:EyeAngles()
				ang:Normalize()
				--ang.p = math.max(math.min(ang.p,55),-55)
				self.Forward = ang:Forward()
			else
				self.WeaponEnt = self.WeaponEnt.Owner:GetViewModel()
			end
		else
			ang = self.WeaponEnt.Owner:EyeAngles()
			ang:Normalize()
			--ang.p = math.max(math.min(ang.p,55),-55)
			self.Forward = ang:Forward()			
		end
	end
	
	self.Forward = self.Forward or data:GetNormal()
	self.Angle = self.Forward:Angle()
	self.Right = self.Angle:Right()
	
	self.vOffset = self.Position
	dir = self.Forward
	
	if IsValid(LocalPlayer()) then
		AddVel = LocalPlayer():GetVelocity()
	end
	
	AddVel = AddVel * 0.05
	
	self.vOffset = self.Position
	dir = self.Forward
	AddVel = AddVel * 0.05
	
	local dot = dir:GetNormalized():Dot( EyeAngles():Forward() )
	local dotang = math.deg( math.acos( math.abs(dot) ) )	
	local halofac =  math.Clamp( 1 - (dotang/90), 0, 1)
	
	if CLIENT and !IsValid(ownerent) then ownerent = LocalPlayer() end
	
	local dlight = DynamicLight( ownerent:EntIndex() )
	if ( dlight ) then
		dlight.pos = self.vOffset - ownerent:EyeAngles():Right()*5 + 1.05 * ownerent:GetVelocity() * FrameTime()
		dlight.r = 255
		dlight.g = 100
		dlight.b = 32
		dlight.brightness = 6
		dlight.Decay = 1750
		dlight.Size = 140
		dlight.DieTime = CurTime() + 0.3
	end
	
	local emitter = ParticleEmitter( self.vOffset )
		
		
		for i=0, 1 do
			local particle = emitter:Add( "effects/muzzleflashX_nemole", self.vOffset )
			if (particle) then
				particle:SetVelocity( dir*4 + 1.05 * AddVel )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.1 )
				particle:SetStartAlpha( math.Rand( 200, 255 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( 13 * (halofac*0.8+0.2), 0, 1)
				particle:SetEndSize( 0 )
				local r = math.Rand(-10, 10) * 3.14/180
				particle:SetRoll( r )
				particle:SetRollDelta( r/5)
				particle:SetColor( 255 , 132 , 32 )
				particle:SetLighting(false)
				particle.FollowEnt = self.WeaponEnt
				particle.Att = self.Attachment
				TFARegPartThink(particle,TFAMuzzlePartFunc)
			end
		end
		
		for i=0, 6 do
			local particle = emitter:Add( "particles/flamelet"..math.random(1,5), self.vOffset + (dir * 0.6 * i))
			if (particle) then
				particle:SetVelocity((dir * 19 * i) + 1.05 * AddVel )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.1 )
				particle:SetStartAlpha( math.Rand( 200, 255 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.max(8 - 0.55 * i,1) )
				particle:SetEndSize( 0 )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-40, 40) )
				particle:SetColor( 255 , 132 , 32 )
				particle:SetLighting(false)
				particle.FollowEnt = self.WeaponEnt
				particle.Att = self.Attachment
				TFARegPartThink(particle,TFAMuzzlePartFunc)
			end
		end
		
		for i=0, 9 do
		
			local particle = emitter:Add( "particles/smokey", self.vOffset + dir * math.Rand(6, 10 ))
			if (particle) then
				particle:SetVelocity(VectorRand() * 7 + dir * math.Rand(18,25) + 1.05 * AddVel )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( math.Rand( 0.5, 0.5 ) )
				particle:SetStartAlpha( math.Rand( 4, 7 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand(8,10) )
				particle:SetEndSize( math.Rand(2,5) )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-0.8, 0.8) )
				particle:SetLighting(true)
				
				particle:SetAirResistance( 10 ) 
 				 
 				particle:SetGravity( Vector( 0, 0, 60 ) ) 
				
				particle:SetColor( 255 , 255 , 255 ) 
			end
			
		end
		
		local sparkcount = math.random(8,12)		
		for i=0, sparkcount do
			local particle = emitter:Add("effects/yellowflare", self.Position)
			if (particle) then
			
				particle:SetVelocity(VectorRand() * 30 + dir * math.Rand(40,100) + 1.05 * AddVel )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( math.Rand( 0.4, 0.7 ) )
				particle:SetStartAlpha(255)
				particle:SetEndAlpha( 0 )
				particle:SetStartSize(.3)
				particle:SetEndSize(2)
				particle:SetRoll( math.rad(math.Rand(0, 360)) )
				particle:SetGravity(Vector(0, 0, -50))
				particle:SetAirResistance(50)
				particle:SetStartLength(0.2)
				particle:SetEndLength(0.05)
				particle:SetColor( 255 , 215 , 192 ) 
				particle:SetVelocityScale(true)
				particle:SetThinkFunction( function( pa )
					pa:SetVelocity( pa:GetVelocity() + VectorRand()*5)
					pa:SetNextThink( CurTime() + 0.01 )
				end )
				particle:SetNextThink( CurTime() + 0.01 )
				
			end
		end
		
		if GetTFAGasEnabled() then
			for i=0, 2 do
				local particle = emitter:Add( "sprites/heatwave", self.vOffset + (dir * i) )
				if (particle) then
					particle:SetVelocity((dir * 25 * i) + 1.05 * AddVel )
					particle:SetLifeTime( 0 )
					particle:SetDieTime( math.Rand( 0.05, 0.15 ) )
					particle:SetStartAlpha( math.Rand( 200, 225 ) )
					particle:SetEndAlpha( 0 )
					particle:SetStartSize( math.Rand(3,5) )
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

 