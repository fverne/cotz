DIALOGUE.name = "Suture"
DIALOGUE.townContact = "suture"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Let me see the condition.")

DIALOGUE.addTopic("GREETING", {
	response = "Turn around. That strap is doing half the work of the whole pack.",
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
		"I put equipment together so it stays together outside. Most people notice the stitching only "
		.. "after it stops doing its job."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Try your equipment with the weight you'll actually carry. An empty pack tells you very little "
		.. "about the walk home."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Quartermaster gives clear specifications. Latch brings good materials. Arena Master's "
		.. "customers bring back the sort of damage nobody admits causing."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Turn around. That strap is doing half the work of the whole pack.",
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
	response = "Look after the seams.",
})
