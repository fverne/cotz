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
	statement = "Why did you become a prospector?",
	response = (
		"I liked the work before I became sensible enough to describe it as preparation. I still like it. A "
		.. "reading changes, you find something you didn't expect, and for a little while the walk was worth "
		.. "all the packing. Then you have to come back, clean everything, explain why you were late. That's "
		.. "less glamorous. Beanstalk hears me enjoying the first part and thinks I've forgotten the rest. I'm "
		.. "willing to admit I've occasionally made that impression very convincing."
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
	response = "Good journey. Leave yourself time for the return.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Why keep going back?",
	response = (
		"Because I want another look. Sometimes I spend the return journey deciding what I'd do differently, "
		.. "then get annoyed because I have to eat and sleep before trying it. There's pleasure in doing a trip "
		.. "well too. Enough water left, equipment packed properly, no argument about which way we came. You "
		.. "get home and discover you can still enjoy the discovery. That's a better evening than explaining "
		.. "why someone else didn't return."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Does Beanstalk think you take too many risks?",
	response = (
		"He worries aloud. I tend to start answering before he's finished. Neither habit improves the "
		.. "discussion. If we talk about an actual trip, he asks useful things: what changed, what I left out, "
		.. "why I chose that spot. I can answer those. 'Be more careful' is harder to pack. Intern has started "
		.. "asking the useful questions too. I hope we let him finish them."
	),
	options = {"BackTopic"},
})
