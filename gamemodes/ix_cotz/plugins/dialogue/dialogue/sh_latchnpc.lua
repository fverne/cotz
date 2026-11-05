DIALOGUE.name = "Latch"
DIALOGUE.townContact = "latch"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Let's see what tools and supplies you have.",
	"Take a look. Give yourself room to put the heavy things down properly."
)

DIALOGUE.addTopic("GREETING", {
	response = "Room on the bench if you've brought a part. Otherwise take a seat where I won't knock your knee. What is it?",
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
	statement = "What did you like about industrial work?",
	response = "Having someone at the other end who knew why you were waiting. Could pass a tool without stopping to explain the whole job. We kept machinery going long after the people scheduling maintenance had lost interest. Here you meet people who see a rusty lump and stop looking. I don't mind showing them what matters. Nice when one comes back later and puts a useful part on the bench without needing to be told.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "How do I avoid hauling back useless salvage?",
	response = "Look at the working surfaces before you admire the weight of it. Ask yourself what has to fit against what. If you don't know, describe the part before making a whole expedition out of carrying it. A proper look takes less time than getting a heavy thing out of a sack because you suddenly need your hands for a mutant. Learned that with a vice. Won't improve the story by telling it again.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who appreciates the things you recover?",
	response = "Technut can become interested enough to forget I need the bench space. Good eye once you've got him looking at the job in front of him. Gasket wants things he can put to use before somebody asks why the water's stopped. Suture sees a good strap where I've seen wrapping. I like finding out somebody else noticed a useful part I walked past. Less keen on being told about it while I'm still carrying the load.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "All right. What are we looking at?",
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
	statement = "I'll leave you to the work.",
	response = "See you. Pack the small pieces before you lift the big one.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Would you show me how you judge a part?",
	response = "Show me where you think it's worn. You don't need the name yet. Look along the surface that meets another piece, then look at the other side. Rust can be ugly without settling the question. I like seeing the moment someone stops guessing what answer I want and starts looking properly. Better to be wrong with a part on the bench than halfway back from a wreck carrying three of them.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Would Technut judge it differently?",
	response = "He'd find a use for it and then another three. I'd like the first one finished before we divide the thing into possibilities. But I'll ask him when I can't place something. He keeps being curious after I've become annoyed. Useful quality to have at the other end of a bench. Sometimes I can leave him with the puzzle and get some work done.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Have you ever carried back something that wasn't worth the weight?",
	response = "A vice. Looked sound, moved freely, thought I'd been clever finding it. Halfway back I was stopping every few minutes to change hands. Heard a mutant somewhere ahead and discovered I could put it down very promptly after all. Carried it the rest of the way when things quietened. It's a good vice. Use it often. Doesn't improve the memory of carrying the bloody thing.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "What does Suture see in the things you salvage?",
	response = "Usually something I've wrapped round the part I wanted. Old webbing, a buckle, material I'd have used as padding. Starts asking where it came from and whether there's more. I used to think we were disagreeing about what was worth keeping. Then I watched Suture pick through it. Knows where to look for the wear. Same pleasure as watching someone examine a bearing properly. I try to leave the material uncut now.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Would you carry it back again?",
	response = "Ask me while it's holding a job still on the bench and I'll say yes. Ask me halfway up the bank and you'll get a different answer. Don't need those two versions brought together in front of an audience.",
	options = {"BackTopic"},
})
