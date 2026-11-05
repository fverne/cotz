DIALOGUE.name = "Old Timer"
DIALOGUE.townContact = "old-timer"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Let's see what we can trade.",
	"Have a look. Think about what you'll use on the walk, as well as what you hope to bring back."
)

DIALOGUE.addTopic("GREETING", {
	response = "Come over. There's room by the fire if you need a moment. Hunting, supplies, or something on your mind?",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
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
	statement = "I'd like to use a different nickname.",
	response = "Your name to live with. What do you want people calling you?",
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
	statement = "Did you know this country before it became the Zone?",
	response = "Hunted hereabouts. Used to know where I'd stop to eat and which stretch would soak my boots. Some of it still looks familiar. That's caught me out more than once: you start looking for a gap that used to be there instead of watching where you're putting your feet. I can enjoy remembering a place. Takes a little effort to stop the memory deciding what I'm seeing.",
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "What do you make of the military here?",
	response = "I give them room. Heard enough accounts of men trying to explain themselves to a patrol, and I haven't much appetite for adding my own. People bring camp a new rumour about the soldiers every week. Some of it may be true. Ask who actually saw what happened before you decide a particular uniform will listen to you. I'd sooner spend the extra time walking round.",
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "What made you stay?",
	response = "Home had become a place where people were tired of waiting for me to put myself right. The hunting wasn't paying, I was drinking, and I had an answer ready for everyone except my family. Here I could get up and deal with something that needed doing. Still can. Doesn't make a grand story about finding my place. Lemon knows enough of it already; you needn't go asking him for the rest.",
	options = {
		"BackgroundTopic4",
	},
})

DIALOGUE.addTopic("BackgroundTopic4", {
	statement = "We can leave that there.",
	response = "Yes. Thank you. How are you finding the camp?",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("StartBarter", {
	statement = "What can I exchange with you?",
	response = "Let's see what you've got and what I can spare.",
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
	statement = "Something else.",
	response = "Go on. I'm listening.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
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
	statement = "I'll be on my way.",
	response = "All right. Don't let somebody else's hurry decide the length of your walk.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What do you look for in someone heading out?",
	response = "Someone who can tell me what they're uncertain about. A new stalker asking where to stop is easier company than a confident one announcing how far they'll get before dark. I still ask about water and the return. Then I try to leave them room to answer. Lemon would tell you I need practice at that part. First trip out, you've already got enough people explaining what sort of stalker you ought to become.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Do you ever get tired of being the one giving advice?",
	response = "Sometimes I'd like to hear the end of a journey before discussing the next one. Sit down, tell me what you found funny, let your boots dry. Then I notice somebody's left their bag open in the rain and off I go again. Habit. You can tell me I've started. Might even catch me early enough to finish your story.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "What do you do when you aren't hunting?",
	response = "Sit somewhere I can get my socks dry without someone putting another log on. Everyone comes back from hunting mutants with a different idea of the correct fire. Usually a larger one. I mend a little, listen to whoever's returned. Sometimes there's a decent account of the walk between all the shouting about the kill. I like hearing which places people still stop at. Spent enough years passing through them myself.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Does Lemon ever let you cook?",
	response = "He lets me explain how little cooking I require, then carries on doing whatever he intended. Apparently I've been ruining tinned meat for decades. We had a disagreement over a pot after a hunt. I said it was perfectly edible; he said that was a description of the pot. I ate his version. He's still waiting for a sufficiently elaborate admission that it was better.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you miss having the woods to yourself?",
	response = "Some mornings. Then I hear movement where I wasn't expecting it and remember the company I might get instead. There are stalkers whose chatter I'd choose over another hour listening for a mutant. Don't tell them which ones. They've enough confidence already.",
	options = {"BackTopic"},
})
