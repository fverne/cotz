DIALOGUE.name = "Gasket"
DIALOGUE.townContact = "gasket"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "What have you got?")

DIALOGUE.addTopic("GREETING", {
	response = "If you've come to complain about the lights, bring fuel next time.",
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
		"Someone has to keep the generator fed and the water fit to drink. Apparently that someone is "
		.. "me."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"A generator with no fuel is furniture. Check what your equipment actually needs before "
		.. "carrying a pile of useless spares."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Technut keeps borrowing parts to improve them. Jitters gets clean water first. Haggler gets an "
		.. "argument when he names his fuel price."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "If you've come to complain about the lights, bring fuel next time.",
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
	response = "Try leaving something running for once.",
})
