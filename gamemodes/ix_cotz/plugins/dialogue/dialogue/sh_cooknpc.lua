DIALOGUE.name = "Spicy Lemon"
DIALOGUE.townContact = "spicy-lemon"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Always - You looking for a good meal?")

DIALOGUE.addTopic("GREETING", {
	response = "What's up? If you're hungry, say so. If you've come to tell me how to cook, take a number.",
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
	statement = "How long have you known Old Timer?",
	response = (
		"Since before either of us had these magnificent names. Eighties, a shelter kitchen, a lot of people "
		.. "wanting something warm. I volunteered. Yes, me. You needn't look for a second Lemon. He had his own "
		.. "difficulties; he can tell you those if he wants. We stayed in touch. When I started hearing about "
		.. "this place, he was someone I could ask who might actually have seen what he was describing. That "
		.. "counts for something, even if he still thinks seasoning means opening a tin beside a fire."
	),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Why did you leave home?",
	response = (
		"I had a wife, a job, people who expected me at certain times. I became difficult to expect. There "
		.. "was always somewhere else I wanted to be, and I generally found a reason why that was somebody "
		.. "else's fault. She had plenty to say about it. Some of it was even fair. Don't look so pleased; you "
		.. "haven't heard my side."
	),
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "What is your side?",
	response = (
		"Considerably longer. Usually improves after a drink. Look, I heard about artifacts, knew people "
		.. "willing to pay for things they hadn't seen, and knew Old Timer. It sounded like a fresh start with "
		.. "money attached. I didn't arrive dreaming of feeding everybody. That's what I found I could do here. "
		.. "Want food, or are you planning to spend the afternoon enjoying my personal failures?"
	),
	options = {
		"BackgroundTopic4",
	},
})

DIALOGUE.addTopic("BackgroundTopic4", {
	statement = "Let's leave it there.",
	response = "Good. I can give a much more convincing account of what's in the pot.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "What do you like cooking?",
	response = (
		"Something people sit down to eat. A meal they stop walking for. You spend all that time getting it "
		.. "right and somebody wants to shovel it into a tin and leave. Sit down! Let it cool enough to taste. "
		.. "And if you like it, say so before telling me how your mother would have made it."
	),
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
	response = "See you. Bring the bowl back if you've borrowed one.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Why do you keep cooking for everyone?",
	response = (
		"Because I'm good at it, and people will pay for something they actually want to eat. I didn't come "
		.. "here to run a charity. Still, you put a pot on and find yourself remembering who can't chew the "
		.. "tough bits, who'll arrive late, who says they aren't hungry and then watches everyone else's bowl. "
		.. "Old habits, perhaps. If I make a little extra, that's my decision. It doesn't mean everyone gets to "
		.. "start explaining what a generous fellow I am."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "You notice who misses a meal?",
	response = (
		"I notice what's left in the pot. Old Timer gets distracted. Jitters says he'll eat after the next "
		.. "patient, which is a fine plan if nobody ever gets hurt again. I put something aside. They can "
		.. "collect it or I can complain until they do. Don't make a touching story out of it. I also notice "
		.. "who brings the bowl back dirty."
	),
	options = {"BackTopic"},
})
