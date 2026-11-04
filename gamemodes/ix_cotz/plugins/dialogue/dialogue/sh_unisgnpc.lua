DIALOGUE.name = "Quartermaster"
DIALOGUE.townContact = "quartermaster"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "I have some spare equipment laying around, yes.")

DIALOGUE.addTopic("GREETING", {
	response = "State what you need. If this concerns an order, have the details ready.",
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
	statement = "What does your work involve?",
	response = (
		"Allocations, requisitions, and explaining why the equipment already promised to someone else is "
		.. "unavailable. If you need something, be specific. What it must do matters more than how much you "
		.. "like the look of it. I can discuss an order. My personal history is unlikely to help fill yours. If "
		.. "that is what you intended to ask, consider this the shorter answer."
	),
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("StartBarter", {
	statement = "I'd like to do some bartering.",
	response = "Fine.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			local barters = ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Quartermaster'")

			if #barters <= 0 then
				self.response = "Nothing at the moment."

				net.Start("npcbarter_sync")
				net.SendToServer()
			else
				self.response = "I have the following things up for barter:"

				for _, barter in pairs(barters) do
					local barterTable = ix.npcbarter.barterdict["'Quartermaster'"][barter]
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

		for _, barterid in
			pairs(ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Quartermaster'"))
		do
			local barterstruct = ix.npcbarter.barterdict["'Quartermaster'"][barterid]

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
				dyndata = { npcname = "'Quartermaster'", identifier = barterid, reqitem = reqitem[1] },
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
	statement = "Let's talk about another topic.",
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
	statement = "I'll talk to you later.",
	response = "Check your equipment before departure. Dismissed.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Can you make an exception?",
	response = (
		"Explain what has changed. I can reconsider an allocation; I cannot issue the same equipment to two "
		.. "people. Usually the person asking for an exception has thought very carefully about their own "
		.. "difficulty and rather less about the next departure. That is understandable. Keeping track of both "
		.. "is part of my work. Give me enough information to do it before you begin bargaining."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What if an order cannot be filled?",
	response = (
		"Tell me while there is time to change arrangements. Brass will report a shortage even when he knows "
		.. "I won't like hearing it. I can work with that. Optimism written into a stock return sends somebody "
		.. "out expecting equipment that never arrived. If you bring me a problem early, I may still be "
		.. "displeased. You should not mistake that for preferring a late surprise."
	),
	options = {"BackTopic"},
})
