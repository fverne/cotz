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
	
	self.vOffset = self.Position
	dir = self.Forward
	AddVel = AddVel * 0.05
	
	local dot = dir:GetNormalized():Dot( EyeAngles():Forward() )
	local dotang = math.deg( math.acos( math.abs(dot) ) )	
	local halofac =  math.Clamp( 1 - (dotang/90), 0, 1)
	
	if CLIENT and !IsValid(ownerent) then ownerent = LocalPlayer() end
	
    if (dlight) then
        dlight.Pos              = self.Position + dir * 1 - dir:Angle():Right()*5
        dlight.r                = 25
        dlight.g                = 200
        dlight.b                = 255
        dlight.Brightness = 4.0
        dlight.size     = 110
        dlight.DieTime  = CurTime() + 0.03
   end
	
	ParticleEffectAttach("tfa_muzzle_energy",PATTACH_POINT_FOLLOW,self.WeaponEnt,data:GetAttachment())
	
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

 