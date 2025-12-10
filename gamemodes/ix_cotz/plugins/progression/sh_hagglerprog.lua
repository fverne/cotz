local map = "rp_marsh_cs"

ix.progression.Register("hagglerItemDelivery_1", {
	name = "Kitting Up 1",
	description = "Help Haggler establish basic supply lines to smugglers inside the Zone.",
	keyNpc = "'Haggler'",
	defaultActive = true,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_1"] = ix.progression.status["hagglerItemDelivery_1"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_1"].complexData

		local itemids = self:GetItemIds()

		local str = "I'll be honest, stalker, this place is kind of a slouch. We're surviving on particularly shitty pieces of kit: Makarovs, Lugers... basically whatever dumpster trash we can dredge up from the swamps. Luckily for us, I have a solution; I've gotten in touch with a couple of suppliers in the Ukrainian military who are willing to scratch our backs if we scratch theirs. That's where you come in; we've received a supply requisition from a supplier that can't get soldiers out this way to go find it. If we get him what he needs, he's got a shipment of sidearms from military storehouses that he can redirect our way. Get to it.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_nuts"] = 90,
			["value_toiletpaper"] = 15,
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

		ix.progression.status["hagglerItemDelivery_1"].complexData = ix.progression.status["hagglerItemDelivery_1"].complexData or {}
		ix.progression.status["hagglerItemDelivery_1"].complexData[item] = ix.progression.status["hagglerItemDelivery_1"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_1"].complexData[item] = ix.progression.status["hagglerItemDelivery_1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_1"].complexData[item] = ix.progression.status["hagglerItemDelivery_1"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_1"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "My supplier came through. We've got UKM Fort-12 and merc-issue M1911s and Browning Hi-Powers now in stock. Come see me when you've got a chance."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("fort12", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("m1911", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("brhp", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_1", true)
			ix.progression.SetActive("hagglerItemDelivery_11", true) 
			ix.progression.SetActive("hagglerItemDelivery_12", true) 

		end
	end
})

ix.progression.Register("hagglerItemDelivery_11", {
	name = "Kitting Up 1.1",
	description = "Help Haggler set up a workshop.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_11"] = ix.progression.status["hagglerItemDelivery_11"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_11"].complexData

		local itemids = self:GetItemIds()

		local str = "The shipment of pistols is handy, but they're only good for shooting at dogs and fleshes. We're going to need something with a bit more firepower. Now, as it stands, consistent shipments of long guns aren't viable. I can, however, produce some of my own stuff out here. If you bring me the necessary tools, I can get a basic workshop going and fix up something that's 'good enough.' Sound like a plan?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_capacitors"] = 100,
			["value_glue_1"] = 20,
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

		ix.progression.status["hagglerItemDelivery_11"].complexData = ix.progression.status["hagglerItemDelivery_11"].complexData or {}
		ix.progression.status["hagglerItemDelivery_11"].complexData[item] = ix.progression.status["hagglerItemDelivery_11"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_11"].complexData[item] = ix.progression.status["hagglerItemDelivery_11"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_11"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_11"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_11"].complexData[item] = ix.progression.status["hagglerItemDelivery_11"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_11"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Workshop is up and running. If you're interested in a short lever action shotgun or a STEN gun, come find me."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("lax410s", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("sten", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_11", true)
			ix.progression.SetActive("hagglerItemDelivery_111", true) 
			ix.progression.SetActive("hagglerItemDelivery_112", true) 

		end
	end
})

ix.progression.Register("hagglerItemDelivery_111", {
	name = "Kitting Up 1.1.1",
	description = "Help Haggler upgrade his workshop with a basic lathe.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_111"] = ix.progression.status["hagglerItemDelivery_111"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_111"].complexData

		local itemids = self:GetItemIds()

		local str = "Happy with my work in the shop so far? I am too, but my workshop can always be improved, and for that we're gonna need more space. We've got wood in abundance but we don't have the stuff to build with; I need nails for reinforcement, duct tape because duct tape is useful for everything, and we'll need hoses to run water, sewage, and all that good stuff. It'll go a long way to shoring up the shit shacks we call a vllage.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_nails"] = 40,
			["value_tape_duct"] = 25,
			["value_hose"] = 15,
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

		ix.progression.status["hagglerItemDelivery_111"].complexData = ix.progression.status["hagglerItemDelivery_111"].complexData or {}
		ix.progression.status["hagglerItemDelivery_111"].complexData[item] = ix.progression.status["hagglerItemDelivery_111"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_111"].complexData[item] = ix.progression.status["hagglerItemDelivery_111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_111"].complexData[item] = ix.progression.status["hagglerItemDelivery_111"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_111"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Lathe is online. Come give these new long barrel lever action shotguns a try."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("lax410", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_111", true)
			ix.progression.SetActive("hagglerItemDelivery_1111", true) 

		end
	end
})

ix.progression.Register("hagglerItemDelivery_1111", {
	name = "Kitting Up 1.1.1.1",
	description = "Help Haggler expand his supply lines.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_1111"] = ix.progression.status["hagglerItemDelivery_1111"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_1111"].complexData

		local itemids = self:GetItemIds()

		local str = "I'm milking my supplies in the SBU for all they're worth, but there's only so much they can get to us right now. Luckily, though, I've made contact with some of the Zone's Mercenaries; a guy called Quartermaster is interested in helping us out. He's put out a requisition order to test the waters and is offering some real Dirty Harry kind of revolvers if we help him out. If you want to take the first step into big bore pistols, now's your time to shine, kid.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_tape_electric"] = 30,
			["value_detergent"] = 30,
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

		ix.progression.status["hagglerItemDelivery_1111"].complexData = ix.progression.status["hagglerItemDelivery_1111"].complexData or {}
		ix.progression.status["hagglerItemDelivery_1111"].complexData[item] = ix.progression.status["hagglerItemDelivery_1111"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_1111"].complexData[item] = ix.progression.status["hagglerItemDelivery_1111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_1111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_1111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_1111"].complexData[item] = ix.progression.status["hagglerItemDelivery_1111"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_1111"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "First shipment of .44 Magnum revolvers just came in. If you want one of these wristbreakers, come and say hello."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("swmodel29", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_1111", true)

		end
	end
})


ix.progression.Register("hagglerItemDelivery_112", {
	name = "Kitting Up 1.1.2",
	description = "Help Haggler upgrade his workshop with a rivet gun.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_112"] = ix.progression.status["hagglerItemDelivery_112"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_112"].complexData

		local itemids = self:GetItemIds()

		local str = "I don't know if you've spent any time using it, but I really, really hate the STEN gun. It's bulky, takes up a lot of space, and is damn near impossible to carry comfortably. I've managed to barter for diagrams on how to make Sterling guns; the next step up from a normal STEN. However, I've run into a... slight problem. The guy who I sent to pay for the schematics hasn't showed up yet and my supplier is starting to get pissed. I'm gonna work ons scrabbling together something to get him off my ass, but for that I'll need some help for you. He's fond of showing off; go get some bling... and while you're at it, bring some loose wiring so I can work on my shop.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_goldchain"] = 4,
			["value_wire_light"] = 60,
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

		ix.progression.status["hagglerItemDelivery_112"].complexData = ix.progression.status["hagglerItemDelivery_112"].complexData or {}
		ix.progression.status["hagglerItemDelivery_112"].complexData[item] = ix.progression.status["hagglerItemDelivery_112"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_112"].complexData[item] = ix.progression.status["hagglerItemDelivery_112"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_112"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_112"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_112"].complexData[item] = ix.progression.status["hagglerItemDelivery_112"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_112"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Just finished refitting the first batch of Sterling guns. Come and get 'em if you've got the rubles to spare."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("sterling", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_112", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_12", {
	name = "Kitting Up 1.2",
	description = "Help Haggler con a mechanic.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_12"] = ix.progression.status["hagglerItemDelivery_12"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_12"].complexData

		local itemids = self:GetItemIds()

		local str = "If you've got time, I've got something you can help me with. One of my suppliers managed to get a shipment of TOZ-66 shotguns that never made it out of the Tula arsenal. Pretty good shit, right? Problem is that he isn't selling, but I know just the way to get him to cough it up. He's a gearhead, so I figure if we fork him auto components for his precious cars he'll be willing to deal. You get me some spark plugs and some glue and I'll handle the rest.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_sparkplug"] = 30,
			["value_glue_2"] = 25,
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

		ix.progression.status["hagglerItemDelivery_12"].complexData = ix.progression.status["hagglerItemDelivery_12"].complexData or {}
		ix.progression.status["hagglerItemDelivery_12"].complexData[item] = ix.progression.status["hagglerItemDelivery_12"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_12"].complexData[item] = ix.progression.status["hagglerItemDelivery_12"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_12"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_12"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_12"].complexData[item] = ix.progression.status["hagglerItemDelivery_12"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_12"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "TOZ-66 shipment just hit the shelves. Come spent your hard earned cash on the rookie's dream gun."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("toz66", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("toz66short", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_12", true)
			ix.progression.SetActive("hagglerItemDelivery_121", true)
			ix.progression.SetActive("hagglerItemDelivery_1221", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_121", {
	name = "Kitting Up 1.2.1",
	description = "Help Haggler deal with Quartermaster.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_121"] = ix.progression.status["hagglerItemDelivery_121"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_121"].complexData

		local itemids = self:GetItemIds()

		local str = "So, I had the great idea to start importing some Cold War era weapons, starting SKS rifles from the Ukrainians and Mini-14s from Quartermaster. Seemed like a great idea, right? Intermediate caliber, accurate, reliable... only the entire fucking shipment came coated in cosmoline! Unfortunately, he's got us by the throat here. I don't know where he's based out of, but it's remote, and they lack hygenic supplies. He's requesting, of all things, toothpaste, and a handful of those bronze horse statuettes that seem to show up out of nowhere. This'll be big if we fill the order, so let's do this.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_toothpaste"] = 35,
			["value_statue_horse"] = 5,
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

		ix.progression.status["hagglerItemDelivery_121"].complexData = ix.progression.status["hagglerItemDelivery_121"].complexData or {}
		ix.progression.status["hagglerItemDelivery_121"].complexData[item] = ix.progression.status["hagglerItemDelivery_121"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_121"].complexData[item] = ix.progression.status["hagglerItemDelivery_121"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_121"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_121"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_121"].complexData[item] = ix.progression.status["hagglerItemDelivery_121"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_121"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "SKS and Mini-14 rifles are ready to go if you don't mind the damn grease smell. I hope you all appreciate the bullshit I go through for you all."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("sks", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("rugermini14", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_121", true)
			ix.progression.SetActive("hagglerItemDelivery_1211", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_1211", {
	name = "Kitting Up 1.2.1.1",
	description = "Help Haggler expand his supply lines.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_1211"] = ix.progression.status["hagglerItemDelivery_1211"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_1211"].complexData

		local itemids = self:GetItemIds()

		local str = "So, I'm thinking that these imported arms are all well and good, but they're too damn expensive by far. The Russian gearhead is willing to deal, but he's wanting a bit more than last time. He wants full engline blocks this time; not the kind used in cars, but the motors that are used in stuff like garage doors. He wants these as well as nuts to use for fastening. If you're interested in Saiga semiauto rifles, you should spring.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_engine"] = 4,
			["value_nuts"] = 80,
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

		ix.progression.status["hagglerItemDelivery_1211"].complexData = ix.progression.status["hagglerItemDelivery_1211"].complexData or {}
		ix.progression.status["hagglerItemDelivery_1211"].complexData[item] = ix.progression.status["hagglerItemDelivery_1211"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_1211"].complexData[item] = ix.progression.status["hagglerItemDelivery_1211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_1211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_1211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_1211"].complexData[item] = ix.progression.status["hagglerItemDelivery_1211"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_1211"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Saigas are now in stock. Come and get 'em before someone else does."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("saigasemi", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_1211", true)
			ix.progression.SetActive("hagglerItemDelivery_12111", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_12111", {
	name = "Kitting Up 1.2.1.1.1",
	description = "Help Haggler organize a trade with Quartermaster.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_12111"] = ix.progression.status["hagglerItemDelivery_12111"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_12111"].complexData

		local itemids = self:GetItemIds()

		local str = "So, Quartermaster got in touch with me with an offer. We've got some stuff out here in the Swamps that he can't get where he is, and he wants some. He also knows that we're gonna need something a little more beefy than what we've got if we want to start pushing north. Like typical Quartermaster, though, he's offering to sell us the weapon without a reliable means of getting the ammo. He's wanting fifty jars of gunpowder, the shitty stuff used for pistol reloads. You up to it?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_gunpowder_blue"] = 30,
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

		ix.progression.status["hagglerItemDelivery_12111"].complexData = ix.progression.status["hagglerItemDelivery_12111"].complexData or {}
		ix.progression.status["hagglerItemDelivery_12111"].complexData[item] = ix.progression.status["hagglerItemDelivery_12111"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_12111"].complexData[item] = ix.progression.status["hagglerItemDelivery_12111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_12111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_12111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_12111"].complexData[item] = ix.progression.status["hagglerItemDelivery_12111"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_12111"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Big bore rifles are up for grabs. Come get your mutant hunting kit."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("w9422357", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("357magnum", nil, 15, "SELLANDBUY", 15, 1, 15)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_12111", true)
			ix.progression.SetActive("hagglerItemDelivery_121111", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_121111", {
	name = "Kitting Up 1.2.1.1.1.1",
	description = "Help Haggler trade with a tourist.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_121111"] = ix.progression.status["hagglerItemDelivery_121111"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_121111"].complexData

		local itemids = self:GetItemIds()

		local str = "We've got a golden opportunity here, stalker! Word about what we're doing here is starting to spread, and a pretty rich tourist hit me up with a request. He's wanting to get some bling from the Zone, mostly because it costs a fraction of the price from here compared to the open market. He's after new phones and the big gold watches bandits like to wear. He's offering up .500 Magnum as a big bore hunting load for some of the nastier mutants. Want to help make a deal? \n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_phone_new"] = 15,
			["value_watch"] = 20,
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

		ix.progression.status["hagglerItemDelivery_121111"].complexData = ix.progression.status["hagglerItemDelivery_121111"].complexData or {}
		ix.progression.status["hagglerItemDelivery_121111"].complexData[item] = ix.progression.status["hagglerItemDelivery_121111"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_121111"].complexData[item] = ix.progression.status["hagglerItemDelivery_121111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_121111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_121111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_121111"].complexData[item] = ix.progression.status["hagglerItemDelivery_121111"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_121111"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Tourists were happy with the magnums; even got some .500 Magnum revolvers in along with the refit Contenders. Come grab one if you want to give a boar a really bad day."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("g2500mag", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("500magnum", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_121111", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_122", {
	name = "Kitting Up 1.2.2",
	description = "Help Haggler make an exchange with his Russian supplier.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_122"] = ix.progression.status["hagglerItemDelivery_122"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_122"].complexData

		local itemids = self:GetItemIds()

		local str = "Yo, got another opportunity here. My Russian supplier came at me with an order for some Zone-acquired supplies. He's after detergent bottles and car batteries; apparently, the older detergents around here are more acidic than modern stuff or some shit like that. I don't ask questions, I just make deals. You in?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_detergent"] = 30,
			["value_car_battery"] = 5,
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

		ix.progression.status["hagglerItemDelivery_122"].complexData = ix.progression.status["hagglerItemDelivery_122"].complexData or {}
		ix.progression.status["hagglerItemDelivery_122"].complexData[item] = ix.progression.status["hagglerItemDelivery_122"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_122"].complexData[item] = ix.progression.status["hagglerItemDelivery_122"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_122"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_122"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_122"].complexData[item] = ix.progression.status["hagglerItemDelivery_122"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_122"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Crates just got here. I've got Kiparis machine pistols and Suomi SMGs on the shelves now."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("kiparis", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("kp31", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_122", true)
			ix.progression.SetActive("hagglerItemDelivery_1221", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_1221", {
	name = "Kitting Up 1.2.2.1",
	description = "Help Haggler get proper pistol tooling equipment.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_1221"] = ix.progression.status["hagglerItemDelivery_1221"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_1221"].complexData

		local itemids = self:GetItemIds()

		local str = "Alright, I think I've about hit my limit with this hand machining shit. I'm gonna need proper tooling for the workshop to make better SMGs and machine pistols. What's tooling, you ask? Fuck, I don't have time to explain it, just fill my shopping list so I can start making calls.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_waterfilter"] = 8,
			["value_bolts"] = 80,
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

		ix.progression.status["hagglerItemDelivery_1221"].complexData = ix.progression.status["hagglerItemDelivery_1221"].complexData or {}
		ix.progression.status["hagglerItemDelivery_1221"].complexData[item] = ix.progression.status["hagglerItemDelivery_1221"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_1221"].complexData[item] = ix.progression.status["hagglerItemDelivery_1221"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_1221"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_1221"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_1221"].complexData[item] = ix.progression.status["hagglerItemDelivery_1221"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_1221"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Finally got my lathe upgraded, I've got Mac-11 machine pistols up for grabs. Perfect fast-firing 9x19 kit for those who like the candle that burns twice as bright."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("mac11", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_1221", true)
			ix.progression.SetActive("hagglerItemDelivery_12211", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_12211", {
	name = "Kitting Up 1.2.2.1.1",
	description = "Help Haggler get some precision components.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_12211"] = ix.progression.status["hagglerItemDelivery_12211"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_12211"].complexData

		local itemids = self:GetItemIds()

		local str = "Good seeing you. You remember way back when we got the 1911 pistols? Well, Quartermaster got a custom order that he wants us to fill. He's sent over the blueprints for a pistol he calls the Chicago; a modified variant of the 1911 that's capable of firing in full auto. Could be useful if you want the rate of fire of a machine pistol but the power of something a little heavier. Wanna give it a shot with me?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_techtool_2"] = 2,
			["value_gunoil"] = 20,
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

		ix.progression.status["hagglerItemDelivery_12211"].complexData = ix.progression.status["hagglerItemDelivery_12211"].complexData or {}
		ix.progression.status["hagglerItemDelivery_12211"].complexData[item] = ix.progression.status["hagglerItemDelivery_12211"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_12211"].complexData[item] = ix.progression.status["hagglerItemDelivery_12211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_12211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_12211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_12211"].complexData[item] = ix.progression.status["hagglerItemDelivery_12211"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_12211"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Quartermaster was pleased with what we gave him and they seem to be useful, so I'll be stocking the Colt Chicago from now on. If you want a custom little piece, now's the time."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("m1911chic", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_12211", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_2", {
	name = "Kitting Up 2",
	description = "Help Haggler import a new type of shotgun.",
	keyNpc = "'Haggler'",
	defaultActive = true,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_2"] = ix.progression.status["hagglerItemDelivery_2"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_2"].complexData

		local itemids = self:GetItemIds()

		local str = "So, if you're like me, you're probably getting pretty goddamn tired of the peashooters chambered in .410. Well, my Russian supplier got back to me about a batch of TOZ-34 shotguns directly from the Tula Arsenal; no resale, no second hand, none of that shit. He's requesting some more mechanical parts for the trade. \n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_bolts"] = 130,
			["value_sparkplug"] = 10,
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

		ix.progression.status["hagglerItemDelivery_2"].complexData = ix.progression.status["hagglerItemDelivery_2"].complexData or {}
		ix.progression.status["hagglerItemDelivery_2"].complexData[item] = ix.progression.status["hagglerItemDelivery_2"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_2"].complexData[item] = ix.progression.status["hagglerItemDelivery_2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_2"].complexData[item] = ix.progression.status["hagglerItemDelivery_2"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_2"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "TOZ-34 over-under shotguns are in. From Russia with love, eh?"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("toz34", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("toz34short", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_2", true)
			ix.progression.SetActive("hagglerItemDelivery_21", true) 
			ix.progression.SetActive("hagglerItemDelivery_22", true) 

		end
	end
})

ix.progression.Register("hagglerItemDelivery_21", {
	name = "Kitting Up 2.1",
	description = "Help Haggler rechamber some SAKO rifles.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_21"] = ix.progression.status["hagglerItemDelivery_21"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_21"].complexData

		local itemids = self:GetItemIds()

		local str = "You seen some of the shitty peashooters chambered in .22 around here? They aren't particularly useful other than shooting tushkano, and that isn't really sustainable for us right now. I'm working on getting them rechambered into 5.56. I can try to load the ammo, but I'm gonna need rifle grade gunpowder. Go find some jars and let me see what I can do.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_gunpowder_green"] = 15,
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

		ix.progression.status["hagglerItemDelivery_21"].complexData = ix.progression.status["hagglerItemDelivery_21"].complexData or {}
		ix.progression.status["hagglerItemDelivery_21"].complexData[item] = ix.progression.status["hagglerItemDelivery_21"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_21"].complexData[item] = ix.progression.status["hagglerItemDelivery_21"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_21"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_21"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_21"].complexData[item] = ix.progression.status["hagglerItemDelivery_21"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_21"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "SAKO-85 rifles in 5.56 are in. If you want to try out a NATO cartridge, come see me."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("sako85nato", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_21", true)
			ix.progression.SetActive("hagglerItemDelivery_211", true) 
			ix.progression.SetActive("hagglerItemDelivery_212", true) 

		end
	end
})

ix.progression.Register("hagglerItemDelivery_211", {
	name = "Kitting Up 2.1.1",
	description = "Help Haggler buy some woodworking tools.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_211"] = ix.progression.status["hagglerItemDelivery_211"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_211"].complexData

		local itemids = self:GetItemIds()

		local str = "So, combining some of the knowledge that I gained working on the Chicago project, I'm ready to give a new homemade project a try. Did you know that the C96 Mauser had a carbine variant? Extraordinarily rare these days, but it's an interesting concept that I think we could apply here. I'm gonna need some help importing some specialist woodworking components so I can make my own stocks for these babies. I've found a guy willing to make the trade, but he's after yet more car batteries. Interested?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_carbattery"] = 8,
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

		ix.progression.status["hagglerItemDelivery_211"].complexData = ix.progression.status["hagglerItemDelivery_211"].complexData or {}
		ix.progression.status["hagglerItemDelivery_211"].complexData[item] = ix.progression.status["hagglerItemDelivery_211"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_211"].complexData[item] = ix.progression.status["hagglerItemDelivery_211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_211"].complexData[item] = ix.progression.status["hagglerItemDelivery_211"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_211"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Handmade C96 carbines are now in. Come and get them!"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("c96carbine", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_211", true)
			ix.progression.SetActive("hagglerItemDelivery_2111", true) 
		end
	end
})

ix.progression.Register("hagglerItemDelivery_2111", {
	name = "Kitting Up 2.1.1.1",
	description = "Help Haggler find a stash of PPSh SMGs.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_2111"] = ix.progression.status["hagglerItemDelivery_2111"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_2111"].complexData

		local itemids = self:GetItemIds()

		local str = "I've been seeing stalkers run around the the PPSh SMG; nice piece of kit, but they're rather uncommon right now. I've been hearing rumours from others about a stash of them from the war that were kept in a storehouse somewhere in the Zone, and I've found a stalker willing to sell a stash location. He's trustworthy, so I think it's worth a shot. He's asking for silicone tubing for some repairs at his camp.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_siliconetube"] = 40,
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

		ix.progression.status["hagglerItemDelivery_2111"].complexData = ix.progression.status["hagglerItemDelivery_2111"].complexData or {}
		ix.progression.status["hagglerItemDelivery_2111"].complexData[item] = ix.progression.status["hagglerItemDelivery_2111"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_2111"].complexData[item] = ix.progression.status["hagglerItemDelivery_2111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_2111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_2111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_2111"].complexData[item] = ix.progression.status["hagglerItemDelivery_2111"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_2111"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "My guys came back; it was a legit stash. If you want a PPSh, I've got them for sale now."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("ppsh", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_2111", true)

		end
	end
})

ix.progression.Register("hagglerItemDelivery_212", {
	name = "Kitting Up 2.1.2",
	description = "Help Haggler trade for some pump-action shotguns.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_212"] = ix.progression.status["hagglerItemDelivery_212"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_212"].complexData

		local itemids = self:GetItemIds()

		local str = "I think we're starting to reach the point now where double barrel shotguns just aren't cutting it. The further north we go, the bigger mutant hordes and groups of nasties are getting. My Russian guy is interested in trading some pump action shotguns for some more 'locally acquired goods.' as it were. Want in on the action?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_battery"] = 90,
			["value_motorclean"] = 15,
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

		ix.progression.status["hagglerItemDelivery_212"].complexData = ix.progression.status["hagglerItemDelivery_212"].complexData or {}
		ix.progression.status["hagglerItemDelivery_212"].complexData[item] = ix.progression.status["hagglerItemDelivery_212"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_212"].complexData[item] = ix.progression.status["hagglerItemDelivery_212"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_212"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_212"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_212"].complexData[item] = ix.progression.status["hagglerItemDelivery_212"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_212"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Pump action TOZ-194 shotguns are in. Come and get them while they're hot."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("toz194", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_212", true)
			ix.progression.SetActive("hagglerItemDelivery_2121", true) 
		end
	end
})

ix.progression.Register("hagglerItemDelivery_2121", {
	name = "Kitting Up 2.1.2.1",
	description = "Help Haggler make another deal with Quartermaster.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_2121"] = ix.progression.status["hagglerItemDelivery_2121"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_2121"].complexData

		local itemids = self:GetItemIds()

		local str = "Quartermaster has reached me with an offer for some vintage M1887 lever action shotguns. They're nice little coach guns, the same size as a sawed off but can carry more shells. I've got most of a shipment to him ready, but I'm gonna need some heavy cabling to put on the finishing touches. You know what to do, yeah?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_wire_heavy"] = 5,
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

		ix.progression.status["hagglerItemDelivery_2121"].complexData = ix.progression.status["hagglerItemDelivery_2121"].complexData or {}
		ix.progression.status["hagglerItemDelivery_2121"].complexData[item] = ix.progression.status["hagglerItemDelivery_2121"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_2121"].complexData[item] = ix.progression.status["hagglerItemDelivery_2121"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_2121"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_2121"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_2121"].complexData[item] = ix.progression.status["hagglerItemDelivery_2121"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_2121"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "M1887s are in. Come give them a try."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("m1887", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_2121", true)
			ix.progression.SetActive("hagglerItemDelivery_21211", true) 
		end
	end
})

ix.progression.Register("hagglerItemDelivery_21211", {
	name = "Kitting Up 2.1.2.1.1",
	description = "Help Haggler import some western shotguns.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_21211"] = ix.progression.status["hagglerItemDelivery_21211"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_21211"].complexData

		local itemids = self:GetItemIds()

		local str = "The TOZ-194 is nice and all, but its lack of a stock and small magazine tube make it impractical for larger groups of mutants. Quartermaster reached out again with another offer; he's got some Ithaca shotguns from Vietnam up for grabs and I think I may bite. He's asking for some more electrical components; copper wire and batteries, mostly. Wonder what he's getting up to... \n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_wire_copper"] = 40,
			["value_9vbattery"] = 70,
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

		ix.progression.status["hagglerItemDelivery_21211"].complexData = ix.progression.status["hagglerItemDelivery_21211"].complexData or {}
		ix.progression.status["hagglerItemDelivery_21211"].complexData[item] = ix.progression.status["hagglerItemDelivery_21211"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_21211"].complexData[item] = ix.progression.status["hagglerItemDelivery_21211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_21211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_21211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_21211"].complexData[item] = ix.progression.status["hagglerItemDelivery_21211"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_21211"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Ithaca shotguns are in. They should keep you going."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("ithaca37", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_21211", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_22", {
	name = "Kitting Up 2.2",
	description = "Help Haggler trade for rifle tooling for future projects.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_22"] = ix.progression.status["hagglerItemDelivery_22"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_22"].complexData

		local itemids = self:GetItemIds()

		local str = "So, if you're had any experience with the 7.62 rifles you'll know that the bullet is a little big and is punishing for newer shooters. I want to whip something up that's easier for our newer guys to handle. I've got a shipment of MP34 SMGs coming in from Quartermaster, but the opportunity has come up to get a set of 5.45 tooling with it. Want to help contribute to the deal?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_lightbulb"] = 60,
			["value_gasoline"] = 20,
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

		ix.progression.status["hagglerItemDelivery_22"].complexData = ix.progression.status["hagglerItemDelivery_22"].complexData or {}
		ix.progression.status["hagglerItemDelivery_22"].complexData[item] = ix.progression.status["hagglerItemDelivery_22"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_22"].complexData[item] = ix.progression.status["hagglerItemDelivery_22"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_22"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_22"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_22"].complexData[item] = ix.progression.status["hagglerItemDelivery_22"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_22"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "MP34 shipment just came in a few minutes ago and I'm starting on the Saiga 5.45 rechambers. First come, first serve."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("saigasemi545", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("mp34", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_22", true)
			ix.progression.SetActive("hagglerItemDelivery_221", true) 
			ix.progression.SetActive("hagglerItemDelivery_222", true) 

		end
	end
})

ix.progression.Register("hagglerItemDelivery_221", {
	name = "Kitting Up 2.2.1",
	description = "Help Haggler get some new Finnish hardware.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_221"] = ix.progression.status["hagglerItemDelivery_221"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_221"].complexData

		local itemids = self:GetItemIds()

		local str = "I found out who my supplier was using to get the shitty .22 SAKO peashooters from and went around him, and now I've got access to the Finnish market. In short, that means that I can get Finnish firearms directly from the source; first on the docket, old Russian Empire era Winchester 1895 lever actions and the actual SAKO rifles in 7.62x54. He's asking for a pretty substantial bribe on top of some wiring for a generator and the propane to fuel it, so it isn't gonna be cheap.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_hose"] = 90,
			["value_wire_light"] = 60,
			["value_propanetank"] = 15,
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

		ix.progression.status["hagglerItemDelivery_221"].complexData = ix.progression.status["hagglerItemDelivery_221"].complexData or {}
		ix.progression.status["hagglerItemDelivery_221"].complexData[item] = ix.progression.status["hagglerItemDelivery_221"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_221"].complexData[item] = ix.progression.status["hagglerItemDelivery_221"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_221"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_221"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_221"].complexData[item] = ix.progression.status["hagglerItemDelivery_221"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_221"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "The Finn came through. If you want an original SAKO-85 or the Winchester 1895, come and grab one."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("sako85", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("w1895", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_221", true)
			ix.progression.SetActive("hagglerItemDelivery_2211", true) 
		end
	end
})

ix.progression.Register("hagglerItemDelivery_2211", {
	name = "Kitting Up 2.2.1.1",
	description = "Help Haggler trade for some old Russian surplus.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_2211"] = ix.progression.status["hagglerItemDelivery_2211"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_2211"].complexData

		local itemids = self:GetItemIds()

		local str = "My Russian supplier has a two part shipment. The first is to trade for the Mosin-Nagant; it's so goddamn prominent that I don't need to give you an introduction. He's a technician, so he's asking for some paracord and a wireless transmitter; where the latter request comes from, I have no goddamn idea.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_paracord"] = 40,
			["value_wirelesstrans"] = 1,
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

		ix.progression.status["hagglerItemDelivery_2211"].complexData = ix.progression.status["hagglerItemDelivery_2211"].complexData or {}
		ix.progression.status["hagglerItemDelivery_2211"].complexData[item] = ix.progression.status["hagglerItemDelivery_2211"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_2211"].complexData[item] = ix.progression.status["hagglerItemDelivery_2211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_2211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_2211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_2211"].complexData[item] = ix.progression.status["hagglerItemDelivery_2211"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_2211"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Mosins are in. If you want to help me out with the second part of the shipment, now's the time."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("mosinnagant", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_2211", true)
			ix.progression.SetActive("hagglerItemDelivery_22111", true) 
		end
	end
})

ix.progression.Register("hagglerItemDelivery_22111", {
	name = "Kitting Up 2.2.1.1.1",
	description = "Help Haggler finish his surplus trade.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_22111"] = ix.progression.status["hagglerItemDelivery_22111"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_22111"].complexData

		local itemids = self:GetItemIds()

		local str = "Right, part two of the shipment. Bolt actions are all well and good, but semi autos with a magazine are even better. He's asking for an entire shipment of glue for repairs for the second half, so this is gonna take a lot of time but I think you'll appreciate the results.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_glue_3"] = 200,
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

		ix.progression.status["hagglerItemDelivery_22111"].complexData = ix.progression.status["hagglerItemDelivery_22111"].complexData or {}
		ix.progression.status["hagglerItemDelivery_22111"].complexData[item] = ix.progression.status["hagglerItemDelivery_22111"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_22111"].complexData[item] = ix.progression.status["hagglerItemDelivery_22111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_22111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_22111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_22111"].complexData[item] = ix.progression.status["hagglerItemDelivery_22111"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_22111"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "SVT-40 rifles are in. That's probably going to be the last that my Russian supplier can get us."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("svt40", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_22111", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_222", {
	name = "Kitting Up 2.2.2",
	description = "Help Haggler refurbish some old SMGs.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_222"] = ix.progression.status["hagglerItemDelivery_222"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_222"].complexData

		local itemids = self:GetItemIds()

		local str = "So, you've probably run into a MP40 or two in your time here. Now that we've got more ubiquitous 9x19 floating around, I think it may be time to start selling them myself. I'm gonna need some nails to build a new table and enough tools to start manufacturing everything I need.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_techtool_1"] = 6,
			["value_nails"] = 40,
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

		ix.progression.status["hagglerItemDelivery_222"].complexData = ix.progression.status["hagglerItemDelivery_222"].complexData or {}
		ix.progression.status["hagglerItemDelivery_222"].complexData[item] = ix.progression.status["hagglerItemDelivery_222"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_222"].complexData[item] = ix.progression.status["hagglerItemDelivery_222"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_222"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_222"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_222"].complexData[item] = ix.progression.status["hagglerItemDelivery_222"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_222"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "The MP40 repair shop is ready to go; I've got the first sample ready for sale."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("mp40", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_222", true)
			ix.progression.SetActive("hagglerItemDelivery_2221", true) 
		end
	end
})

ix.progression.Register("hagglerItemDelivery_2221", {
	name = "Kitting Up 2.2.2.1",
	description = "Help Haggler make a deal with the Ukrainian Army.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_2221"] = ix.progression.status["hagglerItemDelivery_2221"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_2221"].complexData

		local itemids = self:GetItemIds()

		local str = "After all this bullshit, it's finally time; it's finally time to start dealing in assault rifles. I've got a line through my Ukrainian contact on a batch of AKS-74u carbines taken directly from Ukrainian army stores that got here into the Zone. I'm not making the same mistake that I did with the SKS shipment; no fucking cosmoline for me. This is a personal request; bring me all the shit I need to clean them off and I'll start forking them out.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_gunspray"] = 10,
			["value_guncleaner"] = 10,
			["value_lubricant"] = 10,
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

		ix.progression.status["hagglerItemDelivery_2221"].complexData = ix.progression.status["hagglerItemDelivery_2221"].complexData or {}
		ix.progression.status["hagglerItemDelivery_2221"].complexData[item] = ix.progression.status["hagglerItemDelivery_2221"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_2221"].complexData[item] = ix.progression.status["hagglerItemDelivery_2221"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_2221"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_2221"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_2221"].complexData[item] = ix.progression.status["hagglerItemDelivery_2221"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_2221"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "AKS-74u crate just came in from the SBU. I advise you move quick; I've got a feeling these are going to fly off the shelves."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("aks74u", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_2221", true)
			ix.progression.SetActive("hagglerItemDelivery_22211", true) 
		end
	end
})

ix.progression.Register("hagglerItemDelivery_22211", {
	name = "Kitting Up 2.2.2.1.1",
	description = "Help Haggler complete his shop.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["hagglerItemDelivery_22211"] = ix.progression.status["hagglerItemDelivery_22211"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_22211"].complexData

		local itemids = self:GetItemIds()

		local str = "We've had a long and prosperous relationship together, stalker, and I'm running out of room to put things here. I've got one final job from my Ukrainian contacts that I'm wrapping up; this time, ironically enough, the UKM is asking for the cleaning materials. Let them do all the hard work, I say.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_gunspray"] = 30,
			["value_guncleaner"] = 30,
			["value_lubricant"] = 30,
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

		ix.progression.status["hagglerItemDelivery_22211"].complexData = ix.progression.status["hagglerItemDelivery_22211"].complexData or {}
		ix.progression.status["hagglerItemDelivery_22211"].complexData[item] = ix.progression.status["hagglerItemDelivery_22211"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_22211"].complexData[item] = ix.progression.status["hagglerItemDelivery_22211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_22211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_22211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["hagglerItemDelivery_22211"].complexData[item] = ix.progression.status["hagglerItemDelivery_22211"].complexData[item] or 0
			if amt > ix.progression.status["hagglerItemDelivery_22211"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "AKMs are in. This is probably gonna be the best I can do for a long while at least, so come grab them while you can."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("akm", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_22211", true)
			ix.progression.SetActive("hagglerItemDelivery_222111", true) 
		end
	end
})