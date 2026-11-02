DIALOGUE.name = "Spool"
DIALOGUE.townContact = "spool"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Yes. Mind the leads.")

DIALOGUE.addTopic("GREETING", {
	response = (
		"Hold on, let me turn that down. There. Come in. Have you come from far, or are you escaping the "
		.. "noise too?"
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
		"I keep listening. You remember a voice after enough late check-ins. You remember it more when "
		.. "it stops calling."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Take proper bearings. If the readings don't agree, move and check again. Guessing a direction "
		.. "gets people lost."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Mute doesn't say much, but his work holds up. Smartass always has a correction. Wake asks "
		.. "about the voices nobody else remembers."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Hold on. That's a voice I haven't heard in a while.",
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
	response = "Keep in touch.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Does anyone call just to talk?",
	response = (
		"Oh, constantly. Weather, boots, somebody else's terrible cooking. One fellow described a whole "
		.. "card game to me because nobody at his table would listen. You complain about it, then he misses "
		.. "a check-in and you'd happily hear every hand again. Sit down, if you've got a minute. Tell me "
		.. "something ordinary."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What do you do when you stop hearing someone?",
	response = (
		"Check before I decide what it means. Equipment fails. People change their plans. Wake "
		.. "understands why I won't call silence an answer. We compare what we know and what we only heard "
		.. "from somebody else. Doesn't make the waiting much easier for either of us."
	),
	options = {"BackTopic"},
})
