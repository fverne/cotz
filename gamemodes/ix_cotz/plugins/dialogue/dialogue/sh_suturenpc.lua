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
	statement = "How did you become an outfitter?",
	response = (
		"I could mend things, and people kept bringing things that needed mending. Eventually I wanted to "
		.. "see them before they'd been dragged through everything imaginable. You learn rather more fitting a "
		.. "pack to its owner than listening to a description of how it failed. Most people demonstrate the "
		.. "problem without noticing. They lift a shoulder, pull a strap, stand differently. Then they tell me "
		.. "it fits perfectly. We can usually improve on perfectly once they've stopped posing."
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
	response = "What else did you want to discuss?",
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
	response = "Check that strap before you leave. Yes, that one.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Does everything have to be practical?",
	response = (
		"You're allowed to like how something looks. Tell me that instead of inventing a technical reason "
		.. "for wanting it. We can consider appearance after it fits. I won't make you explain an old patch or "
		.. "a colour you prefer. People carry enough things chosen for them. But stand naturally while I check "
		.. "the straps, please. Nobody walks six hours with their chest pushed out like that."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Does damaged work bother you?",
	response = (
		"It bothers me when nobody says where it failed. A torn seam gives me something to inspect. 'It just "
		.. "went' gives me a person hoping I won't ask another question. Arena Master's customers become "
		.. "remarkably vague about what happens to their equipment. I'd sooner hear the embarrassing version. I "
		.. "can change a seam. I can't improve an account that leaves out the fall."
	),
	options = {"BackTopic"},
})
