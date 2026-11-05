DIALOGUE.name = "Ledger"
DIALOGUE.townContact = "ledger"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"What supplies are available for exchange?",
	"Have a look. We can keep this exchange separate from the outstanding deliveries."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello. Parcel, receipt, or a conversation? Let me put a marker here so the unfinished business can wait its turn.",
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
	statement = "What do you enjoy about dispatching freight?",
	response = "Finishing an arrangement so the people at both ends can stop waiting. A parcel reaches somebody who needs it, the sender knows, and we can close that page. I remember the incomplete ones more clearly, unfortunately. A late delivery leaves several conversations behind it. Some are very entertaining. I'd still prefer an unremarkable arrival with a receipt I can read. Leaves more of the afternoon for something I've chosen to remember.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "What should I establish before taking a parcel?",
	response = "Who expects it, where it goes, and what you've actually agreed to carry. Get the destination clear before collecting. After an emission or a difficult walk people are very good at recalling what they meant instead of what was said. Write it down while you can still ask the sender. You'll both be happier arguing over an actual sentence than two improved memories.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who do you depend on to keep deliveries moving?",
	response = "Ballast tells me about the load before it becomes somebody else's predicament. Cleaner gives a clear answer, sometimes to a question I was only being polite in asking. Spool can help establish who last spoke to somebody; I try not to make every conversation with him an enquiry. Haggler requires careful wording and often rewards it with an entertaining objection. I can enjoy the objection once we've found the original terms.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Of course. What would you like to ask?",
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
	statement = "I'll leave you to the records.",
	response = "Good journey. I hope you arrive with time to sit down before someone asks about the return trip.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Do you remember the people or the parcels?",
	response = "Usually the people. A parcel is easier to distinguish after somebody has explained its absence three different ways. One fellow insisted we'd never met. Same coat, same request to leave the paperwork until later. I didn't particularly want to embarrass him. I wanted to finish an arrangement another person was still waiting on. If he'd brought the receipt, I might have forgotten the coat by now.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "How do you handle conflicting accounts?",
	response = "Keep both and ask what each person saw. Changed plans and misunderstood names produce quite enough difficulty without anyone intending harm. I like finding that kind of explanation. Haggler sometimes offers a more interesting one before I've finished the question. We can admire it afterwards. Having the agreement written down lets everyone return to the original problem once the performance is over.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Does an emission leave you with a lot of complaints?",
	response = "Generally before I've finished finding somewhere dry for the paperwork. People have been waiting, frightened, inconvenienced; they want something settled. Understandable. One courier came back after a delay and asked whether I'd had time to eat. I remember that more clearly than the explanation for the parcel. We both sat down. There was still an argument about the receipt afterwards, but it was a much more civil argument.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "How do you get along with Cleaner?",
	response = "Very efficiently, until I say something merely polite. He waits to discover what further condition I'm introducing. Sometimes I am only wishing him a good afternoon. We have learned to allow for that difference. If he says a matter is dealt with, I don't usually need another explanation. I appreciate a conversation that finishes when its business does. I also appreciate a farewell. Apparently those remain separate negotiations.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you ever manage to stop thinking about deliveries?",
	response = "For a while. Ballast can describe a stretch of water without introducing a single parcel. Then he'll mention something somebody left on the bank and I'm mentally looking for a space in tomorrow's list. I try to let him finish before I spoil the evening.",
	options = {"BackTopic"},
})
