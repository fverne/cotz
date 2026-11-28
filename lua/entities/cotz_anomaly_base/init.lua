AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

local PROXY_MODEL = "models/props_junk/watermelon01.mdl"
local INVISIBLE = Color(0, 0, 0, 0)
-- Matches the anomaly controller's wake distance for its other field anomalies.
local PLAYER_RANGE = 2500

function ENT:Initialize()
	self:SetModel(PROXY_MODEL)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetCollisionBounds(self.TriggerMins, self.TriggerMaxs)
	self:SetTrigger(true)
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
	self:SetColor(INVISIBLE)
	self:DrawShadow(false)
	self:SetNWBool("StopParticle", false)
	self.nextHurt = setmetatable({}, {__mode = "k"})

	local physics = self:GetPhysicsObject()
	if IsValid(physics) then
		physics:EnableMotion(false)
		physics:Sleep()
	end
end

-- Lets the anomaly skip its work while nobody is close enough to see or reach it.
function ENT:HasPlayerNear()
	if ix and ix.eventController then
		return ix.eventController:HasPlayerNear(self:GetPos(), PLAYER_RANGE)
	end

	return true
end

-- Rate-limits repeated damage to one victim.
function ENT:CanHurt(victim, interval)
	local now = CurTime()
	if (self.nextHurt[victim] or 0) > now then return false end

	self.nextHurt[victim] = now + interval

	return true
end

function ENT:SpawnFunction(client, trace, className)
	if not trace.Hit then return end

	local entity = ents.Create(className)
	entity:SetPos(trace.HitPos + Vector(0, 0, 4))
	entity:Spawn()
	entity:Activate()

	return entity
end
