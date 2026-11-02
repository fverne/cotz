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
	statement = "Tell me about yourself.",
	response = (
		"I watch what moves, where it feeds, and what makes it leave. A dead mutant doesn't explain "
		.. "much if you never looked around it."
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
	response = "Tell me where you saw it. Then tell me what it was eating.",
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
	response = "Keep your eyes off the trophy until it's quiet.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What makes a good hunter?",
	response = (
		"Depends what you're hunting. Patience helps. So does admitting you lost the trail. I've "
		.. "followed the wrong tracks for an hour because I liked my first explanation. Tell that to Old "
		.. "Timer if you want. He'll remember a longer version."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Can tracks really tell you that much?",
	response = (
		"Sometimes. Sometimes they only tell you where to look next. I want to know what was feeding "
		.. "there, which way it went, whether anything followed. A trophy tells everyone you killed "
		.. "something. The ground around it might make the next walk easier."
	),
	options = {"BackTopic"},
})
