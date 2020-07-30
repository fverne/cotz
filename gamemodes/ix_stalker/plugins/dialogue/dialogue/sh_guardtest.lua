DIALOGUE.name = "Guard Test"

DIALOGUE.addTopic("GREETING", {
	response = "Fuck off.",
	options = {
		"InterestTopic", 
		"GOODBYE"
	}
})


DIALOGUE.addTopic("InterestTopic", {
	statement = "Can you tell me something interesting?",
	response = "",
	preCallback = function(self, client, target)
		if (CLIENT) then
			self.response = "You got three seconds before i kick your teeth in, "..client:GetName().."."
		end
	end,
	options = {
		"GOODBYE"
	}
})


DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll be going now.",
	response = "..."
})