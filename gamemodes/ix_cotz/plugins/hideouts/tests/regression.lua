-- Engine/Helix boundary mocks; persistence methods under test are loaded unchanged.
local vector = {}
vector.__index = vector
function Vector(x, y, z)
	return setmetatable({ x = x or 0, y = y or 0, z = z or 0, __vector = true }, vector)
end
function vector.__add(a, b)
	return Vector(a.x + b.x, a.y + b.y, a.z + b.z)
end
function vector.__sub(a, b)
	return Vector(a.x - b.x, a.y - b.y, a.z - b.z)
end
function vector.__mul(a, b)
	return Vector(a.x * b, a.y * b, a.z * b)
end
function vector:DistToSqr(other)
	local d = self - other

	return d.x * d.x + d.y * d.y + d.z * d.z
end
function vector:Distance(other)
	return math.sqrt(self:DistToSqr(other))
end
function Angle(p, y, r)
	return { p = p or 0, y = y or 0, r = r or 0, __angle = true }
end
function isvector(v)
	return type(v) == "table" and v.__vector == true
end
function isangle(v)
	return type(v) == "table" and v.__angle == true
end
function istable(v)
	return type(v) == "table"
end
function isstring(v)
	return type(v) == "string"
end
function isnumber(v)
	return type(v) == "number"
end
function isentity(v)
	return type(v) == "table" and v.entityType == true
end
function IsValid(v)
	return type(v) == "table" and v.valid == true
end
function table.Copy(t)
	if type(t) ~= "table" then
		return t
	end
	local result = {}
	for k, v in pairs(t) do
		result[k] = table.Copy(v)
	end

	return setmetatable(result, getmetatable(t))
end
function table.Count(t)
	local n = 0
	for _ in pairs(t) do
		n = n + 1
	end

	return n
end
function table.IsEmpty(t)
	return next(t) == nil
