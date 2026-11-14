-- Run from the repository root: luatex --luaonly tests/economy_stats_spec.lua
local fixture = dofile("tests/helpers/progression.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local owner = fixture.character()
local updates = 0
function owner:SetData(key, value, noReplication)
	check(key == "economyStats" and noReplication == true, "economy writes suppress owner replication")
	self.data[key] = value
	updates = updates + 1
end
for _, amount in ipairs({0, -5, math.huge, -math.huge, "20"}) do
	ix.economyStats.Record(owner, "ammoSpent", amount)
end
ix.economyStats.Record(owner, "ammoSpent", 0 / 0)
ix.economyStats.Record(owner, "arbitraryKey", 50)
check(updates == 0 and owner.data.economyStats == nil, "invalid amounts and unknown keys never create saved state")
ix.economyStats.Record(owner, "ammoSpent", 12.5)
local startedAt = owner.data.economyStats.startedAt
local previous = owner.data.economyStats
ix.economyStats.Record(owner, "ammoSpent", 7.5)
check(previous.ammoSpent == 12.5 and owner.data.economyStats.ammoSpent == 20,
	"new transactions preserve previous saved-table identity and accumulate actual cash")
ix.economyStats.Record(owner, "vendorEarned", 80)
ix.economyStats.Record(owner, "repairSpent", 30)
ix.economyStats.Record(owner, "progressionEarned", 50)
owner.data.economyStats.private = "never publish"
local summary = ix.economyStats.GetSummary(owner.data, 400)
check(summary.income == 130 and summary.spending == 50 and summary.net == 80 and summary.cash == 400,
	"cash flow totals count disjoint sources and sinks once without treating wallet cash as income")
check(summary.private == nil and summary.startedAt == startedAt, "summaries whitelist fields and retain tracking start")
local reloaded = ix.economyStats.GetSummary(fixture.copy(owner.data), 400)
check(reloaded.ammoSpent == 20 and reloaded.income == 130, "saved counters survive character reload")
local empty = ix.economyStats.GetSummary({}, "250")
check(empty.cash == 250 and empty.income == 0 and empty.spending == 0 and empty.startedAt == nil,
	"legacy characters start with no inferred history")

-- Exercise the real progression completion ledger, including its repeated-hand-in guard.
local recipient = fixture.character()
ix.progression.Register("economyFixture", {townContact = true, nextProgressions = {}})
ix.progression.AccrueTurnInRewards(recipient, "economyFixture", 1, 37.2)
local record = ix.progression.GetCharacterProgression(recipient)
record.lines.economyFixture.completed = true
ix.progression.SetCharacterProgression(recipient, record)
ix.progression.PayCompletionRewards(recipient, "economyFixture")
check(recipient.money == 38 and recipient:GetData("economyStats").progressionEarned == 38,
	"progression records the rounded cash paid at completion, rather than accrued hand-in value")
ix.progression.PayCompletionRewards(recipient, "economyFixture")
check(recipient.money == 38 and recipient:GetData("economyStats").progressionEarned == 38,
	"repeated completion requests cannot duplicate income statistics")

-- Use the real payout entry point to distinguish ordinary work, bonuses and barter cash.
for prefix, field in pairs({job = "taskEarned", bonus = "bonusEarned", barter = "barterEarned"}) do
	local worker = fixture.character()
	local key = prefix .. ":economy"
	worker:SetData("taskRewardOffers", {[key] = {selected = 1,
		choices = {{money = 25, items = {}, services = {}}}}})
	check(ix.taskRewards.EarnOffer(worker, key), "earned cash offer is paid")
	check(worker.money == 25 and worker:GetData("economyStats")[field] == 25,
		"cash offer records its own economy source")
	check(not ix.taskRewards.EarnOffer(worker, key) and worker:GetData("economyStats")[field] == 25,
		"consumed cash offers cannot inflate recorded income")
end

local consumer = fixture.character()
for index = 1, 4 do
	local id = "economyFood" .. index
	ix.item.list[id] = {uniqueID = id, name = "Food " .. index, base = "base_consumables", hunger = 10}
	for _ = 1, index do ix.economyStats.RecordConsumption(consumer, ix.item.list[id]) end
end
local drink = {uniqueID = "economyDrink", name = "Vodka", base = "base_consumables", isDrink = true, thirst = -10}
ix.item.list.economyDrink = drink
ix.economyStats.RecordConsumption(consumer, drink)
for _, sale in ipairs({{"Artifacts", 200}, {"Weapons", 300}, {"Artifacts", 200}, {"Food", 50}, {"Junk", 10}}) do
	ix.economyStats.RecordVendorSale(consumer, {category = sale[1]}, sale[2])
end
ix.economyStats.Record(consumer, "foodSpent", 30)
ix.economyStats.Record(consumer, "drinkSpent", 20)
local ranked = ix.economyStats.GetSummary(consumer.data, 0)
check(#ranked.topFood == 3 and ranked.topFood[1].name == "Food 4" and ranked.topFood[1].amount == 4,
	"consumption ranks servings and sends only three entries")
check(ranked.topDrinks[1].name == "Vodka" and ranked.topDrinks[1].amount == 1,
	"alcohol remains a drink even with negative thirst restoration")
check(#ranked.topSales == 3 and ranked.topSales[1].name == "Artifacts" and ranked.topSales[1].amount == 400,
	"category ranking combines actual payouts across sales")
check(ranked.income == 760 and ranked.spending == 50, "category breakdowns do not double count cash totals")
check(ranked.foodConsumed == nil and ranked.salesByCategory == nil, "raw histories stay out of admin snapshots")

print("economy statistics: " .. checks .. " checks passed")
