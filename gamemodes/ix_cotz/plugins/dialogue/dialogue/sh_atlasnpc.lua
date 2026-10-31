DIALOGUE.name = "Atlas"
DIALOGUE.townContact = "atlas"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Put it down here, away from the survey sheets.")

DIALOGUE.addTopic("GREETING", {
	response = "A route is only useful if it still gets you home.",
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
		"I used to survey land that stayed where you put it on paper. Out here, a map needs an argument "
		.. "and a date."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Pick a landmark for the return journey before you start looking at the next one. And always "
		.. "leave yourself supplies."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Ballast knows the waterside routes. Ledger keeps useful travel records. Wake and I compare "
		.. "notes when a survey team goes missing."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "A route is only useful if it still gets you home.",
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
	response = "Keep your bearings.",
})
