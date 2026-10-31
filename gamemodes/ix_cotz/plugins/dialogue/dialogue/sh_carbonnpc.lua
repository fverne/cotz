DIALOGUE.name = "Carbon"
DIALOGUE.townContact = "carbon"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Keep it clear of the records, please.")

DIALOGUE.addTopic("GREETING", {
	response = "A date and a signature tell me more than another heroic story.",
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
		"I keep records. A maintenance ledger can tell you why a building went quiet. "
		.. "A story about a brave expedition usually leaves that part out."
	),
	options = {"BackTopic"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = "Write down where you found a record. A page without a place or a date can be worse than no page at all.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Egghead knows which findings to compare. The Original has accounts I still can't date. "
		.. "Boss has records I'd very much like to read."
	),
	options = {"BackTopic"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "What have you found?",
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
	response = "Keep the originals.",
})
