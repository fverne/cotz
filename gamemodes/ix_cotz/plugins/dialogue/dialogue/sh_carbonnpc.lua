DIALOGUE.name = "Carbon"
DIALOGUE.townContact = "carbon"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"What can we trade?",
	"Certainly. I'll clear a space; these pages have survived enough accidental marks already."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello. Looking for something, bringing something, or wondering why I've kept this particular pile? There's room to sit.",
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
	statement = "What makes these old records worth keeping?",
	response = "I enjoy finding a little of someone's working day. Repeated requests for a repair, a delivery acknowledged in another hand, a name that turns up where I hadn't expected it. People assume I'm waiting for a folder that explains the whole Zone. Mostly I'm trying to keep enough context that we don't mistake one annoyed remark for a lifetime. You can spend a pleasant hour with a thoroughly ordinary piece of paper.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "What helps you make sense of a recovered document?",
	response = "Where it was found, what was beside it, whether the pages were together when you arrived. Write down what you remember while it's still easy to separate from the journey home. Someone will ask an exciting question about it over supper, and afterwards the find can begin acquiring a story of its own. I like stories. I also like being able to find where this one began.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who helps you put the records in context?",
	response = "Egghead reads a set of figures and begins asking about the result; I may still be wondering who wrote the heading. We both find something worth discussing. The Original will let me ask questions once he's finished objecting to the first one. Boss has records I can't simply walk in and read. I ask for a particular detail where I can. Persistence goes further when the person can understand what might satisfy it.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Of course. I'll leave a marker in that thought.",
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
	statement = "I'll let you get back to the reading.",
	response = "Good journey. A date and a place are welcome if you come across something, but an ordinary account of your day is welcome too.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What can you learn from a maintenance record?",
	response = "Sometimes how long somebody was willing to ask politely. Found three requests for a window latch, followed by 'Fixed it myself' in another hand. I laughed. Then wondered whether the first writer ever learned it had been done. No grand revelation waiting in that question. Just two people whose working days briefly met on a page. I'd like to keep enough of the folder that the next reader can meet them there too.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "How do you treat a story that disagrees with the paperwork?",
	response = "Keep the disagreement visible. The Original can become suspiciously confident when I ask for a date; a document can sound equally confident about something its writer never saw. We can question both without deciding one belongs in the bin. Sometimes we learn where another piece might help. Sometimes we finish the evening still disagreeing. I'm trying to get better at letting that be the end of the evening.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Do you keep stalkers' accounts of mutant encounters?",
	response = "If they're willing to leave them. I like the corrections. 'Two animals' becomes 'possibly three'; a confident direction acquires a question mark. Someone's thought about the evening again. Of course another writer simply adds a larger mutant each time. I keep the versions together when I can. The change interests me. It doesn't tell me which account is right, though people are remarkably keen to have my folders settle an argument.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "What happens when Boss won't let you read a record?",
	response = "I ask what part he can discuss. Sometimes that gets us further; sometimes we spend ten minutes establishing how little he intends to say. I understand that a page can concern people who are still here. I also know a date or a missing heading can change how the rest reads. I try to make a particular request. He finds that more troublesome than a general complaint, which is a small consolation when I leave without the answer.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you ever wish the accounts were more exciting?",
	response = "Rarely. Found a shopping list in a field notebook once. Food, thread, something crossed out so firmly I couldn't read it. The surrounding pages concerned anomalies. I spent far too long wondering what they'd decided they could do without. Eventually I remembered I'd neglected my own shopping. Entirely ordinary discoveries can be rather distracting.",
	options = {"BackTopic"},
})
