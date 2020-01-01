local PenetColor = Color(255,255,255,255)
local PenetMat = Material("trails/smoke")
local PenetMat2 = Material("effects/yellowflare")

function EFFECT:Init(data)
	self.StartPos = data:GetOrigin()
	self.Dir=data:GetNormal()
	self.Dir:Normalize()
	self.Len=32
	self.EndPos=self.StartPos+self.Dir*self.Len
	
	self.LifeTime 	= 0.75
	self.DieTime 	= CurTime() + self.LifeTime
	
	self.Thickness = 1
	
	self.Grav 	= Vector(0, 0, -GetConVarNumber("sv_gravity",800))
	
	self.PartMult = data:GetMagnitude()
	
	self.SparkLife = GetConVarNumber("cl_tfa_fx_impact_Penet_sparklife",2)
	
	local emitter = ParticleEmitter(self.StartPos)
	
	--Sparks
	for i = 1, GetConVarNumber("cl_tfa_fx_impact_ricochet_sparks",20)*self.PartMult*0.1 do
	
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
	local part = emitter:Add("effects/select_ring", self.StartPos)

		part:SetStartAlpha(225)
		part:SetStartSize(1)
		part:SetDieTime(self.LifeTime/5)
		part:SetEndSize(0)
		part:SetEndAlpha(0)
		part:SetRoll(math.Rand(0, 360))
		part:SetColor(200,200,200)
		
	part = emitter:Add("effects/select_ring", self.StartPos)

		part:SetStartAlpha(255)
		part:SetStartSize(1.5*self.PartMult)
		part:SetDieTime(self.LifeTime/6)
		part:SetEndSize(0)
		part:SetEndAlpha(0)
		part:SetRoll(math.Rand(0, 360))
		part:SetColor(200,200,200)
				
	emitter:Finish()
	
	self.WeaponEnt = data:GetEntity()
	if !IsValid(self.WeaponEnt) then return end
	if self.WeaponEnt.TracerName then
		local fx = EffectData()
		fx:SetStart(self.StartPos)
		local traceres = util.QuickTrace(self.StartPos,self.Dir*9999999,nil)
		fx:SetOrigin(traceres.HitPos or self.StartPos)
		util.Effect(self.WeaponEnt.TracerName,fx)
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
				
		render.SetMaterial(PenetMat)
		
		local sinWave = math.sin(fDelta * math.pi)
		
		local color = ColorAlpha(PenetColor, 32 * fDelta)
		local precision=16
		local i = 1
		while i <= precision do
			render.DrawBeam(self.StartPos+self.Dir*self.Len*((i-1)/precision), self.StartPos+self.Dir*self.Len*((i)/precision), self.Thickness * fDelta * ( 1 - i/precision ), 0.5, 0.5, color)
			i = i + 1
		end
		render.SetMaterial(PenetMat2)
		i = 1
		while i <= precision do
			render.DrawBeam(self.StartPos+self.Dir*self.Len*((i-1)/precision), self.StartPos+self.Dir*self.Len*((i)/precision), self.Thickness / 3 * 2 * fDelta * ( 1 - i/precision ), 0.5, 0.5, color)
			i = i + 1
		end
	end
	
end