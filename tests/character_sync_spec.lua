-- Run from the addon root: luatex --luaonly tests/character_sync_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local function copy(value)
	if type(value) ~= "table" then
		return value
	end

	local result = {}

	for key, entry in pairs(value) do
		result[key] = copy(entry)
	end

	return result
end

-- String bytes alone give a lower bound without net.WriteTable's type/number overhead.
local function stringBytes(value)
	if type(value) == "string" then
		return #value
	elseif type(value) ~= "table" then
		return 0
	end

	local total = 0

	for key, entry in pairs(value) do
		total = total + stringBytes(key) + stringBytes(entry)
	end

	return total
end

local characterMeta = {}
ix = {
	meta = {character = characterMeta},
	char = {vars = {
		name = {},
		data = {isLocal = true},
		jobs = {},
		progression = {isLocal = true},
		vendorStock = {bNoNetworking = true},
		vendorRestockClaims = {bNoNetworking = true},
		money = {isLocal = true},
		steamID = {bNoNetworking = true},
	}},
}
local messages, currentMessage = {}, nil
net = {
	Start = function(name)
		currentMessage = {name = name, integers = {}}
	end,
	WriteTable = function(data)
		currentMessage.data = copy(data)
	end,
	WriteUInt = function(value, bits)
		currentMessage.integers[#currentMessage.integers + 1] = {value, bits}
	end,
	Send = function(receiver)
		assert(stringBytes(currentMessage.data) < 65533, "Trying to send an overflowed net message!")
		currentMessage.receiver = receiver
		messages[#messages + 1] = currentMessage
	end,
}
local owner = {EntIndex = function() return 7 end}
local observer = {EntIndex = function() return 8 end}
player = {Iterator = function() return ipairs({owner, observer}) end}
ix.characterNetwork = {SendInfo = function(character, data, receiver)
	messages[#messages + 1] = {
		name = "cotz/character/snapshot",
		data = copy(data),
		id = character:GetID(),
		playerIndex = character.player:EntIndex(),
		receiver = receiver,
	}
end}

-- Exercise the installed Sync, including broadcast recursion and non-owner filtering.
local file = assert(io.open("gamemodes/helix/gamemode/core/meta/sh_character.lua"))
local source = file:read("*a")
file:close()
local start = assert(source:find("\tfunction CHAR:Sync(receiver)", 1, true))
local finish = assert(source:find("\n\t-- Sets up", start, true))
local method = source:sub(start, finish - 1):gsub("!=", "~="):gsub("!", "not ")
assert(load(method, "@Helix:Sync", "t", setmetatable({CHAR = characterMeta}, {__index = _G})))()
function characterMeta:GetID()
	return self.id
end

local progression = {lines = {example = {active = true, completed = false, history = string.rep("p", 70000)}}}
local stock = {map = {trader = {history = string.rep("s", 70000)}}}
local claims = {map = {milestones = {example = true}, lastJob = 12}}
local characterData = {
	vendorStock = stock,
	vendorRestockClaims = claims,
	progression = progression,
	skin = 2,
	bleedingSeverity = 1,
}
local variables = {
	name = "Example",
	data = characterData,
	jobs = {contact = {identifier = "example", progress = 2}},
	progression = progression,
	vendorStock = stock,
	vendorRestockClaims = claims,
	money = 100,
	steamID = "private",
	unregistered = "not a character variable",
}
local character = setmetatable({id = 42, player = owner, vars = variables}, {__index = characterMeta})
local success, failure = pcall(function() character:Sync(owner) end)
check(not success and failure:find("overflowed", 1, true), "large private history reproduces the original overflow")
check(#messages == 0, "original overflowing sync does not reach the owner")

dofile("gamemodes/ix_cotz/schema/meta/sv_character.lua")
character:Sync(owner)
local message = messages[1]
check(message.name == "cotz/character/snapshot" and message.receiver == owner, "owner uses chunked snapshots")
check(message.id == 42, "snapshot retains character ID")
check(message.playerIndex == 7, "snapshot retains player index")
check(message.data.data.vendorStock == nil, "initial sync excludes personal stock history")
check(message.data.data.vendorRestockClaims == nil, "initial sync excludes stock claim history")
check(message.data.vendorStock == nil and message.data.vendorRestockClaims == nil,
	"private stock character vars are excluded from initial sync")
check(message.data.progression.lines.example.active, "owner receives the separate progression var")
check(stringBytes(message.data) > 65533, "large replicated progression bypasses the single-message table writer")
check(#message.data.progression.lines.example.history == 70000, "chunk transport receives all progression history")
check(message.data.data.progression.lines.example.active, "owner retains progression")
check(message.data.data.skin == 2 and message.data.data.bleedingSeverity == 1, "other character data is retained")
check(message.data.jobs.contact.progress == 2 and message.data.money == 100, "ordinary variables are retained")
check(message.data.steamID == nil and message.data.unregistered == nil, "variable networking rules are retained")
check(character.vars == variables and character.vars.data == characterData, "sync never replaces live saved tables")
check(characterData.vendorStock == stock and #stock.map.trader.history == 70000, "saved stock remains intact")
check(characterData.vendorRestockClaims == claims and claims.map.lastJob == 12, "saved claim guards remain intact")
check(characterData.progression == progression, "other saved data keeps its identity")

character:Sync(observer)
message = messages[2]
check(message.receiver == observer and message.data.name == "Example", "observer sync reaches the original method")
check(message.data.data == nil and message.data.money == nil, "observers cannot see owner-local state")
check(message.data.progression == nil, "observers cannot see the separate progression var")
check(message.data.steamID == nil, "observers cannot see non-networked variables")
check(message.data.jobs.contact.progress == 2, "original public variable visibility is preserved")

character:Sync()
check(#messages == 4, "broadcast still synchronizes both recipients")
check(messages[3].receiver == owner and messages[3].data.data.vendorStock == nil, "broadcast filters owner history")
check(messages[4].receiver == observer and messages[4].data.data == nil, "broadcast retains observer privacy")

character.vars.data = nil
character:Sync(owner)
check(messages[5].data.data == nil, "characters without saved data synchronize normally")
character.vars.data = {progression = progression}
character:Sync(owner)
check(messages[6].data.data.progression.lines.example.active, "characters without vendor history retain their data")

print("character_sync_spec: " .. checks .. " checks passed")
