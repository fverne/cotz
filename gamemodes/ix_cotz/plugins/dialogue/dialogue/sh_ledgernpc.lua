DIALOGUE.name = "Ledger"
DIALOGUE.townContact = "ledger"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "I'll check what's available.")

DIALOGUE.addTopic("GREETING", {
	response = "If it's arrived, I need the receipt. If it hasn't, I need a reason.",
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
	response = "Bring the receipt.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Why remember every overdue parcel?",
	response = (
		"Because someone at the other end is making plans around it. A consignment can look like a number on "
		.. "my desk and still be the thing that stops their work tomorrow. I try to remember both views."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What do you do when the two ends disagree?",
	response = (
		"Keep both accounts until I can check them. Haggler would prefer I remember only the most recent "
		.. "conversation. Unfortunately for him, writing things down is rather the point of my being here."
	),
	options = {"BackTopic"},
})
