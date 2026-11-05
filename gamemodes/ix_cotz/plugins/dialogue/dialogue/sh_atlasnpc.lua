DIALOGUE.name = "Atlas"
DIALOGUE.townContact = "atlas"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Let's see what supplies you're trading.",
	"Of course. I'll move the notes; I don't want a good exchange becoming another mysterious stain on a survey."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello. There's room on this side of the papers. Catch your breath if you've just come in; I'd be glad to hear about the walk, or whatever else brought you.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
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
	statement = "What was survey work like before you came here?",
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
	statement = "What should I pay attention to on the way out?",
	response = "Look back occasionally. Stop and turn round, rather than glancing over your shoulder. A gap that looked obvious on the outward walk can be remarkably hard to recognise from the other direction. I used to argue with the trees about that. You can also write down where you stopped, even if the reason was only lunch. It gives the return journey a familiar piece to work with when the impressive parts have filled your head.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Whose accounts do you find useful?",
	response = "Ballast notices the footing before I finish discussing the shape of a bank. We've had some useful, irritating walks together. Ledger records the little details a tired traveller forgets to mention. Wake and I compare accounts when somebody hasn't returned: she begins with the person, I tend to begin with the journey. I try to remember which question she's asking before producing another sheet. Usually she lets me spread it out before pointing out the difference.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Of course. What were you wondering?",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
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
	statement = "I'll let you get back to the maps.",
	response = "Good journey. If you find a view worth stopping for, I'd enjoy hearing about that too.",
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

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Do stalkers describe anomaly fields very differently?",
	response = "Very. One begins with the sound, another with the ground, another with the argument about going round. I ask them to separate what they noticed from what they were told. Then, if they're willing, I ask about the argument. You learn something about a journey from where people disagree. Though I try to let them take their boots off first. Someone pointed out that my questions were becoming the longest part of their return.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Does Ballast ever ask you for a map?",
	response = "He'll look at one, then put his finger on the part he thinks I've made too tidy. Sometimes that's the whole waterside. We had a pleasant ten minutes over a bank once, followed by a less pleasant walk to look at it. He was right about the footing. I was right about where the bend began. We both found room to mention our own contribution afterwards. I'd miss those discussions if he suddenly became agreeable.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you write down the parts that aren't useful?",
	response = "Sometimes in the margin. A place someone stopped because the view surprised them, or because their companion finally stopped talking. I don't put every remark on a working sheet. I enjoy knowing the walk contained something besides difficulty. People are often surprised to be asked about that.",
	options = {"BackTopic"},
})
