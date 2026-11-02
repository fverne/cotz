DIALOGUE.name = "Gasket"
DIALOGUE.townContact = "gasket"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "What have you got?")

DIALOGUE.addTopic("GREETING", {
	response = (
		"If you've come to complain about the lights, bring fuel next time. Otherwise, what can I do for "
		.. "you?"
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
	statement = "How did you end up looking after this place?",
	response = (
		"Started with a leaking connection. I had a wrench, everyone else had advice. Next morning someone "
		.. "brought me a filter. Then a fuel can. By the end of the week people were asking when I'd have the "
		.. "lights back, as though we'd signed something. I complained. Still complain. But Jitters comes over "
		.. "with an empty water container and says he's got someone on the table - what am I going to do, "
		.. "explain that I'm only helping temporarily? Would be nice if they asked before borrowing the wrench, "
		.. "though. That part hasn't improved."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"A generator with no fuel is furniture. Check what your equipment actually needs before "
		.. "carrying a pile of useless spares."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Technut keeps borrowing parts to improve them. Jitters gets clean water first. Haggler gets an "
		.. "argument when he names his fuel price."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "What else?",
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
	response = "Close the lid if you borrowed anything. See you.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What would make your day easier?",
	response = (
		"An uninterrupted breakfast. Doesn't sound ambitious, does it? I put the kettle on, somebody wants a "
		.. "connection looked at. Sit down again, someone else has found a noise. By the time I get back, Lemon "
		.. "is asking why I haven't eaten. I do know they're asking because they trust me to sort it. I'd just "
		.. "like that trust to occasionally extend to leaving a thing alone when I've said it will last until "
		.. "morning."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Do you tell them that?",
	response = (
		"At considerable volume. They remember the volume better than the instruction. Technut's the worst: "
		.. "listens very carefully, understands every word, then explains why his idea is an exception. "
		.. "Sometimes it even works. Don't tell him I said that. He'll bring drawings."
	),
	options = {"BackTopic"},
})
