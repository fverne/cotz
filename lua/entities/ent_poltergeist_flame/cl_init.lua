include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

local WARNING_PARTICLE = "wick_pfx_jarka_inactive"
local ERUPTION_PARTICLE = "jarka_activated"
local LIGHT_SIZE = 260

function ENT:Draw()
end

function ENT:StopFlameEffect()
	if IsValid(self.cotzEffect) then self.cotzEffect:StopEmission(false, false) end
	self.cotzEffect, self.cotzEffectName = nil, nil
end

-- These systems emit forever, so the entity owns them and stops them with itself.
function ENT:Think()
	local erupting = self:GetErupting()
	local name = erupting and ERUPTION_PARTICLE or WARNING_PARTICLE
	if self.cotzEffectName ~= name or not IsValid(self.cotzEffect) then
		self:StopFlameEffect()
		self.cotzEffect = CreateParticleSystem(self, name, PATTACH_ABSORIGIN_FOLLOW)
		self.cotzEffectName = name
	end
	if not erupting then return end

	local light = DynamicLight(self:EntIndex())
	if light then
		light.pos = self:GetPos() + Vector(0, 0, 32)
		light.r, light.g, light.b = 255, 130, 30
		light.brightness = 4
		light.size = LIGHT_SIZE
		light.decay = 800
		light.dietime = CurTime() + 0.2
	end
end

function ENT:OnRemove()
	self:StopFlameEffect()
end
