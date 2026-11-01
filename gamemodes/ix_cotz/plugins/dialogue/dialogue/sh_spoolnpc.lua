DIALOGUE.name = "Spool"
DIALOGUE.townContact = "spool"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Yes. Mind the leads.")

DIALOGUE.addTopic("GREETING", {
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
	statement = "How do you keep listening for so long?",
	response = (
		"Bad tea, mostly. And people have habits. One clears his throat before every call, another "
		.. "apologises for the noise even when there isn't any. After a while you're listening for someone, not "
		.. "just a signal."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What happens when you stop hearing them?",
	response = (
		"I check before I decide what it means. Equipment fails. People change their plans. Wake understands "
		.. "why I won't call silence an answer. Doesn't make the waiting much easier for either of us."
	),
	options = {"BackTopic"},
})
