PLUGIN = hideoutPlugin
getmetatable(NewEntity()).PhysicsInit = function() end
SERVER, CLIENT = true, false
function SortedPairs(values)
	local keys = table.GetKeys(values)
	table.sort(keys)
	local index = 0

	return function()
		index = index + 1
		local key = keys[index]
		if key ~= nil then return key, values[key] end
	end
end
math.Clamp = function(value, low, high) return math.max(low, math.min(high, value)) end
util.AddNetworkString = function() end
local serial = 0
util.SHA256 = function(value) serial = serial + 1 return "token" .. serial end
net.Receive = function() end
for _, method in ipairs({"WriteString", "WriteInt", "WriteBool", "WriteType", "WriteEntity"}) do net[method] = function() end end
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
	function character:UpdateWeight() self.weightUpdates = (self.weightUpdates or 0) + 1 end
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
	data = data or {}
	if uniqueID and uniqueID:match("^hideout_crate_") and not data.cotzHideoutCrate then
		data.cotzHideoutCrate = {level = 1, squad = false, version = 1}
	end
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
	local tables = {"ix_items", "ix_inventories", "ix_characters", "ix_hideout_operations", "ix_hideout_treasuries", "ix_hideout_homes"}
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

local entityMeta = getmetatable(NewEntity())
for _, key in ipairs({"DisplayName", "Description", "IdleAnim", "SoundGroup", "NoBubble", "Sherpa", "AnimGroupId"}) do
	entityMeta["Get" .. key] = function(self) return self[key] or (key == "AnimGroupId" and 0 or "") end
	entityMeta["Set" .. key] = function(self, value) self[key] = value end
end
entityMeta.InitPhysObj = function() end
entityMeta.SetAnim = function() end
entityMeta.CanAccess = function() return true end
entityMeta.GetNetVar = function(self, key) return self[key] end
entityMeta.SetNetVar = function(self, key, value) self[key] = value end
local originalPluginGet = ix.plugin.Get
ix.plugin.Get = function(name)
	if name == "vendor_adv" then return {SaveData = function() end} end
	return originalPluginGet(name)
end

net.Start = net.Start or function() end
net.Send = net.Send or function() end
net.WriteUInt = net.WriteUInt or function() end

-- Places the map's hideout contact beside the client, as the dialogue upgrade service requires.
function FeatureContact(client)
	PLUGIN.personalContacts.testmap = PLUGIN.personalContacts.testmap or PLUGIN.personalContacts.rp_marsh_cs
	PLUGIN.personalPurchases = PLUGIN.personalPurchases or {}
	ix.progression = ix.progression or {}
	ix.progression.IsCompleted = ix.progression.IsCompleted
		or function(character, id) return (character.completed or {})[id] == true end
	ix.progression.CanUseNPC = ix.progression.CanUseNPC or function() return true end
	ix.currency = ix.currency or {}
	ix.currency.Get = ix.currency.Get or function(amount) return amount .. " roubles" end
	local vendor = NewEntity(nil, client:GetPos())
	vendor.GetClass = function() return "ix_vendor_adv" end
	vendor.GetDisplayName = function() return PLUGIN.personalContacts.testmap.name end
	vendor.CanAccess = function() return true end

	return vendor
end

-- Reviews the current contact offers and confirms one, returning the offer and ExecuteUpgrade's result.
function FeatureUpgradeOffer(client, record, feature, slotID, vendor)
	vendor = vendor or FeatureContact(client)
	client.cotzHideoutUpgrades = nil
	PLUGIN:SendUpgradeOffers(client, vendor, record.id, true)
	local session = client.cotzHideoutUpgrades
	for index, offer in ipairs(session and session.offers or {}) do
		if offer.feature == feature and offer.slot == slotID then return offer, index, session, vendor end
	end
end

function FeatureUpgrade(client, record, feature, slotID, options)
	options = options or {}
	local offer, index, session, vendor = FeatureUpgradeOffer(client, record, feature, slotID, options.vendor)
	if not offer then return false, "No offer" end
	if options.prepare then options.prepare(session, offer) end
	client.cotzUpgradeBuyAt = nil
	local ok, reason = PLUGIN:ExecuteUpgrade(client, vendor, {revision = session.revision, index = index,
		crate = options.crate == true or nil})

	return ok, reason, offer
end

-- Gives the client every raw material in an upgrade recipe, using the first alternative of each group.
function FeatureMaterials(inventory, materials)
	local items = {}
	for _, group in ipairs(materials.groups) do
		local itemID = group.items[1]
		ix.item.list[itemID] = ix.item.list[itemID] or {name = itemID, width = 1, height = 1}
		items[#items + 1] = FeatureItem(inventory, {quantity = group.quantity * (PLUGIN.crateBatchSizes[itemID] or 1)},
			itemID)
	end

	return items
end
