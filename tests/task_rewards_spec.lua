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
for _, name in ipairs({"settings", "rewardsettings", "fieldsettings", "killcredit", "regionalcatalogue"}) do
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
local rewardNPCDenied = false
local rewardPosition = {DistToSqr = function() return 0 end}
ix.progression.GetNPCFromName = function(name)
	return {GetClass = function() return "ix_vendor_adv" end, GetDisplayName = function() return name end,
		CanAccess = function() return not rewardNPCDenied end, GetPos = function() return rewardPosition end}
end
local function finishJob(owner, npc, index)
	owner.client:ixJobComplete(npc)
	local job = owner:GetJobs()[npc]
	if job then return ix.taskRewards.SelectOffer(owner, npc, job.rewardKey, index or 1) end
end
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
	function owner.client:Alive() return true end
	function owner.client:GetPos() return rewardPosition end
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
for _, choice in ipairs(packages) do
	local item = ix.item.list[choice.items[1].item]
	if item.isAmmo then
		check(#choice.items == 1 and choice.items[1].data.quantity == item.ammoAmount / 2,
			"ordinary ammunition is exactly half a regular pack")
	end
end
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
check(ix.taskRewards.FixedMoney(delivery, 1) == 3850, "delivery cash adds the tier base to half the hand-in value")
check(
	ix.taskRewards.SupplyBudget(delivery, 1) == 600,
	"delivery supplies exclude the item reimbursement"
)
check(ix.taskRewards.FixedMoney(delivery, 3) == 10550, "cash floor covers every requested specimen")
ix.jobs.jobsbycategory.handDelivery = {"hand"}
local deliveryViewer = actor()
local deliveryPreview = ix.taskRewards.PreviewJob(deliveryViewer, "'Old Timer'", "easy", {"handDelivery"})
local savedDeliveryChoices = deliveryPreview.rewardChoices
local savedDeliveryBudget = deliveryPreview.supplyBudget
local oldDeliveryPreviews = copy(deliveryViewer:GetData("taskJobPreviews"))
oldDeliveryPreviews["'Old Timer'"].easy.moneyReward = 3685
deliveryViewer:SetData("taskJobPreviews", oldDeliveryPreviews)
local refreshedDelivery = ix.taskRewards.PreviewJob(deliveryViewer, "'Old Timer'", "easy", {"handDelivery"})
check(refreshedDelivery.moneyReward == 3850, "cached delivery previews refresh their cash payout")
check(refreshedDelivery.supplyBudget == savedDeliveryBudget
	and refreshedDelivery.rewardChoices == nil and savedDeliveryChoices == nil,
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
	ix.taskRewards.FixedMoney(delivery, 1, 11800) == 6400,
	"high-quality specimen scales the fifty percent cash payout"
)
ix.npctemplates = {templates = {one = {items = {part_swampcontroller_1 = {20000, nil, 3}}, scale = 0.8},
	two = {items = {part_swampcontroller_1 = {2, nil, 3}}}}}
check(ix.taskRewards.HandInUnitValue("part_swampcontroller_1") == 16000,
	"best trader override is considered without multiplying prices between traders")
