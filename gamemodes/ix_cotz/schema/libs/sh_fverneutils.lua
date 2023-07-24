ix.util = ix.util or {}

-- Gives a reputation and currency reward from turning in an item
function ix.util.GetValueFromProgressionTurnin(item, cnt)
    if not (cnt) then cnt = 1 end
    local value = item.price

    -- Calculate Reputation
    local baseRep = 5
    local rep = (math.sqrt(math.sqrt(value * 0.1 * cnt))) 
    rep = math.Round(baseRep + rep)

    -- Calculate Currency
    local buyBackRate = 0.6 -- Same as selling to the good vendor
    local currency = value * buyBackRate
    currency = currency * cnt

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
