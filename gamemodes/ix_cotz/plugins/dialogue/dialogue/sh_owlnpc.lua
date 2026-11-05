DIALOGUE.name = "Cleaner"
DIALOGUE.townContact = "cleaner"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Let's see what we can trade.",
	"All right. Put the goods where I can see them."
)

DIALOGUE.addTopic("GREETING", {
	response = "Yes? Put the wet pack away from the table and tell me what you need.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"StartBarter",
		"BackgroundTopic",
		"InterestTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "How did you get into storage and moving goods?",
	response = "Had space. Kept things where I put them. Didn't give visitors an account of who'd been here before them. People found that useful. You're looking for a more interesting beginning. Go and ask someone who wants to tell you one. If you need something stored or moved, we can discuss an arrangement before you hand it over.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "Any stories you're willing to share?",
	response = "About other people's business? No. About my own? Also no. You've had two answers for the price of one question. Make the next one useful.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("StartBarter", {
	statement = "What exchanges are available?",
	response = "Have a look. Ask if the terms need explaining.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			local barters = ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Cleaner'")

			if #barters <= 0 then
				self.response = "Nothing at the moment."

				net.Start("npcbarter_sync")
				net.SendToServer()
			else
				self.response = "I have the following things up for barter:"

				for _, barter in pairs(barters) do
					local barterTable = ix.npcbarter.barterdict["'Cleaner'"][barter]
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

		for _, barterid in pairs(ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Cleaner'")) do
			local barterstruct = ix.npcbarter.barterdict["'Cleaner'"][barterid]

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
				dyndata = { npcname = "'Cleaner'", identifier = barterid, reqitem = reqitem[1] },
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
	statement = "Something else.",
	response = "What is it?",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"StartBarter",
		"BackgroundTopic",
		"InterestTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "That's all I needed.",
	response = "All right. That's settled.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "How should I judge whether to trust you?",
	response = "Do a small piece of business. Check the result. Haggler would be halfway through explaining his character by now; you can ask him if you miss the conversation. I prefer the terms understood before anybody leaves a parcel. That includes what I haven't agreed to do. You can decide whether it suits you without telling me what sort of person you believe I am.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What if a journey goes wrong?",
	response = "Tell me where, what you saw, and which part you did yourself. I can work with a stupid decision. An account improved to hide it wastes the time we might have spent avoiding the same mistake. Leave everybody else's names out until I ask. No, that isn't an invitation to sit down and tell me about your worst expedition.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Does anything people bring back still surprise you?",
	response = "The smell sometimes. Wet packs, mutant parts, whatever they were using to keep a boot together. They stand there explaining the artifact they almost found while the bag drips. I ask them to put it down somewhere else. That's usually the surprising part for them.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Does Wake ask you about missing stalkers?",
	response = "She asks. Sometimes I can answer a question. Sometimes she wants a name she has no reason to expect from me. I say so. She comes back with a better question. Persistent woman. You're waiting for me to explain why I bother answering. You can keep waiting.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Would you rather everyone left you alone?",
	response = "I'd rather they knew why they'd come before they started talking. You're doing reasonably well. Don't turn it into a visit.",
	options = {"BackTopic"},
})
