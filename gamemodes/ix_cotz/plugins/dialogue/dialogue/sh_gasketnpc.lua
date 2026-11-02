DIALOGUE.name = "Gasket"
DIALOGUE.townContact = "gasket"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "What have you got?")

DIALOGUE.addTopic("GREETING", {
	response = (
		"If you've come to complain about the lights, bring fuel next time. Otherwise, what can I do for "
		.. "you?"
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
	response = "Try leaving something running for once.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What would make your day easier?",
	response = (
		"Put things back. Same shelf, same container, lid on. Nobody believes that's a serious answer. "
		.. "They want me to name an expensive part they can heroically fetch. I spend half my morning "
		.. "finding what somebody borrowed for five minutes. You want gratitude? Return a funnel."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Does anyone notice when everything works?",
	response = (
		"They notice when I ask them not to touch it. That's close enough. Quiet machinery, people "
		.. "complaining about something else, a cup I can finish while it's hot. I don't need applause over "
		.. "the engine. Though I wouldn't refuse a little peace and quiet."
	),
	options = {"BackTopic"},
})
