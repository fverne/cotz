-- Run from the repository root: luatex --luaonly tests/progression_spec.lua
local fixture = dofile("tests/helpers/progression.lua")
local api, character = fixture.api, fixture.character
local copy, addReward = fixture.copy, fixture.addReward
local position, lostItems, callbacks = fixture.position, fixture.lostItems, fixture.callbacks
local currentMap = "rp_marsh_cs"
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local compile = loadstring or load
api.itemPools.fixture = {candidates = {{item = "artifact_bolt"}}}
for id, npc in pairs({storageFixture = "'Cleaner'", otherFixture = "Other"}) do
	api.Register(id, {keyNpc = npc, progMap = currentMap, defaultActive = true,
		requirementSlots = {{pool = "fixture", quantity = 1}}, BuildResponse = api.BuildDeliveryResponse})
end
local a, b = character(), character()
check(not pcall(api.GetCharacterProgression, nil), "owner is mandatory")
check(not pcall(api.GetCharacterProgression, {}), "owner must be a Helix character")
api.InitializeCharacterProgression(a)
api.InitializeCharacterProgression(b)
api.InitializeCharacterProgression(a)
check(a.replications == 2, "initialization and requirement assignment are idempotent")
check(not pcall(api.SetCharacterProgression, a, {lines = false}), "invalid record shape rejected")
local snapshot = api.GetCharacterProgression(a)
snapshot.lines.example = { value = 4 }
check(a.data.progression.lines.example == nil, "reads return snapshots")
api.SetCharacterProgression(a, snapshot)
snapshot.lines.example.value = 99
check(api.GetCharacterProgression(a).lines.example.value == 4, "writes copy snapshots")
check(b.data.progression.lines.example == nil, "storage is isolated")
local restored = character()
restored.data = copy(a.data)
api.InitializeCharacterProgression(restored)
check(
	restored.replications == 0 and api.GetLine(restored, "example").value == 4,
	"restore preserves stored state"
)

