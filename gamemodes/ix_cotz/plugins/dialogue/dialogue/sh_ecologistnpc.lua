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
	statement = "What brought you from the university?",
	response = (
		"An increasingly unproductive disagreement about whose work was whose. I was studying physics and "
		.. "nanotechnology in Kiev; I expected rather more interest in my results than in my willingness to "
		.. "accept a senior name above them. Eventually I was encouraged to gather research of my own. Here I "
		.. "am. I may have overstated my enthusiasm for independence during the argument. Still, it's difficult "
		.. "to stay indignant when somebody brings in an object that makes the next three questions more "
		.. "interesting than the last complaint."
	),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Do you receive any support?",
	response = (
		"Rations and supplies, yes. Funding with which to pursue every interesting question, no. I complain "
		.. "about the first because I spend too long thinking about the second. You'll find the available "
		.. "supplies for sale here. My opinion of the university isn't a discount, before you ask."
	),
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "You sell some of those supplies?",
	response = (
		"It keeps things moving. Someone needs equipment; I need room, money, and occasionally an object "
		.. "worth examining. We can manage a useful exchange without resolving my academic grievances. Though "
		.. "you're welcome to hear those at greater length if you've nothing urgent to do."
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
	response = "Good journey. I'd be interested to hear what you notice.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Do you miss the university?",
	response = (
		"The library. Equipment that arrived with instructions. An afternoon in which the most alarming "
		.. "interruption was somebody asking for a signature. Then I remember defending a result to a man who "
		.. "hadn't read it, and the longing becomes manageable. Here a disagreement can be put on the table "
		.. "between us and examined. Sometimes with tongs. I find that arrangement quite refreshing."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Is it difficult to admit you were wrong?",
	response = (
		"Depends who notices first. Beanstalk enjoys a properly supported objection, and I enjoy finding a "
		.. "flaw in it. On a good day we learn something before becoming unbearable. On a bad one, Intern has "
		.. "to listen to both of us. If a result changes the explanation, I'll change it. I'd merely like five "
		.. "minutes to enjoy the result before somebody begins recalling what they told me last week."
	),
	options = {"BackTopic"},
})
