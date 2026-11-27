-- Run from the repository root: luatex --luaonly tests/mimic_ambush_spec.lua
local fixture = dofile("tests/helpers/mutant_base.lua")
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local opened
local timers = {}
local spawned = {}
local canSpawn = true
local roll = 0
local chance = 8
local spawnRequests = {}
local nodes = {Vector(100, 0, 0), Vector(400, 0, 0)}
local components = {[nodes[1]] = 7, [nodes[2]] = 7}
local connectedPosition, fallbackPosition = Vector(450, 0, 0), Vector(300, 0, 0)

MASK_SOLID, MOVETYPE_NOCLIP = 1, 8
hook = {Add = function(event, _, callback)
	if event == "cotz/containers/open-started" then opened = callback end
end}
timer = {Simple = function(_, callback) timers[#timers + 1] = callback end}
util = {TraceLine = function() return {Hit = false} end}
math.Rand = function() return roll end
ents = {Create = function(class)
	local entity = {
		valid = true, class = class,
		SetPos = function(self, position) self.position = position end,
		SetAngles = function() end, Spawn = function() end, DropToFloor = function() end,
		MimicAmbush = function(self, client) self.quarry = client end,
	}
	spawned[#spawned + 1] = entity

	return entity
end}
ix = {
	config = {Get = function(key, default) return key == "mimicAmbushChance" and chance or default end},
	eventController = {
		GetSpawnNodes = function() return nodes, components end,
		GetSpawnLocation = function(_, _, radius, _, usable, component)
			spawnRequests[#spawnRequests + 1] = {radius = radius, component = component}
			local position
			if component then position = connectedPosition else position = fallbackPosition end
			if position and usable(position) then return position end
		end,
		CanSpawnMutant = function() return canSpawn end,
		RegisterMutant = function(_, entity) entity.registered = true end,
	},
}
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/cycliccontainer/sv_mimicambush.lua")
check(opened, "the ambush listens for container searches")

local function newContainer(category)
	return {
		valid = true, hidden = false,
		GetCyclicalCategory = function() return category or "stash" end,
		GetNoDraw = function(self) return self.hidden end,
		GetPos = function() return Vector() end,
		WorldSpaceCenter = function() return Vector(0, 0, 16) end,
	}
end

local function newClient()
	local client = {valid = true, character = {}, position = Vector(-40, 0, 0)}
	client.GetCharacter = function(self) return self.character end
	client.GetPos = function(self) return self.position end
	client.Alive = function() return true end
	client.GetMoveType = function() return 0 end

	return client
end

local function search(container, client, completes)
	local inventory = {}
	client.ixOpenStorage = inventory
	opened(container, client, inventory)
	if completes == false then client.ixOpenStorage = nil end
	local pending = timers
	timers = {}
	for _, callback in ipairs(pending) do callback() end
end

Angle = function() return {} end

local container, first, second = newContainer(), newClient(), newClient()
search(container, first, false)
check(#spawned == 0 and not container.cotzMimicRolled, "an interrupted search keeps the roll available")
search(container, first)
check(#spawned == 1 and spawned[1].class == "npc_mutant_mimic", "a completed search can draw a mimic")
check(spawned[1].quarry == first and spawned[1].registered, "the mimic hunts whoever opened the container")
check(spawnRequests[1].component == 7, "placement uses the nodegraph component beside the container")
search(container, first)
search(container, second)
check(#spawned == 1, "one container appearance rolls once, however many players open it")

roll, container = 99, newContainer()
search(container, first)
roll = 0
search(container, second)
check(#spawned == 1 and container.cotzMimicRolled, "a failed roll is spent too")

chance, container = 0, newContainer()
search(container, first)
check(#spawned == 1, "a zero chance disables ambushes")
chance = 8

search(newContainer(""), first)
check(#spawned == 1, "ordinary containers never roll")

local hidden = newContainer()
hidden.hidden = true
search(hidden, first)
check(#spawned == 1 and not hidden.cotzMimicRolled, "a container that vanished mid-search does not roll")

local switched = newContainer()
local inventory = {}
first.ixOpenStorage = inventory
opened(switched, first, inventory)
first.character = {}
timers[1]()
timers = {}
check(#spawned == 1 and not switched.cotzMimicRolled, "switching characters abandons the search")

connectedPosition, spawnRequests = nil, {}
search(newContainer(), first)
check(#spawned == 2 and spawned[2].position == fallbackPosition, "missing connected nodes fall back nearby")
check(spawnRequests[#spawnRequests].component == nil, "the fallback does not require a component")

canSpawn = false
search(newContainer(), first)
check(#spawned == 2, "the mutant population limit still applies")

local plugin = assert(io.open("gamemodes/ix_cotz/plugins/cycliccontainer/sh_plugin.lua"))
local source = plugin:read("*a")
plugin:close()
local appear = assert(source:match("function PLUGIN:AppearContainer.-function PLUGIN:DisappearContainer"))
check(appear:find("cotzMimicRolled = nil", 1, true), "a new appearance restores the roll")
check(source:find('ix.util.Include("sv_mimicambush.lua")', 1, true), "the plugin loads the ambush")

print(string.format("PASS: %d mimic ambush checks", checks))
