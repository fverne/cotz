AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

local fx = include("cotz/anomalies/sv_fx.lua")

local PROXY_MODEL = "models/props_junk/watermelon01.mdl"
local INVISIBLE = Color(0, 0, 0, 0)
local MOVE_INTERVAL = 0.1
local WALL_CLEARANCE = 32
local GROUND_SEARCH = Vector(0, 0, 400)

ENT.Waypoints = 8
ENT.Speed = 140
ENT.HoverHeight = 45
ENT.HitRadius = 56

-- Comets fly through their loop, so they need no physics or trigger of their own.
function ENT:Initialize()
	self:SetModel(PROXY_MODEL)
	self:SetMoveType(MOVETYPE_NOCLIP)
	self:SetSolid(SOLID_NONE)
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
	self:SetColor(INVISIBLE)
	self:DrawShadow(false)
	self:SetNWBool("StopParticle", false)
	self.nextHurt = setmetatable({}, {__mode = "k"})
end

-- Built on the first think: the controller drops anomalies to the floor after spawning them.
function ENT:BuildPath()
	local center = self:GetPos() + Vector(0, 0, self.HoverHeight)
	local offset = math.Rand(0, 360)
	local path = {}

	for index = 1, self.Waypoints do
		local direction = Angle(0, offset + index * 360 / self.Waypoints, 0):Forward()
		local reach = util.TraceLine({
			start = center,
			endpos = center + direction * self.BalanceRadius * math.Rand(0.6, 1),
			mask = MASK_SOLID_BRUSHONLY,
		})
		local point = reach.HitPos - direction * (reach.Hit and WALL_CLEARANCE or 0)
		local ground = util.TraceLine({start = point, endpos = point - GROUND_SEARCH, mask = MASK_SOLID_BRUSHONLY})
		path[index] = ground.HitPos + Vector(0, 0, self.HoverHeight)
	end

	self.path = path
	self.waypoint = 1
end

function ENT:Steer()
	local position = self:GetPos()
	local offset = self.path[self.waypoint] - position
	if offset:LengthSqr() < (self.Speed * MOVE_INTERVAL * 1.5) ^ 2 then
		self.waypoint = self.waypoint % #self.path + 1
		offset = self.path[self.waypoint] - position
	end

	offset:Normalize()
	self:SetLocalVelocity(offset * self.Speed)
end

function ENT:Scorch()
	for _, entity in ipairs(ents.FindInSphere(self:GetPos(), self.HitRadius)) do
		if fx.IsCreature(entity) then
			if self:CanHurt(entity, self.BalanceCooldown) then
				fx.Damage(self, entity, self.BalanceDamage, self.CometDamageType)
				fx.Hit(entity, self.CometHitParticle)
				entity:EmitSound(self.CometHitSound, 75, math.random(95, 105))
			end
		elseif entity:IsRagdoll() then
			fx.Consume(entity)
		end
	end
end

function ENT:Think()
	if not self:HasPlayerNear() then
		self:SetLocalVelocity(vector_origin)
		self:NextThink(CurTime() + 1)

		return true
	end

	if not self.path then
		self:BuildPath()
	end
	self:Steer()
	self:Scorch()
	self:NextThink(CurTime() + MOVE_INTERVAL)

	return true
end

function ENT:OnRemove()
	fx.Clear(self)
end
