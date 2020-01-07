local blankvec = Vector(0,0,0)
local AddVel = Vector()
local dif = Vector(0,0,0)
local ang

function EFFECT:Init( data )
	
	self.WeaponEnt = data:GetEntity()
	if !IsValid(self.WeaponEnt) then return end
	self.Attachment = data:GetAttachment()

	local smokepart = "smoke_trail_tfa" 
	
	if self.WeaponEnt.SmokeParticles then
		smokepart = self.WeaponEnt.SmokeParticles[self.WeaponEnt.DefaultHoldType or self.WeaponEnt.HoldType] or smokepart
	end
	
	if self.WeaponEnt.SmokeParticles then
		smokepart = self.WeaponEnt.SmokeParticles[self.WeaponEnt.DefaultHoldType or self.WeaponEnt.HoldType] or smokepart
	end
	
	
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
	
	if GetTFAMZSmokeEnabled == nil or GetTFAMZSmokeEnabled() then
		ParticleEffectAttach(smokepart,PATTACH_POINT_FOLLOW,self.WeaponEnt,self.Attachment)
	end
end 

function EFFECT:Think( )
	return false
end

function EFFECT:Render()
end