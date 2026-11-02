DIALOGUE.name = "Vesper"
DIALOGUE.townContact = "vesper"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Check what you need for the return trip.")

DIALOGUE.addTopic("GREETING", {
	response = (
		"Hello. If you're thinking of going near a field, tell me what you've brought before we discuss "
		.. "where."
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
	statement = "Tell me about yourself.",
	response = (
		"I work near anomaly fields. Not because I think I'm lucky. Because I prepare, take the "
		.. "reading, and leave while leaving is still an option."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Decide what makes you turn back before you enter. It's harder to make a sensible decision once "
		.. "you've spent the supplies."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Egghead knows the theory. Beanstalk worries about the right things, usually twice. Intern "
		.. "listens when you tell him to check his kit."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "You can admire the field from here. Closer costs preparation.",
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
	response = "Bring yourself back with the readings.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Why keep going back?",
	response = (
		"Because I like finding something I haven't understood yet. There, you can tell Beanstalk I "
		.. "admitted it. He thinks that's where the trouble starts. Sometimes he's right. I still want a "
		.. "proper look. I just want enough supplies left to argue about it afterwards."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Does Beanstalk think you take too many risks?",
	response = (
		"He worries aloud; I do the checks before I leave. We get on better when we discuss an actual "
		.. "trip instead of whether caution is a virtue. He asks useful questions. I don't have to enjoy "
		.. "all of them, and he doesn't have to enjoy all my answers."
	),
	options = {"BackTopic"},
})
