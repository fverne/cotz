-- Run from the repository root: luatex --luaonly tests/progression_spec.lua
local fixture = dofile("tests/helpers/progression.lua")
local character = fixture.character
local copy, addReward = fixture.copy, fixture.addReward
local position, lostItems, callbacks = fixture.position, fixture.lostItems, fixture.callbacks
local currentMap = "rp_marsh_cs"
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local compile = loadstring or load
ix.progression.itemPools.fixture = {candidates = {{item = "artifact_bolt"}}}
for id, npc in pairs({storageFixture = "'Cleaner'", otherFixture = "Other"}) do
	ix.progression.Register(id, {keyNpc = npc, progMap = currentMap, defaultActive = true,
		requirementSlots = {{pool = "fixture", quantity = 1}}, BuildResponse = ix.progression.BuildDeliveryResponse})
end
local a, b = character(), character()
check(not pcall(ix.progression.GetCharacterProgression, nil), "owner is mandatory")
check(not pcall(ix.progression.GetCharacterProgression, {}), "owner must be a Helix character")
ix.progression.InitializeCharacterProgression(a)
ix.progression.InitializeCharacterProgression(b)
ix.progression.InitializeCharacterProgression(a)
check(a.replications == 2, "initialization and requirement assignment are idempotent")
check(not pcall(ix.progression.SetCharacterProgression, a, {lines = false}), "invalid record shape rejected")
local snapshot = ix.progression.GetCharacterProgression(a)
snapshot.lines.example = { value = 4 }
check(a.vars.progression.lines.example == nil, "reads return snapshots")
ix.progression.SetCharacterProgression(a, snapshot)
snapshot.lines.example.value = 99
check(ix.progression.GetCharacterProgression(a).lines.example.value == 4, "writes copy snapshots")
check(b.vars.progression.lines.example == nil, "storage is isolated")
local restored = character()
restored.data = copy(a.data)
restored.vars = copy(a.vars)
ix.progression.InitializeCharacterProgression(restored)
check(
	restored.replications == 0 and ix.progression.GetLine(restored, "example").value == 4,
	"restore preserves stored state"
)

-- Use a one-unit fixture to isolate partial-stack consumption and payout checks.
local storageQuantity = ix.progression.definitions.storageFixture.requirementSlots[1].quantity
ix.progression.definitions.storageFixture.requirementSlots[1].quantity = 1

-- Turn-in requests must match NPC, map, inventory, remaining amount and owner.
currentMap = "rp_marsh_cs"
fixture.SetMap(currentMap)
a, b = character(), character()
local inventoryItem = { quantity = 5 }
function inventoryItem:GetData(key, default)
	return self[key] or default
end
function inventoryItem:SetData(key, value)
	self[key] = value
end
function inventoryItem:Remove()
	self.removed = true
