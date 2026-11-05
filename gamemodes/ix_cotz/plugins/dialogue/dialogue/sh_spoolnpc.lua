DIALOGUE.name = "Spool"
DIALOGUE.townContact = "spool"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"What electronics and supplies are you trading?",
	"Have a look. I'll turn this down so we can hear each other without competing."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hang on, let me turn that down. There. Much better. You've got my attention now; what brings you in?",
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
	statement = "How did you end up being the one on the radio?",
	response = "I stayed to listen when somebody else wanted their supper. Next time they knew where to call. I liked recognising people before they gave a name: a cough, the way they begin complaining, a pause before the real question. Eventually getting up felt like leaving in the middle of a conversation. I still enjoy it. Could do with remembering that enjoying a conversation doesn't oblige me to remain awake for every possible continuation.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "What makes a useful report over the radio?",
	response = "Where you were, what you actually heard or saw, and the bit you aren't certain about. Give the position while you've still got the map out. People remember every noise from a mutant encounter and then say they were somewhere beyond the trees. Plenty of trees available. You can tell the exciting version afterwards; I'd like the first account to let somebody ask a useful question.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you rely on when something doesn't make sense?",
	response = "Mute lets me show him the faulty piece before explaining why it can't be faulty. Smartass likes the explanation first so he can improve it. Both useful, provided I get a word in at the right moment. Wake asks which voice I heard myself and which I've only been told about. Makes me slow down. Some evenings that's welcome, even if I've begun the story rather enthusiastically.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Go on. Nice to hear the end of a sentence without asking for it again.",
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
	statement = "I'll let you get back to listening.",
	response = "Good journey. Enjoyed the company. If I remember where I've heard your voice, it'll be just after you've gone.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What do people call about when nothing's wrong?",
	response = "Boots. Food. A disagreement over the size of a mutant neither of them saw particularly well. Had a fellow describe a whole card game, including what he'd meant to do. I was exhausted by the last hand. Next evening I caught myself wanting to know whether he'd played again. It's company. You can be tired of a man's favourite subject and still be glad to hear him begin.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What do you do when a familiar caller goes quiet?",
	response = "Check the equipment and ask when somebody last heard them. Plans change. A battery fails. I've written a time down wrong myself. Wake helps me keep those possibilities apart from the thing I'm worried has happened. I can be quite sensible while I'm asking the questions. Afterwards I still catch myself listening for the cough before they speak. Don't suppose that's a technical problem anyone can fix.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Do people argue about artifacts over the radio?",
	response = "Until somebody needs the channel for something useful. Then they take a breath and begin the same argument at a lower volume, as if that solves it. One chap described his find three times. Different comparison each time: egg, fist, potato. By the end I wanted to know whether he'd found an artifact or was making supper. He laughed so hard I couldn't understand the correction. Still don't know what it looked like.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "What is talking to Mute like for you?",
	response = "Restful at first. I can put a faulty piece on the bench without competing with three theories about it. He looks, I wait, we get somewhere. Then I remember I've been sitting quietly for ten minutes and start telling him about the day. He'll move a chair so I can keep talking without leaning on his work. I choose to consider that encouragement. He has plenty of ways to make the alternative clear.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Doesn't all that chatter wear you out?",
	response = "Oh, absolutely. I spend half the evening wishing they'd finish and the next morning remembering the funny bit. It's the fellow who keeps checking whether I can hear him that does for me. Yes, I can hear you. I could hear you the first four times. Tell me something while we're both still awake.",
	options = {"BackTopic"},
})
