-- Run from the addon root: luatex --luaonly tests/character_network_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end

table.Count = function(value)
	local count = 0
	for _ in pairs(value) do count = count + 1 end

	return count
end
string.Explode = function(_, value)
	local result = {}
	for part in value:gmatch("[^,]+") do result[#result + 1] = part end

	return result
end
Vector = function(x, y, z) return setmetatable({x = x, y = y, z = z}, {kind = "Vector"}) end
Angle = function(p, y, r) return setmetatable({p = p, y = y, r = r}, {kind = "Angle"}) end
local entity = setmetatable({EntIndex = function() return 7 end}, {kind = "Entity"})
Entity = function(index) assert(index == 7) return entity end
IsValid = function(value) return value ~= nil and value ~= false end
local luaType = type
local environment = setmetatable({type = function(value)
	local meta = getmetatable(value)

	return meta and meta.kind or luaType(value)
end}, {__index = _G})
-- The installed pON has one GLua continue for invalid keys; this fixture only encodes valid keys.
local ponSource = read("gamemodes/helix/gamemode/core/libs/thirdparty/sh_pon.lua")
ponSource = ponSource:gsub("if not k then continue end", "assert(k ~= nil, \"Unexpected nil key\")")
assert(load(ponSource, "@installed pON", "t", environment))()

local wire, current, handlers, registered = {}, nil, {}, {}
local function write(value, bits)
	current.fields[#current.fields + 1] = value
	current.bits = current.bits + bits
end
net = {
	Start = function(name) current = {name = name, fields = {}, bits = 0} end,
	WriteBool = function(value) write(value, 1) end,
	WriteUInt = function(value, bits)
		assert(value >= 0 and value < 2 ^ bits)
		write(value, bits)
	end,
	WriteData = function(value, length)
		assert(#value == length)
		write(value, length * 8)
	end,
	Send = function(receiver)
		assert(current.bits < 65533 * 8, "Trying to send an overflowed net message!")
		current.receiver = receiver
		wire[#wire + 1] = current
	end,
	Receive = function(name, callback) handlers[name] = callback end,
}
-- Keep compression as identity to force multiple chunks even for highly repetitive saved state.
-- The engine's LZMA implementation is not available in standalone Lua.
local compressions, decompressions = 0, 0
util = {
	AddNetworkString = function(name) registered[name] = true end,
	Compress = function(value) compressions = compressions + 1 return value end,
	Decompress = function(value) decompressions = decompressions + 1 return value end,
}
SERVER = true
ix = {meta = {character = {}}, char = {loaded = {}, vars = {}}}
function ix.char.RegisterVar(key, definition)
	ix.char.vars[key] = definition
	ix.meta.character.SetProgression = definition.OnSet
end
local changes = {}
hook = {Run = function(...) changes[#changes + 1] = {...} end}
dofile("gamemodes/ix_cotz/schema/libs/sh_characternetwork.lua")
dofile("gamemodes/ix_cotz/plugins/progression/libs/sh_storage.lua")
local character = setmetatable({id = 42, player = entity, vars = {}}, {__index = ix.meta.character})
function ix.meta.character:GetID() return self.id end
local record = {lines = {example = {history = string.rep("a;\0z", 40000), completed = false}}}
local data = {name = "Example", progression = record, data = {skin = 0, [123] = "numeric key",
	position = Vector(1, 2, 3), angle = Angle(4, 5, 6), entity = entity}}
ix.characterNetwork.SendInfo(character, data, entity)
local snapshotEnd = #wire
check(snapshotEnd > 1, "initial snapshots larger than a net message are split")
check(registered[wire[1].name], "the schema registers its message server-side")
for _, message in ipairs(wire) do
	check(message.receiver == entity and message.fields[3] <= 60000, "chunks are bounded and owner-directed")
end
local before = {lines = {old = {completed = true}}}
character.vars.progression = before
character:SetProgression(record)
local updateEnd = #wire
check(updateEnd > snapshotEnd + 1, "large progression updates also split")
check(character.vars.progression == record, "the setter commits authoritative state")
check(#changes == 1 and changes[1][1] == "CharacterVarChanged" and changes[1][2] == character
	and changes[1][3] == "progression" and changes[1][4] == before and changes[1][5] == record,
	"the setter preserves the installed Helix hook contract")

-- Register the actual client receiver, then replay reliable messages in order.
SERVER = false
dofile("gamemodes/ix_cotz/schema/libs/sh_characternetwork.lua")
ix.char.New = function(vars, id, playerIndex)
	return {vars = vars, id = id, playerIndex = playerIndex}
end
local function deliver(index)
	local message = wire[index]
	local position = 0
	local function readField()
		position = position + 1

		return message.fields[position]
	end
	net.ReadBool = readField
	net.ReadUInt = function(bits) assert(bits == 16) return readField() end
	net.ReadData = function(length)
		local value = readField()
		assert(#value == length)

		return value
	end
	handlers[message.name]()
end
for index = 1, snapshotEnd - 1 do deliver(index) end
check(ix.char.loaded[42] == nil, "partial snapshots never create incomplete characters")
deliver(snapshotEnd)
local loaded = ix.char.loaded[42]
check(loaded.id == 42 and loaded.playerIndex == 7, "the client receives character and player identity")
check(loaded.vars.progression.lines.example.history == record.lines.example.history,
	"large saved state including NULs and escaped strings survives chunk assembly")
check(loaded.vars.progression.lines.example.completed == false and loaded.vars.data.skin == 0,
	"false and zero values survive")
check(loaded.vars.data[123] == "numeric key" and loaded.vars.data.position.z == 3
	and loaded.vars.data.angle.r == 6, "numeric keys and engine value types survive")
check(loaded.vars.data.entity == entity, "entity references resolve through the bundled serializer")
loaded.vars.progression = before
for index = snapshotEnd + 1, updateEnd - 1 do deliver(index) end
check(loaded.vars.progression == before, "partial updates leave previous state intact")
deliver(updateEnd)
check(ix.char.loaded[42] == loaded and loaded.vars.progression.lines.example.history == record.lines.example.history,
	"a completed update replaces only the variable on the existing character")
check(loaded.vars.name == "Example" and loaded.vars.data.skin == 0, "updates retain other client variables")

-- Consecutive snapshots and updates cannot share buffers, even for different characters.
local second = setmetatable({id = 43, player = entity, vars = {}}, getmetatable(character))
local offset = #wire
ix.characterNetwork.SendInfo(second, {name = "Second"}, entity)
ix.characterNetwork.SendVar(character, "progression", nil, entity)
for index = offset + 1, #wire do deliver(index) end
check(ix.char.loaded[43].vars.name == "Second" and loaded.vars.name == "Example", "characters stay isolated")
check(loaded.vars.progression == nil, "nil updates preserve the ordinary setter contract")
offset = #wire
ix.char.loaded[43] = nil
ix.characterNetwork.SendVar(second, "progression", record, entity)
for index = offset + 1, #wire do deliver(index) end
check(ix.char.loaded[43] == nil, "late updates for deleted characters do not recreate them")
character.player = nil
offset = #wire
character:SetProgression(before)
check(#wire == offset and character.vars.progression == before, "offline mutations persist without sending")
check(compressions == decompressions, "every transmitted payload passes through compression and decompression")

print("character_network_spec: " .. checks .. " checks passed")
