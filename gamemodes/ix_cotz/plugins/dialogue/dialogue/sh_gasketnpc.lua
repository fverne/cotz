DIALOGUE.name = "Gasket"
DIALOGUE.townContact = "gasket"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"What supplies have you got to trade?",
	"Have a look. Keep the fuel away from the breakfast, if you'd be so kind."
)

DIALOGUE.addTopic("GREETING", {
	response = "Come in. Tell me if you've brought a problem before I put the kettle on. I'd enjoy finishing one cup today.",
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
	statement = "How did you become responsible for the camp's utilities?",
	response = "Had a wrench when a connection needed looking at. Everyone else had suggestions. Next day somebody brought a filter, then fuel, then a question about when I'd finish. By the time I thought to explain I was only helping, Jitters was asking about water for the clinic. You can imagine how convincing my objection sounded. I like a place that works. I would also like to decide occasionally when I'm the person making it work.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "What do people overlook when packing equipment?",
	response = "What they'll need to keep using it. They remember every round for the mutant hunt, then discover the other equipment needs something they left behind. Check before you've got a wet pack spread across a bank. And put the lids back on the things you check. Seems an ambitious request round here.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who helps keep things running here?",
	response = "Latch knows a useful spare when he sees one. Technut knows three more uses for it, which can become a problem if I needed it for the first. Jitters actually tells me what the water's for, so I know what can't wait. Lemon notices when breakfast has been interrupted again. Haggler notices when I've run out of fuel. We each have our own way of showing an interest.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Go on. I've heard the start now.",
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
	statement = "I'll leave you to it.",
	response = "See you. And ask before borrowing something; it's a pleasant sound I'd like to hear more often.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What would you do with an uninterrupted morning?",
	response = "Have breakfast while it was breakfast. Listen to the camp waking up without somebody deciding a loose fitting is a personal emergency. Then I'd probably look at the fitting. I know what you're about to say. There's a difference between seeing something that needs doing and being fetched halfway through a mouthful. Some of the people fetching me have just spent six hours being very patient beside an anomaly. Apparently they use it all up outside.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Have you told them you need a break?",
	response = "Repeatedly. Technut listens with great sympathy before explaining that his idea won't take a moment. Lemon tells me to sit down, then wants an opinion on a noise near the kitchen. I do sometimes finish the meal. Those mornings I can be quite agreeable. People are surprised enough to keep asking what's happened, which spoils it a bit.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "What bothers you most after everyone comes back from an expedition?",
	response = "Mud. All the excitement over an artifact, and six people standing about shedding half the Swamps while they explain who carried it. Boots off would be a start. Then somebody remembers they've left an empty container beside the water. Everybody's exhausted, apparently. I'm allowed to be exhausted as soon as I've finished clearing up. Still, I like hearing them outside. Means I can complain to their faces instead of wondering where they've got to.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Do you ever get a fair deal from Haggler?",
	response = "He thinks every deal's fair if he can explain it long enough. Fuel costs more because the route's dangerous. Route gets easier, now it's demand. Demand drops, now he's keeping reserves. I keep going back because the can eventually arrives. Doesn't mean I have to admire the speech attached to it. Once he carried one over himself. Complained about the weight. I told him he'd bought the full experience.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Is there a time when nobody needs anything?",
	response = "Early, sometimes. Before the first kettle starts an argument. You can hear the camp waking up a bit at a time. I sit down if I can. People see me sitting and assume I'm available, so I've learned to look quite cross while enjoying myself.",
	options = {"BackTopic"},
})
