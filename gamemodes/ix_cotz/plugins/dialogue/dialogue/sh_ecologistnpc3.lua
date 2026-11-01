DIALOGUE.name = "Intern"
DIALOGUE.townContact = "intern"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Absolutely!")

DIALOGUE.addTopic("GREETING", {
	response = "Hello.",
	options = {
		"SpecialtyTopic",
		"TradeTopic",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = (
		"I do a longterm internship here, but they make me do all " .. "the counting of equipment..."
	),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "That sucks. Do you ever go outside?",
	response = "That's classified I'm afraid. But I'm getting tired of this suit.",
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "Alright, thanks.",
	response = "See you later.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else...",
	response = "Alright, what do you have in mind?",
	options = {
		"SpecialtyTopic",
		"TradeTopic",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "Take care!",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Do they really leave you counting equipment all day?",
	response = (
		"Not all day. There are forms afterwards. Sorry, that sounded worse than I meant it to. I know the "
		.. "equipment matters. I'd just like being able to explain a result to count for something too."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What would you work on if you could choose?",
	response = (
		"A survey I could take responsibility for from start to finish. Set it up, check the readings, write "
		.. "what I actually found. Vesper says knowing when to stop is part of the work. I'm trying to remember "
		.. "that too."
	),
	options = {"BackTopic"},
})
