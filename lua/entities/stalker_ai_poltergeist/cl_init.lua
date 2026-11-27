include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

local GLOW_MATERIAL = Material("sprites/light_glow02_add")
local DISTORTION_MATERIAL = Material("models/shadertest/predator")
local GLOW_SIZE = 56
local GLOW_PULSE = 14
local GLOW_RATE = 4
local LIGHT_SIZE = 200

function ENT:Initialize()
	self:DrawShadow(false)
end

function ENT:StopOrb()
	if IsValid(self.cotzOrb) then self.cotzOrb:StopEmissionAndDestroyImmediately() end
	self.cotzOrb = nil
end

-- The body is never drawn alive. Damage briefly shows it as a refraction so hits can be read.
function ENT:Draw()
	if CurTime() < self:GetNWFloat("cotzPolterReveal", 0) then
		render.MaterialOverride(DISTORTION_MATERIAL)
		self:DrawModel()
		render.MaterialOverride()
	end

	local size = GLOW_SIZE + math.sin(CurTime() * GLOW_RATE + self:EntIndex()) * GLOW_PULSE
	local color = self.cotzGlowColor
	if not color then
		color = Color(self.OrbColor.r, self.OrbColor.g, self.OrbColor.b)
		self.cotzGlowColor = color
	end
	render.SetMaterial(GLOW_MATERIAL)
	render.DrawSprite(self:GetPos() + Vector(0, 0, self.OrbHeight), size, size, color)
end

function ENT:Think()
	if self:IsDormant() or self:GetNoDraw() then
		self:StopOrb()
		return
	end

	if not IsValid(self.cotzOrb) then
		self.cotzOrb = CreateParticleSystem(self, self.OrbParticle, PATTACH_ABSORIGIN_FOLLOW, 0,
			Vector(0, 0, self.OrbHeight))
	end
	local light = DynamicLight(self:EntIndex())
	if light then
		light.pos = self:GetPos() + Vector(0, 0, self.OrbHeight)
		light.r, light.g, light.b = self.OrbColor.r, self.OrbColor.g, self.OrbColor.b
		light.brightness = 2
		light.size = LIGHT_SIZE
		light.decay = 600
		light.dietime = CurTime() + 0.2
	end
end

function ENT:OnRemove()
	self:StopOrb()
end
