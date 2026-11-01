DIALOGUE.name = "Jitters"
DIALOGUE.townContact = "jitters"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "How can I help?")

DIALOGUE.addTopic("GREETING", {
	response = "Welcome!",
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
	response = "What would you like to know?",
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
	response = "Take care, STALKER...",
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
	statement = "Is there ever a quiet day here?",
	response = (
		"Sometimes. That's when I count everything twice and wonder what I've forgotten. Then somebody comes "
		.. "in holding a hand where a bandage should be and I remember why I was counting. Sorry. You asked "
		.. "about a quiet day, didn't you?"
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What helps you settle down?",
	response = (
		"Clean water. Something to eat that hasn't gone cold while I was busy. Gasket and Lemon can be "
		.. "impossible, but they remember those things. It helps knowing I don't have to think of absolutely "
		.. "everything myself."
	),
	options = {"BackTopic"},
})
