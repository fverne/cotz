DIALOGUE.name = "Spoor"
DIALOGUE.townContact = "spoor"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Let me see it.")

DIALOGUE.addTopic("GREETING", {
	response = "Tell me where you saw it. Then tell me what it was eating.",
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