end
function table.GetKeys(t)
	local keys = {}
	for k in pairs(t) do
		keys[#keys + 1] = k
	end

	return keys
end
function table.HasValue(t, value)
	for _, v in pairs(t) do
		if v == value then
			return true
		end
	end

	return false
end
vector_origin, angle_zero, color_white = Vector(), Angle(), {}
MASK_SOLID_BRUSHONLY, MASK_PLAYERSOLID, SOLID_NONE, MOVETYPE_NOCLIP = 1, 2, 0, 8
SOLID_VPHYSICS = 6
SOLID_BSP = 1
local now = 100
function CurTime()
	return now
end
function SysTime()
	return now
end
function Advance(seconds)
	now = now + seconds
end
function ErrorNoHalt(message) end
game = {
	GetMap = function()
		return "testmap"
	end,
	GetWorld = function()
		return {}
	end,
}
Schema = { folder = "testschema" }
SERVER = true
PLUGIN = { instances = {}, members = {}, allowedShellClasses = { prop_physics = true } }
local hideouts = PLUGIN
ix = {
	config = {
		Get = function(name, default)
			return default
		end,
		Add = function() end,
	},
	item = { instances = {}, inventories = { [0] = {} }, list = { water = {} } },
	inventory = { Register = function() end },
	storage = { Close = function() end, Open = function() end },
	util = {},
	plugin = {
		Get = function(name)
			if name == "hideouts" then
				return hideouts
			end
		end,
	},
	command = { Add = function() end },
	type = { string = 1 },
	char = { loaded = {} },
}
netstream = { Hook = function() end, Start = function() end }
timer = {
	Simple = function(_, callback)
		callback()
	end,
}
util = {
	IsInWorld = function()
		return true
	end,
	IsValidModel = function()
		return true
	end,
	TraceHull = function()
		return { Hit = false, StartSolid = false, AllSolid = false }
	end,
}
local encodings = {}
function util.TableToJSON(data)
	local id = "json" .. tostring(#encodings + 1)
	encodings[#encodings + 1] = id
	encodings[id] = table.Copy(data)

	return id
end
function util.JSONToTable(value)
	return table.Copy(encodings[value] or {})
end

DB = { rows = {}, nextID = 1, deferred = {}, hold = false, rejectWrite = false, history = {} }
function DB:Reset()
	self.rows, self.deferred, self.nextID = {}, {}, 1
	self.history = {}
	self.hold, self.rejectWrite = false, false
	ix.item.instances, ix.item.inventories[0] = {}, {}
end
function DB:Flush()
	local pending = self.deferred
	self.deferred = {}
	self.hold = false
	for _, callback in ipairs(pending) do
		callback()
	end
end
local query = {}
query.__index = query
function query:Where(key, value)
	self.conditions[key] = tostring(value)
end
function query:WhereIn(key, values)
	self.inKey, self.inValues = key, values
end
function query:WhereLike() end
function query:Select() end
function query:Update(key, value)
	self.values[key] = value
end
function query:Insert(key, value)
	self.values[key] = value
end
function query:Callback(callback)
	self.callback = callback
end
function query:Matches(row)
	for k, v in pairs(self.conditions) do
		if tostring(row[k]) ~= v then
			return false
		end
	end
	if self.inKey and not table.HasValue(self.inValues, row[self.inKey]) then
		return false
	end

	return true
end
function query:Execute()
	DB.history[#DB.history + 1] = { kind = self.kind, values = table.Copy(self.values) }
	local result = {}
	local lastID
	if self.kind == "insert" then
		lastID = DB.nextID
		DB.nextID = lastID + 1
		local row = table.Copy(self.values)
		row.item_id = lastID
		DB.rows[lastID] = row
	else
		for id, row in pairs(DB.rows) do
			if self:Matches(row) then
				if self.kind == "select" then
					result[#result + 1] = table.Copy(row)
				elseif self.kind == "delete" then
					DB.rows[id] = nil
				elseif self.kind == "update" and not DB.rejectWrite then
					for k, v in pairs(self.values) do
						row[k] = v
					end
				end
			end
		end
	end
	if self.callback then
		local callback = function()
			self.callback(result, true, lastID)
		end
		if DB.hold then
			DB.deferred[#DB.deferred + 1] = callback
		else
			callback()
		end
	end
end
mysql = {}
for name, kind in pairs({ Select = "select", Update = "update", Delete = "delete", Insert = "insert" }) do
	mysql[name] = function()
		return setmetatable({ kind = kind, conditions = {}, values = {} }, query)
	end
end

local physics = { valid = true }
function physics:IsMotionEnabled()
	return true
end
function physics:EnableMotion() end
local entity = {}
entity.__index = entity
ENTITIES = {}
function NewEntity(item, position)
	local result = setmetatable({
		valid = true,
		entityType = true,
		item = item,
		position = position or Vector(),
		angles = Angle(),
		ixItemID = item and item.id,
	}, entity)
	ENTITIES[#ENTITIES + 1] = result

	return result
end
function entity:GetPos()
	return self.position
end
function entity:SetPos(position)
	self.position = position
end
function entity:GetAngles()
	return self.angles
end
function entity:OBBMins()
	return Vector(-16, -16, -20)
end
function entity:SetAngles(angles)
	self.angles = angles
end
function entity:GetPhysicsObject()
	return physics
end
function entity:GetItemTable()
	return self.item and ix.item.list[self.item.uniqueID]
end
function entity:GetClass()
	return self.item and "ix_item" or "prop_physics"
end
function entity:GetSolid()
	return SOLID_VPHYSICS
end
function entity:IsSolid()
	return self:GetSolid() ~= SOLID_NONE
end
function entity:SetNetVar(key, value)
	self[key] = value
end
function entity:SetModel(model)
	self.model = model
end
function entity:GetModel()
	return self.model or "models/props_junk/wood_crate001a.mdl"
end
function entity:Spawn() end
function entity:GetSkin()
	return 0
end
function entity:SetSkin() end
function entity:GetColor()
	return {}
end
function entity:SetColor() end
function entity:GetMaterial()
	return ""
end
function entity:SetMaterial() end
function entity:GetBodyGroups()
	return {}
end
function entity:GetMaterials()
	return {}
end
function entity:WorldSpaceAABB()
	return self.position - Vector(1, 1, 1), self.position + Vector(1, 1, 1)
end
function entity:GetPhysicsObjectCount()
	return 1
end
function entity:GetPhysicsObjectNum()
	return physics
end
function entity:IsPlayer()
	return false
end
function entity:Remove()
	self.valid = false
	if self.item and not self.ixIsSafe then
		DB.rows[self.item.id] = nil
	end
end
ents = {
	Create = function(class)
		local ent = NewEntity()
		function ent:GetClass()
			return class
		end

		return ent
	end,
	FindInBox = function()
		return {}
	end,
	FindByClass = function(class)
		local result = {}
		for _, ent in ipairs(ENTITIES) do
			if ent.valid and ent:GetClass() == class then
				result[#result + 1] = ent
			end
		end

		return result
	end,
}

local item = {}
item.__index = item
function item:GetData(key)
	return self.data[key]
end
function item:SetData(key, value, receivers, noSave)
	self.data[key] = value
	if not noSave and DB.rows[self.id] then
		DB.rows[self.id].data = util.TableToJSON(self.data)
	end
end
function item:GetID()
	return self.id
end
function item:GetEntity()
	for _, ent in ipairs(ENTITIES) do
		if ent.valid and ent.item == self then
			return ent
		end
	end
end
function item:Spawn(position, angles)
	local ent = NewEntity(self, position)
	ent.angles = angles

	return ent
end
function ix.item.New(uniqueID, id)
	local result = setmetatable({ uniqueID = uniqueID, id = id, data = {} }, item)
	ix.item.instances[id] = result

	return result
end
function ix.item.Instance(invID, uniqueID, data, x, y, callback)
	local q = mysql:Insert("ix_items")
	q:Insert("inventory_id", invID)
	q:Insert("unique_id", uniqueID)
	q:Insert("data", util.TableToJSON(data))
	q:Callback(function(_, _, id)
		local result = ix.item.New(uniqueID, id)
		result.data, result.invID = table.Copy(data), invID
		callback(result)
	end)
	q:Execute()
end
function NewItem(data)
	local result
	ix.item.Instance(0, "water", data or {}, 1, 1, function(value)
		result = value
	end)

	return result
end

function NewClient(id)
	local character = { id = id, data = {} }
	local client = { valid = true, position = Vector(10000, 0, 8), angles = Angle(), character = character }
	function character:GetName()
		return "Character " .. self.id
	end
	function character:GetID()
		return self.id
	end
	function character:SetData(key, value)
		self.data[key] = value
	end
	function character:GetData(key, default)
		if self.data[key] == nil then
			return default
		end

		return self.data[key]
	end
	function character:Save(callback)
		if callback then
			callback()
		end
	end
	function character:GetPlayer()
		return client
	end
	function client:GetCharacter()
		return self.character
	end
	function client:GetPos()
		return self.position
	end
	function client:GetShootPos()
		return self.position
	end
	function client:GetUseEntity()
		return self.useEntity
	end
	function client:SetPos(position)
		self.position = position
	end
	function client:EyeAngles()
		return self.angles
	end
	function client:SetEyeAngles(angles)
		self.angles = angles
	end
	function client:Alive()
		return true
	end
	function client:IsAdmin()
		return false
	end
	function client:IsPlayer()
		return true
	end
	function client:Health()
		return self.health or 90
	end
	function client:SetHealth(health)
		self.health = health
	end
	function client:GetMaxHealth()
		return 100
	end
	function client:AddBuff(id, duration)
		self.buffs = self.buffs or {}
		self.buffs[id] = duration
	end
	function client:SteamID64()
		return "100"
	end
	function client:InVehicle()
		return false
	end
	function client:GetMoveType()
		return 0
	end
	function client:GetLocalVar()
		return nil
	end
	function client:SetLocalVar() end
	function client:Notify(message)
		self.notification = message
	end

	return client
end

function Reset()
	DB:Reset()
	ENTITIES = {}
	PLUGIN.instances, PLUGIN.members = {}, {}
	PLUGIN.ready = true
	PLUGIN.state = {
		nextID = 1,
		hideouts = {},
		templates = {},
		areas = {},
		entrances = { gate = { pos = Vector(10000, 0, 8), outside = Vector(10000, 0, 8) } },
	}
end

function NewInstance(id)
	local instance = {
		id = id or "1",
		origin = Vector(100, 200, 0),
		mins = Vector(0, 0, 0),
		maxs = Vector(1000, 1000, 1000),
		state = "active",
		items = {},
		props = {},
		shell = {},
		occupants = {},
		pending = {},
		entities = {},
		created = CurTime(),
	}
	PLUGIN.instances[instance.id] = instance
	PLUGIN.state.hideouts[instance.id] = {
		id = instance.id,
		name = "Home",
		owner = 1,
		entrance = "gate",
		template = "room",
		furnishings = {},
		shell = {},
		seeds = {},
		guests = {},
	}
	PLUGIN.state.templates.room = { spawns = { Vector(0, 0, 8) }, storage = Vector(), exit = Vector() }

	return instance
end
local stored
function PLUGIN:SetData(value)
	stored = table.Copy(value)
end
function DecodeSavedKeys(value)
	if not istable(value) or isvector(value) or isangle(value) then
		return table.Copy(value)
	end
	local result = {}
	for key, entry in pairs(value) do
		result[tonumber(key) or key] = DecodeSavedKeys(entry)
	end

	return result
end
function PLUGIN:GetData()
	return DecodeSavedKeys(stored)
end

function Test(name, callback)
	callback()
	print("PASS " .. name)
end
