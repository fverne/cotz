-- Run from the addon root: luatex --luaonly tests/event_spawnplacement_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local root = "gamemodes/ix_cotz/plugins/eventcontroller/"
local vectorMeta = {}
Vector = function(x, y, z) return setmetatable({x = x, y = y, z = z}, vectorMeta) end
vectorMeta.__add = function(a, b) return Vector(a.x + b.x, a.y + b.y, a.z + b.z) end
vectorMeta.__sub = function(a, b) return Vector(a.x - b.x, a.y - b.y, a.z - b.z) end
vectorMeta.__index = {
	DistToSqr = function(a, b) return (a.x - b.x) ^ 2 + (a.y - b.y) ^ 2 + (a.z - b.z) ^ 2 end,
}
MASK_SOLID, CAP_MOVE_GROUND = 1, 1
bit = {band = function(a, b) return a & b end}
local mapName, engineCount = "test", 0
game = {GetMap = function() return mapName end}
ai = {GetNodeCount = function() return engineCount end}
local warnings, opens, closes, files = {}, 0, 0, {}
ErrorNoHalt = function(message) warnings[#warnings + 1] = message end
local function binaryFile(data)
	local cursor = 1
	local handle = {
		Size = function() return #data end,
		Seek = function(_, offset) cursor = offset + 1 end,
		Close = function() closes = closes + 1 end,
	}
	for name, format in pairs({ReadLong = "<i4", ReadShort = "<i2", ReadFloat = "<f", ReadByte = "<I1"}) do
		handle[name] = function()
			local value
			value, cursor = string.unpack(format, data, cursor)

			return value
		end
	end

	return handle
end
file = {Open = function(path, mode, realm)
	check(mode == "rb" and realm == "GAME", "graph and BSP are read-only mounted game files")
	opens = opens + 1

	return files[path] and binaryFile(files[path])
end}
local function makeGraph(nodes, links, version, revision)
	local parts = {string.pack("<i4i4i4", version or 37, revision or 1, #nodes)}
	for _, node in ipairs(nodes) do
		parts[#parts + 1] = string.pack("<ffff", node.x or 0, node.y or 0, node.z or 0, 0)
		parts[#parts + 1] = string.pack("<f", node.offset or 0)
		parts[#parts + 1] = string.rep("\0", 36)
		parts[#parts + 1] = string.pack("<I1I2i2", node.kind or 2, 0, 4)
	end
	parts[#parts + 1] = string.pack("<i4", #links)
	for _, link in ipairs(links) do
		parts[#parts + 1] = string.pack("<i2i2I1", link[1], link[2], link[3] or 1) .. string.rep("\0", 9)
	end
	parts[#parts + 1] = string.rep("\0", #nodes * 4)

	return table.concat(parts)
end
PLUGIN = {spawnradius = 750, saferadius = 1500}
local function loadGraph(data, count, bspRevision)
	files, warnings, opens, closes = {}, {}, 0, 0
	engineCount = count or 0
	files["maps/graphs/test.ain"] = data
	if bspRevision then files["maps/test.bsp"] = string.rep("\0", 1032) .. string.pack("<i4", bspRevision) end
	dofile(root .. "sv_spawnnodes.lua")

	return PLUGIN:GetSpawnNodes()
end
local graph = makeGraph({{x = 100, z = 40, offset = -40}, {x = 300}, {kind = 3}, {}, {}, {}},
	{{0, 1}, {1, 2}, {3, 4, 2}, {5, 5}})
local nodes = loadGraph(graph, 6, 1)
check(#nodes == 2 and nodes[1].x == 100 and nodes[1].z == 0,
	"only ground nodes with a human ground link survive; hull-specific height is applied")
check(closes == 2 and #warnings == 0, "successful graph and BSP handles close without warnings")
local before = opens
check(PLUGIN:GetSpawnNodes() == nodes and opens == before, "nodegraph is cached rather than reread per spawn")
check(not loadGraph(nil) and #warnings == 1, "missing graph selects safe fallback and reports it")
before = opens
PLUGIN:GetSpawnNodes()
check(opens == before and #warnings == 1, "missing graph is cached and warns once")
check(not loadGraph("short") and closes == 1, "short header is rejected and closed")
check(not loadGraph(makeGraph({}, {}, 99)) and closes == 1, "unsupported format is rejected")
check(not loadGraph(string.pack("<i4i4i4", 37, 1, -1)), "negative node count is rejected")
check(not loadGraph(string.pack("<i4i4i4", 37, 1, 32769)), "node count has a fixed allocation bound")
check(not loadGraph(graph:sub(1, 50), 6), "truncated node records are rejected")
check(not loadGraph(graph:sub(1, -2), 6), "truncated link/lookup data is rejected")
check(not loadGraph(graph, 5), "graph count must match the engine")
check(not loadGraph(graph, 6, 2) and closes == 2, "stale BSP revision is rejected with both files closed")
check(not loadGraph(makeGraph({{}, {}}, {{0, 2}}), 2), "invalid link endpoints are rejected")
check(not loadGraph(makeGraph({{x = math.huge}, {}}, {{0, 1}}), 2), "non-finite positions are rejected")
check(#loadGraph(makeGraph({{}, {}}, {}), 2) == 0, "valid graph without connections yields no node candidates")

local floor, blocked, inWorld, hullCalls, lineCalls = {}, false, true, 0, 0
local function resetFloor(changes)
	floor = {Hit = true, HitWorld = true, HitNormal = Vector(0, 0, 1), HitPos = Vector(100, 0, 0)}
	for key, value in pairs(changes or {}) do floor[key] = value end
	blocked, inWorld, hullCalls, lineCalls = false, true, 0, 0
end
util = {
	IsInWorld = function() return inWorld end,
	TraceLine = function(data)
		check(data.mask == MASK_SOLID and data.start.z - data.endpos.z == 160,
			"floor trace includes props and stays within a bounded vertical range")
		lineCalls = lineCalls + 1

		return floor
	end,
	TraceHull = function(data)
		check(data.mask == MASK_SOLID and data.mins.x <= -52 and data.maxs.x >= 52 and data.maxs.z >= 105,
			"clearance covers the largest current encounter actors and includes solid collisions")
		hullCalls = hullCalls + 1

		return {Hit = blocked}
	end,
}
dofile(root .. "sv_spawnplacement.lua")
resetFloor()
local position = PLUGIN:GetGroundedSpawnLocation(Vector(100, 0, 8))
check(position and position.z == 2, "world floor is grounded with a small clearance")
for _, changes in ipairs({{Hit = false}, {StartSolid = true}, {AllSolid = true}, {HitSky = true},
	{HitWorld = false}, {HitNormal = Vector(0, 0, 0.5)}, {HitTexture = "**studio**"}, {HitBox = 1}}) do
	resetFloor(changes)
	check(not PLUGIN:GetGroundedSpawnLocation(Vector(100, 0, 8)), "unsafe or prop-supported fallback is rejected")
end
resetFloor({HitTexture = "**studio**", HitBox = 1})
check(PLUGIN:GetGroundedSpawnLocation(Vector(100, 0, 8), true),
	"connected graph nodes may use authored static prop walkways")
check(not PLUGIN:GetGroundedSpawnLocation(Vector(100, 0, 100), true),
	"graph node cannot snap onto a different floor or newly placed tall obstacle")
resetFloor()
blocked = true
check(not PLUGIN:GetGroundedSpawnLocation(Vector(100, 0, 8)), "blocked hull is rejected")
blocked, inWorld = false, false
check(not PLUGIN:GetGroundedSpawnLocation(Vector(100, 0, 8)), "outside-world spawn is rejected")

local originalRandom = math.random
math.random = function(minimum, maximum) return maximum and maximum or 1 end
PLUGIN.GetSpawnNodes = function() return {Vector(100, 0, 8), Vector(300, 0, 8),
	Vector(2000, 0, 8), Vector(0, 0, 300)} end
resetFloor()
position = PLUGIN:GetSpawnLocation(Vector(0, 0, 5))
check(position and position.x == 100 and hullCalls == 1, "nearby graph placement needs no sweep from the event center")
blocked, lineCalls = true, 0
check(not PLUGIN:GetSpawnLocation(Vector(0, 0, 5)) and lineCalls == 3,
	"blocked graph candidates are tried once each, followed by the validated fallback center")
PLUGIN.GetSpawnNodes = function() return {} end
resetFloor()
check(PLUGIN:GetSpawnLocation(Vector(0, 0, 5)) and lineCalls == 1,
	"valid graph with no usable node still spawns on validated nearby ground")
PLUGIN.GetSpawnNodes = function() return {Vector(100, 0, 8)} end
resetFloor({HitPos = Vector(100, 0, -40)})
check(PLUGIN:GetSpawnLocation(Vector(0, 0, 5)) and lineCalls == 2,
	"unsafe graph-floor height falls through to safe ordinary ground sampling")
PLUGIN.GetSpawnNodes = function() end
resetFloor({HitTexture = "**studio**"})
check(not PLUGIN:GetSpawnLocation(Vector(0, 0, 5)) and lineCalls == 25,
	"missing-graph fallback has bounded attempts and never blindly accepts a prop-supported center")
resetFloor()
check(PLUGIN:GetSpawnLocation(Vector(0, 0, 5)), "missing-graph fallback still permits validated world floors")
local summoner = {}
local ordinaryHullTrace = util.TraceHull
local sweepCalls, clearanceCalls = 0, 0
PLUGIN.GetSpawnNodes = function() return {Vector(300, 0, 8)} end
util.TraceHull = function(data)
	if data.start:DistToSqr(data.endpos) > 0 then
		sweepCalls = sweepCalls + 1
		check(data.filter == summoner and data.endpos.x == 128 and data.endpos.y == 128,
			"summons use their own radius and ignore the owner only during the outward sweep")

		return {Hit = data.filter ~= summoner}
	end
	clearanceCalls = clearanceCalls + 1
	check(data.filter == nil, "summon clearance still collides with the owner and existing summons")

	return {Hit = false}
end
resetFloor()
check(PLUGIN:GetSpawnLocation(Vector(0, 0, 5), 128, summoner) and sweepCalls == 1 and clearanceCalls == 1,
	"summoning falls back from nodes outside its radius without blocking on the owner's hull at the origin")
util.TraceHull = ordinaryHullTrace
math.random = originalRandom

-- Exercise the actual encounter entry point and delayed queue, including a blocker appearing after selection.
local sourceFile = assert(io.open(root .. "sh_plugin.lua"))
local source = sourceFile:read("*a")
sourceFile:close()
local method = assert(source:match("(function PLUGIN:SpawnEncounterEntity.-\n\tend)"))
assert(load(method))()
CurTime = function() return 100 end
ix = {eventController = PLUGIN, config = {Get = function(_, default) return default end}}
IsValid = function(entity) return entity ~= nil end
local created, registered = 0, 0
ents = {Create = function()
	created = created + 1

	return {SetPos = function() end, Spawn = function() blocked = true end, DropToFloor = function() end}
end}
dofile(root .. "sv_performance.lua")
PLUGIN.CanPopulateMutant = function() return true end
PLUGIN.CanQueueMutant = function() return true end
PLUGIN.HasPlayerNear = function() return false end
PLUGIN.RegisterMutant = function() registered = registered + 1 end
PLUGIN.RegisterCombatActor = function() registered = registered + 1 end
local pack = {}
PLUGIN.GetSpawnLocation = function() end
check(not PLUGIN:SpawnEncounterEntity("npc_mutant_dog", Vector(0, 0, 0), pack)
	and not PLUGIN:SpawnEncounterEntity("npc_human_bandit", Vector(0, 0, 0), pack) and created == 0,
	"failed placement creates neither queued mutants nor humans")
PLUGIN.GetSpawnLocation = function() return Vector(100, 0, 2) end
resetFloor()
check(PLUGIN:SpawnEncounterEntity("npc_mutant_dog", Vector(0, 0, 0), pack), "routine spawn enters the queue")
blocked = true
PLUGIN:ProcessMutantQueue()
check(created == 0, "new blockers cancel queued routine spawns before entity creation")
blocked = false
PLUGIN:SpawnEncounterEntity("npc_mutant_dog", Vector(0, 0, 0), pack)
PLUGIN:SpawnEncounterEntity("npc_mutant_dog", Vector(0, 0, 0), pack)
PLUGIN:ProcessMutantQueue()
check(created == 1 and registered == 1, "first queued mutant prevents a later overlapping queued spawn")
blocked = false
local human = PLUGIN:SpawnEncounterEntity("npc_human_bandit", Vector(0, 0, 0), pack)
check(human and human.cotzCombatPack == pack and created == 2 and registered == 2,
	"humans use validated placement and retain encounter pack registration")

-- Optional compatibility check against installed AIN files supplied on the command line.
for index = 1, #arg do
	local path = arg[index]
	if path:match("%.ain$") then
		local input = assert(io.open(path, "rb"))
		local data = input:read("*a")
		input:close()
		local count = string.unpack("<i4", data, 9)
		local loaded = loadGraph(data, count)
		check(loaded and #loaded > 0, "installed graph parses: " .. path)
		print("Parsed " .. path .. ": " .. #loaded .. " connected ground nodes")
	end
end
print("PASS: " .. checks .. " event spawn placement checks")
