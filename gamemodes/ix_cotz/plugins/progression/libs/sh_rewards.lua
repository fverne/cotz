ix.progression = ix.progression or {}

local PROGRESSION_CASH_RATE = 0.60

function ix.progression.CashMultiplier()
	return PROGRESSION_CASH_RATE
end

function ix.progression.HandInUnitValue(itemID, instance)
	return ix.taskRewards.HandInUnitValue(itemID, instance) * PROGRESSION_CASH_RATE
end
