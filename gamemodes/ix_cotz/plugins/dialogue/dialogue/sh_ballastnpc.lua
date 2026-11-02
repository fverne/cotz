DIALOGUE.name = "Ballast"
DIALOGUE.townContact = "ballast"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Set it down. Let me have a look.")

DIALOGUE.addTopic("GREETING", {
	response = "Come closer if you like. Mind the ground there; it looks firmer than it is. What have you got?",
	options = {
		"SpecialtyTopic",
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
		"SpecialtyTopic",
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

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "You don't sound impressed by urgent work.",
	response = (
		"Urgent usually means someone spent three days making it my problem. I'll hear them out. Might "
		.. "be medicine. Might be Haggler remembering a promise he made while drinking. Either way, I'd "
		.. "like to know what I'm carrying before I discover I need another pair of hands."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What if they say the trip is perfectly safe?",
	response = (
		"Then I ask why they're still standing beside me. Don't mistake that for refusing the work. I "
		.. "just like the difficult bits explained before I've got both hands full. If a person knows the "
		.. "route, they can tell me what made them choose it."
	),
	options = {"BackTopic"},
})
