local RicochetColor = Color(255,255,255,255)
local RicochetIDOffset = 33
local RicochetMat = Material("effects/yellowflare")

function EFFECT:Init(data)
	self.StartPos = data:GetOrigin()
	self.Dir=data:GetNormal()
	self.Dir:Normalize()
	self.Len=128
	self.EndPos=self.StartPos+self.Dir*self.Len
	
	self.LifeTime 	= 0.1
	self.DieTime 	= CurTime() + self.LifeTime
	
	self.Grav 	= Vector(0, 0, -GetConVarNumber("sv_gravity",800))
	
	self.PartMult = data:GetMagnitude()
	
	self.SparkLife = GetConVarNumber("cl_tfa_fx_impact_ricochet_sparklife",2)
	
	local emitter = ParticleEmitter(self.StartPos)
	
	--Sparks
	for i = 1, GetConVarNumber("cl_tfa_fx_impact_ricochet_sparks",20)*self.PartMult do
	
		local part = emitter:Add("effects/yellowflare", self.StartPos)
		
		part:SetVelocity((self.Dir + VectorRand() * 0.5) * math.Rand(75, 185))
		part:SetDieTime(math.Rand(0.25, 1)*self.SparkLife)
		part:SetStartAlpha(255)
		part:SetStartSize(math.Rand(2, 4))
		part:SetEndSize(0)
		part:SetRoll(0)
		part:SetGravity(self.Grav)
		part:SetCollide(true)
		part:SetBounce(0.55)
		part:SetAirResistance(0.5)
		part:SetStartLength(0.2)
		part:SetEndLength(0)
		part:SetVelocityScale(true)
		part:SetCollide(true)
	end
	--Impact
	local part = emitter:Add("effects/yellowflare", self.StartPos)

		part:SetStartAlpha(225)
		part:SetStartSize(64)
		part:SetDieTime(self.LifeTime)
		part:SetEndSize(0)
		part:SetEndAlpha(0)
		part:SetRoll(math.Rand(0, 360))
			
	part = emitter:Add("effects/yellowflare", self.StartPos)

		part:SetStartAlpha(255)
		part:SetStartSize(30*self.PartMult)
		part:SetDieTime(self.LifeTime*1.5)
		part:SetEndSize(0)
		part:SetEndAlpha(0)
		part:SetRoll(math.Rand(0, 360))
				
	emitter:Finish()
	
	local dlight = DynamicLight(LocalPlayer():EntIndex() + RicochetIDOffset)
		if (dlight) then
			dlight.Pos 		= self.StartPos
			dlight.r 		= 255
			dlight.g 		= 225
			dlight.b 		= 185
			dlight.Brightness = 2.75*self.PartMult
			dlight.size 	= 48
			--dlight.DieTime 	= CurTime() + self.DieTime*0.7
			dlight.Decay = 1000/math.max(0.01,(math.min(self.SparkLife*0.66,1)))
		end
end

function EFFECT:Think()

	if self.DieTime then
		if (CurTime() > self.DieTime) then return false end
	end
	
	return true
end

function EFFECT:Render()

	if self.DieTime then
		local fDelta = (self.DieTime - CurTime()) / self.LifeTime
		fDelta = math.Clamp(fDelta, 0, 1)
				
		render.SetMaterial(RicochetMat)
		
		local sinWave = math.sin(fDelta * math.pi)
		
		local color = ColorAlpha(RicochetColor, 255 * fDelta)
		local precision=16
		local i = 1
		while i <= precision do
			render.DrawBeam(self.StartPos+self.Dir*self.Len*((i-1)/precision), self.StartPos+self.Dir*self.Len*((i)/precision), 8 * fDelta * ( 1 - i/precision ), 0.5, 0.5, color)
			i = i + 1
		end
	end
	
end