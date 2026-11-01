DIALOGUE.name = "Suture"
DIALOGUE.townContact = "suture"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Let me see the condition.")

DIALOGUE.addTopic("GREETING", {
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
	statement = "Can you really judge a trip by someone's straps?",
	response = (
		"I can tell what rubbed, what was overloaded, and what someone tied in a hurry. The wearer usually "
		.. "tells me the rest while insisting none of it was their fault. Hold still long enough and equipment "
		.. "is quite informative."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Does it bother you when your work comes back damaged?",
	response = (
		"It bothers me when nobody mentions where it failed. A torn seam I can inspect. 'It just went' isn't "
		.. "much help. Arena Master's customers are particularly inventive about how nothing happened to their "
		.. "gear."
	),
	options = {"BackTopic"},
})
