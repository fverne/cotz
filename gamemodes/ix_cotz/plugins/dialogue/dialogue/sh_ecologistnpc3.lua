DIALOGUE.name = "Intern"
DIALOGUE.townContact = "intern"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Absolutely!")

DIALOGUE.addTopic("GREETING", {
	response = "Hello. Sorry about the equipment; I was in the middle of counting it. What can I help you with?",
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
	statement = "Why don't you ask for more responsibility?",
	response = (
		"I have. Apparently knowing where every instrument is makes me indispensable to the cupboard. "
		.. "Sorry, that was unkind. Someone has to do it. I'd just like a chance to make a mistake that "
		.. "belongs to my own research for once."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What would you work on if you could choose?",
	response = (
		"A survey I could take responsibility for from start to finish. Set it up, check the readings, "
		.. "write what I actually found. Vesper says knowing when to stop is part of the work. I'm trying "
		.. "to remember that too, even when I think I can get one more useful reading."
	),
	options = {"BackTopic"},
})
