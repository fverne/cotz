DIALOGUE.name = "Community NPC"

-- Template NPC showcasing all currently implemented features
-- Copy&Paste from this file to build new NPCs

-- Progression can be done by calling this:
-- 				ix.progression.AddProgressionValue(client:GetCharacter(), progressionIdentifier, amountToIncrement)
-- and
--  			ix.progression.GetProgressionValue(client:GetCharacter(), progressionIdentifier)
-- to react to progression levels

DIALOGUE.addTopic("GREETING", {
	response = "Me love cheese!",
	options = {
		"TradeTopic",
		"AboutProgression",
		"GOODBYE",
	},
	preCallback = function(self, client, target)
		-- Only needed if NPC offers tasks
		-- 4th argument is the categories to grab tasks from
		-- 5th argument is the amount of tasks to grab
		-- netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"mutantkillgroupeasy"},
		-- 4)

		-- alternative npc task giving by difficulty
		-- if (SERVER) then
		-- 	if target:GetNetVar("possibleJobs") == nil then
		-- 		local possibleJobs = {}
		-- 		possibleJobs["easy"] = {"item_part_NPC_easy"}
		-- 		possibleJobs["medium"] = {"item_part_NPC_medium"}
		-- 		possibleJobs["hard"] = {"item_part_NPC_hard"}

		-- 		target:SetNetVar("possibleJobs", possibleJobs)
		-- 	end
		-- end
	end,
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else.",
	response = "Yes yes!",
	options = {
		"TradeTopic",
		"AboutProgression",
		"GOODBYE",
	}, -- Should be identical to GREETING's options
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "** You take your leave **",
	response = "You come back soon!",
})

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "Oooooooo, shinyyyyyyy!",
	postCallback = function(self, client, target)
		if SERVER then
			local character = client:GetCharacter()

			target.receivers[#target.receivers + 1] = client

			local items = {}

			-- Only send what is needed.
			for k, v in pairs(ix.vendorStock.GetItems(character, target)) do
				if
					not table.IsEmpty(v)
					and (CAMI.PlayerHasAccess(client, "Helix - Manage Vendors", nil) or v[VENDOR_MODE])
				then
					if ix.progression.CanBuyItem(character, target:GetDisplayName(), k) then
						items[k] = v
					end
				end
			end

			target.scale = target.scale or 0.5

			client.ixVendorAdv = target
			client.ixVendorAdvEditing = nil

			-- force sync to prevent outdated inventories while buying/selling
			if character then
				character:GetInventory():Sync(client, true)
			end

			net.Start("ixVendorAdvOpen")
			net.WriteEntity(target)
			net.WriteUInt(target.money or 0, 16)
			net.WriteTable(items)
			net.WriteFloat(target.scale or 0.5)
			net.Send(client)

			ix.log.Add(client, "vendorUse", target:GetDisplayName())
		end
	end,
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("StartBarter", {
	statement = "** Read the list of barters **",
	response = "",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			local barters = ix.npcbarter.GetActiveBartersForNPC(client:GetCharacter(), "'Spicy Lemon'")

			if #barters <= 0 then
				self.response = "** The list is empty. **"

				net.Start("npcbarter_sync")
				net.SendToServer()
			else
				self.response = "** The list reads as follows: **"

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
