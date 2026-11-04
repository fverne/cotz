DIALOGUE.name = "Haggler"
DIALOGUE.townContact = "haggler"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Absolutely, here's what I have in stock.")

DIALOGUE.addTopic("GREETING", {
	response = (
		"Welcome. Take a look, but don't start an argument about the price until you've found something "
		.. "you want."
	),
	options = {
		"SpecialtyTopic",
		"TradeTopic",
		"StartBarter",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "What brought you into trading here?",
	response = (
		"Customers. Back home a man can walk out of your shop and find six more selling the same thing. Here "
		.. "he comes back and says, 'Haggler, nobody else has one.' Beautiful words. Of course, then I have to "
		.. "find another, persuade someone to bring it through, and listen to the first man explain that I paid "
		.. "too little for his. Everybody remembers the pleasant half of my business. You're welcome to "
		.. "remember the rest when we discuss my prices."
	),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Do you ever get tired of bargaining?",
	response = (
		"With Brass, yes. He counts everything before he becomes interested in my explanation. Ledger writes "
		.. "it down afterwards. Very difficult men to have an enjoyable misunderstanding with. Fortunately most "
		.. "people appreciate a little conversation while we establish what their goods are worth."
	),
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "Can you point me towards other suppliers?",
	response = (
		"Depends what you need. Lemon for food, Technut for repairs, Jitters if your next question concerns "
		.. "bleeding. Brass handles ammunition in Garbage. Ask them their prices, by all means. I'll be here "
		.. "when you've finished carrying your bargain home."
	),
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "Can you tell me something interesting?",
	response = "Not really, no.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("StartBarter", {
	statement = "I'd like to do some bartering.",
	response = "Sure.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			local barters = ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Haggler'")

			if #barters <= 0 then
				self.response = "Nothing at the moment."

				net.Start("npcbarter_sync")
				net.SendToServer()
			else
				self.response = "I have the following things up for barter:"

				for _, barter in pairs(barters) do
					local barterTable = ix.npcbarter.barterdict["'Haggler'"][barter]
					self.response = self.response
						.. "\n    "
						.. string.format(
							barterTable.description,
							ix.item.list[barterTable.barterItem[1]].name,
							barterTable.reqItem[2],
							ix.item.list[barterTable.reqItem[1]].name
						)
				end
			end
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		for _, barterid in pairs(ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Haggler'")) do
			local barterstruct = ix.npcbarter.barterdict["'Haggler'"][barterid]

			local barterItem = barterstruct.barterItem
			local barterCnt = barterItem[2] or 1

			-- for _, reqitem in pairs(barterstruct.reqItem) do
			local reqitem = barterstruct.reqItem
			local reqItemCnt = reqitem[2] or 1

			table.insert(dynamicOptions, {
				statement = "I'd like "
					.. barterCnt
					.. "x "
					.. ix.item.list[barterItem[1]].name
					.. " for my "
					.. reqItemCnt
					.. "x "
					.. ix.item.list[reqitem[1]].name,
				topicID = "StartBarter",
				dyndata = { npcname = "'Haggler'", identifier = barterid, reqitem = reqitem[1] },
			})
			-- end
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		if CLIENT then
			ix.npcbarter.TryExecuteBarter(dynamicData.npcname, dynamicData.identifier, dynamicData.reqitem)
		end

		-- Return the next topicID

		return "BackTopic", dynamicData
	end,
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else...",
	response = "What else did you want to discuss?",
	options = {
		"SpecialtyTopic",
		"TradeTopic",
		"StartBarter",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "Come back when you need something. Or when you've found something I need.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Do you ever do someone a favour?",
	response = (
		"Frequently. People are less enthusiastic when I remember it afterwards. Oh, don't pull that face. "
		.. "Sometimes I let a payment wait. You can usually tell who's embarrassed to ask and who's been "
		.. "practising the explanation. I don't require a man to be cheerful about needing help. I do require "
		.. "him to remember we had a conversation. Cleaner understands that perfectly. No speech, no "
		.. "performance, just what we agreed."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Why let the payment wait?",
	response = (
		"Because I expect him to come back. With money, ideally, but coming back is a useful start. You sell "
		.. "someone his last bandage and then refuse him enough food to get home, you've made a remarkably "
		.. "short investment. I prefer customers who complain about me for years. Some even start bringing "
		.. "things I can sell. It becomes almost sociable."
	),
	options = {"BackTopic"},
})
