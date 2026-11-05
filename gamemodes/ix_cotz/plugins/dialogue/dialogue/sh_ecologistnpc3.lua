DIALOGUE.name = "Intern"
DIALOGUE.townContact = "intern"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Can I look at the equipment you're trading?",
	"Of course. Let me clear the survey kit so we don't mix anything up."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello. There's a clear space here, if you'd like to put anything down. I was checking the survey kit; what can I help with?",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "What do you look after in the research programme?",
	response = "Instruments, survey preparations, the returns that need sorting before somebody can make sense of them. I'm good at finding the cable everyone remembers using and nobody remembers putting away. I also work with the readings. I'd like people to ask about that before asking which cupboard has the spare connectors. They're entitled to need the connectors. I just sometimes wish I could finish explaining something before finding them.",
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Do you get to follow the surveys into the field?",
	response = "Less often than I'd like. Preparing the kit gives me a part of the journey, then someone else comes back with the interesting interruptions. I'd like to follow one through from the first question to the final account. There are things I can't discuss about the work. Counting the equipment isn't one of them. I could tell you about that very confidently, though I won't pretend it makes an exciting expedition story.",
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "I hope you get to follow one through.",
	response = "Thank you. I intend to have the kit ready when the opportunity comes. Preferably without anyone needing to remind me that's also a responsibility.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Yes? I've got a moment.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll let you finish preparing.",
	response = "Good journey. Hope the packing makes sense when you need something in a hurry.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Have you asked for a survey of your own?",
	response = "Yes. Accurate preparation is a responsibility, which is the answer I keep getting and a very difficult answer to dispute. I'd like to choose the comparison, check a reading I didn't expect, and explain what it might mean. Correct my own mistake instead of passing the awkward bit to someone senior. I'm allowed to want that without being ungrateful for the part I've learned, I think. That sentence comes out more clearly here than it does when I ask.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Would you tell Egghead if you thought he was wrong?",
	response = "With the figures in front of me, yes. In conversation I can spend too long trying to begin politely. Vesper says to start with the reading and let the apology look after itself. Egghead does listen when I get that far. Sometimes he becomes interested enough to forget to interrupt. I'd like to stop depending on that particular opening.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Is there a part of fieldwork you actually enjoy?",
	response = "Packing the instruments once I know where everything goes. That probably sounds like an answer chosen to please someone. I do enjoy it. After a day near anomalies, with everyone remembering a different interruption, it's pleasant to have one bag whose contents make sense. I can find what I need without unpacking the whole expedition. Then someone borrows a lead and puts it back in the wrong pocket, and I become surprisingly difficult company.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Does Beanstalk worry about you too much?",
	response = "He asks whether I've eaten, then whether I've checked the equipment. Sometimes I'd like him to assume both. But he stays for the answer. If I say something doesn't seem right, he doesn't immediately send me to ask Egghead. I appreciate that. I just wish appreciation didn't make it so difficult to tell him I've already checked the same fastening twice. Three times, if we're being accurate. The last was my own idea.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you tell people when they've moved your things?",
	response = "If I catch them doing it. Afterwards I practise a very clear explanation while sorting the bag. Then Egghead arrives with something interesting and I forget the explanation completely. I suspect he'd call that a promising sense of priorities. I'd like the lead back first.",
	options = {"BackTopic"},
})
