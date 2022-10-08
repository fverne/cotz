
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
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Technut'",
					message = "The first product of our combined efforts are ready, come by and buy a mail jacket."
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("mailjacket", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetActive("technutItemDelivery_Suit1", false)
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
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Technut'",
					message = "Come on over, I got some freshly finished trenchcoats for you all, for a price of course."
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("trenchcoat", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetActive("technutItemDelivery_Suit2", false)
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
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Technut'",
					message = "Stalkers, I've got some fresh suit prototypes, ready for purchase."
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("sunrise", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetActive("technutItemDelivery_Suit3", false)
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
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Technut'",
					message = "I just finished a batch of armored suits, they're ready for purchase."
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("cs1", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetActive("technutItemDelivery_Suit4", false)
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
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Technut'",
					message = "I just finished my work on the new iteration of the CS type suits, they're ready for purchase now."
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("cs2", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetActive("technutItemDelivery_Suit5", false)
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
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Technut'",
					message = "I just finished a batch of heavily armored suits, the CS3's, they're ready for purchase now."
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("cs3", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetActive("technutItemDelivery_Suit6", false)
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
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Technut'",
					message = "I just finished a batch of suits, they're ready for purchase now."
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("wind", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetActive("technutItemDelivery_Suit7", false)

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
	defaultActive = false,
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
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Technut'",
					message = "I just finished a batch of suits, they're ready for purchase now."
				})
			end)

			ix.progression.SetActive("technutItemDelivery_SuitPainting", false)

		end
	end
})