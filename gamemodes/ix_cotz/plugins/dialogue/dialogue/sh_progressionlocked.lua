DIALOGUE.name = "Unfamiliar contact"

DIALOGUE.addTopic("GREETING", {
	response = ("I don't know you well enough to do business. Get an introduction, " .. "then we'll talk."),
	options = { "Introduction", "GOODBYE" },
})

DIALOGUE.addTopic("Introduction", {
	statement = "Who should I speak to?",
	response = "Help the people who sent you here. Once they can vouch for you, come back.",
	options = { "GOODBYE" },
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll come back later.",
	response = "Stay safe out there.",
})
