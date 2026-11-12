DIALOGUE.name = "SherpaVendor"

for _, id in ipairs({"GREETING", "BackTopic"}) do
	DIALOGUE.addTopic(id, {
		statement = "Let's talk about something else.",
		response = "Need something from stock, or dropping something off?",
		options = {"TradeTopic", "StorageTopic", "DonateTopic", "ManageTopic", "GOODBYE"},
	})
end

DIALOGUE.addTopic("TradeTopic", {
	statement = "Let me see what's in stock.",
	response = "Take a look.",
	options = {"BackTopic"},
	postCallback = function(_, client, target)
		if SERVER then ix.sherpa.Open(client, target) end
	end,
})

-- DIALOGUE.addTopic("DonateTopic", {
-- 	statement = "I'd like to store some supplies with you.",
-- 	response = "Use the items on your side of the trading window to hand them over. There's no payment for a donation.",
-- 	options = {"BackTopic"},
-- 	postCallback = function(_, client, target)
-- 		if SERVER then ix.sherpa.Open(client, target) end
-- 	end,
-- })

-- DIALOGUE.addTopic("ManageTopic", {
-- 	statement = "I need to manage our stock.",
-- 	response = "Prices and stock are in the trading window. You'll need authorization to change them.",
-- 	options = {"BackTopic"},
-- 	postCallback = function(_, client, target)
-- 		if SERVER then ix.sherpa.Open(client, target) end
-- 	end,
-- })

DIALOGUE.addTopic("GOODBYE", {statement = "That's all for now.", response = "See you."})

-- DIALOGUE.addTopic("StorageTopic", {
-- 	statement = "I'd like to access my personal storage.",
-- 	response = "Go ahead.",
-- 	options = {"BackTopic"},
-- 	postCallback = function(_, client, target)
-- 		if SERVER then ix.sherpa.OpenPersonalStorage(client, target) end
-- 	end,
-- })
