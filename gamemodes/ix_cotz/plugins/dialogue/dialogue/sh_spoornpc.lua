DIALOGUE.name = "Spoor"
DIALOGUE.townContact = "spoor"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Let me see it.")

DIALOGUE.addTopic("GREETING", {
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
	statement = "Why don't you care much for trophies?",
	response = (
		"They tell everyone you killed something. They don't tell you why it was there. I want to know what "
		.. "it was feeding on and where the rest went. That's more useful on the next walk."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Can you tell that much from tracks?",
	response = (
		"Sometimes. Sometimes you can only tell where to look next. The Original doesn't much like that "
		.. "answer. A long story is more satisfying than a patch of mud you haven't understood yet."
	),
	options = {"BackTopic"},
})
