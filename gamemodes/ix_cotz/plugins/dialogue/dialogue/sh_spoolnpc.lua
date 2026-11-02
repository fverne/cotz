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
	statement = "How did you end up at the radio?",
	response = (
		"I was the one who didn't mind staying to listen. Then everyone knew where to call, and leaving "
		.. "became awkward. I like it, mostly. You learn who clears their throat before speaking, who calls "
		.. "only when something is wrong, who has absolutely no reason to call and does anyway. The trouble is "
		.. "sleeping afterwards. Someone says 'I'll try again later' and part of you stays awake to hear them. "
		.. "Sorry. Have we met? If I've heard your voice before, it'll come to me."
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
	response = "Good journey. Nice to hear a voice without the static for once.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Does anyone call just to talk?",
	response = (
		"Constantly. Boots, weather, a card game in terrible detail. One fellow kept telling me what he "
		.. "should have played after the hand was finished. I could barely keep my eyes open. Next evening I "
		.. "caught myself hoping he'd call. There's a long stretch between checking equipment and deciding you "
		.. "might as well go to bed. Ordinary nonsense fills it quite nicely. If you've got some, take a seat."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What happens when someone stops calling?",
	response = (
		"I check the equipment, then ask who last heard them. People change plans. Batteries fail. Sometimes "
		.. "the person waiting for a call was the one who wrote the time down wrong. Wake helps me separate "
		.. "what I heard myself from what somebody thinks they remember. I won't call silence an answer. "
		.. "Doesn't mean I don't sit here trying to hear one."
	),
	options = {"BackTopic"},
})
