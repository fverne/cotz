DIALOGUE.name = "Jitters"
DIALOGUE.townContact = "jitters"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "How can I help?")

DIALOGUE.addTopic("GREETING", {
	response = "Come in. Are you hurt? Sorry, I should let you answer before I start looking for a bandage.",
	options = {
		"SpecialtyTopic",
		"TradeTopic",
		"HealTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else.",
	response = "What else did you want to discuss?",
	options = {
		"SpecialtyTopic",
		"TradeTopic",
		"HealTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	}, -- Should be identical to GREETING's options
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you!",
	response = "Take care. Of yourself, I mean. Not just the supplies.",
})

DIALOGUE.addTopic("HealTopic", {
	statement = "Can you patch me up?",
	response = "What would you like me to look at?",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	GetDynamicOptions = function(self, client, target)
		return ix.progression.GetTreatmentOptions(client, target)
	end,
	ResolveDynamicOption = function(self, client, target, data)
		return ix.progression.ResolveServiceOffer(client, target, "treatment", data)
	end,
})

DIALOGUE.addTopic("ConfirmHeal", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, client, target, data)
		ix.progression.ConfirmService(self, client, target, "treatment", data)
	end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {
			{
				statement = "I can agree to that. Go ahead and heal me.",
				topicID = "ConfirmHeal",
				dyndata = { accepted = true },
			},
			{
				statement = "On second thought...",
				topicID = "ConfirmHeal",
				dyndata = { accepted = false },
			},
		}

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, data)
		if SERVER then
			local accepted = type(data) == "table" and data.accepted == true
			local completed = ix.progression.ExecuteService(client, target, "treatment", accepted)
			if accepted and not completed then
				client:Notify("That service could not be completed. Please request a fresh quote.")
			end
		end

		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneyHeal", {
	statement = "",
	response = "Not enough money for that.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Are you always this nervous?",
	response = (
		"You've caught me between things. That's the worst time. Someone comes through the door bleeding, I "
		.. "can ask questions, wash my hands, start doing something useful. An empty doorway gives me rather "
		.. "more possibilities. I rearranged that shelf yesterday because I thought the dressings would be "
		.. "easier to reach. Spent this morning reaching where they used to be. Very productive improvement. "
		.. "You can sit down, incidentally. You don't have to stand there waiting for me to become reassuring."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Want me to leave you to your work?",
	response = (
		"No, you're all right. Just tell me if you actually need treatment. I've been known to mistake "
		.. "politeness for a symptom. Otherwise we can talk for a moment. Gasket was telling me about a "
		.. "perfectly ordinary repair earlier. I understood perhaps half of it. Rather enjoyed having something "
		.. "I didn't need to understand completely. He seemed surprised when I asked him to finish."
	),
	options = {"BackTopic"},
})
