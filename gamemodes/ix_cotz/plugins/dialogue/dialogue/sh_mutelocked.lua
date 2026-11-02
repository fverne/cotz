DIALOGUE.name = "Mute"

DIALOGUE.addTopic("GREETING", {
	response = "** He glances up, shakes his head, and returns to the equipment on his table. **",
	options = {"Introduction", "GOODBYE"},
})

DIALOGUE.addTopic("Introduction", {
	statement = "Do I need someone to vouch for me?",
	response = "** He nods once, then turns back to his work. **",
	options = {"GOODBYE"},
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll come back later.",
	response = "** He gives a small nod without looking up. **",
})
