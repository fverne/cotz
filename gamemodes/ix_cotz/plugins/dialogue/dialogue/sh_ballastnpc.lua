DIALOGUE.name = "Ballast"
DIALOGUE.townContact = "ballast"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Set it down. Let me have a look.")

DIALOGUE.addTopic("GREETING", {
	response = "Water's patient. Be a shame to let it outlast you over a parcel.",
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
		"I move cargo where the roads stop being useful. Most losses start with somebody deciding the "
		.. "water looks shallow enough."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Think about carrying the case back before you step down the bank. Getting there empty-handed "
		.. "is the easy half."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Atlas wants to draw permanent lines through changing ground. Ledger at least packs a parcel "
		.. "properly. Haggler always understates the weight."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Water's patient. Be a shame to let it outlast you over a parcel.",
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
	response = "Watch your footing.",
})
