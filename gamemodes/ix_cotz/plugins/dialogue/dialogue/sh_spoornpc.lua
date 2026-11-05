DIALOGUE.name = "Spoor"
DIALOGUE.townContact = "spoor"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"What hunting supplies can we trade?",
	"Have a look. There's room to set the pack down."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello. If you've seen something outside, I'm interested. If you've come for something else, say so.",
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
	statement = "What keeps you interested in tracking?",
	response = "Small decisions. An animal goes round a patch the others crossed, stops where I expected it to keep moving. I want to look at the ground. Doesn't always lead to an answer. Sometimes rain gets there before I do, sometimes I lose interest and eat. People want a hunting story to end with a shot. I've had good mornings where nothing happened that would hold their attention through supper.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "What do you check before taking a shot at a mutant?",
	response = "Where I'll go if the shot changes what everything else is doing. You can watch one animal so closely you miss the others. I also look at the ground between me and the way back. A place to stand and a place to run aren't necessarily the same. Then I decide whether I need the shot. Nobody's waiting to congratulate me for making a bad position more exciting.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you enjoy talking to about hunting?",
	response = "Old Timer can let an account finish. Might ask one question afterwards that makes you wish you'd told it differently. The Original notices things, but you have to find them inside the performance. Lemon wants to know which part can go near his kitchen. I let him decide that. Good to have someone ask a different question about the same animal, even when he sounds offended by my answer.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Go on.",
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
	response = "Good walk. You needn't hurry back with an explanation for everything you see.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "How do you know when you've followed the wrong trail?",
	response = "Sometimes you don't, until you've spent an hour explaining every awkward sign away. Did that myself. The first idea pleased me and I wanted to keep it. Old Timer let me tell the whole account, then asked if I'd enjoyed the extra walk. I remember being annoyed more clearly than the tracks. Helps when I hear myself becoming very certain about something I haven't gone over to look at.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Can you tell why a mutant has moved?",
	response = "I can find questions to ask. What was feeding there, what else passed through, whether I'm even following the same animal. The ground doesn't owe me a complete account. The Original has recollections I can't check from a track. I'll hear him out. Might ask where he stood. He usually makes room for that question once he's finished deciding whether to be offended.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "What do you watch when you aren't on a hunt?",
	response = "Boars, if I can sit well away and the wind isn't making everything awkward. Easy to spend a whole morning interested in where one decides to put its feet. Had a stalker ask what I was waiting for. Told him I was watching. He waited beside me for a while, then asked again. I don't think he enjoyed the morning. I did, until I remembered I'd left my food in the other coat.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Is The Original ever right about the mutants?",
	response = "He's noticed things worth asking about. Described an animal favouring one side; I asked which leg. Showed me where he'd been standing before he answered. I liked that part. Rest of the story grew considerably on the next telling. I stayed for it. You don't have to stop enjoying a man's company because you've stopped believing every distance he gives you.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you tell him when you don't believe it?",
	response = "Usually asks before I've decided whether to bother. Watches my face through the important part. Think he enjoys the objection, provided I've listened first. I can give him that much. He stayed awake through a fairly dull account of tracks for me.",
	options = {"BackTopic"},
})
