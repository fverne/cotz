DIALOGUE.name = "Old Timer"
DIALOGUE.townContact = "old-timer"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Yes")

DIALOGUE.addTopic("GREETING", {
	response = "Yes?",
	options = {
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
	statement = "Tell me about yourself.",
	response = (
		"Well, I've lived in the outskirts of the now exclusion "
		.. "zone for a long time. After the first emission hit, and "
		.. "the area around Chernobyl became restricted, I decided "
		.. "to check out the area myself. And I can tell you, friend, "
		.. "that this area is not for the faint of heart. You're one "
		.. "of the first people I see have seen succesfully sneek past "
		.. "the military patrols."
	),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Military? I didn't know they had the area under lockdown?",
	response = (
		"Well, I would say you're lucky to be here. Usually the "
		.. "military take tourists for a long walk out of here if they "
		.. "find them, but I've heard gunshots coming from their encampments. "
		.. "Not sure if they are bored guarding the exclusion zone, "
		.. "or if they actually take care of intruders like us that "
		.. "way. I suggest just dodging the military entirely if you "
		.. "see any."
	),
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "Thanks for the advice. Why are you here?",
	response = (
		"Not a lot for me to do back home. I made my living as a "
		.. "hunter, but it's not something you can make a living off "
		.. "anymore. Hit the bottle. Family left me and so I decided "
		.. "to try my adventurelust and check out the rumours around "
		.. "this place. As far as I'm aware, I was the first one to "
		.. "succesfully make it past the military. And not get escorted "
		.. "out. "
	),
	options = {
		"BackgroundTopic4",
	},
})

DIALOGUE.addTopic("BackgroundTopic4", {
	statement = "Alright. We all have our demons.",
	response = "Some bigger than others. Take care.",
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
	response = "All right.",
	options = {
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
	response = "Come back soon, stranger...",
})
