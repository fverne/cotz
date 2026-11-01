DIALOGUE.name = "Latch"
DIALOGUE.townContact = "latch"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Show me the condition first.")

DIALOGUE.addTopic("GREETING", {
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
	statement = "How do you decide what is still worth salvaging?",
	response = (
		"Look at the bits that have to fit, not the paint. A casing can look terrible and still have sound "
		.. "parts inside. Can look lovely and be wrecked, too. Costs less to check before you've dragged it "
		.. "halfway home."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Do you and Technut agree on what to keep?",
	response = (
		"Usually agree it's useful. Then he starts explaining what else it could do. I want a part that fits "
		.. "the job in front of me. He wants three jobs and a better version by supper. Keeps things lively."
	),
	options = {"BackTopic"},
})
