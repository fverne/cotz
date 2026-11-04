DIALOGUE.name = "Latch"
DIALOGUE.townContact = "latch"

ix.dialogue.AddTradeTopic(DIALOGUE, "What do you have for sale?", "Show me the condition first.")

DIALOGUE.addTopic("GREETING", {
	response = "Got something to show me? Put it down where I can see the part that actually does the work.",
	options = {
		"SpecialtyTopic",
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
	statement = "What sort of work did you do before?",
	response = (
		"Industrial work. Keeping machinery useful after somebody decided maintenance could wait another "
		.. "month. Usually a team job, though the fellow writing the report sometimes forgot that part. I miss "
		.. "having someone at the other end of a bench who knows what I'm about to ask for. Here I spend more "
		.. "time explaining why a part is worth carrying. Don't mind explaining if a person listens. I mind "
		.. "watching them throw it into a sack while I'm explaining why they shouldn't."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "Any advice before I head out?",
	response = (
		"Check a part before hauling it home. A heavy broken thing is still a broken thing when you've "
		.. "carried it twice as far."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you know around here?",
	response = (
		"Technut knows what he wants, down to the last screw. Gasket needs practical spares. Suture can "
		.. "usually find a use for the good straps."
	),
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "What else did you want to discuss?",
	options = {
		"SpecialtyTopic",
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
	statement = "See you around.",
	response = "Mind how you pack the useful bits.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Can you teach me what to look for?",
	response = (
		"Pick it up. Show me where you think it's worn. No, look at the part while you answer. Being wrong "
		.. "here costs us a minute; better than carrying twenty kilos back because you were embarrassed to ask. "
		.. "There. That surface needs to meet another one. Follow it round. We'll work out what you're seeing "
		.. "before we decide whether the rust matters. You don't have to know the proper name yet."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Would Technut make the same choice?",
	response = (
		"He'd agree it's useful, then explain three other things it could do. I'd like the first job "
		.. "finished. Still, when I can't identify something, I'll ask him. He enjoys the puzzle enough to keep "
		.. "looking after I've become annoyed with it. Suture's similar about material. Get them discussing a "
		.. "fault and you can learn a fair bit, provided you're willing to wait for a gap."
	),
	options = {"BackTopic"},
})
