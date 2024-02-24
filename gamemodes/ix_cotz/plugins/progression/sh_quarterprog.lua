ix.progression.Register("quartermasterItemDelivery_1", {
	name = "Gearing Up 1",
	description = "Introduce yourself to Quartermaster.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_1"] = ix.progression.status["quartermasterItemDelivery_1"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_1"].complexData
		local itemids = self:GetItemIds()

		local str = "So, you're one of the hotshots from the Swamp that Haggler has been talking about. If you're interested in doing business with me, stalker, you'll need to prove your abilities and your worth first. I offer higher end equipment than that buffoon in the swamps can offer, but only to those who are worth my time. If you're interested in opening up my best stock, prove yourself by reducing the chimera population and then I'll consider doing proper business with you lot.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_snork_1"] = 10,
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

		ix.progression.status["quartermasterItemDelivery_1"].complexData = ix.progression.status["quartermasterItemDelivery_1"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_1"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_1"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_1"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_1"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Alright, you've convinced me that we can do business together. My stock of MP5 SMGs is now open to buyers."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("mp5", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("mossberg500", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_1", true)
			ix.progression.SetActive("quartermasterItemDelivery_11", true) 
			ix.progression.SetActive("quartermasterItemDelivery_12", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_11", {
	name = "Gearing Up 1.1",
	description = "Help Quartermaster secure a weapon shipment.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_11"] = ix.progression.status["quartermasterItemDelivery_11"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_11"].complexData
		local itemids = self:GetItemIds()

		local str = "Alright, you've proven yourself at least a bit useful. That means that it's time to move on from playing with SMGs and to move onto the real deal; assault weapons. That's why you're here, isn't it? Anyway, some of my people outside the Zone are getting ready to move some special hardware into the Zone and I need some extra guns to help seal the deal. Here's a list of what I need.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["ruger1022"] = 10,
			["w9422"] = 10,
			["sako85varmint"] = 10,
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

		ix.progression.status["quartermasterItemDelivery_11"].complexData = ix.progression.status["quartermasterItemDelivery_11"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_11"].complexData[item] = ix.progression.status["quartermasterItemDelivery_11"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_11"].complexData[item] = ix.progression.status["quartermasterItemDelivery_11"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_11"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_11"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_11"].complexData[item] = ix.progression.status["quartermasterItemDelivery_11"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_11"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Shipment cleared. If you're interested in an AK-74, L85, or a Mateba .44 revolver, bring your coin."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("mateba", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("ak74", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("l85", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_11", true)
			ix.progression.SetActive("quartermasterItemDelivery_111", true) 
			ix.progression.SetActive("quartermasterItemDelivery_112", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_111", {
	name = "Gearing Up 1.1.1",
	description = "Help Quartermaster snatch a shipment.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_111"] = ix.progression.status["quartermasterItemDelivery_111"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_111"].complexData
		local itemids = self:GetItemIds()

		local str = "Got another job for you if you're interested in helping out. I've got a couple of people from outside the Zone who are interested in importing some G36c rifles into the Zone, but we're running into some competition from the local wildlife. In addition, I've gotten wind of the location of a stash of .44 lever actions; pretty useful stuff against mutants. I see a win-win here; help me arrange the retrieval of both shipments and I'll have some new stock for you.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_boar"] = 80,
			["part_cat"] = 40,
			["part_pseudodog"] = 70,
			["part_bloodsucker"] = 20,
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

		ix.progression.status["quartermasterItemDelivery_111"].complexData = ix.progression.status["quartermasterItemDelivery_111"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_111"].complexData[item] = ix.progression.status["quartermasterItemDelivery_111"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_111"].complexData[item] = ix.progression.status["quartermasterItemDelivery_111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_111"].complexData[item] = ix.progression.status["quartermasterItemDelivery_111"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_111"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Stash is secure and shipment got here. If you're interested in a .44 lever action or a G36c, now's the time to see me."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("lax44", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("g36c", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_111", true)
			ix.progression.SetActive("quartermasterItemDelivery_1111", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_1111", {
	name = "Gearing Up 1.1.1.1",
	description = "Help Quartermaster clear his supply lines.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_1111"] = ix.progression.status["quartermasterItemDelivery_1111"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_1111"].complexData
		local itemids = self:GetItemIds()

		local str = "We've got a problem, stalker. My shipments are getting harassed, and I'm not sure by what. My couriers are turning up dead and my guards are reporting sustained contact from mutants and armed locals, I assume either bandits or the Ukrainian military. How's about you lot help me keep my supply lines clear? I'll pay you... hell, I'll even open up stock to one of my nicer rifles.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_izlom"] = 50,
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

		ix.progression.status["quartermasterItemDelivery_1111"].complexData = ix.progression.status["quartermasterItemDelivery_1111"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_1111"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1111"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_1111"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_1111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_1111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_1111"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1111"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_1111"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "My people feel a lot safer now. As promised, SG552 rifles are now available for sale."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("sg552", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_1111", true)

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_112", {
	name = "Gearing Up 1.1.2",
	description = "Help Quartermaster close a sale with some shady customers.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_112"] = ix.progression.status["quartermasterItemDelivery_112"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_112"].complexData
		local itemids = self:GetItemIds()

		local str = "Got an interesting one for you; I've gotten an offer from some people outside the Zone... Russians, I think. They've got a list of some pretty exclusive intelligence they want in exchange for a shipment of unique rifles. Now, I'm not talking random AKMs here; I'm referring to Russian military issue equipment that have been santizied for distribution. I smell a solid opportunity here, and I want your help in making it happen.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_documents_2"] = 1,
			["value_documents_4"] = 1,
			["value_documents_5"] = 1,
			["value_documents_9"] = 1,
			["value_documents_10"] = 1,
			["value_documents_11"] = 1,
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

		ix.progression.status["quartermasterItemDelivery_112"].complexData = ix.progression.status["quartermasterItemDelivery_112"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_112"].complexData[item] = ix.progression.status["quartermasterItemDelivery_112"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_112"].complexData[item] = ix.progression.status["quartermasterItemDelivery_112"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_112"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_112"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_112"].complexData[item] = ix.progression.status["quartermasterItemDelivery_112"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_112"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "The check cleared and I got the crates. If you want an AEK-971 or a AN94k straight out of the storehouses, contact me."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("aek971", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("an94k", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_112", true)
			ix.progression.SetActive("quartermasterItemDelivery_1121", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_1121", {
	name = "Gearing Up 1.1.2.1",
	description = "Help Quartermaster establish a new supply line.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_1121"] = ix.progression.status["quartermasterItemDelivery_1121"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_1121"].complexData
		local itemids = self:GetItemIds()

		local str = "Good timing; I've got work. Unfortunately, one of my suppliers has gone dark, and intel from outside suggests that he was found out and arrested by the SBU. That's bad enough; worse is that one of my supply lines has been cut off. I've been in talks for a while with a new one, and while things are going well I think they could use a little bit of extra motivation, you follow me? I've found out that he craves information, and I'm more than willing to provide that to him.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_documents_9"] = 3,
			["value_documents_10"] = 3,
			["value_documents_11"] = 3,
			["value_powerbank"] = 15,
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

		ix.progression.status["quartermasterItemDelivery_1121"].complexData = ix.progression.status["quartermasterItemDelivery_1121"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_1121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1121"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_1121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1121"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_1121"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_1121"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_1121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1121"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_1121"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Business talks went well; the first new shipment of SAKO RK 95 rifles just arrived. You can purchase them now."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("rk95", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_1121", true)
			ix.progression.SetActive("quartermasterItemDelivery_11211", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_11211", {
	name = "Gearing Up 1.1.2.1.1",
	description = "Help Quartermaster get friendly with the Russians.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_11211"] = ix.progression.status["quartermasterItemDelivery_11211"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_11211"].complexData
		local itemids = self:GetItemIds()

		local str = "The Russians are back in touch again, and their shopping list this time is even longer than the last one. On the bright side, however, they've got some damn nice hardware in stock; AK-12s are up for grabs. This is a big deal; these are Russian army issue, not just stored prototypes. They're requesting high grade gunpowders in exchange for the rifles; the kind of powder we don't have the tools to repack. Interested?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_gunpowder_green"] = 100,
			["value_gunpowder_blue"] = 90,
			["value_gunpowder_red"] = 80,
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

		ix.progression.status["quartermasterItemDelivery_11211"].complexData = ix.progression.status["quartermasterItemDelivery_11211"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_11211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_11211"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_11211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_11211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_11211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_11211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_11211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_11211"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_11211"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "First crate of AK-12s just came in. Anyone feel like buying?"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("ak12", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_11211", true)
		end
	end
})

ix.progression.Register("quartermasterItemDelivery_12", {
	name = "Gearing Up 1.2",
	description = "Help Quartermaster expand his personal defence arsenal.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_12"] = ix.progression.status["quartermasterItemDelivery_12"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_12"].complexData
		local itemids = self:GetItemIds()

		local str = "I've got no outstanding work right now, although... no, nevermind, I've got something for you; or, rather, you've got something for me. I don't get out there a lot, so I want to know what you're up against out there. I want data, intel, that sort of thing. That'll allow me to tailor my stock to better serve you lot.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["hidestash_2"] = 15,
			["hidestash_3"] = 20,
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

		ix.progression.status["quartermasterItemDelivery_12"].complexData = ix.progression.status["quartermasterItemDelivery_12"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_12"].complexData[item] = ix.progression.status["quartermasterItemDelivery_12"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_12"].complexData[item] = ix.progression.status["quartermasterItemDelivery_12"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_12"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_12"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_12"].complexData[item] = ix.progression.status["quartermasterItemDelivery_12"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_12"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Your data's been invaluable. I've added the M3 Super 90 and FN FiveseveN to my stock; they should help you deal with a variety of threats."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("m3super90", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("fiveseven", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_12", true)
			ix.progression.SetActive("quartermasterItemDelivery_121", true) 
			ix.progression.SetActive("quartermasterItemDelivery_122", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_121", {
	name = "Gearing Up 1.2.1",
	description = "Prove your worth to Quartermaster.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_121"] = ix.progression.status["quartermasterItemDelivery_121"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_121"].complexData
		local itemids = self:GetItemIds()

		local str = "It's time for another test, stalker. You've proven yourself a reliable business partner so far, but I need to know that you have the skills to keep up. Psuedogiants are rare and very dangerous around here; I want you to find one, I want you to kill it, and I want you to bring me proof.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_pseudogiant"] = 1,
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

		ix.progression.status["quartermasterItemDelivery_121"].complexData = ix.progression.status["quartermasterItemDelivery_121"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_121"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_121"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_121"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_121"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_121"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_121"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "The pseudogiant has been found and killed. Good work; I'm releasing the P90 and UMP-45 into regular distribution."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("p90", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("ump45", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_121", true)
		end
	end
})

ix.progression.Register("quartermasterItemDelivery_122", {
	name = "Gearing Up 1.2.2",
	description = "Help Quartermaster work with his Western supplier.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_122"] = ix.progression.status["quartermasterItemDelivery_122"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_122"].complexData
		local itemids = self:GetItemIds()

		local str = "No, I don't need data this time, but I do need some help. My Western suppliers are finally willing to trade some of the nicer hardware and they've put an order out for some psydog fur. If this works out, they'll be sending some NATO weapons into the zone, starting with the LR 300 combat rifle. You have my back on this one?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_psydog"] = 3,
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

		ix.progression.status["quartermasterItemDelivery_122"].complexData = ix.progression.status["quartermasterItemDelivery_122"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_122"].complexData[item] = ix.progression.status["quartermasterItemDelivery_122"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_122"].complexData[item] = ix.progression.status["quartermasterItemDelivery_122"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_122"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_122"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_122"].complexData[item] = ix.progression.status["quartermasterItemDelivery_122"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_122"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "LR 300 rifles just hit the shelves. Come and see me if you want to buy one."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("lr300", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_122", true)
			ix.progression.SetActive("quartermasterItemDelivery_1221", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_1221", {
	name = "Gearing Up 1.2.2.1",
	description = "Help Quartermaster expand his Western operation.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_1221"] = ix.progression.status["quartermasterItemDelivery_1221"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_1221"].complexData
		local itemids = self:GetItemIds()

		local str = "Alright, our friends from the West were very pleased with what we provided them. Unsurprisingly, they're asking for more supplies from the Zone; in this case, MREs. Believe it or not, it's actually cheaper to buy them per meal from us as opposed to by the case off the surplus market. This time, they've got M16A4 rifles up for grabs. I'm not sure where these guys are getting the stuff that the United States Marines get, but I'm interested in staying on their good side. Are you?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["food_mre_usa"] = 100,
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

		ix.progression.status["quartermasterItemDelivery_1221"].complexData = ix.progression.status["quartermasterItemDelivery_1221"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_1221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1221"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_1221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1221"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_1221"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_1221"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_1221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1221"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_1221"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "The West was pleased and they've further provided us with some American rifles. Come get your M16A4s here."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("m16a4", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_1221", true)
			ix.progression.SetActive("quartermasterItemDelivery_12211", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_12211", {
	name = "Gearing Up 1.2.2.1.1",
	description = "Help Quartermaster further expand his Western operation.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_12211"] = ix.progression.status["quartermasterItemDelivery_12211"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_12211"].complexData
		local itemids = self:GetItemIds()

		local str = "No direct import order this time, the Westerners have a delivery that they want me to help facilitate and I'm going to do just that. I have been given permission, however, to skim a couple of hundred rifles off the shipment they've got coming in. They're asking for a pseudogiant's hide in exchange, something about armour research. You in?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["hide_pseudogiant"] = 1,
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

		ix.progression.status["quartermasterItemDelivery_12211"].complexData = ix.progression.status["quartermasterItemDelivery_12211"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_12211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_12211"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_12211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_12211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_12211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_12211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_12211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_12211"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_12211"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "You all came through for me so I'm doing likewise. I've now got FN FAL rifles in stock."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("fnfal", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_12211", true)
		end
	end
})

ix.progression.Register("quartermasterItemDelivery_2", {
	name = "Gearing Up 2",
	description = "Help Quartermaster with his hand cannon problem.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_2"] = ix.progression.status["quartermasterItemDelivery_2"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_2"].complexData
		local itemids = self:GetItemIds()

		local str = "Time for a data gathering mission. I've been getting complaints about the lack of heavy sidearms for sale, and I don't really know what would be most useful out there. Get out there, get me some more intel, and I'll tailor my stock accordingly. Try taking out some of the burer population.\n\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_burer_1"] = 10,
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

		ix.progression.status["quartermasterItemDelivery_2"].complexData = ix.progression.status["quartermasterItemDelivery_2"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_2"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_2"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_2"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_2"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Alright, data about heavy pistols suggests that the S&W R8 is a good fit for my local market. Come and pick one up if you want eight rounds of .357 and a dream."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("swr8", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_2", true)
			ix.progression.SetActive("quartermasterItemDelivery_21", true) 
			ix.progression.SetActive("quartermasterItemDelivery_22", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_21", {
	name = "Gearing Up 2.1",
	description = "Help Quartermaster complete his revolver supply.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_21"] = ix.progression.status["quartermasterItemDelivery_21"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_21"].complexData
		local itemids = self:GetItemIds()

		local str = "The S&W R8 seems to satisfy most people, but I've found that some stalkers are turning up their nose at that idea and sticking with the shitty .44 Magnum cartridge instead. Rather than give the moron in the swamps my business, I want in on that action. Get me some more data and I'll reward you.\n\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["hidestash_2"] = 45,
			["hidestash_3"] = 10,
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

		ix.progression.status["quartermasterItemDelivery_21"].complexData = ix.progression.status["quartermasterItemDelivery_21"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_21"].complexData[item] = ix.progression.status["quartermasterItemDelivery_21"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_21"].complexData[item] = ix.progression.status["quartermasterItemDelivery_21"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_21"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_21"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_21"].complexData[item] = ix.progression.status["quartermasterItemDelivery_21"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_21"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "I now offer the Taurus Raging Bull; a .44 hand cannon that should give any mutants a bad day. As a bonus, I've opened up my stock of MP9 machine pistols for purchase."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("taurusragingbull", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("mp9a1", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_21", true)
			ix.progression.SetActive("quartermasterItemDelivery_211", true) 
			ix.progression.SetActive("quartermasterItemDelivery_212", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_211", {
	name = "Gearing Up 2.1.1",
	description = "Help Quartermaster fulfill his SMG stocks.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_211"] = ix.progression.status["quartermasterItemDelivery_211"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_211"].complexData
		local itemids = self:GetItemIds()

		local str = "I've gotten a request for some SMGs that are cheaper than the P90 or the like, and I have a few in mind. I've requested an order, but my supplier says that they're on backorder. The guy loves bacon, and so I suggest that we give the fat fuck exactly what he wants.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["meat_flesh"] = 300,
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

		ix.progression.status["quartermasterItemDelivery_211"].complexData = ix.progression.status["quartermasterItemDelivery_211"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_211"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_211"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_211"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Good news; my supplier suddenly found a bunch of UZI and Vityaz SMGs. Lucky us, right?"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("uzi", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("pp1901vityaz", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_211", true)
		end
	end
})

ix.progression.Register("quartermasterItemDelivery_212", {
	name = "Gearing Up 2.1.2",
	description = "Help Quartermaster fulfill a request from the West.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_212"] = ix.progression.status["quartermasterItemDelivery_212"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_212"].complexData
		local itemids = self:GetItemIds()

		local str = "The West has reached out again, and they've got yet another shopping list of food that they require. Up for grabs this time is the FAMAS assault rifle; a French piece that's particularly useful in close quarters, being both a bullpup and automatic. If you want your very own bugle, now's the time to pitch in.\n\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["food_mre_ukraine"] = 50,
			["food_mre_russia"] = 50,
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

		ix.progression.status["quartermasterItemDelivery_212"].complexData = ix.progression.status["quartermasterItemDelivery_212"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_212"].complexData[item] = ix.progression.status["quartermasterItemDelivery_212"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_212"].complexData[item] = ix.progression.status["quartermasterItemDelivery_212"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_212"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_212"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_212"].complexData[item] = ix.progression.status["quartermasterItemDelivery_212"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_212"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "FAMAS rifles just arrived here. If you're interested, I'm selling them."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("famas", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_212", true)
			ix.progression.SetActive("quartermasterItemDelivery_2121", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_2121", {
	name = "Gearing Up 2.1.2.1",
	description = "Help Quartermaster complete his Western contract.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_2121"] = ix.progression.status["quartermasterItemDelivery_2121"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_2121"].complexData
		local itemids = self:GetItemIds()

		local str = "We've gotten about all we can from the West, and it's time to seal the deal. Up on offer is the AUG; a real space age piece of kit. My supplier's after computer parts, and I can only think of a few locals who can help out here.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_pcpart_gpu"] = 1,
			["value_pcpart_psu"] = 1,
			["value_pcpart_hdd"] = 2,
			["value_pcpart_ssd"] = 2,
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

		ix.progression.status["quartermasterItemDelivery_2121"].complexData = ix.progression.status["quartermasterItemDelivery_2121"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_2121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2121"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_2121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2121"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_2121"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_2121"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_2121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2121"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_2121"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "The Steyr AUG is now available for purchase. That will be the last assault rifle we see from the West, so hope you like it."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("aug", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_2121", true)
		end
	end
})

ix.progression.Register("quartermasterItemDelivery_22", {
	name = "Gearing Up 2.2",
	description = "Help Quartermaster pick out some precision weapons.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_22"] = ix.progression.status["quartermasterItemDelivery_22"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_22"].complexData
		local itemids = self:GetItemIds()

		local str = "A group of pretty influential mutant hunters have been in touch, and they're looking for some kit that's more accurate than your standard fare. Now, the Raging Bull hits like a goddamn freight train, but these guys are wanting something a bit more accurate. To that end, I'm contacting the West with a specific request; and I want you to supply me with the offering. In this case, i've picked up wind that the Westerners are wanting to do research into anomalous power sources, and I've got an idea of what they might want.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_battery"] = 10,
			["part_electrocontroller_1"] = 1,
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

		ix.progression.status["quartermasterItemDelivery_22"].complexData = ix.progression.status["quartermasterItemDelivery_22"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_22"].complexData[item] = ix.progression.status["quartermasterItemDelivery_22"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_22"].complexData[item] = ix.progression.status["quartermasterItemDelivery_22"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_22"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_22"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_22"].complexData[item] = ix.progression.status["quartermasterItemDelivery_22"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_22"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "The West was more than happy to provide; the Remington 870AE and the MR96 revolver are up for grabs."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("rem870", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("mr96", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_22", true)
			ix.progression.SetActive("quartermasterItemDelivery_221", true) 
			ix.progression.SetActive("quartermasterItemDelivery_222", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_221", {
	name = "Gearing Up 2.2.1",
	description = "Help Quartermaster appease the locals.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_221"] = ix.progression.status["quartermasterItemDelivery_221"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_221"].complexData
		local itemids = self:GetItemIds()

		local str = "I think it's time to expand my market into kit that's a little bit cheaper than the super high end stuff. The first thing that comes to mind is the Saiga shotgun, but I know that's a bit more money than your average stalker is willing to foot. To that end, I'm going to make another deal; this time, I'm after thermal artefacts and information about hellhounds. You know what to do.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_eye"] = 15,
			["part_hellhound"] = 8, -- PLACEHOLDER, DOESNT EXIST YET
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

		ix.progression.status["quartermasterItemDelivery_221"].complexData = ix.progression.status["quartermasterItemDelivery_221"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_221"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_221"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_221"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_221"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_221"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_221"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "You spoke and I listened; the MP-153 semi automatic shotgun is up for grabs."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("mp153", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_221", true)
		end
	end
})

ix.progression.Register("quartermasterItemDelivery_222", {
	name = "Gearing Up 2.2.2",
	description = "Help Quartermaster expand into the precision rifles market.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_222"] = ix.progression.status["quartermasterItemDelivery_222"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_222"].complexData
		local itemids = self:GetItemIds()

		local str = "I've seen a lot of the swamp stalkers coming in with Mosin rifles and SAKO kit. While that's nice, they aren't modern precision rifles and they especially aren't hardened for use in the Zone. I have a shipment of decent bolt actions coming in, but the price they're offering is substantial. I'll need enough artefacts to sate them.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_mamasbeads"] = 4,
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

		ix.progression.status["quartermasterItemDelivery_222"].complexData = ix.progression.status["quartermasterItemDelivery_222"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_222"].complexData[item] = ix.progression.status["quartermasterItemDelivery_222"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_222"].complexData[item] = ix.progression.status["quartermasterItemDelivery_222"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_222"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_222"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_222"].complexData[item] = ix.progression.status["quartermasterItemDelivery_222"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_222"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "The SV-98 is up for sale. Come grab one if you fancy yourself a sniper."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("sv98", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_222", true)
			ix.progression.SetActive("quartermasterItemDelivery_2221", true) 
		end
	end
})

ix.progression.Register("quartermasterItemDelivery_2221", {
	name = "Gearing Up 2.2.2.1",
	description = "Help Quartermaster top off his stock.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_2221"] = ix.progression.status["quartermasterItemDelivery_2221"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_2221"].complexData
		local itemids = self:GetItemIds()

		local str = "It's been a long road together, but I have one last job for you to do. The SV-98 isn't selling as well as I'd like, so I've put in an order for something I know nobody else is going to be able to match. The asking price is very high, so to close the deal I intend to use artefacts rather than liquid currency. Crystals will be our best bet, I think.\n\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_crystal"] = 25,
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

		ix.progression.status["quartermasterItemDelivery_2221"].complexData = ix.progression.status["quartermasterItemDelivery_2221"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_2221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2221"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_2221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2221"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_2221"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_2221"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["quartermasterItemDelivery_2221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2221"].complexData[item] or 0
			if amt > ix.progression.status["quartermasterItemDelivery_2221"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "The SVD is now available to buy. That's all the work I have for you guys; feel free to drop by and say hi, though."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("svd", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_2221", true)
		end
	end
})

