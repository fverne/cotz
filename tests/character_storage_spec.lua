-- Run from the addon root: luatex --luaonly tests/character_storage_spec.lua
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
	assert(load(source:gsub("!=", "~="):gsub("!", "not "), "@installed Helix API"))()
end

local function section(source, first, following)
	local start = assert(source:find(first, 1, true))

	return source:sub(start, assert(source:find(following, start, true)) - 1)
end

SERVER, CLIENT = true, false
istable = function(value) return type(value) == "table" end
isstring = function(value) return type(value) == "string" end
isnumber = function(value) return type(value) == "number" end
isbool = function(value) return type(value) == "boolean" end
table.Copy = copy
table.Count = function(value)
	local count = 0
	for _ in pairs(value) do count = count + 1 end

	return count
end
local json = {}
util = {TableToJSON = function(value)
	json[#json + 1] = copy(value)

	return tostring(#json)
end}
local function decode(value) return copy(json[tonumber(value)]) end
util.JSONToTable = decode
local database, statements, columns = {}, {}, {}
local failSave = false
mysql = {IsConnected = function() return true end}
function mysql:Update(name)
	local query = {values = {}}
	function query:Update(key, value) self.values[key] = value end
	function query:Where() end
	function query:Callback(callback) self.callback = callback end
	function query:Execute()
		if name ~= "ix_characters" then return end
		statements[#statements + 1] = copy(self.values)
		if failSave then return end
		for key, value in pairs(self.values) do database[key] = value end
		if self.callback then self.callback() end
	end

	return query
end
function mysql:Alter()
	return {Add = function(_, key, definition) columns[key] = definition end, Execute = function() end}
end
ix = {type = {text = 4}, db = {type = {[4] = "TEXT"}, schema = {ix_characters = {}}, schemaQueue = {}},
	meta = {character = {vars = {}}}, char = {vars = {}}}
resource = {AddWorkshop = function() end}
dofile("gamemodes/ix_cotz/schema/sv_schema.lua")
local databaseSource = read("gamemodes/helix/gamemode/core/libs/sv_database.lua")
execute(section(databaseSource, "function ix.db.AddToSchema", "function ix.db.LoadTables"))
local characterSource = read("gamemodes/helix/gamemode/core/meta/sh_character.lua")
execute(section(read("gamemodes/helix/gamemode/core/libs/sh_character.lua"),
	"\tfunction ix.char.RestoreVars", "\nend\n"))
CHAR = ix.meta.character
execute(section(characterSource, "function ix.char.RegisterVar", "-- Allows access"))
execute(section(characterSource, "\tfunction CHAR:Save(callback)", "\t--- Networks"))
CHAR.__index = CHAR
function CHAR:GetID() return 1 end
function CHAR:GetData(key, default)
	if key == nil then return self.vars.data end
	local value = self.vars.data[key]
	if value == nil then return default end

	return value
end
function CHAR:SetData(key, value) self.vars.data[key] = value end
local networked = {}
IsValid = function(value) return value ~= nil end
ix.characterNetwork = {SendVar = function(_, key) networked[#networked + 1] = key end}
net = {Start = function() end, WriteUInt = function() end, WriteType = function() end,
	WriteString = function(key) networked[#networked + 1] = key end, Send = function() end,
	Broadcast = function() end}
hook = {Run = function() end}
ix.char.RegisterVar("data", {field = "data", fieldType = ix.type.text, default = {}, bNoNetworking = true,
	OnGet = CHAR.GetData, OnSet = CHAR.SetData})
dofile("gamemodes/ix_cotz/plugins/progression/libs/sh_storage.lua")
dofile("gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_stockstorage.lua")
PLUGIN = {}
execute(section(read("gamemodes/ix_cotz/plugins/jobsystem/sh_plugin.lua"),
	"ix.char.RegisterVar", "ix.util.Include"))
for _, key in ipairs({"progression", "vendorStock", "vendorRestockClaims", "jobs"}) do
	check(columns[key] == "MEDIUMTEXT", key .. " uses the installed schema registry and large SQL type")
end
check(columns.data == "TEXT", "the generic data type is unchanged")
check(ix.char.vars.progression.isLocal, "progression remains owner-local")
check(ix.char.vars.vendorStock.bNoNetworking and ix.char.vars.vendorRestockClaims.bNoNetworking,
	"stock and restock guards never enter automatic networking")
local progression = {lines = {example = {completed = true, pendingRewards = {{item = "reward"}},
	requirement = {item = "old_choice"}}}}
local stock = {map = {trader = {item = {count = 2, updated = 123, fraction = 0.4, maximum = 5}}}}
local claims = {map = {milestones = {paid = true}, lastJob = 42}}
local character = setmetatable({player = {}, vars = {data = {unrelated = "retain"},
	jobs = {contact = {progress = 3}}}}, CHAR)
character:SetProgression(copy(progression))
character:SetVendorStock(copy(stock))
character:SetVendorRestockClaims(copy(claims))
failSave = true
local completed = false
character:Save(function() completed = true end)
check(not completed and next(database) == nil, "failed saves never acknowledge or modify durable state")
local update = statements[#statements]
check(update.progression and update.vendorStock and update.vendorRestockClaims and update.data and update.jobs,
	"all affected character vars share one installed Save UPDATE")
check(decode(update.data).progression == nil and decode(update.data).vendorStock == nil
	and decode(update.data).vendorRestockClaims == nil, "large feature records stay outside generic data")
check(character:GetData("unrelated") == "retain", "unrelated character data is retained")
check(character:GetProgression().lines.example.pendingRewards[1].item == "reward"
	and character:GetProgression().lines.example.requirement.item == "old_choice",
	"progression retains durable rewards and selected requirements")
check(character:GetVendorStock().map.trader.item.updated == 123
	and character:GetVendorStock().map.trader.item.fraction == 0.4, "stock timing and fractional credit survive")
check(character:GetVendorRestockClaims().map.lastJob == 42
	and character:GetVendorRestockClaims().map.milestones.paid, "duplicate-restock guards survive")
check(#networked == 1 and networked[1] == "progression", "only progression uses owner networking")
failSave = false
character:Save(function() completed = true end)
check(completed and decode(database.progression).lines.example.completed, "a successful retry persists progression")
check(decode(database.jobs).contact.progress == 3, "existing job assignments remain intact")
local restored = setmetatable({vars = {}}, CHAR)
ix.char.RestoreVars(restored.vars, database)
check(restored:GetVendorStock().map.trader.item.count == 2, "stock survives save and restoration")
check(restored:GetVendorRestockClaims().map.lastJob == 42, "claim guards survive restoration")
check(restored:GetProgression().lines.example.completed, "completion survives restoration")
local second = setmetatable({vars = {data = {}}}, CHAR)
local empty = second:GetProgression()
empty.lines.test = true
check(second:GetProgression().lines.test == nil, "fresh progression defaults are isolated")
check(next(second:GetVendorStock()) == nil, "fresh stock is isolated")
print("character storage: " .. checks .. " checks passed")
