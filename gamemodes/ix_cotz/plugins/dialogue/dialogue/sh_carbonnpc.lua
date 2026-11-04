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
	statement = "Why collect all these records?",
	response = (
		"I enjoy reading them. That seems to surprise people; they assume I'm waiting for a page that "
		.. "explains the whole Zone. Usually I find someone trying to get a delivery acknowledged or a damaged "
		.. "roof repaired. A name turns up in two places and suddenly I can follow a little of their working "
		.. "week. I don't know them. I wouldn't pretend to. But I can keep what they wrote together long enough "
		.. "for someone else to recognise it."
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
	response = "What else did you want to discuss?",
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
	response = "Good journey. Keep the pages together.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What can a maintenance record tell you?",
	response = (
		"Someone kept requesting the same window latch. Three entries over two months. Then another hand "
		.. "writes, 'Fixed it myself.' I laughed when I found it. You can almost hear the conversation that "
		.. "preceded that entry. It doesn't explain a disappearance or uncover an operation. It's simply a "
		.. "moment that survived because a person had a pencil and was sufficiently annoyed. I'd hate to lose "
		.. "it because the rest of the folder looked unimportant."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Do you collect stories as well?",
	response = (
		"Gladly, if the teller lets me ask questions. The Original gets impatient when I want a date. I get "
		.. "impatient when he supplies one with suspicious confidence. Neither is a good reason to throw his "
		.. "account away. I put what he remembers beside what survives on paper. Sometimes the disagreement "
		.. "tells me where to look next; sometimes we just have to leave it there."
	),
	options = {"BackTopic"},
})
