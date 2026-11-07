DIALOGUE.name = "Technut"
DIALOGUE.townContact = "technut"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Let's see what you have for trade.",
	"Certainly, buddy. Give me a moment to put the unfinished bits out of your way."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello, buddy! Mind that loose lead. I know precisely where it belongs; the rest of the bench is still under discussion. What have you brought?",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"RepairItems",
		"CustomizeGear",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("CustomizeGear", {
	statement = "Can you change the finish on my gear or suit?",
	quickAction = true,
	response = "Yes! Keep it equipped and we'll look at the finishes available. You can decide before anything's changed.",
	options = {"BackTopic"},
	preCallback = function(self, client, target)
		local customization = ix.plugin.Get("gearcustomization")
		if SERVER and customization then customization:Open(client, target) end
	end,
	ShouldAdd = function()
		return ix.plugin.Get("gearcustomization") ~= nil and ix.pac ~= nil
	end,
})

DIALOGUE.addTopic("RepairItems", {
	statement = "Can you repair my equipment or clean my weapons?",
	response = "Let's have a look. Tell me what needs attention; I'll show you the work and the price.",
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
	response = "You're short for that repair, buddy. Leave that one for now.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "What did you do before you opened the workshop?",
	response = "Army work. Left in 2007, after we were cut off. Deserted. I can say the word; it doesn't explain the whole day. I wanted out and found a way. Here someone puts a broken thing on the bench and I get to make myself useful with my hands. I like the questions a repair gives me. What moved, what wore through, why the owner kept pushing that button. Easier questions to keep company with.",
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Do people here know about that?",
	response = "Some. If they ask, I tell them. Then Gasket arrives wanting the parts I borrowed, and we return to an argument I can actually finish. Well, finish my side of. He'd like to see the assembled result before considering the subject closed. Fair enough. I've promised him rather a lot of assembled results.",
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "We can talk about the workshop instead.",
	response = "Gladly. There's something on practically every inch of it I'd enjoy discussing.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Go on. If I keep turning this over, I'm still listening.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"RepairItems",
		"CustomizeGear",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll let you get back to the bench.",
	response = "See you, buddy. If you remember what it was doing before it failed, come and tell me. Those details keep me entertained.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "How do you decide an improvement is finished?",
	response = "The sensible answer involves the owner needing the thing back. I can go on finding another adjustment indefinitely. Something comes back from an anomaly field held together with wire, and immediately I want to understand every turn of the wire. Its owner would like a repair and some supper. Gasket is excellent at reminding me which of us is waiting. Sometimes a little forcefully, considering how interesting the problem has become.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What is the best part of repairing something?",
	response = "When they stop watching my hands. They've been leaning over the bench certain it's finished for good, then it works and they start telling me about the trip instead. I could do with another moment of admiration. But I like hearing the journey once the broken thing has stopped being the most important part of it. Usually there's a detail that explains the fault, too.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Do you keep anything people bring back from anomaly fields?",
	response = "Broken fasteners, usually. Everyone else wants to see the artifact. I want the clasp the owner has held together with wire for three days. There's a decision in that repair! What they had, what they tried, which bit they were prepared to sacrifice. Sometimes I ask and get the whole expedition instead. Fine by me, buddy. Sit down. Although tell me before I take the wire off if it's the only thing keeping the rest together.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "What happens when you visit Mute's bench?",
	response = "Depends how close my hands get. He's got a way of putting a tray down that ends a suggestion before I've finished making it. Very economical. I once spent a whole visit describing an arrangement he'd already tried. He let me reach the exciting part, then produced the rejected piece. Kept it labelled, too. I admired that. Would've admired it more if he'd shown me five minutes earlier.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you leave his equipment alone?",
	response = "When he asks. Well, when he makes it sufficiently clear. Usually by moving it away. I like seeing work done differently, even if the owner won't allow a perfectly reasonable experiment. You should see how clean he leaves the bench. Almost discourages thought.",
	options = {"BackTopic"},
})
