DIALOGUE.name = "Egghead"
DIALOGUE.townContact = "egghead"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Show me the goods.")

DIALOGUE.addTopic("GREETING", {
	response = "Hello. Have you brought something interesting, or have you come to interrupt the search for it?",
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
		"Sure. Overly intelligent, physics and nanotechnology PhD "
		.. "student from Kiev, got tired of the older professors stealing "
		.. "all my hard-earned work."
	),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Yeah? But how did you end up here then?",
	response = (
		"They told me I was entitled, and after complaining to the "
		.. "university dean, they evicted me to this hellhole, to 'gather "
		.. "my own research'. And guess what - they don't even fund "
		.. "me!"
	),
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "How do you make a living if you don't get any funding?",
	response = (
		"I guess they do fund me, in terms of rations, but they "
		.. "are so tasteless. Hey, listen, here's a deal. If you want "
		.. "to buy some shitty supplies from Kiev, let me know. I want "
		.. "to fuck the professors over as much as possible."
	),
	options = {
		"BackgroundTopic4",
	},
})

DIALOGUE.addTopic("BackgroundTopic4", {
	statement = "Thanks I guess, won't they be mad if they know?",
	response = (
		"Hypothetically, they would, but who would tell them? If "
		.. "I hear anything, I'll have you evicted into an anomaly. "
		.. "Take care!"
	),
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else...",
	response = "What else is there to talk about?",
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
	response = "Don't trip into an anomaly!",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Do you miss the university?",
	response = (
		"The equipment. A library where the book you need hasn't been used to level a table. "
		.. "Occasionally the conversation. Then I remember spending an afternoon defending a result to "
		.. "someone who hadn't read it. Here, at least, an objection sometimes arrives in a container and "
		.. "does something interesting."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Is admitting a mistake difficult?",
	response = (
		"Less difficult than listening to Beanstalk identify it for me. Don't look so pleased. I'll "
		.. "change an explanation when the evidence warrants it. I'd merely prefer the evidence to arrive "
		.. "before the lecture. Finding out why I was wrong can be more interesting than being right in the "
		.. "first place."
	),
	options = {"BackTopic"},
})
