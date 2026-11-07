-- Run from the addon root: luatex --luaonly tests/character_vitals_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end

SERVER, CLIENT = true, false
IsValid = function(value) return type(value) == "table" and not value.invalid end
local playerMeta = {}
FindMetaTable = function(name) assert(name == "Player") return playerMeta end
local pending = {}
timer = {Simple = function(_, callback) pending[#pending + 1] = callback end}
ix = {
	config = {Add = function() end},
	char = {RegisterVar = function() end},
	command = {Add = function() end},
	type = {string = 1, number = 2},
}

local function loadPlugin(path)
	PLUGIN = {}
	-- Translate the legacy GLua operators/comments for the standalone Lua runner.
	local source = read(path):gsub("/%*", "--[["):gsub("%*/", "]]"):gsub("!=", "~="):gsub("!", "not ")
	assert(load(source, "@" .. path))()

	return PLUGIN
end

local survival = loadPlugin("gamemodes/ix_cotz/plugins/survival_system.lua")
local psy = loadPlugin("gamemodes/ix_cotz/plugins/psyhealth.lua")
local stamina = loadPlugin("gamemodes/ix_cotz/plugins/stm/sh_plugin.lua")
local plugins = {survival, psy, stamina}

function playerMeta:GetCharacter() return self.character end
function playerMeta:GetLocalVar(key, default)
	local value = self.vars[key]
	if value == nil then return default end

	return value
end
function playerMeta:SetLocalVar(key, value) self.vars[key] = value end
function playerMeta:UpdateHungerState() self.updates = self.updates + 1 end
function playerMeta:UpdateThirstState() self.updates = self.updates + 1 end
function playerMeta:UpdatePsyHealthState() self.updates = self.updates + 1 end

local function newPlayer()
	return setmetatable({vars = {}, updates = 0}, {__index = playerMeta})
end

local function newCharacter(client, hunger, thirst, stm, psyHP)
	local character = {data = {hunger = hunger, thirst = thirst, stamina = stm}, psyHP = psyHP}
	function character:GetPlayer() return client end
	function character:GetData(key, default)
		local value = self.data[key]
		if value == nil then return default end

		return value
	end
	function character:SetData(key, value) self.data[key] = value end
	function character:GetPsyHP() return self.psyHP == nil and 100 or self.psyHP end
	function character:SetPsyHP(value) self.psyHP = value end
	function character:Save()
		for _, plugin in ipairs(plugins) do
			check(plugin:CharacterPreSave(self) == nil, "vital save hooks must not stop dispatch")
		end
	end

	return character
end

local function checkSaved(character, hunger, thirst, stm, psyHP)
	check(character:GetData("hunger", 100) == hunger, "saved hunger")
	check(character:GetData("thirst", 100) == thirst, "saved thirst")
	check(character:GetData("stamina", 100) == stm, "saved stamina")
	check(character:GetPsyHP() == psyHP, "saved psy health")
end

local function checkLive(client, hunger, thirst, stm, psyHP)
	check(client:GetLocalVar("hunger") == hunger, "immediate hunger restore")
	check(client:GetLocalVar("thirst") == thirst, "immediate thirst restore")
	check(client:GetLocalVar("stm") == stm, "immediate stamina restore")
	check(client:GetLocalVar("psyhealth") == psyHP, "immediate psy health restore")
end

local function flushTimers()
	local callbacks = pending
	pending = {}
	for _, callback in ipairs(callbacks) do callback() end
end

-- Town NPC initialization saves during PlayerLoadedCharacter, before legacy 0.25s restores.
for _, order in ipairs({{1, 2, 3}, {1, 3, 2}, {2, 1, 3}, {2, 3, 1}, {3, 1, 2}, {3, 2, 1}}) do
	local client = newPlayer()
	local character = newCharacter(client)
	survival:OnCharacterCreated(client, character)
	psy:OnCharacterCreated(client, character)
	client.character = character
	character:Save()
	checkSaved(character, 100, 100, 100, 100)
	for _, index in ipairs(order) do
		plugins[index]:PlayerLoadedCharacter(client, character)
		character:Save()
		checkSaved(character, 100, 100, 100, 100)
	end
	checkLive(client, 100, 100, 100, 100)
	flushTimers()
end

local client = newPlayer()
local first = newCharacter(client, 80, 70, 60, 50)
client.character = first
for _, plugin in ipairs(plugins) do plugin:PlayerLoadedCharacter(client, first) end
checkLive(client, 80, 70, 60, 50)
client.vars = {hunger = 45, thirst = 35, stm = 25, psyhealth = 15}
first:Save()
checkSaved(first, 45, 35, 25, 15)

-- The owner is valid for inactive characters too; their live vars belong to the active one.
local second = newCharacter(client, 90, 85, 75, 65)
second:Save()
checkSaved(second, 90, 85, 75, 65)
client.character = second
second:Save()
checkSaved(second, 90, 85, 75, 65)
for _, plugin in ipairs(plugins) do plugin:PlayerLoadedCharacter(client, second) end
checkLive(client, 90, 85, 75, 65)
first:Save()
checkSaved(first, 45, 35, 25, 15)

-- Missing runtime state preserves saved values, while genuine zero values remain zero.
client.vars = {}
second:Save()
checkSaved(second, 90, 85, 75, 65)
client.vars = {hunger = 0, thirst = 0, stm = 0, psyhealth = 0}
second:Save()
checkSaved(second, 0, 0, 0, 0)
for _, plugin in ipairs(plugins) do plugin:PlayerLoadedCharacter(client, second) end
checkLive(client, 0, 0, 0, 0)

client.character = nil
flushTimers()
check(client.updates == 0, "delayed state updates skip a character that is no longer active")
client.character = first
for _, plugin in ipairs(plugins) do plugin:PlayerLoadedCharacter(client, first) end
client.invalid = true
flushTimers()
check(client.updates == 0, "delayed state updates skip disconnected players")
first:Save()
checkSaved(first, 45, 35, 25, 15)

-- A new connection restores the persisted values, including actual depletion.
local reconnect = newPlayer()
local restored = newCharacter(reconnect, 0, 0, 0, 0)
reconnect.character = restored
restored:Save()
checkSaved(restored, 0, 0, 0, 0)
for _, plugin in ipairs(plugins) do plugin:PlayerLoadedCharacter(reconnect, restored) end
checkLive(reconnect, 0, 0, 0, 0)
flushTimers()
check(reconnect.updates == 3, "active character receives delayed survival and psy state updates")

print("character_vitals_spec: " .. checks .. " checks passed")
