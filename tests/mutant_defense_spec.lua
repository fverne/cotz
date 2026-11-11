-- Run from the addon root: luatex --luaonly tests/mutant_defense_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local function copy(value)
	if type(value) ~= "table" then return value end
	local result = {}
	for key, entry in pairs(value) do result[key] = copy(entry) end

	return result
end

local now, clients, timers, inserts, created = 0, {}, {}, {}, {}
local capacity, placement, playerNear, rejectSpawn = true, true, false, false
local spawnPoint
local restockAllowed, restocks, vendorBlocked = true, 0, false
local commands = {}
local ROOT = "gamemodes/ix_cotz/plugins/"
local vectorMeta = {}
vectorMeta.__index = vectorMeta
function vectorMeta:DistToSqr(other)
	return (self.x - other.x) ^ 2 + (self.y - other.y) ^ 2 + (self.z - other.z) ^ 2
end
function Vector(x, y, z) return setmetatable({x = x, y = y, z = z}, vectorMeta) end
function CurTime() return now end
function IsValid(value) return type(value) == "table" and not value.invalid end
function ErrorNoHalt(message) error(message) end
table.Copy = copy
SERVER, MOVETYPE_NOCLIP, MOVETYPE_OBSERVER, OBS_MODE_NONE = true, 8, 10, 0
timer = {Simple = function(_, callback) timers[#timers + 1] = callback end}
local function flushTimers()
	local pending = timers
	timers = {}
	for _, callback in ipairs(pending) do callback() end
end
player = {Iterator = function() return ipairs(clients) end}
hook = {Run = function() if vendorBlocked then return false end end}
ix = {
	temp = {Corpses = {}}, char = {loaded = {}},
	command = {Add = function(id, definition) commands[id] = definition end},
	util = {Include = function(path) dofile(ROOT .. "mutantdefense/" .. path) end},
	vendorStock = {RestockFraction = function(_, _, fraction)
		check(fraction == 0.5, "voucher requests half restock")
		if restockAllowed then restocks = restocks + 1 end

		return restockAllowed
	end},
	eventController = {
		GetGroundedSpawnLocation = function(_, position) if placement then return position end end,
		GetSpawnLocation = function() if placement then return spawnPoint or Vector(1200, 0, 0) end end,
		HasPlayerNear = function() return playerNear end,
		CanSpawnMutant = function() return capacity end,
		CreateCombatPack = function(_, origin, isolated) return {origin = origin, isolated = isolated} end,
		RegisterMutant = function(_, entity, enforce, pack)
			check(enforce and pack.isolated, "event actors obey population limits in an isolated pack")
			entity.cotzPopulationRejected = rejectSpawn
		end,
		SetCombatTarget = function(_, entity, target) entity.target = target end,
	},
}
PLUGIN = {uniqueID = "mutantdefense"}
dofile(ROOT .. "mutantdefense/sh_plugin.lua")
local plugin = PLUGIN
ents = {Create = function(class)
	local entity = {class = class}
	function entity:SetPos(position) self.position = position end
	function entity:Spawn() end
	function entity:Remove()
		self.invalid = true
		plugin:EntityRemoved(self)
	end
	created[#created + 1] = entity

	return entity
end}

local serial = 0
local function newClient()
	serial = serial + 1
	local character = {id = serial, data = {}, saves = 0}
	local client = {character = character, position = Vector(0, 0, 0), alive = true, messages = {}}
	local inventory = {owner = serial, items = {}, full = false, additions = 0}
	character.inventory, character.client = inventory, client
	function character:GetID() return self.id end
	function character:GetData(key, default)
		if self.data[key] == nil then return default end

		return self.data[key]
	end
	function character:SetData(key, value) self.data[key] = copy(value) end
	function character:Save() self.saves = self.saves + 1 end
	function character:GetPlayer() return self.client end
	function character:GetInventory() return self.inventory end
	function inventory:GetItems() return self.items end
	function inventory:HasItem(id)
		for _, item in pairs(self.items) do if item.uniqueID == id and not item.removed then return item end end
		return false
	end
	function inventory:Add(id, _, data)
		self.additions = self.additions + 1
		if self.full then return false, "noFit" end
		inserts[#inserts + 1] = {inventory = self, id = id, data = copy(data), character = character}

		return 1, 1, self.owner
	end
	function client:GetCharacter() return self.character end
	function client:GetPos() return self.position end
	function client:Alive() return self.alive end
	function client:IsRestricted() return self.restricted or false end
	function client:GetMoveType() return self.moveType or 2 end
	function client:GetObserverMode() return self.observer or OBS_MODE_NONE end
	function client:Notify(message) self.messages[#self.messages + 1] = message end
	function client:GetEyeTraceNoCursor() return {Hit = true, HitPos = self.position} end
	ix.char.loaded[character.id] = character

	return client, character
end

local function finishInsert(index, bag)
	local request = table.remove(inserts, index or 1)
	local item = {uniqueID = request.id, data = request.data, owner = request.character.id}
	function item:GetData(key) return self.data[key] end
	function item:GetCharacterID() return self.owner end
	function item:Remove() self.removed = true return true end
	request.inventory.items[#request.inventory.items + 1] = item
	plugin:InventoryItemAdded(nil, bag or request.inventory, item)

	return item
end

local first, firstChar = newClient()
clients = {first}
local function resetEvent()
	plugin:EndDefense("reset")
	clients = {first}
	first.position, first.alive = Vector(0, 0, 0), true
	first.observer, first.moveType, first.restricted, first.ixRagdoll = nil, nil, nil, nil
	first.character = firstChar
	capacity, placement, playerNear, rejectSpawn = true, true, false, false
	ix.temp.Corpses = {}
	now = now + 1000
	plugin:StartDefense(Vector(0, 0, 0))
end
local function beginWave()
	now = plugin.event.nextWave
	plugin:UpdateDefense()
end
local function clearWave()
	for _, slot in ipairs(plugin.event.slots) do
		if not slot.entity then
			while not slot.entity do plugin:SpawnDefenseAttackers({first}) end
		end
		plugin:OnNPCKilled(slot.entity)
	end
	plugin:UpdateDefense()
end

for _, id in ipairs({"MutantDefenseStart", "MutantDefenseCancel", "MutantDefenseStatus"}) do
	check(commands[id].adminOnly and #commands[id].arguments == 0, id .. " has Helix admin permissions")
end
placement = false
check(plugin:StartDefense(Vector(0, 0, 0)):find("safe ground") and not plugin.event,
	"invalid centers do not create an event")
resetEvent()
check(plugin.event.phase == "preparing", "event starts in preparation")
local original = plugin.event
plugin:StartDefense(Vector(500, 0, 0))
check(plugin.event == original, "only one event can run")
now = plugin.event.nextWave - 1
plugin:UpdateDefense()
check(plugin.event.wave == 0, "preparation cannot start the wave early")
beginWave()
check(#plugin.event.slots == 3, "solo first wave contains three dogs")
plugin:UpdateDefense()
check(#created == 2 and plugin:RemainingAttackers() == 3, "spawning is budgeted and live enemies remain required")
local removed = plugin.event.slots[1].entity
removed:Remove()
check(plugin:RemainingAttackers() == 3, "unexpected removal is not a kill")
plugin:UpdateDefense()
check(plugin.event.slots[1].entity ~= removed, "unexpectedly removed attackers are replaced")
clearWave()
check(plugin.event.credited[firstChar.id] == firstChar and plugin.event.phase == "break",
	"a complete wave credits the character and starts a break")
local second, secondChar = newClient()
clients[#clients + 1] = second
beginWave()
check(#plugin.event.slots == 3, "second wave scales to the new defender count")
local third = newClient()
clients[#clients + 1] = third
check(#plugin.event.slots == 3, "a running wave does not change when someone joins")
second.position = Vector(1600, 0, 0)
plugin:UpdateDefense()
second.position = Vector(0, 0, 0)
clearWave()
check(not plugin.event.credited[secondChar.id], "leaving and returning invalidates full-wave credit")
beginWave()
check(#plugin.event.slots == 7, "final wave uses current defenders and rounds pseudodogs up")
first.alive = false
plugin:PlayerDeath(first)
first.position = Vector(9000, 0, 0)
check(plugin:GetDefenderPosition(first):DistToSqr(Vector(0, 0, 0)) == 0,
	"dead presence uses recorded death position rather than spectator position")
local beforeAward = plugin:PendingVouchers(firstChar)
clearWave()
check(not plugin.event and plugin:PendingVouchers(firstChar) == beforeAward + 1,
	"dead but present qualified defenders earn exactly one voucher")
check(plugin:PendingVouchers(secondChar) == 1, "late arrivals can qualify by attending a later full wave")
plugin:EndDefense("duplicate", true)
check(plugin:PendingVouchers(firstChar) == beforeAward + 1, "duplicate completion cannot award twice")

resetEvent()
clients = {first}
for _ = 1, 10 do clients[#clients + 1] = newClient() end
beginWave()
check(#plugin.event.slots == 10, "scaling is capped at eight defenders")
check(plugin.event.candidates[clients[11]:GetCharacter():GetID()] ~= nil,
	"defenders beyond the scaling cap can qualify")
resetEvent()
beginWave()
capacity = false
local createdBefore = #created
plugin:UpdateDefense()
check(#created == createdBefore and plugin:RemainingAttackers() == 3, "population caps keep required slots pending")
local blockedStatus = commands.MutantDefenseStatus.OnRun()
check(blockedStatus:find("3 awaiting spawn", 1, true) and blockedStatus:find("mutant population limit", 1, true),
	"status distinguishes pending attackers blocked by population from already spawned enemies")
capacity, placement = true, false
plugin:UpdateDefense()
check(#created == createdBefore, "blocked placement keeps slots pending")
check(commands.MutantDefenseStatus.OnRun():find("no safe spawn position", 1, true),
	"status reports a placement blockage")
placement, playerNear = true, true
plugin:UpdateDefense()
check(#created == createdBefore, "nearby players prevent spawning")
playerNear = false
spawnPoint = Vector(2500, 0, 0)
plugin:UpdateDefense()
check(#created == createdBefore, "square fallback samples beyond the outer radius are rejected")
spawnPoint = Vector(500, 0, 0)
plugin:UpdateDefense()
check(#created == createdBefore, "spawns inside the inner band are rejected")
spawnPoint = nil
rejectSpawn = true
plugin:UpdateDefense()
check(plugin:RemainingAttackers() == 3 and not plugin.event.slots[1].entity,
	"registration rejection is not a completed spawn")
rejectSpawn = false
first.ixRagdoll = {GetPos = function() return Vector(0, 0, 0) end}
first.position = Vector(5000, 0, 0)
check(plugin:GetDefenderPosition(first).x == 0 and not plugin:IsLivingDefender(first),
	"Helix ragdolls retain presence but cannot hold the area alone")
first.ixRagdoll = nil
first.alive = false
ix.temp.Corpses[first] = {GetPos = function() return Vector(5, 0, 0) end}
first.observer = 4
check(plugin:GetDefenderPosition(first).x == 5 and not plugin:IsLivingDefender(first),
	"revive corpses retain presence despite chase spectator mode")
plugin:UpdateDefense()
check(commands.MutantDefenseStatus.OnRun():find("0 living defenders", 1, true),
	"status reports missing living defenders during the grace period")
now = now + plugin.settings.abandonGrace
plugin:UpdateDefense()
check(not plugin.event, "no living defenders eventually fails the event")

resetEvent()
beginWave()
first.moveType = MOVETYPE_NOCLIP
plugin:UpdateDefense()
check(not plugin.event.candidates[firstChar.id], "noclip invalidates participation")
resetEvent()
beginWave()
plugin:PrePlayerLoadedCharacter(first, secondChar, firstChar)
check(not plugin.event.candidates[firstChar.id], "character switching invalidates a wave even between updates")
resetEvent()
beginWave()
plugin:PlayerDisconnected(first)
check(not plugin.event.candidates[firstChar.id], "disconnecting invalidates full-wave credit")
resetEvent()
beginWave()
plugin:UpdateDefense()
local survivor = plugin.event.slots[1].entity
plugin:PreCleanupMap()
check(not plugin.event and survivor.invalid, "map cleanup removes surviving event attackers")
resetEvent()
now = plugin.event.started + plugin.settings.timeout
plugin:UpdateDefense()
check(not plugin.event, "overall timeout fails the event")
resetEvent()
plugin:PluginUnloaded("eventcontroller")
check(not plugin.event, "dependency unload cancels the event")
resetEvent()
plugin:OnUnload()
check(not plugin.event and ix.mutantDefense == nil, "plugin unload cancels and detaches public API")
plugin:OnLoaded()
resetEvent()
commands.MutantDefenseCancel.OnRun()
check(not plugin.event, "admin cancellation ends the event")
resetEvent()
beginWave()
clearWave()
beginWave()
clearWave()
beginWave()
for _, slot in ipairs(plugin.event.slots) do
	while not slot.entity do plugin:SpawnDefenseAttackers({first}) end
	plugin:OnNPCKilled(slot.entity)
end
plugin:PlayerDeath(first)
first.alive = false
plugin:UpdateDefense()
check(not plugin.event, "a final mutual kill can complete with no living defenders")

resetEvent()
clients = {first, second}
beginWave()
clearWave()
beforeAward = plugin:PendingVouchers(firstChar)
first.position = Vector(3000, 0, 0)
beginWave()
clearWave()
beginWave()
clearWave()
check(not plugin.event and plugin:PendingVouchers(firstChar) == beforeAward,
	"qualified characters who leave before completion receive no reward")
resetEvent()
now = plugin.event.nextWave
plugin:Think()
local rateCount = #created
plugin:Think()
check(#created == rateCount, "Think cannot spawn twice within the same update interval")
now = now + 1
plugin:Think()
check(#created == rateCount + 2, "one scheduled update creates at most two attackers")
plugin:Think()
check(#created == rateCount + 2, "per-frame Think calls do not exceed the spawn budget")
plugin:EndDefense("test finished")

-- Reward delivery is acknowledged by insertion, including bags, character changes and reconnect recovery.
inserts, timers = {}, {}
local holder, holderChar = newClient()
holderChar.inventory.full = true
plugin:AwardVoucher(holderChar)
check(plugin:PendingVouchers(holderChar) == 1 and #inserts == 0, "full inventories preserve earned vouchers")
holderChar.inventory.full = false
check(plugin:DeliverVoucher(holderChar), "stored voucher can be retried")
local additions = holderChar.inventory.additions
check(not plugin:DeliverVoucher(holderChar) and holderChar.inventory.additions == additions,
	"repeated requests cannot duplicate an in-flight insertion")
check(plugin:PendingVouchers(holderChar) == 1, "reserved inventory slot does not acknowledge delivery")
local delivered = finishInsert(nil, {})
check(plugin:PendingVouchers(holderChar) == 0, "insertion into an ownerless bag acknowledges the original character")
plugin:InventoryItemAdded(nil, holderChar.inventory, delivered)
check(plugin:PendingVouchers(holderChar) == 0, "duplicate insertion callbacks do not reduce rewards twice")
plugin:AwardVoucher(holderChar)
local messageCount = #holder.messages
holder.character = firstChar
finishInsert()
check(plugin:PendingVouchers(holderChar) == 0 and #holder.messages == messageCount,
	"late insertion updates original character without notifying a different active character")
holder.character = holderChar
holderChar.inventory.full = true
plugin:AwardVoucher(holderChar)
local restoredState = copy(holderChar.data)
holderChar.data = restoredState
plugin:PlayerLoadedCharacter(holder, holderChar)
flushTimers()
check(plugin:PendingVouchers(holderChar) == 1, "reconnecting with full inventory retains rewards")
holderChar.inventory.full = false
local token = holderChar:GetData("mutantDefenseRewards").token
holderChar.inventory.items[#holderChar.inventory.items + 1] = {
	uniqueID = "mutant_defense_voucher", GetData = function() return token end,
}
additions = holderChar.inventory.additions
plugin:PlayerLoadedCharacter(holder, holderChar)
flushTimers()
check(plugin:PendingVouchers(holderChar) == 0 and holderChar.inventory.additions == additions,
	"a saved delivery token reconciles an already inserted voucher instead of creating another")
plugin:AwardVoucher(holderChar)
plugin:AwardVoucher(holderChar)
check(#inserts == 1 and plugin:PendingVouchers(holderChar) == 2, "multiple awards serialize item creation")
finishInsert()
flushTimers()
check(#inserts == 1, "next entitlement is delivered after confirmation")
finishInsert()
check(plugin:PendingVouchers(holderChar) == 0, "all pending awards can be delivered")

local vendor = {position = Vector(0, 0, 0)}
function vendor:GetClass() return self.class or "ix_vendor_adv" end
function vendor:GetSherpa() return self.sherpa or false end
function vendor:CanAccess() return not self.denied end
function vendor:GetPos() return self.position end
holder.position = Vector(0, 0, 0)
holderChar.inventory.items = {delivered}
delivered.removed = nil
restockAllowed = false
now = now + 2
check(not plugin:RedeemVoucher(holder, vendor) and not delivered.removed,
	"full shelves keep the voucher")
restockAllowed = true
check(not plugin:RedeemVoucher(holder, vendor), "server action cooldown rejects repeated requests")
now = now + 2
check(plugin:RedeemVoucher(holder, vendor) and delivered.removed and restocks == 1,
	"one successful hand-in consumes one voucher")
now = now + 2
check(not plugin:RedeemVoucher(holder, vendor) and restocks == 1, "replayed hand-in has no item to redeem")
holderChar.inventory.items = {}
plugin:AwardVoucher(holderChar)
delivered = finishInsert()
secondChar.inventory.items = {delivered}
holderChar.inventory.items = {}
now = now + 2
check(plugin:RedeemVoucher(second, vendor), "another character may redeem a transferred voucher")
delivered.cotzDefenseRedeeming = nil
holderChar.inventory.items = {delivered}
for _, failure in ipairs({"distance", "access", "sherpa", "class", "hook", "character"}) do
	now = now + 2
	delivered.removed = nil
	holder.position = failure == "distance" and Vector(500, 0, 0) or Vector(0, 0, 0)
	vendor.denied, vendor.sherpa = failure == "access", failure == "sherpa"
	vendor.class = failure == "class" and "ix_hideout_vendor" or nil
	vendorBlocked = failure == "hook"
	holder.character = holderChar
	if failure == "character" then holder.character = nil end
	check(not plugin:RedeemVoucher(holder, vendor) and not delivered.removed, failure .. " rejects redemption")
end
holder.character, holder.position = holderChar, Vector(0, 0, 0)
vendor.denied, vendor.sherpa, vendor.class, vendorBlocked = false, false, nil, false
check(plugin:CanPlayerTradeWithVendor(nil, nil, "mutant_defense_voucher") == false,
	"vouchers cannot enter normal vendor buying or selling")
check(plugin:CanPlayerTradeWithVendor(nil, nil, "food_bread") == nil,
	"ordinary vendor trades continue through other hooks")

dofile(ROOT .. "dialogue/integrations/sh_mutantdefense.lua")
ix.dialogue.OrderOptions = function(options) return options end
local dialogue = {tree = {TradeTopic = {}, GREETING = {options = {"TradeTopic", "GOODBYE"}},
	BackTopic = {options = {"TradeTopic", "GOODBYE"}}}}
dialogue.addTopic = function(id, data) dialogue.tree[id] = data end
ix.dialogue.ConfigureMutantDefense(dialogue)
ix.dialogue.ConfigureMutantDefense(dialogue)
check(#dialogue.tree.GREETING.options == 4 and #dialogue.tree.BackTopic.options == 4,
	"dialogue installation is idempotent")
check(dialogue.tree.DefenseVoucher.response == "" and dialogue.tree.DefenseRewards.response == "",
	"voucher actions do not invent speech for silent contacts")
check(dialogue.tree.DefenseVoucher.ShouldAdd(nil, holder, vendor), "carried vouchers expose the hand-in")
vendor.sherpa = true
check(not dialogue.tree.DefenseVoucher.ShouldAdd(nil, holder, vendor), "Sherpas do not offer voucher hand-in")
vendor.sherpa = false
holderChar.inventory.full = true
plugin:AwardVoucher(holderChar)
check(dialogue.tree.DefenseRewards.ShouldAdd(nil, holder, vendor), "pending rewards expose collection")
vendor.denied = true
now = now + 2
additions = holderChar.inventory.additions
dialogue.tree.DefenseRewards.postCallback(nil, holder, vendor)
check(holderChar.inventory.additions == additions, "forged dialogue collection still checks server access")

-- Exercise the installed revive command and corpse-removing spawn hook during wave two.
local reviveFile = assert(io.open(ROOT .. "revive/sh_plugin.lua"))
local reviveSource = reviveFile:read("*a")
reviveFile:close()
local reviveSpawn = {}
local spawnStart = assert(reviveSource:find("function PLUGIN:PlayerSpawn( client )", 1, true))
local spawnEnd = assert(reviveSource:find("\n\t--[[", spawnStart, true))
local spawnSource = reviveSource:sub(spawnStart, spawnEnd - 1):gsub("!", "not ")
assert(load(spawnSource, "@revive/PlayerSpawn", "t", setmetatable({PLUGIN = reviveSpawn}, {__index = _G})))()
local commandSource = assert(reviveSource:match('ix.command.Add%("charrevive", (%b{})%)'))
local commandEnvironment = setmetatable({bit = {bor = function(a, b) return a + b end}}, {__index = _G})
ix.type = {string = 1, number = 2, optional = 4}
local reviveCommand = assert(load("return " .. commandSource, "@revive/charrevive", "t", commandEnvironment))()
math.Round = function(value) return math.floor(value + 0.5) end
ix.util.FindPlayer = function() return first end
function first:UnSpectate() self.observer = OBS_MODE_NONE end
function first:SetNWEntity() end
function first:SetNetVar(key, value)
	self.netVars = self.netVars or {}
	self.netVars[key] = value
end
function first:GetNetVar(key) return self.netVars and self.netVars[key] end
function first:SetPos(position) self.position = position end
function first:SetHealth(value) self.health = value end
function first:IsStuck() return false end
function first:GetName() return "Defender" end
function first:Spawn()
	self.alive, self.moveType = true, 2
	-- Normal loadout may place the player away from the defense before the revive restores them.
	self.position = Vector(9000, 0, 0)
	plugin:PlayerSpawn(self)
	reviveSpawn:PlayerSpawn(self)
end
resetEvent()
beginWave()
clearWave()
beginWave()
local deathPosition = Vector(20, 0, 0)
local corpse = {isDeadBody = true}
function corpse:GetPos()
	assert(not self.invalid, "revive accessed a removed corpse")
	return deathPosition
end
function corpse:Remove() self.markedForDeletion = true end
first.position, first.alive, first.observer, first.moveType = deathPosition, false, 4, MOVETYPE_OBSERVER
ix.temp.Corpses[first] = corpse
plugin:PlayerDeath(first)
plugin:UpdateDefense()
now = now + 5
reviveCommand.OnRun(reviveCommand, first, "Defender", 100)
check(first.position == deathPosition and corpse.markedForDeletion and first:Alive(),
	"charrevive restores the saved body position after Spawn schedules corpse removal")
plugin:UpdateDefense()
check(plugin.event and plugin.event.emptySince == nil and plugin:IsLivingDefender(first),
	"reviving during wave two clears abandonment even before the old corpse is deleted")
first.position = Vector(25, 0, 0)
check(plugin:GetDefenderPosition(first) == first.position,
	"living defender presence follows the revived player instead of the old corpse")
corpse.invalid = true
clearWave()
beginWave()
check(plugin.event.wave == 3 and plugin.event.phase == "fighting", "wave three starts after a wave-two revival")
local beforeRevivedSpawns = #created
plugin:UpdateDefense()
check(#created == beforeRevivedSpawns + 2, "wave three creates attackers after solo charrevive")
first.observer = 4
check(plugin:IsLivingDefender(first) and plugin:GetDefenderPosition(first) == first.position,
	"a revived walking defender is eligible even if the observer camera field remains set")
first.moveType = MOVETYPE_OBSERVER
check(not plugin:IsLivingDefender(first) and plugin:GetDefenderPosition(first) == nil,
	"actual observer movement still excludes spectators")
first.moveType, first.observer = 2, OBS_MODE_NONE
clearWave()
check(not plugin.event, "a revived solo defender can finish the event")
local emptyBody = ix.temp.Corpses[first]
ix.temp.Corpses[first] = nil
reviveCommand.OnRun(reviveCommand, first, "Defender", 100)
check(first.messages[#first.messages] == "The target is not dead, they can't be revived!",
	"charrevive safely rejects a player without a valid dead body")
ix.temp.Corpses[first] = emptyBody

print("PASS: " .. checks .. " mutant defense checks")
