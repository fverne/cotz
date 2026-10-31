DIALOGUE.name = "Gasket"

DIALOGUE.addTopic("GREETING", {
	response = "If you've come to complain about the lights, bring fuel next time.",
	options = {"SpecialtyTopic", "BackgroundTopic", "AdviceTopic", "ContactsTopic", "GOODBYE"},
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What sort of work do you handle?",
	response = (
		"Fuel, filters, things we actually use up. Technut takes the machinery. I'm sorting out the "
		.. "supply lists before taking deliveries."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = (
		"Someone has to keep the generator fed and the water fit to drink. Apparently that someone is "
		.. "me."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"A generator with no fuel is furniture. Check what your equipment actually needs before "
		.. "carrying a pile of useless spares."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Technut keeps borrowing parts to improve them. Jitters gets clean water first. Haggler gets an "
		.. "argument when he names his fuel price."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "If you've come to complain about the lights, bring fuel next time.",
	options = {"SpecialtyTopic", "BackgroundTopic", "AdviceTopic", "ContactsTopic", "GOODBYE"},
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "Try leaving something running for once.",
})
