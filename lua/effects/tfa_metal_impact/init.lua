function EFFECT:Init( data )
	
	self.StartPos = data:GetOrigin()
	
	self.Dir = data:GetNormal()
	
	self.LifeTime 	= 0.1
	
	self.DieTime 	= CurTime() + self.LifeTime
	
	self.PartMult = 0.2
	
	self.Grav 	= Vector(0, 0, -GetConVarNumber("sv_gravity",800))
	
	self.SparkLife = GetConVarNumber("cl_tfa_fx_impact_ricochet_sparklife",2)
	
	local emitter = ParticleEmitter(self.StartPos)
	
	--Sparks
	for i = 1, GetConVarNumber("cl_tfa_fx_impact_ricochet_sparks",20)*self.PartMult do
	
		local part = emitter:Add("effects/yellowflare", self.StartPos)
		
		part:SetVelocity((self.Dir + VectorRand() * 0.5) * math.Rand(50, 85))
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

		part:SetStartAlpha(255)
		part:SetStartSize(15*self.PartMult)
		part:SetDieTime(self.LifeTime*1)
		part:SetEndSize(0)
		part:SetEndAlpha(0)
		part:SetRoll(math.Rand(0, 360))
				
	emitter:Finish()
end

function EFFECT:Think( )
	return false
end

function EFFECT:Render()
	return false
end