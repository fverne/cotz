function Angle(p, y, r) return {p = p, y = y, r = r} end
-- Run from the addon root: luatex --luaonly tests/field_tasks_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local vectorMeta = {}
vectorMeta.__index = vectorMeta
function Vector(x, y, z) return setmetatable({x = x, y = y, z = z}, vectorMeta) end
function vectorMeta.__add(a, b) return Vector(a.x + b.x, a.y + b.y, a.z + b.z) end
function vectorMeta.__sub(a, b) return Vector(a.x - b.x, a.y - b.y, a.z - b.z) end
function vectorMeta.__mul(a, b) return Vector(a.x * b, a.y * b, a.z * b) end
function vectorMeta.__tostring(a) return a.x .. ":" .. a.y .. ":" .. a.z end
function vectorMeta:LengthSqr() return self.x ^ 2 + self.y ^ 2 + self.z ^ 2 end
function vectorMeta:DistToSqr(other) return (self - other):LengthSqr() end
isvector = function(value) return getmetatable(value) == vectorMeta end
IsValid = function(value) return type(value) == "table" and not value.invalid end
istable = function(value) return type(value) == "table" end
local function copy(value)
	if isvector(value) then return Vector(value.x, value.y, value.z) end
	if type(value) ~= "table" then return value end
	local result = {}
	for key, entry in pairs(value) do result[key] = copy(entry) end

	return result
end
table.Copy = copy
table.Shuffle = function() end
math.Rand = function(a, b) return (a + b) / 2 end
math.Clamp = function(value, a, b) return math.max(a, math.min(b, value)) end
math.atan2 = math.atan2 or function(y, x) return math.atan(y, x) end
SERVER, CLIENT = true, false
PLUGIN = {}
local now, map, blocked = 1000, "rp_marsh_cs", false
CurTime = function() return now end
os.time = function() return now end
game = {GetMap = function() return map end}
MASK_SOLID = 1
util = {
	AddNetworkString = function() end,
	TraceHull = function(trace)
		return {Hit = not blocked, StartSolid = blocked, HitNormal = Vector(0, 0, 1),
			HitPos = trace.start - Vector(0, 0, 32)}
	end,
	IsInWorld = function() return true end,
}
local markers, lastMarker = 0
net = {Receive = function() end, Start = function() end, WriteVector = function(position) lastMarker = position end,
	WriteString = function() end, WriteUInt = function() end, Send = function() markers = markers + 1 end}
netstream = {Start = function() end}
hook = {Add = function() end, Run = function() end}
timer = {Simple = function() end}
SortedPairs = pairs
local playerMeta = {}
FindMetaTable = function() return playerMeta end
ix = {jobs = {list = {}, jobsbycategory = {}}, plugin = {list = {}},
	item = {list = {}}, char = {loaded = {}}, taskRewards = {},
	config = {Get = function(_, default) return default end}, progression = {GetNPCFromName = function() end},
	dialogue = {notifyMoneyReceive = function() end, notifyReputationReceive = function() end}}
