-- Run from the addon root: luatex --luaonly tests/anomaly_types_spec.lua
-- Server behaviour of the anomaly types added with cotz_anomalies.pcf.
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local DMG_BURN, DMG_CRUSH, DMG_SHOCK, DMG_ACID, DMG_SONIC = 8, 1, 256, 1048576, 512

local vectorMeta = {}
vectorMeta.__index = vectorMeta
local function vector(x, y, z)
	return setmetatable({x = x or 0, y = y or 0, z = z or 0}, vectorMeta)
end
vectorMeta.__add = function(a, b) return vector(a.x + b.x, a.y + b.y, a.z + b.z) end
vectorMeta.__sub = function(a, b) return vector(a.x - b.x, a.y - b.y, a.z - b.z) end
vectorMeta.__mul = function(a, b)
	if type(a) == "number" then a, b = b, a end

	return vector(a.x * b, a.y * b, a.z * b)
end
function vectorMeta:LengthSqr() return self.x ^ 2 + self.y ^ 2 + self.z ^ 2 end
function vectorMeta:Length() return math.sqrt(self:LengthSqr()) end
function vectorMeta:Distance(other) return (self - other):Length() end
function vectorMeta:IsZero() return self:LengthSqr() == 0 end
function vectorMeta:Normalize()
	local length = self:Length()
	self.x, self.y, self.z = self.x / length, self.y / length, self.z / length
end

local state
local registry = {}

local function newState()
	state = {now = 100, timers = {}, found = {}, traceHit = {}, bursts = {}, hits = {}, sounds = {}}
end

