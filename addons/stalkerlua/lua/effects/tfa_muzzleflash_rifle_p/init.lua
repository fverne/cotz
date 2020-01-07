game.AddParticles("particles/doktor_muzzleflash.pcf")
PrecacheParticleSystem("VES_fire_1_FP")

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
	
    if (dlight) then
        dlight.Pos              = self.Position + dir * 1 - dir:Angle():Right()*5
        dlight.r                = 180
        dlight.g                = 120
        dlight.b                = 40
        dlight.Brightness = 4.0
        dlight.size     = 110
        dlight.DieTime  = CurTime() + 0.1
		dlight.Fade = 1000
   end 
	
	local att = math.max(1,data:GetAttachment())
	
	ParticleEffectAttach("VES_fire_1_FP",PATTACH_POINT_FOLLOW,ent,att)
end 

function EFFECT:Think( )
	return false
end

function EFFECT:Render()
end

 