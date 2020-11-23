DIALOGUE.name = "Task NPC Test"

DIALOGUE.addTopic("GREETING", {
	response = "What's up city slicker?",
	options = {
		"InterestTopic",
		"GetTask",
		"AboutWorkTopic",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
	end
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "Can you tell me something useful?",
	response = "",
	preCallback = function(self, client, target)
		if (CLIENT) then
			self.response = "No."
		end
	end,
	options = {
		"BackTopic"
	}
})

DIALOGUE.addTopic("AboutWorkTopic", {
	statement = "About work...",
	response = "",
	options = {
		"BackTopic"
	},
	preCallback = function(self, client, target)
		if client:ixHasJobFromNPC("identifierthatisdefinedinthenpc") then
			local jobs = client:GetCharacter():GetJobs()
			if (jobs["identifierthatisdefinedinthenpc"].isCompleted) then
				if (SERVER) then client:ixJobComplete("identifierthatisdefinedinthenpc") end
				if (CLIENT) then self.response = "Great work on the job, here's your reward." end
			else
				if (CLIENT) then self.response = string.format("Have you finished %s yet?", ix.jobs.getFormattedName(jobs["identifierthatisdefinedinthenpc"])) end
			end
		else
			if (CLIENT) then self.response = "You're not working for me right now." end
		end

	end,
} )

DIALOGUE.addTopic("GetTask", {
	statement = "Do you have any work for me?",
	response = "Yes, have a look.",
	options = {
		"BackTopic"
	},
	preCallback = function(self, client, target)
		if client:ixHasJobFromNPC("identifierthatisdefinedinthenpc") and CLIENT then
			self.response = "I already gave you some work."
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynopts = {
			{statement = "Sneed test task", topicID = "GetTask", dyndata = {identifier = "TestJob"}},
		}

		if client:ixHasJobFromNPC("identifierthatisdefinedinthenpc") then
			dynopts = {}
		end
		
		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		if( SERVER ) then
			client:Notify("You have accepted task with identifeir: "..(dyndata.identifier or "INVALID OPTION"))
			client:ixJobAdd(dyndata.identifier, "identifierthatisdefinedinthenpc")
		end
		-- Return the next topicID
		return "BackTopic"
	end,
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about another topic.",
	response = "All right.",
	options = {
		"InterestTopic",
		"GetTask",
		"AboutWorkTopic",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you!",
	response = "Come back soon, STALKER..."
})