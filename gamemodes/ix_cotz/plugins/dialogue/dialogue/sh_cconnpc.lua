DIALOGUE.name = "CCON NPC"

-- Template NPC showcasing all currently implemented features
-- Copy&Paste from this file to build new NPCs

-- Progression can be done by calling this:
-- 				ix.progression.AddProgressionValue(client:GetCharacter(), progressionIdentifier, amountToIncrement)
-- and
--  			ix.progression.GetProgressionValue(client:GetCharacter(), progressionIdentifier)
-- to react to progression levels

DIALOGUE.addTopic("GREETING", {
	response = "What do you want?",
	options = {
		"WishTopic",
		"AboutProgression",
		"InterestTopic",
		"GOODBYE",
	},
	preCallback = function(self, client, target)
		local char = client:GetCharacter()
		if SERVER then
			local wishes = char:GetData("wishes", nil)
			if wishes == nil then
				char:SetData("wishes", {})
			end
		end
	end,
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else.",
	response = "What would you like to know?",
	options = {
		"WishTopic",
		"AboutProgression",
		"InterestTopic",
		"GOODBYE",
	}, -- Should be identical to GREETING's options
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll be back.",
	response = "Take care.",
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "Who are you?",
	response = "Some call me the wishgranter.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			self.response = "..."
		end
	end,
})

DIALOGUE.addTopic("WishTopic", {
	statement = "I want to make a wish.",
	response = "What is your wish?",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	GetDynamicOptions = function(self, client, target)
		return ix.progression.GetWishOptions(client, target)
	end,
	ResolveDynamicOption = function(self, client, target, data)
		return ix.progression.ResolveServiceOffer(client, target, "wish", data)
	end,
})

DIALOGUE.addTopic("ConfirmWish", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, client, target, data)
		ix.progression.ConfirmService(self, client, target, "wish", data)
	end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {
			{ statement = "Go ahead, bless me.", topicID = "ConfirmWish", dyndata = { accepted = true } },
			{ statement = "Actually, wait.", topicID = "ConfirmWish", dyndata = { accepted = false } },
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
			local completed = ix.progression.ExecuteService(client, target, "wish", accepted)
			if accepted and not completed then
				client:Notify("That service could not be completed. Please request a fresh quote.")
			end
		end

		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneyWish", {
	statement = "",
	response = "You do not possess the currency for me to bless you with my wish.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("HasWish", {
	statement = "",
	response = "You have already wished for that.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("HandInComplexProgressionItemTopic", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	options = { "BackTopic" },
	DynamicPreCallback = function(self, player, target, dynamicData)
		ix.dialogue.ProgressionTurnIn(self, player, target, dynamicData)
	end,
})

DIALOGUE.addTopic("ViewProgression", {
	statement = "",
	response = "",
	options = {
		"BackTopic",
	},

	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local identifier = self.tmp
		self.tmp = nil

		return ix.progression.GetDeliveryOptions(client:GetCharacter(), identifier)
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		-- Return the next topicID

		return "HandInComplexProgressionItemTopic", dynamicData
	end,

	IsDynamicFollowup = true,
	DynamicPreCallback = function(self, player, target, dynamicData)
		if dynamicData then
			if CLIENT then
				local definition = ix.progression.definitions[dynamicData.identifier]
				local progressionStatus =
					ix.progression.GetLine(player:GetCharacter(), dynamicData.identifier)

				if definition.requirementSlots then
					progressionStatus = ix.progression.GetComplexProgressionValue(
						player:GetCharacter(),
						dynamicData.identifier
					)
				end

				self.response = ix.progression.DescribeTask(definition,
					target:GetDisplayName(),
					progressionStatus,
					player:GetCharacter()
				)
				self.tmp = dynamicData.identifier
			end
		end
	end,
})

DIALOGUE.addTopic("AboutProgression", {
	statement = "Do you need help with anything?",
	response = "These are your available progression tasks and unclaimed rewards.",
	options = {"BackTopic"},
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local options = {}
		for _, id in ipairs(ix.progression.GetActiveProgressions(client:GetCharacter(), target:GetDisplayName())) do
			options[#options + 1] = {
				statement = ix.progression.definitions[id].name,
				topicID = "AboutProgression",
				dyndata = {identifier = id},
			}
		end

		return options
	end,
	ResolveDynamicOption = function(self, client, target, data)
		return "ViewProgression", data
	end,
})
