
ix.progression.Register("technutItemDelivery_Suit1", {
	name = "Suiting Up Pt. 1",
	description = "Collecting lots of meat for the Old Timer.",
	keyNpc = "'Technut'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Suit1"] = ix.progression.status["technutItemDelivery_Suit1"] or {}
		local dat = ix.progression.status["technutItemDelivery_Suit1"].complexData
		local itemids = self:GetItemIds()

		local str = "I've been thinking about improving these jackets we're wearing, just adding some simple metal inlays should help against mutant bites and scratches. To accomplish this I'll need a couple of things:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_bolt"] = 1,
		}	

		return itemids
	end,
	progressfunctions = {
		[1] = {
			OnRun = function()
				
			end,
			RunOnce = false,
		},
	},
	progressthresholds = {
		[1] = 1,
	},
	fnAddComplexProgression = function(dat, playername)
		local item = dat[1]
		local amt = dat[2]

		ix.progression.status["technutItemDelivery_Suit1"].complexData = ix.progression.status["technutItemDelivery_Suit1"].complexData or {}
		ix.progression.status["technutItemDelivery_Suit1"].complexData[item] = ix.progression.status["technutItemDelivery_Suit1"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Suit1"].complexData[item] = ix.progression.status["technutItemDelivery_Suit1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Suit1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Suit1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Suit1"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Technut'",
					message = "The first product of our combined efforts are ready, come by and buy a mail jacket."
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("suit_mailjacket", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetActive("technutItemDelivery_Suit1", false)
			ix.progression.SetActive("technutItemDelivery_Suit2", true) 

		end
	end
})

