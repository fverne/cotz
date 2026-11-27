-- Shared standalone stubs for stalker_ai base specs. Returns a fixture with a controllable clock.
local fixture = {now = 100, errors = {}}

local vectorMeta = {}
vectorMeta.__index = vectorMeta

function Vector(x, y, z)
	return setmetatable({x = x or 0, y = y or 0, z = z or 0}, vectorMeta)
end

function vectorMeta.__add(a, b) return Vector(a.x + b.x, a.y + b.y, a.z + b.z) end
function vectorMeta.__sub(a, b) return Vector(a.x - b.x, a.y - b.y, a.z - b.z) end
function vectorMeta.__mul(a, b) return Vector(a.x * b, a.y * b, a.z * b) end
function vectorMeta.__div(a, b) return Vector(a.x / b, a.y / b, a.z / b) end
function vectorMeta:Dot(other) return self.x * other.x + self.y * other.y + self.z * other.z end
function vectorMeta:LengthSqr() return self:Dot(self) end
function vectorMeta:Length() return math.sqrt(self:LengthSqr()) end
function vectorMeta:DistToSqr(other) return (self - other):LengthSqr() end
function vectorMeta:Distance(other) return (self - other):Length() end

function vectorMeta:GetNormalized()
	local length = self:Length()
	if length == 0 then return Vector() end

	return self / length
end

function vectorMeta:Normalize()
	local normalized = self:GetNormalized()
	self.x, self.y, self.z = normalized.x, normalized.y, normalized.z
end

function vectorMeta:Angle()
	return {y = math.deg(math.atan(self.y, self.x)), direction = self:GetNormalized()}
end

function Angle(pitch, yaw, roll) return {p = pitch, y = yaw, r = roll} end

vector_origin = Vector()
vector_up = Vector(0, 0, 1)
NULL = {}
MASK_NPCSOLID, MOVETYPE_FLY, CAP_MOVE_GROUND = 1, 2, 4
MASK_SOLID_BRUSHONLY, MOVETYPE_WALK = 16, 32
physenv = {GetPerformanceSettings = function() return {MaxVelocity = fixture.maxVelocity or 4000} end}
DMG_AIRBOAT, DMG_SONIC = 16, 32

