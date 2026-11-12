-- Run from the repository root: luatex --luaonly tests/blowout_items_spec.lua
SERVER = true
MOVETYPE_NOCLIP, MOVETYPE_OBSERVER = 8, 10
PLUGIN = {}
local removeItems = true
ix = {
	util = {Include = function() end}, command = {Add = function() end},
	config = {Add = function() end, Get = function(key, default)
		if key == "blowoutRemoveItems" then return removeItems end

		return default
	end},
	plugin = {list = {anomalycontroller = {
		cleanAnomalies = function() end, spawnAnomalies = function() end, trySpawnArtifacts = function() end,
	}}},
}
util = {AddNetworkString = function() end}
bit = {bor = function() return 0 end}
ix.type = {}
CurTime = function() return 100 end
math.Round = function(value) return math.floor(value + 0.5) end
player = {Iterator = function() return ipairs({}) end}
local function item(temporary, hideout)
	return {bTemporary = temporary, ixHideout = hideout, Remove = function(self) self.removed = true end}
end
local seed, dropped, loot, permanent = item(true, "home"), item(true, "home"), item(true), item(false)
local entities = {seed, loot, dropped, permanent}
ents = {FindByClass = function() return entities end}
dofile("gamemodes/ix_cotz/plugins/blowout/sh_plugin.lua")
function PLUGIN:RemoveBlowoutMarkFromPlayers() end
function PLUGIN:ChangePhase() end
local function hit()
	PLUGIN.NextBlowout = os.time() + 1000
	PLUGIN.BlowoutVars.BlowoutStarted = true
	PLUGIN.BlowoutVars.BlowoutStep = 5
	PLUGIN.BlowoutVars.BlowoutHitTime = 99
	PLUGIN.BlowoutVars.NextHitSound = 200
	PLUGIN.BlowoutVars.NextAmbientSound = 200
	PLUGIN:Think()
end
hit()
assert(not seed.removed and not dropped.removed, "blowout preserves seeded and player-dropped hideout items")
assert(loot.removed and not permanent.removed, "ordinary temporary loot cleanup retains its existing behavior")
assert(PLUGIN.BlowoutVars.BlowoutStep == 6, "the blowout hit completed")
entities = {item(true)}
removeItems = false
hit()
assert(not entities[1].removed, "disabling item cleanup still preserves ordinary loot")
print("PASS: blowout item cleanup preserves hideout floors")
