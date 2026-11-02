DIALOGUE.name = "Atlas"
DIALOGUE.townContact = "atlas"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"What do you have for sale?",
	"Of course. Let me move these papers so you can have a proper look."
)

DIALOGUE.addTopic("GREETING", {
	response = (
		"Hello. Come round this side; there's room. If you've just come in from outside, I'd like to "
		.. "hear how you found the walk. But catch your breath first. What can I do for you?"
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
		"I was a surveyor before I came here. Boundary lines, levels, long afternoons persuading "
		.. "someone their fence was in the wrong place. I liked the work. You could settle a disagreement "
		.. "by going out and measuring again. Here I spend rather more time asking what someone meant by "
		.. "'just past the trees'. Still, I like sitting down with a person who's noticed something I "
		.. "haven't. You can work on the same stretch for weeks and miss what a stranger sees on their "
		.. "first walk."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Turn round occasionally while you're walking out. Actually stop and look. A gap you can see "
		.. "easily from one direction may disappear completely from the other. I used to think "
		.. "remembering the outward journey was enough. Then I'd find myself arguing with a perfectly "
		.. "innocent stand of trees. And leave yourself time to be wrong. Finding the way back is much "
		.. "less unpleasant when you're neither thirsty nor in a hurry."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Ballast is worth listening to about the waterside, provided you let him finish complaining "
		.. "about whatever you're carrying. We disagree about how much a map can tell you. Usually he "
		.. "makes me go and look again, which is useful, if irritating. Ledger keeps the records I wish "
		.. "everyone kept. Wake and I compare what we have when someone fails to return. She asks who "
		.. "last saw them; I try to establish where. Neither question gets very far on its own."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Yes, of course. What did you want to ask?",
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
	response = (
		"Take your time out there. If something on the way surprises you, I'd be interested to hear "
		.. "about it when you're back."
	),
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What do you want to hear about a journey?",
	response = (
		"Which side you passed on, where you stopped, what made you change your mind. People tend to "
		.. "skip those bits and begin with whatever frightened them most. Understandable, but sometimes "
		.. "the little turn before it explains the whole difficulty. You needn't have the right words. "
		.. "I'd rather you described a muddy bank badly than called it a road because that sounds more "
		.. "useful. Here, there's a pencil if drawing it would help."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What if I can't remember it properly?",
	response = (
		"Then we leave that part open. It may come back while we're discussing something else. I once "
		.. "spent most of an evening trying to place a man's 'fallen tree'. Eventually he mentioned he'd "
		.. "sat on it to empty his boot. The tree was a pipe. He remembered it perfectly well; I'd "
		.. "supplied the branches. That's why I ask rather a lot of questions. Do stop me if I begin "
		.. "answering them myself."
	),
	options = {"BackTopic"},
})