end
a.inventory = {
	Add = addReward,
	HasItem = function(_, id)
		if id == "artifact_bolt" and not inventoryItem.removed then
			return inventoryItem
		end
	end,
}
local target = {
	GetClass = function()
		return "ix_vendor_adv"
	end,
	GetDisplayName = function()
		return "'Cleaner'"
	end,
	GetPos = function()
		return position
	end,
	CanAccess = function()
		return true
	end,
}
check(not ix.progression.TurnIn(a.client, target, "otherFixture", "artifact_bolt"), "wrong NPC rejected")
check(not ix.progression.TurnIn(a.client, target, "storageFixture", "invalid"), "wrong item rejected")
currentMap = "rp_waystation"
fixture.SetMap(currentMap)
check(not ix.progression.TurnIn(a.client, target, "storageFixture", "artifact_bolt"), "wrong map rejected")
currentMap = "rp_marsh_cs"
fixture.SetMap(currentMap)
local accepted, response = ix.progression.TurnIn(a.client, target, "storageFixture", "artifact_bolt")
check(accepted, "valid turn-in accepted")
check(#lostItems == 1 and lostItems[1].client == a.client, "only accepted delivery notifies its owner")
check(lostItems[1].description == "artifact_bolt x1", "lost-item notification uses consumed quantity")
check(string.find(response, "Task complete", 1, true), "completed hand-in confirms task completion")
check(
	inventoryItem.quantity == 4 and a.money == 2 and a.reputation == 1,
	"only required amount consumed and rewarded"
)
check(
	not ix.progression.TurnIn(a.client, target, "storageFixture", "artifact_bolt"),
	"duplicate turn-in rejected"
)
check(
	a.money == 2 and inventoryItem.quantity == 4 and not ix.progression.IsCompleted(b, "storageFixture"),
	"duplicate requests cannot award rewards or affect others"
)
check(#lostItems == 1, "duplicate delivery sends no lost-item notification")
check(a.saves >= 2, "assignment and turn-in both save character")

-- Inventory removal can fail; never grant progress or rewards in that case.
local c = character()
c.inventory = a.inventory
inventoryItem.quantity = 1
inventoryItem.Remove = function()
	return false
end
check(
	not ix.progression.TurnIn(c.client, target, "storageFixture", "artifact_bolt"),
	"failed item removal rejected"
)
check(
	c.money == 0 and not ix.progression.IsCompleted(c, "storageFixture"),
	"failed removal gives no progress or rewards"
)
check(#lostItems == 1, "failed removal sends no lost-item notification")
inventoryItem.Remove = function(self)
	self.removed = true
end
check(
	ix.progression.TurnIn(c.client, target, "storageFixture", "artifact_bolt") and inventoryItem.removed,
	"whole-stack turn-in removes inventory item"
)

local ammoOwner = character()
ammoOwner.inventory = a.inventory
inventoryItem.quantity = nil
inventoryItem.ammoAmount = 10
inventoryItem.removed = false
check(ix.progression.TurnIn(ammoOwner.client, target, "storageFixture", "artifact_bolt"),
	"progression accepts ammunition default quantity")
check(inventoryItem.quantity == 9 and not inventoryItem.removed,
	"progression preserves ammunition surplus after consuming one round")

ix.progression.definitions.storageFixture.requirementSlots[1].quantity = storageQuantity

-- The real reward helper prices the consumed fraction, not the whole remaining stack.
local rewardFile = assert(io.open("gamemodes/ix_cotz/schema/libs/sh_util.lua"))
local rewardSource = rewardFile:read("*a")
rewardFile:close()
math.Round = function(value)
	return math.floor(value + 0.5)
end
assert(compile(rewardSource:sub(1, assert(rewardSource:find("-- Performs", 1, true)) - 1)))()
local pricedStack = {
	quantity = 10,
	price = 100,
	GetData = function()
		return 10
	end,
	GetPrice = function()
		return 100
	end,
}
local _, partialMoney = ix.util.GetValueFromProgressionTurnin(pricedStack, 2)
local _, fullMoney = ix.util.GetValueFromProgressionTurnin(pricedStack, 10)
check(partialMoney == 12 and fullMoney == 60, "progression cash is sixty percent of consumed value")
local fullReputation = ix.util.GetValueFromProgressionTurnin(pricedStack, 10)
check(math.abs(fullReputation - 2 * (5 + 10 ^ 0.25)) < 0.000001, "reputation credit is doubled")
check(_G.value == nil, "reward calculation does not leak global mutable state")

-- Rounding credits accumulate across requests, so splitting a stack cannot multiply rewards.
ix.progression.itemPools.reward_test = { candidates = { { item = "reward_test" } } }
ix.progression.Register("reward_test", {
	keyNpc = "Tester",
	progMap = currentMap,
	defaultActive = true,
	requirementSlots = { { pool = "reward_test", quantity = 10 } },
})
local function rewardCharacter(useAmmoDefault)
	local owner = character()
	local inventoryStack
	owner.inventory = {
		Add = addReward,
		HasItem = function()
			return inventoryStack
		end,
	}
	local function supply(amount)
		inventoryStack = { quantity = 10, price = 1, remaining = amount }
		if useAmmoDefault then
			inventoryStack.quantity = nil
			inventoryStack.ammoAmount = 10
		end
		function inventoryStack:GetData()
			return useAmmoDefault and self.ammoAmount or self.remaining
		end
		function inventoryStack:GetPrice()
			local maximum = self.quantity or self.ammoAmount

			return math.Round(self.price * self:GetData("quantity", maximum) / maximum)
		end
		function inventoryStack:Remove()
			return true
		end
	end

	return owner, supply
end
local bulk, supplyBulk = rewardCharacter()
local split, supplySplit = rewardCharacter()
local rewardNPC = {
	GetClass = function()
		return "ix_vendor_adv"
	end,
	GetDisplayName = function()
		return "Tester"
	end,
	GetPos = function()
		return position
	end,
	CanAccess = function()
		return true
	end,
}
supplyBulk(10)
check(ix.progression.TurnIn(bulk.client, rewardNPC, "reward_test", "reward_test"), "whole reward stack accepted")
for _ = 1, 10 do
	supplySplit(1)
	check(ix.progression.TurnIn(split.client, rewardNPC, "reward_test", "reward_test"), "split reward stack accepted")
	if not ix.progression.IsCompleted(split, "reward_test") then
		check(split.money == 0 and not split.reputation, "partial deliveries pay no currency or reputation")
		check(not split.inventory.rewards, "partial deliveries give no item rewards")
	end
end
check(
	bulk.money == split.money and bulk.reputation == split.reputation,
	"splitting the same quantity cannot multiply currency or reputation"
)
check(
	not ix.progression.TurnIn(split.client, rewardNPC, "reward_test", "reward_test"),
	"completed reward ledger rejects repeats"
)
check(bulk.money == 1 and bulk.reputation == 11, "completion rounds cash up once and preserves reputation")
check(not bulk.inventory.rewards, "singleton pools give money instead of items")

ix.progression.definitions.reward_test.townContact = "atlas"
ix.progression.definitions.reward_test.completionCash = 9999
local townBulk, townSupply = rewardCharacter()
local townSplit, townSplitSupply = rewardCharacter()
townSupply(10)
check(ix.progression.TurnIn(townBulk.client, rewardNPC, "reward_test", "reward_test"),
	"town progression accepts the same authoritative valued hand-in")
for _ = 1, 10 do
	townSplitSupply(1)
	check(ix.progression.TurnIn(townSplit.client, rewardNPC, "reward_test", "reward_test"),
		"town progression accepts partial deliveries")
	if not ix.progression.IsCompleted(townSplit, "reward_test") then
		check(townSplit.money == 0, "town hand-in value is held until completion")
	end
end
check(townBulk.money == 1 and townSplit.money == 1 and townBulk.reputation == townSplit.reputation,
	"town payments use only accumulated value, rounded once, ignoring obsolete flat cash")
ix.progression.PayCompletionRewards(townSplit, "reward_test")
check(townSplit.money == 1, "town completion recovery cannot replay the payout")
ix.progression.definitions.reward_test.townContact = nil
ix.progression.definitions.reward_test.completionCash = nil

local ammoOwner, supplyAmmo = rewardCharacter(true)
supplyAmmo(10)
check(ix.progression.TurnIn(ammoOwner.client, rewardNPC, "reward_test", "reward_test"), "ammo default stack accepted")
check(
	ix.progression.IsCompleted(ammoOwner, "reward_test"),
	"ammo without quantity data contributes the full ammoAmount"
)
local moneyBeforeRepeat = split.money
ix.progression.PayCompletionRewards(split, "reward_test")
check(
	split.money == moneyBeforeRepeat and not split.inventory.rewards,
	"repeated completion cannot pay the singleton bonus twice"
)

-- Progression completion pays its money and reputation without a selectable supply bonus.
ix.item.list.drug_cigarette_3 = { name = "Star", quantity = 10, price = 100 }
ix.item.list.drug_cigarette_4 = { name = "Spark", quantity = 10, price = 100 }
ix.item.list.drug_cigarette_5 = { name = "Lucky Strike", quantity = 20, price = 200 }
ix.item.list.drug_cigarette_6 = { name = "Marlboro", quantity = 20, price = 200 }
local completionCalls = 0
ix.progression.Register("reward_groups", {
	keyNpc = "Tester",
	progMap = currentMap,
	defaultActive = true,
	requirementSlots = {
		{ pool = "cigarettes", quantity = 12 },
		{ pool = "premium_cigarettes", quantity = 3 },
	},
	OnComplete = function()
		completionCalls = completionCalls + 1
	end,
})
local groupOwner = character()
local stocks = {}
local function installInventory(owner)
	owner.inventory = {
		Add = addReward,
		HasItem = function(_, itemID)
			return stocks[itemID]
		end,
	}
end
local function supplyItem(itemID, quantity)
	local stock = setmetatable({ remaining = quantity }, { __index = ix.item.list[itemID] })
	function stock:GetData(_, default)
		return self.remaining or default
	end
	function stock:SetData(_, value)
		self.remaining = value
	end
	function stock:Remove()
		stocks[itemID] = nil
	end
	stocks[itemID] = stock
end
installInventory(groupOwner)
supplyItem("drug_cigarette_3", 10)
accepted, response = ix.progression.TurnIn(groupOwner.client, rewardNPC, "reward_groups", "drug_cigarette_3")
check(accepted, "first stack accepted")
check(string.find(response, "Still needed: 2.", 1, true), "partial delivery reports remaining units")
check(groupOwner.money == 0 and not groupOwner.reputation, "unfinished group task pays nothing")
local reloadedOwner = character()
reloadedOwner.data = copy(groupOwner.data)
reloadedOwner.vars = copy(groupOwner.vars)
groupOwner = reloadedOwner
installInventory(groupOwner)
ix.progression.InitializeCharacterProgression(groupOwner)
supplyItem("drug_cigarette_3", 10)
accepted, response = ix.progression.TurnIn(groupOwner.client, rewardNPC, "reward_groups", "drug_cigarette_3")
check(accepted, "restored credit accepts remainder")
check(string.find(response, "remaining items", 1, true), "fulfilled item explains other requirements remain")
check(stocks.drug_cigarette_3.remaining == 8, "excess units remain in the submitted stack")
check(groupOwner.money == 0 and not groupOwner.inventory.rewards, "fulfilling one group pays nothing")
supplyItem("drug_cigarette_5", 3)
check(
	ix.progression.TurnIn(groupOwner.client, rewardNPC, "reward_groups", "drug_cigarette_5"),
	"last group completes task"
)
check(groupOwner.money == 90, "completion pays sixty percent of all 150 currency of consumed items")
local expectedReputation = math.floor(2 * (5 + 10 ^ 0.25) * (12 / 10 + 3 / 20) + 0.5)
check(groupOwner.reputation == expectedReputation, "completion sums doubled reputation from every group")
check(not (groupOwner:GetData("taskRewardOffers", {}) or {})["progression:reward_groups"],
	"progression completion does not create a supply offer")
check(not groupOwner.inventory.rewards, "progression pays currency and reputation without selectable supplies")
check(not ix.taskRewards.SelectOffer(groupOwner, "Tester", "progression:reward_groups", 1),
	"progression supply selection is unavailable")
check(completionCalls == 1, "completion callback runs once alongside the rewards")
local completedRestore = character()
completedRestore.data = copy(groupOwner.data)
completedRestore.vars = copy(groupOwner.vars)
ix.progression.PayCompletionRewards(completedRestore, "reward_groups")
check(completedRestore.money == 0 and not completedRestore.inventory.rewards, "save/load cannot replay rewards")

-- Only singleton groups add extra currency in a task with mixed group sizes.
ix.item.list.reward_test = { name = "Singleton", price = 100 }
ix.progression.Register("reward_mixed", {
	keyNpc = "Tester",
	progMap = currentMap,
	defaultActive = true,
	requirementSlots = {
		{ pool = "cigarettes", quantity = 2 },
		{ pool = "reward_test", quantity = 2 },
	},
})
local mixedOwner = character()
installInventory(mixedOwner)
supplyItem("reward_test", 1)
check(ix.progression.TurnIn(mixedOwner.client, rewardNPC, "reward_mixed", "reward_test"), "partial singleton accepted")
check(mixedOwner.money == 0 and not mixedOwner.inventory.rewards, "singleton bonus waits for completion")
local mixedReload = character()
mixedReload.data = copy(mixedOwner.data)
mixedReload.vars = copy(mixedOwner.vars)
mixedOwner = mixedReload
installInventory(mixedOwner)
supplyItem("reward_test", 1)
check(ix.progression.TurnIn(mixedOwner.client, rewardNPC, "reward_mixed", "reward_test"), "restored singleton accepted")
supplyItem("drug_cigarette_3", 2)
check(ix.progression.TurnIn(mixedOwner.client, rewardNPC, "reward_mixed", "drug_cigarette_3"), "mixed task completes")
check(mixedOwner.money == 132, "singleton and alternative pools use the same sixty percent cash rate")
check(not ix.taskRewards.SelectOffer(mixedOwner, "Tester", "progression:reward_mixed", 1),
	"mixed task has no selectable supply reward")
check(not mixedOwner.inventory.rewards, "mixed task retains only its money and reputation payout")
ix.progression.definitions.reward_mixed = nil

-- Overflow remains a durable claim; no alternative is rerolled or dropped into the world.
local overflow = character()
overflow.inventory.Add = function() return false end
ix.taskRewards.CreateOffer(overflow, "overflow", "Tester", 35, "Overflow")
ix.taskRewards.SelectOffer(overflow, "Tester", "overflow", 1)
ix.taskRewards.EarnOffer(overflow, "overflow")
local pending = ix.progression.GetLine(overflow, "taskRewardClaims").pendingRewards
check(#pending == 1 and pending[1].data.quantity == 35, "full inventory preserves the exact selected reward")
check(not ix.taskRewards.ClaimNext(overflow), "full inventory cannot acknowledge an undelivered reward")
overflow.inventory.Add = addReward
check(ix.taskRewards.ClaimNext(overflow), "queued reward can be claimed after making space")
check(#overflow.inventory.rewards == 1, "retry delivers once")

ix.progression.definitions.reward_groups = nil
ix.progression.definitions.reward_test = nil
ix.progression.itemPools.reward_test = nil

local progressionPlugin = {}
PLUGIN = progressionPlugin
for _, name in ipairs({"computer_story", "computerprog", "hoarderprog", "noosphereprog", "communityprog"}) do
	dofile("gamemodes/ix_cotz/plugins/progression/definitions/sh_" .. name .. ".lua")
end
for _, definition in pairs(ix.progression.definitions) do
	check(not (definition.completionBenefits or {}).items, "standalone completion definitions have no gifts")
	for _, benefits in ipairs(definition.checkpointBenefits or {}) do
		check(not benefits.items, "standalone checkpoint definitions have no gifts")
	end
end

local legacyGift = character()
ix.progression.Register("removedGiftFixture", {keyNpc = "Tester", progMap = currentMap, defaultActive = false,
	BuildResponse = ix.progression.BuildDeliveryResponse})
local legacyRecord = ix.progression.GetCharacterProgression(legacyGift)
legacyRecord.lines.removedGiftFixture = {completed = true,
	pendingRewards = {{item = "medic_medkit_1", token = "old-gift"}}}
ix.progression.SetCharacterProgression(legacyGift, legacyRecord)
check(not ix.progression.QueueReward(legacyGift, "removedGiftFixture", {item = "medic_medkit_1"}),
	"progression cannot queue new gift items")
check(not ix.progression.ClaimRewards(legacyGift, "removedGiftFixture"), "old progression gifts cannot be claimed")
check(#ix.progression.GetLine(legacyGift, "removedGiftFixture").pendingRewards == 1,
	"disabling gifts retains historical pending data")
check(
	#ix.progression.GetDeliveryOptions(legacyGift, "removedGiftFixture") == 0,
	"old gifts do not expose a claim action"
)
check(
	#ix.progression.GetActiveProgressions(legacyGift, "Tester") == 0,
	"pending gifts cannot revive completed objectives"
)
ix.progression.definitions.removedGiftFixture = nil
-- Helix reserves slots before its database callback; claims remain pending until confirmation.
local asyncOwner = character()
ix.progression.QueueReward(asyncOwner, "taskRewardClaims", {item = "medic_medkit_1"})
local reservedData
asyncOwner.inventory = {
	owner = 4242,
	Add = function(_, _, _, data) reservedData = data return 3 end,
}
check(ix.progression.ClaimRewards(asyncOwner, "taskRewardClaims"), "asynchronous inventory slot reserved")
check(ix.progression.GetLine(asyncOwner, "taskRewardClaims").claiming, "in-flight reward blocks re-entry")
check(#ix.progression.GetLine(asyncOwner, "taskRewardClaims").pendingRewards == 1,
	"slot reservation alone does not erase durable pending reward")
check(not ix.progression.ClaimRewards(asyncOwner, "taskRewardClaims"), "duplicate in-flight claim rejected")
local interruptedClaim = copy(asyncOwner.vars)
local insertedItem = {GetData = function(_, key) return reservedData[key] end}
ix.char = {loaded = {[4242] = asyncOwner}}
callbacks["cotz/progression/confirm-reward"](nil, asyncOwner.inventory, insertedItem)
check(
	#ix.progression.GetLine(asyncOwner, "taskRewardClaims").pendingRewards == 0,
	"database insertion confirms delivery"
)
local claimRestored = character()
claimRestored.vars = interruptedClaim
local attemptedDuplicate = 0
claimRestored.inventory = {
	GetItems = function() return {insertedItem} end,
	Add = function() attemptedDuplicate = attemptedDuplicate + 1 return true end,
}
ix.progression.InitializeCharacterProgression(claimRestored)
check(ix.progression.ClaimRewards(claimRestored, "taskRewardClaims"), "restored claim recognizes already inserted item")
check(attemptedDuplicate == 0, "restart between item insertion and acknowledgement cannot duplicate reward")
ix.char = nil


ix.progression.Register("numericFixture", {keyNpc = "Tester", progMap = currentMap, defaultActive = true,
	progressthresholds = {2}, progressfunctions = {}, BuildResponse = ix.progression.BuildDeliveryResponse})
local counter = character()
check(not ix.progression.SetProgressionValue(counter, "numericFixture", 0 / 0), "NaN progression rejected")
check(not ix.progression.SetProgressionValue(counter, "numericFixture", math.huge), "infinite progression rejected")
check(ix.progression.AddProgressionValue(counter, "numericFixture", 1), "numeric counter advances")
check(not ix.progression.IsCompleted(counter, "numericFixture"), "counter waits for its threshold")
check(ix.progression.AddProgressionValue(counter, "numericFixture", 1), "threshold completes")
check(not ix.progression.AddProgressionValue(counter, "numericFixture", 1), "completed counter rejects replay")
local notify = ix.progression.Notify
local completionNotice
ix.progression.Notify = function(_, _, message) completionNotice = message end
for _, townContact in ipairs({false, "atlas"}) do
	local suffix = townContact or "standalone"
	local owner = character()
	owner.name = "Named Completer"
	local numericID = "namedNumeric/" .. suffix
	ix.progression.Register(numericID, {keyNpc = "Tester", progMap = currentMap, defaultActive = true,
		townContact = townContact, progressthresholds = {1}, progressfunctions = {},
		completionMessage = "Thank you."})
	ix.progression.AddProgressionValue(owner, numericID, 1)
	local numericNotice = townContact and "Thank you." or "Named Completer, Thank you."
	check(completionNotice == numericNotice,
		"numeric completions preserve authored town text and standalone addressing for " .. suffix)
	local deliveryID = "namedDelivery/" .. suffix
	ix.progression.Register(deliveryID, {keyNpc = "Tester", progMap = currentMap, defaultActive = true,
		townContact = townContact, requirementSlots = {{pool = "fixture", quantity = 1}},
		completionMessage = "Delivery received."})
	completionNotice = nil
	ix.progression.AddComplexProgressionValue(owner, deliveryID, {"artifact_bolt", 1})
	local deliveryNotice = townContact and "Delivery received." or "Named Completer, Delivery received."
	check(completionNotice == deliveryNotice,
		"delivery completions preserve authored town text and standalone addressing for " .. suffix)
end
local silentOwner = character()
local silentNotice = "** He checks the list and nods. **"
ix.progression.Register("silentDelivery", {keyNpc = "Tester", progMap = currentMap, defaultActive = true,
	townContact = "mute", requirementSlots = {{pool = "fixture", quantity = 1}},
	completionMessage = silentNotice})
ix.progression.AddComplexProgressionValue(silentOwner, "silentDelivery", {"artifact_bolt", 1})
check(completionNotice == silentNotice, "Mute's completion remains an unprefixed nonverbal reply")
ix.progression.Notify = notify

local reader, stranger = character(), character()
ix.progression.Register("discovery/first", {keyNpc = "Discovery", defaultActive = true,
	requirementSlots = {{pool = "fixture", quantity = 3}}})
ix.progression.Register("discovery/second", {keyNpc = "Discovery",
	requirementSlots = {{pool = "fixture", quantity = 5}}})
check(#ix.progression.GetKnownActiveProgressions(reader, "Discovery") == 0,
	"a new character has no discovered progression entries")
check(next(ix.progression.GetNeededItems(reader)) == nil,
	"undiscussed progression requests do not highlight inventory items")
check(next(ix.progression.GetNeededItemContacts(reader)) == nil,
	"undiscussed requests do not reveal tooltip contacts")
ix.progression.DiscoverTopics(reader, "Discovery")
check(ix.progression.GetKnownActiveProgressions(reader, "Discovery")[1] == "discovery/first",
	"discussing a contact reveals its currently active topics")
check(ix.progression.GetNeededItems(reader).artifact_bolt == 3,
	"only the discussed request contributes to progression highlighting")
check(#ix.progression.GetKnownActiveProgressions(stranger, "Discovery") == 0,
	"discovery belongs to the character")
check(next(ix.progression.GetNeededItems(stranger)) == nil,
	"another character's conversations do not reveal inventory highlights")
ix.progression.SetActive(reader, "discovery/second", true)
check(#ix.progression.GetKnownActiveProgressions(reader, "Discovery") == 1,
	"a newly unlocked topic remains hidden until discussed")
check(ix.progression.GetNeededItems(reader).artifact_bolt == 3,
	"a newly unlocked but undiscussed request does not add highlighted requirements")
ix.progression.DiscoverTopics(reader, "Discovery")
check(#ix.progression.GetKnownActiveProgressions(reader, "Discovery") == 2,
	"returning to the contact reveals the new topic")
check(ix.progression.GetNeededItems(reader).artifact_bolt == 8,
	"discussed active requests combine their remaining item counts")
local neededContacts = ix.progression.GetNeededItemContacts(reader)
check(neededContacts.artifact_bolt.Discovery and next(neededContacts.artifact_bolt, "Discovery") == nil,
	"multiple requests from the same contact produce one tooltip contact")
local reconnected = character()
reconnected.data = copy(reader.data)
reconnected.vars = copy(reader.vars)
check(#ix.progression.GetKnownActiveProgressions(reconnected, "Discovery") == 2,
	"discovery survives character restoration")
check(ix.progression.GetNeededItems(reconnected).artifact_bolt == 8,
	"discovered inventory highlights survive character restoration")
local discoveryRecord = ix.progression.GetCharacterProgression(reader)
discoveryRecord.lines["discovery/first"].complexData = {artifact_bolt = 2}
ix.progression.SetCharacterProgression(reader, discoveryRecord)
check(ix.progression.GetNeededItems(reader).artifact_bolt == 6,
	"progression highlights count only outstanding contributions")
ix.progression.SetCompleted(reader, "discovery/first")
check(ix.progression.GetNeededItems(reader).artifact_bolt == 5,
	"completed discussed requests stop contributing to inventory highlights")
ix.progression.SetCompleted(reader, "discovery/second")
check(next(ix.progression.GetNeededItems(reader)) == nil,
	"items stop being highlighted once every discussed request is complete")
check(next(ix.progression.GetNeededItemContacts(reader)) == nil,
	"completed requests stop contributing tooltip contacts")

local contactReader = character()
for id, npc in pairs({first = "Alpha", second = "Beta"}) do
	ix.progression.Register("tooltip/" .. id, {keyNpc = npc, defaultActive = true,
		requirementSlots = {{pool = "fixture", quantity = 3}},
		requirementAlternatives = {artifact_alt = "artifact_bolt"}})
	ix.progression.DiscoverTopics(contactReader, npc)
end
neededContacts = ix.progression.GetNeededItemContacts(contactReader)
check(neededContacts.artifact_bolt.Alpha and neededContacts.artifact_bolt.Beta
	and neededContacts.artifact_alt.Alpha and neededContacts.artifact_alt.Beta,
	"shared requirements and accepted alternatives retain every requesting contact")
local contactRecord = ix.progression.GetCharacterProgression(contactReader)
contactRecord.lines["tooltip/first"].complexData = {artifact_bolt = 3}
ix.progression.SetCharacterProgression(contactReader, contactRecord)
neededContacts = ix.progression.GetNeededItemContacts(contactReader)
check(not neededContacts.artifact_bolt.Alpha and neededContacts.artifact_bolt.Beta
	and not neededContacts.artifact_alt.Alpha and neededContacts.artifact_alt.Beta,
	"fulfilled contributions remove only their contact, including accepted alternatives")

local journalOwner = character()
ix.progression.Register("journalRewardsFixture", {
	name = "Workshop request", briefing = "Bring the requested supplies.", keyNpc = "'Cleaner'",
	progMap = currentMap, defaultActive = true,
	requirementSlots = {{pool = "fixture", quantity = 1}},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	vendorUnlocks = {{npc = "'Cleaner'", args = {"artifact_bolt"}}},
	stockUnlocks = {{npc = "'Cleaner'", items = {"artifact_bolt"}, bonus = 2}},
})
ix.progression.InitializeCharacterProgression(journalOwner)
local request = ix.progression.definitions.journalRewardsFixture
local journal = ix.progression.DescribeTask(request, request.keyNpc, {}, journalOwner)
local requiredAt, rewardsAt = journal:find("REQUIRED ITEMS:", 1, true), journal:find("Rewards:", 1, true)
check(requiredAt and rewardsAt and requiredAt < rewardsAt, "requirements precede a distinct Rewards section")
check(journal:find("Purchase access:", 1, true) > rewardsAt
	and journal:find("Stock capacity:", 1, true) > rewardsAt
	and journal:find("60% of the accepted hand-in value", 1, true) > rewardsAt,
	"purchase access, stock capacity and money all appear under Rewards")
check(not ix.progression.BuildDeliveryResponse(request, request.keyNpc, {}, journalOwner):find("Purchase access:", 1, true),
	"required-item text never includes purchase rewards")

ix.progression = {definitions = ix.progression.definitions}
SERVER, CLIENT = false, true
dofile("tests/helpers/character_vars.lua")
for _, library in ipairs({"sh_storage", "sh_progression", "sh_requirements", "sh_expansion", "sh_services"}) do
	dofile("gamemodes/ix_cotz/plugins/progression/libs/" .. library .. ".lua")
end
check(not ix.progression.SetCompleted and not ix.progression.SetCharacterProgression,
	"clients have no progression mutation API")
print(string.format("PASS: %d progression engine checks", checks))
