-- Current trader service and conversion regression suite.
local context = dofile("tests/helpers/townnpcs.lua")
local fixture = context.fixture
local town = ix.townNPCs
local root = "gamemodes/ix_cotz/plugins/"
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
math.Round = function(value) return math.floor(value + 0.5) end
-- Exercise the actual asynchronous conversion boundary without consuming inputs on failed insertion.
PLUGIN = town
dofile(root .. "townnpcs/libs/sv_services.lua")
local now = 2000
CurTime = function() return now end
local timers, inserts, replacements, nextFrame = {}, {}, {}, {}
timer.Simple = function(delay, callback)
	if delay == 0 then nextFrame[#nextFrame + 1] = callback else timers[#timers + 1] = callback end
end
ix.item.inventories = {}
ix.currency = {Get = tostring}
ix.dialogue.notifyMoneyLost = function() end
local converter = fixture.character()
converter.money = 100000
function converter:GetID() return 42 end
function converter:HasMoney(amount) return self.money >= amount end
function converter:TakeMoney(amount) self.money = self.money - amount end
function converter.client:SteamID64() return "test-owner" end
function converter.client:Notify(message) self.message = message end
local currentCharacter = converter
converter.client.GetCharacter = function() return currentCharacter end
converter.inventory.items = {}
function converter.inventory:GetID() return 2 end
function converter.inventory:GetItems() return self.items end
function converter.inventory:Add(id)
	if self.full then return false end
	local item = replacements[id]
	self.items[id] = item
	item.invID = 2

	return 1, 1, 2
end
local input = {id = 100, invID = 2, uniqueID = "suit_anorak", baseSuit = "suit_anorak",
	data = {durability = 37, attachments = {exteriorSlots = {}}}}
function input:GetData(key, default)
	if self.data[key] == nil then return default end

	return self.data[key]
end
function input:Remove()
	if self.failRemoval then return false end
	converter.inventory.items[self.id] = nil
	self.removed = true

	return true
end
converter.inventory.items[input.id] = input
ix.item.list.suit_anorak = {baseSuit = "suit_anorak", price = 6690}
ix.item.list.suit_anorak_anarchist = {baseSuit = "suit_anorak", price = 9000}
local function serviceVendor(name)
	return {GetDisplayName = function() return name end, GetClass = function() return "ix_vendor_adv" end,
		CanAccess = function() return true end, GetPos = function() return fixture.position end}
end
local provider = serviceVendor("'Suture'")
ix.progression.SetCompleted(converter, town:StepID("suture", town.variantUnlocks.suit_anorak_anarchist.step))
converter.money = 100000
ix.item.Instance = function(_, _, data, _, _, callback)
	inserts[#inserts + 1] = {data = table.Copy(data), callback = callback}
end
local replacementID = 200
local function acknowledge(index)
	replacementID = replacementID + 1
	local request = inserts[index]
	local item = {id = replacementID, data = request.data}
	function item:GetID() return self.id end
	function item:SetData(key, value) self.data[key] = value end
	function item:Remove()
		self.removed = true
		converter.inventory.items[self.id] = nil

		return true
	end
	replacements[item.id] = item
	request.callback(item)
	-- Match installed Helix: suit OnInstanced runs after the creation callback and resets condition.
	item.data.durability = 100
	local callbacks = nextFrame
	nextFrame = {}
	for _, callback in ipairs(callbacks) do callback() end

	return item
end
local function convert(target)
	now = now + 1

	return town:ConvertSuit(converter.client, target or provider, 100, "suit_anorak_anarchist")
end
check(not convert(serviceVendor("'Technut'")), "the former provider cannot execute Vesper's conversions")
input.data.equip = true
check(not convert(), "equipped suits cannot be consumed by conversion")
input.data.equip = false
input.data.attachments.exteriorSlots = {plate = true}
check(not convert(), "attachments must be removed before conversion")
input.data.attachments.exteriorSlots = {}
check(convert(), "an unlocked owned unequipped suit can start conversion")
check(not input.removed and converter.money == 100000, "a pending insert consumes neither suit nor money")
check(not convert(), "a duplicate request cannot start another conversion for the same input")
converter.inventory.full = true
local failed = acknowledge(1)
check(failed.removed and not input.removed and converter.money == 100000,
	"full inventory preserves the input and fee")
converter.inventory.full = false
check(convert(), "conversion can be retried after making room")
currentCharacter = {}
local switched = acknowledge(2)
check(switched.removed and not input.removed and converter.money == 100000,
	"switching character during the insert cannot charge or consume the old character's suit")
currentCharacter = converter
check(convert(), "the original character can retry")
timers[#timers]()
check(convert(), "a timed-out insert can be retried")
local late = acknowledge(3)
check(late.removed and not input.removed, "late callbacks cannot finish a replaced request")
input.failRemoval = true
local rollback = acknowledge(4)
check(rollback.removed and not input.removed and converter.money == 100000,
	"failed input removal rolls the replacement back without charging")
input.failRemoval = false
check(convert(), "a failed removal leaves the original recoverable")
local replacement = acknowledge(5)
check(input.removed and not replacement.removed and replacement.data.durability == 37,
	"successful conversion preserves condition and consumes the input once")
check(converter.money == 99100, "successful conversion charges exactly the server-calculated fee")

local storage = serviceVendor("'Ballast'")
check(not town:OpenTownStorage(converter.client, storage), "retired bank service is unavailable")
net = {Receive = function() end}
dofile(root .. "jobsystem/libs/sh_fieldtasks.lua")
ix.jobs.field.runtimeSettings = {deployForwardDistance = 24}
ix.jobs.field.enabled = true
net.Receive = function() end
dofile(root .. "jobsystem/sv_fieldactions.lua")
local courierJob = {rewardKey = "courier-before-move", numberRec = 1,
	fieldTask = {stage = "carrying", recipient = "'Egghead'", recipientMap = "rp_waystation"}}
fixture.SetMap("rp_marsh_cs")
converter.jobs = {["'Atlas'"] = courierJob}
function converter.client:Alive() return true end
function converter.client:IsRestricted() return false end
local cargoRemoved = 0
ix.jobs.field.FindCargo = function()
	return {Remove = function() cargoRemoved = cargoRemoved + 1 return true end}
end
local receiptSaved = 0
ix.jobs.field.SaveJob = function() receiptSaved = receiptSaved + 1 end
local receiver = serviceVendor("'Egghead'")
check(ix.jobs.field.GetRecipientMap(courierJob.fieldTask) == "rp_marsh_cs"
	and courierJob.fieldTask.recipientMap == "rp_waystation", "old deliveries resolve the scientist's bunker home")
check(not ix.jobs.field.DeliverToContact(converter.client, receiver, "'Atlas'", "stale-claim"),
	"relocation does not permit stale delivery claims")
check(ix.jobs.field.DeliverToContact(converter.client, receiver, "'Atlas'", courierJob.rewardKey),
	"a saved courier assignment can be handed in at the relocated scientist")
check(cargoRemoved == 1 and receiptSaved == 1 and courierJob.isCompleted,
	"the relocated hand-in consumes and saves once")
check(not ix.jobs.field.DeliverToContact(converter.client, receiver, "'Atlas'", courierJob.rewardKey),
	"the relocated delivery cannot be replayed")

print(string.format("PASS: %d approved vendor plan checks", checks))
