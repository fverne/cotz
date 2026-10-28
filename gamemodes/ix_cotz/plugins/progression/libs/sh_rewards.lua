ix.progression = ix.progression or {}

local PROGRESSION_CASH_RATE = 0.65

function ix.progression.CashMultiplier()
	return PROGRESSION_CASH_RATE
end

function ix.progression.HandInUnitValue(itemID, instance)
	local item = instance or ix.item.list[itemID]
	local ammoAmount = item.ammoAmount
	if type(ammoAmount) == "table" then
		ammoAmount = ((ammoAmount[1] or 1) + (ammoAmount[2] or ammoAmount[1] or 1)) / 2
	elseif type(ammoAmount) ~= "number" then
		ammoAmount = 1
	end
	local units = not item.quantity and (ammoAmount or 1) or 1
	local value = ix.taskRewards.HandInUnitValue(itemID, instance)

	return value / math.max(1, units) * PROGRESSION_CASH_RATE
end