local environment = setmetatable({
	DMG_BURN = DMG_BURN, DMG_CRUSH = DMG_CRUSH, DMG_SHOCK = DMG_SHOCK, DMG_ACID = DMG_ACID, DMG_SONIC = DMG_SONIC,
	MOVETYPE_NOCLIP = 8, MOVETYPE_VPHYSICS = 6, SOLID_NONE = 0, SOLID_BBOX = 2, SOLID_VPHYSICS = 6,
	COLLISION_GROUP_WORLD = 20, RENDERMODE_TRANSALPHA = 4, MASK_SOLID = 1, MASK_SOLID_BRUSHONLY = 2,
	PATTACH_ABSORIGIN_FOLLOW = 1, CHAN_AUTO = 0, CHAN_STATIC = 6,
	Vector = vector, vector_origin = vector(),
	VectorRand = function() return vector(1, 0, 0) end,
	Color = function(...) return {...} end,
	Angle = function(_, yaw)
		return {Forward = function()
			local radians = math.rad(yaw or 0)
			return vector(math.cos(radians), math.sin(radians), 0)
		end}
	end,
	AddCSLuaFile = function() end,
	sound = {Add = function() end},
	CurTime = function() return state.now end,
	IsValid = function(value) return value ~= nil and value.valid ~= false end,
	ParticleEffect = function(name) state.bursts[#state.bursts + 1] = name end,
	ParticleEffectAttach = function(name, _, victim) state.hits[#state.hits + 1] = {name, victim} end,
	DamageInfo = function()
		local info = {}
		function info:SetDamage(value) self.amount = value end
		function info:SetDamageType(value) self.damageType = value end
		function info:SetAttacker(value) self.attacker = value end
		function info:SetInflictor(value) self.inflictor = value end
		function info:SetDamagePosition(value) self.position = value end

		return info
	end,
	timer = {
		Create = function(name, delay, _, callback) state.timers[name] = {delay = delay, callback = callback} end,
		Remove = function(name) state.timers[name] = nil end,
	},
	ents = {FindInSphere = function() return state.found end},
	util = {TraceLine = function(trace)
		if trace.filter then
			return {Hit = state.traceHit[trace.filter[2]] or false}
		end

		-- Path traces: walls stop the loop at 200 units; the ground is 100 units down.
		local offset = trace.endpos - trace.start
		if offset.z < 0 then
			return {Hit = true, HitPos = vector(trace.start.x, trace.start.y, trace.start.z - 100)}
		end
		local length = offset:Length()
		if length <= 200 then return {Hit = false, HitPos = trace.endpos} end
		offset:Normalize()

		return {Hit = true, HitPos = trace.start + offset * 200}
	end},
	baseclass = {Get = function(name) return registry[name] end},
	math = setmetatable({Rand = function(low, high) return low + (high - low) * math.random() end}, {__index = math}),
}, {__index = _G})

local function load_class(name)
	if registry[name] then return registry[name] end

	local folder = "lua/entities/" .. name .. "/"
	local ENT = {}
	environment.ENT = ENT
	environment.include = function(path)
		local file = path == "shared.lua" and folder .. path or "lua/" .. path
		local handle = assert(io.open(file))
		local source = handle:read("*a")
		handle:close()

		return assert(load(source, "@" .. file, "t", environment))()
	end
	environment.include("shared.lua")
	local handle = assert(io.open(folder .. "init.lua"))
	local source = handle:read("*a")
	handle:close()
	assert(load(source, "@" .. folder .. "init.lua", "t", environment))()
	registry[name] = ENT
	if ENT.Base and ENT.Base ~= "base_anim" then
		setmetatable(ENT, {__index = load_class(ENT.Base)})
	end

	return ENT
end

local function spawn(class, position)
	local origin = position or vector()
	local entity = setmetatable({valid = true, nw = {}, emitted = {}}, {__index = load_class(class)})
	local noop = function() end
	for _, method in ipairs({"SetModel", "PhysicsInit", "SetMoveType", "SetSolid", "SetCollisionGroup",
		"SetCollisionBounds", "SetTrigger", "SetRenderMode", "SetColor", "DrawShadow", "StopParticles",
		"StopSound", "NextThink"}) do
		entity[method] = noop
	end
	entity.GetPhysicsObject = function() return nil end
	entity.GetPos = function() return origin end
	entity.SetPos = function(_, value) origin = value end
	entity.EntIndex = function() return 7 end
	entity.SetNWBool = function(self, key, value) self.nw[key] = value end
	entity.EmitSound = function(self, name) self.emitted[#self.emitted + 1] = name end
	entity.SetLocalVelocity = function(self, velocity) self.velocity = velocity end
	entity:Initialize()

	return entity
end

local function creature(kind, position)
	local victim = {valid = true, received = {}, position = position or vector()}
	victim.IsPlayer = function() return kind == "player" end
	victim.IsNPC = function() return kind == "npc" end
	victim.IsNextBot = function() return false end
	victim.IsRagdoll = function() return kind == "ragdoll" end
	victim.Alive = function() return true end
	victim.GetMoveType = function() return 2 end
	victim.GetPos = function() return victim.position end
	victim.WorldSpaceCenter = function() return victim.position + vector(0, 0, 36) end
	victim.TakeDamageInfo = function(_, info) victim.received[#victim.received + 1] = info end
	victim.SetVelocity = function(_, velocity) victim.velocity = velocity end
	victim.EmitSound = function() end
	victim.GetPhysicsObject = function() return nil end

	return victim
end

local function runTimer(name)
	local pending = state.timers[name]
	check(pending ~= nil, "timer " .. name .. " is pending")
	state.timers[name] = nil
	pending.callback()

	return pending.delay
end

-- Zones hurt whatever stands in them at a steady, per-victim rate.
newState()
local zone = spawn("anom_zone_fire")
local walker = creature("player")
zone:Touch(walker)
check(#walker.received == 1 and walker.received[1].damageType == DMG_BURN and walker.received[1].amount == 6,
	"the smouldering ground burns a player on contact")
zone:Touch(walker)
check(#walker.received == 1, "zone contact is rate-limited per victim")
local second = creature("npc")
zone:Touch(second)
check(#second.received == 1, "one victim's cooldown does not shield another")
state.now = state.now + 1
zone:Touch(walker)
check(#walker.received == 2, "zone damage repeats once the interval has passed")
zone:Touch({valid = true, IsPlayer = function() return false end, IsNPC = function() return false end,
	IsNextBot = function() return false end})
check(true, "props in a zone are ignored")
newState()
local acid = spawn("anom_zone_acid")
local wader = creature("player")
acid:Touch(wader)
check(wader.received[1].damageType == DMG_ACID, "acid mist deals chemical damage")

-- The Tesla warns, then discharges at everyone in the open.
newState()
local tesla = spawn("anom_tesla")
local exposed, covered = creature("player"), creature("player", vector(100, 0, 0))
state.found = {exposed, covered}
state.traceHit[covered] = true
tesla:Think()
check(#exposed.received == 0 and tesla.nw.Activated, "the tesla charges before it discharges")
check(state.bursts[#state.bursts] == "cotz_anom_tesla_charge", "the charge is visible")
tesla:Think()
check(#state.bursts == 1, "a charging tesla does not restart its charge")
check(runTimer("cotz/anomalies/tesla/7") == tesla.ChargeTime, "the discharge follows the charge time")
check(#exposed.received == 1 and exposed.received[1].damageType == DMG_SHOCK, "the discharge shocks exposed victims")
check(#covered.received == 0, "cover shields a victim from the discharge")
check(math.abs(exposed.received[1].amount - tesla.BalanceDamage * (1 - 0.5 * 40 / 320)) < 0.001,
	"discharge damage falls off with distance from the core")
tesla:Think()
check(state.timers["cotz/anomalies/tesla/7"] == nil, "the tesla rests for its cooldown")
state.now = state.now + tesla.BalanceCooldown
tesla:Think()
check(state.timers["cotz/anomalies/tesla/7"] ~= nil, "the tesla charges again after its cooldown")
state.found = {}
newState()
local idle = spawn("anom_tesla")
idle:Think()
check(state.timers["cotz/anomalies/tesla/7"] == nil, "an empty field never charges")

-- Psy pockets drain PsyHealth from players only, strongest at the centre.
newState()
local field = spawn("anom_psyfield")
local centre, edge, npc = creature("player"), creature("player", vector(350, 0, 0)), creature("npc")
state.found = {centre, edge, npc}
field:Think()
check(centre.received[1].damageType == DMG_SONIC and centre.received[1].amount == field.BalanceDamage,
	"the centre drains the full amount")
check(math.abs(edge.received[1].amount - field.BalanceDamage * field.EdgeDamage) < 0.001,
	"the edge drains the edge share")
check(#npc.received == 0, "psy damage never wounds NPCs")
state.now = field.nextPulse
field:Think()
check(#centre.received == 3 and centre.received[3].amount == field.PulseDamage, "a pulse adds its own drain")
check(state.bursts[#state.bursts] == "cotz_anom_psy_pulse" and field.nextPulse > state.now, "pulses are scheduled")

-- Springboards wind up, launch everything nearby and recover.
newState()
local springboard = spawn("anom_springboard")
local jumper = creature("player", vector(10, 0, 0))
state.found = {springboard, jumper}
springboard:StartTouch(jumper)
check(#jumper.received == 0, "the springboard waits for its wind-up")
springboard:StartTouch(jumper)
check(runTimer("cotz/anomalies/springboard/7") == springboard.WindUp, "one touch starts one wind-up")
check(jumper.received[1].damageType == DMG_CRUSH and jumper.received[1].amount == springboard.BalanceDamage,
	"the release deals impact damage")
check(jumper.velocity.z == springboard.LaunchSpeed and jumper.velocity.x == springboard.PushSpeed,
	"the release throws victims up and away")
springboard:StartTouch(jumper)
check(runTimer("cotz/anomalies/springboard/7") == springboard.BalanceCooldown and springboard.Active,
	"the springboard ignores contact until it recovers")

-- Comets fly a closed loop and scorch what they pass.
newState()
local comet = spawn("anom_comet")
local bystander = creature("player")
state.found = {bystander}
comet:Think()
check(#comet.path == comet.Waypoints, "the comet plans one waypoint per heading")
for _, point in ipairs(comet.path) do
	check(point.z == comet.HoverHeight - 100 + comet.HoverHeight, "waypoints hover over the ground")
	check(vector(point.x, point.y, 0):Length() <= 200 + 0.001, "waypoints stop short of walls")
end
check(math.abs(comet.velocity:Length() - comet.Speed) < 0.001, "the comet moves at its speed")
check(#bystander.received == 1 and bystander.received[1].damageType == DMG_BURN, "the comet burns what it touches")
comet:Think()
check(#bystander.received == 1, "comet hits are rate-limited per victim")
local electra = spawn("anom_comet_electra")
electra:Think()
check(bystander.received[2].damageType == DMG_SHOCK and #electra.path == 5, "ball lightning shocks on a tighter loop")

print(string.format("PASS: %d anomaly type checks", checks))
