DIALOGUE.name = "Latch"
DIALOGUE.townContact = "latch"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Show me the condition first.")

DIALOGUE.addTopic("GREETING", {
	response = "Got something to show me? Put it down where I can see the part that actually does the work.",
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
		"I worked around machinery before this place started eating it. Rust doesn't mean useless. "
		.. "Sometimes it means nobody looked properly."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Check a part before hauling it home. A heavy broken thing is still a broken thing when you've "
		.. "carried it twice as far."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Technut knows what he wants, down to the last screw. Gasket needs practical spares. Suture can "
		.. "usually find a use for the good straps."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "If it still has a serial plate, it isn't just scrap.",
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
	response = "Bring back something worth the weight.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Can you teach me what to look for?",
	response = (
		"Yes. Pick it up. Tell me where you think it's worn. Don't look at me; look at the part. Being "
		.. "wrong here costs us a minute. Better than carrying twenty kilos home because you were "
		.. "embarrassed to ask. We'll see whether the surfaces that need to fit still do."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Would Technut make the same choice?",
	response = (
		"Usually he'd agree it's useful. Then he'd explain what else it could do. I want a part that "
		.. "fits the job in front of me. He wants three jobs and a better version by supper. I complain, "
		.. "but when I can't make sense of something, he's worth asking."
	),
	options = {"BackTopic"},
})
