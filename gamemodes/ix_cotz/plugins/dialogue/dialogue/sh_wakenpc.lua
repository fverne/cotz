DIALOGUE.name = "Wake"

DIALOGUE.addTopic("GREETING", {
	response = "A name, a last location, anything they were carrying. Start there.",
	options = {"SpecialtyTopic", "BackgroundTopic", "AdviceTopic", "ContactsTopic", "GOODBYE"},
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What sort of work do you handle?",
	response = (
		"Personal-effects cases. Bring them back intact. I haven't finished checking the current search "
		.. "reports, so there isn't an assignment yet."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = (
		"I keep track of people who don't come back. Sometimes we find them. Sometimes we find enough "
		.. "to stop making somebody wait."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Write down where you're going and tell someone. A rough route is better than a search that "
		.. "starts with the whole Zone."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Atlas helps with routes. Spool remembers voices. Boss sometimes knows more than he'll put in a "
		.. "report. I keep asking."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "A name, a last location, anything they were carrying. Start there.",
	options = {"SpecialtyTopic", "BackgroundTopic", "AdviceTopic", "ContactsTopic", "GOODBYE"},
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "Let someone know you made it back.",
})
