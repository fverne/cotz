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
	GetModelBounds = function() return Vector(-8, -8, 0), Vector(8, 8, 16) end,
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
local playerMeta = {}
FindMetaTable = function() return playerMeta end
ix = {jobs = {list = {}, jobsbycategory = {}}, plugin = {list = {}},
	item = {list = {}}, char = {loaded = {}}, taskRewards = {},
	config = {Get = function(_, default) return default end}, progression = {GetNPCFromName = function() end},
	dialogue = {notifyMoneyReceive = function() end, notifyReputationReceive = function() end}}
local players, objects, callbacks = {}, {}, {}
player = {Iterator = function() return ipairs(players) end}
ents = {Create = function(class)
	local entity = {class = class, health = 100}
	function entity:SetPos(position) self.position = position end
	function entity:GetPos() return self.position end
	function entity:SetModel(model) self.model = model end
	function entity:Spawn() end
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
dofile(base .. "libs/sh_fieldtasks.lua")
local field = ix.jobs.field
local handle = assert(io.open(base .. "libs/sh_jobs.lua"))
local source = handle:read("*a")
handle:close()
assert((loadstring or load)(source:gsub("!=", "~="):gsub("!", "not ")))()
dofile(base .. "sv_fieldtasks.lua")
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
		eventcontroller = {eventpoints = {[map] = {{Vector(1000, 0, 0)}, {Vector(2000, 0, 0)}}}},
		radiationcontroller = {radiationpoints = {[map] = {{Vector(3000, 0, 0)}}}},
		anomalycontroller = {anomalypoints = {[map] = {{Vector(4000, 0, 0)}}}},
	}
