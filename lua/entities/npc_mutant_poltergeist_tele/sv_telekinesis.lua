-- Object selection for the telekinetic poltergeist. Loose props nearby are preferred; debris torn from the
-- ground makes up the rest, so the attack still works in empty rooms and open fields.
local OBJECT_COUNT = 3
local SEARCH_RADIUS = 500
local MAX_PROP_MASS = 80
local MAX_PROP_RADIUS = 48
local HOVER_HEIGHT = 80
local HURL_SPEED = 1400
local DEBRIS_ATTEMPTS = 12
local DEBRIS_RADIUS_MIN, DEBRIS_RADIUS_MAX = 60, 180
local DEBRIS_PROBE = Vector(0, 0, 400)
local DEBRIS_CLEARANCE = Vector(0, 0, 14)
local DEBRIS_MODELS = {
	"models/props_junk/cinderblock01a.mdl",
	"models/props_junk/metalbucket01a.mdl",
	"models/props_junk/metal_paintcan001a.mdl",
	"models/props_junk/sawblade001a.mdl",
}
local PROP_CLASSES = {prop_physics = true, prop_physics_multiplayer = true}

-- Only free, unremarkable props: never frozen, constrained, saved, carried or broken-box fragments.
function ENT:PoltergeistCanBorrow(entity)
	if not PROP_CLASSES[entity:GetClass()] or entity.cotzPoltergeistHeld then return false end
	if entity:GetCollisionGroup() == COLLISION_GROUP_DEBRIS or IsValid(entity:GetParent()) then return false end
	if entity:GetNetVar("Persistent") or entity:IsPlayerHolding() then return false end
	if constraint.HasConstraints(entity) or entity:BoundingRadius() > MAX_PROP_RADIUS then return false end

	local physics = entity:GetPhysicsObject()

	return IsValid(physics) and physics:IsMotionEnabled() and physics:IsMoveable()
		and physics:GetMass() <= MAX_PROP_MASS and self:Visible(entity)
end

function ENT:PoltergeistGrip(object, conjured)
	local grip = ents.Create("ent_poltergeist_grip")
	if not IsValid(grip) then return false end
	grip:SetPos(object:GetPos())
	grip:SetOwner(self)
	grip:Spawn()
	if not grip:Grab(object, conjured, HOVER_HEIGHT) then
		grip:Remove()
		return false
	end
	self.cotzGrips[#self.cotzGrips + 1] = grip

	return true
end

function ENT:PoltergeistDebrisPosition()
	local angle = math.Rand(0, math.pi * 2)
	local radius = math.Rand(DEBRIS_RADIUS_MIN, DEBRIS_RADIUS_MAX)
	local point = self:GetPos() + Vector(math.cos(angle) * radius, math.sin(angle) * radius, 0)
	local trace = util.TraceLine({
		start = point, endpos = point - DEBRIS_PROBE, mask = MASK_SOLID_BRUSHONLY,
	})
	if not trace.Hit or trace.StartSolid or trace.HitSky then return end

	local position = trace.HitPos + DEBRIS_CLEARANCE
	if util.TraceLine({start = self:WorldSpaceCenter(), endpos = position, mask = MASK_SOLID_BRUSHONLY}).Hit then
		return
	end

	return position
end

function ENT:PoltergeistConjure()
	local position = self:PoltergeistDebrisPosition()
	if not position then return false end

	local object = ents.Create("prop_physics")
	if not IsValid(object) then return false end
	object:SetModel(DEBRIS_MODELS[math.random(#DEBRIS_MODELS)])
	object:SetPos(position)
	object:SetAngles(AngleRand())
	object:Spawn()
	if not self:PoltergeistGrip(object, true) then
		object:Remove()
		return false
	end

	return true
end

function ENT:PoltergeistGather()
	self.cotzGrips = {}
	for _, entity in ipairs(ents.FindInSphere(self:GetPos(), SEARCH_RADIUS)) do
		if #self.cotzGrips >= OBJECT_COUNT then break end
		if self:PoltergeistCanBorrow(entity) then self:PoltergeistGrip(entity, false) end
	end
	for _ = 1, DEBRIS_ATTEMPTS do
		if #self.cotzGrips >= OBJECT_COUNT then break end
		self:PoltergeistConjure()
	end
end

function ENT:PoltergeistHurl(enemy)
	if not enemy or not self:Visible(enemy) then return end

	for _, grip in ipairs(self.cotzGrips or {}) do
		if IsValid(grip) and grip:IsHolding() then
			grip:Hurl(enemy, HURL_SPEED)
			return
		end
	end
end

function ENT:PoltergeistReleaseHeld()
	for _, grip in ipairs(self.cotzGrips or {}) do
		if IsValid(grip) and grip:IsHolding() then grip:Drop() end
	end
	self.cotzGrips = nil
end
