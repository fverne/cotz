DIALOGUE.name = "Spoor"
DIALOGUE.townContact = "spoor"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Let me see it.")

DIALOGUE.addTopic("GREETING", {
	response = (
		"You look as though you've been out. See anything feeding, or have you come about something "
		.. "else?"
	),
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
	statement = "What do you spend your time looking for?",
	response = (
		"Depends on the day. Tracks when I need them. Often it's something smaller: where an animal stopped "
		.. "to feed, where it walked around ground the others crossed. I like watching them when there isn't "
		.. "work attached. People find that odd here. They'd rather I told them the biggest thing I've killed. "
		.. "I've got those stories too. Usually remember the walk back more clearly than the shot. Especially "
		.. "if I had to carry something Lemon insisted was worth eating."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Know your way out before the first shot. A feeding ground can have more animals than the ones "
		.. "you can see."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Old Timer understands patience. The Original remembers things differently from the tracks. "
		.. "Spicy Lemon thinks every carcass belongs in his pot."
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
	response = "Keep your eyes on the ground as well as ahead.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What makes a good hunter?",
	response = (
		"Knowing when you've lost it. I followed the wrong tracks for an hour once because my first "
		.. "explanation pleased me. Kept finding reasons it must still be right. Old Timer heard that story and "
		.. "sat very quietly until I finished. Then he asked whether I'd enjoyed the extra walk. You can learn "
		.. "from someone without enjoying every minute of their company."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Can tracks tell you why an animal moved?",
	response = (
		"Sometimes they tell you where to look. Sometimes rain has got there first and you're left making "
		.. "guesses. I want to see the feeding ground and what else used it before I choose a reason. The "
		.. "Original remembers animals I've never seen. I'll listen. Then I'll go and look at the ground "
		.. "myself. He can complain about that on his own time."
	),
	options = {"BackTopic"},
})
