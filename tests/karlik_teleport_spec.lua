-- Run from the addon root: luatex --luaonly tests/karlik_teleport_spec.lua
local path = "lua/entities/npc_mutant_karlik/init.lua"
local file = assert(io.open(path))
local source = file:read("*a")
file:close()

local vectorMeta = {}
vectorMeta.__index = vectorMeta
function Vector(x, y, z)
	return setmetatable({x = x, y = y, z = z}, vectorMeta)
end
function vectorMeta.__add(a, b)
	return Vector(a.x + b.x, a.y + b.y, a.z + b.z)
end
function vectorMeta.__sub(a, b)
	return Vector(a.x - b.x, a.y - b.y, a.z - b.z)
end
function vectorMeta:Distance(other)
	return math.sqrt((self.x - other.x) ^ 2 + (self.y - other.y) ^ 2 + (self.z - other.z) ^ 2)
end

ENT = {}
IsValid = function(entity) return entity ~= nil and entity.valid == true end
MASK_ALL = 1
local traceCount = 0
local candidate = Vector(1000, 0, 0)
local hitSky = false
util = {
	TraceLine = function(data)
		traceCount = traceCount + 1

		return {HitPos = data.endpos}
	end,
	TraceHull = function()
		traceCount = traceCount + 1

		return {HitPos = candidate, HitSky = hitSky}
	end,
}

local start = assert(source:find("function ENT:GetTeleportLocation", 1, true))
assert(load(source:sub(start), "@" .. path))()
local position = Vector(0, 0, 0)
local npc = setmetatable({
	GetPos = function() return position end,
	GetEnemy = function(self) return self.enemy end,
}, {__index = ENT})

assert(npc:GetTeleportLocation() == position, "missing enemy keeps the current position")
assert(traceCount == 0, "missing enemy does not run teleport traces")
npc.enemy = {valid = false, GetPos = function() error("invalid enemy accessed") end}
assert(npc:GetTeleportLocation() == position, "removed enemy keeps the current position")
assert(traceCount == 0, "removed enemy does not run teleport traces")

npc.enemy = {valid = true, GetPos = function() return Vector(0, 0, 0) end}
assert(npc:GetTeleportLocation() == candidate, "valid enemy permits a distant teleport")
assert(traceCount == 2, "valid destination ends the search immediately")

traceCount = 0
hitSky = true
assert(npc:GetTeleportLocation() == position, "failed search retains the current position")
assert(traceCount == 52, "failed search retains the existing bounded trace budget")

print("Karlik teleport regression checks passed")
