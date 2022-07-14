ix.util = ix.util or {}

-- Gives a reputation and currency reward from turning in an item
function ix.util.GetValueFromProgressionTurnin(item)
    local value = item.price

    -- Calculate Reputation
    local baseRep = 5
    local rep = (math.sqrt(math.sqrt(value * 0.1))) 
    rep = math.Round(baseRep + rep)

    -- Calculate Currency - left out for now
    local buyBackRate = 0.4 -- Slightly less than cleaner
    local currency = value * buyBackRate

    return rep, currency
end