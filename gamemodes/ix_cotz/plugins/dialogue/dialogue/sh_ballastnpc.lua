DIALOGUE.name = "Ballast"
DIALOGUE.townContact = "ballast"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"What supplies can we trade?",
	"Have a look. You can work out how to carry it before you decide."
)

DIALOGUE.addTopic("GREETING", {
	response = "There's firmer ground a little closer. Take your time. Have you brought something, or just come to talk?",
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
	statement = "How did moving freight become your living?",
	response = "Agreed to move a load nobody else fancied taking near the water. Next fellow had heard I was willing. After a few more it seemed I had a profession. There's work I enjoy in it: finding how a load wants to sit, getting everybody's hands where they're needed. Frightened people can learn that perfectly well. It's the confident fellow changing his mind while you're lifting who makes the day interesting.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "What do you check before recovering a heavy load?",
	response = "Where I'll put it down when I need a rest. People see the case and plan one great effort. Then they're on a muddy bank with nowhere to set it and both hands occupied when they hear a mutant. I like a dull place to stop. Gives you time to find out whether that noise deserves the attention you're about to give it.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Whose judgement do you trust with freight?",
	response = "Ledger's, once I've found the end of his string. Atlas will listen when I tell him the ground won't bear the weight, though he may want a second conversation about exactly where. Haggler tells me something is a small load before mentioning how many of them there are. I ask the dull questions first now. He seems to miss the surprise.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "I'm in no hurry. Go on.",
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
	statement = "I'll be on my way.",
	response = "Good journey. No need to prove how fast you can leave.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Why all the questions before you agree to a load?",
	response = "Because people remember the awkward details in stages. First it's a parcel, then it's urgent, then there's something inside that mustn't get wet. By then they think we've agreed. I'll listen to a real hurry. Medicine, somebody waiting outside, that's worth understanding. But Haggler discovering his own deadline after breakfast doesn't make the bank any firmer. Weight, destination, who takes it at the other end. We can be friendly once those are clear.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Does Atlas make that easier or harder?",
	response = "Takes longer, usually. Wants to be sure which bend I meant. But if his sheet disagrees with what I saw, he asks another question instead of announcing that I must've gone to the wrong place. Pleasant change. I tease him until he brings the paper out again. Then I have to explain which of my complaints was actually about the ground.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "What do stalkers do while they wait here?",
	response = "Watch the water at first. Then they start explaining why they aren't worried about it. One had just come back from an anomaly field and apparently that made a wet bank beneath his dignity. Sat down in it halfway through the explanation. I let him finish. You can offer a man a hand without making him tell the story again from the beginning. He came back later with a rather more sensible place to sit.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Is Ledger really that good at packing freight?",
	response = "Keeps the heavy things where you expect them. Labels you can find without turning everything over. There's pleasure in that after a morning of other people's surprises. Does use rather a lot of string. I've told him I intend to open the parcel eventually. He says the receiver has scissors. We each think that settles the matter in our favour. I'd still take his packing over Haggler's description of it.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you mind people waiting without talking?",
	response = "No. Pleasant enough when nobody's trying to fill every gap. You hear things you were talking over before. A bird, a loose fitting, somebody finally admitting they're hungry. If you're expecting me to name every noise out there, you'll have a disappointing afternoon.",
	options = {"BackTopic"},
})
