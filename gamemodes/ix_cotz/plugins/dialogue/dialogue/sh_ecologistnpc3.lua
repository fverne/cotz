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
	statement = "What is your part in the research?",
	response = (
		"Keeping the instruments accounted for, preparing surveys, checking returns. A surprising amount of "
		.. "research begins with discovering that the cable everyone remembers is in someone else's cupboard. "
		.. "I'm good at that part now. I'd like to be known for something besides knowing which shelf to look "
		.. "on. Sorry, that sounds ungrateful. I do get to work with the readings. I just have to finish "
		.. "counting the equipment before I can sit down with them."
	),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Do you get much field experience?",
	response = (
		"Less than I'd like. Preparing a survey teaches you things, but I want to follow one through without "
		.. "handing it over at the interesting part. There are details I can't discuss. That doesn't mean every "
		.. "afternoon spent counting connectors is a secret operation."
	),
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "I hope you get the opportunity.",
	response = (
		"Thank you. I should probably have the preparations finished when it comes. Otherwise I'll have "
		.. "given them an excellent reason to keep me beside the cupboard."
	),
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else...",
	response = "What else did you want to discuss?",
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
	response = "Good luck. I'll keep the notes in order here.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Why not ask for more responsibility?",
	response = (
		"I have. The answer is generally that accurate preparation is a responsibility, which is true and "
		.. "rather difficult to argue with. What I mean is a survey I can follow all the way through. Choose "
		.. "the comparison, check the result, explain the awkward part instead of handing it to someone senior. "
		.. "I'm quite capable of making an error of my own. It would be useful to have the chance to correct "
		.. "one too."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Would you challenge one of their conclusions?",
	response = (
		"On paper, confidently. In the room, I sometimes spend too long arranging the first sentence. Vesper "
		.. "says to start with the reading and stop apologising for having it. Egghead will listen if I can "
		.. "explain the objection. I know that. Knowing it and interrupting him are different skills. I'm "
		.. "working on the second. Please don't tell him I described it as training."
	),
	options = {"BackTopic"},
})
