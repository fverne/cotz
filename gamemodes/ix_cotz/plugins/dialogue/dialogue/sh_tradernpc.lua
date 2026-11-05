DIALOGUE.name = "Haggler"
DIALOGUE.townContact = "haggler"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Let's have a look at your goods.",
	"With pleasure. Find what interests you, then we'll discover how far apart our ideas of its value are."
)

DIALOGUE.addTopic("GREETING", {
	response = "Welcome! Put the pack down if it's dragging your shoulder off. I can wait until you've recovered enough to argue about prices.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"StartBarter",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Why set up a business in the Zone?",
	response = "Because when a stalker needs something here, there's a reason. An empty magazine, a torn bag, an expedition tomorrow. Back home people spend all afternoon deciding whether they want a thing at all. Here they know. Sometimes they also know exactly how little they can afford, which makes the conversation interesting. I enjoy finding the point where we both decide the deal was our idea. Supplies still have to reach me, mind. You won't find the cost of that walk written on the label.",
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Who gives you the hardest time over a deal?",
	response = "Brass counts before I finish speaking. Ledger remembers the wording after I've improved it. Between them they could turn a lively transaction into an examination. Useful men, both. Very little romance in their approach to business. Cleaner says what he'll agree to and waits. You can spend a long afternoon trying to make a waiting man feel hurried. I recommend bringing your own lunch.",
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "Who should I ask for things you don't carry?",
	response = "Lemon for a meal he'll expect you to appreciate, Technut for repairs he'll want to explain, Jitters if you're hurt. Brass handles ammunition over in Garbage. Ask the right question and you'll hear more than a price. Just remember to count the journey when comparing bargains. People will cross mutant country to save a little money and then tell me I'm the unreasonable one.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "Heard any trading stories worth repeating?",
	response = "A man tried to sell me his account of finding an artifact. The artifact had already gone to somebody else. Very vivid account, excellent hand movements, no obvious place to put it on the shelf. I suggested he tell it over supper and ask Lemon for an audience. Apparently I lack imagination. I did listen to the end. Wanted to hear what he thought the missing object was worth.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("StartBarter", {
	statement = "What exchanges are you offering?",
	response = "Take a look at the arrangements. You may discover something you've been carrying has finally become useful.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			local barters = ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Haggler'")

			if #barters <= 0 then
				self.response = "Nothing at the moment."

				net.Start("npcbarter_sync")
				net.SendToServer()
			else
				self.response = "I have the following things up for barter:"

				for _, barter in pairs(barters) do
					local barterTable = ix.npcbarter.barterdict["'Haggler'"][barter]
					self.response = self.response
						.. "\n    "
						.. string.format(
							barterTable.description,
							ix.item.list[barterTable.barterItem[1]].name,
							barterTable.reqItem[2],
							ix.item.list[barterTable.reqItem[1]].name
						)
				end
			end
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		for _, barterid in pairs(ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Haggler'")) do
			local barterstruct = ix.npcbarter.barterdict["'Haggler'"][barterid]

			local barterItem = barterstruct.barterItem
			local barterCnt = barterItem[2] or 1

			-- for _, reqitem in pairs(barterstruct.reqItem) do
			local reqitem = barterstruct.reqItem
			local reqItemCnt = reqitem[2] or 1

			table.insert(dynamicOptions, {
				statement = "I'd like "
					.. barterCnt
					.. "x "
					.. ix.item.list[barterItem[1]].name
					.. " for my "
					.. reqItemCnt
					.. "x "
					.. ix.item.list[reqitem[1]].name,
				topicID = "StartBarter",
				dyndata = { npcname = "'Haggler'", identifier = barterid, reqitem = reqitem[1] },
			})
			-- end
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		if CLIENT then
			ix.npcbarter.TryExecuteBarter(dynamicData.npcname, dynamicData.identifier, dynamicData.reqitem)
		end

		-- Return the next topicID

		return "BackTopic", dynamicData
	end,
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Certainly. We were getting along so well.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"StartBarter",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll look in another time.",
	response = "Do. I enjoy a customer who has time to reconsider.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Does a regular customer get any sympathy?",
	response = "They get remembered. What they're looking for, what they complain about, whether they bring back something they promised. Sympathy is harder to put a price on. I've let a payment wait when I expected the person back. I've also listened to a splendid explanation from a fellow who'd practised it on three other traders. You want me soft-hearted enough to help and sharp enough to have things left when you arrive. A demanding combination.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What makes you expect someone to return?",
	response = "They ask what they owe before explaining what they need next. I like that. And I like customers who keep finding reasons to curse my prices for years. They come in wet, tired, delighted with some scrap from beyond an anomaly field, and we have another argument. There's worse company. Naturally I'd enjoy it even more if they agreed with me sooner.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "What is the strangest thing someone has tried to sell you?",
	response = "A bag he refused to open. Claimed the artifact inside was too valuable to expose. Very serious fellow. Held it as though he expected applause. I offered to buy the bag at the price of a used bag, and he became extremely concerned about my lack of imagination. Perhaps he had a fortune in there. Perhaps he had his lunch. Either way, I enjoyed the conversation more than he did.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Why does Brass annoy you so much?",
	response = "He counts while you're talking. You make an excellent point about the cost of bringing ammunition through mutant country, and he says, 'Forty-seven.' Wonderful. We were approaching an understanding, now we're back at forty-seven. But if he says a box is short, I check it. He's caught mistakes that would have become much more expensive arguments elsewhere. Don't look so surprised. I can find a man useful and still wish he'd finish counting sooner.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Would you buy something you couldn't identify?",
	response = "For the right price, with the uncertainty included. People want me to pay for every possibility they've imagined on the walk back. If I do that, I become the collector and they become the trader. A delightful arrangement for one of us.",
	options = {"BackTopic"},
})
