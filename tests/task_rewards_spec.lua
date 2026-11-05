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
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_leaderboard.lua")
local base = "gamemodes/ix_cotz/plugins/progression/"
dofile(base .. "libs/sh_storage.lua")
dofile(base .. "libs/sh_progression.lua")
ix.progression.npcRequirements["'Mute'"] = "cotz/town/old-timer/OT19"
ix.progression.npcRequirements["'Egghead'"] = "cotz/town/smartass/SM07"

dofile(base .. "libs/sh_expansion.lua")
dofile(base .. "libs/sh_services.lua")
ix.jobs = ix.jobs or {}
ix.jobs.field = ix.jobs.field or {}
ix.taskRewards = ix.taskRewards or {}
for _, name in ipairs({"settings", "rewardsettings", "fieldsettings", "killcredit"}) do
	dofile("gamemodes/ix_cotz/plugins/jobsystem/definitions/sh_" .. name .. ".lua")
end
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_taskrewards.lua")
dofile(base .. "libs/sh_rewards.lua")
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sv_taskrewards.lua")
ix.progression.AssignActiveRequirements = function() end
ix.meta.character.__index = ix.meta.character
function ix.meta.character:GetData(key, default)
	if self.data[key] == nil then return default end

	return self.data[key]
end
function ix.meta.character:SetData(key, value) self.data[key] = copy(value) end
function ix.meta.character:GetInventory() return self.inventory end
function ix.meta.character:GetPlayer() return self.client end
function ix.meta.character:GetID() return self.id end
function ix.meta.character:GetJobs() return copy(self.jobs) end
function ix.meta.character:SetJobs(jobs) self.jobs = copy(jobs) end
function ix.meta.character:Save() self.saves = self.saves + 1 end
function ix.meta.character:GiveMoney(amount) self.money = self.money + amount end
local nextID = 0
local function actor()
	nextID = nextID + 1
	local owner = setmetatable({id = nextID, data = {}, jobs = {}, money = 0, saves = 0}, ix.meta.character)
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
check(
	ix.taskRewards.ExpectedValue("kit_reward_demo") == 17.5,
	"kit valuation uses weights and exact partial-stack amounts"
)
ix.item.list.kit_reward_nested = {items = {{{1, "nested"}}}}
ix.randomitems.tables.nested = {{1, {"kit_reward_demo"}}}
check(ix.taskRewards.ExpectedValue("kit_reward_nested") == 17.5, "nested kits are valued without rolling contents")
ix.randomitems.tables.cycle = {{1, {"kit_reward_cycle"}}}
ix.item.list.kit_reward_cycle = {items = {{{1, "cycle"}}}}
check(not pcall(ix.taskRewards.ExpectedValue, "kit_reward_cycle"), "cyclic kit definitions cannot recurse indefinitely")
ix.item.list.value_currency_euro = {name = "Euro", price = 52, quantity = 5000,
	GetPrice = function(self) return self.price * self:GetData("quantity", self.quantity) end}
check(ix.taskRewards.UnitValue("value_currency_euro") == 52, "custom per-unit valuable pricing is respected")
check(
	ix.taskRewards.ExpectedValue("value_currency_euro") == 52,
	"generated currency defaults to one note, not stack capacity"
)
check(ix.taskRewards.ExpectedValue("value_currency_euro", {quantity = 3}) == 156,
	"explicit pool quantities override generated defaults")
