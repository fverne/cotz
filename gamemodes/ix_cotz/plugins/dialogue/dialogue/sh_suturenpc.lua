DIALOGUE.name = "Suture"
DIALOGUE.townContact = "suture"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Let me see the condition.")

DIALOGUE.addTopic("GREETING", {
	response = "Hold still a moment. Your strap is twisted. There. Now, what did you come in for?",
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
	response = "Look after the seams.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Does everything have to be practical?",
	response = (
		"No. You're allowed to like how something looks. I'd rather you said so than invented a "
		.. "technical reason for wanting it. We can consider appearance after it fits. Stand naturally, "
		.. "please. Nobody spends six hours walking with their chest pushed out like that."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Does it bother you when your work comes back damaged?",
	response = (
		"It bothers me when nobody mentions where it failed. A torn seam I can inspect. 'It just went' "
		.. "isn't much help. Arena Master's customers are particularly inventive about how nothing happened "
		.. "to their gear. I'd rather hear the embarrassing version and make the next one fit better."
	),
	options = {"BackTopic"},
})
