DIALOGUE.name = "Wake"
DIALOGUE.townContact = "wake"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Can I look through your supplies?",
	"Of course. I'll put these belongings aside so we can keep the exchange clear."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello. Take a seat if you've had a long walk. We can talk about what brought you when you're ready.",
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
	statement = "How did you begin helping with recoveries?",
	response = "Someone needed to put what they knew in order. A name, a last conversation, the place somebody expected to reach. I sat with them and wrote it down. Then there was another person with a similar question. I don't always have something reassuring to say. I can ask carefully and look after what returns. Some days the useful part is letting someone finish without deciding their account ought to be easier to hear.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "What helps if someone needs to look for me?",
	response = "Tell somebody where you intend to go and when that plan changes, if you can. A rough account with a few recognisable places gives people somewhere to begin. They may remember the artifact you hoped to find more clearly than the route you mentioned. Ask them to repeat the route. You can both feel a little foolish about it now rather than leave the whole Zone to somebody's memory later.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you work with when somebody hasn't returned?",
	response = "Atlas asks careful questions about the journey. Spool remembers how a person sounded, which can help separate two confused accounts. Boss sometimes has information he has reasons to keep back. I ask what we need and let him explain the boundary. We don't always agree on where it belongs. Old Timer understands what it's like to keep asking. I don't expect him to discuss the reasons with everyone who comes through.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "All right. We can leave that there.",
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
	statement = "I'll let you get on.",
	response = "Take care. You're welcome to come back for an ordinary conversation too.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What if I don't know how to explain what happened?",
	response = "Start with something you remember yourself. The last words, where you were standing, the interruption you thought didn't matter. We can put the later accounts to one side until we reach them. You don't have to make the whole journey fit before telling it. And if you want to stop for a moment, say so. I can wait without filling the gap for you.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Can you promise someone will be found?",
	response = "I can't. I can listen properly, handle what comes back carefully, and be clear about what it establishes. A bag on a table doesn't answer every question about its owner. If there's something personal inside, we can decide how to approach it without an audience. You don't owe anyone an immediate conclusion because they're uncomfortable leaving a disappearance open.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Is it hard handling what stalkers leave behind?",
	response = "Sometimes it's the ordinary things that hold me up. A spoon wrapped so it won't rattle, a cuff repaired several times. Someone found room for them alongside ammunition and whatever they hoped would bring them money. I can look after the object without deciding what sort of person they were. And sometimes I put it aside and go and eat. I don't make better decisions for having missed another meal.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "What do you and Spool talk about away from work?",
	response = "Who talks in their sleep, how long a kettle takes, a caller who couldn't stop describing an artifact none of us could see. He's good company when he remembers he's allowed to leave a gap. I like hearing him laugh at something he was cross about yesterday. Sometimes he begins another account and I tell him I've only come for tea. He can manage that. We get a few minutes without anybody becoming a case.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you read the letters you find?",
	response = "Enough to know what I'm handling, if that's necessary. I don't read on because I'm curious about an argument or somebody's home. There are people who'd happily tell me what every scrap means. They can wait. The person it belongs to ought to have a say if we can find them.",
	options = {"BackTopic"},
})
