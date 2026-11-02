DIALOGUE.name = "Boss"
DIALOGUE.townContact = "boss"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Sure.")

DIALOGUE.addTopic("GREETING", {
	response = "Look what the cat dragged in. What brings you to my part of the operation?",
	options = {
		"SpecialtyTopic",
		"TradeTopic",
		"RepairItems",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("RepairItems", {
	statement = "Can you fix my items?",
	response = "What would you like me to look at?",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	-- ShouldAdd = function(self, client, target) return ix.GetProgression("funy") end,
	GetDynamicOptions = function(self, client, target)
		return ix.progression.GetRepairOptions(client, target)
	end,
	ResolveDynamicOption = function(self, client, target, data)
		return ix.progression.ResolveServiceOffer(client, target, "repair", data)
	end,
})

DIALOGUE.addTopic("ConfirmRepair", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, client, target, data)
		ix.progression.ConfirmService(self, client, target, "repair", data)
	end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {
			{
				statement = "That's fine, fix it.",
				topicID = "ConfirmRepair",
				dyndata = { accepted = true },
			},
			{
				statement = "On second thought...",
				topicID = "ConfirmRepair",
				dyndata = { accepted = false },
			},
		}

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, data)
		if SERVER then
			local accepted = type(data) == "table" and data.accepted == true
			local completed = ix.progression.ExecuteService(client, target, "repair", accepted)
			if accepted and not completed then
				client:Notify("That service could not be completed. Please request a fresh quote.")
			end
		end

		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneyRepair", {
	statement = "",
	response = "You don't have enough money to repair that.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "What is your group doing here?",
	response = (
		"Research and the work necessary to keep it going. International group, local problems. You can see "
		.. "how easily an operation acquires more of the latter. I won't discuss everything with someone who "
		.. "has walked through the door. If you want work, you'll get an assignment, the terms, and the risks I "
		.. "can establish. Ask about anything you need to understand before accepting. My patience for "
		.. "questions is considerably better here than after someone has gone out with the wrong idea."
	),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "What would you need from me?",
	response = (
		"Reliable work and an accurate account afterwards. I can pay for a particular assignment without "
		.. "inviting you into every discussion behind it. If we continue working together, you'll have more "
		.. "evidence on which to judge us. That applies in both directions."
	),
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about another topic.",
	response = "What else did you want to discuss?",
	options = {
		"SpecialtyTopic",
		"TradeTopic",
		"RepairItems",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll talk to you later.",
	response = "Understood. Prepare before you leave.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "How can I work without the full picture?",
	response = (
		"Tell me which missing detail affects your decision. I may have an answer, or I may have to tell you "
		.. "that we don't know. Secrecy is useful until it leaves the person carrying out an order guessing at "
		.. "its purpose. I don't intend to explain the entire operation to settle every assignment. I do intend "
		.. "you to understand what you're agreeing to. If the uncertainty is unacceptable, refuse before "
		.. "leaving."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Can I question an assignment?",
	response = (
		"Yes. Bring me a practical objection and we'll discuss it. Wake asks questions I would sometimes "
		.. "rather leave until later. She has good reasons for refusing to wait. Doesn't mean every file "
		.. "becomes hers to read. It means I have to decide what she needs instead of using 'restricted' to "
		.. "finish a difficult conversation. You can expect the same consideration. It may not produce the "
		.. "answer you want."
	),
	options = {"BackTopic"},
})
