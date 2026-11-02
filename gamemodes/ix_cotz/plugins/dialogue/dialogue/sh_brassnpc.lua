DIALOGUE.name = "Brass"
DIALOGUE.townContact = "brass"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "We'll count it first.")

DIALOGUE.addTopic("GREETING", {
	response = "Put the boxes where I can see the markings. If you're here for something else, say so.",
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
	statement = "You worked in a depot?",
	response = (
		"Kept the stock and the records. Mostly ordinary work: damp packaging, bad totals, a box nobody "
		.. "admits moving. You learn to check before accusing someone. Once you've made a public fuss over your "
		.. "own addition, the lesson stays with you. Here I still count what arrives and what leaves. People "
		.. "call it fussy until they're the person waiting for the last box. Then they'd like me to remember "
		.. "every round personally."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Read the marking and check what your weapon takes. A full bag of the wrong rounds is a very "
		.. "expensive dead weight."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Quartermaster understands an inventory. Haggler thinks counting is a bargaining tactic. Arena "
		.. "Master could stand to keep better records."
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
	response = "Take your copy. Good journey.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "You think I would short you?",
	response = (
		"Haven't counted yet. You may have brought too much. Happens often enough, particularly when someone "
		.. "packed in a hurry. Put your total beside mine. If they differ, we go through it again. You don't "
		.. "need to explain what sort of person you are while I'm holding a pencil. I'd rather settle the "
		.. "number and pay you for what actually arrived."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Would you tell me if I brought too much?",
	response = (
		"Of course. If I keep quiet, I spend the next delivery wondering whether you noticed. Then you check "
		.. "my payment, I check your explanation, and a simple transaction takes half the morning. "
		.. "Quartermaster and I have enough to disagree over without adding that. Count it, correct it, get on "
		.. "with the day."
	),
	options = {"BackTopic"},
})
