-- Included into each anomaly's ENT table without changing its registered base or class.
local ACTIVE_INTERVAL = 0.1
local SLEEP_INTERVAL = 0.5
local SLEEP_MARGIN = 250
local PARTICLE_OFFSET = Vector(0, 0, 0)
local INVISIBLE_COLOR = Color(0, 0, 0, 0)

ENT.WakeRange = 2500

local function stopParticle(entity)
	if entity.particle and entity.particle:IsValid() then
		entity.particle:StopEmission(false, true)
	end

	entity.particle = nil
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

local function createParticle(entity)
	entity.particle = CreateParticleSystem(entity, entity.IdleParticle, PATTACH_ABSORIGIN_FOLLOW, 0, PARTICLE_OFFSET)
	if not entity.particle or not entity.particle:IsValid() then return end

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
	local activated = entity:GetNWBool("Activated", false)
	local lightsEnabled = not ix or not ix.option or ix.option.Get("anomalyLights", true)
	if not lightsEnabled or not entity.IdleLight or (entity.IdleLight ~= "chemical" and not activated) then
		clearLight(entity)
		return
	end

	local light = DynamicLight(entity:EntIndex())
	if not light then return end

	light.pos = entity:GetPos()
	light.dietime = now + ACTIVE_INTERVAL * 2
	light.decay = 500
	light.brightness = 1
	if entity.IdleLight == "chemical" then
		light.r = 137
		light.g = 244
		light.b = 66
		light.size = activated and 170 or 128
		light.brightness = activated and 4 or 1
		light.decay = activated and 1000 or 500
	else
		light.r = 30
		light.g = 30
		light.b = 90
		light.size = 1024
		light.innerangle = 1
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
	self:SetNextClientThink(now + ACTIVE_INTERVAL)

	return true
end

function ENT:OnRemove()
	self:StopAnomalyIdleEffects()
end
