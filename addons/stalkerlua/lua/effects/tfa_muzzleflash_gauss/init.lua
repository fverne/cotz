local function rvec(vec)
	vec.x=math.Round(vec.x)
	vec.y=math.Round(vec.y)
	vec.z=math.Round(vec.z)
	return vec
end

local blankvec = Vector(0,0,0)

local function partfunc(self)
	if IsValid(self.FollowEnt) then
		if self.Att then
			local angpos = self.FollowEnt:GetAttachment(self.Att)
			if angpos and angpos.Pos then
				self:SetPos(angpos.Pos)
				self:SetNextThink(CurTime())
			end
		end
	end
end
				
function EFFECT:Init( data )
	
	self.StartPacket = data:GetStart()
	self.Attachment = data:GetAttachment()

	local AddVel = vector_origin
	
	if LocalPlayer then
		if IsValid(LocalPlayer()) then
			AddVel = LocalPlayer():GetVelocity()
		end
	end
	
	if AddVel == vector_origin then
		AddVel = Entity(1):GetVelocity()
	end
	
	self.Position = data:GetOrigin()
	self.Forward = data:GetNormal()
	self.Angle = self.Forward:Angle()
	self.Right = self.Angle:Right()
	
	local wepent = Entity(math.Round(self.StartPacket.z))
	
	if IsValid(wepent) then
		if wepent.IsFirstPerson and !wepent:IsFirstPerson() then
			data:SetEntity(wepent)
			self.Position = blankvec
		end
	end
	
	local ownerent = player.GetByID(math.Round(self.StartPacket.x))
	local serverside = false
	if math.Round(self.StartPacket.y)==1 then
		serverside = true
	end
	
	local ent = data:GetEntity()
	
	if serverside then
		if IsValid(ownerent) then
			if LocalPlayer() == ownerent then
				return
			end
			ent = ownerent:GetActiveWeapon()
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

	if IsValid(ent) then
		dlight = DynamicLight(ent:EntIndex())
	else
		dlight = DynamicLight(0)	
	end
	local fadeouttime = 0.2
    if (dlight) then
        dlight.Pos              = self.Position + dir * 1 - dir:Angle():Right()*5
        dlight.r                = 25
        dlight.g                = 200
        dlight.b                = 255
        dlight.Brightness = 4.0
        dlight.size     = 110
		dlight.decay = 1000
        dlight.DieTime  = CurTime() + fadeouttime
   end
	
	ParticleEffectAttach("tfa_muzzle_gauss",PATTACH_POINT_FOLLOW,ent,data:GetAttachment())
	
	--[[
	local emitter = ParticleEmitter( self.vOffset )
		for i=0, 6 do
			local particle = emitter:Add( "particles/flamelet"..math.random(1,5), self.vOffset + (dir * 1.7 * i))
			if (particle) then
				particle:SetVelocity((dir * 19 * i) + 1.05 * AddVel )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.1 )
				particle:SetStartAlpha( math.Rand( 200, 255 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.max(7 - 0.65 * i,1) )
				particle:SetEndSize( 0 )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-40, 40) )
				particle:SetColor( 255 , 218 , 97 )
				particle:SetLighting(false)
				particle.FollowEnt = self.WeaponEnt
				particle.Att = self.Attachment
				particle:SetThinkFunction( partfunc )
				particle:SetNextThink(CurTime())
			end
		end
		
		for i=0, 5 do
		
			local particle = emitter:Add( "particles/smokey", self.vOffset + dir * math.Rand(6, 10 ))
			if (particle) then
				particle:SetVelocity(VectorRand() * 5 + dir * math.Rand(27,33) + 1.05 * AddVel )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( math.Rand( 0.5, 0.5 ) )
				particle:SetStartAlpha( math.Rand( 5, 15 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand(8,10) )
				particle:SetEndSize( math.Rand(2,5) )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-0.8, 0.8) )
				
				particle:SetAirResistance( 10 ) 
 				 
 				particle:SetGravity( Vector( 0, 0, 60 ) ) 
				
				particle:SetColor( 255 , 255 , 255 ) 
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
					particle:SetThinkFunction( partfunc )
					 
					particle:SetGravity( Vector( 0, 0, 40 ) ) 
					
					particle:SetColor( 255 , 255 , 255 ) 
				end
			end
		end
		
	emitter:Finish() 
	]]--
end 

function EFFECT:Think( )
	return false
end

function EFFECT:Render()
end

 