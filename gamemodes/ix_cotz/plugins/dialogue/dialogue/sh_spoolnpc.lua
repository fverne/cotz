DIALOGUE.name = "Spool"

DIALOGUE.addTopic("GREETING", {
	response = "Hold on. That's a voice I haven't heard in a while.",
	options = {"SpecialtyTopic", "BackgroundTopic", "AdviceTopic", "ContactsTopic", "GOODBYE"},
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What sort of work do you handle?",
	response = (
		"Triangulate the source and bring the transmitter back. I'm checking the reports before sending "
		.. "anyone after a signal."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = (
		"I keep listening. You remember a voice after enough late check-ins. You remember it more when "
		.. "it stops calling."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Take proper bearings. If the readings don't agree, move and check again. Guessing a direction "
		.. "gets people lost."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Mute doesn't say much, but his work holds up. Smartass always has a correction. Wake asks "
		.. "about the voices nobody else remembers."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Hold on. That's a voice I haven't heard in a while.",
	options = {"SpecialtyTopic", "BackgroundTopic", "AdviceTopic", "ContactsTopic", "GOODBYE"},
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "Keep in touch.",
})
