DIALOGUE.name = "Egghead"
DIALOGUE.townContact = "egghead"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Show me the goods.")

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
	statement = "What do you actually enjoy about studying artifacts?",
	response = (
		"When something refuses to fit. Frustrating, naturally, but at least I know I'm not simply copying "
		.. "what somebody else decided. The problem is finding enough good observations to distinguish a "
		.. "surprise from my own mistake."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Is admitting a mistake difficult?",
	response = (
		"Less difficult than listening to Beanstalk identify it for me. Don't look so pleased. I'll change "
		.. "an explanation when the evidence warrants it. I'd merely prefer the evidence to arrive before the "
		.. "lecture."
	),
	options = {"BackTopic"},
})
