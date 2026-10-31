DIALOGUE.name = "Atlas"

DIALOGUE.addTopic("GREETING", {
	response = "A route is only useful if it still gets you home.",
	options = {"SpecialtyTopic", "BackgroundTopic", "AdviceTopic", "ContactsTopic", "GOODBYE"},
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What sort of work do you handle?",
	response = (
		"I organise field surveys. Set down a recorder, let it finish, then bring it back. I'm still "
		.. "preparing the next survey."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = (
		"I used to survey land that stayed where you put it on paper. Out here, a map needs an argument "
		.. "and a date."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Pick a landmark for the return journey before you start looking at the next one. And always "
		.. "leave yourself supplies."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Ballast knows the waterside routes. Ledger keeps useful travel records. Wake and I compare "
		.. "notes when a survey team goes missing."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "A route is only useful if it still gets you home.",
	options = {"SpecialtyTopic", "BackgroundTopic", "AdviceTopic", "ContactsTopic", "GOODBYE"},
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "Keep your bearings.",
})
