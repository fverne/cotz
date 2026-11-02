DIALOGUE.name = "Carbon"
DIALOGUE.townContact = "carbon"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Keep it clear of the records, please.")

DIALOGUE.addTopic("GREETING", {
	response = "Hello. Have you brought a record, or have you come to ask why I keep so many?",
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
	response = "Keep the originals.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What's so interesting about maintenance records?",
	response = (
		"Someone kept asking for the same replacement window latch. Three entries over two months. Then "
		.. "another hand writes, 'Fixed it myself.' I don't know who either person was yet. But for a "
		.. "moment you can hear them sharing a workplace. I'd like to preserve that before someone uses the "
		.. "page to light a stove."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Do you think they expected anyone to read it?",
	response = (
		"Most probably wanted the next shift to stop asking the same question. Either way, I'd rather "
		.. "understand what they meant than borrow a sentence to support a story I've already decided to "
		.. "tell. If you find a page, remember where it came from. That can matter as much as what's "
		.. "written on it."
	),
	options = {"BackTopic"},
})
