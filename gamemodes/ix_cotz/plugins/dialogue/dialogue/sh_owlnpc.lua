DIALOGUE.name = "Cleaner"
DIALOGUE.townContact = "cleaner"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Yes")

DIALOGUE.addTopic("GREETING", {
	response = "What is it?",
	options = {
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
	statement = "Tell me about yourself.",
	response = (
		"Not a whole lot to know. I came here a few months ago, "
		.. "after the military presence ramped up their presence around "
		.. "here - turns out the swamps are the only place they haven't "
		.. "really cut off around the perimeter of the zone, which "
		.. "means that this is where we stay for now. I worked as a "
		.. "trader back in the days, so thought I might as well put "
		.. "my skills to use here too. Oh, and I have a bunch of friends "
		.. "who can get things. And remove things, like you, if you "
		.. "keep asking."
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
	response = "All right.",
	options = {
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
	response = "Come back soon, STALKER...",
})
