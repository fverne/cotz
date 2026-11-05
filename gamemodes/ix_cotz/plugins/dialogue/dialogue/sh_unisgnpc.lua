DIALOGUE.name = "Quartermaster"
DIALOGUE.townContact = "quartermaster"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"I'd like to look at the equipment available for trade.",
	"All right. Consider what you need it to do before choosing."
)

DIALOGUE.addTopic("GREETING", {
	response = "What do you need? If this concerns supplies, begin with the equipment and the intended use. We'll reach the explanation afterwards.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
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
	statement = "What occupies most of your time here?",
	response = "Making sure two departures don't depend on the same equipment. People arrive with very clear ideas about their own expedition and rather less interest in the next one. I understand that. I still need the intended use, the quantity, and an accurate account of what they already have. My personal history won't fill a shortage. If that's what you meant to ask about, you'll have to make do with the work.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("StartBarter", {
	statement = "What equipment exchanges can I consider?",
	response = "Review the available exchanges. Ask about the terms before committing.",
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
	statement = "Something else.",
	response = "Yes. Be specific.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
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
	statement = "That's everything for now.",
	response = "Understood. Check what you've packed before departure.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "When will you reconsider an allocation?",
	response = "When the circumstances have changed and someone can explain how. A difficult expedition deserves proper consideration. So does the departure whose supplies you're asking me to divert. Tell me the practical problem before arguing about the importance of your own journey. I can be persuaded by information. An extended account of how much you dislike waiting is unlikely to add any.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What should someone do if they can't meet an order?",
	response = "Report the shortage while arrangements can still change. Brass does that, including when he knows I'll be displeased. Useful man. We can disagree about what to do next with the same number in front of us. I am less interested in an optimistic account that becomes a surprise at departure. You may find the early conversation uncomfortable. Have it anyway.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Is there anything in your own kit you keep out of habit?",
	response = "An old cup. Handle's awkward in gloves, takes up more room than it should. I've had several opportunities to replace it. There, you've discovered a failure of procurement. Stalkers return from an anomaly field and tell me every unnecessary thing they carried had a purpose. I don't need an expedition report to recognise an attachment. I would prefer them to admit it before we spend twenty minutes discussing the specifications.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Does Suture inspect your equipment too?",
	response = "Without being asked. I adjusted a strap while we were discussing a supply request and the subject changed immediately. Apparently I'd been making the same adjustment throughout the conversation. Irritating to discover somebody else has been paying closer attention to your discomfort. The observation was sound. I said so. That should have been sufficient; Suture also wanted to know how long I'd been putting up with it.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Does Boss know about the cup?",
	response = "We've had more pressing things to discuss. If your next question is whether I include it in the weight, yes. I can be fond of something and still count it.",
	options = {"BackTopic"},
})
