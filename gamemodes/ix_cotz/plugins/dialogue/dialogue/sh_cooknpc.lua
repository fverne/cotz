DIALOGUE.name = "Spicy Lemon"
DIALOGUE.townContact = "spicy-lemon"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Let me see what you're selling.",
	"Now you're asking a useful question. Have a look; perhaps you'll find something worth sitting down for."
)

DIALOGUE.addTopic("GREETING", {
	response = "Come in, then. Hungry, trading, or planning to stand there smelling the food until I ask?",
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
	statement = "How did you and Old Timer meet?",
	response = "Eighties. A shelter kitchen, more hungry people than anyone knew what to do with. I volunteered to cook. Look as surprised as you like; I was useful before I became expensive. He had his own troubles. We stayed in touch, which is how I had somebody to ask when the stories about artifacts started reaching me. Somebody who might have seen one, rather than somebody who knew a man who knew a man. He still ate terribly. Some things survive a change of country.",
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "What were you leaving behind?",
	response = "A wife who'd heard quite enough of my explanations. A job, people expecting me home, all sorts of small arrangements I found inconvenient when they applied to me. Naturally I considered myself misunderstood. I can hear what you're preparing to say. Save it. She was better at that conversation and had considerably more evidence.",
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "Was coming here the fresh start you expected?",
	response = "I expected artifacts and money. Had some notion I could connect the people finding one with the people spending the other. Turned out I understood hungry stalkers better than strange objects dug out of an anomaly field. I could cook something they'd come back for. There's money in that, and I like being good at it. Don't give me the look people get when they're about to call it a calling.",
	options = {
		"BackgroundTopic4",
	},
})

DIALOGUE.addTopic("BackgroundTopic4", {
	statement = "Let's talk about the kitchen.",
	response = "Excellent. At last, a subject on which my judgement deserves respect.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "What makes a meal worth cooking for you?",
	response = "Someone stops talking halfway through the first mouthful. That's good. Gives me a moment before they begin explaining how somebody at home would have done it. I like people sitting long enough to taste what I've made. If they've spent all day watching for mutants, they can spend ten minutes watching their bowl instead. Preferably without putting it on their knee and announcing they're in a hurry.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("StartBarter", {
	statement = "What can I exchange for supplies?",
	response = "Show me what you're offering. Admiring the cooking won't cover the difference.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			local barters = ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Spicy Lemon'")

			if #barters <= 0 then
				self.response = "Nothing at the moment."

				net.Start("npcbarter_sync")
				net.SendToServer()
			else
				self.response = "I have the following things up for barter:"

				for _, barter in pairs(barters) do
					local barterTable = ix.npcbarter.barterdict["'Spicy Lemon'"][barter]
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

		for _, barterid in pairs(ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Spicy Lemon'")) do
			local barterstruct = ix.npcbarter.barterdict["'Spicy Lemon'"][barterid]

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
				dyndata = { npcname = "'Spicy Lemon'", identifier = barterid, reqitem = reqitem[1] },
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
	response = "Go on. I can listen while I work.",
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
	statement = "I'll leave you to the cooking.",
	response = "See you. If someone asks what smelled good, you know whose name to give them.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Do you like feeding the whole camp?",
	response = "Depends which part of the camp has just asked for something. The fellow wanting more because he liked it, fine. The one explaining his expedition makes him too important to wait, less fine. I know who's likely to turn up late, who needs a softer piece, who'll pretend they aren't hungry. It gets into the cooking whether you intend it or not. I can care how somebody eats and still expect to be paid.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What about Old Timer and Jitters?",
	response = "Those two can find a reason to miss any meal. Hunting, a patient, some necessary thing that apparently prevents a man from lifting a spoon. I put theirs aside, then they complain I'm fussing. Next time I'll let it go cold. Yes, I said that last time. You're remarkably well informed for someone who isn't helping with the washing-up.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Do artifact hunters make good customers?",
	response = "They arrive convinced they've become wealthy, order like kings, then sit watching their bag instead of eating. One wanted me to admire his find halfway through serving. I told him Egghead was the one to impress with a strange lump; I had something cooling that I'd actually made myself. He laughed. Ate properly after that. Bought another helping, too. A little respect for the cook can be very good for the appetite.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "What do you and Spoor disagree about?",
	response = "Which part of his day's work is the important part. He'll describe a mutant's last meal in considerable detail while mine waits to be prepared. I understand wanting a specimen intact. I also understand having people outside asking when they can eat. Sometimes he helps carry things in and stays to explain where he found them. That's better. I can work while he talks, and he eventually remembers to ask what's for supper.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you trust what he brings you?",
	response = "I trust him to tell me what he knows. Then I decide what goes near the kitchen. He's allowed to find something fascinating; I'm allowed to want it off my table. We've had that conversation at a volume the whole camp found educational.",
	options = {"BackTopic"},
})
