-- Run from the repository root: luatex --luaonly tests/vendor_plan_spec.lua
local fixture = dofile("tests/helpers/progression.lua")
local api = fixture.api
api.Notify = function() end
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
math.Round = function(value) return math.floor(value + 0.5) end
local root = "gamemodes/ix_cotz/plugins/"
PLUGIN = {}
for _, name in ipairs({"sh_00_townnpcs", "sh_catalogue", "sh_progressions", "sh_networkservices", "sv_runtime"}) do
	dofile(root .. "townnpcs/libs/" .. name .. ".lua")
end
local town = PLUGIN
ix.util.Include = function(path) return dofile(root .. "townnpcs/" .. path) end
dofile(root .. "townnpcs/sh_plugin.lua")
town:BuildProgressions()
local multipliers = {
	atlas = 1, ballast = 1, gasket = 1, haggler = 2, jitters = 1.5, mute = 2, ["old-timer"] = 3,
	["spicy-lemon"] = 1, technut = 3, brass = 2, cleaner = 3, latch = 2, spool = 3.5, spoor = 2,
	vesper = 2, wake = 1.5, boss = 3, carbon = 4, ledger = 4, quartermaster = 5, smartass = 2.5,
	suture = 5, beanstalk = 5, egghead = 3, intern = 4,
}
for slug, multiplier in pairs(multipliers) do
	local contact = town.contacts[slug]
	check(contact.difficultyMultiplier == multiplier, "spreadsheet effort multiplier: " .. slug)
	check(#contact.supplies == 0, "no starting sale supplies: " .. slug)
	for _, step in ipairs(contact.progression) do
		local definition = api.definitions[town:StepID(slug, step.id)]
		if step.kind == "delivery" then
			for index, slot in ipairs(step.requirements) do
				check(definition.requirementSlots[index].quantity == math.ceil(slot.quantity * multiplier),
					"delivery effort scales once, with whole-unit rounding")
			end
		else
			check(definition.progressthresholds[1] == math.ceil((step.target or 1) * multiplier),
				"checkpoints and field commission counts use the same effort multiplier")
		end
	end
end
check(#town.contacts["the-original"].progression == 0, "The Original has no finite progression")
check(not api.definitions["cotz/town/the-original/OR01"], "retired milestones cannot grant entitlements")
for _, variant in pairs(town.variantUnlocks) do
	check(variant.contact == "vesper", "conversion milestones belong to Vesper")
end
for _, slug in ipairs({"beanstalk", "egghead", "intern"}) do
	check(town.contacts[slug].map == "rp_marsh_cs", "researchers use the Marsh Eco Bunker")
	for _, step in ipairs(town.contacts[slug].progression) do
		for _, slot in ipairs(step.requirements or {}) do
			for _, candidate in ipairs(api.itemPools[slot.pool].candidates) do
				check(candidate.item:sub(1, 9) == "artifact_", "researcher hand-ins request artifacts")
			end
		end
	end
end
check(town.contacts.carbon.catalogue.accesscard_bunker and town.contacts.intern.catalogue.accesscard_laboratory,
	"existing working access cards have the planned sellers")
local saved = fixture.character()
local savedID = town:StepID("jitters", "JT01")
api.SetCharacterProgression(saved, {lines = {[savedID] = {active = true,
	requirements = {medic_bandage_1 = 7}, complexData = {medic_bandage_1 = 3}}}})
api.AssignActiveRequirements(saved)
check(api.GetRequirements(saved, savedID).medic_bandage_1 == 7, "new scaling preserves assigned requirements")
check(api.GetComplexProgressionValue(saved, savedID).medic_bandage_1 == 3, "partial contributions survive")

ix.jobs = {list = {}}
fixture.SetMap("rp_garbage_cotz")
local commission = "cotz/town/commission/vesper/VE02"
local progression = town:StepID("vesper", "VE02")
ix.jobs.list[commission] = {townContact = "vesper", townProgression = progression}
local owner = fixture.character()
town:InitializeTownCharacter(owner)
api.SetCompleted(owner, town:StepID("vesper", "VE01"))
owner:SetData("jobClaimsPaid", {["'Vesper'"] = 1})
town:JobCompleted(owner.client, "'Vesper'", commission)
check(api.GetProgressionValue(owner, progression) == 1 and not api.IsCompleted(owner, progression),
	"one trip advances a two-trip commission without completing it")
town:JobCompleted(owner.client, "'Vesper'", commission)
town:InitializeTownCharacter(owner)
check(api.GetProgressionValue(owner, progression) == 1, "replay and reconnect cannot count a trip twice")
owner:SetData("jobClaimsPaid", {["'Vesper'"] = 2})
town:JobCompleted(owner.client, "'Vesper'", commission)
check(api.IsCompleted(owner, progression), "a second distinct trip completes the commission")
local paid = owner.money
town:JobCompleted(owner.client, "'Vesper'", commission)
check(owner.money == paid, "repeated completion cannot repay the commission")

local interrupted = fixture.character()
town:InitializeTownCharacter(interrupted)
api.SetCompleted(interrupted, town:StepID("vesper", "VE01"))
interrupted:SetData("jobClaimsPaid", {["'Vesper'"] = 31})
local advance = api.SetProgressionValue
api.SetProgressionValue = function() error("simulated interruption") end
local completed = pcall(function() town:JobCompleted(interrupted.client, "'Vesper'", commission) end)
api.SetProgressionValue = advance
check(not completed, "fault injection interrupts advancement after journaling")
town:InitializeTownCharacter(interrupted)
town:InitializeTownCharacter(interrupted)
check(api.GetProgressionValue(interrupted, progression) == 1, "recovery applies journaled count once")
local history = fixture.character()
history:SetData("townNPCProgression", {counts = {}, pending = {
	["'The Original'"] = {identifier = "cotz/town/commission/the-original/OR02", serial = 9},
}})
town:RecoverCompletions(history)
check(history:GetData("townNPCProgression").pending["'The Original'"], "retired pending history stays inactive")

fixture.SetMap("rp_marsh_cs")
local viewer = fixture.character()
local full = {characterID = 1, name = "Scout", map = "rp_waystation", state = "travelling",
	destination = "rp_pripyat_remaster", profile = {reputation = 1000,
		leaderboardStats = {tasksCompleted = 30, taskEarnings = 10000}}}
check(not town:FilterNetworkRecord(viewer, full), "remote directory is unavailable before its unlock")
local localRecord = table.Copy(full)
localRecord.map = "rp_marsh_cs"
local redacted = town:FilterNetworkRecord(viewer, localRecord)
check(redacted.profile.reputation == 0 and not next(redacted.profile.leaderboardStats),
	"unearned reputation and activity data are removed before publication")
check(redacted.state == "unknown" and redacted.destination == "", "tracking destinations are redacted")
api.SetCompleted(viewer, town:StepID("mute", "MU11"))
redacted = town:FilterNetworkRecord(viewer, localRecord)
check(redacted.profile.leaderboardStats.tasksCompleted == 30
	and not redacted.profile.leaderboardStats.taskEarnings, "basic activity does not expose the full dossier")
api.SetCompleted(viewer, town:StepID("mute", "MU19"))
api.SetCompleted(viewer, town:StepID("mute", "MU23"))
check(town:FilterNetworkRecord(viewer, full).profile.leaderboardStats.taskEarnings == 10000,
	"earned remote and dossier services expose their fields")

ix.npctemplates = {templates = {test = {items = {stale = {nil, 100, 1, 100, 1, 1}}}}}
ix.vendorStock = {ApplyDefaults = function() end}
local profile = {template = "test", name = "'Jitters'", enforceCatalogue = true, supplies = {},
	wantedItems = {medic_bandage_1 = true, value_med_peroxide = true}}
local catalogue = {{args = {"medic_bandage_1", nil, 1, "SELLANDBUY", 1, 12, 1}}}
PLUGIN = {}
dofile(root .. "vendor_adv/libs/sh_towncontacts.lua")
PLUGIN:ConfigureTownTemplate(profile, catalogue, {})
local rows = ix.npctemplates.templates.test.items
check(not rows.stale and rows.value_med_peroxide[3] == 3, "only planned rows survive and wants start BUYONLY")
local vendor = {items = rows, receivers = {}, GetDisplayName = function() return "'Jitters'" end}
local payload
net = {Start = function() end, WriteEntity = function() end, WriteUInt = function() end,
	WriteFloat = function() end, WriteTable = function(value) payload = value end, Send = function() end}
CAMI = {PlayerHasAccess = function() return false end}
VENDOR_MODE, VENDOR_BUYONLY = 3, 3
table.IsEmpty = function(value) return next(value) == nil end
ix.vendorStock.GetItems = function(_, value) return table.Copy(value.items) end
ix.log = {Add = function() end}
local shopper = fixture.character()
shopper.inventory.Sync = function() end
dofile(root .. "dialogue/integrations/sh_trade.lua")
ix.dialogue.OpenVendor(nil, shopper.client, vendor)
check(payload.medic_bandage_1[3] == 3 and payload.value_med_peroxide[3] == 3,
	"locked purchases remain visible only as BUYONLY when also requested")
api.SetCompleted(shopper, town:StepID("jitters", town.contacts.jitters.catalogue.medic_bandage_1.step))
ix.dialogue.OpenVendor(nil, shopper.client, vendor)
check(payload.medic_bandage_1[3] == 1, "earning the purchase milestone exposes the sale mode")
check(not town:CanBuyItem(shopper, "medic_medkit_6", "'Jitters'"), "stale high-tier clinic sales remain blocked")
check(town:CanSellItem("value_med_peroxide", "'Jitters'"), "requested goods can be sold to the clinic")
check(not town:CanSellItem("ak74", "'Jitters'"), "forged sales cannot bypass the requested assortment")

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
local provider = serviceVendor("'Vesper'")
api.SetCompleted(converter, town.itemGates.suit_anorak.id)
api.SetCompleted(converter, town.serviceGates.suitVariants.id)
api.SetCompleted(converter, town:StepID("vesper", town.variantUnlocks.suit_anorak_anarchist.step))
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
local opened
ix.storage = {Open = function(client, inventory, options) opened = {client, inventory, options} end}
check(not town:OpenTownStorage(converter.client, storage), "storage access requires its own milestone")
api.SetCompleted(converter, town.serviceGates.storage.id)
converter:SetData("bankID", 51)
converter:SetData("bankW", 3)
converter:SetData("bankH", 4)
local bank = {}
ix.config = {Get = function(_, default) return default end}
function bank:SetOwner(id) self.owner = id end
function bank:SetSize(width, height) self.width, self.height = width, height end
ix.item.inventories[51] = bank
now = now + 1
check(town:OpenTownStorage(converter.client, storage), "Ballast opens earned personal storage")
check(opened[2] == bank and bank.owner == 42 and bank.width == 3 and bank.height == 4,
	"the moved service retains the existing bank and its paid dimensions")
check(opened[3].entity == storage, "storage uses the real vendor for ongoing proximity checks")

dofile(root .. "jobsystem/libs/sh_fieldtasks.lua")
local field = ix.jobs.field
field.runtimeSettings = {deployForwardDistance = 24}
field.enabled = true
net.Receive = function() end
dofile(root .. "jobsystem/sv_fieldactions.lua")
local courierJob = {rewardKey = "courier-before-move", numberRec = 1,
	fieldTask = {stage = "carrying", recipient = "'Egghead'", recipientMap = "rp_waystation"}}
converter.jobs = {["'Atlas'"] = courierJob}
function converter.client:Alive() return true end
function converter.client:IsRestricted() return false end
local cargoRemoved = 0
field.FindCargo = function()
	return {Remove = function() cargoRemoved = cargoRemoved + 1 return true end}
end
local receiptSaved = 0
field.SaveJob = function() receiptSaved = receiptSaved + 1 end
local receiver = serviceVendor("'Egghead'")
check(field.GetRecipientMap(courierJob.fieldTask) == "rp_marsh_cs"
	and courierJob.fieldTask.recipientMap == "rp_waystation", "old deliveries resolve the relocated recipient")
check(not field.DeliverToContact(converter.client, receiver, "'Atlas'", "stale-claim"),
	"relocation does not permit stale delivery claims")
check(field.DeliverToContact(converter.client, receiver, "'Atlas'", courierJob.rewardKey),
	"a saved courier assignment can be handed in at the relocated scientist")
check(cargoRemoved == 1 and receiptSaved == 1 and courierJob.isCompleted,
	"the relocated hand-in consumes and saves once")
check(not field.DeliverToContact(converter.client, receiver, "'Atlas'", courierJob.rewardKey),
	"the relocated delivery cannot be replayed")

print(string.format("PASS: %d approved vendor plan checks", checks))
