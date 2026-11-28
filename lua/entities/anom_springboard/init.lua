AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

local fx = include("cotz/anomalies/sv_fx.lua")

-- Explicit balancing parameters used by the spreadsheet export/import tool.
ENT.BalanceDamage = 20
ENT.BalanceCooldown = 2.5
ENT.BalanceRadius = 110

-- Seconds between the first touch and the release, enough to feel the ground give.
ENT.WindUp = 0.25
ENT.LaunchSpeed = 620
ENT.PushSpeed = 260

local UP = Vector(0, 0, 1)

function ENT:Initialize()
	baseclass.Get("cotz_anomaly_base").Initialize(self)
	self.Active = true
end

local function launchVelocity(origin, target, push, launch)
	local away = target - origin
	away.z = 0
	if away:IsZero() then
		away = VectorRand()
		away.z = 0
	end
	away:Normalize()

	return away * push + UP * launch
end

function ENT:Launch(entity, velocity, origin)
	if fx.IsCreature(entity) then
		fx.Damage(self, entity, self.BalanceDamage, DMG_CRUSH, origin)
		entity:SetVelocity(velocity)
	elseif entity:IsRagdoll() then
		fx.Consume(entity)
	else
		local physics = entity:GetPhysicsObject()
		if IsValid(physics) and physics:IsMoveable() then
			physics:ApplyForceCenter(velocity * physics:GetMass())
		end
	end
end

function ENT:Release()
	local origin = self:GetPos()
	self:EmitSound("anomaly/anomaly_gravy_hit1.mp3", 90)
	self:EmitSound("anomaly/gravy_blast1.mp3", 95)
	self:StopParticles()
	self:SetNWBool("StopParticle", true)
	fx.Burst("cotz_anom_tramplin_blast", origin)
	fx.Flash(self, 0.4)

	for _, entity in ipairs(ents.FindInSphere(origin, self.BalanceRadius)) do
		if entity ~= self then
			self:Launch(entity, launchVelocity(origin, entity:GetPos(), self.PushSpeed, self.LaunchSpeed), origin)
		end
	end

	timer.Create("cotz/anomalies/springboard/" .. self:EntIndex(), self.BalanceCooldown, 1, function()
		if not IsValid(self) then return end

		self:SetNWBool("StopParticle", false)
		self.Active = true
	end)
end

function ENT:StartTouch(entity)
	if not self.Active then return end
	if not fx.IsCreature(entity) and not IsValid(entity:GetPhysicsObject()) then return end

	self.Active = false
	timer.Create("cotz/anomalies/springboard/" .. self:EntIndex(), self.WindUp, 1, function()
		if IsValid(self) then
			self:Release()
		end
	end)
end

function ENT:OnRemove()
	timer.Remove("cotz/anomalies/springboard/" .. self:EntIndex())
	fx.Clear(self)
end
