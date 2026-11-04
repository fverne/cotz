DIALOGUE.name = "Ledger"
DIALOGUE.townContact = "ledger"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "I'll check what's available.")

DIALOGUE.addTopic("GREETING", {
	response = "Hello. If it's arrived, I need the receipt. If it hasn't, I need to know what happened.",
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
	statement = "Have you always worked with freight?",
	response = (
		"Long enough to recognise the moment a straightforward delivery begins becoming an explanation. It "
		.. "usually starts with someone saying they assumed. I keep both ends of the journey in writing. There "
		.. "is a person waiting at each end, even when the sender has forgotten them. Some want their parcel, "
		.. "some want their payment, and a few simply want to know they can go to bed without listening for a "
		.. "knock. I find that worth getting right."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Know where a parcel goes before collecting it. Picking it up doesn't mean the delivery is "
		.. "finished."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Ballast handles awkward ground. Cleaner understands discretion. Spool keeps people in contact. "
		.. "Haggler generates paperwork by disagreeing with it."
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
	response = "Good journey. I'll keep this end of the account.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "You remember every late parcel?",
	response = (
		"The punctual ones leave fewer conversations behind. One involved three explanations, two proposed "
		.. "destinations, and a man who insisted we had never met. We had. Same borrowed coat, same request to "
		.. "keep this informal. I don't particularly enjoy catching somebody out. I would enjoy the original "
		.. "receipt considerably more. If you've brought one, you may improve my afternoon without becoming "
		.. "memorable yourself."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What if the two ends disagree?",
	response = (
		"I retain both accounts and ask what each person actually saw. Often there is a dull explanation. A "
		.. "changed time, a misunderstood name. Haggler tends to offer an exciting one before I've finished the "
		.. "question. Writing it down allows us to return to what was agreed after everyone has had time to "
		.. "calm down. A useful service, even for people who make fun of my handwriting."
	),
	options = {"BackTopic"},
})
