DIALOGUE.name = "Ballast"

DIALOGUE.addTopic("GREETING", {
	response = "Water's patient. Be a shame to let it outlast you over a parcel.",
	options = {"SpecialtyTopic", "BackgroundTopic", "AdviceTopic", "ContactsTopic", "GOODBYE"},
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What sort of work do you handle?",
	response = (
		"Stranded cases. Find them, keep them dry, bring them back. I haven't got a recovery ready for "
		.. "you yet."
	),
	options = {"BackTopic", "GOODBYE"},
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
	options = {"SpecialtyTopic", "BackgroundTopic", "AdviceTopic", "ContactsTopic", "GOODBYE"},
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "Watch your footing.",
})