check(
	ix.taskRewards.FixedMoney(delivery, 1) == 8500,
	"delivery cash is fifty percent of configured trader reference value"
)
ix.npctemplates = nil
ix.item.list.food = {name = "Food", price = 100, quantity = 5}
local foodJob = {requiredItem = "food", numberRec = 3, reward = {}, moneyReward = 0}
check(ix.taskRewards.FixedMoney(foodJob, 3) == 530, "stacked deliveries are valued per use, not per full stack")
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
check(foodOwner:GetJobs().NPC.deliveredValue == 60 and foodOwner:GetJobs().NPC.moneyReward == 530,
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
local oldTown = ix.townNPCs
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_regionaljobs.lua")
local themed = {map = "rp_marsh_cs", wantedItems = {food = true}}
ix.townNPCs = {byName = {NPC = {map = "rp_marsh_cs"}, Themed = themed},
	CanInteract = function(_, _, target) return not target.denied end}
local receiver = {GetDisplayName = function() return "Themed" end}
ix.jobs.list.alternate = {requiredItem = "food", alternateDelivery = true, issuerName = "NPC"}
local alternativeOwner = actor()
alternativeOwner.jobs.NPC = {identifier = "alternate", numberRec = 3, progress = 0}
local supplies = copy(food)
supplies.data.quantity, supplies.removed = 5, nil
function alternativeOwner.inventory:HasItem(id) if id == "food" then return supplies end end
check(not ix.taskRewards.DeliverJobItem(alternativeOwner.client, "NPC"), "valuable orders require a receiver")
receiver.denied = true
check(not ix.taskRewards.DeliverJobItem(alternativeOwner.client, "NPC", receiver), "receiver access is authoritative")
receiver.denied, themed.map = false, "rp_waystation"
check(not ix.taskRewards.DeliverJobItem(alternativeOwner.client, "NPC", receiver), "receiver must share issuer map")
themed.map, themed.wantedItems = "rp_marsh_cs", {}
check(not ix.taskRewards.DeliverJobItem(alternativeOwner.client, "NPC", receiver), "receiver must request the category")
themed.wantedItems.food = true
check(ix.taskRewards.DeliverJobItem(alternativeOwner.client, "NPC", receiver), "eligible alternate receiver accepts goods")
check(supplies.data.quantity == 2 and not supplies.removed, "alternate delivery preserves surplus units")
check(not ix.taskRewards.DeliverJobItem(alternativeOwner.client, "NPC", receiver), "completed alternate delivery cannot replay")
ix.jobs.list.wholeMeal = {requiredItem = "food", wholeItems = true}
alternativeOwner.jobs.NPC = {identifier = "wholeMeal", numberRec = 1, progress = 0}
supplies.removed = nil
check(ix.taskRewards.DeliverJobItem(alternativeOwner.client, "NPC") and supplies.removed,
	"whole-item requests consume one item rather than its saved use quantity")
ix.townNPCs = oldTown
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
check(not hunter:GetData("taskRewardOffers")[preview.rewardKey].selected,
	"acceptance reserves no reward")
check(not ix.taskRewards.SelectOffer(hunter, "'Old Timer'", preview.rewardKey, 1),
	"unfinished accepted tasks cannot select rewards")
local rewardChoiceOwner = actor()
local choicePreview = ix.taskRewards.PreviewJob(rewardChoiceOwner, "'Old Timer'", "easy", {"hunting"})
check(not ix.taskRewards.AcceptJob(rewardChoiceOwner.client, "'Old Timer'", "easy", 1),
	"acceptance rejects attempts to choose a hidden reward")
check(ix.taskRewards.AcceptJob(rewardChoiceOwner.client, "'Old Timer'", "easy"), "task accepts without a reward")
local acceptedChoice = rewardChoiceOwner:GetJobs()["'Old Timer'"]
local restoredChoice = actor()
restoredChoice.data, restoredChoice.jobs = copy(rewardChoiceOwner.data), copy(rewardChoiceOwner.jobs)
check(not ix.taskRewards.SelectOffer(restoredChoice, "'Old Timer'", acceptedChoice.rewardKey, 1),
	"reconnecting cannot reveal or reserve an unfinished task reward")
local jobs = hunter:GetJobs()
check(jobs["'Old Timer'"].numberRec == preview.numberRec, "accepted count matches the displayed count")
check(not ix.taskRewards.AcceptJob(hunter.client, "'Old Timer'", "easy", 1), "accepted preview cannot be replayed")
jobs["'Old Timer'"].isCompleted = true
hunter:SetJobs(jobs)
finishJob(hunter, "'Old Timer'")
check(hunter.money == 14 and hunter.client.rep == 7, "job cash and reputation pay once")
check(#hunter.inventory.received >= 1 and #hunter.inventory.received <= 2, "completion delivers one or two supplies")
for _, reward in ipairs(hunter.inventory.received) do check(not reward.item:match("^kit_"), "jobs emit no kits") end
local received = #hunter.inventory.received
finishJob(hunter, "'Old Timer'")
check(hunter.money == 14 and #hunter.inventory.received == received, "job completion cannot be replayed")
local lateChoice = actor()
local latePreview = ix.taskRewards.PreviewJob(lateChoice, "'Old Timer'", "easy", {"hunting"})
check(
	ix.taskRewards.AcceptJob(lateChoice.client, "'Old Timer'", "easy"),
	"acceptance does not require a reward selection"
)
lateChoice.inventory.full = true
local lateJobs = lateChoice:GetJobs()
lateJobs["'Old Timer'"].isCompleted = true
lateChoice:SetJobs(lateJobs)
finishJob(lateChoice, "'Old Timer'")
check(#lateChoice.inventory.received == 0, "full inventory preserves the assigned supply for later")
lateChoice.inventory.full = false
check(ix.taskRewards.ClaimNext(lateChoice), "chosen supply remains claimable after the task finishes")
check(#lateChoice.inventory.received == 1, "late claim delivers the assigned item once")
check(ix.taskRewards.SupplyBudget({moneyReward = 100, reward = {}}, 1) == 600,
	"easy tasks have a useful six-hundred-ruble minimum supply allowance")
local largerJob = {moneyReward = 10000, reward = {}}
check(ix.taskRewards.SupplyBudget(largerJob, 1) == ix.taskRewards.FixedMoney(largerJob, 1),
	"larger allowances use one hundred percent of reference cash")
for _, budget in ipairs({20, 40, 60, 80, 100}) do
	for seed = 1, 5 do
		for _, choice in ipairs(ix.taskRewards.BuildJobChoices(owner, "'Old Timer'", budget, "ammo:" .. seed)) do
			local reward = choice.items[1]
			local item = ix.item.list[reward.item]
			if item.isAmmo then
				check(#choice.items == 1 and reward.data.quantity == item.ammoAmount / 2,
					"larger allowances never increase ammunition above a half-pack")
			end
		end
	end
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
check(quantities["9x18"] == 30 and quantities["545x39"] == nil and quantities["12gauge"] == 15,
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
oldOffers[oldPreview.rewardKey].version = nil
oldPreviewOwner:SetData("taskRewardOffers", oldOffers)
local upgradedPreview = ix.taskRewards.PreviewJob(oldPreviewOwner, "'Old Timer'", "easy", {"hunting"})
check(upgradedPreview.supplyBudget == 600 and upgradedPreview.rewardKey == oldPreview.rewardKey
	and upgradedPreview.numberRec == oldPreview.numberRec, "old unaccepted previews receive larger supplies without rerolling the task")
check(#oldPreviewOwner:GetData("taskRewardOffers")[oldPreview.rewardKey].choices == 0,
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
	active[npc].isCompleted = true
	bonusOwner:SetJobs(active)
	check(ix.taskRewards.RevealJobOffer(bonusOwner.client, npc), "completed job reveals reward choices")
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
	finishJob(bonusOwner, npc)
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
check(previewPacket[1] == target and previewPacket[2] == "easy" and previewPacket[4] == 0,
	"network preview transmits zero reward choices")
local shownPreview = viewer:GetData("taskJobPreviews")["'Old Timer'"].easy
local shownOffer = viewer:GetData("taskRewardOffers")[shownPreview.rewardKey]
check(#shownOffer.choices == 0 and shownPreview.rewardChoices == nil,
	"replicated offer and preview contain no hidden reward details")
check(previewPacket[3]:find("revealed", 1, true), "confirmation explains when rewards are revealed")
check(not ix.taskRewards.AcceptJob(viewer.client, "'Old Timer'", "easy", 999),
	"acceptance rejects a supplied reward choice")
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
check(#confirmation == 2 and confirmation[1].statement == "Accept task"
	and confirmation[1].dyndata.choice == nil, "acceptance screen displays one assigned supply without a choice index")
check(not ix.taskRewards.AcceptJob(viewer.client, "'Old Timer'", "easy", 900),
	"invalid preview supply choice cannot accept a job")
check(not viewer:GetJobs()["'Old Timer'"], "invalid preview choice leaves the task unaccepted")
check(ix.taskRewards.AcceptJob(viewer.client, "'Old Timer'", "easy"), "preview can be accepted with its random supply")
check(viewer:GetData("taskRewardOffers")[viewer:GetJobs()["'Old Timer'"].rewardKey].selected == shownPreview.supplyChoice,
	"no reward is reserved at acceptance")
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
for _, itemID in ipairs({"attachment_reward_test", "hidestasher_reward_test", "rewardEquipment"}) do
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
	and refreshed.rewardChoices == nil, "unaccepted previews refresh their catalogue")
check(
	ix.taskRewards.AcceptJob(catalogueOwner.client, "'Old Timer'", "easy"),
	"updated catalogue preview can be accepted"
)
local acceptedCatalogue = catalogueOwner:GetJobs()["'Old Timer'"]
local acceptedLabel = #catalogueOwner:GetData("taskRewardOffers")[acceptedCatalogue.rewardKey].choices
check(not ix.taskRewards.PreviewJob(catalogueOwner, "'Old Timer'", "easy", {"hunting"}),
	"active assignments prevent preview migrations")
check(#catalogueOwner:GetData("taskRewardOffers")[acceptedCatalogue.rewardKey].choices == acceptedLabel,
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
check(fieldPreview and fieldPreview.rewardKey and fieldPreview.rewardChoices == nil,
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
		local item = {name = id, base = baseID, price = tonumber(text:match("ITEM.price = ([%d%.]+)")) or parent.price or 100,
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
		check(contact.rewards and (contact.rewards.cashPerTier or #contact.rewards.packages > 0),
			"each contact has explicit regular rewards")
		for _, packages in ipairs({contact.rewards.packages, contact.rewards.bonusPackages or contact.rewards.packages}) do
			for _, package in ipairs(packages) do
				for _, id in ipairs(package.items) do
					loadReward(id)
					check(ix.taskRewards.IsConsumableSupply(id), "town rewards are consumable: " .. id)
				end
			end
		end
		check(not contact.rewards.bonusItems and not contact.rewards.bonusService,
			"reusable equipment and services have no town reward routes")
		ix.taskRewards.SetTownProfile(contact.name, contact.rewards)
	end
	check(count == 27, "reward policies cover all 27 contacts including legacy issuers")
	local recipient = actor()
	local record = ix.progression.GetCharacterProgression(recipient)
	record.lines["cotz/town/old-timer/OT19"] = {completed = true}
	record.lines["cotz/town/smartass/SM07"] = {completed = true}
	ix.progression.SetCharacterProgression(recipient, record)
	for _, contact in pairs(contacts) do
		for _, budget in ipairs({600, 1500, 10000}) do
			for serial = 1, 10 do
				local choices = ix.taskRewards.BuildJobChoices(recipient, contact.name, budget, "theme:" .. serial, 1)
				check(#choices > 0 and #choices <= 3, "every contact offers affordable regular rewards")
				for _, choice in ipairs(choices) do
					check(ix.taskRewards.ChoiceValue(choice) <= budget, "regular choices respect their allowance")
					for _, reward in ipairs(choice.items) do
						check(ix.taskRewards.IsConsumableSupply(reward.item), "ordinary items are consumable")
						local item = ix.item.list[reward.item]
						if item.isAmmo then
							check(reward.data.quantity == item.ammoAmount / 2,
								"every town ammunition reward is a half-pack")
						end
					end
				end
			end
		end
		for _, choice in ipairs(ix.taskRewards.BuildBonusChoices(recipient, contact.name, 15000, "bonus:theme")) do
			check(not choice.services, "new town bonuses never issue service credit")
			for _, reward in ipairs(choice.items) do
				check(ix.taskRewards.IsConsumableSupply(reward.item), "bonus items are consumable")
				local item = ix.item.list[reward.item]
				if item.isAmmo then
					check(reward.data.quantity == item.ammoAmount / 2, "bonus ammunition is also a half-pack")
				end
			end
		end
	end
	local function offered(choices, id)
		for _, choice in ipairs(choices) do
			for _, reward in ipairs(choice.items) do if reward.item == id then return true end end
		end

		return false
	end
	local cleaner = ix.taskRewards.SupplyCatalogue(recipient, "'Cleaner'")
	check(includes(cleaner, "hidestasher_cutlery") and includes(cleaner, "hidestasher_cleaningkit"),
		"Cleaner retains cutlery and cleaning kits")
	check(not includes(cleaner, "hidestash_1"), "Cleaner never gives stash spawners for ordinary work")
	local cleanerBonus = ix.taskRewards.BuildBonusChoices(recipient, "'Cleaner'", 10000, "bonus:cleaner")
	for _, id in ipairs({"hidestash_1", "hidestash_2", "hidestash_3"}) do
		check(offered(cleanerBonus, id), "Cleaner can offer each affordable stash tier as a bonus")
	end
	check(includes(ix.taskRewards.SupplyCatalogue(recipient, "'Spicy Lemon'"), "hidestasher_cutlery"),
		"Spicy Lemon offers cutlery")
	local oldTimer = ix.taskRewards.SupplyCatalogue(recipient, "'Old Timer'")
	check(includes(oldTimer, "45acp41") and not includes(oldTimer, "12gauge") and not includes(oldTimer, "22lr"),
		"Old Timer's only ammunition is .410")
	for _, choice in ipairs(ix.taskRewards.BuildJobChoices(recipient, "'Old Timer'", 10000, "410:half")) do
		for _, reward in ipairs(choice.items) do
			if reward.item == "45acp41" then check(reward.data.quantity == 10, ".410 awards ten shells") end
		end
	end
	loadReward("value_bolts")
	check(not ix.taskRewards.IsConsumableSupply("value_bolts"), "ordinary valuables are never rewards")
	ix.item.list.food_fake = {name = "Disguised valuable", base = "base_valuable", quantity = 2}
	check(not ix.taskRewards.IsConsumableSupply("food_fake"), "valuable inheritance cannot masquerade as a consumable")
	check(ix.taskRewards.IsConsumableSupply("value_currency_euro")
		and ix.taskRewards.IsConsumableSupply("value_currency_dollar"), "euros and dollars are explicit exceptions")
	ix.progression.definitions.themeLeak = {vendorUnlocks = {{npc = "'Technut'", args = {"medic_antirad_1"}}}}
	check(not includes(ix.taskRewards.SupplyCatalogue(recipient, "'Technut'"), "medic_antirad_1"),
		"shop catalogues do not alter the dedicated reward list")
	ix.progression.definitions.themeLeak = nil
	for _, npc in ipairs({"'Mute'", "'Spool'", "'Ballast'"}) do
		for tier = 1, 3 do
			local cashOwner = actor()
			cashOwner.data.progression = copy(recipient.data.progression)
			local unlocked = ix.progression.GetCharacterProgression(cashOwner)
			unlocked.lines["cotz/town/old-timer/OT19"] = {completed = true}
			ix.progression.SetCharacterProgression(cashOwner, unlocked)
			local budget = ({600, 1100, 1650})[tier]
			ix.jobs.list.cashFlow = {name = "Complete cash work", desc = "Work", numberRec = 1,
				moneyReward = 1000 * tier, repReward = 15, reward = {}, tier = tier}
			for serial = 1, 5 do
				check(cashOwner.client:ixJobAdd("cashFlow", npc), "cash task can be accepted")
				local job = cashOwner.jobs[npc]
				local offer = cashOwner:GetData("taskRewardOffers")[job.rewardKey]
				check(#offer.choices == 0 and not job.rewardChoices, "cash reward stays secret before completion")
				check(not ix.taskRewards.SelectOffer(cashOwner, npc, job.rewardKey, 1),
					"hidden reward cannot be chosen early")
				job.isCompleted = true
				check(cashOwner.client:ixJobComplete(npc) == false, "hand-in first reveals choices without paying")
				offer = cashOwner:GetData("taskRewardOffers")[job.rewardKey]
				check(#offer.choices == 1 and offer.choices[1].money == 200 * tier
					and #offer.choices[1].items == 0, "cash-only contacts offer 200 rubles per difficulty tier")
				local beforeMoney = cashOwner.money
				check(ix.taskRewards.SelectOffer(cashOwner, npc, job.rewardKey, 1), "reward selection finishes hand-in")
				check(cashOwner.money == beforeMoney + 550 * tier + 200 * tier,
					"cash reward is paid in addition to ordinary job payment")
				check(not ix.taskRewards.SelectOffer(cashOwner, npc, job.rewardKey, 1), "cash claims cannot replay")
				if serial < 5 then
					for key in pairs(cashOwner:GetData("taskRewardOffers")) do
						check(not key:match("^bonus:"), "bonus is not revealed before five completions")
					end
				else
					local bonus = cashOwner:GetData("taskRewardOffers")["bonus:" .. job.progressionClaim]
					check(bonus and bonus.budget == 5 * (budget - 200 * tier),
						"the actual regular cash reward is excluded from the bonus allowance")
					check(#bonus.choices == 2, "cash-only contacts offer euros or dollars for the bonus")
					for _, choice in ipairs(bonus.choices) do
						local reward = choice.items[1]
						check(not choice.money and #choice.items == 1,
							"their bonus never substitutes rubles or unrelated items")
						check(reward.item == "value_currency_euro" or reward.item == "value_currency_dollar",
							"bonus uses only the allowed foreign currencies")
						local unit = reward.item == "value_currency_euro" and 52 or 38
						check(reward.data.quantity == math.floor(bonus.budget / unit),
							"currency quantities match the agreed conversion values")
					end
					cashOwner.inventory.full = true
					local key = "bonus:" .. job.progressionClaim
					check(ix.taskRewards.SelectOffer(cashOwner, npc, key, 1), "currency bonus can enter the claim queue")
					check(#ix.progression.GetLine(cashOwner, "taskRewardClaims").pendingRewards == 1,
						"full inventories retain foreign currency with its exact quantity")
					cashOwner.inventory.full = false
					check(ix.taskRewards.ClaimNext(cashOwner), "queued currency can be recovered")
				end
			end
		end
	end
	local hiddenOwner = actor()
	check(hiddenOwner.client:ixJobAdd("hunt", "'Old Timer'"), "hidden item reward task accepts")
	local hiddenJob = hiddenOwner.jobs["'Old Timer'"]
	local key = hiddenJob.rewardKey
	local oldOffers = hiddenOwner:GetData("taskRewardOffers")
	oldOffers[key].version, oldOffers[key].selected = 4, 1
	oldOffers[key].choices = {{label = "Obsolete bolts", items = {{item = "value_bolts"}}}}
	hiddenOwner:SetData("taskRewardOffers", oldOffers)
	hiddenJob.rewardChoices, hiddenJob.supplyChoice = oldOffers[key].choices, 1
	ix.taskRewards.ReconcileCharacter(hiddenOwner)
	check(#hiddenOwner:GetData("taskRewardOffers")[key].choices == 0
		and hiddenOwner.jobs["'Old Timer'"].rewardChoices == nil, "migration hides obsolete preselected rewards")
	check(hiddenOwner.jobs["'Old Timer'"].rewardKey == key, "migration preserves the active assignment identity")
	hiddenOwner.jobs["'Old Timer'"].isCompleted = true
	rewardNPCDenied = true
	check(not ix.taskRewards.RevealJobOffer(hiddenOwner.client, "'Old Timer'"), "inaccessible NPC cannot reveal rewards")
	rewardNPCDenied = false
	check(ix.taskRewards.RevealJobOffer(hiddenOwner.client, "'Old Timer'"), "completed task reveals item choices")
	local revealed = hiddenOwner:GetData("taskRewardOffers")[key]
	local restored = actor()
	restored.data, restored.jobs = copy(hiddenOwner.data), copy(hiddenOwner.jobs)
	ix.taskRewards.ReconcileCharacter(restored)
	check(restored:GetData("taskRewardOffers")[key].choices[1].label == revealed.choices[1].label,
		"revealed choices survive reconnect without rerolling")
	local beforeMoney = hiddenOwner.money
	rewardNPCDenied = true
	check(not ix.taskRewards.SelectOffer(hiddenOwner, "'Old Timer'", key, 1), "remote reward selection is rejected")
	check(hiddenOwner.money == beforeMoney and hiddenOwner.jobs["'Old Timer'"], "failed selection preserves the job")
	rewardNPCDenied = false
	hiddenOwner.client.owner = actor()
	check(not ix.taskRewards.SelectOffer(hiddenOwner, "'Old Timer'", key, 1),
		"a character switch prevents a stale reward claim")
	hiddenOwner.client.owner = hiddenOwner
	check(ix.taskRewards.SelectOffer(hiddenOwner, "'Old Timer'", key, 1), "valid selection completes the job")
end

local bonusCashOwner = actor()
local cashChoices = ix.taskRewards.BuildBonusChoices(bonusCashOwner, "'Boss'", 1000, "bonus:cash-policy")
local cashIndex
for index, choice in ipairs(cashChoices) do if choice.money then cashIndex = index end end
check(cashIndex ~= nil, "approved contacts offer an explicit bonus cash alternative")
bonusCashOwner:SetData("leaderboardStats", {taskEarnings = 123})
bonusCashOwner:SetData("taskRewardOffers", {["bonus:cash-policy"] = {npc = "'Boss'", earned = true,
	budget = 1000, version = ix.taskRewards.SupplyCatalogueVersion(), choices = cashChoices}})
check(ix.taskRewards.SelectOffer(bonusCashOwner, "'Boss'", "bonus:cash-policy", cashIndex),
	"bonus cash can be claimed")
check(bonusCashOwner.money == 1000 and #bonusCashOwner.inventory.received == 0,
	"the cash alternative awards only its stated ruble amount")
check(bonusCashOwner:GetData("leaderboardStats").taskEarnings == 123,
	"bonus cash is excluded from ordinary task earnings statistics")
check(not ix.taskRewards.SelectOffer(bonusCashOwner, "'Boss'", "bonus:cash-policy", cashIndex),
	"bonus cash cannot be claimed twice")
local queueOwner = actor()
check(queueOwner.client:ixJobAdd("hunt", "'Old Timer'"), "queue-capacity fixture accepts work")
local queueJob = queueOwner.jobs["'Old Timer'"]
queueJob.isCompleted = true
local queuedRecord = ix.progression.GetCharacterProgression(queueOwner)
queuedRecord.lines.taskRewardClaims = {pendingRewards = {}}
for index = 1, ix.taskRewards.settings.maxPendingRewards do
	queuedRecord.lines.taskRewardClaims.pendingRewards[index] = {item = "food", token = "occupied:" .. index}
end
ix.progression.SetCharacterProgression(queueOwner, queuedRecord)
queueOwner.inventory.full = true
finishJob(queueOwner, "'Old Timer'")
local held = queueOwner:GetData("taskRewardOffers")[queueJob.rewardKey]
check(held and held.earned and held.selected == 1 and held.retrySelected,
	"a full claim queue retains the selected earned entitlement")
check(not ix.taskRewards.SelectOffer(queueOwner, "'Old Timer'", queueJob.rewardKey, 2),
	"a queued entitlement cannot change reward and invalidate the credited bonus allowance")
local interruptedOffers = queueOwner:GetData("taskRewardOffers")
interruptedOffers[queueJob.rewardKey].retrySelected = nil
queueOwner:SetData("taskRewardOffers", interruptedOffers)
ix.taskRewards.ReconcileCharacter(queueOwner)
check(queueOwner:GetData("taskRewardOffers")[queueJob.rewardKey].retrySelected,
	"an interrupted selected claim becomes recoverable after restart")
local paidCash = queueOwner.money
queuedRecord = ix.progression.GetCharacterProgression(queueOwner)
queuedRecord.lines.taskRewardClaims.pendingRewards = {}
ix.progression.SetCharacterProgression(queueOwner, queuedRecord)
check(ix.taskRewards.SelectOffer(queueOwner, "'Old Timer'", queueJob.rewardKey, 1),
	"the retained entitlement can be claimed after queue space opens")
check(queueOwner.money == paidCash and ix.taskRewards.TraderBonusProgress(queueOwner, "'Old Timer'").count == 1,
	"retrying a reward cannot repeat task payment or bonus progress")
local secretDescription = ix.jobs.getFormattedDesc({identifier = "hunt", numberRec = 1, moneyReward = 14,
	rewardChoices = {{label = "Secret item", items = {}}}})
check(not secretDescription:find("Secret item", 1, true), "the journal never displays old cached reward labels")
local secretBonusStatus = ix.taskRewards.BonusStatus(queueOwner, "'Old Timer'")
check(not secretBonusStatus:find("rubles", 1, true), "bonus progress hides reward value before it is earned")

local directRewards = dialogue.tree.TaskRewardChoices.GetDynamicOptions(nil, rootRewardOwner.client, target)
local rootRewards = dialogue.tree.GREETING.GetDynamicOptions(nil, rootRewardOwner.client, target)
check(#rootRewards == #directRewards, "reward actions appear directly at the root")
ix.dialogue.ConfigureTaskRewards(dialogue)
check(#dialogue.tree.GREETING.GetDynamicOptions(nil, rootRewardOwner.client, target) == #directRewards,
	"reconfiguring a dialogue does not duplicate direct reward actions")
for tier, base in ipairs({500, 1000, 1500}) do
	local request = {requiredItem = "food", wholeItems = true, numberRec = 2, tier = tier}
	check(ix.taskRewards.FixedMoney(request, 2) == base + 100,
		"each delivery tier adds its base to half the price of two whole meals")
	check(ix.taskRewards.SupplyBudget(request, 2) == math.max(600, base),
		"item reimbursement does not increase the supply allowance")
end
local handInBonus = actor()
handInBonus:SetData("taskRewardOffers", {["job:handin"] = {npc = "'Old Timer'", selected = 1,
	choices = {{items = {{item = "food"}}}}}})
ix.taskRewards.RecordCompletion(handInBonus, "'Old Timer'", {identifier = "hand", numberRec = 1,
	progressionClaim = 1, rewardKey = "job:handin", supplyBudget = 10000, moneyReward = 6400, deliveredValue = 11800})
check(ix.taskRewards.TraderBonusProgress(handInBonus, "'Old Timer'").budget
	== 600 - ix.taskRewards.ExpectedValue("food"),
	"accepted old hand-in allowances cannot put reimbursement into the bonus")
local paidHandIn = actor()
local paidJob = {identifier = "hand", numberRec = 1, deliveredValue = 11800}
ix.taskRewards.PrepareJob(paidHandIn, "'Old Timer'", paidJob)
paidJob.isCompleted = true
paidJob.moneyReward = 5900
paidHandIn.jobs["'Old Timer'"] = paidJob
ix.taskRewards.SelectOffer(paidHandIn, "'Old Timer'", paidJob.rewardKey, 1)
finishJob(paidHandIn, "'Old Timer'")
check(paidHandIn.money == 6400 and #paidHandIn.inventory.received > 0,
	"saved hand-ins receive the base and reimbursement without deducting their item reward")
finishJob(paidHandIn, "'Old Timer'")
check(paidHandIn.money == 6400, "hand-in payment cannot be repeated")
local triggerOwner = actor()
triggerOwner.jobs.NPC = {identifier = "hunt", listenTrigger = "hunt", numberRec = 1, progress = 0}
triggerOwner.client:ixJobEvaluate("hunt")
check(triggerOwner.client.message:find("Task completed:", 1, true)
	and triggerOwner.jobs.NPC.completionNotified, "ordinary item/tool triggers announce readiness")
triggerOwner.client.message = nil
triggerOwner.client:ixJobEvaluate("hunt")
check(triggerOwner.client.message == nil, "repeated triggers do not announce a completed task again")
print("PASS: " .. checks .. " task reward checks")
