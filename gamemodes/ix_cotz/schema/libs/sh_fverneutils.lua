ix.util = ix.util or {}

local TURN_IN_BASE_REPUTATION = 5
local TURN_IN_REPUTATION_MULTIPLIER = 2
local TURN_IN_VALUE_FACTOR = 0.1
local TURN_IN_BUYBACK_RATE = 0.3

function ix.util.GetValueFromProgressionTurnin(item, count)
	local maximumQuantity = item.quantity or item.ammoAmount or 1
	local available = item:GetData("quantity", maximumQuantity)
	if available <= 0 or maximumQuantity <= 0 then
		return 0, 0
	end
	local fullValue = item.price or 0
	if item.GetPrice then
		-- Quote a full stack without mutating inventory; partial-stack price rounding must not change rewards.
		local quote = setmetatable({
			GetData = function(_, key, default)
				if key == "quantity" then
					return maximumQuantity
				end

				return item:GetData(key, default)
			end,
		}, { __index = item })
		fullValue = quote:GetPrice()
	end
	local accepted = math.min(count or available, available)
	local unitPrice = fullValue / maximumQuantity
	local fullReputation = TURN_IN_BASE_REPUTATION + (fullValue * TURN_IN_VALUE_FACTOR) ^ 0.25
	local reputation = fullReputation * accepted / maximumQuantity * TURN_IN_REPUTATION_MULTIPLIER
	local currency = unitPrice * accepted * TURN_IN_BUYBACK_RATE

	return reputation, currency
end

-- Performs various extra features based around chat messages in a single helper function
function ix.util.HandleChat(name, message)
	-- Relay to other servers
	if ix.crossserverchat then
		local icon = "vgui/icons/news.png"
		ix.crossserverchat.PostMessage(name, message, icon)
	end

	-- Relay to discord
	if ix.discordrelay then
		ix.discordrelay.RelayChatToDiscord(name, message)
	end
end

--overwrites the original helix one
function ix.util.GetMaterial(materialPath, materialArguments)
	if not isstring(materialPath) then
		return materialPath
	end

	-- Cache the material.
	ix.util.cachedMaterials = ix.util.cachedMaterials or {}
	ix.util.cachedMaterials[materialPath] = ix.util.cachedMaterials[materialPath]
		or Material(materialPath, materialArguments or "noclamp smooth")

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

	for k, v in pairs(tempMaps) do
		if v == mapToAvoid then
			continue
		else
			return v
		end
	end
end
