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
	statement = "Are you always this nervous?",
	response = (
		"When there's nothing to do, yes. Plenty of time to think of what I've missed. When someone "
		.. "comes in hurt, there's an order to things. I know the order. It's afterwards I start wondering "
		.. "whether I should have— Anyway. Are you here because something hurts, or are we discussing my "
		.. "charming manner?"
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What helps you settle down?",
	response = (
		"Clean water. Food while it's still warm. Someone else saying they've checked the door or "
		.. "counted a shelf, and actually having done it. Gasket and Lemon can both be impossible, but they "
		.. "remember those things. I don't have to think of absolutely everything myself."
	),
	options = {"BackTopic"},
})
