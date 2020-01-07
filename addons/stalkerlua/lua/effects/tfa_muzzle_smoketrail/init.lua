local smokecol = Color(225,225,225,200)
local smokemat = Material("trails/smoke")
smokemat:SetInt("$nocull",1)
function EFFECT:AddPart()
	local pos, rawdat, norm
	pos = self.startpos
	norm = self.startnormal
	if self.targent and self.targatt then
		--pos = self:GetTracerShootPos(self.startpos, self.targent, self.targatt)
		rawdat = self.targent:GetAttachment(self.targatt)
		if rawdat then
			pos = rawdat.Pos
			norm = rawdat.Ang:Forward()
		end
	end
	
	local p = {}
	p.position = pos
	p.normal = norm
	p.velocity = p.normal * 5
	p.startlife = CurTime()
	p.lifetime = self.lifetime
	p.radius = self.radius
	
	if self.vparticles then
		table.insert(self.vparticles,#self.vparticles+1, p)
	end
end

function EFFECT:ProcessFakeParticles()
	self.stepcount = self.stepcount + 1
	if self.vparticles then
		if CurTime() < self.emittime and self.stepcount%self.partinterval==0 then
			self:AddPart()
		end
		
		for k,v in ipairs(self.vparticles) do
			v.position = v.position + v.velocity * FrameTime()
			v.velocity = v.velocity + self.grav * FrameTime()
			if CurTime() > v.startlife + v.lifetime then
				--print("Curtime:"..CurTime())
				--print("Lifetime:"..v.lifetime)
				--print("CTime:"..v.startlife)
				table.remove(self.vparticles,k)
			end
		end
		
		if #self.vparticles <= 0 then
			return false
		else
			return true
		end
	else
		return true
	end
end
function EFFECT:Init(ef)
	self.lifetime = 1
	self.stepcount = 0
	self.partinterval = 3
	self.emittime = CurTime()+3
	self.targent = ef:GetEntity()
	self.targatt = ef:GetAttachment()
	self.startpos = ef:GetOrigin() 
	self.startnormal = ef:GetNormal()
	self.radius = ef:GetRadius()
	self.grav = Vector(0,0,GetConVarNumber("sv_gravity",600)*0.2)
	self.randfac = 1
	if !self.startpos then
		self.startpos = vector_origin
		if IsValid(LocalPlayer()) then
			self.startpos = LocalPlayer():GetShootPos()
		end
	end
	
	if !self.startnormal then
		self.startnormal = vector_origin
	end
	
	if !self.radius or self.radius == 0 then
		self.radius = 1
	end
	
	self.vparticles = {}
	
	self:AddPart()
end

function EFFECT:Think()
	if self.vparticles then
		if #self.vparticles<=0 then
			return false
		end
	end
	return true
end

function EFFECT:DrawBeam()
	render.StartBeam(#self.vparticles)
	local prevpos = nil
	for k,v in ipairs(self.vparticles) do
		local alphac = ColorAlpha(smokecol, (1-(CurTime()-v.startlife)/v.lifetime) * 64)
		render.AddBeam(v.position,v.radius*(1-k/#self.vparticles),(k/#self.vparticles),alphac)
	end
	render.EndBeam()
end

function EFFECT:Render()
	self:ProcessFakeParticles()
	local prevpos
	if self.vparticles then
		if #self.vparticles>=2 then
			render.SetMaterial(smokemat)
			self:DrawBeam()
		end
	end
end