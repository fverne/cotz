DIALOGUE.name = "Old Timer"
DIALOGUE.townContact = "old-timer"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Yes")

DIALOGUE.addTopic("GREETING", {
	response = "Still standing, I see. Good. What do you need?",
	options = {
		"SpecialtyTopic",
		"TradeTopic",
		"StartBarter",
		"NicknameTopic",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("NicknameTopic", {
	statement = "I'd like to change my nickname.",
	response = "What would you like your nickname to be?",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			Derma_StringRequest(
				"Edit Nickname",
				"Edit your nickname. Length must be between 4 and 16 characters.",
				"",
				function(text)
					netstream.Start("ix_requestNicknameChange", text)
				end,
				function(text)
					client:Notify("Nickname change cancelled.")
				end
			)
		end
	end,
	ShouldAdd = function(self, client, target)
		return LocalPlayer():getReputation() >= 4100 -- Professional
	end,
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Were you living near here before the Zone?",
	response = (
		"Near enough to know some of the country before everyone started giving it new names. Hunted "
		.. "hereabouts. Thought that would stand me in good stead when I first came through. It helped, until I "
		.. "began trusting what I expected to find more than what was in front of me. You can make that mistake "
		.. "on familiar ground very easily. I still recognise bits of the place. A bend, a line of trees. "
		.. "Sometimes I wish I didn't; takes a moment to stop looking for what used to be beside them."
	),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "How do you deal with the military?",
	response = (
		"Avoid them where you can. Don't assume a uniform means they're interested in your explanation. I've "
		.. "heard enough stories about how they deal with intruders to leave the experiments to somebody else. "
		.. "If you can make a quieter journey, do it. You don't need to establish which rumour was true."
	),
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "Why did you stay?",
	response = (
		"Not much waiting for me at home by then. Hunting stopped paying, I drank more than I should, and my "
		.. "family had enough of it. Here there was always something to do next. Don't confuse that with "
		.. "putting things right. A person can stay very busy avoiding a question."
	),
	options = {
		"BackgroundTopic4",
	},
})

DIALOGUE.addTopic("BackgroundTopic4", {
	statement = "Let's leave the past there.",
	response = "All right. There's enough to be getting on with today.",
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
			local barters = ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Old Timer'")

			if #barters <= 0 then
				self.response = "Nothing at the moment."

				net.Start("npcbarter_sync")
				net.SendToServer()
			else
				self.response = "I have the following things up for barter:"

				for _, barter in pairs(barters) do
					local barterTable = ix.npcbarter.barterdict["'Old Timer'"][barter]
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

		for _, barterid in pairs(ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Old Timer'")) do
			local barterstruct = ix.npcbarter.barterdict["'Old Timer'"][barterid]

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
				dyndata = { npcname = "'Old Timer'", identifier = barterid, reqitem = reqitem[1] },
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
		"NicknameTopic",
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
	response = "Get yourself home. We can talk another time.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "When do you know someone is ready to go out?",
	response = (
		"Depends where they're going. Show me your water, tell me how you're getting back, then we can "
		.. "discuss how ready you are. People think I'm asking because I enjoy finding fault with their "
		.. "packing. Sometimes I do. Mostly I want them to have an answer before something frightens it out of "
		.. "their head. First walk needn't be a grand expedition. There's plenty to learn within a sensible "
		.. "distance of supper."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Do you take your own advice?",
	response = (
		"More often than I used to. Lemon would enjoy giving you the exceptions. There are mornings I don't "
		.. "want to carry the extra weight either, or I tell myself I've got time before dark. Knowing better "
		.. "doesn't pack the bag for you. If you're walking with me and something looks wrong, say so. Don't "
		.. "wait politely for me to notice."
	),
	options = {"BackTopic"},
})
