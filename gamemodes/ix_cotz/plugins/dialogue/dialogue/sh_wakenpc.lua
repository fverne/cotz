DIALOGUE.name = "Wake"
DIALOGUE.townContact = "wake"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Of course. What do you need?")

DIALOGUE.addTopic("GREETING", {
	response = (
		"Hello. If you're looking for someone, we can start with their name. Otherwise, tell me what you "
		.. "need."
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
	response = "Let someone know you made it back.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What if I can't explain a disappearance properly?",
	response = (
		"We can do it slowly. Start with the last time you spoke to them yourself. Anything you heard "
		.. "afterwards, we'll write separately. You don't have to make it sound sensible before you tell "
		.. "me. That's part of what we're here to work out."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Can you promise you'll find them?",
	response = (
		"No. I can promise to take the information seriously and be careful with what comes back. A last "
		.. "location from someone who saw them is different from a story passed round a table. Both can "
		.. "help, provided we don't dress one up as the other."
	),
	options = {"BackTopic"},
})
