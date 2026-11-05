DIALOGUE.name = "Egghead"
DIALOGUE.townContact = "egghead"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Let's look at your supplies and possible exchanges.",
	"Certainly. I can put the interesting questions aside long enough to discuss a price."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello. You've caught me looking for a note I was quite certain I'd put somewhere sensible. What have you come about?",
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
	statement = "Why leave the university for the Zone?",
	response = "Physics and nanotechnology in Kiev, followed by an increasingly weary argument about whose name belonged over the work. I expected a little more attention to the results. Eventually I was encouraged to gather research of my own. Naturally I made independence sound splendid. Here a stalker can walk in with an artifact and ruin an entire afternoon I'd set aside for being indignant. Difficult to sustain a grievance with a better question on the table.",
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Does the university still support your research?",
	response = "Rations and supplies, yes. The resources to pursue every interesting comparison, no. I can explain the difference at considerable length. Beanstalk can explain it back to me with an inventory attached. Some of the available supplies are for sale here. My opinion of the funding arrangement isn't included as a discount, though you're welcome to hear it while you look.",
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "How does trading fit into the research?",
	response = "Room, funds, equipment changing hands instead of sitting where somebody else could use it. An exchange can be useful without resolving my relationship with the university. I'd like to spend more time following a finding and less time deciding which practical matter has become urgent. Naturally, when someone brings in an interesting artifact, I help make the practical matters more urgent by ignoring them for an hour.",
	options = {
		"BackgroundTopic4",
	},
})

DIALOGUE.addTopic("BackgroundTopic4", {
	statement = "Would they approve of that arrangement?",
	response = "I suspect we would have a long discussion about the wording. I'd prefer to spend the afternoon on an object whose properties might change my mind. You can tell me if you come across a university form with that quality.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Yes? We can return to that when one of us has thought of a better question.",
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
	statement = "I'll let you get back to it.",
	response = "Good journey. If something puzzles you out there, I'd enjoy hearing the part you haven't explained yet.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What do you miss about university life?",
	response = "The library. Equipment that arrived with instructions. A stretch of afternoon in which the most intrusive thing was somebody wanting a signature. Then I remember trying to discuss a result with a man who hadn't read it. Here a disagreement can sit on the table between us. Sometimes it requires tongs. I enjoy that arrangement, provided nobody expects the object to wait while we settle whose interpretation sounded cleverest.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "How do you handle a result that proves you wrong?",
	response = "I become very interested in it and hope everyone gives me a few minutes before mentioning what I'd predicted. Beanstalk is not always generous with the interval. I can hardly complain; I've reminded him of a misplaced objection often enough. Intern has had to listen to both versions. We should probably let him finish his own explanation before beginning the next round. He does occasionally have one worth hearing.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Can you enjoy an artifact without studying it?",
	response = "A Moonlight can hold my attention quite successfully before I've thought of a useful question. That blue is very difficult to describe without sounding like a catalogue for an expensive ornament. Then someone asks what it does, and I become professionally respectable again. There is a collector's pleasure in looking. I understand it perfectly. What irritates me is being expected to explain every property of an object because we've both agreed it's beautiful.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "What do you and Carbon exchange besides research?",
	response = "Complaints about handwriting. I want to read the figures; he wants to know why the writer became hurried on the next page. Occasionally we discover the same coffee stain and approach it from our respective disciplines. He's made me look twice at notes I'd have passed over. I've made him sit through an explanation he didn't ask for. We both describe this as a useful exchange, and sometimes it even is.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do collectors ever ask better questions than researchers?",
	response = "Certainly. One asked why I'd stopped talking when I saw what he'd brought. Excellent observation. I was trying to remember where I'd put the comparison notes. He thought I'd recognised something momentous. We were both disappointed, though he concealed it less politely.",
	options = {"BackTopic"},
})
