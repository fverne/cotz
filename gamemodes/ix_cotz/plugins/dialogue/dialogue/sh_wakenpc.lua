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
	statement = "How did you start doing recovery work?",
	response = (
		"Someone had a last location and nobody to ask. I helped write down what they knew. There were other "
		.. "names afterwards. I don't have a special talent for saying the right thing. Usually I ask a small "
		.. "question and let the person finish answering it. Sometimes what comes back is enough to identify a "
		.. "journey. Sometimes all we have is a bag that belongs to someone who isn't here to collect it. It "
		.. "still needs looking after."
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
	response = "Take care on the way. You can come back to talk.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What if I cannot explain a disappearance?",
	response = (
		"We can take our time. Begin with the last conversation you had yourself. Put what you heard later "
		.. "to one side; we'll come to that. You don't need to make the whole account fit before telling me. "
		.. "People often leave out a detail because it sounds foolish, or because they're afraid it will make "
		.. "somebody angry. I'd rather hear it in your words while you still remember how uncertain you were."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Can you promise to find them?",
	response = (
		"No. I can promise to take the information seriously and handle what returns carefully. You can ask "
		.. "me to stop reading something personal while you're here. You can come back another day. I won't "
		.. "decide what a possession ought to mean to you. And I won't ask you to call a disappearance settled "
		.. "because an incomplete answer would make the paperwork easier."
	),
	options = {"BackTopic"},
})
