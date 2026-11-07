DIALOGUE.name = "Brass"
DIALOGUE.townContact = "brass"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Let's look at your ammunition and supplies.",
	"All right. We'll keep the totals clear on both sides."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello. Ammunition on the clear side of the table, if you've brought any. Otherwise, what do you need?",
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
	statement = "How did you end up reloading ammunition?",
	response = "Depot work put enough damaged ammunition in front of me to make me interested in what could still be used. Now I spend more time at the loading bench. Sorting cases, checking what belongs together, putting doubtful material aside. It suits me. Nobody benefits from my hurrying. I still count everything twice, including what I owe you; that habit has saved more arguments than it has started.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "What do people get wrong when stocking up for a hunt?",
	response = "They buy for the argument they just had about a mutant, then forget to check what their weapon takes. Read the markings. Decide what you're carrying before filling the last space in the pack. I've had people return with the wrong ammunition and a long explanation of why it ought to have been obvious. We'd both prefer the short question before they set out.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you like doing business with?",
	response = "Quartermaster reports a shortage plainly, even when we'd both prefer a different total. Ledger keeps the terms available after everyone's memory has improved. Haggler knows what he's doing too; he'll just spend longer explaining why it should cost me more. Arena Master pays attention when I give him something specific. More use than telling him to be sensible in general. He finds that an excellent opening for a joke.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Yes. What's the question?",
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
	statement = "That's all for now.",
	response = "Good journey. Take a moment with your own packing before leaving.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Is checking the count a matter of trust?",
	response = "It's a matter of finding out what arrived. People bring too much as well as too little. A tired stalker can lose track while packing, especially after a day outside. I won't decide what sort of person you are from the difference before we've checked it. Put your total here. If it disagrees with mine, we'll go through it again. You can save the character reference for someone who asked for one.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Would you correct an error in my favour?",
	response = "Yes. I'd like the next transaction to begin with a number instead of both of us wondering what the other noticed. Quicker, and I can eat my lunch without rehearsing an explanation. Quartermaster and I find enough genuine differences to discuss. No need to manufacture another by keeping quiet over a few rounds.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "What do you notice first when a hunting party returns?",
	response = "How they put their things down. A long walk, mutants, perhaps a fright they haven't finished talking about, and somebody still takes a moment with the ammunition. I notice that. I can wait while a person catches their breath. What tries my patience is watching them scatter their belongings because the story needs both hands. Then I'm supposed to remember where every box went while they argue about the shot.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Does Arena Master listen to you?",
	response = "More than he lets on in company. Loves an entertaining account. I prefer a clear one, particularly when it concerns ammunition. But he'll stop talking if you put something in front of him that needs attention. Had a damaged box once; he asked whether the contents had been checked before he asked whose fault it was. Sensible question. I told him so. He looked quite pleased. Briefly tolerable company.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Were you always this tidy?",
	response = "No. Used to put things where they were convenient and trust myself to remember. Spent an evening looking for a pencil I'd tucked behind my ear. Other people were very helpful once they'd stopped laughing. I prefer a designated place now.",
	options = {"BackTopic"},
})
