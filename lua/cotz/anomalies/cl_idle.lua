-- Included into each anomaly's ENT table without changing its registered base or class.
local ACTIVE_INTERVAL = 0.1
local SLEEP_INTERVAL = 0.5
local SLEEP_MARGIN = 250
local PARTICLE_OFFSET = Vector(0, 0, 0)
local INVISIBLE_COLOR = Color(0, 0, 0, 0)

-- Light presets. Lights only show while the server flags the anomaly as activated. Active values fall
-- back to the base values when a preset does not set them.
local LIGHTS = {
	chemical = {r = 137, g = 244, b = 66, size = 128, brightness = 1, decay = 500,
		activeSize = 170, activeBrightness = 4, activeDecay = 1000},
	activation = {r = 30, g = 30, b = 90, size = 1024, brightness = 1, decay = 500, innerAngle = 1},
	electric = {r = 110, g = 140, b = 255, size = 420, brightness = 3, decay = 1500},
	thermal = {r = 255, g = 120, b = 30, size = 300, brightness = 3, decay = 800},
	acid = {r = 120, g = 255, b = 60, size = 220, brightness = 3, decay = 1200},
	gravity = {r = 255, g = 200, b = 140, size = 260, brightness = 2, decay = 1500},
	tesla = {r = 90, g = 110, b = 255, size = 160, brightness = 0.6, decay = 500,
		activeSize = 700, activeBrightness = 4, activeDecay = 2000},
	psy = {r = 150, g = 70, b = 230, size = 260, brightness = 0.8, decay = 500,
		activeSize = 420, activeBrightness = 3, activeDecay = 1500},
	smoulder = {r = 255, g = 110, b = 30, size = 180, brightness = 0.5, decay = 500},
	cometFire = {r = 255, g = 110, b = 25, size = 300, brightness = 3, decay = 500},
	cometElectric = {r = 120, g = 150, b = 255, size = 300, brightness = 3, decay = 500},
}

ENT.WakeRange = 2500

local function stopParticle(entity)
	if entity.particle and entity.particle:IsValid() then
		entity.particle:StopEmission(false, true)
	end
	entity.particle = nil

	for index, layer in ipairs(entity.particleLayers or {}) do
		if layer:IsValid() then
			layer:StopEmission(false, true)
		end
		entity.particleLayers[index] = nil
	end
end

local function clearLight(entity)
	if not entity.cotzHasIdleLight then return end
	local light = DynamicLight(entity:EntIndex())
	if light then
		light.brightness = 0
		light.size = 0
		light.dietime = CurTime() + ACTIVE_INTERVAL
	end

	entity.cotzHasIdleLight = false
end

local function createLayers(entity)
	if not entity.IdleLayers then return end
	entity.particleLayers = entity.particleLayers or {}

	for _, name in ipairs(entity.IdleLayers) do
		local layer = CreateParticleSystem(entity, name, PATTACH_ABSORIGIN_FOLLOW, 0, PARTICLE_OFFSET)
		if layer and layer:IsValid() then
			entity.particleLayers[#entity.particleLayers + 1] = layer
		end
	end
end

local function createParticle(entity)
	stopParticle(entity)
	entity.particle = CreateParticleSystem(entity, entity.IdleParticle, PATTACH_ABSORIGIN_FOLLOW, 0, PARTICLE_OFFSET)
	if not entity.particle or not entity.particle:IsValid() then return end
	createLayers(entity)

	if entity.cotzIdleCreated then
		if entity.IdleRestartTranslucent then
			entity:SetColor(INVISIBLE_COLOR)
			entity:SetRenderMode(RENDERMODE_TRANSALPHA)
		end
		if entity.IdleRestartModel then
			entity:SetModel(entity.IdleRestartModel)
		end
	end

	entity.cotzIdleCreated = true
end

local function updateLight(entity, now)
	local preset = LIGHTS[entity.IdleLight]
	local activated = entity:GetNWBool("Activated", false)
	local lightsEnabled = not ix or not ix.option or ix.option.Get("anomalyLights", true)
	if not lightsEnabled or not preset or not activated then
		clearLight(entity)
		return
	end

	local light = DynamicLight(entity:EntIndex())
	if not light then return end

	light.pos = entity:GetPos() + (entity.IdleLightOffset or PARTICLE_OFFSET)
	light.dietime = now + ACTIVE_INTERVAL * 2
	light.r = preset.r
	light.g = preset.g
	light.b = preset.b
	light.size = activated and preset.activeSize or preset.size
	light.brightness = activated and preset.activeBrightness or preset.brightness
	light.decay = activated and preset.activeDecay or preset.decay
	if preset.innerAngle then
		light.innerangle = preset.innerAngle
	end

	entity.cotzHasIdleLight = true
end

function ENT:Initialize()
	self.IsSleeping = true
	self.PlayingSound = false
	self.cotzIdleCreated = false
	if self.IdleModel then
		self:SetModel(self.IdleModel)
	end
end

function ENT:StopAnomalyIdleEffects()
	stopParticle(self)
	clearLight(self)
	if self.PlayingSound then
		self:StopSound(self.IdleSound)
		self.PlayingSound = false
	end
	if self.OnIdleSleep then
		self:OnIdleSleep()
	end
end

function ENT:ShouldWake(range)
	local client = LocalPlayer()
	if not IsValid(client) or self:IsDormant() then return false end

	local viewEntity = client:GetViewEntity()
	if not IsValid(viewEntity) then return false end

	return self:GetPos():DistToSqr(viewEntity:EyePos()) <= range * range
end

function ENT:Think()
	local now = CurTime()
	local range = self.WakeRange + (self.IsSleeping and 0 or SLEEP_MARGIN)
	self.IsSleeping = not self:ShouldWake(range)
	if self.IsSleeping then
		self:StopAnomalyIdleEffects()
		self:SetNextClientThink(now + SLEEP_INTERVAL)

		return true
	end

	if not self.PlayingSound then
		self:EmitSound(self.IdleSound)
		self.PlayingSound = true
	end

	if self:GetNWBool("StopParticle", false) then
		stopParticle(self)
	elseif not self.particle or not self.particle:IsValid() then
		createParticle(self)
	end

	updateLight(self, now)
	if self.OnIdleThink then
		self:OnIdleThink(now)
	end
	self:SetNextClientThink(now + ACTIVE_INTERVAL)

	return true
end

function ENT:OnRemove()
	self:StopAnomalyIdleEffects()
end
