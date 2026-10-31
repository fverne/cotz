DIALOGUE.name = "Egghead"
DIALOGUE.townContact = "egghead"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Show me the goods.")

DIALOGUE.addTopic("GREETING", {
	response = "Hello.",
	options = {
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
