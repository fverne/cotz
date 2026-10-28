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
dofile(base .. "libs/sh_expansion.lua")
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
check(api.ExpectedValue("drug_codeine", {quantity = 2}) == 20, "removed codeine has an explicit legacy valuation")
ix.randomitems.tables.default = {{1, {"22lr", {quantity = 2}}}}
ix.item.list.kit_reward_master = {items = {{{1, "task_reward_weapon_08_high"}}}}
check(api.ExpectedValue("kit_reward_master") == 4, "disabled master pool preserves its former default-pool fallback")
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
		local supplies = api.BuildJobChoices(owner, "'Old Timer'", tier, "job:" .. serial)
		for _, choice in ipairs(supplies) do
			check(#choice.items == 1, "job choices always contain one inventory item")
			local reward = choice.items[1]
			local item = ix.item.list[reward.item]
			check(reward.item ~= "bagrubles", "job supplies never top up legacy value with cash")
			check(reward.data.quantity >= 1 and reward.data.quantity <= (item.quantity or item.ammoAmount),
				"job uses and ammunition stay within normal item capacity")
		end
	end
end
ix.progression.definitions.gunGate = {vendorUnlocks = {{npc = "'Old Timer'", args = {"rifle"}}}}
local singleWeapon = api.BuildJobChoices(owner, "'Old Timer'", 1, "job:weapon")
local weapon = singleWeapon[#singleWeapon].items[1]
check(weapon.item == "rifle" and #singleWeapon[#singleWeapon].items == 1,
	"job equipment is a single unlocked weapon with no cash remainder")
check(weapon.data.durability >= 30 and weapon.data.durability <= 60
	and weapon.data.wear == weapon.data.durability, "weapon has explicit tier-based durability and wear")
check(api.BuildJobChoices(owner, "'Old Timer'", 1, "job:weapon")[#singleWeapon].label
	== singleWeapon[#singleWeapon].label, "job item condition is stable when reopened")
ix.progression.definitions.gunGate = nil
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
local legacy = actor()
kit(legacy, 77)
local kitChoice = api.BuildChoices(legacy, "'Haggler'", api.ExpectedValue("kit_reward_demo"), "kit:77")[1]
check(not api.RedeemKit(legacy, "'Haggler'", 77, 1, "changed"), "stale kit quote does not consume it")
check(legacy.inventory.items[77], "rejected redemption preserves the owned kit")
check(api.RedeemKit(legacy, "'Haggler'", 77, 1, kitChoice.label), "legacy kit redeems without paying an upgrade fee")
check(not api.RedeemKit(legacy, "'Haggler'", 77, 1, kitChoice.label), "same kit cannot redeem twice")
check(not api.RedeemKit(actor(), "'Haggler'", 77, 1, kitChoice.label), "other character cannot redeem an unowned kit")

ix.npcbarter = {barterdict = {["'Haggler'"] = {powder = {
	barterItem = {"kit_reward_demo", 1}, reqItem = {"powder", 2},
}}}, activebarters = {powder = true}}
local consumed = 0
ix.npcbarter.ConsumeItems = function(_, _, amount) consumed = consumed + amount return true end
local barterChoice = api.BarterChoices(legacy, "'Haggler'", "powder", ix.npcbarter.barterdict["'Haggler'"].powder)[1]
check(barterChoice, "kit barter exposes explicit ammunition choices")
check(not api.ExecuteBarter(legacy, "'Haggler'", "powder", 1, "wrong"), "stale barter quote is rejected")
check(consumed == 0, "invalid barter consumes no inputs")
check(api.ExecuteBarter(legacy, "'Haggler'", "powder", 1, barterChoice.label), "converted barter grants chosen ammo")
check(consumed == 2, "converted barter preserves input quantity")
ix.npcbarter.activebarters.powder = false
check(not api.ExecuteBarter(legacy, "'Haggler'", "powder", 1, barterChoice.label), "inactive recipe cannot execute")

-- Load the real job path with its legacy GLua operators translated for the standalone Lua runtime.
local handle = assert(io.open("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_jobs.lua"))
local source = handle:read("*a")
handle:close()
source = source:gsub("!=", "~="):gsub("!", "not ")
assert((loadstring or load)(source))()
ix.jobs.list.hunt = {name = "Hunt %d", desc = "Hunt %d mutants", numberRec = {2, 5},
	reward = {{"kit_reward_demo"}, 0}, repReward = 7, moneyReward = {10, 20}}
ix.jobs.jobsbycategory.hunting = {"hunt"}
check(api.FixedMoney(ix.jobs.list.hunt, 4) == 14, "non-delivery jobs scale their cash and legacy allowance to fifty-five percent")
local hand = {price = 6700, pricepertier = 1700, name = "Swampcontroller Hand"}
function hand:GetPrice() return self.price + self.pricepertier * self:GetData("tier", 0) end
ix.item.list.part_swampcontroller_1 = hand
local delivery = {name = "Hand over %d hands", numberRec = 1, requiredItem = "part_swampcontroller_1",
	reward = {{"kit_reward_demo"}}, repReward = 5}
ix.jobs.list.hand = delivery
check(api.FixedMoney(delivery, 1) == 3685, "swampcontroller task cash is fifty-five percent of hand-in value")
check(api.FixedMoney(delivery, 3) == 11055, "cash floor covers every requested specimen")
check(ix.progression.HandInUnitValue("part_swampcontroller_1") == 4355,
	"progression hand cash is sixty-five percent of hand-in value")
local specimen = setmetatable({GetData = function(_, key, default)
	if key == "tier" then return 3 end

	return default
end}, {__index = hand})
check(api.HandInUnitValue("part_swampcontroller_1", specimen) == 11800,
	"actual specimen tier increases opportunity cost")
check(api.FixedMoney(delivery, 1, 11800) == 6490, "high-quality specimen scales the fifty-five percent cash payout")
ix.npctemplates = {templates = {one = {items = {part_swampcontroller_1 = {20000, nil, 3}}, scale = 0.8},
	two = {items = {part_swampcontroller_1 = {2, nil, 3}}}}}
check(api.HandInUnitValue("part_swampcontroller_1") == 16000,
	"best trader override is considered without multiplying prices between traders")
check(api.FixedMoney(delivery, 1) == 8800, "delivery cash is fifty-five percent of configured trader reference value")
ix.npctemplates = nil
ix.item.list.food = {name = "Food", price = 100, quantity = 5}
local foodJob = {requiredItem = "food", numberRec = 3, reward = {}, moneyReward = 0}
check(api.FixedMoney(foodJob, 3) == 33, "stacked deliveries are valued per use, not per full stack")
local foodOwner = actor()
foodOwner.jobs.NPC = {identifier = "food", numberRec = 3, progress = 0}
ix.jobs.list.food = foodJob
check(math.abs(ix.progression.HandInUnitValue("food") - 13) < 0.000001, "progression stacks are valued per consumed use")
ix.jobs.list.highFood = {requiredItem = "food", numberRec = {2, 5}, moneyReward = 2000, reward = {}}
check(math.abs(ix.progression.HandInUnitValue("food") - 13) < 0.000001,
	"old repeatable cash bonuses cannot increase the sixty-five percent progression rate")
ix.jobs.list.highFood = nil
local ammoJob = {requiredItem = "22lr", numberRec = 1, moneyReward = 100, reward = {}}
ix.jobs.list.ammoComparison = ammoJob
check(math.abs(ix.progression.HandInUnitValue("22lr") * ix.item.list["22lr"].ammoAmount - 13) < 0.000001,
	"progression ammunition pays sixty-five percent of a full box per consumed round")
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
check(foodOwner:GetJobs().NPC.deliveredValue == 60 and foodOwner:GetJobs().NPC.moneyReward == 33,
	"actual hand-in value and payout are saved with progress")
check(not api.DeliverJobItem(foodOwner.client, "NPC"), "completed task cannot consume more items")
callbacks.ix_JobTrigger = nil
local activeLegacy = actor()
activeLegacy.jobs["'Old Timer'"] = {identifier = "hunt", numberRec = 4, progress = 2, isCompleted = false}
api.PrepareExistingJobs(activeLegacy)
local migrated = activeLegacy:GetJobs()["'Old Timer'"]
check(migrated.numberRec == 4 and migrated.progress == 2 and migrated.rewardPrepared,
	"active-job migration saves choices without changing existing work")
local obsolete = actor()
obsolete.jobs["'Old Timer'"] = {identifier = "hunt", numberRec = 4, progress = 2,
	rewardKey = "job:old", rewardPrepared = true}
obsolete.data.taskRewardOffers = {["job:old"] = {npc = "'Old Timer'", selected = 1, earned = true,
	choices = {{label = "192 bandages", items = {{item = "medic_bandage_1", data = {quantity = 192}}}}}}}
api.PrepareExistingJobs(obsolete)
local replacement = obsolete:GetData("taskRewardOffers")["job:old"]
check(replacement.earned and not replacement.selected, "old job entitlement survives but requires a fresh selection")
for _, choice in ipairs(replacement.choices) do
	check(#choice.items == 1, "previously prepared oversized job offers are replaced")
end
check(#obsolete.inventory.received == 0, "replacing an old offer pays nothing automatically")
local moneyOnly = activeLegacy:GetJobs()
moneyOnly["'Old Timer'"].moneyVersion = nil
moneyOnly["'Old Timer'"].moneyReward = 15
activeLegacy:SetJobs(moneyOnly)
api.PrepareExistingJobs(activeLegacy)
check(activeLegacy:GetJobs()["'Old Timer'"].moneyReward == 14,
	"existing single-item jobs also receive the cash migration")
local oldHighCash = actor()
oldHighCash.jobs["'Old Timer'"] = {identifier = "hand", numberRec = 1, progress = 0,
	moneyReward = 99999, moneyVersion = 2, rewardVersion = api.JOB_REWARD_VERSION,
	rewardKey = "job:old-high-cash", progressionClaim = 1}
api.PrepareExistingJobs(oldHighCash)
check(oldHighCash:GetJobs()["'Old Timer'"].moneyReward == 3685,
	"existing oversized repeatable cash quotes are reduced to fifty-five percent")
local oldHighJobs = oldHighCash:GetJobs()
oldHighJobs["'Old Timer'"].deliveredValue = 11800
oldHighJobs["'Old Timer'"].moneyVersion = 1
oldHighCash:SetJobs(oldHighJobs)
api.PrepareExistingJobs(oldHighCash)
check(oldHighCash:GetJobs()["'Old Timer'"].moneyReward == 6490,
	"cash migration preserves recorded specimen quality at the reduced rate")
local migrationSaves = activeLegacy.saves
api.PrepareExistingJobs(activeLegacy)
check(activeLegacy.saves == migrationSaves and #activeLegacy.inventory.received == 0,
	"migration is idempotent and pays no early rewards")
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
check(api.SelectOffer(hunter, "'Old Timer'", preview.rewardKey, 1),
	"accepted task allows supply selection")
check(api.SelectOffer(hunter, "'Old Timer'", preview.rewardKey, 2),
	"accepted task allows changing the supply selection")
local jobs = hunter:GetJobs()
check(jobs["'Old Timer'"].numberRec == preview.numberRec, "accepted count matches the displayed count")
check(not api.AcceptJob(hunter.client, "'Old Timer'", "easy", 1), "accepted preview cannot be replayed")
jobs["'Old Timer'"].isCompleted = true
hunter:SetJobs(jobs)
hunter.client:ixJobComplete("'Old Timer'")
check(hunter.money == 14 and hunter.client.rep == 7, "job cash and reputation pay once")
check(#hunter.inventory.received == 1, "job completion delivers exactly one supply item")
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
dofile("gamemodes/ix_cotz/plugins/dialogue/libs/sh_dialogue.lua")
dofile("gamemodes/ix_cotz/plugins/dialogue/libs/sh_taskrewards.lua")
local dialogue = {tree = {GREETING = {options = {"GOODBYE"}},
	BackTopic = {options = {"GOODBYE"}}, GetTaskByDifficulty = {}}}
dialogue.addTopic = function(id, data) dialogue.tree[id] = data end
ix.dialogue.ConfigureTaskRewards(dialogue)
check(dialogue.tree.GREETING.options[1] == "TaskRewardChoices"
	and dialogue.tree.GREETING.options[2] == "GOODBYE", "reward menu keeps goodbye last")
check(not dialogue.tree.TaskRewardChoices.ShouldAdd(), "task supplies entry is hidden for NPCs without a work topic")
local viewer = actor()
local position = {DistToSqr = function() return 0 end}
function viewer.client:GetPos() return position end
local target = {GetClass = function() return "ix_vendor_adv" end,
	CanAccess = function() return true end, GetPos = function() return position end,
	GetDisplayName = function() return "'Old Timer'" end,
	GetNetVar = function() return {easy = {"hunting"}} end}
dialogue.tree.GetTaskByDifficulty.preCallback(nil, viewer.client, target)
local listPacket = packets[1].values
check(packets[1].name == "cotz/dialogue/task-list" and listPacket[1] == target and listPacket[2] == 1,
	"work menu sends actual offers only for configured categories")
check(listPacket[3] == "easy" and listPacket[4]:find("Hunt ", 1, true)
	and listPacket[4]:find("rubles", 1, true) and not listPacket[4]:find("reputation", 1, true)
	and listPacket[4]:find("supplies:", 1, true), "task row shows its requirement, cash and supplies without reputation")
viewer.client.cotzTaskRewardNext = nil
dialogue.tree.GetTaskByDifficulty.preCallback(nil, viewer.client, target)
check(packets[2].values[4] == listPacket[4], "reopening the work menu preserves the offered task and rewards")
viewer.client.cotzTaskRewardNext = nil
dialogue.tree.GetTaskByDifficulty.ResolveDynamicOption(nil, viewer.client, target, {difficulty = "easy"})
check(packets[3].name == "cotz/dialogue/task-offer", "choosing a listed task sends its authoritative preview")
check(not viewer:GetJobs()["'Old Timer'"], "network preview has no task acceptance side effect")
local previewPacket = packets[3].values
check(previewPacket[1] == target and previewPacket[2] == "easy" and previewPacket[4] == 1,
	"preview reveals exactly one random supply")
local shownPreview = viewer:GetData("taskJobPreviews")["'Old Timer'"].easy
local shownOffer = viewer:GetData("taskRewardOffers")[shownPreview.rewardKey]
check(previewPacket[5] == shownOffer.choices[shownPreview.supplyChoice].label,
	"confirmation shows the exact supply randomly assigned by the server")
check(not previewPacket[3]:find("reputation", 1, true) and previewPacket[3]:find("rubles", 1, true),
	"confirmation keeps cash visible and hides reputation")
check(listPacket[4]:find(previewPacket[5], 1, true)
	and previewPacket[3]:find("Supplies: " .. previewPacket[5], 1, true),
	"task list and NPC dialogue both show the same assigned supply reward")
check(not previewPacket[3]:find("restock", 1, true) and not listPacket[4]:find("restock", 1, true),
	"task reward text does not mention vendor restocking")
local otherSupply = shownPreview.supplyChoice % #shownOffer.choices + 1
check(not api.AcceptJob(viewer.client, "'Old Timer'", "easy", otherSupply),
	"acceptance cannot substitute a different supply for the server's random choice")
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
	and not confirmation[1].dyndata.choice, "acceptance screen displays one assigned supply without a choice index")
check(not api.AcceptJob(viewer.client, "'Old Timer'", "easy", 900),
	"invalid preview supply choice cannot accept a job")
check(not viewer:GetJobs()["'Old Timer'"], "invalid preview choice leaves the task unaccepted")
check(api.AcceptJob(viewer.client, "'Old Timer'", "easy"), "preview can be accepted with its random supply")
check(viewer:GetData("taskRewardOffers")[viewer:GetJobs()["'Old Timer'"].rewardKey].selected == shownPreview.supplyChoice,
	"random supply is reserved after the task is accepted")
check(not workDialogue.tree.TaskRewardChoices.ShouldAdd(nil, viewer.client, target),
	"task supplies entry stays hidden even with an accepted job")
check(not workDialogue.tree.AboutWorkTopic.ShouldAdd(nil, viewer.client, target),
	"hidden task supplies do not override the original work-topic visibility")
local noWork = actor()
check(not workDialogue.tree.AboutWorkTopic.ShouldAdd(nil, noWork.client, target),
	"work menu keeps its original visibility when there are no reward actions")
check(not api.CreateOffer(viewer, "progression:menu-test", "'Old Timer'", 75, "Progression task"),
	"new progression supply offers cannot be created")
local legacyOffers = copy(viewer:GetData("taskRewardOffers", {}))
legacyOffers["progression:menu-test"] = {npc = "'Old Timer'", label = "Progression task", earned = true,
	choices = {{label = "Old supplies", items = {{item = "medic_bandage_1", data = {quantity = 3}}}}}}
viewer:SetData("taskRewardOffers", legacyOffers)
local menuOptions = dialogue.tree.TaskRewardChoices.GetDynamicOptions(nil, viewer.client, target)
local hasRepeatable = false
for _, option in ipairs(menuOptions) do
	if option.dyndata.kind == "offer" then
		check(option.dyndata.key:match("^job:"), "task supplies menu excludes progression offers")
		hasRepeatable = true
	end
end
check(hasRepeatable, "repeatable task rewards remain in the supplies menu")
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
api.PrepareExistingJobs(viewer)
check(not viewer:GetData("taskRewardOffers")["progression:menu-test"],
	"old progression offers are retired when existing jobs are prepared")
check(viewer:GetData("taskRewardOffers")[viewer:GetJobs()["'Old Timer'"].rewardKey],
	"retiring progression offers preserves repeatable job choices")
check(#viewer.inventory.received == 0 and viewer.money == 0,
	"retiring obsolete progression choices does not pay extra rewards")
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
dofile("gamemodes/ix_cotz/plugins/dialogue/libs/sh_taskrewards.lua")
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
print("PASS: " .. checks .. " task reward checks")
