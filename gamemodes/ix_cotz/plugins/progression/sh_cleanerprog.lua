ix.progression.Register("cleanerItemDelivery_Storage", {
	name = "Storage",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Cleaner'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["cleanerItemDelivery_Storage"] = ix.progression.status["cleanerItemDelivery_Storage"] or {}
		local dat = ix.progression.status["cleanerItemDelivery_Storage"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Storage:\n"

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

		ix.progression.status["cleanerItemDelivery_Storage"].complexData = ix.progression.status["cleanerItemDelivery_Storage"].complexData or {}
		ix.progression.status["cleanerItemDelivery_Storage"].complexData[item] = ix.progression.status["cleanerItemDelivery_Storage"].complexData[item] or 0
		ix.progression.status["cleanerItemDelivery_Storage"].complexData[item] = ix.progression.status["cleanerItemDelivery_Storage"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["cleanerItemDelivery_Storage"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["cleanerItemDelivery_Storage"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["cleanerItemDelivery_Storage"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Cleaner'"
				local message = "For a small fee, you can now get your stuff stored by yours truly."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			ix.progression.SetCompleted("cleanerItemDelivery_Storage", true)

		end
	end
})