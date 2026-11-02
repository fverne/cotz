DIALOGUE.name = "Ballast"
DIALOGUE.townContact = "ballast"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Set it down. Let me have a look.")

DIALOGUE.addTopic("GREETING", {
	response = "Come closer if you like. Mind the ground there; it looks firmer than it is. What have you got?",
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
	statement = "How did you get into moving freight?",
	response = (
		"Someone needed a load moved and didn't fancy the wet part. I did it. The next fellow had heard I "
		.. "was willing, which is how a day's work acquires a career. I don't mind the pace. You load properly, "
		.. "work out where your hands will be needed, leave yourself room. People can be nervous; that's all "
		.. "right. I'd sooner explain something twice to a frightened person than have a confident one climbing "
		.. "about while I'm trying to keep the load steady."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Think about carrying the case back before you step down the bank. Getting there empty-handed "
		.. "is the easy half."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Atlas wants to draw permanent lines through changing ground. Ledger at least packs a parcel "
		.. "properly. Haggler always understates the weight."
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
	response = "Watch your footing. I'll be here.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "You sound suspicious of urgent work.",
	response = (
		"I'll hear them out. Might be medicine. Might be Haggler remembering something he promised three "
		.. "days ago. They begin with 'It's only a little parcel', then mention the rest when I've agreed. So I "
		.. "ask a few dull questions. Weight, destination, who'll take it off my hands. If those ruin the "
		.. "surprise, we were going to have an unpleasant conversation somewhere wetter."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Does Atlas ask the same questions?",
	response = (
		"More. Then he asks whether I meant left before the turn or left after it. We get there eventually. "
		.. "I tease him because he'll listen to an answer even after he's spent an evening drawing something "
		.. "different. Plenty of people would rather you walked into trouble than spoiled their neat work. "
		.. "He'll get another sheet out."
	),
	options = {"BackTopic"},
})
