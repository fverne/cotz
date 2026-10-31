DIALOGUE.name = "Ledger"
DIALOGUE.townContact = "ledger"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "I'll check what's available.")

DIALOGUE.addTopic("GREETING", {
	response = "If it's arrived, I need the receipt. If it hasn't, I need a reason.",
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
		"Freight only moves reliably when somebody keeps track of both ends. I am usually that "
		.. "somebody."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Know where a parcel goes before collecting it. Picking it up doesn't mean the delivery is "
		.. "finished."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Ballast handles awkward ground. Cleaner understands discretion. Spool keeps people in contact. "
		.. "Haggler generates paperwork by disagreeing with it."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "If it's arrived, I need the receipt. If it hasn't, I need a reason.",
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
	response = "Bring the receipt.",
})
