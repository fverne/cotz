DIALOGUE.name = "Brass"
DIALOGUE.townContact = "brass"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "We'll count it first.")

DIALOGUE.addTopic("GREETING", {
	response = "Put the boxes down. We'll count them before we discuss payment.",
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
		"I kept depot records. Still do. Ammunition doesn't become the right calibre because somebody "
		.. "wrote nearly the right number on the box."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Read the marking and check what your weapon takes. A full bag of the wrong rounds is a very "
		.. "expensive dead weight."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Quartermaster understands an inventory. Haggler thinks counting is a bargaining tactic. Arena "
		.. "Master could stand to keep better records."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Put the boxes down. We'll count them before we discuss payment.",
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
	response = "Count what you have before you leave.",
})