local owner = actor()
local choices = ix.taskRewards.BuildChoices(owner, "'Old Timer'", 75, "saved")
check(#choices == 3, "contact gets three distinct available supply choices")
local seen = {}
for _, choice in ipairs(choices) do
	local value = 0
	for _, reward in ipairs(choice.items) do value = value + ix.taskRewards.ExpectedValue(reward.item, reward.data) end
	check(value <= 75 and value >= 74, "each choice preserves budget to within one ruble")
	check(not seen[choice.label], "choices are distinct")
	seen[choice.label] = true
end
ix.item.list.rifle = {name = "Rifle", price = 60, isWeapon = true}
ix.progression.definitions.gunGate = {vendorUnlocks = {{npc = "'Old Timer'", args = {"rifle"}}}}
local lockedChoices = ix.taskRewards.BuildChoices(owner, "'Old Timer'", 75, "gear")
for _, choice in ipairs(lockedChoices) do
	check(choice.items[1].item ~= "rifle", "locked equipment is excluded from reward offers")
end
local earned = ix.progression.GetCharacterProgression(owner)
earned.lines.gunGate = {completed = true}
ix.progression.SetCharacterProgression(owner, earned)
local equipment = ix.taskRewards.BuildChoices(owner, "'Old Timer'", 75, "gear")
check(equipment[#equipment].items[1].item == "rifle", "earned equipment can appear as an explicit choice")
check(#equipment[#equipment].items == 2 and equipment[#equipment].items[2].data.quantity == 15,
	"equipment choice contains one weapon and its visible budget remainder")
ix.progression.definitions.gunGate = nil
ix.item.list.medic_bandage_1 = {name = "Gauze Bandage", price = 40, quantity = 3}
ix.item.list.medic_bandage_2 = {name = "Bandage", price = 80, quantity = 5}
for tier = 1, 5 do
	for serial = 1, 30 do
		local supplies = ix.taskRewards.BuildJobChoices(owner, "'Old Timer'", 75, "job:" .. serial)
		for _, choice in ipairs(supplies) do
			check(#choice.items >= 1 and #choice.items <= 2, "job packages contain one or two inventory items")
			local value = 0
			for _, reward in ipairs(choice.items) do
				local item = ix.item.list[reward.item]
				check(not item.isWeapon and not item.isBodyArmor, "ordinary tasks pay supplies instead of equipment")
				check(reward.data.quantity >= 1 and reward.data.quantity <= (item.quantity or item.ammoAmount),
					"job supplies stay within normal item capacity")
				value = value + ix.taskRewards.ExpectedValue(reward.item, reward.data)
			end
			check(value <= 75, "one or two supplies respect the task budget")
		end
	end
end
local packages = ix.taskRewards.BuildJobChoices(owner, "'Old Timer'", 75, "two-items")
local hasTwo = false
for _, choice in ipairs(packages) do if #choice.items == 2 then hasTwo = true end end
check(hasTwo, "sufficient budgets can award two items")
local stable = ix.taskRewards.BuildJobChoices(owner, "'Old Timer'", 75, "two-items")
check(packages[1].label == stable[1].label, "saved package choices are deterministic")
local first = ix.taskRewards.CreateOffer(owner, "persistent", "'Old Timer'", 75, "Hunt")
ix.item.list[choices[1].items[1].item].price = 999
check(ix.taskRewards.CreateOffer(owner, "persistent", "'Old Timer'", 1000, "Changed").choices[1].label
	== first.choices[1].label, "saved choices never reroll or reprice")
check(not ix.taskRewards.SelectOffer(owner, "'Haggler'", "persistent", 1), "another provider cannot claim the reward")
check(not ix.taskRewards.SelectOffer(owner, "'Old Timer'", "persistent", 0), "invalid choice rejected")
check(not ix.taskRewards.SelectOffer(owner, "'Old Timer'", "persistent", 0 / 0), "nonfinite choice rejected")
check(ix.taskRewards.SelectOffer(owner, "'Old Timer'", "persistent", 1), "reward can be reserved")
check(#owner.inventory.received == 0, "reservation pays no items")
check(ix.taskRewards.EarnOffer(owner, "persistent"), "completion earns the reserved reward")
check(#owner.inventory.received > 0, "reserved reward delivers on completion")
check(not ix.taskRewards.EarnOffer(owner, "persistent"), "completion replay pays nothing")
local restored = actor()
restored.data = copy(owner.data)
check(
	not ix.taskRewards.SelectOffer(restored, "'Old Timer'", "persistent", 1),
	"save/load cannot replay a selected reward"
)
local waiting = actor()
waiting.inventory.full = true
ix.taskRewards.CreateOffer(waiting, "waiting", "'Old Timer'", 60, "Hunt")
ix.taskRewards.SelectOffer(waiting, "'Old Timer'", "waiting", 1)
ix.taskRewards.EarnOffer(waiting, "waiting")
local pending = ix.progression.GetLine(waiting, "taskRewardClaims").pendingRewards
check(#pending > 0, "full inventory preserves a durable queue")
check(not ix.taskRewards.ClaimNext(waiting), "queue cannot acknowledge failed inventory insertion")
waiting.inventory.full = false
check(ix.taskRewards.ClaimNext(waiting), "pending reward delivers after space is available")

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
ix.progression.QueueReward(useOwner, "taskRewardClaims", {item = "reward_bandage", data = {quantity = 2}})
check(not ix.progression.ClaimRewards(useOwner, "taskRewardClaims") and not useOwner.client.receivedLabels,
	"failed inventory insertion does not announce a received item")
useOwner.inventory.full = false
check(ix.progression.ClaimRewards(useOwner, "taskRewardClaims"), "quantity reward delivers when inventory has space")
check(useOwner.client.receivedLabels[1] == "Reward Bandage (2 uses)",
	"item-received message includes the exact awarded uses")
check(not ix.progression.ClaimRewards(useOwner, "taskRewardClaims") and #useOwner.client.receivedLabels == 1,
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
local kitChoice = ix.taskRewards.BuildChoices(
	kitOwner,
	"'Haggler'",
	ix.taskRewards.ExpectedValue("kit_reward_demo"),
	"kit:77"
)[1]
check(not ix.taskRewards.RedeemKit(kitOwner, "'Haggler'", 77, 1, "changed"), "stale kit quote does not consume it")
check(kitOwner.inventory.items[77], "rejected redemption preserves the owned kit")
check(
	ix.taskRewards.RedeemKit(kitOwner, "'Haggler'", 77, 1, kitChoice.label),
	"task kit redeems without paying an upgrade fee"
)
check(not ix.taskRewards.RedeemKit(kitOwner, "'Haggler'", 77, 1, kitChoice.label), "same kit cannot redeem twice")
check(
	not ix.taskRewards.RedeemKit(actor(), "'Haggler'", 77, 1, kitChoice.label),
	"other character cannot redeem an unowned kit"
)

ix.npcbarter = {barterdict = {["'Haggler'"] = {powder = {
	barterItem = {"kit_reward_demo", 1}, reqItem = {"powder", 2},
}}}, activebarters = {powder = true}}
local consumed = 0
ix.npcbarter.ConsumeItems = function(_, _, amount) consumed = consumed + amount return true end
local barterChoice = ix.taskRewards.BarterChoices(
	kitOwner,
	"'Haggler'",
	"powder",
	ix.npcbarter.barterdict["'Haggler'"].powder
)[1]
check(barterChoice, "kit barter exposes explicit ammunition choices")
check(not ix.taskRewards.ExecuteBarter(kitOwner, "'Haggler'", "powder", 1, "wrong"), "stale barter quote is rejected")
check(consumed == 0, "invalid barter consumes no inputs")
check(
	ix.taskRewards.ExecuteBarter(kitOwner, "'Haggler'", "powder", 1, barterChoice.label),
	"converted barter grants chosen ammo"
)
check(consumed == 2, "converted barter preserves input quantity")
ix.npcbarter.activebarters.powder = false
check(
	not ix.taskRewards.ExecuteBarter(kitOwner, "'Haggler'", "powder", 1, barterChoice.label),
	"inactive recipe cannot execute"
)

dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_jobs.lua")
dofile("gamemodes/ix_cotz/plugins/jobsystem/sv_jobs.lua")
ix.jobs.list.hunt = {name = "Hunt %d", desc = "Hunt %d mutants", numberRec = {2, 5},
	reward = {{"kit_reward_demo"}, 0}, repReward = 7, moneyReward = {10, 20}}
ix.jobs.jobsbycategory.hunting = {"hunt"}
check(
	ix.taskRewards.FixedMoney(ix.jobs.list.hunt, 4) == 14,
	"non-delivery jobs scale their cash and supply allowance to fifty-five percent"
)
local hand = {price = 6700, pricepertier = 1700, name = "Swampcontroller Hand"}
function hand:GetPrice() return self.price + self.pricepertier * self:GetData("tier", 0) end
ix.item.list.part_swampcontroller_1 = hand
local delivery = {name = "Hand over %d hands", numberRec = 1, requiredItem = "part_swampcontroller_1",
	reward = {{"kit_reward_demo"}}, repReward = 5}
ix.jobs.list.hand = delivery
check(ix.taskRewards.FixedMoney(delivery, 1) == 3350, "swampcontroller task cash is fifty percent of hand-in value")
check(
	ix.taskRewards.SupplyBudget(delivery, 1) == 3685,
	"delivery supplies retain their previous budget despite changed cash"
)
check(ix.taskRewards.FixedMoney(delivery, 3) == 10050, "cash floor covers every requested specimen")
ix.jobs.jobsbycategory.handDelivery = {"hand"}
local deliveryViewer = actor()
local deliveryPreview = ix.taskRewards.PreviewJob(deliveryViewer, "'Old Timer'", "easy", {"handDelivery"})
local savedDeliveryChoices = copy(deliveryPreview.rewardChoices)
local savedDeliveryBudget = deliveryPreview.supplyBudget
local oldDeliveryPreviews = copy(deliveryViewer:GetData("taskJobPreviews"))
oldDeliveryPreviews["'Old Timer'"].easy.moneyReward = 3685
deliveryViewer:SetData("taskJobPreviews", oldDeliveryPreviews)
local refreshedDelivery = ix.taskRewards.PreviewJob(deliveryViewer, "'Old Timer'", "easy", {"handDelivery"})
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
check(ix.taskRewards.HandInUnitValue("part_swampcontroller_1", specimen) == 11800,
	"actual specimen tier increases opportunity cost")
check(
	ix.taskRewards.FixedMoney(delivery, 1, 11800) == 5900,
	"high-quality specimen scales the fifty percent cash payout"
)
ix.npctemplates = {templates = {one = {items = {part_swampcontroller_1 = {20000, nil, 3}}, scale = 0.8},
	two = {items = {part_swampcontroller_1 = {2, nil, 3}}}}}
check(ix.taskRewards.HandInUnitValue("part_swampcontroller_1") == 16000,
	"best trader override is considered without multiplying prices between traders")
check(
	ix.taskRewards.FixedMoney(delivery, 1) == 8000,
	"delivery cash is fifty percent of configured trader reference value"
)
ix.npctemplates = nil
ix.item.list.food = {name = "Food", price = 100, quantity = 5}
local foodJob = {requiredItem = "food", numberRec = 3, reward = {}, moneyReward = 0}
check(ix.taskRewards.FixedMoney(foodJob, 3) == 30, "stacked deliveries are valued per use, not per full stack")
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
check(ix.taskRewards.DeliverJobItem(foodOwner.client, "NPC"), "delivery records consumed units")
check(food.data.quantity == 2 and not food.removed, "partial stack hand-in preserves surplus uses")
check(foodOwner:GetJobs().NPC.deliveredValue == 60 and foodOwner:GetJobs().NPC.moneyReward == 30,
	"actual hand-in value and payout are saved with progress")
check(not ix.taskRewards.DeliverJobItem(foodOwner.client, "NPC"), "completed task cannot consume more items")
local ammoOwner = actor()
ix.jobs.list.ammoDelivery = {requiredItem = "22lr", numberRec = 3, reward = {}, moneyReward = 0}
ammoOwner.jobs.NPC = {identifier = "ammoDelivery", numberRec = 3, progress = 0}
local rounds = copy(food)
rounds.quantity = nil
rounds.ammoAmount = ix.item.list["22lr"].ammoAmount
rounds.data.quantity = 5
function ammoOwner.inventory:HasItem(id) if id == "22lr" then return rounds end end
check(ix.taskRewards.DeliverJobItem(ammoOwner.client, "NPC"), "ammunition hand-in accepts saved round quantity")
check(rounds.data.quantity == 2 and not rounds.removed and ammoOwner.jobs.NPC.progress == 3,
	"ammunition consumes requested rounds and preserves surplus")
check(ammoOwner.jobs.NPC.deliveredValue == ix.taskRewards.HandInUnitValue("22lr") * 3,
	"ammunition hand-in is valued per consumed round")
ammoOwner.jobs.NPC = {identifier = "ammoDelivery", numberRec = 3, progress = 0}
rounds.Remove = function() return false end
check(not ix.taskRewards.DeliverJobItem(ammoOwner.client, "NPC") and ammoOwner.jobs.NPC.progress == 0,
	"failed ammunition removal awards no job progress")
rounds.data.quantity = 0
check(not ix.taskRewards.DeliverJobItem(ammoOwner.client, "NPC"), "empty ammunition stack cannot advance a job")
local categoryOwner = actor()
ix.progression.itemPools.deliveryTest = {candidates = {{item = "food"}, {item = "part_swampcontroller_1"}}}
ix.jobs.list.categoryDelivery = copy(foodJob)
ix.jobs.list.categoryDelivery.requiredPool = "deliveryTest"
categoryOwner.jobs.NPC = {identifier = "categoryDelivery", numberRec = 2, progress = 0}
local stock = {}
function categoryOwner.inventory:HasItem(id) return stock[id] end
check(not ix.taskRewards.DeliverJobItem(categoryOwner.client, "NPC"), "unrelated inventory cannot satisfy a category")
local function wholeItem(id)
	local item = {GetData = function(_, _, default) return default end}
	function item:Remove() stock[id] = nil end
	stock[id] = item

	return item
end
wholeItem("part_swampcontroller_1")
local alternativeValue = ix.taskRewards.HandInUnitValue("part_swampcontroller_1")
check(ix.taskRewards.DeliverJobItem(categoryOwner.client, "NPC"), "another category member satisfies an easy request")
check(stock.part_swampcontroller_1 == nil and categoryOwner.jobs.NPC.progress == 1,
	"alternative hand-in consumes only the submitted item and preserves partial progress")
check(categoryOwner.jobs.NPC.deliveredValue == alternativeValue,
	"category hand-ins value the actual item rather than the original reference")
wholeItem("food")
check(
	ix.taskRewards.DeliverJobItem(categoryOwner.client, "NPC"),
	"different category members combine toward completion"
)
check(categoryOwner.jobs.NPC.isCompleted, "mixed category hand-ins complete the requested count")
wholeItem("food")
check(not ix.taskRewards.DeliverJobItem(categoryOwner.client, "NPC") and stock.food,
	"repeated category delivery after completion consumes nothing")
categoryOwner.jobs.NPC = {identifier = "food", numberRec = 2, progress = 0}
stock.food = nil
wholeItem("part_swampcontroller_1")
check(not ix.taskRewards.DeliverJobItem(categoryOwner.client, "NPC"), "specific requests still reject alternatives")
ix.jobs.list.categoryDelivery.requiredPool = "missingDeliveryPool"
categoryOwner.jobs.NPC.identifier = "categoryDelivery"
wholeItem("food")
check(not ix.taskRewards.DeliverJobItem(categoryOwner.client, "NPC"), "missing category fails without consuming stock")
ix.jobs.list.categoryDelivery = nil
ix.progression.itemPools.deliveryTest = nil
callbacks.ix_JobTrigger = nil
local gated = actor()
gated.client.rep = 249
check(not ix.taskRewards.PreviewJob(gated, "'Old Timer'", "medium", {"hunting"}),
	"medium task preview requires at least 250 reputation")
gated.client.rep = 250
local mediumPreview = ix.taskRewards.PreviewJob(gated, "'Old Timer'", "medium", {"hunting"})
check(mediumPreview, "medium task unlocks at exactly 250 reputation")
gated.client.rep = 249
check(not ix.taskRewards.AcceptJob(gated.client, "'Old Timer'", "medium"),
	"saved medium preview cannot bypass a reputation drop")
gated.client.rep = 1599
check(not ix.taskRewards.PreviewJob(gated, "'Old Timer'", "hard", {"hunting"}),
	"hard task preview requires at least 1600 reputation")
gated.client.rep = 1600
check(ix.taskRewards.PreviewJob(gated, "'Old Timer'", "hard", {"hunting"}),
	"hard task unlocks at exactly 1600 reputation")
gated.client.rep = 1599
check(not ix.taskRewards.AcceptJob(gated.client, "'Old Timer'", "hard"),
	"saved hard preview cannot bypass a reputation drop")
gated.client.rep = 250
check(ix.taskRewards.AcceptJob(gated.client, "'Old Timer'", "medium"),
	"eligible player can accept the saved medium task")
local hunter = actor()
local preview = ix.taskRewards.PreviewJob(hunter, "'Old Timer'", "easy", {"hunting"})
check(preview.moneyReward == 14, "non-delivery job cash scales its old cash and supply allowance to fifty-five percent")
check(not hunter:GetJobs()["'Old Timer'"], "preview does not accept a task")
local repeated = ix.taskRewards.PreviewJob(hunter, "'Old Timer'", "easy", {"hunting"})
check(repeated.progressionClaim == preview.progressionClaim and repeated.numberRec == preview.numberRec
	and repeated.supplyChoice == preview.supplyChoice,
	"preview reopen preserves task identity, count and reward")
check(not ix.taskRewards.SelectOffer(hunter, "'Old Timer'", preview.rewardKey, 1),
	"unaccepted task cannot reserve a supply through the server API")
check(not ix.taskRewards.AcceptJob(hunter.client, "'Old Timer'", "unknown"), "unpreviewed task cannot be accepted")
check(ix.taskRewards.AcceptJob(hunter.client, "'Old Timer'", "easy"), "acceptance binds the saved task preview")
check(hunter:GetData("taskRewardOffers")[preview.rewardKey].selected == preview.supplyChoice,
	"acceptance reserves the saved random supply")
check(not ix.taskRewards.SelectOffer(hunter, "'Old Timer'", preview.rewardKey, 1),
	"accepted task rejects reward changes")
check(hunter:GetData("taskRewardOffers")[preview.rewardKey].selected == preview.supplyChoice,
	"rejected reward change preserves the accepted selection")
local rewardChoiceOwner = actor()
local choicePreview = ix.taskRewards.PreviewJob(rewardChoiceOwner, "'Old Timer'", "easy", {"hunting"})
local chosenIndex = choicePreview.supplyChoice % #choicePreview.rewardChoices + 1
check(ix.taskRewards.AcceptJob(rewardChoiceOwner.client, "'Old Timer'", "easy", chosenIndex),
	"an explicit acceptance choice is accepted")
local acceptedChoice = rewardChoiceOwner:GetJobs()["'Old Timer'"]
check(acceptedChoice.supplyChoice == chosenIndex
	and rewardChoiceOwner:GetData("taskRewardOffers")[acceptedChoice.rewardKey].selected == chosenIndex,
	"acceptance locks the chosen package rather than the preview default")
local restoredChoice = actor()
restoredChoice.data = copy(rewardChoiceOwner.data)
restoredChoice.jobs = copy(rewardChoiceOwner.jobs)
check(not ix.taskRewards.SelectOffer(restoredChoice, "'Old Timer'", acceptedChoice.rewardKey,
	chosenIndex % #choicePreview.rewardChoices + 1), "reward locking survives save/load")
local jobs = hunter:GetJobs()
check(jobs["'Old Timer'"].numberRec == preview.numberRec, "accepted count matches the displayed count")
check(not ix.taskRewards.AcceptJob(hunter.client, "'Old Timer'", "easy", 1), "accepted preview cannot be replayed")
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
local latePreview = ix.taskRewards.PreviewJob(lateChoice, "'Old Timer'", "easy", {"hunting"})
check(
	ix.taskRewards.AcceptJob(lateChoice.client, "'Old Timer'", "easy"),
	"acceptance automatically reserves its random supply"
)
lateChoice.inventory.full = true
local lateJobs = lateChoice:GetJobs()
lateJobs["'Old Timer'"].isCompleted = true
lateChoice:SetJobs(lateJobs)
lateChoice.client:ixJobComplete("'Old Timer'")
check(#lateChoice.inventory.received == 0, "full inventory preserves the assigned supply for later")
lateChoice.inventory.full = false
check(ix.taskRewards.ClaimNext(lateChoice), "assigned random supply remains claimable after the task finishes")
check(#lateChoice.inventory.received == 1, "late claim delivers the assigned item once")
check(ix.taskRewards.SupplyBudget({moneyReward = 100, reward = {}}, 1) == 600,
	"easy tasks have a useful six-hundred-ruble minimum supply allowance")
local largerJob = {moneyReward = 10000, reward = {}}
check(ix.taskRewards.SupplyBudget(largerJob, 1) == ix.taskRewards.FixedMoney(largerJob, 1),
	"larger allowances use one hundred percent of reference cash")
for _, setting in ipairs({{20, 5, 1}, {40, 10, 1}, {60, 15, 2}, {80, 20, 2}, {100, 20, 2}}) do
	local checkedAmmo = false
	for seed = 1, 5 do
		local choicesByValue = ix.taskRewards.BuildJobChoices(owner, "'Old Timer'", setting[1], "cash-scaling:" .. seed)
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
		for _, choice in ipairs(ix.taskRewards.BuildJobChoices(owner, npc, 600, "minimum-ammo:" .. seed)) do
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
local oldPreview = ix.taskRewards.PreviewJob(oldPreviewOwner, "'Old Timer'", "easy", {"hunting"})
local oldPreviews = oldPreviewOwner:GetData("taskJobPreviews")
oldPreviews["'Old Timer'"].easy.supplyBudget = 600
oldPreviews["'Old Timer'"].easy.supplyDifficulty = "easy"
oldPreviewOwner:SetData("taskJobPreviews", oldPreviews)
local oldOffers = oldPreviewOwner:GetData("taskRewardOffers")
oldOffers[oldPreview.rewardKey].choices = {{label = "Old small reward", items = {}}}
oldPreviewOwner:SetData("taskRewardOffers", oldOffers)
local upgradedPreview = ix.taskRewards.PreviewJob(oldPreviewOwner, "'Old Timer'", "easy", {"hunting"})
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
	check(
		not ix.taskRewards.SelectOffer(bonusOwner, npc, saved.rewardKey, 1),
		"bonus fixture keeps its accepted reward"
	)
	local chosen = bonusOwner:GetData("taskRewardOffers")[saved.rewardKey].choices[1]
	local suppliedValue = 0
	for _, reward in ipairs(chosen.items) do suppliedValue = suppliedValue + ix.taskRewards.ExpectedValue(
		reward.item,
		reward.data
	) end
	expectedByTrader[npc] = (expectedByTrader[npc] or 0) + math.max(0, math.floor(saved.supplyBudget - suppliedValue))
	expectedBonus = expectedByTrader[npc]
	active[npc].isCompleted = true
	bonusOwner:SetJobs(active)
	bonusOwner.client:ixJobComplete(npc)
	local state = ix.taskRewards.TraderBonusProgress(bonusOwner, npc)
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
	ix.taskRewards.RecordCompletion(bonusOwner, npc, saved)
	check(
		ix.taskRewards.TraderBonusProgress(bonusOwner, npc).count == state.count,
		"completion replay adds no bonus progress"
	)
end
check(ix.taskRewards.TraderBonusProgress(bonusOwner, "'Haggler'").count == 4,
	"one trader reaching five preserves the other trader's four completions")
local bonusOffer = bonusOwner:GetData("taskRewardOffers")[finalKey]
check(bonusOffer and bonusOffer.budget == expectedBonus and bonusOffer.earned, "five jobs create the accumulated earned bonus")
check(not ix.taskRewards.SelectOffer(bonusOwner, "'Haggler'", finalKey, 1), "another NPC cannot pay the bonus")
check(
	not ix.taskRewards.SelectOffer(bonusOwner, finalNPC, finalKey, 1, "stale label"),
	"stale reward labels cannot select a changed offer"
)
local cashBefore = bonusOwner.money
check(ix.taskRewards.SelectOffer(bonusOwner, finalNPC, finalKey, 1), "supply bonus can be claimed")
check(bonusOwner.money == cashBefore, "bonus supplies never pay cash")
check(not ix.taskRewards.SelectOffer(bonusOwner, finalNPC, finalKey, 1), "supply bonus cannot be replayed")
for _, choice in ipairs(bonusOffer.choices) do
	check(not choice.money, "bonus choices have no cash payout")
	for _, reward in ipairs(choice.items) do
		check(reward.item ~= "bagrubles", "bonus supplies include no cash rounding remainder")
	end
end
local legacyCash = actor()
legacyCash:SetData("taskRewardOffers", {["bonus:legacy-cash"] = {npc = "'Old Timer'", earned = true,
	label = "Five-task bonus", budget = 101, choices = {{label = "Cash: 101 rubles", money = 101, items = {}}}}})
check(not ix.taskRewards.SelectOffer(legacyCash, "'Old Timer'", "bonus:legacy-cash", 1, "Cash: 101 rubles"),
	"old saved cash selections are rejected after rebuilding bonus choices")
check(legacyCash.money == 0 and legacyCash:GetData("taskRewardOffers")["bonus:legacy-cash"].budget == 101,
	"legacy migration preserves the earned budget without paying cash")
local roundedBonus = ix.taskRewards.BuildBonusChoices(owner, "'Old Timer'", 101, "bonus:rounding")
for _, choice in ipairs(roundedBonus) do
	for _, reward in ipairs(choice.items) do
		check(reward.item ~= "bagrubles", "uneven bonus budgets cannot add ruble items")
	end
end
local noRemainder = actor()
for serial = 1, 5 do
	local key = "job:zero:" .. serial
	local quantity = 1
	local allowance = ix.taskRewards.UnitValue("9x18") * quantity
	noRemainder:SetData("taskRewardOffers", {[key] = {npc = "'Old Timer'", selected = 1,
		choices = {{items = {{item = "9x18", data = {quantity = quantity}}}}}}})
	ix.taskRewards.RecordCompletion(noRemainder, "'Old Timer'", {progressionClaim = serial, rewardKey = key,
		supplyBudget = allowance, bonusContribution = 9999})
	check(ix.taskRewards.TraderBonusProgress(noRemainder, "'Old Timer'").budget == 0,
		"fully spent allowances add nothing, including jobs saved with an old base contribution")
end
check(ix.taskRewards.TraderBonusProgress(noRemainder, "'Old Timer'").count == 0,
	"a zero-value five-task cycle resets normally")
for key in pairs(noRemainder:GetData("taskRewardOffers")) do
	check(not key:match("^bonus:"), "zero-value cycles do not create empty bonus offers")
end
local creditOwner = actor()
local creditChoices = ix.taskRewards.BuildBonusChoices(creditOwner, "'Technut'", 100, "bonus:credit")
local creditIndex = #creditChoices
check(creditChoices[creditIndex].services[1].amount == 130, "repair credit has a thirty percent face-value premium")
creditOwner:SetData("taskRewardOffers", {["bonus:credit"] = {npc = "'Technut'", earned = true,
	label = "Five-task bonus", budget = 100, choices = creditChoices}})
check(
	ix.taskRewards.SelectOffer(creditOwner, "'Technut'", "bonus:credit", creditIndex),
	"repair credit bonus can be claimed"
)
check(ix.progression.GetServiceCredit(creditOwner, "'Technut'", "repair") == 130,
	"bonus credit belongs to the issuing repair provider")
check(
	not ix.taskRewards.SelectOffer(creditOwner, "'Technut'", "bonus:credit", creditIndex),
	"credit bonus cannot be replayed"
)
creditOwner:SetData("progressionServiceCredits", {["'Technut'/repair"] = 19900})
local capacityChoices = ix.taskRewards.BuildBonusChoices(creditOwner, "'Technut'", 100, "bonus:cap")
for _, choice in ipairs(capacityChoices) do check(not choice.services, "insufficient credit capacity hides the credit choice") end
creditOwner:SetData("progressionServiceCredits", {["'Technut'/repair"] = 0})
creditOwner:SetData("taskRewardOffers", {["bonus:cap"] = {npc = "'Technut'", earned = true,
	label = "Five-task bonus", budget = 100, choices = creditChoices}})
creditOwner:SetData("progressionServiceCredits", {["'Technut'/repair"] = 19900})
ix.taskRewards.SelectOffer(creditOwner, "'Technut'", "bonus:cap", creditIndex)
check(ix.progression.GetServiceCredit(creditOwner, "'Technut'", "repair") == 19900
	and creditOwner:GetData("taskRewardOffers")["bonus:cap"], "capacity changes preserve the whole unclaimed bonus")
check(
	ix.taskRewards.SelectOffer(creditOwner, "'Technut'", "bonus:cap", 1),
	"a blocked credit claim can choose supplies instead"
)
ix.item.list.advancedAmmo = {name = "Advanced ammunition", isAmmo = true, price = 100, ammoAmount = 10}
ix.progression.definitions.supplyGate = {vendorUnlocks = {{npc = "'Old Timer'", args = {"advancedAmmo"}}}}
local catalogue = ix.taskRewards.SupplyCatalogue(creditOwner, "'Old Timer'")
local function includes(list, value)
	for _, entry in ipairs(list) do if entry == value then return true end end

	return false
end
check(includes(catalogue, "advancedAmmo"), "all consumable rewards are available before purchase unlocks")
local unlockRecord = ix.progression.GetCharacterProgression(creditOwner)
unlockRecord.lines.supplyGate = {completed = true}
ix.progression.SetCharacterProgression(creditOwner, unlockRecord)
check(
	includes(ix.taskRewards.SupplyCatalogue(creditOwner, "'Old Timer'"), "advancedAmmo"),
	"earned unlocks expand the supply catalogue"
)
local fixedAllowance = ix.taskRewards.SupplyBudget(ix.jobs.list[preview.identifier], preview.numberRec)
check(fixedAllowance == preview.supplyBudget, "equipment unlocks do not increase the allowance for the same work")
ix.progression.definitions.supplyGate = nil
local harder = {moneyReward = 10000, reward = {}}
check(ix.taskRewards.SupplyBudget(harder, 1) > fixedAllowance, "more valuable work contributes more toward the bonus")
local resumed = actor()
resumed.data = copy(hunter.data)
check(
	ix.taskRewards.BonusStatus(resumed, "'Old Timer'") == ix.taskRewards.BonusStatus(hunter, "'Old Timer'"),
	"partial bonus progress survives character restoration"
)

local legacyBonus = actor()
legacyBonus:SetData("taskCompletionBonus", {count = 3, budget = 150,
	claims = {["'Old Timer'"] = 4, ["'Haggler'"] = 7}})
check(ix.taskRewards.TraderBonusProgress(legacyBonus, "'Haggler'").count == 3,
	"legacy partial progress is preserved at its most recently credited trader")
check(not ix.taskRewards.TraderBonusProgress(legacyBonus, "'Old Timer'").count,
	"legacy partial progress is not duplicated across traders")
ix.taskRewards.RecordCompletion(legacyBonus, "'Old Timer'", {identifier = preview.identifier, numberRec = 2,
	progressionClaim = 8, rewardKey = "job:8", bonusContribution = 20})
check(ix.taskRewards.TraderBonusProgress(legacyBonus, "'Haggler'").budget == 150
	and ix.taskRewards.TraderBonusProgress(legacyBonus, "'Old Timer'").count == 1,
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
check(#dialogue.tree.GREETING.options == 1
	and dialogue.tree.GREETING.options[1] == "GOODBYE", "no claim submenu remains at root")
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
check(not ix.taskRewards.AcceptJob(viewer.client, "'Old Timer'", "easy", 999),
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
		check(option ~= "TaskRewardChoices", "claim submenu is removed")
	end
end
check(#workDialogue.tree.AboutWorkTopic.options == 1
	and workDialogue.tree.AboutWorkTopic.options[1] == "BackTopic",
	"assignment has no reward submenu")
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
check(not ix.taskRewards.AcceptJob(viewer.client, "'Old Timer'", "easy", 900),
	"invalid preview supply choice cannot accept a job")
check(not viewer:GetJobs()["'Old Timer'"], "invalid preview choice leaves the task unaccepted")
check(ix.taskRewards.AcceptJob(viewer.client, "'Old Timer'", "easy"), "preview can be accepted with its random supply")
check(viewer:GetData("taskRewardOffers")[viewer:GetJobs()["'Old Timer'"].rewardKey].selected == shownPreview.supplyChoice,
	"random supply is reserved after the task is accepted")
check(not workDialogue.tree.TaskRewardChoices.ShouldAdd(nil, viewer.client, target),
	"accepted jobs without outstanding rewards hide exchanges")
check(not workDialogue.tree.AboutWorkTopic.ShouldAdd(nil, viewer.client, target),
	"accepted jobs do not expose reward changes through About work")
check(#workDialogue.tree.TaskRewardChoices.GetDynamicOptions(nil, viewer.client, target) == 0,
	"accepted rewards are absent from claim choices")
local noWork = actor()
check(not workDialogue.tree.AboutWorkTopic.ShouldAdd(nil, noWork.client, target),
	"work menu keeps its original visibility when there are no reward actions")
check(not ix.taskRewards.CreateOffer(viewer, "progression:menu-test", "'Old Timer'", 75, "Progression task"),
	"new progression supply offers cannot be created")
local forgedOffers = copy(viewer:GetData("taskRewardOffers", {}))
forgedOffers["progression:menu-test"] = {npc = "'Old Timer'", label = "Progression task", earned = true,
	choices = {{label = "Old supplies", items = {{item = "medic_bandage_1", data = {quantity = 3}}}}}}
viewer:SetData("taskRewardOffers", forgedOffers)
check(not ix.taskRewards.SelectOffer(viewer, "'Old Timer'", "progression:menu-test", 1),
	"direct calls cannot select an old progression gift offer")
check(not ix.taskRewards.EarnOffer(viewer, "progression:menu-test"),
	"saved progression offers cannot be paid through the job reward service")
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
check(ix.taskRewards.ClaimNext(packageOwner) and #scheduledClaims == 1,
	"jobsystem schedules continuation after the first supply claim")
scheduledClaims[1]()
check(#packageOwner.inventory.received == 2 and #scheduledClaims == 1,
	"jobsystem drains the package and stops when the claim queue is empty")
check(not ix.progression.QueueReward(packageOwner, "story-claim", {item = "medic_bandage_1"}),
	"progression gifts cannot use the repeatable job claim queue")
check(not ix.progression.ClaimRewards(packageOwner, "story-claim") and #scheduledClaims == 1,
	"removed story gifts cannot schedule job reward delivery")
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
	check(includes(ix.taskRewards.SupplyCatalogue(stoneRecipient, "'Old Timer'"), itemID),
		"ungated standalone supply profiles can offer stones")
	check(not ix.progression.CanBuyItem(stoneRecipient, "'Old Timer'", itemID),
		"the purchase gate remains authoritative")
end
local stoneRecord = ix.progression.GetCharacterProgression(stoneRecipient)
stoneRecord.lines.stonePurchase = {completed = true}
ix.progression.SetCharacterProgression(stoneRecipient, stoneRecord)
local stoneOffers = {}
for _, itemID in ipairs(stoneIDs) do
	check(includes(ix.taskRewards.SupplyCatalogue(stoneRecipient, "'Old Timer'"), itemID),
		"unlocked sharpening stones are eligible task supplies")
end
for seed = 1, 30 do
	for _, choice in ipairs(ix.taskRewards.BuildJobChoices(stoneRecipient, "'Old Timer'", 600, "stones:" .. seed)) do
		local itemID = choice.items[1].item
		if includes(stoneIDs, itemID) then
			stoneOffers[itemID] = true
			check(#choice.items == 2, "task budget awards two sharpening stones")
			local value = 0
			for _, reward in ipairs(choice.items) do
				check(reward.data.quantity == 3, "task reward stones each have three uses")
				value = value + ix.taskRewards.ExpectedValue(reward.item, reward.data)
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
local earlyCatalogue = ix.taskRewards.SupplyCatalogue(supplyOwner, "'Jitters'")
for _, itemID in ipairs({"medic_medkit_2", "medic_antirad_1", "drug_painkillers"}) do
	check(includes(earlyCatalogue, itemID), "approved low-end supply is available before its shop unlock")
	check(not ix.progression.CanBuyItem(supplyOwner, "'Jitters'", itemID),
		"early task rewards do not grant purchase authorisation")
end
check(includes(earlyCatalogue, "medic_locked_reward_test"), "all configured aid is eligible before shop unlocks")
local supplyRecord = ix.progression.GetCharacterProgression(supplyOwner)
supplyRecord.lines.earlySupplyTest = {completed = true}
ix.progression.SetCharacterProgression(supplyOwner, supplyRecord)
local earnedCatalogue = ix.taskRewards.SupplyCatalogue(supplyOwner, "'Jitters'")
check(includes(earnedCatalogue, "medic_locked_reward_test"), "consumables remain available after purchase unlocks")
for _, itemID in ipairs({"attachment_reward_test", "hidestasher_reward_test", "hidestash_1", "rewardEquipment"}) do
	check(not includes(earnedCatalogue, itemID), "equipment and reusable items stay excluded after unlock")
	check(not ix.taskRewards.IsConsumableSupply(itemID), "quantity alone does not make equipment consumable")
end
supplyRecord.lines.earlySupplyTest = nil
ix.progression.SetCharacterProgression(supplyOwner, supplyRecord)
local earlySeen, bonusSeen = {}, {}
for serial = 1, 25 do
	for _, choice in ipairs(ix.taskRewards.BuildJobChoices(supplyOwner, "'Jitters'", 600, "early:" .. serial)) do
		check(#choice.items <= 2, "early supplies retain the ordinary two-item cap")
		local value = 0
		for _, reward in ipairs(choice.items) do
			earlySeen[reward.item] = true
			check(ix.taskRewards.IsConsumableSupply(reward.item), "ordinary rewards contain only consumable supplies")
			value = value + ix.taskRewards.ExpectedValue(reward.item, reward.data)
		end
		check(value <= 600, "early ordinary packages respect their supply budget")
	end
	for _, choice in ipairs(ix.taskRewards.BuildBonusChoices(
		supplyOwner,
		"'Jitters'",
		600,
		"early-bonus:" .. serial
	)) do
		local value = 0
		for _, reward in ipairs(choice.items) do
			bonusSeen[reward.item] = true
			check(ix.taskRewards.IsConsumableSupply(reward.item), "bonus rewards contain only consumable supplies")
			value = value + ix.taskRewards.ExpectedValue(reward.item, reward.data)
		end
		check(value <= 600, "early bonus packages respect their supply budget")
	end
end
check(earlySeen.medic_medkit_2 and bonusSeen.medic_medkit_2,
	"locked syrette kits appear in both ordinary and bonus choices")
check(#ix.taskRewards.SupplyCatalogue(supplyOwner, "'Mute'") == 0, "early supplies cannot bypass Mute access")
check(#ix.taskRewards.SupplyCatalogue(supplyOwner, "'Egghead'") == 0, "early supplies cannot bypass scientist access")
supplyRecord = ix.progression.GetCharacterProgression(supplyOwner)
supplyRecord.lines["cotz/town/old-timer/OT19"] = {completed = true}
ix.progression.SetCharacterProgression(supplyOwner, supplyRecord)
check(includes(ix.taskRewards.SupplyCatalogue(supplyOwner, "'Mute'"), "drug_caffeine"),
	"Mute provides consumable supplies after gaining NPC access")
ix.progression.definitions.earlySupplyTest = nil
local catalogueOwner = actor()
local cataloguePreview = ix.taskRewards.PreviewJob(catalogueOwner, "'Old Timer'", "easy", {"hunting"})
local cataloguePreviews = catalogueOwner:GetData("taskJobPreviews")
cataloguePreviews["'Old Timer'"].easy.supplyCatalogueVersion = nil
cataloguePreviews["'Old Timer'"].easy.rewardChoices = {{label = "Outdated catalogue", items = {}}}
catalogueOwner:SetData("taskJobPreviews", cataloguePreviews)
local refreshed = ix.taskRewards.PreviewJob(catalogueOwner, "'Old Timer'", "easy", {"hunting"})
check(refreshed.rewardKey == cataloguePreview.rewardKey and refreshed.numberRec == cataloguePreview.numberRec,
	"catalogue migration preserves the preview task identity and requirements")
check(refreshed.supplyCatalogueVersion == ix.taskRewards.SupplyCatalogueVersion()
	and refreshed.rewardChoices[1].label ~= "Outdated catalogue", "unaccepted previews refresh their catalogue")
check(
	ix.taskRewards.AcceptJob(catalogueOwner.client, "'Old Timer'", "easy"),
	"updated catalogue preview can be accepted"
)
local acceptedCatalogue = catalogueOwner:GetJobs()["'Old Timer'"]
local acceptedLabel = catalogueOwner:GetData("taskRewardOffers")[acceptedCatalogue.rewardKey].choices[1].label
check(not ix.taskRewards.PreviewJob(catalogueOwner, "'Old Timer'", "easy", {"hunting"}),
	"active assignments prevent preview migrations")
check(catalogueOwner:GetData("taskRewardOffers")[acceptedCatalogue.rewardKey].choices[1].label == acceptedLabel,
	"accepted assignments keep their saved supplies")

local cleaningOwner = actor()
ix.item.list.hidestasher_cleaningkit = {name = "Cleaning kit", price = 900, quantity = 4}
ix.progression.definitions.cleaningSupplyTest = {vendorUnlocks = {
	{npc = "'Old Timer'", args = {"hidestasher_cleaningkit"}},
}}
check(ix.taskRewards.IsConsumableSupply("hidestasher_cleaningkit"), "four-use cleaning kits qualify as task supplies")
check(includes(ix.taskRewards.SupplyCatalogue(cleaningOwner, "'Old Timer'"), "hidestasher_cleaningkit"),
	"cleaning kits are task rewards before their purchase unlock")
local cleaningRecord = ix.progression.GetCharacterProgression(cleaningOwner)
cleaningRecord.lines.cleaningSupplyTest = {completed = true}
ix.progression.SetCharacterProgression(cleaningOwner, cleaningRecord)
check(includes(ix.taskRewards.SupplyCatalogue(cleaningOwner, "'Old Timer'"), "hidestasher_cleaningkit"),
	"unlocked cleaning kits return to Old Timer's catalogue")
local cleaningSeen, cleaningBonusSeen = false, false
for serial = 1, 30 do
	for _, choice in ipairs(ix.taskRewards.BuildJobChoices(cleaningOwner, "'Old Timer'", 600, "cleaning:" .. serial)) do
		for _, reward in ipairs(choice.items) do
			if reward.item == "hidestasher_cleaningkit" then
				cleaningSeen = true
				check(reward.data.quantity == 2, "cleaning kits use budgeted partial charges")
			end
		end
	end
	for _, choice in ipairs(ix.taskRewards.BuildBonusChoices(
		cleaningOwner,
		"'Old Timer'",
		600,
		"cleaning-bonus:" .. serial
	)) do
		for _, reward in ipairs(choice.items) do
			if reward.item == "hidestasher_cleaningkit" then cleaningBonusSeen = true end
		end
	end
	for _, choice in ipairs(ix.taskRewards.BuildChoices(cleaningOwner, "'Cleaner'", 600, "cleaner:" .. serial)) do
		for _, reward in ipairs(choice.items) do
			check(not reward.item:match("^hidestash_"), "Cleaner profiles exclude stash notes and PDAs")
		end
	end
end
check(cleaningSeen and cleaningBonusSeen, "cleaning kits appear in ordinary and five-task bonus rewards")
check(not includes(ix.taskRewards.SupplyCatalogue(cleaningOwner, "'Cleaner'"), "hidestash_1"),
	"Cleaner repeatable supplies exclude stash notes")
ix.progression.definitions.cleaningSupplyTest = nil

local fieldViewer = actor()
local fieldAvailable = true
ix.jobs.field = {IsAvailable = function() return fieldAvailable end}
ix.jobs.list.fieldPreviewTest = {name = "Recover equipment", desc = "Recover equipment", fieldType = "recovery",
	numberRec = 1, tier = 1, reward = {}, moneyReward = 3000, repReward = 25}
ix.jobs.jobsbycategory.fieldPreviewTest = {"fieldPreviewTest"}
local fieldPreview = ix.taskRewards.PreviewJob(fieldViewer, "'Old Timer'", "easy", {"fieldPreviewTest"})
check(fieldPreview and fieldPreview.rewardKey and #fieldPreview.rewardChoices > 0,
	"field objectives receive ordinary saved cash and supply previews")
fieldAvailable = false
check(not ix.taskRewards.PreviewJob(fieldViewer, "'Old Timer'", "easy", {"fieldPreviewTest"}),
	"cached field previews are hidden while point sources are unavailable")
check(not ix.taskRewards.PreviewJob(actor(), "'Old Timer'", "easy", {"fieldPreviewTest"}),
	"new previews do not select unavailable field objectives")
fieldAvailable = true
local restoredField = ix.taskRewards.PreviewJob(fieldViewer, "'Old Timer'", "easy", {"fieldPreviewTest"})
check(restoredField.rewardKey == fieldPreview.rewardKey and restoredField.moneyReward == fieldPreview.moneyReward,
	"restoring point sources preserves saved preview identity and payment")

do
	local contacts = {}
	SERVER, CLIENT = true, false
	local previousPlugin = PLUGIN
	PLUGIN = {Register = function(_, id, contact) contacts[id] = contact end}
	local paths = assert(io.popen("rg --files gamemodes/ix_cotz/plugins/townnpcs/definitions"))
	for path in paths:lines() do
		if not (path:match("sh_config.lua$") or path:match("sh_equipment.lua$") or path:match("sh_sites.lua$")) then
			dofile(path)
		end
	end
	paths:close()
	PLUGIN = previousPlugin
	local sources = {}
	paths = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items gamemodes/ix_cotz/plugins"))
	for path in paths:lines() do
		if path:find("/items/", 1, true) then
			local id = path:match("/sh_([^/]+)%.lua$")
			if id then
				if path:find("/items/base/", 1, true) then id = "base_" .. id end
				local file = assert(io.open(path))
				sources[id] = {text = file:read("*a"), path = path}
				file:close()
			end
		end
	end
	paths:close()
	local function loadReward(id)
		local source = assert(sources[id], "Reward uses a real item: " .. id)
		local text = source.text
		local baseID = text:match("ITEM.base = \"([^\"]+)\"")
			or "base_" .. source.path:match("/items/([^/]+)/")
		local parent = sources[baseID] and loadReward(baseID) or {}
		local item = {name = id, price = tonumber(text:match("ITEM.price = ([%d%.]+)")) or parent.price or 100,
			quantity = tonumber(text:match("ITEM.quantity = (%d+)")) or parent.quantity,
			ammoAmount = tonumber(text:match("ITEM.ammoAmount = (%d+)")) or parent.ammoAmount,
			isAmmo = source.path:find("/newammo/", 1, true) ~= nil or parent.isAmmo,
			sharpnessRestored = text:find("ITEM.sharpnessRestored", 1, true) ~= nil or parent.sharpnessRestored}
		setmetatable(item, {__index = parent})
		if text:find("return self.price * self:GetData", 1, true) then
			function item:GetPrice() return self.price * self:GetData("quantity", self.quantity) end
		end
		ix.item.list[id] = item

		return item
	end
	local count = 0
	for _, contact in pairs(contacts) do
		count = count + 1
		check(contact.rewards and #contact.rewards.packages == 3, "each town contact has three themed packages")
		for _, package in ipairs(contact.rewards.packages) do
			for _, id in ipairs(package.items) do
				loadReward(id)
				check(ix.taskRewards.IsConsumableSupply(id) or id:match("^value_"),
					"ordinary theme uses supported consumables or trade goods: " .. id)
			end
		end
		for _, id in ipairs(contact.rewards.bonusItems or {}) do loadReward(id) end
		ix.taskRewards.SetTownProfile(contact.name, contact.rewards)
	end
	check(count == 27, "reward overhaul covers all 27 contacts")
	local bossOwner = actor()
	local bossChoices = ix.taskRewards.BuildBonusChoices(bossOwner, "'Boss'", 100, "bonus:boss")
	local bossCredit = #bossChoices
	check(bossChoices[bossCredit].services[1].npc == "'Boss'", "Boss offers his own repair credit")
	bossOwner:SetData("taskRewardOffers", {["bonus:boss"] = {npc = "'Boss'", earned = true,
		budget = 100, choices = bossChoices}})
	check(
		ix.taskRewards.SelectOffer(bossOwner, "'Boss'", "bonus:boss", bossCredit),
		"themed provider credit can be claimed"
	)
	check(ix.progression.GetServiceCredit(bossOwner, "'Boss'", "repair") == 130
		and ix.progression.GetServiceCredit(bossOwner, "'Technut'", "repair") == 0,
		"Boss's bonus pays only Boss credit with the existing premium")
	local recipient = actor()
	local record = ix.progression.GetCharacterProgression(recipient)
	record.lines["cotz/town/old-timer/OT19"] = {completed = true}
	record.lines["cotz/town/smartass/SM07"] = {completed = true}
	ix.progression.SetCharacterProgression(recipient, record)
	for _, contact in pairs(contacts) do
		local allowed = {}
		for _, package in ipairs(contact.rewards.packages) do
			for _, id in ipairs(package.items) do allowed[id] = true end
		end
		for _, budget in ipairs({600, 1500, 10000}) do
			for serial = 1, 10 do
				local choices = ix.taskRewards.BuildJobChoices(recipient, contact.name, budget, "theme:" .. serial)
				check(#choices > 0 and #choices <= 3, "every contact has affordable ordinary choices")
				for _, choice in ipairs(choices) do
					check(#choice.items > 0 and #choice.items <= 2, "themed jobs retain the two-item cap")
					local value = 0
					for _, reward in ipairs(choice.items) do
						check(allowed[reward.item], "ordinary rewards stay within the contact's dedicated list")
						value = value + ix.taskRewards.ExpectedValue(reward.item, reward.data)
						local item = ix.item.list[reward.item]
						if item.quantity or item.ammoAmount then
							check(reward.data.quantity > 0
								and reward.data.quantity <= (item.quantity or item.ammoAmount),
								"stacked trade goods and supplies have explicit legal quantities")
						end
					end
					check(value <= budget, "themed packages respect the unchanged allowance")
				end
			end
		end
		local bonus = ix.taskRewards.BuildBonusChoices(recipient, contact.name, 1500, "theme:bonus")
		for _, choice in ipairs(bonus) do
			for _, service in ipairs(choice.services or {}) do
				check(service.npc == contact.name, "credit remains with its issuing provider")
				check(contact.name == "'Technut'" or contact.name == "'Boss'", "only repair providers issue credit")
			end
		end
	end
	ix.progression.definitions.themeLeak = {vendorUnlocks = {{npc = "'Technut'", args = {"medic_antirad_1"}}}}
	check(not includes(ix.taskRewards.SupplyCatalogue(recipient, "'Technut'"), "medic_antirad_1"),
		"vendor catalogue changes cannot leak into dedicated task rewards")
	ix.progression.definitions.themeLeak = nil
	local profile = contacts.technut.rewards
	local before = ix.taskRewards.BuildJobChoices(recipient, "'Technut'", 600, "theme:stable")
	check(before[1].label == ix.taskRewards.BuildJobChoices(recipient, "'Technut'", 600, "theme:stable")[1].label,
		"themed choices remain deterministic")
	check(before[1].label:find("trade goods", 1, true), "maintenance valuables are labelled honestly")
	ix.taskRewards.SetTownProfile("'Technut'", {packages = {{label = "Exact bolts", items = {"value_bolts"}}}})
	local goods = ix.taskRewards.BuildJobChoices(recipient, "'Technut'", 600, "theme:goods")[1]
	check(goods.items[1].data.quantity == 20 and goods.items[2].data.quantity == 3,
		"per-unit valuable prices produce exact stacks instead of random spawn quantities")
	recipient.inventory.full = true
	ix.taskRewards.CreateOffer(recipient, "theme:claim", "'Technut'", 600, "Workshop job", 1)
	ix.taskRewards.SelectOffer(recipient, "'Technut'", "theme:claim", 1)
	ix.taskRewards.EarnOffer(recipient, "theme:claim")
	check(#ix.progression.GetLine(recipient, "taskRewardClaims").pendingRewards == 2,
		"full inventories preserve themed trade goods in the existing claim queue")
	ix.taskRewards.SetTownProfile("'Technut'", profile)
	recipient.inventory.full = false
	check(ix.taskRewards.ClaimNext(recipient), "themed trade goods resume delivery after space becomes available")
	local unlocked = true
	local previousTown = ix.townNPCs
	ix.townNPCs = {installed = true, itemGates = {
		medic_antirad_1 = {sellers = {["'Jitters'"] = {}}}, attachment_fabric_1 = {},
	}, IsPurchaseExcluded = function() return false end,
		CanBuyItem = function(_, _, id, seller)
			if id == "medic_antirad_1" then return unlocked and seller == "'Jitters'" end
			return unlocked
		end}
	unlocked = false
	check(not includes(ix.taskRewards.SupplyCatalogue(recipient, "'Vesper'"), "medic_antirad_1"),
		"support medicine respects its real seller's progression gate")
	local function hasEquipment(choices, id)
		for _, choice in ipairs(choices) do
			for _, reward in ipairs(choice.items) do if reward.item == id then return true end end
		end
		return false
	end
	check(not hasEquipment(ix.taskRewards.BuildBonusChoices(recipient, "'Suture'", 50000, "theme:equipment"),
		"attachment_fabric_1"), "locked reinforcement cannot appear in bonuses")
	unlocked = true
	check(includes(ix.taskRewards.SupplyCatalogue(recipient, "'Vesper'"), "medic_antirad_1"),
		"support medicine becomes available after a real seller's milestone")
	check(includes(ix.taskRewards.SupplyCatalogue(recipient, "'Jitters'"), "medic_antirad_1"),
		"a medic's own unlocked supplies remain available")
	check(hasEquipment(ix.taskRewards.BuildBonusChoices(recipient, "'Suture'", 50000, "theme:equipment"),
		"attachment_fabric_1"), "earned reinforcement can appear as an explicit bonus")
	ix.townNPCs = previousTown
	local fresh = actor()
	check(#ix.taskRewards.BuildJobChoices(fresh, "'Mute'", 600, "theme:access") == 0,
		"dedicated profiles preserve contact access requirements")
	check(catalogueOwner:GetData("taskRewardOffers")[acceptedCatalogue.rewardKey].choices[1].label == acceptedLabel,
		"installing themed profiles leaves an existing accepted reward intact")
	local cachedOwner = actor()
	local cached = ix.taskRewards.PreviewJob(cachedOwner, "'Old Timer'", "easy", {"hunting"})
	local cachedPreviews = cachedOwner:GetData("taskJobPreviews")
	cachedPreviews["'Old Timer'"].easy.supplyCatalogueVersion = nil
	cachedOwner:SetData("taskJobPreviews", cachedPreviews)
	ix.taskRewards.SetTownProfile(
		"'Old Timer'",
		{packages = {{label = "Expensive goods", items = {"value_motorclean"}}}}
	)
	local refreshed = ix.taskRewards.PreviewJob(cachedOwner, "'Old Timer'", "easy", {"hunting"})
	check(refreshed.identifier == cached.identifier and refreshed.numberRec == cached.numberRec,
		"theme refresh preserves cached job identity and requirements")
	check(refreshed.rewardChoices[1].label == "No item rewards available",
		"an unaffordable theme retires old unaccepted supplies instead of leaking them")
	local saver = actor()
	for serial = 1, 10 do
		local key = "job:theme-saving:" .. serial
		saver:SetData("taskRewardOffers", {[key] = {npc = "'Old Timer'", selected = 1,
			choices = {{items = {}}}}})
		ix.taskRewards.RecordCompletion(saver, "'Old Timer'", {rewardKey = key, progressionClaim = serial,
			supplyBudget = serial <= 5 and 1 or 500})
		if serial == 5 then
			check(ix.taskRewards.TraderBonusProgress(saver, "'Old Timer'").budget == 5,
				"unaffordable five-task value stays banked for the next cycle")
			check(not saver:GetData("taskRewardOffers")["bonus:5"], "unaffordable cycles create no empty offers")
		end
	end
	check(saver:GetData("taskRewardOffers")["bonus:10"].budget == 2505,
		"retained value combines with later completions into a claimable themed bonus")
	ix.taskRewards.SetTownProfile("'Old Timer'", contacts["old-timer"].rewards)
end

local directRewards = dialogue.tree.TaskRewardChoices.GetDynamicOptions(nil, rootRewardOwner.client, target)
local rootRewards = dialogue.tree.GREETING.GetDynamicOptions(nil, rootRewardOwner.client, target)
check(#rootRewards == #directRewards, "reward actions appear directly at the root")
ix.dialogue.ConfigureTaskRewards(dialogue)
check(#dialogue.tree.GREETING.GetDynamicOptions(nil, rootRewardOwner.client, target) == #directRewards,
	"reconfiguring a dialogue does not duplicate direct reward actions")
print("PASS: " .. checks .. " task reward checks")
