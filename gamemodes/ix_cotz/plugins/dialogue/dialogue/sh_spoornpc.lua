DIALOGUE.name = "Spoor"

DIALOGUE.addTopic("GREETING", {
	response = "Tell me where you saw it. Then tell me what it was eating.",
	options = {"SpecialtyTopic", "BackgroundTopic", "AdviceTopic", "ContactsTopic", "GOODBYE"},
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What sort of work do you handle?",
	response = (
		"Mutants threatening the routes. I'll name the quarry when I have a hunt ready. Nothing to send "
		.. "you after just now."
	),
	options = {"BackTopic", "GOODBYE"},
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
	options = {"SpecialtyTopic", "BackgroundTopic", "AdviceTopic", "ContactsTopic", "GOODBYE"},
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "Keep your eyes off the trophy until it's quiet.",
})