-- Use a one-unit fixture to isolate partial-stack consumption and payout checks.
local storageQuantity = api.definitions.storageFixture.requirementSlots[1].quantity
api.definitions.storageFixture.requirementSlots[1].quantity = 1

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
check(not api.TurnIn(a.client, target, "otherFixture", "artifact_bolt"), "wrong NPC rejected")
check(not api.TurnIn(a.client, target, "storageFixture", "invalid"), "wrong item rejected")
currentMap = "rp_waystation"
fixture.SetMap(currentMap)
check(not api.TurnIn(a.client, target, "storageFixture", "artifact_bolt"), "wrong map rejected")
currentMap = "rp_marsh_cs"
fixture.SetMap(currentMap)
local accepted, response = api.TurnIn(a.client, target, "storageFixture", "artifact_bolt")
check(accepted, "valid turn-in accepted")
check(#lostItems == 1 and lostItems[1].client == a.client, "only accepted delivery notifies its owner")
check(lostItems[1].description == "artifact_bolt x1", "lost-item notification uses consumed quantity")
check(string.find(response, "Task complete", 1, true), "completed hand-in confirms task completion")
check(
	inventoryItem.quantity == 4 and a.money == 2 and a.reputation == 1,
	"only required amount consumed and rewarded"
)
check(
	not api.TurnIn(a.client, target, "storageFixture", "artifact_bolt"),
	"duplicate turn-in rejected"
)
check(
	a.money == 2 and inventoryItem.quantity == 4 and not api.IsCompleted(b, "storageFixture"),
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
	not api.TurnIn(c.client, target, "storageFixture", "artifact_bolt"),
	"failed item removal rejected"
)
check(
	c.money == 0 and not api.IsCompleted(c, "storageFixture"),
	"failed removal gives no progress or rewards"
)
check(#lostItems == 1, "failed removal sends no lost-item notification")
inventoryItem.Remove = function(self)
	self.removed = true
end
check(
	api.TurnIn(c.client, target, "storageFixture", "artifact_bolt") and inventoryItem.removed,
	"whole-stack turn-in removes inventory item"
)

api.definitions.storageFixture.requirementSlots[1].quantity = storageQuantity

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
api.itemPools.reward_test = { candidates = { { item = "reward_test" } } }
api.Register("reward_test", {
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
check(api.TurnIn(bulk.client, rewardNPC, "reward_test", "reward_test"), "whole reward stack accepted")
for _ = 1, 10 do
	supplySplit(1)
	check(api.TurnIn(split.client, rewardNPC, "reward_test", "reward_test"), "split reward stack accepted")
	if not api.IsCompleted(split, "reward_test") then
		check(split.money == 0 and not split.reputation, "partial deliveries pay no currency or reputation")
		check(not split.inventory.rewards, "partial deliveries give no item rewards")
	end
end
check(
	bulk.money == split.money and bulk.reputation == split.reputation,
	"splitting the same quantity cannot multiply currency or reputation"
)
check(
	not api.TurnIn(split.client, rewardNPC, "reward_test", "reward_test"),
	"completed reward ledger rejects repeats"
)
check(bulk.money == 1 and bulk.reputation == 11, "completion rounds cash up once and preserves reputation")
check(not bulk.inventory.rewards, "singleton pools give money instead of items")
local ammoOwner, supplyAmmo = rewardCharacter(true)
supplyAmmo(10)
check(api.TurnIn(ammoOwner.client, rewardNPC, "reward_test", "reward_test"), "ammo default stack accepted")
check(api.IsCompleted(ammoOwner, "reward_test"), "ammo without quantity data contributes the full ammoAmount")
local moneyBeforeRepeat = split.money
api.PayCompletionRewards(split, "reward_test")
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
api.Register("reward_groups", {
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
accepted, response = api.TurnIn(groupOwner.client, rewardNPC, "reward_groups", "drug_cigarette_3")
check(accepted, "first stack accepted")
check(string.find(response, "Still needed: 2.", 1, true), "partial delivery reports remaining units")
check(groupOwner.money == 0 and not groupOwner.reputation, "unfinished group task pays nothing")
local reloadedOwner = character()
reloadedOwner.data = copy(groupOwner.data)
groupOwner = reloadedOwner
installInventory(groupOwner)
api.InitializeCharacterProgression(groupOwner)
supplyItem("drug_cigarette_3", 10)
accepted, response = api.TurnIn(groupOwner.client, rewardNPC, "reward_groups", "drug_cigarette_3")
check(accepted, "restored credit accepts remainder")
check(string.find(response, "remaining items", 1, true), "fulfilled item explains other requirements remain")
check(stocks.drug_cigarette_3.remaining == 8, "excess units remain in the submitted stack")
check(groupOwner.money == 0 and not groupOwner.inventory.rewards, "fulfilling one group pays nothing")
supplyItem("drug_cigarette_5", 3)
check(api.TurnIn(groupOwner.client, rewardNPC, "reward_groups", "drug_cigarette_5"), "last group completes task")
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
api.PayCompletionRewards(completedRestore, "reward_groups")
check(completedRestore.money == 0 and not completedRestore.inventory.rewards, "save/load cannot replay rewards")

-- Only singleton groups add extra currency in a task with mixed group sizes.
ix.item.list.reward_test = { name = "Singleton", price = 100 }
api.Register("reward_mixed", {
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
check(api.TurnIn(mixedOwner.client, rewardNPC, "reward_mixed", "reward_test"), "partial singleton accepted")
check(mixedOwner.money == 0 and not mixedOwner.inventory.rewards, "singleton bonus waits for completion")
local mixedReload = character()
mixedReload.data = copy(mixedOwner.data)
mixedOwner = mixedReload
installInventory(mixedOwner)
supplyItem("reward_test", 1)
check(api.TurnIn(mixedOwner.client, rewardNPC, "reward_mixed", "reward_test"), "restored singleton accepted")
supplyItem("drug_cigarette_3", 2)
check(api.TurnIn(mixedOwner.client, rewardNPC, "reward_mixed", "drug_cigarette_3"), "mixed task completes")
check(mixedOwner.money == 132, "singleton and alternative pools use the same sixty percent cash rate")
check(not ix.taskRewards.SelectOffer(mixedOwner, "Tester", "progression:reward_mixed", 1),
	"mixed task has no selectable supply reward")
check(not mixedOwner.inventory.rewards, "mixed task retains only its money and reputation payout")
api.definitions.reward_mixed = nil

-- Overflow remains a durable claim; no alternative is rerolled or dropped into the world.
local overflow = character()
overflow.inventory.Add = function() return false end
ix.taskRewards.CreateOffer(overflow, "overflow", "Tester", 35, "Overflow")
ix.taskRewards.SelectOffer(overflow, "Tester", "overflow", 1)
ix.taskRewards.EarnOffer(overflow, "overflow")
local pending = api.GetLine(overflow, "taskRewardClaims").pendingRewards
check(#pending == 1 and pending[1].data.quantity == 35, "full inventory preserves the exact selected reward")
check(not ix.taskRewards.ClaimNext(overflow), "full inventory cannot acknowledge an undelivered reward")
overflow.inventory.Add = addReward
check(ix.taskRewards.ClaimNext(overflow), "queued reward can be claimed after making space")
check(#overflow.inventory.rewards == 1, "retry delivers once")

api.definitions.reward_groups = nil
api.definitions.reward_test = nil
api.itemPools.reward_test = nil

api.Register("asyncFixture", {keyNpc = "Tester", progMap = currentMap, defaultActive = false,
	BuildResponse = api.BuildDeliveryResponse})
-- Helix reserves slots before its database callback; claims remain pending until confirmation.
local asyncOwner = character()
api.QueueReward(asyncOwner, "asyncFixture", {item = "medic_medkit_1"})
local reservedData
asyncOwner.inventory = {
	owner = 4242,
	Add = function(_, _, _, data) reservedData = data return 3 end,
}
check(api.ClaimRewards(asyncOwner, "asyncFixture"), "asynchronous inventory slot reserved")
check(api.GetLine(asyncOwner, "asyncFixture").claiming, "in-flight reward blocks re-entry")
check(#api.GetLine(asyncOwner, "asyncFixture").pendingRewards == 1,
	"slot reservation alone does not erase durable pending reward")
check(not api.ClaimRewards(asyncOwner, "asyncFixture"), "duplicate in-flight claim rejected")
local interruptedClaim = copy(asyncOwner.data)
local insertedItem = {GetData = function(_, key) return reservedData[key] end}
ix.char = {loaded = {[4242] = asyncOwner}}
callbacks["cotz/progression/confirm-reward"](nil, asyncOwner.inventory, insertedItem)
check(#api.GetLine(asyncOwner, "asyncFixture").pendingRewards == 0, "database insertion confirms delivery")
local claimRestored = character()
claimRestored.data = interruptedClaim
local attemptedDuplicate = 0
claimRestored.inventory = {
	GetItems = function() return {insertedItem} end,
	Add = function() attemptedDuplicate = attemptedDuplicate + 1 return true end,
}
api.InitializeCharacterProgression(claimRestored)
check(api.ClaimRewards(claimRestored, "asyncFixture"), "restored claim recognizes already inserted item")
check(attemptedDuplicate == 0, "restart between item insertion and acknowledgement cannot duplicate reward")
ix.char = nil


api.Register("numericFixture", {keyNpc = "Tester", progMap = currentMap, defaultActive = true,
	progressthresholds = {2}, progressfunctions = {}, BuildResponse = api.BuildDeliveryResponse})
local counter = character()
check(not api.SetProgressionValue(counter, "numericFixture", 0 / 0), "NaN progression rejected")
check(not api.SetProgressionValue(counter, "numericFixture", math.huge), "infinite progression rejected")
check(api.AddProgressionValue(counter, "numericFixture", 1), "numeric counter advances")
check(not api.IsCompleted(counter, "numericFixture"), "counter waits for its threshold")
check(api.AddProgressionValue(counter, "numericFixture", 1), "threshold completes")
check(not api.AddProgressionValue(counter, "numericFixture", 1), "completed counter rejects replay")
local serverApi = ix.progression
ix.progression = {definitions = serverApi.definitions}
SERVER, CLIENT = false, true
for _, library in ipairs({"sh_storage", "sh_progression", "sh_requirements", "sh_expansion", "sh_services"}) do
	dofile("gamemodes/ix_cotz/plugins/progression/libs/" .. library .. ".lua")
end
check(not ix.progression.SetCompleted and not ix.progression.SetCharacterProgression,
	"clients have no progression mutation API")
print(string.format("PASS: %d progression engine checks", checks))
