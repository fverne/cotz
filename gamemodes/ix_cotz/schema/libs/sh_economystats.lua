ix.economyStats = ix.economyStats or {}

ix.economyStats.fields = {
	{"cash", "CURRENT CASH"},
	{"income", "TOTAL TRACKED INCOME"},
	{"spending", "TOTAL TRACKED SPENDING"},
	{"net", "TRACKED NET CASH FLOW"},
	{"repairSpent", "MONEY SPENT ON REPAIRS"},
	{"ammoSpent", "MONEY SPENT ON AMMO"},
	{"foodSpent", "MONEY SPENT ON FOOD"},
	{"drinkSpent", "MONEY SPENT ON DRINKS"},
	{"vendorSpent", "OTHER VENDOR PURCHASES"},
	{"serviceSpent", "OTHER PAID SERVICES"},
	{"conversionSpent", "MONEY SPENT ON SUIT CONVERSIONS"},
	{"progressionEarned", "PROGRESSION HAND-IN INCOME"},
	{"taskEarned", "TASK CASH INCOME"},
	{"bonusEarned", "TASK BONUS CASH INCOME"},
	{"barterEarned", "BARTER CASH INCOME"},
	{"vendorEarned", "VENDOR SALES INCOME"},
	{"topFood", "TOP 3 FOODS EATEN", "ranking"},
	{"topDrinks", "TOP 3 DRINKS CONSUMED", "ranking"},
	{"topSales", "TOP 3 VENDOR SALE CATEGORIES", "ranking"},
}

local INCOME_KEYS = {"progressionEarned", "taskEarned", "bonusEarned", "barterEarned", "vendorEarned"}
local SPENDING_KEYS = {
	"repairSpent", "ammoSpent", "vendorSpent", "serviceSpent", "conversionSpent", "foodSpent", "drinkSpent",
}
local TRACKED_KEYS = {}
for _, key in ipairs(INCOME_KEYS) do TRACKED_KEYS[key] = true end
for _, key in ipairs(SPENDING_KEYS) do TRACKED_KEYS[key] = true end

function ix.economyStats.GetConsumableKind(item)
	if item.base == "base_cooked" or item.GetHunger then return "food" end
	if item.base ~= "base_consumables" and not item.DecideFunction then return end
	if item.isDrink or (item.thirst or 0) > 0 then return "drink" end
	if (item.hunger or 0) > 0 then return "food" end
end

local function topThree(totals, items)
	local ranked = {}
	for key, amount in pairs(totals or {}) do
		local definition = items and ix.item.list[key]
		ranked[#ranked + 1] = {name = definition and definition.name or key, amount = amount, key = key}
	end
	table.sort(ranked, function(a, b)
		if a.amount == b.amount then return a.key < b.key end

		return a.amount > b.amount
	end)
	local result = {}
	for index = 1, math.min(3, #ranked) do result[index] = ranked[index] end

	return result
end

if SERVER then
	function ix.economyStats.Record(character, key, amount)
		if not TRACKED_KEYS[key] or type(amount) ~= "number" or amount <= 0
			or amount ~= amount or amount == math.huge then return end
		local stats = table.Copy(character:GetData("economyStats", {}))
		stats.startedAt = stats.startedAt or os.time()
		stats[key] = (stats[key] or 0) + amount
		-- Initial owner sync also excludes this key; only the admin roster may publish it.
		character:SetData("economyStats", stats, true)
	end

	function ix.economyStats.RecordConsumption(character, item)
		local kind = ix.economyStats.GetConsumableKind(item)
		if not kind or not ix.item.list[item.uniqueID] then return end
		local stats = table.Copy(character:GetData("economyStats", {}))
		local key = kind == "drink" and "drinksConsumed" or "foodConsumed"
		stats[key] = stats[key] or {}
		stats[key][item.uniqueID] = (stats[key][item.uniqueID] or 0) + 1
		character:SetData("economyStats", stats, true)
	end

	function ix.economyStats.RecordVendorSale(character, item, amount)
		if type(amount) ~= "number" or amount <= 0 or amount ~= amount or amount == math.huge then return end
		ix.economyStats.Record(character, "vendorEarned", amount)
		local stats = table.Copy(character:GetData("economyStats", {}))
		local category = item.category or "Other"
		stats.salesByCategory = stats.salesByCategory or {}
		stats.salesByCategory[category] = (stats.salesByCategory[category] or 0) + amount
		character:SetData("economyStats", stats, true)
	end

	function ix.economyStats.GetSummary(data, cash)
		local saved = data.economyStats or {}
		local result = {cash = tonumber(cash) or 0, income = 0, spending = 0, startedAt = saved.startedAt}
		for _, key in ipairs(INCOME_KEYS) do
			result[key] = saved[key] or 0
			result.income = result.income + result[key]
		end
		for _, key in ipairs(SPENDING_KEYS) do
			result[key] = saved[key] or 0
			result.spending = result.spending + result[key]
		end
		result.net = result.income - result.spending
		result.topFood = topThree(saved.foodConsumed, true)
		result.topDrinks = topThree(saved.drinksConsumed, true)
		result.topSales = topThree(saved.salesByCategory, false)

		return result
	end
end
