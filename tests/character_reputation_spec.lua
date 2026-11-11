-- Run from the addon root: luatex --luaonly tests/character_reputation_spec.lua
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

local function copy(value)
	if type(value) ~= "table" then return value end
	local result = {}
	for key, entry in pairs(value) do result[key] = copy(entry) end

	return result
end

local function execute(source)
	assert(load(source:gsub("!=", "~="):gsub("!", "not "), "@reputation regression"))()
end

local function section(source, first, following)
	local start = assert(source:find(first, 1, true))

	return source:sub(start, assert(source:find(following, start, true)) - 1)
end

SERVER, CLIENT = true, false
istable = function(value) return type(value) == "table" end
isnumber = function(value) return type(value) == "number" end
isstring = function(value) return type(value) == "string" end
isbool = function(value) return type(value) == "boolean" end
table.Copy = copy
table.Count = function(value)
	local count = 0
	for _ in pairs(value) do count = count + 1 end

	return count
end
math.Clamp = function(value, minimum, maximum) return math.max(minimum, math.min(maximum, value)) end
local playerMeta, commands, database, json = {}, {}, {}, {}
FindMetaTable = function() return playerMeta end
util = {TableToJSON = function(value)
	json[#json + 1] = copy(value)

	return tostring(#json)
end, JSONToTable = function(value) return copy(json[tonumber(value)]) end}
ix = {
	meta = {character = {vars = {}}}, char = {vars = {}},
	db = {AddToSchema = function() end}, type = {number = 1, string = 2},
	command = {Add = function(name, command) commands[name] = command end},
	util = {Include = function() end, FindPlayer = function(value) return value end},
	progression = {AssignActiveRequirements = function() end},
}
net = {Start = function() end, WriteUInt = function() end, WriteString = function() end,
	WriteType = function() end, Broadcast = function() end}
mysql = {}
function mysql:Update()
	local query = {values = {}}
	function query:Update(key, value) self.values[key] = value end
	function query:Where(_, id) self.id = id end
	function query:Callback(callback) self.callback = callback end
	function query:Execute()
		database[self.id] = copy(self.values)
		self.callback()
	end

	return query
end
CHAR = ix.meta.character
CHAR.__index = CHAR
local characterSource = read("gamemodes/helix/gamemode/core/meta/sh_character.lua")
execute(section(characterSource, "function ix.char.RegisterVar", "-- Allows access"))
execute(section(characterSource, "\tfunction CHAR:Save(callback)", "\t--- Networks"))
execute(section(read("gamemodes/helix/gamemode/core/libs/sh_character.lua"),
	"\tfunction ix.char.RestoreVars", "\nend\n"))
function CHAR:GetID() return self.id end
function CHAR:GetData(key, default)
	local value = self.vars.data[key]
	if value == nil then return default end

	return value
end
function CHAR:SetData(key, value) self.vars.data[key] = value end
ix.char.RegisterVar("data", {field = "data", default = {}, bNoNetworking = true,
	OnGet = CHAR.GetData, OnSet = CHAR.SetData})
PLUGIN = {}
execute(read("gamemodes/ix_cotz/plugins/karmarep/sh_plugin.lua"))
local reputation = PLUGIN
hook = {Run = function(name, ...)
	if reputation[name] then return reputation[name](reputation, ...) end
end}
PLUGIN = {}
execute(read("gamemodes/ix_cotz/plugins/townnpcs/sh_plugin.lua"))
execute(read("gamemodes/ix_cotz/plugins/townnpcs/libs/sv_runtime.lua"))
local town = PLUGIN
town.AdvanceCounters = function() end
town.RecoverCompletions = function(_, character)
	if character.reward then
		character.player:addReputation(character.reward)
		character:Save()
	end
end
function playerMeta:GetCharacter() return self.character end
function playerMeta:GetNetVar(key, default)
	local value = self.netVars[key]
	if value == nil then return default end

	return value
end
function playerMeta:SetNetVar(key, value) self.netVars[key] = value end
function playerMeta:Notify() end
local nextID = 0
local function newPlayer()
	return setmetatable({netVars = {}}, {__index = playerMeta})
end
local function newCharacter(client, rep, karma, name)
	nextID = nextID + 1

	return setmetatable({id = nextID, player = client,
		vars = {reputation = rep, karma = karma, data = {repOverride = name}}}, CHAR)
end
local function checkSaved(character, rep, karma, name)
	local row = database[character.id]
	check(tonumber(row.reputation) == rep, "saved reputation")
	check(tonumber(row.karma) == karma, "saved karma")
	check(util.JSONToTable(row.data).repOverride == name, "saved custom rank")
end

-- Use actual town initialization and Helix Save/RestoreVars with either load-hook order.
for _, townFirst in ipairs({true, false}) do
	for _, previous in ipairs({false, 0, 25, 8300}) do
		for _, reward in ipairs({0, 7}) do
			local client = newPlayer()
			client.netVars = {reputation = previous or nil, karma = -75, repOverride = "Previous"}
			local character = newCharacter(client, 4100, 25, "Guide")
			client.character = character
			character.reward = reward
			character:Save()
			checkSaved(character, 4100, 25, "Guide")
			check(client:getReputation() == 4100, "server reads saved reputation before restore")
			local order = townFirst and {town, reputation} or {reputation, town}
			for _, plugin in ipairs(order) do plugin:PlayerLoadedCharacter(client, character) end
			checkSaved(character, 4100 + reward, 25, "Guide")
			check(client:GetNetVar("reputation") == 4100 + reward, "display retains recovered reward")
			check(client:getKarma() == 25 and client:getRepName() == "Guide", "server reads character state")
			check(client:GetNetVar("karma") == 25 and client:GetNetVar("repOverride") == "Guide",
				"load refreshes karma and custom rank display")
		end
	end
end

local client = newPlayer()
local first = newCharacter(client, 1600, 50, "First")
client.character = first
reputation:PlayerLoadedCharacter(client, first)
client:addReputation(0.5)
client:addKarma(10)
client:SetRepName("Changed")
check(first:GetReputation() == 1600.5 and first:GetKarma() == 60
	and first:GetData("repOverride") == "Changed", "mutations immediately update character state")
first:Save()
checkSaved(first, 1600.5, 60, "Changed")
local second = newCharacter(client, 250, -25, "Second")
client.character = second
second:Save()
checkSaved(second, 250, -25, "Second")
client:addReputation(15)
second:Save()
reputation:PlayerLoadedCharacter(client, second, first)
first:Save()
checkSaved(first, 1600.5, 60, "Changed")
checkSaved(second, 265, -25, "Second")

client.netVars = {}
second:Save()
checkSaved(second, 265, -25, "Second")
client:addKarma(-500)
check(second:GetKarma() == -100 and client:GetNetVar("karma") == -100, "karma lower clamp")
client:addKarma(500)
check(second:GetKarma() == 100 and client:GetNetVar("karma") == 100, "karma upper clamp")
commands.charsetreputation:OnRun(client, client, 0)
commands.charrepnameset:OnRun(client, client, "Named")
check(second:GetData("repOverride") == "Named", "admin custom rank writes character data")
commands.charrepnameremove:OnRun(client, client)
client:addKarma(-100)
second:Save()
checkSaved(second, 0, 0, 0)
client.character = nil
client:setReputation(999)
client:addReputation(1)
client:addKarma(1)
client:SetRepName("No character")
second:Save()
checkSaved(second, 0, 0, 0)
check(client:getReputation() == 0 and client:getKarma() == 0 and client:getRepName() == 0,
	"server without an active character ignores stale display state")

-- A fresh connection restores persisted zeroes through the installed restore API.
local reconnect = newPlayer()
local restored = newCharacter(reconnect)
ix.char.RestoreVars(restored.vars, database[second.id])
reconnect.character = restored
reputation:PlayerLoadedCharacter(reconnect, restored)
check(reconnect:getReputation() == 0 and reconnect:getKarma() == 0 and reconnect:getRepName() == 0,
	"reconnect preserves genuine zeroes")
check(reconnect:GetNetVar("reputation") == 0, "reconnect displays a genuine zero")
first:Save()
checkSaved(first, 1600.5, 60, "Changed")
local retained = newCharacter(reconnect)
ix.char.RestoreVars(retained.vars, database[first.id])
reconnect.character = retained
retained:Save()
reputation:PlayerLoadedCharacter(reconnect, retained)
checkSaved(retained, 1600.5, 60, "Changed")
check(reconnect:GetNetVar("reputation") == 1600.5 and reconnect:GetNetVar("karma") == 60
	and reconnect:GetNetVar("repOverride") == "Changed", "reconnect restores nonzero saved values")
local fresh = newCharacter(reconnect)
reconnect.character = fresh
town:PlayerLoadedCharacter(reconnect, fresh)
reputation:PlayerLoadedCharacter(reconnect, fresh)
check(reconnect:getReputation() == 0 and reconnect:getKarma() == 0 and reconnect:getRepName() == 0,
	"new characters retain the registered defaults")
check(reconnect:GetNetVar("reputation") == 0 and reconnect:GetNetVar("karma") == 0
	and reconnect:GetNetVar("repOverride") == 0, "new characters replace previous display values")

SERVER, CLIENT = false, true
client.netVars = {reputation = 750, karma = 25, repOverride = "Client"}
check(client:getReputation() == 750 and client:getKarma() == 25 and client:getRepName() == "Client",
	"client getters retain network display behavior")
client:setReputation(0)
client:addKarma(-25)
client:SetRepName(0)
check(client:GetNetVar("reputation") == 750 and client:GetNetVar("karma") == 25
	and client:GetNetVar("repOverride") == "Client", "client mutations cannot change authoritative state")
client.netVars = {}
check(client:getReputation() == 0 and client:getKarma() == 0 and client:getRepName() == 0,
	"client missing network values default to zero")
print("character_reputation_spec: " .. checks .. " checks passed")
