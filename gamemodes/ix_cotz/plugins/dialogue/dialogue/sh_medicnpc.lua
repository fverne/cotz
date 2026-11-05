DIALOGUE.name = "Jitters"
DIALOGUE.townContact = "jitters"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Can I look at your medical supplies?",
	"Of course. Tell me if you need treatment as well; I can put the trading aside."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello. Come through. Is something wrong, or have you come in before letting it get that far? Either's welcome.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"HealTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Yes? You can sit while we talk.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"HealTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	}, -- Should be identical to GREETING's options
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll leave you to it.",
	response = "Take care. And if you see Lemon, I haven't forgotten the food. I'm going now. Shortly.",
})

DIALOGUE.addTopic("HealTopic", {
	statement = "Can you treat me?",
	response = "Tell me what needs attention. We'll look at the treatment and its cost before you agree.",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	GetDynamicOptions = function(self, client, target)
		return ix.progression.GetTreatmentOptions(client, target)
	end,
	ResolveDynamicOption = function(self, client, target, data)
		return ix.progression.ResolveServiceOffer(client, target, "treatment", data)
	end,
})

DIALOGUE.addTopic("ConfirmHeal", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, client, target, data)
		ix.progression.ConfirmService(self, client, target, "treatment", data)
	end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {
			{
				statement = "I can agree to that. Go ahead and heal me.",
				topicID = "ConfirmHeal",
				dyndata = { accepted = true },
			},
			{
				statement = "On second thought...",
				topicID = "ConfirmHeal",
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
			local completed = ix.progression.ExecuteService(client, target, "treatment", accepted)
			if accepted and not completed then
				client:Notify("That service could not be completed. Please request a fresh quote.")
			end
		end

		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneyHeal", {
	statement = "",
	response = "You haven't enough for that treatment. We can leave the purchase there.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Is it easier when you have a patient to concentrate on?",
	response = "Usually. Someone tells me where it hurts and the next question has a purpose. Between patients I can wonder about everyone who's still outside. Then someone returns from a mutant hunt and spends ten minutes describing a broken boot, and I discover I'm quite happy hearing about the boot. A little warning before they show me an injury would be welcome, though. People can be wonderfully casual about what they lead a conversation with.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Is talking to visitors a bother?",
	response = "Not if they let me know what they've come for. If you want supplies, ask. If you'd like company, that's all right too. Gasket sometimes complains through half a repair while I'm sorting things. I don't need to fix the problem he's describing. Rather pleasant, that. I can listen and have an opinion about something that won't require another dressing.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Do people talk much while you treat them?",
	response = "Quite a lot once they're sitting still. I hear about artifact finds, awful sleeping places, what somebody thought was a mutant and later decided was a sack. I like the little details. Where they ate, who snored. It gives me something to ask about besides pain. No, I won't tell you whose sack it was. He was embarrassed enough, and I was rather grateful for a story in which nothing needed stitching.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Would you ever go and watch the arena?",
	response = "Arena Master keeps asking. Says I might enjoy seeing what happens before people arrive here. I've explained that I can usually form an adequate picture. Still, he can make a room pleasant when he wants to. If he'd talk about the spectators for a while instead of the fights, we might get through a conversation without me looking at his hands to see which one's swollen.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you ever tell them about your own day?",
	response = "Sometimes. Once I complained that Lemon had put my supper aside and then scolded me for letting it go cold. The fellow in the chair was laughing while I finished his dressing. I managed to eat afterwards. That was a fairly good evening, actually.",
	options = {"BackTopic"},
})
