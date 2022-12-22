
--
-- Suit line
--

ix.progression.Register("technutItemDelivery_Suit1", {
	name = "Suiting Up Pt. 1",
	description = "Get Technut to help you make suits.",
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
				local name = "'Technut'"
				local message = "The first product of our combined efforts are ready, come by and buy a mail jacket."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("mailjacket", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Suit1", true)
			ix.progression.SetActive("technutItemDelivery_Suit2", true) 

		end
	end
})

ix.progression.Register("technutItemDelivery_Suit2", {
	name = "Suiting Up Pt. 2",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Suit2"] = ix.progression.status["technutItemDelivery_Suit2"] or {}
		local dat = ix.progression.status["technutItemDelivery_Suit2"].complexData
		local itemids = self:GetItemIds()

		local str = "You ever notice how tough the skin of some of these mutants are? I bet you we could fashion them into coats. I'll need the following:\n"

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

		ix.progression.status["technutItemDelivery_Suit2"].complexData = ix.progression.status["technutItemDelivery_Suit2"].complexData or {}
		ix.progression.status["technutItemDelivery_Suit2"].complexData[item] = ix.progression.status["technutItemDelivery_Suit2"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Suit2"].complexData[item] = ix.progression.status["technutItemDelivery_Suit2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Suit2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Suit2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Suit2"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = "Come on over, I got some freshly finished trenchcoats for you all, for a price of course."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("trenchcoat", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Suit2", true)
			ix.progression.SetActive("technutItemDelivery_Suit3", true) 

		end
	end
})

ix.progression.Register("technutItemDelivery_Suit3", {
	name = "Suiting Up Pt. 3",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Suit3"] = ix.progression.status["technutItemDelivery_Suit3"] or {}
		local dat = ix.progression.status["technutItemDelivery_Suit3"].complexData
		local itemids = self:GetItemIds()

		local str = "All this suit construction has given me some ideas for outfits. The first one is a fairly lightweight, as the most important thing is being nimble, right? I can start work on the prototype as soon as you bring me these items:\n"

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

		ix.progression.status["technutItemDelivery_Suit3"].complexData = ix.progression.status["technutItemDelivery_Suit3"].complexData or {}
		ix.progression.status["technutItemDelivery_Suit3"].complexData[item] = ix.progression.status["technutItemDelivery_Suit3"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Suit3"].complexData[item] = ix.progression.status["technutItemDelivery_Suit3"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Suit3"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Suit3"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Suit3"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = "Stalkers, I've got some fresh suit prototypes, ready for purchase."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("sunrise", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Suit3", true)
			ix.progression.SetActive("technutItemDelivery_Suit4", true) 

		end
	end
})

ix.progression.Register("technutItemDelivery_Suit4", {
	name = "Suiting Up Pt. 4",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Suit4"] = ix.progression.status["technutItemDelivery_Suit4"] or {}
		local dat = ix.progression.status["technutItemDelivery_Suit4"].complexData
		local itemids = self:GetItemIds()

		local str = "The next outfit I have in mind is a bit more heavily armored, mostly around the chest area. Should be able to take a couple of shots to the chest at least. Like before, I'll start working on the prototype as soon as you bring me these items:\n"

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

		ix.progression.status["technutItemDelivery_Suit4"].complexData = ix.progression.status["technutItemDelivery_Suit4"].complexData or {}
		ix.progression.status["technutItemDelivery_Suit4"].complexData[item] = ix.progression.status["technutItemDelivery_Suit4"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Suit4"].complexData[item] = ix.progression.status["technutItemDelivery_Suit4"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Suit4"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Suit4"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Suit4"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = "I just finished a batch of armored suits, they're ready for purchase."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("cs1", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Suit4", true)
			ix.progression.SetActive("technutItemDelivery_Suit5", true) 

		end
	end
})

ix.progression.Register("technutItemDelivery_Suit5", {
	name = "Suiting Up Pt. 5",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Suit5"] = ix.progression.status["technutItemDelivery_Suit5"] or {}
		local dat = ix.progression.status["technutItemDelivery_Suit5"].complexData
		local itemids = self:GetItemIds()

		local str = "From seeing the previous model, CS1, in action, it's clear that it needs a little bit more oomph. I've got some plans for another model much like the CS1, but this time more armored. Like before, I'll start working on the prototype as soon as you bring me these items:\n"

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

		ix.progression.status["technutItemDelivery_Suit5"].complexData = ix.progression.status["technutItemDelivery_Suit5"].complexData or {}
		ix.progression.status["technutItemDelivery_Suit5"].complexData[item] = ix.progression.status["technutItemDelivery_Suit5"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Suit5"].complexData[item] = ix.progression.status["technutItemDelivery_Suit5"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Suit5"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Suit5"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Suit5"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = "I just finished my work on the new iteration of the CS type suits, they're ready for purchase now."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("cs2", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Suit5", true)
			ix.progression.SetActive("technutItemDelivery_Suit6", true) 

		end
	end
})

ix.progression.Register("technutItemDelivery_Suit6", {
	name = "Suiting Up Pt. 6",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Suit6"] = ix.progression.status["technutItemDelivery_Suit6"] or {}
		local dat = ix.progression.status["technutItemDelivery_Suit6"].complexData
		local itemids = self:GetItemIds()

		local str = "The CS2 is an improvement on the CS1, but it doesn't protect quite as well as I would like, so my idea is to make it even more armored. Like before, I'll start working on the prototype as soon as you bring me these items:\n"

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

		ix.progression.status["technutItemDelivery_Suit6"].complexData = ix.progression.status["technutItemDelivery_Suit6"].complexData or {}
		ix.progression.status["technutItemDelivery_Suit6"].complexData[item] = ix.progression.status["technutItemDelivery_Suit6"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Suit6"].complexData[item] = ix.progression.status["technutItemDelivery_Suit6"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Suit6"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Suit6"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Suit6"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = "I just finished a batch of heavily armored suits, the CS3's, they're ready for purchase now."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("cs3", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Suit6", true)
			ix.progression.SetActive("technutItemDelivery_Suit7", true) 

		end
	end
})

ix.progression.Register("technutItemDelivery_Suit7", {
	name = "Suiting Up Pt. 7",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Suit7"] = ix.progression.status["technutItemDelivery_Suit7"] or {}
		local dat = ix.progression.status["technutItemDelivery_Suit7"].complexData
		local itemids = self:GetItemIds()

		local str = "I've heard from some of the guys that the CS3 is too heavy, and that moving around in it is too clunky. I've got a schematic for a lightweight, highly modular suit, that I think will be just the thing for you all. Like before, I'll start working on the prototype as soon as you bring me these items:\n"

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

		ix.progression.status["technutItemDelivery_Suit7"].complexData = ix.progression.status["technutItemDelivery_Suit7"].complexData or {}
		ix.progression.status["technutItemDelivery_Suit7"].complexData[item] = ix.progression.status["technutItemDelivery_Suit7"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Suit7"].complexData[item] = ix.progression.status["technutItemDelivery_Suit7"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Suit7"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Suit7"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Suit7"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = "I just finished a batch of suits, they're ready for purchase now."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("wind", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Suit7", true)

		end
	end
})


--
-- Suit Painting
--
-- Note how this is not default active, so it needs to be .SetActive'd from another event
ix.progression.Register("technutItemDelivery_SuitPainting", {
	name = "Colourful Fashion",
	description = "Get Technut to paint your suits.",
	keyNpc = "'Technut'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_SuitPainting"] = ix.progression.status["technutItemDelivery_SuitPainting"] or {}
		local dat = ix.progression.status["technutItemDelivery_SuitPainting"].complexData
		local itemids = self:GetItemIds()

		local str = "It's a bit hard to tell you all apart with those balaclavas, so I'm thinking of establishing a way for you guys to get patches, other types of camouflage and so on on your suits. We'll need a couple of things for that:\n"

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

		ix.progression.status["technutItemDelivery_SuitPainting"].complexData = ix.progression.status["technutItemDelivery_SuitPainting"].complexData or {}
		ix.progression.status["technutItemDelivery_SuitPainting"].complexData[item] = ix.progression.status["technutItemDelivery_SuitPainting"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_SuitPainting"].complexData[item] = ix.progression.status["technutItemDelivery_SuitPainting"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_SuitPainting"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_SuitPainting"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_SuitPainting"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = "I just finished a batch of suits, they're ready for purchase now."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			ix.progression.SetCompleted("technutItemDelivery_SuitPainting", true)

		end
	end
})



--
-- Helmets line
--


ix.progression.Register("technutItemDelivery_Helmet1", {
	name = "Wear Protection Pt. 1",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Helmet1"] = ix.progression.status["technutItemDelivery_Helmet1"] or {}
		local dat = ix.progression.status["technutItemDelivery_Helmet1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Steel Helmets, german and russian :\n"

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

		ix.progression.status["technutItemDelivery_Helmet1"].complexData = ix.progression.status["technutItemDelivery_Helmet1"].complexData or {}
		ix.progression.status["technutItemDelivery_Helmet1"].complexData[item] = ix.progression.status["technutItemDelivery_Helmet1"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Helmet1"].complexData[item] = ix.progression.status["technutItemDelivery_Helmet1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Helmet1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Helmet1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Helmet1"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks Steel Helmets, german and russian"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("steelhelmetgerman", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("steelhelmetrussian", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Helmet1", true)
			ix.progression.SetActive("technutItemDelivery_Helmet2", true) 

		end
	end
})


ix.progression.Register("technutItemDelivery_Helmet2", {
	name = "Wear Protection Pt. 2",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Helmet2"] = ix.progression.status["technutItemDelivery_Helmet2"] or {}
		local dat = ix.progression.status["technutItemDelivery_Helmet2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks flighthelmet, flighthelmetvisor :\n"

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

		ix.progression.status["technutItemDelivery_Helmet2"].complexData = ix.progression.status["technutItemDelivery_Helmet2"].complexData or {}
		ix.progression.status["technutItemDelivery_Helmet2"].complexData[item] = ix.progression.status["technutItemDelivery_Helmet2"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Helmet2"].complexData[item] = ix.progression.status["technutItemDelivery_Helmet2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Helmet2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Helmet2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Helmet2"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks flighthelmet, flighthelmetvisor"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("flighthelmet", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("flighthelmetvisor", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Helmet2", true)
			ix.progression.SetActive("technutItemDelivery_Helmet3", true) 

		end
	end
})


ix.progression.Register("technutItemDelivery_Helmet3", {
	name = "Wear Protection Pt. 3",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Helmet3"] = ix.progression.status["technutItemDelivery_Helmet3"] or {}
		local dat = ix.progression.status["technutItemDelivery_Helmet3"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks pasgt :\n"

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

		ix.progression.status["technutItemDelivery_Helmet3"].complexData = ix.progression.status["technutItemDelivery_Helmet3"].complexData or {}
		ix.progression.status["technutItemDelivery_Helmet3"].complexData[item] = ix.progression.status["technutItemDelivery_Helmet3"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Helmet3"].complexData[item] = ix.progression.status["technutItemDelivery_Helmet3"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Helmet3"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Helmet3"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Helmet3"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks pasgt"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("pasgt", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Helmet3", true)
			ix.progression.SetActive("technutItemDelivery_Helmet4", true) 

		end
	end
})


ix.progression.Register("technutItemDelivery_Helmet4", {
	name = "Wear Protection Pt. 4",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Helmet4"] = ix.progression.status["technutItemDelivery_Helmet4"] or {}
		local dat = ix.progression.status["technutItemDelivery_Helmet4"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks fraghelmet :\n"

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

		ix.progression.status["technutItemDelivery_Helmet4"].complexData = ix.progression.status["technutItemDelivery_Helmet4"].complexData or {}
		ix.progression.status["technutItemDelivery_Helmet4"].complexData[item] = ix.progression.status["technutItemDelivery_Helmet4"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Helmet4"].complexData[item] = ix.progression.status["technutItemDelivery_Helmet4"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Helmet4"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Helmet4"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Helmet4"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks fraghelmet"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("fraghelmet", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Helmet4", true)
			ix.progression.SetActive("technutItemDelivery_Helmet5", true) 

		end
	end
})


ix.progression.Register("technutItemDelivery_Helmet5", {
	name = "Wear Protection Pt. 5",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Helmet5"] = ix.progression.status["technutItemDelivery_Helmet5"] or {}
		local dat = ix.progression.status["technutItemDelivery_Helmet5"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks sphere08 :\n"

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

		ix.progression.status["technutItemDelivery_Helmet5"].complexData = ix.progression.status["technutItemDelivery_Helmet5"].complexData or {}
		ix.progression.status["technutItemDelivery_Helmet5"].complexData[item] = ix.progression.status["technutItemDelivery_Helmet5"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Helmet5"].complexData[item] = ix.progression.status["technutItemDelivery_Helmet5"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Helmet5"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Helmet5"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Helmet5"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks sphere08"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("sphere08", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Helmet5", true)
			ix.progression.SetActive("technutItemDelivery_Helmet6", true) 

		end
	end
})


ix.progression.Register("technutItemDelivery_Helmet6", {
	name = "Wear Protection Pt. 6",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Helmet6"] = ix.progression.status["technutItemDelivery_Helmet6"] or {}
		local dat = ix.progression.status["technutItemDelivery_Helmet6"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks ach :\n"

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

		ix.progression.status["technutItemDelivery_Helmet6"].complexData = ix.progression.status["technutItemDelivery_Helmet6"].complexData or {}
		ix.progression.status["technutItemDelivery_Helmet6"].complexData[item] = ix.progression.status["technutItemDelivery_Helmet6"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Helmet6"].complexData[item] = ix.progression.status["technutItemDelivery_Helmet6"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Helmet6"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Helmet6"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Helmet6"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks ach"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("ach", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Helmet6", true)
			ix.progression.SetActive("technutItemDelivery_Helmet7", true) 

		end
	end
})


ix.progression.Register("technutItemDelivery_Helmet7", {
	name = "Wear Protection Pt. 7",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Helmet7"] = ix.progression.status["technutItemDelivery_Helmet7"] or {}
		local dat = ix.progression.status["technutItemDelivery_Helmet7"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks sphere12 :\n"

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

		ix.progression.status["technutItemDelivery_Helmet7"].complexData = ix.progression.status["technutItemDelivery_Helmet7"].complexData or {}
		ix.progression.status["technutItemDelivery_Helmet7"].complexData[item] = ix.progression.status["technutItemDelivery_Helmet7"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Helmet7"].complexData[item] = ix.progression.status["technutItemDelivery_Helmet7"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Helmet7"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Helmet7"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Helmet7"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks sphere12"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("sphere12", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Helmet7", true)

		end
	end
})



--
-- Gasmasks/Masks line
--


ix.progression.Register("technutItemDelivery_Mask1", {
	name = "Don't breathe this Pt. 1",
	description = "Help technut provide gasmasks.",
	keyNpc = "'Technut'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Mask1"] = ix.progression.status["technutItemDelivery_Mask1"] or {}
		local dat = ix.progression.status["technutItemDelivery_Mask1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks halfmask :\n"

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

		ix.progression.status["technutItemDelivery_Mask1"].complexData = ix.progression.status["technutItemDelivery_Mask1"].complexData or {}
		ix.progression.status["technutItemDelivery_Mask1"].complexData[item] = ix.progression.status["technutItemDelivery_Mask1"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Mask1"].complexData[item] = ix.progression.status["technutItemDelivery_Mask1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Mask1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Mask1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Mask1"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks halfmask"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("halfmask", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Mask1", true)
			ix.progression.SetActive("technutItemDelivery_Mask2", true) 

		end
	end
})


ix.progression.Register("technutItemDelivery_Mask2", {
	name = "Don't breathe this Pt. 2",
	description = "Help technut provide gasmasks.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Mask2"] = ix.progression.status["technutItemDelivery_Mask2"] or {}
		local dat = ix.progression.status["technutItemDelivery_Mask2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks gp5 :\n"

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

		ix.progression.status["technutItemDelivery_Mask2"].complexData = ix.progression.status["technutItemDelivery_Mask2"].complexData or {}
		ix.progression.status["technutItemDelivery_Mask2"].complexData[item] = ix.progression.status["technutItemDelivery_Mask2"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Mask2"].complexData[item] = ix.progression.status["technutItemDelivery_Mask2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Mask2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Mask2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Mask2"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks gp5"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("gp5", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Mask2", true)
			ix.progression.SetActive("technutItemDelivery_Mask3", true) 

		end
	end
})


ix.progression.Register("technutItemDelivery_Mask3", {
	name = "Don't breathe this Pt. 3",
	description = "Help technut provide gasmasks.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Mask3"] = ix.progression.status["technutItemDelivery_Mask3"] or {}
		local dat = ix.progression.status["technutItemDelivery_Mask3"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks eo20, eo20old :\n"

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

		ix.progression.status["technutItemDelivery_Mask3"].complexData = ix.progression.status["technutItemDelivery_Mask3"].complexData or {}
		ix.progression.status["technutItemDelivery_Mask3"].complexData[item] = ix.progression.status["technutItemDelivery_Mask3"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Mask3"].complexData[item] = ix.progression.status["technutItemDelivery_Mask3"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Mask3"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Mask3"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Mask3"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks eo20, eo20old"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("eo20", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("eo20old", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Mask3", true)
		end
	end
})




--
-- Suit Attachments line
--


ix.progression.Register("technutItemDelivery_Attachment1", {
	name = "Plating up Pt. 1",
	description = "Provide technut with materials for suit plates.",
	keyNpc = "'Technut'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Attachment1"] = ix.progression.status["technutItemDelivery_Attachment1"] or {}
		local dat = ix.progression.status["technutItemDelivery_Attachment1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks attachment_steelplate_1, attachment_ceramicplate_1 :\n"

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

		ix.progression.status["technutItemDelivery_Attachment1"].complexData = ix.progression.status["technutItemDelivery_Attachment1"].complexData or {}
		ix.progression.status["technutItemDelivery_Attachment1"].complexData[item] = ix.progression.status["technutItemDelivery_Attachment1"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Attachment1"].complexData[item] = ix.progression.status["technutItemDelivery_Attachment1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Attachment1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Attachment1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Attachment1"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks attachment_steelplate_1, attachment_ceramicplate_1"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("attachment_steelplate_1", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("attachment_ceramicplate_1", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Attachment1", true)
			ix.progression.SetActive("technutItemDelivery_Attachment2", true) 

		end
	end
})


ix.progression.Register("technutItemDelivery_Attachment2", {
	name = "Plating up Pt. 2",
	description = "Provide technut with materials for suit plates.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Attachment2"] = ix.progression.status["technutItemDelivery_Attachment2"] or {}
		local dat = ix.progression.status["technutItemDelivery_Attachment2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks attachment_steelplate_2, attachment_ceramicplate_2 :\n"

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

		ix.progression.status["technutItemDelivery_Attachment2"].complexData = ix.progression.status["technutItemDelivery_Attachment2"].complexData or {}
		ix.progression.status["technutItemDelivery_Attachment2"].complexData[item] = ix.progression.status["technutItemDelivery_Attachment2"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Attachment2"].complexData[item] = ix.progression.status["technutItemDelivery_Attachment2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Attachment2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Attachment2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Attachment2"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks attachment_steelplate_2, attachment_ceramicplate_2"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("attachment_steelplate_2", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("attachment_ceramicplate_2", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Attachment2", true)
			ix.progression.SetActive("technutItemDelivery_Attachment3", true) 

		end
	end
})


ix.progression.Register("technutItemDelivery_Attachment3", {
	name = "Plating up Pt. 3",
	description = "Provide technut with materials for suit plates.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Attachment3"] = ix.progression.status["technutItemDelivery_Attachment3"] or {}
		local dat = ix.progression.status["technutItemDelivery_Attachment3"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks attachment_steelplate_3, attachment_ceramicplate_3 :\n"

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

		ix.progression.status["technutItemDelivery_Attachment3"].complexData = ix.progression.status["technutItemDelivery_Attachment3"].complexData or {}
		ix.progression.status["technutItemDelivery_Attachment3"].complexData[item] = ix.progression.status["technutItemDelivery_Attachment3"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_Attachment3"].complexData[item] = ix.progression.status["technutItemDelivery_Attachment3"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Attachment3"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Attachment3"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Attachment3"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks attachment_steelplate_3, attachment_ceramicplate_3"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("attachment_steelplate_3", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("attachment_ceramicplate_3", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_Attachment3", true)
		end
	end
})


ix.progression.Register("technutItemDelivery_AttachmentFabric1", {
	name = "Patching Pt. 1",
	description = "Provide technut with materials for suit fabrics.",
	keyNpc = "'Technut'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_AttachmentFabric1"] = ix.progression.status["technutItemDelivery_AttachmentFabric1"] or {}
		local dat = ix.progression.status["technutItemDelivery_AttachmentFabric1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks attachment_fabric_1:\n"

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

		ix.progression.status["technutItemDelivery_AttachmentFabric1"].complexData = ix.progression.status["technutItemDelivery_AttachmentFabric1"].complexData or {}
		ix.progression.status["technutItemDelivery_AttachmentFabric1"].complexData[item] = ix.progression.status["technutItemDelivery_AttachmentFabric1"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_AttachmentFabric1"].complexData[item] = ix.progression.status["technutItemDelivery_AttachmentFabric1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_AttachmentFabric1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_AttachmentFabric1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_AttachmentFabric1"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks attachment_fabric_1"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("attachment_fabric_1", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_AttachmentFabric1", true)
			ix.progression.SetActive("technutItemDelivery_AttachmentFabric2", true) 

		end
	end
})


ix.progression.Register("technutItemDelivery_AttachmentFabric2", {
	name = "Patching Pt. 2",
	description = "Provide technut with materials for suit fabrics.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_AttachmentFabric2"] = ix.progression.status["technutItemDelivery_AttachmentFabric2"] or {}
		local dat = ix.progression.status["technutItemDelivery_AttachmentFabric2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks attachment_fabric_2:\n"

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

		ix.progression.status["technutItemDelivery_AttachmentFabric2"].complexData = ix.progression.status["technutItemDelivery_AttachmentFabric2"].complexData or {}
		ix.progression.status["technutItemDelivery_AttachmentFabric2"].complexData[item] = ix.progression.status["technutItemDelivery_AttachmentFabric2"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_AttachmentFabric2"].complexData[item] = ix.progression.status["technutItemDelivery_AttachmentFabric2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_AttachmentFabric2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_AttachmentFabric2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_AttachmentFabric2"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks attachment_fabric_2"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("attachment_fabric_2", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_AttachmentFabric2", true)

		end
	end
})


ix.progression.Register("technutItemDelivery_AttachmentFrame1", {
	name = "Framing Pt. 1",
	description = "Provide technut with materials for suit frames.",
	keyNpc = "'Technut'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_AttachmentFrame1"] = ix.progression.status["technutItemDelivery_AttachmentFrame1"] or {}
		local dat = ix.progression.status["technutItemDelivery_AttachmentFrame1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks attachment_aluframe:\n"

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

		ix.progression.status["technutItemDelivery_AttachmentFrame1"].complexData = ix.progression.status["technutItemDelivery_AttachmentFrame1"].complexData or {}
		ix.progression.status["technutItemDelivery_AttachmentFrame1"].complexData[item] = ix.progression.status["technutItemDelivery_AttachmentFrame1"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_AttachmentFrame1"].complexData[item] = ix.progression.status["technutItemDelivery_AttachmentFrame1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_AttachmentFrame1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_AttachmentFrame1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_AttachmentFrame1"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks attachment_aluframe"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("attachment_aluframe", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_AttachmentFrame1", true)
			ix.progression.SetActive("technutItemDelivery_AttachmentFrame2", true)

		end
	end
})


ix.progression.Register("technutItemDelivery_AttachmentFrame2", {
	name = "Framing Pt. 2",
	description = "Provide technut with materials for suit frames.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_AttachmentFrame2"] = ix.progression.status["technutItemDelivery_AttachmentFrame2"] or {}
		local dat = ix.progression.status["technutItemDelivery_AttachmentFrame2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks attachment_steelframe:\n"

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

		ix.progression.status["technutItemDelivery_AttachmentFrame2"].complexData = ix.progression.status["technutItemDelivery_AttachmentFrame2"].complexData or {}
		ix.progression.status["technutItemDelivery_AttachmentFrame2"].complexData[item] = ix.progression.status["technutItemDelivery_AttachmentFrame2"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_AttachmentFrame2"].complexData[item] = ix.progression.status["technutItemDelivery_AttachmentFrame2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_AttachmentFrame2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_AttachmentFrame2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_AttachmentFrame2"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message =  " ## PLACEHOLDER ## - Unlocks attachment_steelframe"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("attachment_steelframe", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_AttachmentFrame2", true)

		end
	end
})



ix.progression.Register("technutItemDelivery_AttachmentCarbon", {
	name = "Carbon Cabrón",
	description = "Provide technut with materials for suit carbon fibre.",
	keyNpc = "'Technut'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_AttachmentCarbon"] = ix.progression.status["technutItemDelivery_AttachmentCarbon"] or {}
		local dat = ix.progression.status["technutItemDelivery_AttachmentCarbon"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks attachment_carbonfibre:\n"

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

		ix.progression.status["technutItemDelivery_AttachmentCarbon"].complexData = ix.progression.status["technutItemDelivery_AttachmentCarbon"].complexData or {}
		ix.progression.status["technutItemDelivery_AttachmentCarbon"].complexData[item] = ix.progression.status["technutItemDelivery_AttachmentCarbon"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_AttachmentCarbon"].complexData[item] = ix.progression.status["technutItemDelivery_AttachmentCarbon"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_AttachmentCarbon"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_AttachmentCarbon"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_AttachmentCarbon"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks attachment_carbonfibre"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("attachment_carbonfibre", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_AttachmentCarbon", true)

		end
	end
})



ix.progression.Register("technutItemDelivery_AttachmentKevlar1", {
	name = "Armoring up Pt. 1",
	description = "Provide technut with materials for suit kevlar.",
	keyNpc = "'Technut'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_AttachmentKevlar1"] = ix.progression.status["technutItemDelivery_AttachmentKevlar1"] or {}
		local dat = ix.progression.status["technutItemDelivery_AttachmentKevlar1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks attachment_kevlar_1:\n"

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

		ix.progression.status["technutItemDelivery_AttachmentKevlar1"].complexData = ix.progression.status["technutItemDelivery_AttachmentKevlar1"].complexData or {}
		ix.progression.status["technutItemDelivery_AttachmentKevlar1"].complexData[item] = ix.progression.status["technutItemDelivery_AttachmentKevlar1"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_AttachmentKevlar1"].complexData[item] = ix.progression.status["technutItemDelivery_AttachmentKevlar1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_AttachmentKevlar1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_AttachmentKevlar1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_AttachmentKevlar1"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks attachment_kevlar_1"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("attachment_kevlar_1", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_AttachmentKevlar1", true)
			ix.progression.SetActive("technutItemDelivery_AttachmentKevlar2", true)

		end
	end
})



ix.progression.Register("technutItemDelivery_AttachmentKevlar2", {
	name = "Armoring up Pt. 2",
	description = "Provide technut with materials for suit kevlar.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_AttachmentKevlar2"] = ix.progression.status["technutItemDelivery_AttachmentKevlar2"] or {}
		local dat = ix.progression.status["technutItemDelivery_AttachmentKevlar2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks attachment_kevlar_2:\n"

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

		ix.progression.status["technutItemDelivery_AttachmentKevlar2"].complexData = ix.progression.status["technutItemDelivery_AttachmentKevlar2"].complexData or {}
		ix.progression.status["technutItemDelivery_AttachmentKevlar2"].complexData[item] = ix.progression.status["technutItemDelivery_AttachmentKevlar2"].complexData[item] or 0
		ix.progression.status["technutItemDelivery_AttachmentKevlar2"].complexData[item] = ix.progression.status["technutItemDelivery_AttachmentKevlar2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_AttachmentKevlar2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_AttachmentKevlar2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_AttachmentKevlar2"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Technut'"
				local message = " ## PLACEHOLDER ## - Unlocks attachment_kevlar_2"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("attachment_kevlar_2", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("technutItemDelivery_AttachmentKevlar2", true)

		end
	end
})