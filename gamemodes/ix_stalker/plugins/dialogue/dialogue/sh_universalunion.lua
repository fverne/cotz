DIALOGUE.name = "Universal Union"

DIALOGUE.addTopic("GREETING", {
	response = "Welcome to the zone!",
	options = {
		"Topic01", 
		"Topic02",
		"Topic03",
		"GetItems",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Topic01", {
	statement = "Who are you?",
	response = "I'm Sidorovich, I run the place. I can make sure you get a good start here, or I can rat you out to the military. Just stay cool with me, and I'll stay cool with you, got that?",
	options = {
		"Return",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Topic02", {
	statement = "wasap negr",
	response = "Nice reference, you retard.",
	options = {
		"Return",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Topic03", {
	statement = "Why is Helix such a nice framework?",
	response = "It's pretty neat, yeah.",
	options = {
		"Return",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("GetItems", {
	statement = "Can you give me something for free?",
	response = "That depends buddy.",
	options = {
		"GetMoney",
		"GetStarterKit",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Return", {
	statement = "Let's talk about something else.",
	response = "What would you like to know?",
	options = {
		"Topic01",
		"Topic02",
		"Topic03",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("GetStarterKit", {
	statement = "Hey, can I get a starterkit from you?",
	response = "",
	preCallback = function(self, client, target)
		if (CLIENT) then
			self.response = "Okay "..client:GetName().." here is a starter kit. It contains a bit of money, a TT-33, and a bit of ammo. I won't give you any more of these. Don't go die somewhere, I expect this to be an investment."
		end
	end,
	postCallback = function(self, client, target)
		if (SERVER) then
			client:GetCharacter():GetInventory():Add("kit_newchar")
		end
	end,
	options = {
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
	response = "Take care, STALKER..."
})