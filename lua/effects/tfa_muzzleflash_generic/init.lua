local function rvec(vec)
	vec.x=math.Round(vec.x)
	vec.y=math.Round(vec.y)
	vec.z=math.Round(vec.z)
	return vec
end

local blankvec = Vector(0,0,0)

function EFFECT:Init( data )
	
	self.StartPacket = data:GetStart()
	self.Attachment = data:GetAttachment()

	local AddVel = vector_origin
	
	if LocalPlayer then
		if IsValid(LocalPlayer()) then
			AddVel = LocalPlayer():GetVelocity()
		end
	end
	
	if game.SinglePlayer() then
		AddVel = Entity(1):GetVelocity()
	end
	
	self.Position = data:GetOrigin()
	self.Forward = data:GetNormal()
	self.Angle = self.Forward:Angle()
	self.Right = self.Angle:Right()
	
	local wepent = Entity(math.Round(self.StartPacket.z))
	
	local ownerent = player.GetByID(math.Round(self.StartPacket.x))
	local serverside = false
	if math.Round(self.StartPacket.y)==1 then
		serverside = true
	end
	
	if IsValid(wepent) then
		if ( wepent.IsFirstPerson and !wepent:IsFirstPerson() ) or serverside then
			data:SetEntity(wepent)
			self.Position = blankvec
		end
	end
	
	--[[
	self.Forward = ownerent:EyeAngles():Forward()
	self.Angle = self.Forward:Angle()
	self.Right = self.Angle:Right()
	]]--
	
	if serverside then
		if IsValid(ownerent) then
			if LocalPlayer() == ownerent then
				return
			end
			AddVel = ownerent:GetVelocity()
		end
	end
	
	if (!self.Position) or ( rvec(self.Position) == blankvec ) then
		self.WeaponEnt = data:GetEntity()
		self.Attachment = data:GetAttachment()
		if self.WeaponEnt and IsValid(self.WeaponEnt) then
			local rpos = self.WeaponEnt:GetAttachment(self.Attachment)
			if rpos and rpos.Pos then
				self.Position = rpos.Pos
				if data:GetNormal()==vector_origin then
					self.Forward = rpos.Ang:Up()
					self.Angle = self.Forward:Angle()
					self.Right = self.Angle:Right()
				end
			end
		end
	end
	
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
		dlight.g = 192
		dlight.b = 64
		dlight.brightness = 4
		dlight.Decay = 1750
		dlight.Size = 96
		dlight.DieTime = CurTime() + 0.3
	end
	
	local emitter = ParticleEmitter( self.vOffset )
		
		for i=0, 4 do
			local particle = emitter:Add( "effects/scotchmuzzleflash"..math.random(1,4), self.vOffset )
			
			if (particle) then
				particle:SetVelocity( dir*4 + 1.05 * AddVel )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.1 )
				particle:SetStartAlpha( math.Rand( 225, 255 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( 7.5 * (halofac*0.8+0.2), 0, 1)
				particle:SetEndSize( 0 )
				local r = math.Rand(-180, 180) * 3.14/180
				particle:SetRoll( r )
				particle:SetRollDelta( math.sqrt(math.Clamp(r,-90,90))/9 )
				particle:SetColor( 255 , 218 , 97 )
				particle:SetLighting(false)
				particle.FollowEnt = self.WeaponEnt
				particle.Att = self.Attachment
				TFARegPartThink(particle,TFAMuzzlePartFunc)
			end
		end
		
		for i=0, 4 do
			local particle = emitter:Add( "particles/flamelet"..math.random(1,5), self.vOffset + (dir * 0.8 * i))
			if (particle) then
				particle:SetVelocity((dir * 6 * i) + 1.05 * AddVel )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.1 )
				particle:SetStartAlpha( math.Rand( 200, 255 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.max(3.8 - 0.65 * i,1) )
				particle:SetEndSize( 1 )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-10, 10) )
				particle:SetColor( 255 , 218 , 97 )
				particle:SetLighting(false)
				particle.FollowEnt = self.WeaponEnt
				particle.Att = self.Attachment
				TFARegPartThink(particle,TFAMuzzlePartFunc)
			end
		end
		
		for i=0, 3 do
		
			local particle = emitter:Add( "particles/smokey", self.vOffset + dir * math.Rand(3, 6 ))
			if (particle) then
				particle:SetVelocity(VectorRand() * 5 + dir * math.Rand(13,20) + 1.05 * AddVel )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( math.Rand( 0.5, 0.5 ) )
				particle:SetStartAlpha( math.Rand( 5, 15 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand(3,5) )
				particle:SetEndSize( math.Rand(2,5) )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-0.8, 0.8) )
				particle:SetLighting(true)
				
				particle:SetAirResistance( 10 ) 
 				 
 				particle:SetGravity( Vector( 0, 0, 60 ) ) 
				
				particle:SetColor( 255 , 255 , 255 ) 
			end
			
		end
		
		local sparkcount = math.random(2,3)		
		for i=0, sparkcount do
			local particle = emitter:Add("effects/yellowflare", self.Position)
			if (particle) then
			
				particle:SetVelocity( ( VectorRand() + Vector(0,0,0.3) ) * 15 * Vector(0.8,0.8,0.6) + dir * math.Rand(45,60) + 1.15 * AddVel )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( math.Rand( 0.25, 0.4 ) )
				particle:SetStartAlpha(255)
				particle:SetEndAlpha( 0 )
				particle:SetStartSize(.35)
				particle:SetEndSize(1.15)
				particle:SetRoll( math.rad(math.Rand(0, 360)) )
				particle:SetGravity(Vector(0, 0, -50))
				particle:SetAirResistance(40)
				particle:SetStartLength(0.2)
				particle:SetEndLength(0.05)
				particle:SetColor( 255 , 200 , 140 ) 
				particle:SetVelocityScale(true)
				particle:SetThinkFunction( function( pa )
					pa.ranvel = pa.ranvel or VectorRand()*4
					pa.ranvel.x = math.Approach(pa.ranvel.x,math.Rand(-4,4),0.5)
					pa.ranvel.y = math.Approach(pa.ranvel.y,math.Rand(-4,4),0.5)
					pa.ranvel.z = math.Approach(pa.ranvel.z,math.Rand(-4,4),0.5)
					pa:SetVelocity( pa:GetVelocity() + pa.ranvel*0.5)
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
					
					particle.FollowEnt = self.WeaponEnt
					particle.Att = self.Attachment
					TFARegPartThink(particle,TFAMuzzlePartFunc)
					 
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

 