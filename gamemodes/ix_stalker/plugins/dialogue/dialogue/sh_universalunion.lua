DIALOGUE.name = "Universal Union"

DIALOGUE.addTopic("GREETING", {
	response = "Welcome to the Universal Union!",
	options = {
		"Topic01", 
		"Topic02",
		"GetMoney",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Topic01", {
	statement = "Who are you?",
	response = "Why, I'm the Universal Union!",
	options = {
		"Topic03",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Topic02", {
	statement = "What are you?",
	response = "I'm just testing a lot of text right now, I just need to see what happens if you add this much text and how much it looks like, because you know...sometimes people like to talk A LOT.",
	options = {
		"Topic03",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Topic03", {
	statement = "Let's talk about something else.",
	response = "What would you like to know?",
	options = {
		"Topic01",
		"Topic02",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("GetMoney", {
	statement = "Hey, can I get some money?",
	response = "",
	preCallback = function(self, client, target)
		if (CLIENT) then
			self.response = "Okay "..client:GetName().." here is 50 "..ix.currency.plural.."."
		end
	end,
	postCallback = function(self, client, target)
		if (SERVER) then
			client:GetCharacter():GiveMoney(50)
		end
	end,
	options = {
		"GOODBYE"
	}
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "Goodbye.",
	response = "Going so soon?"
})