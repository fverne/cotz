DIALOGUE.name = "Wake"
DIALOGUE.townContact = "wake"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Of course. What do you need?")

DIALOGUE.addTopic("GREETING", {
	response = "A name, a last location, anything they were carrying. Start there.",
	options = {
		"BackgroundTopic",
		"AdviceTopic",
		"ContactsTopic",
		"GOODBYE",
		"TradeTopic",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = (
		"I keep track of people who don't come back. Sometimes we find them. Sometimes we find enough "
		.. "to stop making somebody wait."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Write down where you're going and tell someone. A rough route is better than a search that "
		.. "starts with the whole Zone."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Atlas helps with routes. Spool remembers voices. Boss sometimes knows more than he'll put in a "
		.. "report. I keep asking."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "A name, a last location, anything they were carrying. Start there.",
	options = {
		"BackgroundTopic",
		"AdviceTopic",
		"ContactsTopic",
		"GOODBYE",
		"TradeTopic",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "Let someone know you made it back.",
})
