DIALOGUE.name = "Community NPC"

-- Template NPC showcasing all currently implemented features
-- Copy&Paste from this file to build new NPCs

-- Progression can be done by calling this:
-- 				ix.progression.AddProgessionValue(progressionIdentifier, amountToIncrement, client:Name())
-- and
--  			ix.progression.GetProgressionValue(progressionIdentifier)
-- to react to progression levels

DIALOGUE.addTopic("GREETING", {
	response = "** Silence **",
	options = {
		"TradeSherpaTopic", 
		-- "HealTopic",
		-- "JoinArena",
		-- "TutorialTopic",
		-- "InterestTopic",
		-- "ChangeSuitVariant",
		-- "AboutWorkTopic",
		-- "GetTaskByDifficulty",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		-- Only needed if NPC offers tasks
		-- 4th argument is the categories to grab tasks from
		-- 5th argument is the amount of tasks to grab
		-- netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"mutantkillgroupeasy"}, 4)

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
	end
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else.",
	response = "What would you like to know?",
	options = {
		"TradeSherpaTopic", 
		-- "HealTopic",
		-- "JoinArena",
		-- "TutorialTopic",
		-- "InterestTopic",
		-- "ChangeSuitVariant",
		-- "AboutWorkTopic",
		-- "GetTaskByDifficulty",
		"GOODBYE"
	} --Should be identical to GREETING's options
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "** You take your leave **",
	response = "** Silence **"
})

----------------------------------------------------------------
----------------------START-TRADER-START------------------------
----------------------------------------------------------------

DIALOGUE.addTopic("TradeSherpaTopic", {
	statement = "Want to trade?",
	response = "No.",
	postCallback = function(self, client, target)
		if (SERVER) then
			local character = client:GetCharacter()

			target.receivers[#target.receivers + 1] = client

			local items = {}
			-- Only send what is needed.
			for k, v in pairs(target.items) do
				if (!table.IsEmpty(v) and (CAMI.PlayerHasAccess(client, "Helix - Manage Vendors", nil) or v[VENDOR_MODE])) then
					items[k] = v
				end
			end

			target.scale = target.scale or 0.5

			client.ixVendorAdv = target

			-- force sync to prevent outdated inventories while buying/selling
			if (character) then
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
	}
})

----------------------------------------------------------------
------------------------END-TRADER-END--------------------------
----------------------------------------------------------------

DIALOGUE.addTopic("StartBarter", {
	statement = "** Read the list of barters **",
	response = "",
	options = {
		"BackTopic"
	},
	preCallback = function(self, client, target)
		if( CLIENT ) then
			local barters = ix.npcbarter.GetActiveBartersForNPC("'Spicy Lemon'")

			if #barters <= 0 then
				self.response = "** The list is empty. **"

				net.Start("npcbarter_sync")
				net.SendToServer()
			else
				self.response = "** The list reads as follows: **"

				for _, barter in pairs(barters) do
					local barterTable = ix.npcbarter.barterdict["'Spicy Lemon'"][barter]
					self.response = self.response.."\n    "..string.format(barterTable.description, ix.item.list[barterTable.barterItem[1]].name, barterTable.reqItem[2], ix.item.list[barterTable.reqItem[1]].name)
				end
			end

		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}

		for _, barterid in pairs(ix.npcbarter.GetActiveBartersForNPC("'Spicy Lemon'")) do
			local barterstruct = ix.npcbarter.barterdict["'Spicy Lemon'"][barterid]

			local barterItem = barterstruct.barterItem
			local barterCnt = barterItem[2] or 1

			-- for _, reqitem in pairs(barterstruct.reqItem) do
				local reqitem = barterstruct.reqItem
				local reqItemCnt = reqitem[2] or 1

				table.insert(dynopts, {statement = "I'd like "..barterCnt.."x "..ix.item.list[barterItem[1]].name.." for my "..reqItemCnt.."x "..ix.item.list[reqitem[1]].name, topicID = "StartBarter", dyndata = {npcname = "'Spicy Lemon'", identifier = barterid, reqitem = reqitem[1]}})
			-- end
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)

		if CLIENT then
			ix.npcbarter.TryExecuteBarter(dyndata.npcname, dyndata.identifier, dyndata.reqitem)
		end

		-- Return the next topicID
		return "BackTopic", dyndata
	end,
})





