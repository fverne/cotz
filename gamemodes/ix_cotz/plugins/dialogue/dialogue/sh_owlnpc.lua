DIALOGUE.name = "Cleaner"
DIALOGUE.townContact = "cleaner"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Yes")

DIALOGUE.addTopic("GREETING", {
	response = "What is it? If you've come to do business, get to the point.",
	options = {
		"SpecialtyTopic",
		"TradeTopic",
		"StartBarter",
		"StorageTopic",
		"BackgroundTopic",
		"InterestTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("StorageTopic", {
	statement = "Do you have room to store my items?",
	response = "Yes.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if
			not ix.progression.IsCompleted(client:GetCharacter(), "cotz/town/cleaner/CL01") and CLIENT
		then
			self.response = "No, not for the moment."
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		return ix.progression.GetStorageOptions(client, target)
	end,
	ResolveDynamicOption = function(self, client, target, data)
		return ix.progression.ResolveServiceOffer(client, target, "storage", data)
	end,
	ShouldAdd = function(self, client, target)
		if ix.progression.IsCompleted(client:GetCharacter(), "cotz/town/cleaner/CL01") then
			return true
		end
	end,
})

DIALOGUE.addTopic("OpenStorage", {
	statement = "",
	response = "Here's your items I've been storing for you.",
	postCallback = function(self, client, target)
		if SERVER then
			local character = client:GetCharacter()
			local id = character:GetData("bankID")
			local bank

			if id then
				local bankstruct = {}
				bankstruct[id] = {
					character:GetData("bankW", ix.config.Get("bankW", 2)),
					character:GetData("bankH", ix.config.Get("bankH", 2)),
				}
				ix.inventory.Restore(
					bankstruct,
					ix.config.Get("bankW", 2),
					ix.config.Get("bankH", 2),
					function(inventory)
						bank = inventory
						bank:SetOwner(character:GetID())
					end
				)
			else
				bank = ix.inventory.Create(ix.config.Get("bankW", 2), ix.config.Get("bankH", 2), os.time())
				bank:SetOwner(character:GetID())
				bank:Sync(client)

				character:SetData("bankID", bank:GetID())
			end

			timer.Simple(0.1, function()
				ix.storage.Open(client, bank, {
					entity = client,
					name = "Personal Storage",
					searchText = "Accessing personal storage...",
					searchTime = ix.config.Get("containerOpenTime", 0),
				})
			end)
		end
	end,
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("ConfirmStorageUpgrade", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, client, target, data)
		ix.progression.ConfirmService(self, client, target, "storage", data)
	end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {
			{
				statement = "Expensive, but alright. Upgrade my stash.",
				topicID = "ConfirmStorageUpgrade",
				dyndata = { accepted = true },
			},
			{
				statement = "Eh, what's with that price? No thanks.",
				topicID = "ConfirmStorageUpgrade",
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
			local completed = ix.progression.ExecuteService(client, target, "storage", accepted)
			if accepted and not completed then
				client:Notify("That service could not be completed. Please request a fresh quote.")
			end
		end

		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneyStorage", {
	statement = "",
	response = ("You lack the funds to upgrade your stash. Return to me " .. "once you get more funds."),
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "How did you get into this business?",
	response = (
		"People needed somewhere to leave things. I had space and knew how to keep my mouth shut. It worked. "
		.. "You're waiting for a more interesting answer. There may be one, but we haven't done any business "
		.. "yet. Tell me what you need stored or moved. I'll tell you what I can do, what it costs, and where "
		.. "my responsibility ends. You can decide whether that suits you before handing anything over."
	),
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "Can you tell me something interesting?",
	response = "Sure. How about you do business with me, or shut the fuck up?",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("StartBarter", {
	statement = "I'd like to do some bartering.",
	response = "Sure.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			local barters = ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Cleaner'")

			if #barters <= 0 then
				self.response = "Nothing at the moment."

				net.Start("npcbarter_sync")
				net.SendToServer()
			else
				self.response = "I have the following things up for barter:"

				for _, barter in pairs(barters) do
					local barterTable = ix.npcbarter.barterdict["'Cleaner'"][barter]
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

		for _, barterid in pairs(ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Cleaner'")) do
			local barterstruct = ix.npcbarter.barterdict["'Cleaner'"][barterid]

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
				dyndata = { npcname = "'Cleaner'", identifier = barterid, reqitem = reqitem[1] },
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
	statement = "Let's talk about something else...",
	response = "Anything else concerning business?",
	options = {
		"SpecialtyTopic",
		"TradeTopic",
		"StartBarter",
		"StorageTopic",
		"BackgroundTopic",
		"InterestTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "All right. We're finished.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "How do I know I can trust you?",
	response = (
		"Start small. Check what comes back. Decide for yourself. Haggler could spend an hour explaining why "
		.. "he's trustworthy; I'd like to finish this conversation before lunch. If something matters to the "
		.. "arrangement, ask. If you're asking because you're curious about someone else's parcel, get used to "
		.. "being disappointed. You'll appreciate that when it's yours."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What if something goes wrong?",
	response = (
		"Tell me early. Where it was, what you saw, what you actually did. Don't tidy up the part that makes "
		.. "you look foolish. I've heard worse, and the story gets less useful every time someone improves it. "
		.. "A bad route I can stop using. An imaginary safe one keeps costing people. That's the answer you "
		.. "came for. Leave the names out unless I need them."
	),
	options = {"BackTopic"},
})
