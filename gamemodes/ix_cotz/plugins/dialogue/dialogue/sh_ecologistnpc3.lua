DIALOGUE.name = "Intern"
DIALOGUE.townContact = "intern"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Absolutely!")

DIALOGUE.addTopic("GREETING", {
	response = "Hello.",
	options = {
		"TradeTopic",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = (
		"I do a longterm internship here, but they make me do all " .. "the counting of equipment..."
	),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "That sucks. Do you ever go outside?",
	response = "That's classified I'm afraid. But I'm getting tired of this suit.",
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "Alright, thanks.",
	response = "See you later.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else...",
	response = "Alright, what do you have in mind?",
	options = {
		"TradeTopic",
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
	response = "Take care!",
})