ix.plugin.Get = function(id) return ix.plugin.list[id] end
local players, objects, callbacks = {}, {}, {}
player = {Iterator = function() return ipairs(players) end}
ents = {Create = function(class)
	local entity = {class = class, health = 100}
	function entity:SetPos(position) self.position = position end
	function entity:GetPos() return self.position end
	function entity:SetModel(model) self.model = model end
	function entity:SetNWString(key, value) self[key] = value end
	function entity:GetModelBounds()
		assert(self.model, "SetModel precedes reading bounds")
		return Vector(-8, -8, 0), Vector(8, 8, 16)
	end
	function entity:Spawn() end
	function entity:SetNoDraw(value) self.hidden = value end
	function entity:SetNotSolid(value) self.notSolid = value end
	function entity:DrawShadow(value) self.shadow = value end
	function entity:Remove() self.invalid = true end
	function entity:GetClass() return self.class end
	function entity:SetHealth(health) self.health = health end
	function entity:Health() return self.health end
	function entity:DropToFloor() end
	function entity:SetEnemy(enemy) self.enemy = enemy end
	function entity:GetEnemy() return self.enemy end
	function entity:UpdateEnemyMemory() end
	function entity:Visible() return not self.hidden end
	objects[#objects + 1] = entity

	return entity
end}

local base = "gamemodes/ix_cotz/plugins/jobsystem/"
ix.jobs = ix.jobs or {}
ix.jobs.field = ix.jobs.field or {}
ix.taskRewards = ix.taskRewards or {}
for _, name in ipairs({"settings", "rewardsettings", "fieldsettings", "killcredit", "regionalcatalogue"}) do
	dofile("gamemodes/ix_cotz/plugins/jobsystem/definitions/sh_" .. name .. ".lua")
end
dofile(base .. "libs/sh_fieldtasks.lua")
dofile(base .. "libs/sh_jobs.lua")
dofile(base .. "sv_jobs.lua")
dofile(base .. "sv_fieldplacement.lua")
dofile(base .. "sv_fieldassignment.lua")
dofile(base .. "sv_fieldactions.lua")
dofile(base .. "sv_fieldtasks.lua")
dofile(base .. "sv_deaddrops.lua")
dofile(base .. "sv_cargo.lua")
dofile(base .. "sv_fielddefence.lua")
ITEM = {functions = {}}
dofile(base .. "items/base/sh_jobcargo.lua")
local cargoBase = ITEM
for _, id in ipairs({"job_recovery_case", "job_sensor_recorder", "job_signal_transmitter",
	"job_dead_drop_parcel", "job_research_results"}) do
	ITEM = {}
	dofile(base .. "items/jobcargo/sh_" .. id .. ".lua")
	ix.item.list[id] = setmetatable(ITEM, {__index = cargoBase})
end
ix.jobs.register = function(definition, id)
	ix.jobs.list[id] = definition
	for _, category in ipairs(definition.categories) do
		ix.jobs.jobsbycategory[category] = ix.jobs.jobsbycategory[category] or {}
		table.insert(ix.jobs.jobsbycategory[category], id)
	end
end
dofile(base .. "definitions/sh_fieldjobs.lua")
local function points()
	ix.plugin.list = {
		hidestashspawner = {stashspawnpoints = {[map] = {{Vector(1000, 0, 0), "stash"}}}},
		eventcontroller = {eventpoints = {[map] = {{Vector(1000, 0, 0), "Test event area"}, {Vector(2000, 0, 0), "Test event area"}}}},
		radiationcontroller = {radiationpoints = {[map] = {{Vector(3000, 0, 0), "Test event area"}}}},
		anomalycontroller = {anomalypoints = {[map] = {{Vector(4000, 0, 0), "Test event area"}}}},
	}
end
points()
local originalProviders = ix.plugin.list
ix.plugin.list = {eventcontroller = {eventpoints = {[map] = {
	{Vector(1000, 0, 0), "Test event area"}, {Vector(4000, 0, 0), "Test event area"},
}}}}
for _, kind in ipairs({"recovery", "sensor", "triangulation", "deadDrop"}) do
	check(ix.jobs.field.IsAvailable(ix.jobs.list["field_" .. kind .. "_easy"]),
		kind .. " can use event points without stash or hazard providers")
end
local site, approaches = ix.jobs.field.SelectDefenceSite(ix.jobs.field.settings.defence, map)
check(site and #approaches > 0, "event points provide defence sites and approaches")
ix.plugin.list = originalProviders
local presetMap = "preset_destination"
local presetRows = {{Vector(1000, 0, 0), "Test event area"}, {Vector(4000, 0, 0), "Test event area"}}
ix.plugin.list.firsttimesetup = {map_presets = {[presetMap] = {
	plugindata = {eventcontroller = presetRows},
}}}
check(#ix.jobs.field.CollectPoints({"event"}, presetMap) == 2, "missing destination data reads FTS coordinates")
check(ix.jobs.field.IsAvailable({fieldType = "sensor", fieldMap = presetMap}), "FTS enables destination sensors")
check(ix.jobs.field.SelectRoute(ix.jobs.field.settings.deadDrop, presetMap) ~= nil, "FTS enables destination routes")
check(
	ix.jobs.field.SelectDefenceSite(ix.jobs.field.settings.defence, presetMap) ~= nil,
	"FTS enables destination defence"
)
originalProviders.eventcontroller.eventpoints[presetMap] = {}
check(#ix.jobs.field.CollectPoints({"event"}, presetMap) == 0, "explicitly empty saved map overrides FTS")
originalProviders.eventcontroller.eventpoints[presetMap] = {{Vector(7000, 0, 0), "Test event area"}}
local savedPoints = ix.jobs.field.CollectPoints({"event"}, presetMap)
check(#savedPoints == 1 and savedPoints[1].x == 7000, "saved destination edits override FTS")
check(#presetRows == 2 and presetRows[1][1].x == 1000, "FTS collection leaves presets unchanged")
originalProviders.eventcontroller.eventpoints[presetMap] = nil
ix.plugin.list.firsttimesetup = nil
ix.jobs.field.pools.combined = {"packages", "rf", "gas", "combined"}
check(#ix.jobs.field.CollectPoints({"combined", "event"}, map) == 4, "pools combine, deduplicate and bound recursion")
check(#ix.jobs.field.CollectPoints({"combined"}, "missing") == 0, "missing maps are empty")
check(#ix.plugin.list.eventcontroller.eventpoints[map] == 2, "collection never changes source tables")
check(ix.jobs.field.IsAvailable(ix.jobs.list.field_recovery_easy), "configured job is available")
check(not ix.jobs.field.IsAvailable(ix.jobs.list.field_recovery_hard), "absent target-map data hides the offer")
check(ix.jobs.getJobFromCategory({"missing"}) == nil, "empty categories do not crash preview generation")
check(ix.jobs.getJobFromCategory({"field_recovery_hard"}) == nil, "unavailable field jobs are filtered")

local serial = 0
local function actor()
	serial = serial + 1
	local character = {id = serial, jobs = {}, data = {}, money = 0}
	function character:GetID() return self.id end
	function character:GetJobs() return copy(self.jobs) end
	function character:SetJobs(jobs) self.jobs = copy(jobs) end
	function character:GetData(key, default) if self.data[key] ~= nil then return self.data[key] end return default end
	function character:SetData(key, value) self.data[key] = copy(value) end
	function character:Save() end
	function character:GiveMoney(amount) self.money = self.money + amount end
	function character:CanCarry() return not self.overweight end
	local inventory = {items = {}, full = false, id = serial}
	function inventory:GetID() return self.id end
	function inventory:GetItems() return self.items end
	function inventory:FindEmptySlot() if not self.full then return 1, 1 end end
	function character:GetInventory() return inventory end
	local client = setmetatable({character = character, position = Vector(0, 0, 0), notices = {}}, {__index = playerMeta})
	function client:GetCharacter() return self.character end
	function client:GetPos() return self.position end
	function client:GetForward() return Vector(1, 0, 0) end
	function client:GetNetVar() return false end
	function client:Alive() return not self.dead end
	function client:IsRestricted() return false end
	function client:SteamID64() return "owner" .. serial end
	function client:Notify(text) self.notices[#self.notices + 1] = text end
	client.NotifyLocalized = client.Notify
	function client:addReputation() end
	function character:GetPlayer() return client end
	ix.char.loaded[serial] = character
	players[#players + 1] = client

	return client, character, inventory
end
ix.jobs.RecordLeaderboardTask = function() end

local itemSerial = 0
local lastItem
ix.item.Instance = function(_, id, data, _, _, callback)
	callbacks[#callbacks + 1] = function()
		itemSerial = itemSerial + 1
		local item = setmetatable({uniqueID = id, data = data, id = itemSerial}, {__index = ix.item.list[id]})
		function item:GetData(key, default)
			if self.data[key] ~= nil then return self.data[key] end
			return default
		end
		function item:SetData(key, value) self.data[key] = value end
		function item:Remove()
			self.removed = true
			for _, character in pairs(ix.char.loaded) do
				character:GetInventory().items[self.id] = nil
			end
		end
		function item:Transfer(invID)
			local inventory = ix.char.loaded[invID]:GetInventory()
			if self:CanTransfer(nil, inventory) == false then return false, "notAllowed" end
			if inventory.full then return false, "noFit" end
			inventory.items[self.id] = self
			return true
		end
		lastItem = item
		callback(item)
	end
end
local function flush()
	local pendingCallbacks = callbacks
	callbacks = {}
	for _, callback in ipairs(pendingCallbacks) do callback() end
end
ix.util = {PlayerPerformBlackScreenAction = function(_, _, _, callback) callback() end}

local function assign(character, kind, npc)
	npc = npc or "Contact"
	local job = {identifier = "field_" .. kind .. "_easy", rewardKey = "job:" .. (#objects + now),
		progressionClaim = now, numberRec = 1, progress = 0, moneyReward = 100}
	check(ix.jobs.field.Assign(character, npc, job), "assignment selects existing point: " .. kind)
	character.jobs[npc] = copy(job)

	return job
end
local function update(client, character)
	now = now + 2
	PLUGIN:Think()
end

local client, character, inventory = actor()
local job = assign(character, "recovery")
check(objects[#objects].class == "prop_dynamic" and objects[#objects].invalid,
	"model bounds probe is removed after assignment")
check(not ix.jobs.field.CanComplete(character, job), "no cargo means no completion")
client:ixJobEvaluate(job.identifier)
check(not character.jobs.Contact.isCompleted, "generic completion triggers cannot finish field assignments")
client.position = Vector(-4000, 0, 0)
local count = #objects
update(client, character)
check(#objects == count, "recovery does not spawn while owner is distant")
client.position = ix.jobs.field.Unpack(job.fieldTask.point)
update(client, character)
local entity = objects[#objects]
check(#objects == count + 1, "recovery spawns when owner approaches")
local stranger = actor()
stranger.position = client.position
ix.jobs.field.Collect(stranger, entity)
check(#callbacks == 0, "another character cannot collect the task object")
map = "rp_waystation"
ix.jobs.field.Collect(client, entity)
check(#callbacks == 0, "wrong-map interaction cannot grant cargo")
map = "rp_marsh_cs"
inventory.full = true
ix.jobs.field.Collect(client, entity)
check(#callbacks == 0 and not entity.invalid, "full inventory leaves recovery available")
inventory.full = false
now = now + 2
character.overweight = true
ix.jobs.field.Collect(client, entity)
check(#callbacks == 0 and not entity.invalid, "overweight owner leaves recovery available")
character.overweight = false
now = now + 2
ix.jobs.field.Collect(client, entity)
client.position = Vector(-4000, 0, 0)
flush()
check(lastItem.removed and not entity.invalid, "moving away during item creation cannot grant cargo")
client.position = ix.jobs.field.Unpack(job.fieldTask.point)
now = now + 2
ix.jobs.field.Collect(client, entity)
ix.jobs.field.Collect(client, entity)
check(#callbacks == 1, "repeated collection has one in-flight item creation")
inventory.full = true
flush()
check(lastItem.removed and not entity.invalid, "inventory becoming full during creation consumes no objective")
inventory.full = false
now = now + 2
ix.jobs.field.Collect(client, entity)
character.overweight = true
flush()
check(lastItem.removed and not entity.invalid, "weight change during creation cannot grant cargo")
character.overweight = false
now = now + 2
ix.jobs.field.Collect(client, entity)
flush()
job = character.jobs.Contact
check(job.isCompleted and ix.jobs.field.CanComplete(character, job), "successful transfer completes the objective")
check(entity.invalid, "collected world object is removed")
local function completionNoticeCount()
	local count = 0
	for _, notice in ipairs(client.notices) do
		if notice:find("Task completed:", 1, true) then count = count + 1 end
	end

	return count
end
local completionNotices = completionNoticeCount()
check(completionNotices == 1, "field recovery announces task completion")
update(client, character)
check(completionNoticeCount() == completionNotices, "field updates do not repeat the completion notification")
check(lastItem:CanTransfer(nil, stranger:GetCharacter():GetInventory()) == false, "cargo blocks another inventory")
check(lastItem:CanTransfer(nil, nil) == false, "cargo cannot be dropped")
SERVER, CLIENT = false, true
LocalPlayer = function() return client end
check(lastItem:CanTransfer(inventory, nil) ~= false, "client can rearrange bound parcels inside the main inventory")
check(lastItem:CanTransfer(inventory, stranger:GetCharacter():GetInventory()) == false,
	"client still blocks parcel transfers out of the main inventory")
SERVER, CLIENT = true, false
check(lastItem:CanTransfer(inventory, nil) == false, "server still rejects nil-destination drops")
check(PLUGIN:CanPlayerTakeItem(stranger, lastItem) == false, "foreign character pickup is denied")
check(PLUGIN:CanPlayerTakeItem(client, lastItem) == nil, "owner pickup does not override other hooks")
lastItem.data.fieldClaim = "another-job"
check(not ix.jobs.field.CanComplete(character, job), "cargo must match the exact active claim")
lastItem.data.fieldClaim = job.rewardKey
local saved = copy(job.fieldTask.point)
ix.jobs.field.settings.recovery.sources = {"gas"}
update(client, character)
check(character.jobs.Contact.fieldTask.point[1] == saved[1], "configuration edits do not reroll accepted assignments")
ix.jobs.field.settings.recovery.sources = {"packages", "rf"}
local earned = 0
ix.taskRewards.RecordCompletion = function() earned = earned + 1 end
ix.taskRewards.EarnOffer = function() end
client:ixJobComplete("Contact")
client:ixJobComplete("Contact")
check(character.money == 100 and earned == 1 and not next(inventory.items), "completion pays once and consumes cargo")

job = assign(character, "recovery")
client.position = ix.jobs.field.Unpack(job.fieldTask.point)
update(client, character)
entity = objects[#objects]
now = now + 2
ix.jobs.field.Collect(client, entity)
ix.taskRewards.RemoveJobOffer = function() end
client:ixJobRemove("Contact")
check(entity.invalid and not character.jobs.Contact, "abandonment removes the world object and active assignment")
flush()
check(lastItem.removed and not next(inventory.items), "abandoning during database callback cannot grant cargo")
job = assign(character, "recovery")
update(client, character)
entity = objects[#objects]
now = now + 2
ix.jobs.field.Collect(client, entity)
client.character = stranger:GetCharacter()
flush()
check(lastItem.removed, "character switch during callback cannot grant cargo")
client.character = character
character.jobs.Contact.fieldTask.stage = "carrying"
character.jobs.Contact.isCompleted = true
client:ixJobComplete("Contact")
check(character.money == 100, "saved completed flag without actual cargo cannot pay")
update(client, character)
check(not character.jobs.Contact.isCompleted, "lost cargo returns to the original recovery objective")
client.dead = true
update(client, character)
check(objects[#objects].invalid, "death removes ephemeral objects")
client.dead = false
update(client, character)
check(not objects[#objects].invalid, "returning character respawns the same objective")
entity = objects[#objects]
ix.jobs.field.Collect(client, entity)
now = now + 31
PLUGIN:Think()
ix.jobs.field.Collect(client, entity)
check(#callbacks == 2, "expired database requests can retry without abandoning the task")
flush()
check(character.jobs.Contact.isCompleted and #callbacks == 0, "late callback cannot duplicate a retried pickup")
local cargoCount = 0
for _ in pairs(inventory.items) do cargoCount = cargoCount + 1 end
check(cargoCount == 1, "only the current pickup request can grant cargo")
ix.jobs.field.Cleanup(character, character.jobs.Contact)
character.jobs.Contact = nil

job = assign(character, "sensor")
client.position = ix.jobs.field.Unpack(job.fieldTask.point)
count = #objects
update(client, character)
check(#objects == count, "sensor does not exist before deployment")
ix.jobs.field.Action(client, "Contact", "deploy")
entity = objects[#objects]
check(character.jobs.Contact.fieldTask.stage == "recording", "deploy starts persisted recording timer")
local readyAt = character.jobs.Contact.fieldTask.readyAt
client.position = client.position + Vector(600, 0, 0)
update(client, character)
client.position = ix.jobs.field.Unpack(character.jobs.Contact.fieldTask.point)
ix.jobs.field.Collect(client, entity)
check(#callbacks == 0, "departure alone cannot bypass recording time")
character.jobs.Contact.fieldTask.departed = false
now = now + 200
ix.jobs.field.Collect(client, entity)
check(#callbacks == 0, "waiting at the sensor without leaving cannot complete it")
client.position = client.position + Vector(600, 0, 0)
update(client, character)
check(character.jobs.Contact.fieldTask.departed, "leaving the site is persisted")
local sensorPoint = copy(character.jobs.Contact.fieldTask.point)
local savedPlayers = players
players = {stranger}
update(client, character)
check(entity.invalid, "disconnect removes the deployed world object")
players = savedPlayers
client.position = ix.jobs.field.Unpack(job.fieldTask.point)
update(client, character)
entity = objects[#objects]
check(character.jobs.Contact.fieldTask.readyAt == readyAt
	and character.jobs.Contact.fieldTask.point[1] == sensorPoint[1], "reconnect keeps the sensor site and deadline")
ix.jobs.field.Collect(client, entity)
flush()
check(character.jobs.Contact.isCompleted, "departed and finished sensor can be retrieved")
ix.jobs.field.Cleanup(character, character.jobs.Contact)
check(not next(inventory.items), "cleanup removes bound cargo")
character.jobs.Contact = nil

job = assign(character, "triangulation")
client.position = ix.jobs.field.Unpack(job.fieldTask.point)
count = #objects
update(client, character)
check(#objects == count, "hidden transmitter waits for sufficient readings")
check(not ix.jobs.field.CanRead(job.fieldTask, client.position, job.fieldTask),
	"coincident signal positions cannot save a bearing that prevents later readings")
client.position = Vector(0, 0, 0)
ix.jobs.field.Action(client, "Contact", "read")
check(#character.jobs.Contact.fieldTask.readings == 1, "first reading is saved")
local reading = character.jobs.Contact.fieldTask.readings[1]
check(reading.bearing ~= nil and reading[1] == client.position.x and reading[2] == client.position.y,
	"reading persists its origin and bearing")
local savedBearing = reading.bearing
check(ix.jobs.field.ReadingBearing({point = {0, 100, 0}}, reading) == savedBearing,
	"recorded bearing is used without recomputing the source")
now = now + 2
ix.jobs.field.Action(client, "Contact", "read")
check(#character.jobs.Contact.fieldTask.readings == 1, "same position cannot farm readings")
client.position = Vector(-1000, 0, 0)
now = now + 2
ix.jobs.field.Action(client, "Contact", "read")
check(#character.jobs.Contact.fieldTask.readings == 1, "collinear readings cannot solve the signal")
client.position = Vector(0, 1000, 0)
now = now + 2
ix.jobs.field.Action(client, "Contact", "read")
client.position = Vector(2000, 1000, 0)
now = now + 2
ix.jobs.field.Action(client, "Contact", "read")
check(#character.jobs.Contact.fieldTask.readings == 3 and markers > 0,
	"three separated bearings reveal the search site")
client.position = ix.jobs.field.Unpack(job.fieldTask.point)
update(client, character)
entity = objects[#objects]
check(#objects == count + 1, "solved transmitter spawns near assigned character")
now = now + 2
ix.jobs.field.Collect(client, entity)
flush()
check(character.jobs.Contact.isCompleted, "transmitter recovery completes objective")
ix.jobs.field.Cleanup(character, character.jobs.Contact)
character.jobs.Contact = nil

blocked = true
check(not ix.jobs.field.Assign(character, "Contact", {identifier = "field_recovery_easy"}),
	"blocked sites are not assigned locally")
blocked = false
ix.plugin.list = {}
check(not ix.jobs.field.IsAvailable(ix.jobs.list.field_sensor_easy), "disabled point providers suppress offers")
points()
ix.taskRewards.PrepareJob = function(_, _, active)
	active.rewardKey, active.progressionClaim = "job:accepted", now + 1
	return true
end
ix.taskRewards.SelectOffer = function() end
check(client:ixJobAdd("field_recovery_easy", "NewContact"), "normal acceptance path creates a field assignment")
check(character.jobs.NewContact.fieldTask and not character.jobs.NewContact.isCompleted,
	"acceptance saves field state alongside ordinary reward state")
ix.jobs.field.Cleanup(character, character.jobs.NewContact)
character.jobs.NewContact = nil

ix.plugin.list.hidestashspawner.stashspawnpoints[map][2] = {Vector(5000, 0, 0), "distant stash"}
check(
	ix.jobs.field.IsAvailable(ix.jobs.list.field_deadDrop_easy),
	"dead drops require a separated pair of existing points"
)
local sourcePoint, destination = ix.jobs.field.SelectRoute(ix.jobs.field.settings.deadDrop, map)
check(sourcePoint:DistToSqr(destination) >= ix.jobs.field.settings.deadDrop.minRouteDistance ^ 2,
	"route selection enforces minimum travel distance")
local originalDistance = ix.jobs.field.settings.deadDrop.minRouteDistance
ix.jobs.field.settings.deadDrop.minRouteDistance = 100000
check(not ix.jobs.field.IsAvailable(ix.jobs.list.field_deadDrop_easy), "impossible dead-drop routes are hidden")
ix.jobs.field.settings.deadDrop.minRouteDistance = originalDistance
job = assign(character, "deadDrop")
local diggingTool = {base = "base_hidestashers", quantity = 0}
function diggingTool:GetData(_, default) return default end
local hasTool = false
function inventory:GetItems()
	local items = {}
	for id, item in pairs(self.items) do items[id] = item end
	if hasTool then items.diggingTool = diggingTool end

	return items
end
local route = copy(job.fieldTask)
client.position = ix.jobs.field.Unpack(route.point)
update(client, character)
entity = ix.jobs.field.GetObject(character, character.jobs.Contact)
check(IsValid(entity) and entity.hidden and entity.notSolid, "parcel is hidden and non-solid at the saved pickup site")
ix.jobs.field.Collect(client, entity)
check(#callbacks == 0, "dead-drop pickup requires a digging tool")
now, hasTool = now + 2, true
ix.jobs.field.DigDeadDrop(client)
check(#callbacks == 0, "an exhausted digging tool cannot dig up a parcel")
diggingTool.quantity, now = 5, now + 2
ix.jobs.field.DigDeadDrop(client)
hasTool = false
flush()
check(not entity.invalid and not next(inventory.items), "tool loss during database work preserves the parcel")
now, hasTool = now + 2, true
ix.jobs.field.DigDeadDrop(client)
flush()
check(character.jobs.Contact.fieldTask.stage == "carrying" and not character.jobs.Contact.isCompleted,
	"parcel pickup does not complete the circuit")
local moneyBefore = character.money
client:ixJobComplete("Contact")
check(character.money == moneyBefore, "pickup alone cannot earn payment")
now = now + 2
ix.jobs.field.Action(client, "Contact", "status")
check(
	lastMarker:DistToSqr(ix.jobs.field.Unpack(route.destination)) == 0,
	"carried parcel directions show the destination"
)
now = now + 2
ix.jobs.field.Action(client, "Contact", "deliver")
check(ix.jobs.field.FindCargo(character, character.jobs.Contact), "delivery from the pickup site consumes nothing")
client.position = ix.jobs.field.Unpack(route.destination)
local parcel = ix.jobs.field.FindCargo(character, character.jobs.Contact)
inventory.items[parcel.id] = nil
now = now + 2
ix.jobs.field.Action(client, "Contact", "deliver")
check(character.jobs.Contact.fieldTask.stage == "carrying", "delivery requires the matching parcel")
inventory.items[parcel.id] = parcel
local originalRemove = parcel.Remove
parcel.Remove = function() return false end
now = now + 2
ix.jobs.field.Action(client, "Contact", "deliver")
check(not character.jobs.Contact.isCompleted, "failed parcel removal cannot complete delivery")
parcel.Remove = originalRemove
hasTool = false
now = now + 2
ix.jobs.field.Action(client, "Contact", "deliver")
check(not character.jobs.Contact.isCompleted and not parcel.removed, "burial also requires a digging tool")
now, hasTool = now + 2, true
ix.jobs.field.Action(client, "Contact", "deliver")
check(character.jobs.Contact.fieldTask.stage == "delivered" and character.jobs.Contact.isCompleted
	and not next(inventory.items), "delivery consumes cargo and saves completion")
now = now + 2
ix.jobs.field.Action(client, "Contact", "deliver")
update(client, character)
check(character.jobs.Contact.fieldTask.stage == "delivered", "completed delivery survives updates without cargo")
client:ixJobComplete("Contact")
client:ixJobComplete("Contact")
check(character.money == moneyBefore + 100, "dead-drop completion pays exactly once")
job = assign(character, "deadDrop")
client.position = ix.jobs.field.Unpack(job.fieldTask.point)
update(client, character)
ix.jobs.field.DigDeadDrop(client)
flush()
ix.jobs.field.FindCargo(character, character.jobs.Contact):Remove()
update(client, character)
check(character.jobs.Contact.fieldTask.stage == "search"
	and character.jobs.Contact.fieldTask.destination[1] == job.fieldTask.destination[1],
	"lost parcel restores the same saved circuit")
ix.jobs.field.Cleanup(character, character.jobs.Contact)
character.jobs.Contact = nil

do
	local immediateAction = ix.util.PlayerPerformBlackScreenAction
	local finishDig
	ix.util.PlayerPerformBlackScreenAction = function(_, _, duration, callback)
		check(duration == 8, "digging takes eight seconds")
		finishDig = callback
	end
	job = assign(character, "deadDrop")
	client.position = ix.jobs.field.Unpack(job.fieldTask.point)
	update(client, character)
	entity = ix.jobs.field.GetObject(character, character.jobs.Contact)
	now = now + 2
	ix.jobs.field.Collect(client, entity)
	check(#callbacks == 0, "Use cannot collect a hidden parcel even with a usable tool")
	ix.jobs.field.DigDeadDrop(client, diggingTool)
	check(#callbacks == 0 and character.jobs.Contact.fieldTask.stage == "search",
		"starting a dig does not grant cargo before the action finishes")
	client.position = client.position + Vector(5000, 0, 0)
	finishDig()
	check(#callbacks == 0 and IsValid(entity), "moving away during digging preserves the hidden pickup")
	client.position = ix.jobs.field.Unpack(job.fieldTask.point)
	ix.jobs.field.DigDeadDrop(client, diggingTool)
	client.character = stranger:GetCharacter()
	finishDig()
	check(#callbacks == 0 and IsValid(entity), "character changes during digging cannot collect old cargo")
	client.character = character
	ix.jobs.field.DigDeadDrop(client, diggingTool)
	finishDig()
	flush()
	check(character.jobs.Contact.fieldTask.stage == "carrying" and diggingTool.quantity == 5,
		"finishing a valid dig grants bound cargo without consuming the tool")
	client.position = ix.jobs.field.Unpack(job.fieldTask.destination)
	now = now + 2
	local carried = ix.jobs.field.FindCargo(character, character.jobs.Contact)
	carried.player, carried.invID = client, inventory:GetID()
	check(cargoBase.functions.Assignment.OnCanRun(carried) and cargoBase.functions.BuryParcel.OnCanRun(carried),
		"the carried parcel exposes directions and burial in its inventory menu")
	check(cargoBase.functions.BuryParcel.OnRun(carried) == false,
		"the burial action keeps the parcel while the dig is pending")
	check(not character.jobs.Contact.isCompleted, "burial waits for its digging action")
	hasTool = false
	finishDig()
	check(not character.jobs.Contact.isCompleted, "losing the tool during burial prevents completion")
	hasTool = true
	ix.jobs.field.Cleanup(character, character.jobs.Contact)
	character.jobs.Contact = nil
	ix.util.PlayerPerformBlackScreenAction = immediateAction
end

check(
	not ix.jobs.field.IsAvailable(ix.jobs.list.field_defence_easy),
	"defence is hidden without the population manager"
)
local populationBlocked, spawnBlocked, checkedQueued, enforcedRegistration = false, false, false, false
local registered = {}
ix.eventController = {
	CreateCombatPack = function(_, origin, isolated) return {origin = origin, isolated = isolated} end,
	CanSpawnMutant = function(_, _, includeQueued)
		checkedQueued = includeQueued
		return not populationBlocked
	end,
	RegisterMutant = function(_, npc, enforceLimit)
		enforcedRegistration = enforceLimit
		registered[#registered + 1] = npc
	end,
	HasPlayerNear = function(_, position, range)
		if spawnBlocked then return true end
		for _, player in ipairs(players) do
			if player:Alive() and player:GetPos():DistToSqr(position) <= range ^ 2 then return true end
		end
		return false
	end,
}
check(ix.jobs.field.IsAvailable(ix.jobs.list.field_defence_easy), "defence uses existing sites and attack points")
local originalDefenceSettings = copy(ix.jobs.field.settings.defence)
ix.jobs.field.settings.defence.duration, ix.jobs.field.settings.defence.waveInterval = 4, 0
ix.jobs.field.settings.defence.waves[1] = {
	{classes = {"npc_mutant_dog"}, count = 2}, {classes = {"npc_mutant_pseudodog"}, count = 1},
}
local function livingAttackers()
	local result = {}
	for _, npc in ipairs(registered) do
		if IsValid(npc) and npc:Health() > 0 then result[#result + 1] = npc end
	end
	return result
end
dofile(base .. "sv_listeners.lua")
local function killWave()
	for _, npc in ipairs(livingAttackers()) do
		npc:SetHealth(0)
		local world = {IsPlayer = function() return false end}
		PLUGIN:OnNPCKilled(npc, world)
		PLUGIN:OnNPCKilled(npc, world)
	end
end
job = assign(character, "defence")
client.position = Vector(-4000, 0, 0)
now = now + 2
ix.jobs.field.Action(client, "Contact", "start")
check(character.jobs.Contact.fieldTask.stage == "deploy", "research cannot start remotely")
client.position = ix.jobs.field.Unpack(job.fieldTask.point)
populationBlocked = true
now = now + 2
ix.jobs.field.Action(client, "Contact", "start")
check(character.jobs.Contact.fieldTask.stage == "deploy", "population cap blocks research startup")
populationBlocked = false
now = now + 2
ix.jobs.field.Action(client, "Contact", "start")
entity = ix.jobs.field.GetObject(character, character.jobs.Contact)
check(IsValid(entity) and character.jobs.Contact.fieldTask.stage == "defending", "starting research creates a sampler")
local originalEncounterLimit = ix.jobs.field.maxDefences
ix.jobs.field.maxDefences = 1
local otherCharacter = stranger:GetCharacter()
assign(otherCharacter, "defence")
stranger.position = ix.jobs.field.Unpack(otherCharacter.jobs.Contact.fieldTask.point)
ix.jobs.field.Action(stranger, "Contact", "start")
check(otherCharacter.jobs.Contact.fieldTask.stage == "deploy", "concurrent encounter limit includes newly started research")
ix.jobs.field.Cleanup(otherCharacter, otherCharacter.jobs.Contact)
otherCharacter.jobs.Contact = nil
ix.jobs.field.maxDefences = originalEncounterLimit
count = #objects
now = now + 2
ix.jobs.field.Action(client, "Contact", "start")
check(#objects == count, "repeated startup cannot create another encounter")
now = now + 2
ix.jobs.field.Collect(client, entity)
check(#callbacks == 0, "unfinished research cannot be collected")
spawnBlocked = true
update(client, character)
check(#livingAttackers() == 0, "attackers do not spawn on nearby players")
spawnBlocked = false
populationBlocked = true
update(client, character)
check(#livingAttackers() == 0 and character.jobs.Contact.fieldTask.defence.completedWaves == 0,
	"capacity-limited waves cannot be silently completed")
populationBlocked = false
update(client, character)
check(#livingAttackers() == 2, "research attackers respect the shared per-tick spawn budget")
check(checkedQueued and enforcedRegistration, "attacker creation checks queued capacity and enforces registration limits")
local attackingNPC = livingAttackers()[1]
check(attackingNPC:GetEnemy() == client, "attackers engage the assigned defender")
local health = entity:Health()
ix.jobs.field.DefenceDamage(
	entity,
	{GetAttacker = function() return stranger end, GetDamage = function() return 999 end}
)
check(entity:Health() == health, "unrelated players cannot damage another character's sampler")
ix.jobs.field.DefenceDamage(
	entity,
	{GetAttacker = function() return attackingNPC end, GetDamage = function() return 10 end}
)
check(entity:Health() == health - 10, "encounter attackers can damage their sampler")
attackingNPC.position, attackingNPC.hidden = entity:GetPos(), true
update(client, character)
health = character.jobs.Contact.fieldTask.defence.health
attackingNPC.hidden = false
update(client, character)
check(character.jobs.Contact.fieldTask.defence.health < health, "visible nearby mutants disrupt the sampler")
check(character.jobs.Contact.fieldTask.stage == "defending", "elapsed recording time cannot bypass uncleared waves")
attackingNPC:Remove()
update(client, character)
check(#livingAttackers() == 2 and character.jobs.Contact.fieldTask.defence.completedWaves == 0,
	"removed attackers are replaced rather than counted as kills")
ix.jobs.field.DefenceKilled(attackingNPC)
update(client, character)
check(character.jobs.Contact.fieldTask.defence.completedWaves == 0,
	"late death events from replaced attackers cannot credit their replacements")
killWave()
update(client, character)
check(character.jobs.Contact.fieldTask.defence.completedWaves == 1,
	"the real kill listener credits a cleared wave once, including non-player kills")
update(client, character)
check(#livingAttackers() == 1, "next wave uses its saved composition")
local checkpoint = copy(character.jobs.Contact.fieldTask)
client.position = client.position + Vector(2000, 0, 0)
update(client, character)
check(entity.invalid and #livingAttackers() == 0, "leaving the defence area cleans up sampler and attackers")
check(character.jobs.Contact.fieldTask.defence.completedWaves == checkpoint.defence.completedWaves,
	"interruption preserves completed waves")
local activePlayers = players
players = {stranger}
now = now + 120
PLUGIN:Think()
players = activePlayers
client.position = ix.jobs.field.Unpack(job.fieldTask.point)
update(client, character)
entity = ix.jobs.field.GetObject(character, character.jobs.Contact)
check(character.jobs.Contact.fieldTask.defence.guardedSeconds == checkpoint.defence.guardedSeconds,
	"offline time cannot advance defended recording")
check(#livingAttackers() == 1 and character.jobs.Contact.fieldTask.defence.completedWaves == 1,
	"returning restarts only the unfinished wave")
killWave()
update(client, character)
check(character.jobs.Contact.fieldTask.stage == "ready" and not character.jobs.Contact.isCompleted,
	"clearing all waves and recording prepares results without paying")
now = now + 2
ix.jobs.field.Collect(client, entity)
flush()
check(character.jobs.Contact.isCompleted and ix.jobs.field.CanComplete(character, character.jobs.Contact),
	"defender must retrieve the results before completing research")
moneyBefore = character.money
client:ixJobComplete("Contact")
client:ixJobComplete("Contact")
check(character.money == moneyBefore + 100, "research pays once through ordinary job completion")

ix.jobs.field.settings.defence.duration, ix.jobs.field.settings.defence.samplerHealth = 90, 1
job = assign(character, "defence")
client.position = ix.jobs.field.Unpack(job.fieldTask.point)
now = now + 2
ix.jobs.field.Action(client, "Contact", "start")
entity = ix.jobs.field.GetObject(character, character.jobs.Contact)
update(client, character)
local guardedBeforeDisconnect = character.jobs.Contact.fieldTask.defence.guardedSeconds
activePlayers = players
players = {stranger}
update(client, character)
now = now + 120
PLUGIN:Think()
players = activePlayers
update(client, character)
entity = ix.jobs.field.GetObject(character, character.jobs.Contact)
check(character.jobs.Contact.fieldTask.defence.guardedSeconds == guardedBeforeDisconnect
	and guardedBeforeDisconnect < character.jobs.Contact.fieldTask.defence.duration,
	"unfinished recording cannot advance while the defender is disconnected")
for _, npc in ipairs(livingAttackers()) do npc.position = entity:GetPos() end
update(client, character)
check(character.jobs.Contact.fieldTask.stage == "deploy" and entity.invalid and #livingAttackers() == 0,
	"sampler destruction fails the attempt and removes its attackers")
check(character.money == moneyBefore + 100, "failed defence grants no payment")
now = now + 2
ix.jobs.field.Action(client, "Contact", "start")
check(character.jobs.Contact.fieldTask.stage == "deploy", "failed attempts enforce a persistent retry delay")
now = now + ix.jobs.field.settings.defence.retryDelay
ix.jobs.field.Action(client, "Contact", "start")
check(character.jobs.Contact.fieldTask.stage == "defending"
	and character.jobs.Contact.fieldTask.point[1] == job.fieldTask.point[1], "explicit retry keeps the assigned site")
update(client, character)
character.data.lastTaskAbandon = 0
client:ixJobRemove("Contact")
check(not character.jobs.Contact and #livingAttackers() == 0, "abandonment removes the entire defence encounter")
ix.jobs.field.settings.defence = originalDefenceSettings
job = assign(character, "defence")
client.position = ix.jobs.field.Unpack(job.fieldTask.point)
now = now + 2
ix.jobs.field.Action(client, "Contact", "start")
update(client, character)
local activePopulation = ix.eventController
ix.eventController = nil
update(client, character)
check(#livingAttackers() == 0 and character.jobs.Contact.fieldTask.stage == "defending",
	"population-manager removal pauses research without losing its assignment")
ix.eventController = activePopulation
update(client, character)
entity = ix.jobs.field.GetObject(character, character.jobs.Contact)
check(#livingAttackers() > 0, "restoring population management resumes the interrupted wave")

Angle = function(...) return {...} end
ITEM = {}
dofile("gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_notebook.lua")
ix.item.list.town_quest_notebook = setmetatable(ITEM, {__index = cargoBase})
local courierClient, courier, courierInventory = actor()
local courierDefinition = {
	name = "Recover the landing log",
	fieldType = "recovery", fieldMap = map, fieldCargo = "town_quest_notebook",
	fieldCargoDescription = "A water-stained maintenance log with a torn cover.",
	fieldCargoName = "Landing maintenance log", fieldRecipient = "Ledger", fieldRecipientMap = "rp_waystation",
	desc = "Recover the landing log and deliver it to Ledger.", moneyReward = 0, repReward = 0,
}
ix.jobs.list.courier_test = courierDefinition
local courierJob = {identifier = "courier_test", rewardKey = "job:courier", progressionClaim = now,
	numberRec = 1, progress = 0, moneyReward = 0}
check(ix.jobs.field.Assign(courier, "Ballast", courierJob), "custom cargo gets a usable assigned recovery site")
courier.jobs.Ballast = copy(courierJob)
check(courierJob.fieldTask.cargo == "town_quest_notebook"
	and courierJob.fieldTask.recipient == "Ledger", "cargo and recipient are saved on acceptance")
courierDefinition.fieldCargoDescription = "Changed description"
courierDefinition.fieldCargoName = "Changed name"
courierDefinition.fieldCargo, courierDefinition.fieldRecipient = "job_recovery_case", "Changed recipient"
check(courierJob.fieldTask.cargo == "town_quest_notebook" and courierJob.fieldTask.recipient == "Ledger",
	"definition edits cannot rewrite an accepted commission")
check(ix.jobs.getFormattedDesc(courierJob):find("deliver it to Ledger", 1, true),
	"accepted commissions retain their description snapshot")
local oldAssignment = copy(courierJob)
oldAssignment.fieldTask.description, oldAssignment.fieldTask.recipient = nil, nil
check(not ix.jobs.getFormattedDesc(oldAssignment):find("Ledger", 1, true),
	"older saved recoveries do not inherit a newly authored recipient")
courierClient.position = ix.jobs.field.Unpack(courierJob.fieldTask.point)
update(courierClient, courier)
local courierObject = ix.jobs.field.GetObject(courier, courierJob)
check(courierObject.model == ix.item.list.town_quest_notebook.model,
	"the world object uses the commission's custom cargo model")
check(courierObject["cotz/jobsystem/cargo-name"] == "Landing maintenance log",
	"world cargo displays the commission-specific name")
courierInventory.full = true
ix.jobs.field.Collect(courierClient, courierObject)
flush()
check(not ix.jobs.field.FindCargo(courier, courierJob), "full inventories leave custom cargo recoverable at its site")
courierInventory.full = false
now = now + 2
ix.jobs.field.Collect(courierClient, courierObject)
flush()
local deliveredCargo = ix.jobs.field.FindCargo(courier, courierJob)
check(courierJob.fieldTask.cargoDescription == "A water-stained maintenance log with a torn cover."
	and deliveredCargo:GetData("fieldDescription") == courierJob.fieldTask.cargoDescription,
	"recovered cargo retains the accepted description after definition changes")
check(deliveredCargo and deliveredCargo:GetName() == "Landing maintenance log",
	"collected cargo carries its commission-specific inventory name")
check(deliveredCargo:GetDescription():find("Deliver this to Ledger", 1, true),
	"cargo descriptions name the receiving contact")
deliveredCargo:SetData("fieldDescription", "An annotated service log.")
local cargoBackground = "\n\n" .. deliveredCargo.longdesc
check(deliveredCargo:GetDescription() == "An annotated service log." .. cargoBackground .. "\nDeliver this to Ledger."
	and deliveredCargo:GetName() == "Landing maintenance log", "description overrides preserve name and destination")
deliveredCargo:SetData("fieldName", nil)
check(deliveredCargo:GetName() == deliveredCargo.name, "clearing the name restores the concrete default")
deliveredCargo:SetData("fieldDescription", nil)
check(deliveredCargo:GetDescription() == deliveredCargo.description .. cargoBackground .. "\nDeliver this to Ledger.",
	"clearing the description restores the concrete default and keeps instructions")
deliveredCargo:SetData("fieldRecipient", nil)
check(deliveredCargo:GetDescription() == deliveredCargo.description
	.. cargoBackground .. "\nReturn this to the contact who issued your assignment.",
	"unaddressed cargo keeps return instructions")
local parcel = setmetatable({data = {}}, {__index = ix.item.list.job_dead_drop_parcel})
parcel.GetData, parcel.SetData = deliveredCargo.GetData, deliveredCargo.SetData
local parcelInstruction = "\nUse Show assignment on this parcel to find the destination, then Bury parcel with digging tool."
local parcelBackground = "\n\n" .. parcel.longdesc
check(parcel:GetDescription() == parcel.description .. parcelBackground .. parcelInstruction,
	"dead-drop default keeps background and PDA instructions")
parcel:SetData("fieldDescription", "A parcel wrapped in oilcloth.")
check(parcel:GetDescription() == "A parcel wrapped in oilcloth." .. parcelBackground .. parcelInstruction,
	"dead-drop description override keeps PDA instructions")
parcel:SetData("fieldDescription", nil)
check(parcel:GetDescription() == parcel.description .. parcelBackground .. parcelInstruction,
	"dead-drop description can be cleared")
check(not courier.jobs.Ballast.isCompleted and not ix.jobs.field.CanComplete(courier, courier.jobs.Ballast),
	"collecting a delivery item does not complete its commission")
courierClient:ixJobComplete("Ballast")
check(courier.jobs.Ballast ~= nil, "issuer cannot complete a commission before the recipient receives cargo")
update(courierClient, courier)
check(not courier.jobs.Ballast.isCompleted, "periodic recovery updates cannot bypass the recipient")
local recipient = {name = "Ledger", position = courierClient.position}
function recipient:GetDisplayName() return self.name end
function recipient:GetPos() return self.position end
local previousTown = ix.townNPCs
ix.townNPCs = {CanInteract = function(_, actor, target)
	return IsValid(target) and not target.denied and actor:GetPos():DistToSqr(target:GetPos()) <= 128 ^ 2
end}
map = "rp_waystation"
check(not ix.jobs.field.DeliverToContact(courierClient, recipient, "Ballast", "job:expired"),
	"stale delivery claims are rejected")
recipient.name = "Carbon"
check(not ix.jobs.field.DeliverToContact(courierClient, recipient, "Ballast", courierJob.rewardKey),
	"another contact cannot receive the consignment")
recipient.name, recipient.denied = "Ledger", true
check(not ix.jobs.field.DeliverToContact(courierClient, recipient, "Ballast", courierJob.rewardKey),
	"recipient access checks apply to delivery")
recipient.denied, recipient.position = false, courierClient.position + Vector(1000, 0, 0)
check(not ix.jobs.field.DeliverToContact(courierClient, recipient, "Ballast", courierJob.rewardKey),
	"remote recipient hand-ins are rejected")
recipient.position = courierClient.position
map = "rp_marsh_cs"
check(not ix.jobs.field.DeliverToContact(courierClient, recipient, "Ballast", courierJob.rewardKey),
	"the saved recipient map is enforced")
map = "rp_waystation"
check(not ix.jobs.field.DeliverToContact(stranger, recipient, "Ballast", courierJob.rewardKey),
	"another character cannot deliver this consignment")
local removeCargo = deliveredCargo.Remove
deliveredCargo.Remove = function() return false end
check(not ix.jobs.field.DeliverToContact(courierClient, recipient, "Ballast", courierJob.rewardKey)
	and courier.jobs.Ballast.fieldTask.stage == "carrying", "failed removal grants no delivery credit")
deliveredCargo.Remove = removeCargo
courier.jobs.Ballast.fieldTask.recipientMap = "previous-home-map"
ix.townNPCs.byName = {Ledger = {map = "rp_waystation"}}
check(ix.jobs.field.GetRecipientMap(courier.jobs.Ballast.fieldTask) == "rp_waystation"
	and courier.jobs.Ballast.fieldTask.recipientMap == "previous-home-map",
	"a relocated town recipient resolves its current home without rewriting the saved assignment")
check(ix.jobs.field.DeliverToContact(courierClient, recipient, "Ballast", courierJob.rewardKey),
	"the named recipient accepts and consumes the matching cargo")
check(deliveredCargo.removed and courier.jobs.Ballast.fieldTask.stage == "delivered"
	and courier.jobs.Ballast.isCompleted, "recipient receipt is saved before returning to the issuer")
check(not ix.jobs.field.DeliverToContact(courierClient, recipient, "Ballast", courierJob.rewardKey),
	"repeated delivery cannot consume or credit twice")
local receipt = copy(courier.jobs.Ballast)
check(
	ix.jobs.field.CanComplete(courier, receipt),
	"a restored delivered assignment completes without carrying consumed cargo"
)
map = courierJob.fieldTask.map
update(courierClient, courier)
check(not ix.jobs.field.GetObject(courier, courierJob), "delivered cargo cannot respawn at the original site")
ix.townNPCs = previousTown

-- Cross-map routes do not compare unrelated map coordinate systems.
local routeClient, routeCharacter, routeInventory = actor()
function routeInventory:GetItems()
	local items = {}
	for id, item in pairs(self.items) do items[id] = item end
	items.diggingTool = diggingTool

	return items
end
local pickupMap, destinationMap = "cross-map-pickup", "cross-map-destination"
ix.plugin.list.hidestashspawner.stashspawnpoints[pickupMap] = {{Vector(1000, 0, 0), "Test event area"}}
ix.plugin.list.hidestashspawner.stashspawnpoints[destinationMap] = {{Vector(1000, 0, 0), "Test event area"}}
ix.jobs.list.crossMapDrop = {name = "Cross-map drop", fieldType = "deadDrop", fieldMap = pickupMap,
	destinationMap = destinationMap, tier = 2}
local routeJob = {identifier = "crossMapDrop", rewardKey = "cross-map:1", numberRec = 1,
	progress = 0, progressionClaim = 99999}
check(ix.jobs.field.Assign(routeCharacter, "Contact", routeJob), "cross-map endpoints can share coordinates")
check(routeJob.fieldTask.map == pickupMap and routeJob.fieldTask.destinationMap == destinationMap,
	"both route maps are snapshotted")
routeCharacter.jobs.Contact = copy(routeJob)
map, routeClient.position = pickupMap, Vector(1000, 0, 0)
update(routeClient, routeCharacter)
local routeObject = ix.jobs.field.GetObject(routeCharacter, routeJob)
ix.jobs.field.DigDeadDrop(routeClient)
flush()
check(routeCharacter.jobs.Contact.fieldTask.stage == "carrying", "parcel pickup works on the saved source map")
now = now + 2
ix.jobs.field.Action(routeClient, "Contact", "deliver")
check(not routeCharacter.jobs.Contact.isCompleted, "same coordinates on the pickup map cannot deliver remotely")
map = destinationMap
now = now + 2
ix.jobs.field.Action(routeClient, "Contact", "deliver")
check(routeCharacter.jobs.Contact.isCompleted and routeCharacter.jobs.Contact.fieldTask.stage == "delivered",
	"parcel delivers on the saved destination map")
local sensorClient, sensorCharacter = actor()
map = "rp_marsh_cs"
ix.jobs.list.sensor900 = {fieldType = "sensor", fieldMap = map, fieldSettings = {recordSeconds = 900}}
local sensorJob = {identifier = "sensor900", rewardKey = "sensor:900", numberRec = 1, progress = 0}
check(ix.jobs.field.Assign(sensorCharacter, "Contact", sensorJob), "sensor accepts per-assignment settings")
sensorCharacter.jobs.Contact = sensorJob
sensorClient.position = ix.jobs.field.Unpack(sensorJob.fieldTask.point)
now = now + 2
ix.jobs.field.Action(sensorClient, "Contact", "deploy")
check(ix.jobs.field.GetObject(sensorCharacter, sensorCharacter.jobs.Contact).model
	== "models/lostsignalproject/items/quest/scanner_anomaly.mdl", "sensor uses the requested scanner model")
check(ix.jobs.field.GetObjectModel({kind = "sensor", cargo = "town_quest_notebook"})
	== "models/lostsignalproject/items/quest/scanner_anomaly.mdl", "custom commission sensors use the scanner too")
local savedReadyAt = sensorCharacter.jobs.Contact.fieldTask.readyAt
check(savedReadyAt == now + 900, "new sensor stores a fifteen-minute real-time deadline")
now = now + 901
map = "another-map"
update(sensorClient, sensorCharacter)
check(sensorCharacter.jobs.Contact.fieldTask.readyAt == savedReadyAt and os.time() >= savedReadyAt,
	"deadline survives travel and continues passing without local simulation")

PLUGIN:OnUnload()
check(entity.invalid and #livingAttackers() == 0, "plugin unload removes field objects and owned attackers")
local markerCount = markers
now = now + 2
ix.jobs.field.Action(client, "Contact", "status")
check(markers == markerCount, "retained network callbacks cannot operate after plugin unload")
-- Recovery clues are text, retain saved sites and do not depend on camera/HUD markers.
map = "rp_marsh_cs"
points()
local recovery = {kind = "recovery", map = map, point = {1000, 0, 0}, searchRadius = 384,
	cargo = "job_recovery_case", stage = "search"}
check(ix.jobs.field.EnsureRecoveryClue(recovery) and recovery.whereabouts:find("Test event area", 1, true),
	"existing saved recovery sites acquire a named event clue")
check(recovery.point[1] == 1000 and not ix.jobs.field.EnsureRecoveryClue(recovery),
	"clue resolution neither moves the accepted site nor resaves a resolved clue")
local remoteClue = ix.jobs.field.RecoveryClue(Vector(8000, 0, 0), map, 384)
check(remoteClue:find("north", 1, true) and remoteClue:find("metres", 1, true),
	"distant sites describe a compass offset from a named area")
local missing = copy(recovery)
missing.whereabouts = nil
ix.plugin.list.eventcontroller.eventpoints[map] = {}
check(not ix.jobs.field.EnsureRecoveryClue(missing) and missing.point[1] == 1000,
	"temporarily missing providers leave accepted recovery state intact")
check(not ix.jobs.field.IsAvailable(ix.jobs.list.field_recovery_easy),
	"new recovery offers require named location clues")
points()
local named = ix.plugin.list.eventcontroller.eventpoints[map][1]
named[2] = "50% Yard"
local textJob = {identifier = "field_recovery_easy", numberRec = 1, fieldTask = copy(missing)}
ix.jobs.field.EnsureRecoveryClue(textJob.fieldTask)
check(ix.jobs.getFormattedDesc(textJob):find("50% Yard", 1, true),
	"literal percent signs in event area names are safe in the PDA")
local previousMarkers = markers
local recoveryClient, recoveryOwner = actor()
recoveryOwner.jobs.Clue = textJob
ix.jobs.field.Status(recoveryClient, "Clue", textJob)
check(markers == previousMarkers, "Show assignment gives recovery text without creating a world marker")
print("PASS: " .. checks .. " field task checks")
