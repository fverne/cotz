include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.GlowColor = Color(255, 255, 255)
ENT.GlowSize = 48
ENT.GlowJitter = 6
ENT.LightSize = 160
ENT.TrailInterval = 0.15

local GLOW_MATERIAL = Material("sprites/light_glow02_add")

function ENT:Draw()
	local size = self.GlowSize + math.Rand(-self.GlowJitter, self.GlowJitter)
	render.SetMaterial(GLOW_MATERIAL)
	render.DrawSprite(self:GetPos(), size, size, self.GlowColor)
end

function ENT:Think()
	local light = DynamicLight(self:EntIndex())
	if light then
		local color = self.GlowColor
		light.pos = self:GetPos()
		light.r, light.g, light.b = color.r, color.g, color.b
		light.brightness = 3
		light.size = self.LightSize
		light.decay = 600
		light.dietime = CurTime() + 0.2
	end

	if self.TrailParticle and CurTime() >= (self.cotzNextTrail or 0) then
		self.cotzNextTrail = CurTime() + self.TrailInterval
		ParticleEffect(self.TrailParticle, self:GetPos(), angle_zero)
	end
end