function CurTime() return fixture.now end
function IsValid(entity) return type(entity) == "table" and entity.valid == true end
function isnumber(value) return type(value) == "number" end
function isstring(value) return type(value) == "string" end
function istable(value) return type(value) == "table" end
function ErrorNoHalt(message) fixture.errors[#fixture.errors + 1] = message end
math.Rand = function(low, high) return (low + high) / 2 end
math.Clamp = function(value, low, high) return math.max(low, math.min(value, high)) end

function DamageInfo()
	local info = {}
	local setters = {
		"SetDamage", "SetDamageType", "SetAttacker", "SetInflictor", "SetDamagePosition", "SetDamageForce",
	}
	for _, method in ipairs(setters) do
		info[method] = function(self, value) self[method:sub(4)] = value end
	end

	return info
end

function fixture.LoadBase(...)
	ENT = {}
	for _, name in ipairs({...}) do
		dofile("lua/entities/stalker_ai/" .. name .. ".lua")
	end

	return ENT
end

function fixture.Target(position, extra)
	local target = {
		valid = true, position = position, health = 100, damage = {},
		GetPos = function(self) return self.position end,
		WorldSpaceCenter = function(self) return self.position + Vector(0, 0, 36) end,
		OBBCenter = function() return Vector(0, 0, 36) end,
		GetVelocity = function(self) return self.velocity or Vector() end,
		Health = function(self) return self.health end,
		IsPlayer = function(self) return self.player == true end,
		IsNPC = function(self) return self.player ~= true end,
		TakeDamageInfo = function(self, info) self.damage[#self.damage + 1] = info end,
	}
	for key, value in pairs(extra or {}) do target[key] = value end

	return target
end

local function translateLegacy(source)
	source = source:gsub("^\239\187\191", ""):gsub("/%*.-%*/", "")
	source = source:gsub("!=", "~="):gsub("&&", " and "):gsub("||", " or "):gsub("!", "not ")

	return (source:gsub("//([^\n]*)", "--%1"))
end

-- Loads a mutant's file-scope definitions and the requested methods onto a class backed by `base`.
-- Each method compiles with the file header so it keeps its file-local constants; methods using
-- GLua-only syntax such as `continue` can be left out.
function fixture.LoadMutant(name, base, methods)
	local input = assert(io.open("lua/entities/npc_mutant_" .. name .. "/init.lua"))
	local source = translateLegacy(input:read("*a"))
	input:close()
	local first = assert(source:find("\nfunction ENT:", 1, true))
	local header = source:sub(1, first)

	AddCSLuaFile, include = function() end, function() end
	sound = sound or {Add = function() end}
	local class = {}
	-- Inherited tables such as DieSound come from STALKERNPCBaseVars; supply them while the header runs.
	ENT = setmetatable(class, {__index = function(entity, key)
		local value = base[key]
		if value ~= nil then return value end
		value = {}
		rawset(entity, key, value)

		return value
	end})
	local chunks = {}
	for _, method in ipairs(methods) do
		local start = assert(source:find("function ENT:" .. method .. "(", first, true), name .. " lacks " .. method)
		local finish = source:find("\nfunction ENT:", start + 1, true)
		chunks[#chunks + 1] = source:sub(start, finish and finish - 1 or #source)
	end
	assert(load(header .. "\n" .. table.concat(chunks, "\n"), "@npc_mutant_" .. name))()
	setmetatable(class, {__index = base})

	return class
end

-- A minimal actor that records the base calls abilities make, backed by the loaded base table.
function fixture.Actor(base, extra)
	local actor = setmetatable({
		valid = true, IsAlive = true, PlayingAnimation = false, position = Vector(), animations = {},
		grounded = true, class = "npc_mutant_test",
		GetClass = function(self) return self.class end,
		GetEnemy = function(self) return self.enemy end,
		GetPos = function(self) return self.position end,
		WorldSpaceCenter = function(self) return self.position + Vector(0, 0, 36) end,
		OBBCenter = function() return Vector(0, 0, 36) end,
		IsOnGround = function(self) return self.grounded end,
		STALKERNPCPlayAnimation = function(self, animation, index)
			self.PlayingAnimation = true
			self.Animation, self.AttackIndex = animation, index
			self.animations[#self.animations + 1] = animation
		end,
		STALKERNPCClearAnimation = function(self)
			self.PlayingAnimation = false
			self.Animation = ""
			self.cleared = (self.cleared or 0) + 1
		end,
		STALKERNPCStopAllTimers = function(self) self.stopped = (self.stopped or 0) + 1 end,
		STALKERNPCMakeMeleeAttack = function(self, index) self.meleeAttacks[#self.meleeAttacks + 1] = index end,
		STALKERNPCPlaySoundRandom = function(self, _, name) self.sounds[#self.sounds + 1] = name end,
		STALKERNPCNavigationJumpVelocity = function(_, _, short) return Vector(short and 1 or 2, 0, 0) end,
		EmitSound = function(self, name) self.sounds[#self.sounds + 1] = name end,
		SetVelocity = function(self, velocity) self.velocities[#self.velocities + 1] = velocity end,
		GetForward = function() return Vector(1, 0, 0) end,
		GetRight = function() return Vector(0, 1, 0) end,
		GetUp = function() return Vector(0, 0, 1) end,
		GetAngles = function() return Angle(0, 0, 0) end,
		SetAngles = function(self, angles) self.angles = angles end,
		SetPos = function(self, position) self.position = position end,
		Health = function(self) return self.health end,
		SetHealth = function(self, health) self.health = health end,
		GetMaxHealth = function(self) return self.maxHealth end,
		SetNWBool = function(self, key, value) self.networked[key] = value end,
		SetNWVector = function(self, key, value) self.networked[key] = value end,
	}, {__index = base})
	actor.meleeAttacks, actor.sounds, actor.velocities, actor.networked = {}, {}, {}, {}
	actor.health, actor.maxHealth = 100, 1000
	for key, value in pairs(extra or {}) do actor[key] = value end

	return actor
end

return fixture
