-- Run from the addon root: luatex --luaonly tests/task_rewards_spec.lua
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
SERVER, CLIENT = true, false
math.Clamp = function(value, minimum, maximum) return math.max(minimum, math.min(maximum, value)) end
table.Copy = copy
IsValid = function(value) return type(value) == "table" and not value.invalid end
istable = function(value) return type(value) == "table" end
isnumber = function(value) return type(value) == "number" end
tobool = function(value) return value == true end
local callbacks = {}
hook = {Add = function(event, _, callback) callbacks[event] = callback end,
	Run = function(event, ...) if callbacks[event] then return callbacks[event](...) end end}
timer = {Simple = function() end}
netstream = {Start = function() end}
ents = {FindByClass = function() return {} end}
game = {GetMap = function() return "rp_marsh_cs" end}
local playerMeta = {}
FindMetaTable = function() return playerMeta end
ix = {
	meta = {character = {}}, progression = {definitions = {}, itemPools = {}},
	item = {list = {}}, randomitems = {tables = {}},
	jobs = {list = {}, jobsbycategory = {}},
	dialogue = {notifyReputationReceive = function() end, notifyMoneyReceive = function() end,
		notifyItemGet = function(client, label)
			client.receivedLabels = client.receivedLabels or {}
			client.receivedLabels[#client.receivedLabels + 1] = label
		end},
	config = {Get = function(_, default) return default end},
}
local base = "gamemodes/ix_cotz/plugins/progression/"
dofile(base .. "libs/sh_storage.lua")
dofile(base .. "libs/sh_progression.lua")
ix.progression.npcRequirements["'Mute'"] = "cotz/town/old-timer/OT19"
ix.progression.npcRequirements["'Egghead'"] = "cotz/town/smartass/SM07"

dofile(base .. "libs/sh_expansion.lua")
dofile(base .. "libs/sh_services.lua")
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_taskrewards.lua")
dofile(base .. "libs/sh_rewards.lua")
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sv_taskrewards.lua")
ix.progression.AssignActiveRequirements = function() end
local api = ix.taskRewards
local meta = ix.meta.character
meta.__index = meta
function meta:GetData(key, default)
	if self.data[key] == nil then return default end

	return self.data[key]
end
function meta:SetData(key, value) self.data[key] = copy(value) end
function meta:GetInventory() return self.inventory end
function meta:GetPlayer() return self.client end
function meta:GetID() return self.id end
function meta:GetJobs() return copy(self.jobs) end
function meta:SetJobs(jobs) self.jobs = copy(jobs) end
function meta:Save() self.saves = self.saves + 1 end
function meta:GiveMoney(amount) self.money = self.money + amount end
local nextID = 0
local function actor()
	nextID = nextID + 1
	local owner = setmetatable({id = nextID, data = {}, jobs = {}, money = 0, saves = 0}, meta)
	owner.inventory = {items = {}, received = {}}
	function owner.inventory:GetItems() return self.items end
	function owner.inventory:Add(item, _, data)
		if self.full then return false end
		self.received[#self.received + 1] = {item = item, data = copy(data)}

		return true
	end
	owner.client = setmetatable({owner = owner}, {__index = playerMeta})
	function owner.client:GetCharacter() return self.owner end
	function owner.client:addReputation(amount) self.rep = (self.rep or 0) + amount end
	function owner.client:getReputation() return self.rep or 0 end
	function owner.client:Notify(text) self.message = text end
	ix.progression.InitializeCharacterProgression(owner)

	return owner
end
local function ammo(id, price, quantity)
	ix.item.list[id] = {name = id, price = price, ammoAmount = quantity, isAmmo = true}
end
ammo("12gauge", 40, 10)
ammo("22lr", 20, 10)
ammo("9x18", 30, 10)
ammo("9x19", 30, 10)
ammo("762x25", 30, 10)
ammo("45acp", 30, 10)
ammo("45acp41", 30, 10)
ix.item.list.bagrubles = {name = "Rubles", quantity = 5000000}
ix.item.list.drug_painkillers = {name = "Painkillers", price = 80, quantity = 8}
ix.randomitems.tables.ammo = {{1, {"22lr", {quantity = 5}}}, {3, {"12gauge", {quantity = 5}}}}
ix.item.list.kit_reward_demo = {name = "Old reward", items = {{{1, "ammo"}}}}
check(api.ExpectedValue("kit_reward_demo") == 17.5, "kit valuation uses weights and exact partial-stack amounts")
ix.item.list.kit_reward_nested = {items = {{{1, "nested"}}}}
ix.randomitems.tables.nested = {{1, {"kit_reward_demo"}}}
check(api.ExpectedValue("kit_reward_nested") == 17.5, "nested kits are valued without rolling contents")
ix.randomitems.tables.cycle = {{1, {"kit_reward_cycle"}}}
ix.item.list.kit_reward_cycle = {items = {{{1, "cycle"}}}}
check(not pcall(api.ExpectedValue, "kit_reward_cycle"), "cyclic kit definitions cannot recurse indefinitely")
ix.item.list.value_currency_euro = {name = "Euro", price = 52, quantity = 5000,
	GetPrice = function(self) return self.price * self:GetData("quantity", self.quantity) end}
check(api.UnitValue("value_currency_euro") == 52, "custom per-unit valuable pricing is respected")
check(api.ExpectedValue("value_currency_euro") == 52, "generated currency defaults to one note, not stack capacity")
check(api.ExpectedValue("value_currency_euro", {quantity = 3}) == 156,
	"explicit pool quantities override generated defaults")
local owner = actor()
local choices = api.BuildChoices(owner, "'Old Timer'", 75, "saved")
check(#choices == 3, "contact gets three distinct available supply choices")
local seen = {}
for _, choice in ipairs(choices) do
	local value = 0
	for _, reward in ipairs(choice.items) do value = value + api.ExpectedValue(reward.item, reward.data) end
	check(value <= 75 and value >= 74, "each choice preserves budget to within one ruble")
	check(not seen[choice.label], "choices are distinct")
	seen[choice.label] = true
end
ix.item.list.rifle = {name = "Rifle", price = 60, isWeapon = true}
ix.progression.definitions.gunGate = {vendorUnlocks = {{npc = "'Old Timer'", args = {"rifle"}}}}
local lockedChoices = api.BuildChoices(owner, "'Old Timer'", 75, "gear")
for _, choice in ipairs(lockedChoices) do
	check(choice.items[1].item ~= "rifle", "locked equipment is excluded from reward offers")
end
local earned = ix.progression.GetCharacterProgression(owner)
earned.lines.gunGate = {completed = true}
ix.progression.SetCharacterProgression(owner, earned)
local equipment = api.BuildChoices(owner, "'Old Timer'", 75, "gear")
check(equipment[#equipment].items[1].item == "rifle", "earned equipment can appear as an explicit choice")
check(#equipment[#equipment].items == 2 and equipment[#equipment].items[2].data.quantity == 15,
	"equipment choice contains one weapon and its visible budget remainder")
ix.progression.definitions.gunGate = nil
ix.item.list.medic_bandage_1 = {name = "Gauze Bandage", price = 40, quantity = 3}
ix.item.list.medic_bandage_2 = {name = "Bandage", price = 80, quantity = 5}
for tier = 1, 5 do
	for serial = 1, 30 do
		local supplies = api.BuildJobChoices(owner, "'Old Timer'", 75, "job:" .. serial)
		for _, choice in ipairs(supplies) do
			check(#choice.items >= 1 and #choice.items <= 2, "job packages contain one or two inventory items")
			local value = 0
			for _, reward in ipairs(choice.items) do
				local item = ix.item.list[reward.item]
				check(not item.isWeapon and not item.isBodyArmor, "ordinary tasks pay supplies instead of equipment")
				check(reward.data.quantity >= 1 and reward.data.quantity <= (item.quantity or item.ammoAmount),
					"job supplies stay within normal item capacity")
				value = value + api.ExpectedValue(reward.item, reward.data)
			end
			check(value <= 75, "one or two supplies respect the task budget")
		end
	end
end
local packages = api.BuildJobChoices(owner, "'Old Timer'", 75, "two-items")
local hasTwo = false
for _, choice in ipairs(packages) do if #choice.items == 2 then hasTwo = true end end
check(hasTwo, "sufficient budgets can award two items")
local stable = api.BuildJobChoices(owner, "'Old Timer'", 75, "two-items")
check(packages[1].label == stable[1].label, "saved package choices are deterministic")
local first = api.CreateOffer(owner, "persistent", "'Old Timer'", 75, "Hunt")
ix.item.list[choices[1].items[1].item].price = 999
check(api.CreateOffer(owner, "persistent", "'Old Timer'", 1000, "Changed").choices[1].label
	== first.choices[1].label, "saved choices never reroll or reprice")
check(not api.SelectOffer(owner, "'Haggler'", "persistent", 1), "another provider cannot claim the reward")
check(not api.SelectOffer(owner, "'Old Timer'", "persistent", 0), "invalid choice rejected")
check(not api.SelectOffer(owner, "'Old Timer'", "persistent", 0 / 0), "nonfinite choice rejected")
check(api.SelectOffer(owner, "'Old Timer'", "persistent", 1), "reward can be reserved")
check(#owner.inventory.received == 0, "reservation pays no items")
check(api.EarnOffer(owner, "persistent"), "completion earns the reserved reward")
check(#owner.inventory.received > 0, "reserved reward delivers on completion")
check(not api.EarnOffer(owner, "persistent"), "completion replay pays nothing")
local restored = actor()
restored.data = copy(owner.data)
check(not api.SelectOffer(restored, "'Old Timer'", "persistent", 1), "save/load cannot replay a selected reward")
local waiting = actor()
waiting.inventory.full = true
api.CreateOffer(waiting, "waiting", "'Old Timer'", 60, "Hunt")
api.SelectOffer(waiting, "'Old Timer'", "waiting", 1)
api.EarnOffer(waiting, "waiting")
local pending = ix.progression.GetLine(waiting, "taskRewardClaims").pendingRewards
check(#pending > 0, "full inventory preserves a durable queue")
check(not api.ClaimNext(waiting), "queue cannot acknowledge failed inventory insertion")
waiting.inventory.full = false
check(api.ClaimNext(waiting), "pending reward delivers after space is available")

ix.item.list.reward_bandage = {name = "Reward Bandage", quantity = 5, price = 50}
check(ix.progression.DescribeItemReward({item = "reward_bandage", data = {quantity = 2}})
	== "Reward Bandage (2 uses)", "reward labels show awarded uses rather than item capacity")
check(ix.progression.DescribeItemReward({item = "reward_bandage"}) == "Reward Bandage (5 uses)",
	"fixed reward labels include default uses")
check(ix.progression.DescribeItemReward({item = "reward_bandage", quantity = 1})
	== "Reward Bandage (1 use)", "single-use rewards use the singular label")
check(ix.progression.DescribeItemReward({item = "22lr", data = {quantity = 7}}) == "22lr (7 rounds)",
	"ammunition rewards show the awarded round count")
local useOwner = actor()
useOwner.inventory.full = true
ix.progression.QueueReward(useOwner, "uses-test", {item = "reward_bandage", data = {quantity = 2}})
check(not ix.progression.ClaimRewards(useOwner, "uses-test") and not useOwner.client.receivedLabels,
	"failed inventory insertion does not announce a received item")
useOwner.inventory.full = false
check(ix.progression.ClaimRewards(useOwner, "uses-test"), "quantity reward delivers when inventory has space")
check(useOwner.client.receivedLabels[1] == "Reward Bandage (2 uses)",
	"item-received message includes the exact awarded uses")
check(not ix.progression.ClaimRewards(useOwner, "uses-test") and #useOwner.client.receivedLabels == 1,
	"replaying a delivered claim does not repeat its item notification")
local function kit(actor, id)
	local item = {uniqueID = "kit_reward_demo", data = {}}
	function item:GetID() return id end
	function item:GetData(key, default) return self.data[key] or default end
	function item:SetData(key, value) self.data[key] = value end
	function item:Remove() actor.inventory.items[id] = nil end
	actor.inventory.items[id] = item

	return item
end
local kitOwner = actor()
kit(kitOwner, 77)
local kitChoice = api.BuildChoices(kitOwner, "'Haggler'", api.ExpectedValue("kit_reward_demo"), "kit:77")[1]
check(not api.RedeemKit(kitOwner, "'Haggler'", 77, 1, "changed"), "stale kit quote does not consume it")
check(kitOwner.inventory.items[77], "rejected redemption preserves the owned kit")
check(api.RedeemKit(kitOwner, "'Haggler'", 77, 1, kitChoice.label), "task kit redeems without paying an upgrade fee")
check(not api.RedeemKit(kitOwner, "'Haggler'", 77, 1, kitChoice.label), "same kit cannot redeem twice")
check(not api.RedeemKit(actor(), "'Haggler'", 77, 1, kitChoice.label), "other character cannot redeem an unowned kit")

ix.npcbarter = {barterdict = {["'Haggler'"] = {powder = {
	barterItem = {"kit_reward_demo", 1}, reqItem = {"powder", 2},
}}}, activebarters = {powder = true}}
local consumed = 0
ix.npcbarter.ConsumeItems = function(_, _, amount) consumed = consumed + amount return true end
local barterChoice = api.BarterChoices(kitOwner, "'Haggler'", "powder", ix.npcbarter.barterdict["'Haggler'"].powder)[1]
check(barterChoice, "kit barter exposes explicit ammunition choices")
check(not api.ExecuteBarter(kitOwner, "'Haggler'", "powder", 1, "wrong"), "stale barter quote is rejected")
check(consumed == 0, "invalid barter consumes no inputs")
check(api.ExecuteBarter(kitOwner, "'Haggler'", "powder", 1, barterChoice.label), "converted barter grants chosen ammo")
check(consumed == 2, "converted barter preserves input quantity")
ix.npcbarter.activebarters.powder = false
check(not api.ExecuteBarter(kitOwner, "'Haggler'", "powder", 1, barterChoice.label), "inactive recipe cannot execute")

-- Load the real job path with its legacy GLua operators translated for the standalone Lua runtime.
local handle = assert(io.open("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_jobs.lua"))
local source = handle:read("*a")
handle:close()
source = source:gsub("!=", "~="):gsub("!", "not ")
assert((loadstring or load)(source))()
ix.jobs.list.hunt = {name = "Hunt %d", desc = "Hunt %d mutants", numberRec = {2, 5},
	reward = {{"kit_reward_demo"}, 0}, repReward = 7, moneyReward = {10, 20}}
ix.jobs.jobsbycategory.hunting = {"hunt"}
check(api.FixedMoney(ix.jobs.list.hunt, 4) == 14, "non-delivery jobs scale their cash and supply allowance to fifty-five percent")
local hand = {price = 6700, pricepertier = 1700, name = "Swampcontroller Hand"}
function hand:GetPrice() return self.price + self.pricepertier * self:GetData("tier", 0) end
ix.item.list.part_swampcontroller_1 = hand
local delivery = {name = "Hand over %d hands", numberRec = 1, requiredItem = "part_swampcontroller_1",
	reward = {{"kit_reward_demo"}}, repReward = 5}
ix.jobs.list.hand = delivery
check(api.FixedMoney(delivery, 1) == 3350, "swampcontroller task cash is fifty percent of hand-in value")
check(api.SupplyBudget(delivery, 1) == 3685, "delivery supplies retain their previous budget despite changed cash")
check(api.FixedMoney(delivery, 3) == 10050, "cash floor covers every requested specimen")
ix.jobs.jobsbycategory.handDelivery = {"hand"}
local deliveryViewer = actor()
local deliveryPreview = api.PreviewJob(deliveryViewer, "'Old Timer'", "easy", {"handDelivery"})
local savedDeliveryChoices = copy(deliveryPreview.rewardChoices)
local savedDeliveryBudget = deliveryPreview.supplyBudget
local oldDeliveryPreviews = copy(deliveryViewer:GetData("taskJobPreviews"))
oldDeliveryPreviews["'Old Timer'"].easy.moneyReward = 3685
deliveryViewer:SetData("taskJobPreviews", oldDeliveryPreviews)
local refreshedDelivery = api.PreviewJob(deliveryViewer, "'Old Timer'", "easy", {"handDelivery"})
check(refreshedDelivery.moneyReward == 3350, "cached delivery previews refresh their cash payout")
check(refreshedDelivery.supplyBudget == savedDeliveryBudget
	and refreshedDelivery.rewardChoices[1].label == savedDeliveryChoices[1].label,
	"cash refresh preserves the saved supply budget and offered items")
check(ix.progression.HandInUnitValue("part_swampcontroller_1") == 4020,
	"progression hand cash is sixty percent of hand-in value")
local specimen = setmetatable({GetData = function(_, key, default)
	if key == "tier" then return 3 end

	return default
end}, {__index = hand})
check(api.HandInUnitValue("part_swampcontroller_1", specimen) == 11800,
	"actual specimen tier increases opportunity cost")
check(api.FixedMoney(delivery, 1, 11800) == 5900, "high-quality specimen scales the fifty percent cash payout")
ix.npctemplates = {templates = {one = {items = {part_swampcontroller_1 = {20000, nil, 3}}, scale = 0.8},
	two = {items = {part_swampcontroller_1 = {2, nil, 3}}}}}
check(api.HandInUnitValue("part_swampcontroller_1") == 16000,
	"best trader override is considered without multiplying prices between traders")
check(api.FixedMoney(delivery, 1) == 8000, "delivery cash is fifty percent of configured trader reference value")
ix.npctemplates = nil
ix.item.list.food = {name = "Food", price = 100, quantity = 5}
local foodJob = {requiredItem = "food", numberRec = 3, reward = {}, moneyReward = 0}
check(api.FixedMoney(foodJob, 3) == 30, "stacked deliveries are valued per use, not per full stack")
local foodOwner = actor()
foodOwner.jobs.NPC = {identifier = "food", numberRec = 3, progress = 0}
ix.jobs.list.food = foodJob
check(math.abs(ix.progression.HandInUnitValue("food") - 12) < 0.000001, "progression stacks are valued per consumed use")
ix.jobs.list.highFood = {requiredItem = "food", numberRec = {2, 5}, moneyReward = 2000, reward = {}}
check(math.abs(ix.progression.HandInUnitValue("food") - 12) < 0.000001,
	"old repeatable cash bonuses cannot increase the sixty percent progression rate")
ix.jobs.list.highFood = nil
local ammoJob = {requiredItem = "22lr", numberRec = 1, moneyReward = 100, reward = {}}
ix.jobs.list.ammoComparison = ammoJob
check(math.abs(ix.progression.HandInUnitValue("22lr") * ix.item.list["22lr"].ammoAmount - 12) < 0.000001,
	"progression ammunition pays sixty percent of a full box per consumed round")
ix.jobs.list.ammoComparison = nil
local food = {quantity = 5, data = {quantity = 5}, GetData = function(self, key, default)
	return self.data[key] or default
end, SetData = function(self, key, value) self.data[key] = value end,
	Remove = function(self) self.removed = true end}
function foodOwner.inventory:HasItem(id) if id == "food" then return food end end
callbacks.ix_JobTrigger = function(client)
	local jobs = client:GetCharacter():GetJobs()
	jobs.NPC.progress = jobs.NPC.progress + 1
	jobs.NPC.isCompleted = jobs.NPC.progress == jobs.NPC.numberRec
	client:GetCharacter():SetJobs(jobs)
end
ix.dialogue.notifyItemLost = function() end
check(api.DeliverJobItem(foodOwner.client, "NPC"), "delivery records consumed units")
check(food.data.quantity == 2 and not food.removed, "partial stack hand-in preserves surplus uses")
check(foodOwner:GetJobs().NPC.deliveredValue == 60 and foodOwner:GetJobs().NPC.moneyReward == 30,
	"actual hand-in value and payout are saved with progress")
check(not api.DeliverJobItem(foodOwner.client, "NPC"), "completed task cannot consume more items")
callbacks.ix_JobTrigger = nil
local gated = actor()
gated.client.rep = 249
check(not api.PreviewJob(gated, "'Old Timer'", "medium", {"hunting"}),
	"medium task preview requires at least 250 reputation")
gated.client.rep = 250
local mediumPreview = api.PreviewJob(gated, "'Old Timer'", "medium", {"hunting"})
check(mediumPreview, "medium task unlocks at exactly 250 reputation")
gated.client.rep = 249
check(not api.AcceptJob(gated.client, "'Old Timer'", "medium"),
	"saved medium preview cannot bypass a reputation drop")
gated.client.rep = 1599
check(not api.PreviewJob(gated, "'Old Timer'", "hard", {"hunting"}),
	"hard task preview requires at least 1600 reputation")
gated.client.rep = 1600
check(api.PreviewJob(gated, "'Old Timer'", "hard", {"hunting"}),
	"hard task unlocks at exactly 1600 reputation")
gated.client.rep = 1599
check(not api.AcceptJob(gated.client, "'Old Timer'", "hard"),
	"saved hard preview cannot bypass a reputation drop")
gated.client.rep = 250
check(api.AcceptJob(gated.client, "'Old Timer'", "medium"),
	"eligible player can accept the saved medium task")
local hunter = actor()
local preview = api.PreviewJob(hunter, "'Old Timer'", "easy", {"hunting"})
check(preview.moneyReward == 14, "non-delivery job cash scales its old cash and supply allowance to fifty-five percent")
check(not hunter:GetJobs()["'Old Timer'"], "preview does not accept a task")
local repeated = api.PreviewJob(hunter, "'Old Timer'", "easy", {"hunting"})
check(repeated.progressionClaim == preview.progressionClaim and repeated.numberRec == preview.numberRec
	and repeated.supplyChoice == preview.supplyChoice,
	"preview reopen preserves task identity, count and reward")
check(not api.SelectOffer(hunter, "'Old Timer'", preview.rewardKey, 1),
	"unaccepted task cannot reserve a supply through the server API")
check(not api.AcceptJob(hunter.client, "'Old Timer'", "unknown"), "unpreviewed task cannot be accepted")
check(api.AcceptJob(hunter.client, "'Old Timer'", "easy"), "acceptance binds the saved task preview")
check(hunter:GetData("taskRewardOffers")[preview.rewardKey].selected == preview.supplyChoice,
	"acceptance reserves the saved random supply")
check(not api.SelectOffer(hunter, "'Old Timer'", preview.rewardKey, 1),
	"accepted task rejects reward changes")
check(hunter:GetData("taskRewardOffers")[preview.rewardKey].selected == preview.supplyChoice,
	"rejected reward change preserves the accepted selection")
local rewardChoiceOwner = actor()
local choicePreview = api.PreviewJob(rewardChoiceOwner, "'Old Timer'", "easy", {"hunting"})
local chosenIndex = choicePreview.supplyChoice % #choicePreview.rewardChoices + 1
check(api.AcceptJob(rewardChoiceOwner.client, "'Old Timer'", "easy", chosenIndex),
	"an explicit acceptance choice is accepted")
local acceptedChoice = rewardChoiceOwner:GetJobs()["'Old Timer'"]
check(acceptedChoice.supplyChoice == chosenIndex
	and rewardChoiceOwner:GetData("taskRewardOffers")[acceptedChoice.rewardKey].selected == chosenIndex,
	"acceptance locks the chosen package rather than the preview default")
local restoredChoice = actor()
restoredChoice.data = copy(rewardChoiceOwner.data)
restoredChoice.jobs = copy(rewardChoiceOwner.jobs)
check(not api.SelectOffer(restoredChoice, "'Old Timer'", acceptedChoice.rewardKey,
	chosenIndex % #choicePreview.rewardChoices + 1), "reward locking survives save/load")
local jobs = hunter:GetJobs()
check(jobs["'Old Timer'"].numberRec == preview.numberRec, "accepted count matches the displayed count")
check(not api.AcceptJob(hunter.client, "'Old Timer'", "easy", 1), "accepted preview cannot be replayed")
jobs["'Old Timer'"].isCompleted = true
hunter:SetJobs(jobs)
hunter.client:ixJobComplete("'Old Timer'")
check(hunter.money == 14 and hunter.client.rep == 7, "job cash and reputation pay once")
check(#hunter.inventory.received >= 1 and #hunter.inventory.received <= 2, "completion delivers one or two supplies")
for _, reward in ipairs(hunter.inventory.received) do check(not reward.item:match("^kit_"), "jobs emit no kits") end
local received = #hunter.inventory.received
hunter.client:ixJobComplete("'Old Timer'")
check(hunter.money == 14 and #hunter.inventory.received == received, "job completion cannot be replayed")
local lateChoice = actor()
local latePreview = api.PreviewJob(lateChoice, "'Old Timer'", "easy", {"hunting"})
check(api.AcceptJob(lateChoice.client, "'Old Timer'", "easy"), "acceptance automatically reserves its random supply")
lateChoice.inventory.full = true
local lateJobs = lateChoice:GetJobs()
lateJobs["'Old Timer'"].isCompleted = true
lateChoice:SetJobs(lateJobs)
lateChoice.client:ixJobComplete("'Old Timer'")
check(#lateChoice.inventory.received == 0, "full inventory preserves the assigned supply for later")
lateChoice.inventory.full = false
check(api.ClaimNext(lateChoice), "assigned random supply remains claimable after the task finishes")
check(#lateChoice.inventory.received == 1, "late claim delivers the assigned item once")
check(api.SupplyBudget({moneyReward = 100, reward = {}}, 1) == 600,
	"easy tasks have a useful six-hundred-ruble minimum supply allowance")
local largerJob = {moneyReward = 10000, reward = {}}
check(api.SupplyBudget(largerJob, 1) == api.FixedMoney(largerJob, 1),
	"larger allowances use one hundred percent of reference cash")
for _, setting in ipairs({{20, 5, 1}, {40, 10, 1}, {60, 15, 2}, {80, 20, 2}, {100, 20, 2}}) do
	local checkedAmmo = false
	for seed = 1, 5 do
		local choicesByValue = api.BuildJobChoices(owner, "'Old Timer'", setting[1], "cash-scaling:" .. seed)
		for _, choice in ipairs(choicesByValue) do
			if choice.items[1].item == "12gauge" then
				checkedAmmo = true
				local total = 0
				for _, reward in ipairs(choice.items) do total = total + reward.data.quantity end
				check(total == setting[2] and #choice.items == setting[3], "cash value controls quantity and item count")
				check(choice.items[1].data.quantity == math.min(10, setting[2]),
					"cash allowance fills the first item before spilling into the second")
				if setting[1] == 60 then
					check(choice.items[2].data.quantity == 5, "remaining cash allowance fills a partial second item")
				end
			end
		end
	end
	check(checkedAmmo, "cash scaling fixture exercises an ammunition reward")
end
local savedAmmo = {}
for _, id in ipairs({"9x18", "545x39", "12gauge"}) do savedAmmo[id] = ix.item.list[id] end
ammo("9x18", 600, 60)
ammo("545x39", 1500, 60)
ammo("12gauge", 800, 30)
local quantities = {}
for _, npc in ipairs({"'Old Timer'", "'Quartermaster'"}) do
	for seed = 1, 10 do
		for _, choice in ipairs(api.BuildJobChoices(owner, npc, 600, "minimum-ammo:" .. seed)) do
			local amount = 0
			for _, reward in ipairs(choice.items) do amount = amount + reward.data.quantity end
			quantities[choice.items[1].item] = amount
		end
	end
end
check(quantities["9x18"] == 60 and quantities["545x39"] == 24 and quantities["12gauge"] == 22,
	"minimum allowance buys useful ammunition quantities at current catalogue prices")
for id, item in pairs(savedAmmo) do ix.item.list[id] = item end
local oldPreviewOwner = actor()
local oldPreview = api.PreviewJob(oldPreviewOwner, "'Old Timer'", "easy", {"hunting"})
local oldPreviews = oldPreviewOwner:GetData("taskJobPreviews")
oldPreviews["'Old Timer'"].easy.supplyBudget = 600
oldPreviews["'Old Timer'"].easy.supplyDifficulty = "easy"
oldPreviewOwner:SetData("taskJobPreviews", oldPreviews)
local oldOffers = oldPreviewOwner:GetData("taskRewardOffers")
oldOffers[oldPreview.rewardKey].choices = {{label = "Old small reward", items = {}}}
oldPreviewOwner:SetData("taskRewardOffers", oldOffers)
local upgradedPreview = api.PreviewJob(oldPreviewOwner, "'Old Timer'", "easy", {"hunting"})
check(upgradedPreview.supplyBudget == 600 and upgradedPreview.rewardKey == oldPreview.rewardKey
	and upgradedPreview.numberRec == oldPreview.numberRec, "old unaccepted previews receive larger supplies without rerolling the task")
check(oldPreviewOwner:GetData("taskRewardOffers")[oldPreview.rewardKey].choices[1].label ~= "Old small reward",
	"updated preview replaces its previously saved small package")

local bonusOwner = actor()
ix.jobs.list.bonusFixture = copy(ix.jobs.list[preview.identifier])
ix.jobs.list.bonusFixture.moneyReward = 1000
local expectedBonus = 0
local expectedByTrader = {}
local finalNPC, finalKey
for index = 1, 9 do
	local npc = index % 2 == 0 and "'Haggler'" or "'Old Timer'"
	local task = {identifier = "hunt", numberRec = 2}
	-- Use the same real completion path as accepted jobs, across both contacts.
	task.identifier = "bonusFixture"
	check(bonusOwner.client:ixJobAdd(task.identifier, npc, task), "bonus fixture accepts repeatable work")
	local active = bonusOwner:GetJobs()
	local saved = active[npc]
	check(not api.SelectOffer(bonusOwner, npc, saved.rewardKey, 1), "bonus fixture keeps its accepted reward")
	local chosen = bonusOwner:GetData("taskRewardOffers")[saved.rewardKey].choices[1]
	local suppliedValue = 0
	for _, reward in ipairs(chosen.items) do suppliedValue = suppliedValue + api.ExpectedValue(reward.item, reward.data) end
	expectedByTrader[npc] = (expectedByTrader[npc] or 0) + math.max(0, math.floor(saved.supplyBudget - suppliedValue))
	expectedBonus = expectedByTrader[npc]
	active[npc].isCompleted = true
	bonusOwner:SetJobs(active)
	bonusOwner.client:ixJobComplete(npc)
	local state = api.TraderBonusProgress(bonusOwner, npc)
	if index < 9 then
		local completed = math.ceil(index / 2)
		check(state.count == completed and state.budget == expectedBonus, "each trader keeps its own bonus progress")
		for key in pairs(bonusOwner:GetData("taskRewardOffers")) do
			check(not key:match("^bonus:"), "mixed completions do not unlock a bonus before five for one trader")
		end
	else
		check(state.count == 0 and state.budget == 0, "fifth completion starts the next cycle")
		finalNPC, finalKey = npc, "bonus:" .. saved.progressionClaim
	end
	api.RecordCompletion(bonusOwner, npc, saved)
	check(api.TraderBonusProgress(bonusOwner, npc).count == state.count, "completion replay adds no bonus progress")
end
check(api.TraderBonusProgress(bonusOwner, "'Haggler'").count == 4,
	"one trader reaching five preserves the other trader's four completions")
local bonusOffer = bonusOwner:GetData("taskRewardOffers")[finalKey]
check(bonusOffer and bonusOffer.budget == expectedBonus and bonusOffer.earned, "five jobs create the accumulated earned bonus")
check(not api.SelectOffer(bonusOwner, "'Haggler'", finalKey, 1), "another NPC cannot pay the bonus")
check(not api.SelectOffer(bonusOwner, finalNPC, finalKey, 1, "stale label"), "stale reward labels cannot select a changed offer")
local cashBefore = bonusOwner.money
check(api.SelectOffer(bonusOwner, finalNPC, finalKey, 1), "supply bonus can be claimed")
check(bonusOwner.money == cashBefore, "bonus supplies never pay cash")
check(not api.SelectOffer(bonusOwner, finalNPC, finalKey, 1), "supply bonus cannot be replayed")
for _, choice in ipairs(bonusOffer.choices) do
	check(not choice.money, "bonus choices have no cash payout")
	for _, reward in ipairs(choice.items) do
		check(reward.item ~= "bagrubles", "bonus supplies include no cash rounding remainder")
	end
end
local legacyCash = actor()
legacyCash:SetData("taskRewardOffers", {["bonus:legacy-cash"] = {npc = "'Old Timer'", earned = true,
	label = "Five-task bonus", budget = 101, choices = {{label = "Cash: 101 rubles", money = 101, items = {}}}}})
check(not api.SelectOffer(legacyCash, "'Old Timer'", "bonus:legacy-cash", 1, "Cash: 101 rubles"),
	"old saved cash selections are rejected after rebuilding bonus choices")
check(legacyCash.money == 0 and legacyCash:GetData("taskRewardOffers")["bonus:legacy-cash"].budget == 101,
	"legacy migration preserves the earned budget without paying cash")
local roundedBonus = api.BuildBonusChoices(owner, "'Old Timer'", 101, "bonus:rounding")
for _, choice in ipairs(roundedBonus) do
	for _, reward in ipairs(choice.items) do
		check(reward.item ~= "bagrubles", "uneven bonus budgets cannot add ruble items")
	end
end
local noRemainder = actor()
for serial = 1, 5 do
	local key = "job:zero:" .. serial
	local quantity = 1
	local allowance = api.UnitValue("9x18") * quantity
	noRemainder:SetData("taskRewardOffers", {[key] = {npc = "'Old Timer'", selected = 1,
		choices = {{items = {{item = "9x18", data = {quantity = quantity}}}}}}})
	api.RecordCompletion(noRemainder, "'Old Timer'", {progressionClaim = serial, rewardKey = key,
		supplyBudget = allowance, bonusContribution = 9999})
	check(api.TraderBonusProgress(noRemainder, "'Old Timer'").budget == 0,
		"fully spent allowances add nothing, including jobs saved with an old base contribution")
end
check(api.TraderBonusProgress(noRemainder, "'Old Timer'").count == 0,
	"a zero-value five-task cycle resets normally")
for key in pairs(noRemainder:GetData("taskRewardOffers")) do
	check(not key:match("^bonus:"), "zero-value cycles do not create empty bonus offers")
end
local creditOwner = actor()
local creditChoices = api.BuildBonusChoices(creditOwner, "'Old Timer'", 100, "bonus:credit")
local creditIndex = #creditChoices
check(creditChoices[creditIndex].services[1].amount == 130, "repair credit has a thirty percent face-value premium")
creditOwner:SetData("taskRewardOffers", {["bonus:credit"] = {npc = "'Old Timer'", earned = true,
	label = "Five-task bonus", budget = 100, choices = creditChoices}})
check(api.SelectOffer(creditOwner, "'Old Timer'", "bonus:credit", creditIndex), "repair credit bonus can be claimed")
check(ix.progression.GetServiceCredit(creditOwner, "'Technut'", "repair") == 130,
	"bonus credit goes to Technut even when earned at another contact")
check(not api.SelectOffer(creditOwner, "'Old Timer'", "bonus:credit", creditIndex), "credit bonus cannot be replayed")
creditOwner:SetData("progressionServiceCredits", {["'Technut'/repair"] = 19900})
local capacityChoices = api.BuildBonusChoices(creditOwner, "'Old Timer'", 100, "bonus:cap")
for _, choice in ipairs(capacityChoices) do check(not choice.services, "insufficient credit capacity hides the credit choice") end
creditOwner:SetData("progressionServiceCredits", {["'Technut'/repair"] = 0})
creditOwner:SetData("taskRewardOffers", {["bonus:cap"] = {npc = "'Old Timer'", earned = true,
	label = "Five-task bonus", budget = 100, choices = creditChoices}})
creditOwner:SetData("progressionServiceCredits", {["'Technut'/repair"] = 19900})
api.SelectOffer(creditOwner, "'Old Timer'", "bonus:cap", creditIndex)
check(ix.progression.GetServiceCredit(creditOwner, "'Technut'", "repair") == 19900
	and creditOwner:GetData("taskRewardOffers")["bonus:cap"], "capacity changes preserve the whole unclaimed bonus")
check(api.SelectOffer(creditOwner, "'Old Timer'", "bonus:cap", 1), "a blocked credit claim can choose supplies instead")
ix.item.list.advancedAmmo = {name = "Advanced ammunition", isAmmo = true, price = 100, ammoAmount = 10}
ix.progression.definitions.supplyGate = {vendorUnlocks = {{npc = "'Old Timer'", args = {"advancedAmmo"}}}}
local catalogue = api.SupplyCatalogue(creditOwner, "'Old Timer'")
local function includes(list, value)
	for _, entry in ipairs(list) do if entry == value then return true end end

	return false
end
check(includes(catalogue, "advancedAmmo"), "all consumable rewards are available before purchase unlocks")
local unlockRecord = ix.progression.GetCharacterProgression(creditOwner)
unlockRecord.lines.supplyGate = {completed = true}
ix.progression.SetCharacterProgression(creditOwner, unlockRecord)
check(includes(api.SupplyCatalogue(creditOwner, "'Old Timer'"), "advancedAmmo"), "earned unlocks expand the supply catalogue")
local fixedAllowance = api.SupplyBudget(ix.jobs.list[preview.identifier], preview.numberRec)
check(fixedAllowance == preview.supplyBudget, "equipment unlocks do not increase the allowance for the same work")
ix.progression.definitions.supplyGate = nil
local harder = {moneyReward = 10000, reward = {}}
check(api.SupplyBudget(harder, 1) > fixedAllowance, "more valuable work contributes more toward the bonus")
local resumed = actor()
resumed.data = copy(hunter.data)
check(api.BonusStatus(resumed, "'Old Timer'") == api.BonusStatus(hunter, "'Old Timer'"), "partial bonus progress survives character restoration")

local legacyBonus = actor()
legacyBonus:SetData("taskCompletionBonus", {count = 3, budget = 150,
	claims = {["'Old Timer'"] = 4, ["'Haggler'"] = 7}})
check(api.TraderBonusProgress(legacyBonus, "'Haggler'").count == 3,
	"legacy partial progress is preserved at its most recently credited trader")
check(not api.TraderBonusProgress(legacyBonus, "'Old Timer'").count,
	"legacy partial progress is not duplicated across traders")
api.RecordCompletion(legacyBonus, "'Old Timer'", {identifier = preview.identifier, numberRec = 2,
	progressionClaim = 8, rewardKey = "job:8", bonusContribution = 20})
check(api.TraderBonusProgress(legacyBonus, "'Haggler'").budget == 150
	and api.TraderBonusProgress(legacyBonus, "'Old Timer'").count == 1,
	"first new completion migrates legacy value without combining trader progress")

-- The real dialogue path sends a server-owned preview; server return values alone are not a UI response.
CurTime = function() return 100 end
local packets, receivers, packet = {}, {}, nil
util = {AddNetworkString = function() end}
net = {
	Start = function(name) packet = {name = name, values = {}} end,
	Send = function() packets[#packets + 1] = packet end,
	Receive = function(name, callback) receivers[name] = callback end,
}
for _, method in ipairs({"WriteEntity", "WriteString", "WriteUInt"}) do
	net[method] = function(value) packet.values[#packet.values + 1] = value end
end
ix.gui = {}
ix.util = {Include = function(filename) dofile("gamemodes/" .. filename) end}
dofile("gamemodes/ix_cotz/plugins/dialogue/libs/sh_dialogue.lua")
local dialogue = {tree = {GREETING = {options = {"GOODBYE"}},
	BackTopic = {options = {"GOODBYE"}}, GetTaskByDifficulty = {}}}
dialogue.addTopic = function(id, data) dialogue.tree[id] = data end
ix.dialogue.ConfigureTaskRewards(dialogue)
check(dialogue.tree.GREETING.options[1] == "TaskRewardChoices"
	and dialogue.tree.GREETING.options[2] == "GOODBYE", "reward menu keeps goodbye last")
local viewer = actor()
local position = {DistToSqr = function() return 0 end}
function viewer.client:GetPos() return position end
local target = {GetClass = function() return "ix_vendor_adv" end,
	CanAccess = function() return true end, GetPos = function() return position end,
	GetDisplayName = function() return "'Old Timer'" end,
	GetNetVar = function() return {easy = {"hunting"}} end}
check(not dialogue.tree.TaskRewardChoices.ShouldAdd(nil, viewer.client, target),
	"traders without a work submenu hide empty task reward entries")
local rootRewardOwner = actor()
rootRewardOwner:SetData("taskRewardOffers", {["bonus:root"] = {npc = "'Old Timer'", earned = true,
	label = "Five-task bonus", budget = 100, choices = {{label = "Supplies", items = {}}}}})
check(dialogue.tree.TaskRewardChoices.ShouldAdd(nil, rootRewardOwner.client, target),
	"traders without a work submenu still expose relevant earned rewards")
local unrelatedRoot = {GetDisplayName = function() return "'Jitters'" end}
check(not dialogue.tree.TaskRewardChoices.ShouldAdd(nil, rootRewardOwner.client, unrelatedRoot),
	"a bonus at another trader does not expose task rewards at Jitters")
dialogue.tree.GetTaskByDifficulty.preCallback(nil, viewer.client, target)
local listPacket = packets[1].values
check(packets[1].name == "cotz/dialogue/task-list" and listPacket[1] == target and listPacket[2] == 1,
	"work menu sends actual offers only for configured categories")
check(listPacket[3] == "easy" and listPacket[4]:find("Hunt ", 1, true)
	and listPacket[4]:find("rubles", 1, true) and not listPacket[4]:find("reputation", 1, true)
	and not listPacket[4]:find("Reward:", 1, true), "task row shows requirement and cash without repeating rewards")
viewer.client.cotzTaskRewardNext = nil
dialogue.tree.GetTaskByDifficulty.preCallback(nil, viewer.client, target)
check(packets[2].values[4] == listPacket[4], "reopening the work menu preserves the offered task and rewards")
viewer.client.cotzTaskRewardNext = nil
dialogue.tree.GetTaskByDifficulty.ResolveDynamicOption(nil, viewer.client, target, {difficulty = "easy"})
check(packets[3].name == "cotz/dialogue/task-offer", "choosing a listed task sends its authoritative preview")
check(not viewer:GetJobs()["'Old Timer'"], "network preview has no task acceptance side effect")
local previewPacket = packets[3].values
check(previewPacket[1] == target and previewPacket[2] == "easy" and previewPacket[4] >= 1,
	"preview reveals exactly one random supply")
local shownPreview = viewer:GetData("taskJobPreviews")["'Old Timer'"].easy
local shownOffer = viewer:GetData("taskRewardOffers")[shownPreview.rewardKey]
check(previewPacket[5] == shownOffer.choices[1].label,
	"confirmation shows the exact supply randomly assigned by the server")
check(not previewPacket[3]:find("reputation", 1, true) and previewPacket[3]:find("rubles", 1, true),
	"confirmation keeps cash visible and hides reputation")
local displayedSupply = previewPacket[5]
check(not previewPacket[3]:find(displayedSupply, 1, true)
	and previewPacket[3]:find("Choose your reward below.", 1, true),
	"confirmation leaves reward packages in acceptance options without repeating them")
check(not previewPacket[3]:find("restock", 1, true) and not listPacket[4]:find("restock", 1, true),
	"task reward text does not mention vendor restocking")
local otherSupply = shownPreview.supplyChoice % #shownOffer.choices + 1
check(not api.AcceptJob(viewer.client, "'Old Timer'", "easy", 999),
	"acceptance rejects an invalid supply choice")
local multiViewer = actor()
multiViewer.client.rep = 1600
function multiViewer.client:GetPos() return position end
local multiTarget = {GetClass = target.GetClass, CanAccess = target.CanAccess,
	GetPos = target.GetPos, GetDisplayName = target.GetDisplayName,
	GetNetVar = function() return {easy = {"hunting"}, medium = {"hunting"}, hard = {"hunting"}} end}
dialogue.tree.GetTaskByDifficulty.preCallback(nil, multiViewer.client, multiTarget)
local multiPacket = packets[#packets].values
check(multiPacket[2] == 3 and multiPacket[3] == "easy" and multiPacket[5] == "medium"
	and multiPacket[7] == "hard", "each configured category contributes a concrete task offer")
for _, threshold in ipairs({{249, 1}, {250, 2}, {1599, 2}, {1600, 3}}) do
	multiViewer.client.rep = threshold[1]
	multiViewer.client.cotzTaskRewardNext = nil
	dialogue.tree.GetTaskByDifficulty.preCallback(nil, multiViewer.client, multiTarget)
	check(packets[#packets].values[2] == threshold[2],
		"work menu sends only difficulties unlocked at reputation " .. threshold[1])
end
check(not multiViewer:GetJobs()["'Old Timer'"], "preparing all category offers does not accept a job")
local workDialogue = {tree = {
	GREETING = {options = {"TaskRewardChoices", "AboutWorkTopic", "GOODBYE"}},
	BackTopic = {options = {"TaskRewardChoices", "AboutWorkTopic", "GOODBYE"}},
	AboutWorkTopic = {options = {"BackTopic"}, ShouldAdd = function() return false end},
}}
workDialogue.addTopic = function(id, data) workDialogue.tree[id] = data end
ix.dialogue.ConfigureTaskRewards(workDialogue)
for _, id in ipairs({"GREETING", "BackTopic"}) do
	for _, option in ipairs(workDialogue.tree[id].options) do
		check(option ~= "TaskRewardChoices", "work-capable NPC main menu does not list supplies")
	end
end
check(workDialogue.tree.AboutWorkTopic.options[1] == "TaskRewardChoices"
	and workDialogue.tree.AboutWorkTopic.options[2] == "BackTopic",
	"supplies live under About work before its back option")
check(workDialogue.tree.TaskRewardChoices.options[1] == "BackTopic",
	"supplies always provide a main-menu return even when work becomes unavailable")
check(not workDialogue.tree.AboutWorkTopic.ShouldAdd(nil, viewer.client, target),
	"unaccepted previews do not expose reward actions in the work menu")
local hiddenChoices = workDialogue.tree.TaskRewardChoices.GetDynamicOptions(nil, viewer.client, target)
check(#hiddenChoices == 0, "unaccepted previews are absent from the supplies menu")
viewer.client.cotzTaskPreview = {difficulty = "easy", choices = {{label = "Preview supplies"}}}
local confirmation = dialogue.tree.ConfirmSupplyTask.GetDynamicOptions(nil, viewer.client)
check(#confirmation == 2 and confirmation[1].statement == "Accept — Preview supplies"
	and confirmation[1].dyndata.choice == 1, "acceptance screen displays one assigned supply without a choice index")
check(not api.AcceptJob(viewer.client, "'Old Timer'", "easy", 900),
	"invalid preview supply choice cannot accept a job")
check(not viewer:GetJobs()["'Old Timer'"], "invalid preview choice leaves the task unaccepted")
check(api.AcceptJob(viewer.client, "'Old Timer'", "easy"), "preview can be accepted with its random supply")
check(viewer:GetData("taskRewardOffers")[viewer:GetJobs()["'Old Timer'"].rewardKey].selected == shownPreview.supplyChoice,
	"random supply is reserved after the task is accepted")
check(workDialogue.tree.TaskRewardChoices.ShouldAdd(nil, viewer.client, target),
	"accepted jobs expose supply choices")
check(not workDialogue.tree.AboutWorkTopic.ShouldAdd(nil, viewer.client, target),
	"accepted jobs do not expose reward changes through About work")
check(#workDialogue.tree.TaskRewardChoices.GetDynamicOptions(nil, viewer.client, target) == 0,
	"accepted rewards are absent from claim choices")
local noWork = actor()
check(not workDialogue.tree.AboutWorkTopic.ShouldAdd(nil, noWork.client, target),
	"work menu keeps its original visibility when there are no reward actions")
check(not api.CreateOffer(viewer, "progression:menu-test", "'Old Timer'", 75, "Progression task"),
	"new progression supply offers cannot be created")
local forgedOffers = copy(viewer:GetData("taskRewardOffers", {}))
forgedOffers["progression:menu-test"] = {npc = "'Old Timer'", label = "Progression task", earned = true,
	choices = {{label = "Old supplies", items = {{item = "medic_bandage_1", data = {quantity = 3}}}}}}
viewer:SetData("taskRewardOffers", forgedOffers)
local menuOptions = dialogue.tree.TaskRewardChoices.GetDynamicOptions(nil, viewer.client, target)
local hasRepeatable = false
for _, option in ipairs(menuOptions) do
	if option.dyndata.kind == "offer" then
		check(option.dyndata.key:match("^job:"), "task supplies menu excludes progression offers")
		hasRepeatable = true
	end
end
check(not hasRepeatable, "accepted task rewards remain locked in the claim menu")
viewer.client.cotzTaskRewardNext = nil
dialogue.tree.TaskRewardChoices.ResolveDynamicOption(nil, viewer.client, target,
	{kind = "offer", key = "progression:menu-test", choice = 1})
check(not viewer:GetData("taskRewardOffers")["progression:menu-test"].selected,
	"task supplies endpoint rejects forged progression selections")
ix.progression.definitions["menu-test"] = {id = "menu-test", name = "Progression task",
	keyNpc = "'Old Timer'", progMap = "*", defaultActive = false}
local menuRecord = ix.progression.GetCharacterProgression(viewer)
menuRecord.lines["menu-test"] = {completed = true}
ix.progression.SetCharacterProgression(viewer, menuRecord)
local ownOptions = ix.progression.GetDeliveryOptions(viewer, "menu-test")
check(#ownOptions == 0, "progression task dialogue has no selectable supply rewards")
check(not ix.progression.TurnIn(viewer.client, target, "menu-test", "supply:1"),
	"progression dialogue rejects old supply selections")
ix.progression.definitions["menu-test"] = nil
local scheduledClaims = {}
timer.Simple = function(_, callback) scheduledClaims[#scheduledClaims + 1] = callback end
local packageOwner = actor()
ix.progression.QueueReward(packageOwner, "taskRewardClaims", {item = "medic_bandage_1"})
ix.progression.QueueReward(packageOwner, "taskRewardClaims", {item = "medic_bandage_1"})
check(api.ClaimNext(packageOwner) and #scheduledClaims == 1,
	"jobsystem schedules continuation after the first supply claim")
scheduledClaims[1]()
check(#packageOwner.inventory.received == 2 and #scheduledClaims == 1,
	"jobsystem drains the package and stops when the claim queue is empty")
ix.progression.QueueReward(packageOwner, "story-claim", {item = "medic_bandage_1"})
ix.progression.QueueReward(packageOwner, "story-claim", {item = "medic_bandage_1"})
ix.progression.ClaimRewards(packageOwner, "story-claim")
check(#scheduledClaims == 1 and #ix.progression.GetLine(packageOwner, "story-claim").pendingRewards == 1,
	"job supply continuation leaves progression claims player-driven")
timer.Simple = function() end

SERVER, CLIENT = false, true
dofile("gamemodes/ix_cotz/plugins/jobsystem/integrations/sh_dialogue.lua")
local activePacket = previewPacket
local offset = 0
local function read()
	offset = offset + 1

	return activePacket[offset]
end
net.ReadEntity, net.ReadString, net.ReadUInt = read, read, read
local opened
ix.gui.dialogue = {target = target, tree = {ConfirmSupplyTask = {}},
	startTopic = function(_, topic, data) opened = {topic = topic, data = data} end}
receivers["cotz/dialogue/task-offer"]()
check(opened.topic == "ConfirmSupplyTask" and #opened.data.choices == previewPacket[4],
	"client displays authoritative preview with every choice")
local catalogueReader = actor()
LocalPlayer = function() return catalogueReader.client end
local displayedOptions, cleared
ix.gui.dialogue = {target = target, currentTopicID = "GetTaskByDifficulty",
	tree = {GetTaskByDifficulty = dialogue.tree.GetTaskByDifficulty},
	options = {Clear = function() cleared = true end},
	prepareDynamicOptions = function(_, options) displayedOptions = options end}
activePacket, offset = listPacket, 0
receivers["cotz/dialogue/task-list"]()
local listed = dialogue.tree.GetTaskByDifficulty.GetDynamicOptions(nil, catalogueReader.client, target)
check(cleared and #displayedOptions == 1 and #listed == 1 and listed[1].statement == listPacket[4],
	"client replaces difficulty labels with the authoritative task and reward row")
check(listed[1].dyndata.difficulty == "easy", "listed task retains its saved category for acceptance")
check(#dialogue.tree.GetTaskByDifficulty.GetDynamicOptions(nil, catalogueReader.client, {GetDisplayName = function() return "Other NPC" end}) == 0,
	"another NPC cannot display a cached task list")
catalogueReader.client.cotzTaskList.options = {
	{dyndata = {difficulty = "easy"}}, {dyndata = {difficulty = "medium"}}, {dyndata = {difficulty = "hard"}},
}
catalogueReader.client.rep = 249
check(#dialogue.tree.GetTaskByDifficulty.GetDynamicOptions(nil, catalogueReader.client, target) == 1,
	"client hides cached medium and hard tasks after reputation drops")
catalogueReader.client.rep = 250
check(#dialogue.tree.GetTaskByDifficulty.GetDynamicOptions(nil, catalogueReader.client, target) == 2,
	"client shows medium but hides hard tasks at 250 reputation")
math.Round = function(value) return math.floor(value + 0.5) end
ITEM = {functions = {}}
dofile("gamemodes/ix_cotz/schema/items/base/sh_sharpeningstones.lua")
local stoneBase = copy(ITEM)
local stoneIDs = {"sharpening_stone", "sharpening_stone_fine"}
for _, itemID in ipairs(stoneIDs) do
	ITEM = copy(stoneBase)
	dofile("gamemodes/ix_cotz/schema/items/sharpeningstones/sh_" .. itemID .. ".lua")
	ix.item.list[itemID] = ITEM
end
ix.progression.definitions.stonePurchase = {
	vendorUnlocks = {{npc = "'Old Timer'", args = {"sharpening_stone"}},
		{npc = "'Old Timer'", args = {"sharpening_stone_fine"}}},
}
local stoneRecipient = actor()
for _, itemID in ipairs(stoneIDs) do
	check(includes(api.SupplyCatalogue(stoneRecipient, "'Old Timer'"), itemID),
		"ungated standalone supply profiles can offer stones")
	check(not ix.progression.CanBuyItem(stoneRecipient, "'Old Timer'", itemID),
		"the purchase gate remains authoritative")
end
local stoneRecord = ix.progression.GetCharacterProgression(stoneRecipient)
stoneRecord.lines.stonePurchase = {completed = true}
ix.progression.SetCharacterProgression(stoneRecipient, stoneRecord)
local stoneOffers = {}
for _, itemID in ipairs(stoneIDs) do
	check(includes(api.SupplyCatalogue(stoneRecipient, "'Old Timer'"), itemID),
		"unlocked sharpening stones are eligible task supplies")
end
for seed = 1, 30 do
	for _, choice in ipairs(api.BuildJobChoices(stoneRecipient, "'Old Timer'", 600, "stones:" .. seed)) do
		local itemID = choice.items[1].item
		if includes(stoneIDs, itemID) then
			stoneOffers[itemID] = true
			check(#choice.items == 2, "task budget awards two sharpening stones")
			local value = 0
			for _, reward in ipairs(choice.items) do
				check(reward.data.quantity == 3, "task reward stones each have three uses")
				value = value + api.ExpectedValue(reward.item, reward.data)
			end
			check(value <= 600, "sharpening stone rewards respect the task supply budget")
		end
	end
end
for _, itemID in ipairs(stoneIDs) do
	check(stoneOffers[itemID], "generated task choices offer " .. itemID)
end
local supplyOwner = actor()
ix.item.list.medic_medkit_2 = {name = "Medical Syrette Kit", price = 740, quantity = 2}
ix.item.list.medic_antirad_1 = {name = "Old antirad", price = 850, quantity = 2}
ix.item.list.drug_caffeine = {name = "Caffeine", price = 760, quantity = 4}
ix.item.list.medic_antipsychotic_1 = {name = "Asenapine", price = 450, quantity = 8}
ix.item.list.attachment_reward_test = {name = "Plate", price = 50, quantity = 2}
ix.item.list.hidestasher_reward_test = {name = "Tool", price = 50, quantity = 2}
ix.item.list.hidestash_1 = {name = "Note", price = 50}
ix.item.list.rewardEquipment = {name = "Equipment", price = 50, quantity = 2}
ix.item.list.medic_locked_reward_test = {name = "Advanced aid", price = 100, quantity = 2}
ix.progression.definitions.earlySupplyTest = {vendorUnlocks = {
	{npc = "'Jitters'", args = {"medic_medkit_2"}},
	{npc = "'Jitters'", args = {"medic_antirad_1"}},
	{npc = "'Jitters'", args = {"drug_painkillers"}},
	{npc = "'Jitters'", args = {"medic_locked_reward_test"}},
	{npc = "'Jitters'", args = {"attachment_reward_test"}},
	{npc = "'Jitters'", args = {"hidestasher_reward_test"}},
	{npc = "'Jitters'", args = {"hidestash_1"}},
	{npc = "'Jitters'", args = {"rewardEquipment"}},
}}
local earlyCatalogue = api.SupplyCatalogue(supplyOwner, "'Jitters'")
for _, itemID in ipairs({"medic_medkit_2", "medic_antirad_1", "drug_painkillers"}) do
	check(includes(earlyCatalogue, itemID), "approved low-end supply is available before its shop unlock")
	check(not ix.progression.CanBuyItem(supplyOwner, "'Jitters'", itemID),
		"early task rewards do not grant purchase authorisation")
end
check(includes(earlyCatalogue, "medic_locked_reward_test"), "all configured aid is eligible before shop unlocks")
local supplyRecord = ix.progression.GetCharacterProgression(supplyOwner)
supplyRecord.lines.earlySupplyTest = {completed = true}
ix.progression.SetCharacterProgression(supplyOwner, supplyRecord)
local earnedCatalogue = api.SupplyCatalogue(supplyOwner, "'Jitters'")
check(includes(earnedCatalogue, "medic_locked_reward_test"), "consumables remain available after purchase unlocks")
for _, itemID in ipairs({"attachment_reward_test", "hidestasher_reward_test", "hidestash_1", "rewardEquipment"}) do
	check(not includes(earnedCatalogue, itemID), "equipment and reusable items stay excluded after unlock")
	check(not api.IsConsumableSupply(itemID), "quantity alone does not make equipment consumable")
end
supplyRecord.lines.earlySupplyTest = nil
ix.progression.SetCharacterProgression(supplyOwner, supplyRecord)
local earlySeen, bonusSeen = {}, {}
for serial = 1, 25 do
	for _, choice in ipairs(api.BuildJobChoices(supplyOwner, "'Jitters'", 600, "early:" .. serial)) do
		check(#choice.items <= 2, "early supplies retain the ordinary two-item cap")
		local value = 0
		for _, reward in ipairs(choice.items) do
			earlySeen[reward.item] = true
			check(api.IsConsumableSupply(reward.item), "ordinary rewards contain only consumable supplies")
			value = value + api.ExpectedValue(reward.item, reward.data)
		end
		check(value <= 600, "early ordinary packages respect their supply budget")
	end
	for _, choice in ipairs(api.BuildBonusChoices(supplyOwner, "'Jitters'", 600, "early-bonus:" .. serial)) do
		local value = 0
		for _, reward in ipairs(choice.items) do
			bonusSeen[reward.item] = true
			check(api.IsConsumableSupply(reward.item), "bonus rewards contain only consumable supplies")
			value = value + api.ExpectedValue(reward.item, reward.data)
		end
		check(value <= 600, "early bonus packages respect their supply budget")
	end
end
check(earlySeen.medic_medkit_2 and bonusSeen.medic_medkit_2,
	"locked syrette kits appear in both ordinary and bonus choices")
check(#api.SupplyCatalogue(supplyOwner, "'Mute'") == 0, "early supplies cannot bypass Mute access")
check(#api.SupplyCatalogue(supplyOwner, "'Egghead'") == 0, "early supplies cannot bypass scientist access")
supplyRecord = ix.progression.GetCharacterProgression(supplyOwner)
supplyRecord.lines["cotz/town/old-timer/OT19"] = {completed = true}
ix.progression.SetCharacterProgression(supplyOwner, supplyRecord)
check(includes(api.SupplyCatalogue(supplyOwner, "'Mute'"), "drug_caffeine"),
	"Mute provides consumable supplies after gaining NPC access")
ix.progression.definitions.earlySupplyTest = nil
local catalogueOwner = actor()
local cataloguePreview = api.PreviewJob(catalogueOwner, "'Old Timer'", "easy", {"hunting"})
local cataloguePreviews = catalogueOwner:GetData("taskJobPreviews")
cataloguePreviews["'Old Timer'"].easy.supplyCatalogueVersion = nil
cataloguePreviews["'Old Timer'"].easy.rewardChoices = {{label = "Outdated catalogue", items = {}}}
catalogueOwner:SetData("taskJobPreviews", cataloguePreviews)
local refreshed = api.PreviewJob(catalogueOwner, "'Old Timer'", "easy", {"hunting"})
check(refreshed.rewardKey == cataloguePreview.rewardKey and refreshed.numberRec == cataloguePreview.numberRec,
	"catalogue migration preserves the preview task identity and requirements")
check(refreshed.supplyCatalogueVersion == api.SupplyCatalogueVersion()
	and refreshed.rewardChoices[1].label ~= "Outdated catalogue", "unaccepted previews refresh their catalogue")
check(api.AcceptJob(catalogueOwner.client, "'Old Timer'", "easy"), "updated catalogue preview can be accepted")
local acceptedCatalogue = catalogueOwner:GetJobs()["'Old Timer'"]
local acceptedLabel = catalogueOwner:GetData("taskRewardOffers")[acceptedCatalogue.rewardKey].choices[1].label
check(not api.PreviewJob(catalogueOwner, "'Old Timer'", "easy", {"hunting"}),
	"active assignments prevent preview migrations")
check(catalogueOwner:GetData("taskRewardOffers")[acceptedCatalogue.rewardKey].choices[1].label == acceptedLabel,
	"accepted assignments keep their saved supplies")

local cleaningOwner = actor()
ix.item.list.hidestasher_cleaningkit = {name = "Cleaning kit", price = 900, quantity = 4}
ix.progression.definitions.cleaningSupplyTest = {vendorUnlocks = {
	{npc = "'Old Timer'", args = {"hidestasher_cleaningkit"}},
}}
check(api.IsConsumableSupply("hidestasher_cleaningkit"), "four-use cleaning kits qualify as task supplies")
check(includes(api.SupplyCatalogue(cleaningOwner, "'Old Timer'"), "hidestasher_cleaningkit"),
	"cleaning kits are task rewards before their purchase unlock")
local cleaningRecord = ix.progression.GetCharacterProgression(cleaningOwner)
cleaningRecord.lines.cleaningSupplyTest = {completed = true}
ix.progression.SetCharacterProgression(cleaningOwner, cleaningRecord)
check(includes(api.SupplyCatalogue(cleaningOwner, "'Old Timer'"), "hidestasher_cleaningkit"),
	"unlocked cleaning kits return to Old Timer's catalogue")
local cleaningSeen, cleaningBonusSeen = false, false
for serial = 1, 30 do
	for _, choice in ipairs(api.BuildJobChoices(cleaningOwner, "'Old Timer'", 600, "cleaning:" .. serial)) do
		for _, reward in ipairs(choice.items) do
			if reward.item == "hidestasher_cleaningkit" then
				cleaningSeen = true
				check(reward.data.quantity == 2, "cleaning kits use budgeted partial charges")
			end
		end
	end
	for _, choice in ipairs(api.BuildBonusChoices(cleaningOwner, "'Old Timer'", 600, "cleaning-bonus:" .. serial)) do
		for _, reward in ipairs(choice.items) do
			if reward.item == "hidestasher_cleaningkit" then cleaningBonusSeen = true end
		end
	end
	for _, choice in ipairs(api.BuildChoices(cleaningOwner, "'Cleaner'", 600, "cleaner:" .. serial)) do
		for _, reward in ipairs(choice.items) do
			check(not reward.item:match("^hidestash_"), "Cleaner profiles exclude stash notes and PDAs")
		end
	end
end
check(cleaningSeen and cleaningBonusSeen, "cleaning kits appear in ordinary and five-task bonus rewards")
check(not includes(api.SupplyCatalogue(cleaningOwner, "'Cleaner'"), "hidestash_1"),
	"Cleaner repeatable supplies exclude stash notes")
ix.progression.definitions.cleaningSupplyTest = nil

local fieldViewer = actor()
local fieldAvailable = true
ix.jobs.field = {IsAvailable = function() return fieldAvailable end}
ix.jobs.list.fieldPreviewTest = {name = "Recover equipment", desc = "Recover equipment", fieldType = "recovery",
	numberRec = 1, tier = 1, reward = {}, moneyReward = 3000, repReward = 25}
ix.jobs.jobsbycategory.fieldPreviewTest = {"fieldPreviewTest"}
local fieldPreview = api.PreviewJob(fieldViewer, "'Old Timer'", "easy", {"fieldPreviewTest"})
check(fieldPreview and fieldPreview.rewardKey and #fieldPreview.rewardChoices > 0,
	"field objectives receive ordinary saved cash and supply previews")
fieldAvailable = false
check(not api.PreviewJob(fieldViewer, "'Old Timer'", "easy", {"fieldPreviewTest"}),
	"cached field previews are hidden while point sources are unavailable")
check(not api.PreviewJob(actor(), "'Old Timer'", "easy", {"fieldPreviewTest"}),
	"new previews do not select unavailable field objectives")
fieldAvailable = true
local restoredField = api.PreviewJob(fieldViewer, "'Old Timer'", "easy", {"fieldPreviewTest"})
check(restoredField.rewardKey == fieldPreview.rewardKey and restoredField.moneyReward == fieldPreview.moneyReward,
	"restoring point sources preserves saved preview identity and payment")

print("PASS: " .. checks .. " task reward checks")
