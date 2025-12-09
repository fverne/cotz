ix.util = ix.util or {}

-- Gives a reputation and currency reward from turning in an item
function ix.util.GetValueFromProgressionTurnin(item, cnt)

    if item.GetPrice then
        value = item:GetPrice()
    else
        value = item.price
    end

    -- Calculate Reputation
    local baseRep = 5
    local rep = (math.sqrt(math.sqrt(value * 0.1))) 
    rep = math.Round(baseRep + rep)

    -- Calculate Currency
    local buyBackRate = 0.6 -- Same as selling to the good vendor
    local currency = value * buyBackRate
    currency = math.Round(currency)

    return rep, currency
end

-- Performs various extra features based around chat messages in a single helper function
function ix.util.HandleChat(name, message)
    // Relay to other servers
	if (ix.crossserverchat) then
		local icon = "vgui/icons/news.png"
		ix.crossserverchat.PostMessage(nil, name, message, icon)
	end

    // Relay to discord
    if (ix.discordrelay) then
	    ix.discordrelay.RelayChatToDiscord(name, message)
    end
end

--overwrites the original helix one
function ix.util.GetMaterial(materialPath, materialArguments)
    if !isstring(materialPath) then return materialPath end

    -- Cache the material.
    ix.util.cachedMaterials = ix.util.cachedMaterials or {}
    ix.util.cachedMaterials[materialPath] = ix.util.cachedMaterials[materialPath] or Material(materialPath, materialArguments or "noclamp smooth")

    return ix.util.cachedMaterials[materialPath]
end

function ix.util.GetRandomMap()
    local activeMaps = ix.plugin.list["simplecrossserver"].activemaps
    local selectedMap = activeMaps[math.random(#activeMaps)]

    return selectedMap
end

function ix.util.GetDifferentRandomMap(mapToAvoid)
    mapToAvoid = mapToAvoid or game.GetMap()

	local activeMaps = ix.plugin.list["simplecrossserver"].activemaps
    local selectedMap = activeMaps[math.random(#activeMaps)]

	for k,v in pairs(tempMaps) do
		if v == mapToAvoid then
			continue
		else
			return v
		end
	end
end