end
points()
field.pools.combined = {"packages", "rf", "gas", "combined"}
check(#field.CollectPoints({"combined", "event"}, map) == 4, "pools combine, deduplicate and bound recursion")
check(#field.CollectPoints({"combined"}, "missing") == 0, "missing maps are empty")
check(#ix.plugin.list.eventcontroller.eventpoints[map] == 2, "collection never changes source tables")
check(field.IsAvailable(ix.jobs.list.field_recovery_easy), "configured job is available")
check(not field.IsAvailable(ix.jobs.list.field_recovery_hard), "absent target-map data hides the offer")
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
local itemSerial = 0
local lastItem
ix.item.Instance = function(_, id, data, _, _, callback)
	callbacks[#callbacks + 1] = function()
		itemSerial = itemSerial + 1
		local item = setmetatable({uniqueID = id, data = data, id = itemSerial}, {__index = ix.item.list[id]})
		function item:GetData(key) return self.data[key] end
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
local function assign(character, kind, npc)
	npc = npc or "Contact"
	local job = {identifier = "field_" .. kind .. "_easy", rewardKey = "job:" .. (#objects + now),
		progressionClaim = now, numberRec = 1, progress = 0, moneyReward = 100}
	check(field.Assign(character, npc, job), "assignment selects existing point: " .. kind)
	character.jobs[npc] = copy(job)

	return job
end
local function update(client, character)
	now = now + 2
	PLUGIN:Think()
end

local client, character, inventory = actor()
local job = assign(character, "recovery")
check(not field.CanComplete(character, job), "no cargo means no completion")
client:ixJobEvaluate(job.identifier)
check(not character.jobs.Contact.isCompleted, "generic completion triggers cannot finish field assignments")
client.position = Vector(-4000, 0, 0)
local count = #objects
update(client, character)
check(#objects == count, "recovery does not spawn while owner is distant")
client.position = field.Unpack(job.fieldTask.point)
update(client, character)
local entity = objects[#objects]
check(#objects == count + 1, "recovery spawns when owner approaches")
local stranger = actor()
stranger.position = client.position
field.Collect(stranger, entity)
check(#callbacks == 0, "another character cannot collect the task object")
map = "rp_waystation"
field.Collect(client, entity)
check(#callbacks == 0, "wrong-map interaction cannot grant cargo")
map = "rp_marsh_cs"
inventory.full = true
field.Collect(client, entity)
check(#callbacks == 0 and not entity.invalid, "full inventory leaves recovery available")
inventory.full = false
now = now + 2
character.overweight = true
field.Collect(client, entity)
check(#callbacks == 0 and not entity.invalid, "overweight owner leaves recovery available")
character.overweight = false
now = now + 2
field.Collect(client, entity)
client.position = Vector(-4000, 0, 0)
flush()
check(lastItem.removed and not entity.invalid, "moving away during item creation cannot grant cargo")
client.position = field.Unpack(job.fieldTask.point)
now = now + 2
field.Collect(client, entity)
field.Collect(client, entity)
check(#callbacks == 1, "repeated collection has one in-flight item creation")
inventory.full = true
flush()
check(lastItem.removed and not entity.invalid, "inventory becoming full during creation consumes no objective")
inventory.full = false
now = now + 2
field.Collect(client, entity)
character.overweight = true
flush()
check(lastItem.removed and not entity.invalid, "weight change during creation cannot grant cargo")
character.overweight = false
now = now + 2
field.Collect(client, entity)
flush()
job = character.jobs.Contact
check(job.isCompleted and field.CanComplete(character, job), "successful transfer completes the objective")
check(entity.invalid, "collected world object is removed")
check(lastItem:CanTransfer(nil, stranger:GetCharacter():GetInventory()) == false, "cargo blocks another inventory")
check(lastItem:CanTransfer(nil, nil) == false, "cargo cannot be dropped")
check(PLUGIN:CanPlayerTakeItem(stranger, lastItem) == false, "foreign character pickup is denied")
check(PLUGIN:CanPlayerTakeItem(client, lastItem) == nil, "owner pickup does not override other hooks")
lastItem.data.fieldClaim = "another-job"
check(not field.CanComplete(character, job), "cargo must match the exact active claim")
lastItem.data.fieldClaim = job.rewardKey
local saved = copy(job.fieldTask.point)
field.settings.recovery.sources = {"gas"}
update(client, character)
check(character.jobs.Contact.fieldTask.point[1] == saved[1], "configuration edits do not reroll accepted assignments")
field.settings.recovery.sources = {"packages", "rf"}
local earned = 0
ix.taskRewards.RecordCompletion = function() earned = earned + 1 end
ix.taskRewards.EarnOffer = function() end
client:ixJobComplete("Contact")
client:ixJobComplete("Contact")
check(character.money == 100 and earned == 1 and not next(inventory.items), "completion pays once and consumes cargo")

job = assign(character, "recovery")
client.position = field.Unpack(job.fieldTask.point)
update(client, character)
entity = objects[#objects]
now = now + 2
field.Collect(client, entity)
ix.taskRewards.RemoveJobOffer = function() end
client:ixJobRemove("Contact")
check(entity.invalid and not character.jobs.Contact, "abandonment removes the world object and active assignment")
flush()
check(lastItem.removed and not next(inventory.items), "abandoning during database callback cannot grant cargo")
job = assign(character, "recovery")
update(client, character)
entity = objects[#objects]
now = now + 2
field.Collect(client, entity)
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
field.Collect(client, entity)
now = now + 31
PLUGIN:Think()
field.Collect(client, entity)
check(#callbacks == 2, "expired database requests can retry without abandoning the task")
flush()
check(character.jobs.Contact.isCompleted and #callbacks == 0, "late callback cannot duplicate a retried pickup")
local cargoCount = 0
for _ in pairs(inventory.items) do cargoCount = cargoCount + 1 end
check(cargoCount == 1, "only the current pickup request can grant cargo")
field.Cleanup(character, character.jobs.Contact)
character.jobs.Contact = nil

job = assign(character, "sensor")
client.position = field.Unpack(job.fieldTask.point)
count = #objects
update(client, character)
check(#objects == count, "sensor does not exist before deployment")
field.Action(client, "Contact", "deploy")
entity = objects[#objects]
check(character.jobs.Contact.fieldTask.stage == "recording", "deploy starts persisted recording timer")
local readyAt = character.jobs.Contact.fieldTask.readyAt
client.position = client.position + Vector(600, 0, 0)
update(client, character)
client.position = field.Unpack(character.jobs.Contact.fieldTask.point)
field.Collect(client, entity)
check(#callbacks == 0, "departure alone cannot bypass recording time")
character.jobs.Contact.fieldTask.departed = false
now = now + 200
field.Collect(client, entity)
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
client.position = field.Unpack(job.fieldTask.point)
update(client, character)
entity = objects[#objects]
check(character.jobs.Contact.fieldTask.readyAt == readyAt
	and character.jobs.Contact.fieldTask.point[1] == sensorPoint[1], "reconnect keeps the sensor site and deadline")
field.Collect(client, entity)
flush()
check(character.jobs.Contact.isCompleted, "departed and finished sensor can be retrieved")
field.Cleanup(character, character.jobs.Contact)
check(not next(inventory.items), "cleanup removes bound cargo")
character.jobs.Contact = nil

job = assign(character, "triangulation")
client.position = field.Unpack(job.fieldTask.point)
count = #objects
update(client, character)
check(#objects == count, "hidden transmitter waits for sufficient readings")
check(not field.CanRead(job.fieldTask, client.position, job.fieldTask),
	"coincident signal positions cannot save a bearing that prevents later readings")
client.position = Vector(0, 0, 0)
field.Action(client, "Contact", "read")
check(#character.jobs.Contact.fieldTask.readings == 1, "first reading is saved")
now = now + 2
field.Action(client, "Contact", "read")
check(#character.jobs.Contact.fieldTask.readings == 1, "same position cannot farm readings")
client.position = Vector(-1000, 0, 0)
now = now + 2
field.Action(client, "Contact", "read")
check(#character.jobs.Contact.fieldTask.readings == 1, "collinear readings cannot solve the signal")
client.position = Vector(0, 1000, 0)
now = now + 2
field.Action(client, "Contact", "read")
client.position = Vector(2000, 1000, 0)
now = now + 2
field.Action(client, "Contact", "read")
check(#character.jobs.Contact.fieldTask.readings == 3 and markers > 0,
	"three separated bearings reveal the search site")
client.position = field.Unpack(job.fieldTask.point)
update(client, character)
entity = objects[#objects]
check(#objects == count + 1, "solved transmitter spawns near assigned character")
now = now + 2
field.Collect(client, entity)
flush()
check(character.jobs.Contact.isCompleted, "transmitter recovery completes objective")
field.Cleanup(character, character.jobs.Contact)
character.jobs.Contact = nil

blocked = true
check(not field.Assign(character, "Contact", {identifier = "field_recovery_easy"}),
	"blocked sites are not assigned locally")
blocked = false
ix.plugin.list = {}
check(not field.IsAvailable(ix.jobs.list.field_sensor_easy), "disabled point providers suppress offers")
points()
ix.taskRewards.PrepareJob = function(_, _, active)
	active.rewardKey, active.progressionClaim = "job:accepted", now + 1
	return true
end
ix.taskRewards.SelectOffer = function() end
check(client:ixJobAdd("field_recovery_easy", "NewContact"), "normal acceptance path creates a field assignment")
check(character.jobs.NewContact.fieldTask and not character.jobs.NewContact.isCompleted,
	"acceptance saves field state alongside ordinary reward state")
field.Cleanup(character, character.jobs.NewContact)
character.jobs.NewContact = nil

ix.plugin.list.hidestashspawner.stashspawnpoints[map][2] = {Vector(5000, 0, 0), "distant stash"}
check(field.IsAvailable(ix.jobs.list.field_deadDrop_easy), "dead drops require a separated pair of existing points")
local dropSettings = field.settings.deadDrop
local sourcePoint, destination = field.SelectRoute(dropSettings, map)
check(sourcePoint:DistToSqr(destination) >= dropSettings.minRouteDistance ^ 2,
	"route selection enforces minimum travel distance")
local originalDistance = dropSettings.minRouteDistance
dropSettings.minRouteDistance = 100000
check(not field.IsAvailable(ix.jobs.list.field_deadDrop_easy), "impossible dead-drop routes are hidden")
dropSettings.minRouteDistance = originalDistance
job = assign(character, "deadDrop")
local route = copy(job.fieldTask)
client.position = field.Unpack(route.point)
update(client, character)
entity = field.GetObject(character, character.jobs.Contact)
check(IsValid(entity), "parcel appears only at the saved pickup site")
field.Collect(client, entity)
flush()
check(character.jobs.Contact.fieldTask.stage == "carrying" and not character.jobs.Contact.isCompleted,
	"parcel pickup does not complete the circuit")
local moneyBefore = character.money
client:ixJobComplete("Contact")
check(character.money == moneyBefore, "pickup alone cannot earn payment")
now = now + 2
field.Action(client, "Contact", "status")
check(lastMarker:DistToSqr(field.Unpack(route.destination)) == 0, "carried parcel directions show the destination")
now = now + 2
field.Action(client, "Contact", "deliver")
check(field.FindCargo(character, character.jobs.Contact), "delivery from the pickup site consumes nothing")
client.position = field.Unpack(route.destination)
local parcel = field.FindCargo(character, character.jobs.Contact)
inventory.items[parcel.id] = nil
now = now + 2
field.Action(client, "Contact", "deliver")
check(character.jobs.Contact.fieldTask.stage == "carrying", "delivery requires the matching parcel")
inventory.items[parcel.id] = parcel
local originalRemove = parcel.Remove
parcel.Remove = function() return false end
now = now + 2
field.Action(client, "Contact", "deliver")
check(not character.jobs.Contact.isCompleted, "failed parcel removal cannot complete delivery")
parcel.Remove = originalRemove
now = now + 2
field.Action(client, "Contact", "deliver")
check(character.jobs.Contact.fieldTask.stage == "delivered" and character.jobs.Contact.isCompleted
	and not next(inventory.items), "delivery consumes cargo and saves completion")
now = now + 2
field.Action(client, "Contact", "deliver")
update(client, character)
check(character.jobs.Contact.fieldTask.stage == "delivered", "completed delivery survives updates without cargo")
client:ixJobComplete("Contact")
client:ixJobComplete("Contact")
check(character.money == moneyBefore + 100, "dead-drop completion pays exactly once")
job = assign(character, "deadDrop")
client.position = field.Unpack(job.fieldTask.point)
update(client, character)
field.Collect(client, field.GetObject(character, character.jobs.Contact))
flush()
field.FindCargo(character, character.jobs.Contact):Remove()
update(client, character)
check(character.jobs.Contact.fieldTask.stage == "search"
	and character.jobs.Contact.fieldTask.destination[1] == job.fieldTask.destination[1],
	"lost parcel restores the same saved circuit")
field.Cleanup(character, character.jobs.Contact)
character.jobs.Contact = nil

check(not field.IsAvailable(ix.jobs.list.field_defence_easy), "defence is hidden without the population manager")
local populationBlocked, spawnBlocked, checkedQueued, enforcedRegistration = false, false, false, false
local registered = {}
ix.eventController = {
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
check(field.IsAvailable(ix.jobs.list.field_defence_easy), "defence uses existing sites and attack points")
local defenceSettings = field.settings.defence
local originalDefenceSettings = copy(defenceSettings)
defenceSettings.duration, defenceSettings.waveInterval = 4, 0
defenceSettings.waves[1] = {
	{classes = {"npc_mutant_dog"}, count = 2}, {classes = {"npc_mutant_pseudodog"}, count = 1},
}
local function livingAttackers()
	local result = {}
	for _, npc in ipairs(registered) do
		if IsValid(npc) and npc:Health() > 0 then result[#result + 1] = npc end
	end
	return result
end
handle = assert(io.open(base .. "sh_listeners.lua"))
source = handle:read("*a")
handle:close()
assert((loadstring or load)(source:gsub("!=", "~="):gsub("!", "not ")))()
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
field.Action(client, "Contact", "start")
check(character.jobs.Contact.fieldTask.stage == "deploy", "research cannot start remotely")
client.position = field.Unpack(job.fieldTask.point)
populationBlocked = true
now = now + 2
field.Action(client, "Contact", "start")
check(character.jobs.Contact.fieldTask.stage == "deploy", "population cap blocks research startup")
populationBlocked = false
now = now + 2
field.Action(client, "Contact", "start")
entity = field.GetObject(character, character.jobs.Contact)
check(IsValid(entity) and character.jobs.Contact.fieldTask.stage == "defending", "starting research creates a sampler")
local originalEncounterLimit = field.maxDefences
field.maxDefences = 1
local otherCharacter = stranger:GetCharacter()
assign(otherCharacter, "defence")
stranger.position = field.Unpack(otherCharacter.jobs.Contact.fieldTask.point)
field.Action(stranger, "Contact", "start")
check(otherCharacter.jobs.Contact.fieldTask.stage == "deploy", "concurrent encounter limit includes newly started research")
field.Cleanup(otherCharacter, otherCharacter.jobs.Contact)
otherCharacter.jobs.Contact = nil
field.maxDefences = originalEncounterLimit
count = #objects
now = now + 2
field.Action(client, "Contact", "start")
check(#objects == count, "repeated startup cannot create another encounter")
now = now + 2
field.Collect(client, entity)
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
field.DefenceDamage(entity, {GetAttacker = function() return stranger end, GetDamage = function() return 999 end})
check(entity:Health() == health, "unrelated players cannot damage another character's sampler")
field.DefenceDamage(entity, {GetAttacker = function() return attackingNPC end, GetDamage = function() return 10 end})
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
field.DefenceKilled(attackingNPC)
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
client.position = field.Unpack(job.fieldTask.point)
update(client, character)
entity = field.GetObject(character, character.jobs.Contact)
check(character.jobs.Contact.fieldTask.defence.guardedSeconds == checkpoint.defence.guardedSeconds,
	"offline time cannot advance defended recording")
check(#livingAttackers() == 1 and character.jobs.Contact.fieldTask.defence.completedWaves == 1,
	"returning restarts only the unfinished wave")
killWave()
update(client, character)
check(character.jobs.Contact.fieldTask.stage == "ready" and not character.jobs.Contact.isCompleted,
	"clearing all waves and recording prepares results without paying")
now = now + 2
field.Collect(client, entity)
flush()
check(character.jobs.Contact.isCompleted and field.CanComplete(character, character.jobs.Contact),
	"defender must retrieve the results before completing research")
moneyBefore = character.money
client:ixJobComplete("Contact")
client:ixJobComplete("Contact")
check(character.money == moneyBefore + 100, "research pays once through ordinary job completion")

defenceSettings.duration, defenceSettings.samplerHealth = 90, 1
job = assign(character, "defence")
client.position = field.Unpack(job.fieldTask.point)
now = now + 2
field.Action(client, "Contact", "start")
entity = field.GetObject(character, character.jobs.Contact)
update(client, character)
local guardedBeforeDisconnect = character.jobs.Contact.fieldTask.defence.guardedSeconds
activePlayers = players
players = {stranger}
update(client, character)
now = now + 120
PLUGIN:Think()
players = activePlayers
update(client, character)
entity = field.GetObject(character, character.jobs.Contact)
check(character.jobs.Contact.fieldTask.defence.guardedSeconds == guardedBeforeDisconnect
	and guardedBeforeDisconnect < character.jobs.Contact.fieldTask.defence.duration,
	"unfinished recording cannot advance while the defender is disconnected")
for _, npc in ipairs(livingAttackers()) do npc.position = entity:GetPos() end
update(client, character)
check(character.jobs.Contact.fieldTask.stage == "deploy" and entity.invalid and #livingAttackers() == 0,
	"sampler destruction fails the attempt and removes its attackers")
check(character.money == moneyBefore + 100, "failed defence grants no payment")
now = now + 2
field.Action(client, "Contact", "start")
check(character.jobs.Contact.fieldTask.stage == "deploy", "failed attempts enforce a persistent retry delay")
now = now + defenceSettings.retryDelay
field.Action(client, "Contact", "start")
check(character.jobs.Contact.fieldTask.stage == "defending"
	and character.jobs.Contact.fieldTask.point[1] == job.fieldTask.point[1], "explicit retry keeps the assigned site")
update(client, character)
character.data.lastTaskAbandon = 0
client:ixJobRemove("Contact")
check(not character.jobs.Contact and #livingAttackers() == 0, "abandonment removes the entire defence encounter")
field.settings.defence = originalDefenceSettings
job = assign(character, "defence")
client.position = field.Unpack(job.fieldTask.point)
now = now + 2
field.Action(client, "Contact", "start")
update(client, character)
local manager = ix.eventController
ix.eventController = nil
update(client, character)
check(#livingAttackers() == 0 and character.jobs.Contact.fieldTask.stage == "defending",
	"population-manager removal pauses research without losing its assignment")
ix.eventController = manager
update(client, character)
entity = field.GetObject(character, character.jobs.Contact)
check(#livingAttackers() > 0, "restoring population management resumes the interrupted wave")
PLUGIN:OnUnload()
check(entity.invalid and #livingAttackers() == 0, "plugin unload removes field objects and owned attackers")
local markerCount = markers
now = now + 2
field.Action(client, "Contact", "status")
check(markers == markerCount, "retained network callbacks cannot operate after plugin unload")
print("PASS: " .. checks .. " field task checks")
