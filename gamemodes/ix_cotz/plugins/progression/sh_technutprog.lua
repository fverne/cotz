
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
			["fireaxe"] = 10,
			["crowbar"] = 10,
			["hatchet"] = 10,
			["machete"] = 10,
			["leadpipe"] = 10,
			["sledgehammer"] = 10,
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
			["value_paracord"] = 15,
			["hide_blinddog"] = 8,
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
			ix.progression.SetACtive("technutItemDelivery_Mask1", true)

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
			["value_techtool_1"] = 5,
			["artifact_bolt"] = 20,
			["artifact_bonecluster"] = 15,
			["artifact_mementomori"] = 10,
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
			ix.progression.SetActive("technutItemDelivery_Helmet1", true) 

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
			["drug_cigarette_4"] = 200,
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
			ix.progression.SetActive("technutItemDelivery_Attachment1", true) 

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
			["drug_tobacco_1"] = 160,
			["drug_tobacco_2"] = 160,
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
			ix.progression.SetActive("technutItemDelivery_AttachmentFabric1", true) 

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
			["drink_spirit_3"] = 70,
			["drink_canbeer_3"] = 120,
			["drink_canbeer_4"] = 120,
			["drink_canbeer_5"] = 120,
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
			ix.progression.SetActive("technutItemDelivery_AttachmentKevlar1", true) 

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
			["drink_wine"] = 100,
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
				local message = "I just finished a batch of lightweight Wind suits, they're ready for purchase now."
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
			ix.progression.SetActive("technutItemDelivery_AttachmentFrame1", true) 
			ix.progression.SetActive("technutItemDelivery_AttachmentCarbon", true) 

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
			["value_glue_2"] = 10,
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
				local message = "You've gotta pimp your suits, different patches and camouflages are now available."
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
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Helmet1"] = ix.progression.status["technutItemDelivery_Helmet1"] or {}
		local dat = ix.progression.status["technutItemDelivery_Helmet1"].complexData
		local itemids = self:GetItemIds()

		local str = "Fancy vests is good and all, but protected body won't save you from a bullet in your face. I have an idea for some simple headgear, but I need some items to make them.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_bolt"] = 5, --Placeholder?
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
				local message = "Steel helmets are up and available for purchase."
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

		local str = "Well, I agree, a simple steel cap is not a good option. I've recovered some schematic for aviation helmets. They are light, comfy, and won't block your vision.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_carbattery"] = 3,
			["value_wire_heavy"] = 10,
			["value_tape_electric"] = 45,
			["value_tape_duct"] = 25,
			["value_motorclean"] = 15,
			["value_gasoline"] = 5,
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
				local message = "Prepare to fly through the Zone with the new headgear!"
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

		local str = "Flight helmets are good, but looks like we need more down-to-earth headgear. I can make some Ukraine military helmets, but I need soom items.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_droplet"] = 50,
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

		local str = "You know what? Why don't I just combine a decent helmet and a respirator together? The creator of this schematic though the same, and I can recreate it. \n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_droplet"] = 20,
			["artifact_crystal"] = 20,
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
				local message = "Frag helmets with respirator are now available, come and buy!"
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

		local str = "Hey! So, the PASGT is all well and good, but it isn't giving the kind of protection people like against bullets. Interested in helping me put together something a little better?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_bonecluster"] = 50,
			["artifact_arachno"] = 5,
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
				local message = "I've figured out how to reproduce Sphere-08 helmets! Come grab some noggin protection!"
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

		local str = "So, the Sphere-08 project is going alright, but it's really friggin' heavy. I've got a few ideas to lighten it and improve on the PASGT design! What do you say?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_slug"] = 40,
			["artifact_mica"] = 15,
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
				local message = "I now carry ACH helmets! These babies from the West are both protective and lightweight!"
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

		local str = "I've gotten a good look at one of the Spetsnaz Sphere-12 helmets and I'm pretty sure I can upgrade them, but I'm gonna need some special materials. Care to help me out?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_mamasbeads"] = 35,
			["artifact_gmamasbeads"] = 5,
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
				local message = "I've now got Sphere-12 heavy helmets! These things are the best of the best!"
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
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Mask1"] = ix.progression.status["technutItemDelivery_Mask1"] or {}
		local dat = ix.progression.status["technutItemDelivery_Mask1"].complexData
		local itemids = self:GetItemIds()

		local str = "So, the Swamps are pretty toxic... before we go much further into the Zone, we're gonna need some kind of radioprotectant. I have an idea, but I'm going to need some materials to make them.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_engine"] = 5,
			["value_waterfilter"] = 18,
			["value_tape_heavy"] = 6,
			["value_tape_duct"] = 12,
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
				local message = "I've managed to whip up a batch of respirators! Come grab one to keep yourself safe from radiation!"
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

		local str = "So, respirators are nice, but they don't protect your eyes and ears! I'm busy refitting some GP-5 gas mask filters to not use asbestos, because we want the masks to avoid cancer, not get it! Want to help me out?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_gasoline"] = 15,
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
				local message = "GP-5 gas masks have been refit and are now safe for use! No asbestos for us!"
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

		local str = "I don't know if you've noticed, but the filters on the PBF gas mask are a bit of a pain to find. I think I've figured out a way to refit them to accept 40mm filters and to trim some weight to boot! Can you grab me a few things to get the job done?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_gasoline"] = 15,
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
				local message = "I've managed to refit the EO-20 to take 40mm external filters! Come and grab one!"
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
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Attachment1"] = ix.progression.status["technutItemDelivery_Attachment1"] or {}
		local dat = ix.progression.status["technutItemDelivery_Attachment1"].complexData
		local itemids = self:GetItemIds()

		local str = "So, a lot of these suits have plate carriers, but we kinda need the plates to get the job done. I'm gonna make them, but I need the stuff to do it!\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["cmore"] = 15,
			["foregrip"] = 20,
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
				local message = "I've managed to put together some basic steel and ceramic armour plates!"
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

		local str = "The handmade plates are okay, but they fold pretty quickly in a firefight. I know someone willing to sell me the plans for better ones, but he's got a steep shopping list for the components...\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["cobrasuppressor"] = 15,
			["tundrasuppressor"] = 10,
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
				local message = "I've managed to fabricate some better quality plates! Come grab them!"
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

		local str = "As we're pushing further north, we're gonna need better steel and ceramic to help keep you guys alive. Interested in helping me make the best stuff money can buy?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["pbssuppressor"] = 15,
			["sakersuppressor"] = 10,
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
				local message = "High quality ballistic inserts are now available for purchase!"
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
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_AttachmentFabric1"] = ix.progression.status["technutItemDelivery_AttachmentFabric1"] or {}
		local dat = ix.progression.status["technutItemDelivery_AttachmentFabric1"].complexData
		local itemids = self:GetItemIds()

		local str = "If you're interested in going artefact hunting, you're gonna need proper protection. We don't exactly have SEVA suits sitting around right now, so I think instead I can get some thermal lining into your suits! I just need materials for the prototypes.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["anorak"] = 100,
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
				local message = "Insulating fabrics are now available! No burning to death if I can help it!"
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

		local str = "How's the insulating fabric treating you? I managed to get my hands on plans for a heavier duty set, but I need more stuff to stitch them together! Wanna help me out?!:\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_zombie_1"] = 500,
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
				local message = "Heavy insulating fabric layers are now available! Come hit me up!"
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
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_AttachmentFrame1"] = ix.progression.status["technutItemDelivery_AttachmentFrame1"] or {}
		local dat = ix.progression.status["technutItemDelivery_AttachmentFrame1"].complexData
		local itemids = self:GetItemIds()

		local str = "Even with big backpacks, have you noticed how damn heavy they can get when you pack them up kinda funky? So have I! I've taken some inspiration from the old ALICE backpacks and I think I can put together some frames that'll help take a load off!\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["food_can_sprats"] = 200,
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
				local message = "Aluminium backpack frames are now available for sale! Come save your back some pain! Just be careful around anomalies, though..."
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

		local str = "So, the aluminium frame is all well and good, but then it hit me; why get something decent from aluminium when you can get something great from steel! Bring me what I need and I'll make it happen!\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_techtool_1"] = 20,
			["value_techtool_2"] = 10,
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
				local message =  "Steel backpack frames are now available! Be extra careful around anomalies, though!"
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
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_AttachmentCarbon"] = ix.progression.status["technutItemDelivery_AttachmentCarbon"] or {}
		local dat = ix.progression.status["technutItemDelivery_AttachmentCarbon"].complexData
		local itemids = self:GetItemIds()

		local str = "I got my hands on some plans for a lining even better than the insulating kind! It'll be very expensive to make, but I think I can do it! I just need prototype materials...\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_toiletpaper"] = 750,
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
				local message = "Carbon fibre inserts are now available! They're really expensive, but you can find nothing better for anomaly protection!"
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
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_AttachmentKevlar1"] = ix.progression.status["technutItemDelivery_AttachmentKevlar1"] or {}
		local dat = ix.progression.status["technutItemDelivery_AttachmentKevlar1"].complexData
		local itemids = self:GetItemIds()

		local str = "So, steel and ceramic plates are good, but they're also really heavy. We're in the 2000s, we're well past the point of super heavy body armour! I think I can piece together something out of kevlar, but the prototypes so far haven't come out great. Wanna help me find materials?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_battery"] = 600,
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
				local message = "K119 Kevlar plates are here to help keep you in the fight!"
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

		local str = "The K119 seems to be doing the job well, but there's always room for improvement! Want to help me make them better? Bring me new materials to work with!\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_9vbattery"] = 450,
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
				local message = "K29 Kevlar plates are now in production! They're lightweight, comfortable, and have the bonus of keeping you alive!"
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