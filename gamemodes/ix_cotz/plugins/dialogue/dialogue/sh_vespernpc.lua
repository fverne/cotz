DIALOGUE.name = "Vesper"
DIALOGUE.townContact = "vesper"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Let's see your expedition supplies.",
	"Have a look. Leave yourself room to bring something back besides the empty packaging."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello. Been out, or still enjoying the part where everything's packed neatly? Either way, take a moment. What do you need?",
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
	statement = "What drew you into prospecting?",
	response = "Wanted to see what was there. Still do. A reading changes, you get another look at a field, there's a find you can't stop thinking about on the walk back. Then you're home sorting wet equipment and explaining why you were late. I've learned to enjoy doing that part properly too. Beanstalk usually catches me describing the exciting bit and assumes he's hearing my entire approach to the work. I may occasionally encourage that misunderstanding.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "What do you decide before approaching an anomaly field?",
	response = "What would make me call the trip finished. Enough supplies spent, an approach I can't judge, something I hadn't allowed for. Easier to answer while you're still looking at the whole afternoon. Get interested in an artifact and you'll find quite persuasive reasons for another few minutes. I can supply several from memory. I'd prefer you had your own answer before you find out how convincing they sound.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Whose advice do you listen to?",
	response = "Egghead can make a finding interesting again when I'm sick of carrying it. Beanstalk asks the useful awkward questions once we've stopped arguing about whether I'm careful. Intern notices equipment I was hoping wouldn't need another look. I tell him when he's right. Doesn't require a senior person to approve the observation first, though he's still inclined to wait for one.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Go on. I haven't put my boots back on yet.",
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
	response = "Good journey. Hope there's something worth telling over supper, even if the most exciting part was staying dry.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What makes you want another expedition?",
	response = "On the way home I remember a place I didn't have time to look at properly. Or I think of a question that would have been excellent to ask before packing the recorder. By supper I've got a convincing argument for going back. Sometimes I leave it until morning and discover I mostly wanted another walk with the same people. Good company makes a lot of wet ground tolerable.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What happens when Beanstalk disagrees with your plans?",
	response = "We talk more usefully once I let him finish the actual question. He wants to know what I noticed and why I chose an approach. I can answer that. If he just says I sound too pleased with myself, we may take a while getting anywhere. Intern has started asking about the actual trip before joining the argument. Sensible fellow. I try to give him the chance to keep doing it.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Which part of an expedition do you look forward to most?",
	response = "The first quiet stretch after everyone's finished adjusting their pack. You've still got food, nobody's decided to explain their boots, and the whole day hasn't happened yet. Getting an artifact home is a fine feeling, obviously. But there are trips where the best part was sitting somewhere dry for ten minutes, looking at a field from far enough away to enjoy the view. I tend to leave that bit out when I'm telling the exciting version.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Do you like taking questions from Intern?",
	response = "When he asks the one he actually wants answered. Sometimes there's a small speech first, explaining why he knows the question may be foolish. By then I've forgotten which reading we were discussing. He notices things, though. Asked me why I'd stopped in a place I hadn't mentioned in my notes. I'd stopped to eat. He looked so relieved to have an ordinary answer that I nearly apologised for it.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you ever ask him for help?",
	response = "With the equipment, certainly. He remembers which lead belongs with which instrument while I'm still looking through the bag. I tell him when he's saved me time. Doesn't require a ceremony. He seems to expect one before he's allowed to feel pleased.",
	options = {"BackTopic"},
})
