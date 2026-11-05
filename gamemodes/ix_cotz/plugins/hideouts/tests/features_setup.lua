PLUGIN = hideoutPlugin
getmetatable(NewEntity()).PhysicsInit = function() end
SERVER, CLIENT = true, false
math.Clamp = function(value, low, high) return math.max(low, math.min(high, value)) end
util.AddNetworkString = function() end
local serial = 0
util.SHA256 = function(value) serial = serial + 1 return "token" .. serial end
net.Receive = function() end
for _, method in ipairs({"WriteString", "WriteInt", "WriteBool", "WriteType"}) do net[method] = function() end end
ix.util.Include = function() end
ix.command.Add = function(name, definition) TEST_COMMANDS[name] = definition end
ix.squad = {list = {}, cross = {Enabled = function() return false end}}
ix.crossserver = {Scope = function() return Schema.folder end, Query = function(query, callback)
	query:Callback(function(rows) callback(rows or {}) end)
	query:Execute()
end}
sql = {
	Query = PythonSqlQuery,
	LastError = function() return PythonSqlError end,
	SQLStr = function(value, bare)
		local escaped = tostring(value):gsub("'", "''")
		return bare and escaped or ("'" .. escaped .. "'")
	end,
	Begin = function() assert(PythonSqlQuery("BEGIN IMMEDIATE") ~= false) end,
	Commit = function() assert(PythonSqlQuery("COMMIT") ~= false) end,
}
sql.QueryValue = function(statement)
	local rows = sql.Query(statement)
	if rows and rows[1] then for _, value in pairs(rows[1]) do return value end end
end
-- Engine timers are queued rather than fired before the asynchronous work they guard.
FEATURE_TIMERS = {}
timer.Simple = function(delay, callback)
	if delay == 0 then callback() else FEATURE_TIMERS[#FEATURE_TIMERS + 1] = {delay = delay, callback = callback} end
end
function RunFeatureTimers(delay)
	local pending = FEATURE_TIMERS
	FEATURE_TIMERS = {}
	for _, entry in ipairs(pending) do
		if entry.delay == delay then entry.callback() else FEATURE_TIMERS[#FEATURE_TIMERS + 1] = entry end
	end
end
ix.meta.character = {Save = function(character, callback)
	local query = mysql:Update("ix_characters")
	query:Update("money", character:GetMoney())
	query:Where("id", character:GetID())
	query:Callback(function() if callback then callback() end end)
	query:Execute()
end}
function ix.meta.inventory:New(id, width, height)
	local inventory = setmetatable({}, {__index = self})
	inventory:Initialize(id, width, height)
	return inventory
end
ix.meta.inventory.SendSlot = function() end
ix.item.inventoryTypes = {}
ix.type = {string = 1, optional = 2, player = 3, text = 4, bool = 5}
bit = {bor = function(a, b) return a + b end}
local clients = {}
player = {GetHumans = function() return clients end, Iterator = function() return ipairs(clients) end}

function FeatureClient(id, balance)
	local client = NewClient(id)
	local character = client:GetCharacter()
	character.money = balance or 0
	function character:GetMoney() return self.money end
	function character:GetName() return "Character " .. id end
	function character:HasMoney(amount) return self.money >= amount end
	function character:TakeMoney(amount) self.money = self.money - amount end
	function character:GiveMoney(amount) self.money = self.money + amount end
	function character:GetFlags() return "" end
	character.Save = function(self, callback) return ix.meta.character.Save(self, callback) end
	local inventory = ix.inventory.Create(6, 6, id + 100)
	inventory.owner = id
	function character:GetInventory() return inventory end
	function character:GetSquadID() return "squad1" end
	client.GetLocalVar = function(self, key, default) return self[key] == nil and default or self[key] end
	client.SetLocalVar = function(self, key, value) self[key] = value end
	client.HasWeapon = function(self, class) return self.weapons and self.weapons[class] end
	client.Give = function(self, class) self.weapons = self.weapons or {} self.weapons[class] = true end
	client.StripWeapon = function(self, class) self.weapons[class] = nil end
	client.IsAdmin = function() return false end
	client.GetHull = function() return Vector(-16, -16, 0), Vector(16, 16, 72) end
	ix.char.loaded[id] = character
	clients[#clients + 1] = client
	assert(sql.Query("INSERT INTO ix_characters(id, money) VALUES (" .. id .. ", " .. character.money .. ")") ~= false)
	return client, inventory
end

function FeatureItem(inventory, data, uniqueID)
	local item
	ix.item.Instance(inventory:GetID(), uniqueID or "water", data or {}, 1, 1, function(created) item = created end)
	AttachCore(item)
	item.data = data or {}
	item.gridX, item.gridY = inventory:FindEmptySlot(1, 1, true)
	inventory.slots[item.gridX] = inventory.slots[item.gridX] or {}
	inventory.slots[item.gridX][item.gridY] = item
	item.GetData = ix.meta.item.GetData
	item.SetData = ix.meta.item.SetData
	item.GetEntity = function() end
	item.GetName = function() return "Test item" end
	item.GetDescription = function() return "Test description" end
	return item
end

function FeatureReset()
	Reset()
	clients = {}
	FEATURE_TIMERS = {}
	PLUGIN.inventoryLoads = {}
	util.TraceHull = function(trace)
		return {Hit = trace.start.z ~= trace.endpos.z, HitNormal = Vector(0, 0, 1)}
	end
	ix.item.inventories = {[0] = {}}
	ix.char.loaded = {}
	ix.db = true
	local tables = {"ix_items", "ix_inventories", "ix_characters", "ix_hideout_operations", "ix_hideout_treasuries"}
	for _, name in ipairs(tables) do
		sql.Query("DROP TABLE IF EXISTS " .. name)
	end
	assert(sql.Query("CREATE TABLE ix_items(item_id INTEGER PRIMARY KEY AUTOINCREMENT, inventory_id INTEGER, "
		.. "unique_id TEXT, data TEXT, x INTEGER, y INTEGER, character_id INTEGER, player_id TEXT)") ~= false)
	assert(sql.Query("CREATE TABLE ix_inventories(inventory_id INTEGER PRIMARY KEY AUTOINCREMENT, "
		.. "inventory_type TEXT, character_id INTEGER)") ~= false)
	assert(sql.Query("CREATE TABLE ix_characters(id INTEGER PRIMARY KEY, money INTEGER)") ~= false)
	PLUGIN:InitializeOperations()
	assert(PLUGIN.operationsReady)
	PLUGIN:InstallWalletSaveGuard()
end

function FeatureHome(client, squad)
	local instance = NewInstance()
	local record = PLUGIN:GetHideout(instance.id)
	record.containers = {}
	if squad then
		record.owner, record.ownerType, record.squadID, record.access = nil, "squad", "squad1", "squad"
		ix.squad.list.squad1 = {members = {[client:GetCharacter():GetID()] = 2}, leaderID = client:GetCharacter():GetID()}
	end
	client.position = instance.origin
	PLUGIN.members[client] = instance.id
	instance.occupants[client] = {character = client:GetCharacter():GetID(),
		returnPoint = {Vector(10000, 0, 8), Angle(), "testmap"}}
	instance.containers = {}
	return instance, record
end
