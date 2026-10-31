DIALOGUE.name = "Vesper"
DIALOGUE.townContact = "vesper"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Check what you need for the return trip.")

DIALOGUE.addTopic("GREETING", {
	response = "You can admire the field from here. Closer costs preparation.",
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
		"I work near anomaly fields. Not because I think I'm lucky. Because I prepare, take the "
		.. "reading, and leave while leaving is still an option."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Decide what makes you turn back before you enter. It's harder to make a sensible decision once "
		.. "you've spent the supplies."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Egghead knows the theory. Beanstalk worries about the right things, usually twice. Intern "
		.. "listens when you tell him to check his kit."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "You can admire the field from here. Closer costs preparation.",
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
	response = "Bring yourself back with the readings.",
})
