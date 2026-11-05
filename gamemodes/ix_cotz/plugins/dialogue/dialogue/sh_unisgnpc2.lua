DIALOGUE.name = "Boss"
DIALOGUE.townContact = "boss"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"What equipment can we trade?",
	"Have a look at what's available. We can discuss the exchange without turning it into an operational briefing."
)

DIALOGUE.addTopic("GREETING", {
	response = "Come in. A practical matter, or a question you've been saving up? Let's hear it.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
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
	statement = "Can you arrange repairs for my equipment?",
	response = "Choose what needs attention. Review the repair and its cost before confirming.",
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
	response = "You don't have enough for that repair. Leave the purchase there.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "What is your group doing in the Zone?",
	response = "Research, and the work required to keep it going. International group, local difficulties. Equipment still has to arrive, people still have to agree on what they're being asked to do. I won't discuss the whole operation with a visitor. If a particular question affects whether you'd accept an assignment, ask it here. I'd rather explain a relevant uncertainty now than hear what somebody assumed after returning.",
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "What do you expect from someone you hire?",
	response = "An accurate account of what they've done, including the part that didn't go as intended. I can pay for a defined piece of work without offering access to every discussion behind it. Judge that arrangement on the terms. If we continue dealing with each other, we'll both have more to judge than an introduction. You don't have to make a declaration of loyalty to ask a useful question.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Go ahead.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
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
	statement = "I'll leave you to the operation.",
	response = "Understood. Make your preparations before somebody else's urgency starts making them for you.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "How much should a contractor be told?",
	response = "Enough to make an informed decision about the assignment. Tell me which missing detail matters. Sometimes I can explain it; sometimes the uncertainty is ours as well. I won't manufacture confidence to make a briefing more comfortable. Nor will I open the whole operation to settle a narrow question. You can decide the arrangement doesn't suit you. That conversation belongs here, before departure.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Can a contractor challenge your judgement?",
	response = "Bring a practical objection. Wake does, and seldom at a time I'd have chosen. I have to consider what she needs to know instead of treating a restriction as the end of the discussion. Some of the answer may still be restricted. You can expect me to distinguish that from a question I haven't bothered to consider. Don't assume being heard guarantees the decision you wanted.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Do you ever sit with the others between expeditions?",
	response = "Occasionally. Last time, someone was describing a snork encounter in enough detail to make the meal last another hour. I asked a question. The story became an account of every decision they'd made since departure. I had wanted to know how they'd lost the cooking pot. Apparently I should announce when I'm only listening. Until then I find people easier company when somebody else has already started an argument.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Does Smartass ever stop performing?",
	response = "Give him a fault he can't explain immediately. He'll forget the remark he was preparing and ask you three useful questions. I enjoy that interval. Then he solves enough of it to recover his audience and we hear why the original design offended him. He earns some of the latitude he takes. You shouldn't mistake that for an invitation to repeat everything he says in my hearing.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Did they ever explain what happened to the pot?",
	response = "Yes. It had been left where they'd stopped to repack. No mutant involved, however much of the story was given over to one. I let them finish eating before asking the question again. Made the answer considerably shorter.",
	options = {"BackTopic"},
})
