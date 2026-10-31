DIALOGUE.name = "Latch"
DIALOGUE.townContact = "latch"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Show me the condition first.")

DIALOGUE.addTopic("GREETING", {
	response = "If it still has a serial plate, it isn't just scrap.",
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
		"I worked around machinery before this place started eating it. Rust doesn't mean useless. "
		.. "Sometimes it means nobody looked properly."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Check a part before hauling it home. A heavy broken thing is still a broken thing when you've "
		.. "carried it twice as far."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Technut knows what he wants, down to the last screw. Gasket needs practical spares. Suture can "
		.. "usually find a use for the good straps."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "If it still has a serial plate, it isn't just scrap.",
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
	response = "Bring back something worth the weight.",
})
