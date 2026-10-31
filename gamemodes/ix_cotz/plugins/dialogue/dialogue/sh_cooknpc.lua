DIALOGUE.name = "Spicy Lemon"
DIALOGUE.townContact = "spicy-lemon"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Always - You looking for a good meal?")

DIALOGUE.addTopic("GREETING", {
	response = "What's up?",
	options = {
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
	statement = "Tell me about yourself.",
	response = (
		"Not a whole lot to say - I came here after consolidating "
		.. "with 'Old Timer', as you know him as. We met each other "
		.. "in a city nearby, back in the eighties, under different "
		.. "circumstances than these. I worked at a volunteer at a "
		.. "homeless shelter and... Well maybe the old guy will open "
		.. "up about it at some point. Let's just say we have different "
		.. "reasons for being here. "
	),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Well, what's your reason?",
	response = (
		"Things didn't work out back home. I was led by temptations "
		.. "and my wife didn't take so kindly. But who cares, she was "
		.. "kind of on the big side anyways and didn't want to cook "
		.. "for me. Who would have believed, I had to cook by myself! "
		.. "It's her own fault and was definitely something she had "
		.. "coming. Stupid bitch."
	),
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "Right... What made you come here, of all places?",
	response = (
		"Well, I heard about the artifacts of course, from good "
		.. "oldie! And I met some crazy people through my volunteer "
		.. "work who are interested in astrology or whatever it's called, "
		.. "they want to pay a big extra for whatever supernatural "
		.. "elements I can get out of here. Apparently they have sources "
		.. "who pay big. I don't care if you believe it, just trust "
		.. "the cash when it flows in, alright?"
	),
	options = {
		"BackgroundTopic4",
	},
})

DIALOGUE.addTopic("BackgroundTopic4", {
	statement = "I'll keep that in mind.",
	response = ("You're always welcome to trade here. And remember - I do " .. "the best meals in town!"),
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
			local barters = ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Spicy Lemon'")

			if #barters <= 0 then
				self.response = "Nothing at the moment."

				net.Start("npcbarter_sync")
				net.SendToServer()
			else
				self.response = "I have the following things up for barter:"

				for _, barter in pairs(barters) do
					local barterTable = ix.npcbarter.barterdict["'Spicy Lemon'"][barter]
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

		for _, barterid in pairs(ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Spicy Lemon'")) do
			local barterstruct = ix.npcbarter.barterdict["'Spicy Lemon'"][barterid]

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
				dyndata = { npcname = "'Spicy Lemon'", identifier = barterid, reqitem = reqitem[1] },
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
	response = "Very nice...",
	options = {
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
	response = "See you soon...",
})
