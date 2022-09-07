--[[
	ix.progression.Register("EcologistResearchMutant", {
		name : Pretty name
		description : Describes the progression
		progressfunctions : table of
			progressfunction {
				OnRun : Function to run when this progress is reached
				RunOnce : Only run this function a single time, ever
			}
		progressthresholds : Table of values denoting how much progress has to be made to get to each level
	})
]]--

hook.Add("ix_OnJobComplete", "OldTimer_oldTimerKillIntro", function(client, npcidentifier, identifier)
	local iscorrecttasktype = false

	local killcategories = {
		["mutantkillgroupeasy"] = true,
		["mutantkillgroupmedium"] = true,
		["mutantkillgrouphard"] = true,
		["mutantkilleasy"] = true,
		["mutantkillmedium"] = true,
		["mutantkillhard"] = true,
	}

	for k, v in pairs(ix.jobs.list[identifier].categories) do
		if killcategories[v] then iscorrecttasktype = true end
	end

	if npcidentifier == "'Old Timer'" and iscorrecttasktype then
		if ix.progression.IsActive("oldTimerKillIntro") then
			ix.progression.AddProgessionValue("oldTimerKillIntro", 1, client:Name())
		end
	end
end)

hook.Add("ix_OnJobComplete", "CookNPC_cookMeatCollect", function(client, npcidentifier, identifier)
	local iscorrecttasktype = false

	local categories = {
		["mutantmeateasy"] = true,
		["mutantmeatmedium"] = true,
		["mutantmeathard"] = true,
	}

	for k, v in pairs(ix.jobs.list[identifier].categories) do
		if categories[v] then iscorrecttasktype = true end
	end

	if npcidentifier == "'Spicy Lemon'" and iscorrecttasktype then
		if ix.progression.IsActive("cookMeatCollect") then
			ix.progression.AddProgessionValue("cookMeatCollect", 1, client:Name())
		end
	end
end)

hook.Add("ix_OnJobComplete", "Mute_scanTasks", function(client, npcidentifier, identifier)
	local iscorrecttasktype = false

	local killcategories = {
		["scanareaeasy"] = true,
		["scanareamed"] = true,
		["scanareahigh"] = true,
	}

	for k, v in pairs(ix.jobs.list[identifier].categories) do
		if killcategories[v] then iscorrecttasktype = true end
	end

	if npcidentifier == "'Mute'" and iscorrecttasktype then
		if ix.progression.IsActive("stalkerNetAdmin_AreaTasks") then
			ix.progression.AddProgessionValue("stalkerNetAdmin_AreaTasks", 1, client:Name())
		end
	end
end)

ix.progression.Register("oldTimerKillIntro", {
	name = "Cleaning up the Zone",
	description = "Cleaning up the zone",
	keyNpc = "'Old Timer'",
	defaultActive = true,
	BuildResponse = function(self, status)
		-- Find next treshold
		local tresh = 0

		for k,v in ipairs( self.progressthresholds ) do
			if v > status.value then
				tresh = v
				break
			end
		end

		return string.format("I need you to complete mutant kill tasks for me, %d tasks should do. This will allow us to get better supply lines, and make sure we wont get killed in our sleep by a wild dog.", tresh-status.value)
	end,
	progressfunctions = {
		[1] = {
			OnRun = function()			
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Good job, you've lowered the mutant population a bit, and as such we've gained a slight foothold in the zone. Come have a chat, I have a new task for you all."
				})
				
				-- Unlock next step in progression
				ix.progression.SetActive("oldTimerItemDelivery_mainMeat", true)
			end,
			RunOnce = true
		},
		[2] = { -- runs at the same time as [1]
			OnRun = function()
				ix.util.SpawnAdvDupe2Dupe( "prog_oldtimer_1" )
			end,
			RunOnce = false
		},
		[3] = {
			OnRun = function()

				local npc = ix.progression.GetNPCFromName("'Old Timer'")
				if (npc) then
					npc:AddItemToList("medic_medkit_1", nil, 4, "SELLANDBUY", 4, 1, 4)
					npc:AddItemToList("medic_medkit_2", nil, 4, "SELLANDBUY", 4, 1, 4)
					npc:AddItemToList("medic_bandage_2", nil, 8, "SELLANDBUY", 4, 1, 4)
				end

				

				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Due to your extraordinary efforts in killing mutants, I have secured some supply lines to import medical supplies from leftover army supplies they don't need anymore."
				})
			end,
			RunOnce = true
		},
		[4] = { -- runs at the same time as [3]
			OnRun = function()
				ix.util.SpawnAdvDupe2Dupe( "prog_oldtimer_2" )
			end,
			RunOnce = false
		},
		[5] = {
			OnRun = function()
				local npc = ix.progression.GetNPCFromName("'Old Timer'")
				if (npc) then
					npc:AddItemToList("medic_medkit_3", nil, 4, "SELLANDBUY", 4, 1, 4)
					npc:AddItemToList("medic_bandage_3", nil, 4, "SELLANDBUY", 4, 1, 4)
				end

				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Lovely work everyone, thanks to your dilligence in clearing out the swamps, one of my associates have agreed to ship in a wider variety of medical supplies, feel free to come check my wares."
				})
				ix.progression.SetActive("oldTimerKillIntro", false)
			end,
			RunOnce = true
		},
		[6] = { -- runs at the same time as [5]
			OnRun = function()
				ix.util.SpawnAdvDupe2Dupe( "prog_oldtimer_3" )
			end,
			RunOnce = false
		},
	},
	progressthresholds = {
		[1] = 30,
		[2] = 30, -- just for the dupe spawning
		[3] = 55,
		[4] = 55,
		[5] = 110,
		[6] = 110
	}
})

ix.progression.Register("oldTimerItemDelivery_mainMeat", {
	name = "Feeding the Hungry",
	description = "Collecting lots of meat for the Old Timer.",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["oldTimerItemDelivery_mainMeat"] = ix.progression.status["oldTimerItemDelivery_mainMeat"] or {}
		local dat = ix.progression.status["oldTimerItemDelivery_mainMeat"].complexData
		local itemids = self:GetItemIds()

		local str = "So, we're in need of a lot of food if we want to stay alive out here, especially with this many people around. So, here's what we need to feed everyone for a while:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d pieces of %s", amt - tmp, ix.item.list[item].name)
		end

		local str = str.."\n\nSo I need you to get out there and hunt some mutated animals. We have enough canned food for a couple days, but we have a lot of mouths to feed, and it wont last long."

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["meat_blinddog"] = 50,
			["part_blinddog"] 	= 15,
			["meat_cat"] 	= 20,
			["part_cat"] 	= 5,
			["meat_tushkano"] 	= 80,
			["part_tushkano"] 	= 30,
			["meat_boar"] = 40,
			["part_boar"] = 10
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
		ix.progression.status["oldTimerItemDelivery_mainMeat"].complexData = ix.progression.status["oldTimerItemDelivery_mainMeat"].complexData or {}
		ix.progression.status["oldTimerItemDelivery_mainMeat"].complexData[dat] = ix.progression.status["oldTimerItemDelivery_mainMeat"].complexData[dat] or 0
		ix.progression.status["oldTimerItemDelivery_mainMeat"].complexData[dat] = ix.progression.status["oldTimerItemDelivery_mainMeat"].complexData[dat]+1
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["oldTimerItemDelivery_mainMeat"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["oldTimerItemDelivery_mainMeat"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["oldTimerItemDelivery_mainMeat"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(5, function()
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "We're good on food, for now. To everyone that contributed, great work. Go say hi to my old friend 'Spicy Lemon', he's here to help cook all the food you've worked so hard for."
				})
			end)

			timer.Simple(15, function()
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Spicy Lemon'",
					message = "Hello everyone, please bring me all your food, I'll cook you the finest delicacies."
				})
			end)

			timer.Simple(30, function()
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Technut'",
					message = "Everyone, come in. I need some help with one of my projects, find me in my cabin."
				})

			end)
			
			local pos = Vector(-6126.198730, -9746.725586, 4959.031250)
			local ang = Angle(0.000, -178.989, 0.000)
			ix.util.SpawnAdvVendor("cooknpc", pos, ang)


			ix.progression.SetActive("oldTimerItemDelivery_mainMeat", false)
			ix.progression.SetActive("technutItemDelivery_Main", true) -- Main progression

			ix.progression.SetActive("spicyLemon_cookMeatCollect", true) -- Side Progression
		end
	end
})


ix.progression.Register("technutItemDelivery_Main", {
	name = "Technut's Radio Project",
	description = "Collecting important components for Technut.",
	keyNpc = "'Technut'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["technutItemDelivery_Main"] = ix.progression.status["technutItemDelivery_Main"] or {}
		local dat = ix.progression.status["technutItemDelivery_Main"].complexData
		local itemids = self:GetItemIds()

		local str = "I'm currently working on setting up rudimentary radiocommunications, because I just lost contact with my last runner that I sent off a couple of days ago, and it is simply not sustainable to send people to their deaths over and over again just to deliver a message that could have been transmitted easily through the airwaves. Anyways, here's a list of what I need:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%s: %d", ix.item.list[item].name, amt - tmp)
		end

		str = str.."\n\nHope you can help me soon, noone wants to take up the job as messenger anymore."

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_wirelesstrans"] = 15,
			["value_wire_heavy"] 	= 30,
			["value_tape_duct"] 	= 10,
			["value_capacitors"] 	= 100,
			["value_sparkplug"] 	= 10,
			["value_carbattery"] 	= 5,
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
		ix.progression.status["technutItemDelivery_Main"].complexData = ix.progression.status["technutItemDelivery_Main"].complexData or {}
		ix.progression.status["technutItemDelivery_Main"].complexData[dat] = ix.progression.status["technutItemDelivery_Main"].complexData[dat] or 0
		ix.progression.status["technutItemDelivery_Main"].complexData[dat] = ix.progression.status["technutItemDelivery_Main"].complexData[dat]+1
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Main"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Main"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Main"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then
			--Spawn STALKERNETAdmin
			timer.Simple(15, function()
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Technut'",
					message = "Thank you all for your help with my radio project, my messages are finally getting through. I managed to strike a deal with some people I know, and they'll supply me with military grade fabrics and plates."
				})
			end)

			timer.Simple(45, function()
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Hello everyone, the new radio equipment gave me an idea. Come see me, maybe we can work something out."
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Technut'")
			if (npc) then
				npc:AddItemToList("steelplate_1", nil, 1, "SELLANDBUY", 1, 3, 1)
				npc:AddItemToList("ceramicplate_1", nil, 1, "SELLANDBUY", 1, 3, 1)
				npc:AddItemToList("fabricplate_1", nil, 1, "SELLANDBUY", 1, 3, 1)
			end

			ix.progression.SetActive("technutItemDelivery_Main", false)

			ix.progression.SetActive("oldTimerItemDelivery_mainStatue", true) -- Main Progression
		end
	end
})

ix.progression.Register("oldTimerItemDelivery_mainStatue", {
	name = "Enticing the Specialist",
	description = "Collecting statues for Old Timer.",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["oldTimerItemDelivery_mainStatue"] = ix.progression.status["oldTimerItemDelivery_mainStatue"] or {}
		local dat = ix.progression.status["oldTimerItemDelivery_mainStatue"].complexData
		local itemids = self:GetItemIds()

		local str = "Great work on Technut's little project, but it got me thinking. No offense to Technut, but he's more of a mechanical guy, his radio system is never going to reach very far. I got an old friend that is extremly knowledgeable in these things, but he's a bit of an oddball. He has a fascination with statuettes of animals made by a certain factory nearby. So, I'm going to need you to collect some of these statues:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%s: %d", ix.item.list[item].name, amt - tmp)
		end

		str = str.."\n\nWith his help we can get a lot more information in and out of the zone."

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_statue_cat"] = 20,
			["value_statue_lion"] 	= 15,
			["value_statue_horse"] 	= 10,
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
		ix.progression.status["oldTimerItemDelivery_mainStatue"].complexData = ix.progression.status["oldTimerItemDelivery_mainStatue"].complexData or {}
		ix.progression.status["oldTimerItemDelivery_mainStatue"].complexData[dat] = ix.progression.status["oldTimerItemDelivery_mainStatue"].complexData[dat] or 0
		ix.progression.status["oldTimerItemDelivery_mainStatue"].complexData[dat] = ix.progression.status["oldTimerItemDelivery_mainStatue"].complexData[dat]+1
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["oldTimerItemDelivery_mainStatue"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["oldTimerItemDelivery_mainStatue"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["oldTimerItemDelivery_mainStatue"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then
			
			timer.Simple(15, function()
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Arrangements have been made, and my good friend, you can call him 'Mute', has arrived. He's a bit eccentric, so keep that in mind."
				})
			end)

			timer.Simple(45, function()
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Mute'",
					message = "Come see me. I need help with something. -Mute"
				})
			end)

			-- Needs dupe setup to be done
			--ix.util.SpawnAdvDupe2Dupe( "prog_mute_1" ) 

			-- Needs correct pos/ang set
			--local pos = Vector(-6126.198730, -9746.725586, 4959.031250)
			--local ang = Angle(0.000, -178.989, 0.000)
			--ix.util.SpawnAdvVendor("stalkernetadmin", pos, ang)

			ix.progression.SetActive("oldTimerItemDelivery_mainStatue", false)

			ix.progression.SetActive("stalkerNetAdmin_AreaTasks", true) -- Main Progression
		end
	end
})

ix.progression.Register("stalkerNetAdmin_AreaTasks", {
	name = "Scanning the Zone",
	description = "Scanning the Zone",
	keyNpc = "'Mute'",
	defaultActive = true,
	BuildResponse = function(self, status)
		-- Find next treshold
		local tresh = 0

		for k,v in ipairs( self.progressthresholds ) do
			if v > status.value then
				tresh = v
				break
			end
		end

		return string.format("** The man gestures at a scanning device behind him, and writes down the number %d on a piece of paper. **.", tresh-status.value)
	end,
	progressfunctions = {
		[1] = {
			OnRun = function()			
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Mute'",
					message = "Thanks for the help with the scanning, please keep it up. Come talk to me, I'll instruct you in what I will need in the future. -Mute"
				})
				
				ix.progression.SetActive("stalkerNetAdmin_AreaTasks", false)

				ix.progression.SetActive("oldTimerItemDelivery_mainMeat", true) -- Main Progression
			end,
			RunOnce = true
		},
	},
	progressthresholds = {
		[1] = 40,
	}
})

ix.progression.Register("stalkerNetAdminDelivery_mainRadioTower", {
	name = "Proper Radio Tower",
	description = "Helping to build a true radiocommunications center.",
	keyNpc = "'Mute'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["stalkerNetAdminDelivery_mainRadioTower"] = ix.progression.status["stalkerNetAdminDelivery_mainRadioTower"] or {}
		local dat = ix.progression.status["stalkerNetAdminDelivery_mainRadioTower"].complexData
		local itemids = self:GetItemIds()

		local str = "** The man looks around erratically, points at a schematic of what looks to be a large radio antenna, and then points to a piece of paper with a list: **\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%s: %d", ix.item.list[item].name, amt - tmp)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_pcpart_fpga"] 	= 10,
			["value_tape_electric"] = 80,
			["value_pcpart_gpu"] 	= 5,
			["value_pcpart_psu"] 	= 10,
			["value_wire_light"]	= 120
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
		ix.progression.status["stalkerNetAdminDelivery_mainRadioTower"].complexData = ix.progression.status["stalkerNetAdminDelivery_mainRadioTower"].complexData or {}
		ix.progression.status["stalkerNetAdminDelivery_mainRadioTower"].complexData[dat] = ix.progression.status["stalkerNetAdminDelivery_mainRadioTower"].complexData[dat] or 0
		ix.progression.status["stalkerNetAdminDelivery_mainRadioTower"].complexData[dat] = ix.progression.status["stalkerNetAdminDelivery_mainRadioTower"].complexData[dat]+1
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["stalkerNetAdminDelivery_mainRadioTower"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["stalkerNetAdminDelivery_mainRadioTower"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["stalkerNetAdminDelivery_mainRadioTower"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then
			
			timer.Simple(45, function()
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Mute'",
					message = "I got some correspondence with a guy in a deeper territory, he calls himself 'Quartermaster'. We need his help arming ourselves. Please go see what he needs before he'll help us. -Mute"
				})
			end)

			-- Add quest item to vendor list that lets players activate next progression step at quartermaster on map2
			local npc = ix.progression.GetNPCFromName("'Mute'")
			if (npc) then
				npc:AddItemToList("quest_flashdrive", nil, 1, "SELLANDBUY", 1, 3, 1) -- Main Progression
			end

			timer.Simple(90, function()
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Haggler'",
					message = "Hello everyone! I see you're all doing quite well for yourselves. I have some wares if you got the cash."
				})
			end)
			-- Needs correct pos/ang set
			--local pos = Vector(-6126.198730, -9746.725586, 4959.031250)
			--local ang = Angle(0.000, -178.989, 0.000)
			--ix.util.SpawnAdvVendor("tradernpc", pos, ang)

			ix.progression.SetActive("stalkerNetAdminDelivery_mainRadioTower", false)

			
		end
	end
})

ix.progression.Register("quarterMasterDelivery_activateItem", {
	name = "Making Connections",
	description = "Bring the flash drive to Quartermaster.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		return "I chatted with a guy, what was his name, Mute? He should have a flash drive with information for me. I ain't budging 'till I get that.\n"
	end,
	GetItemIds = function()
		local itemids = {
			["quest_flashdrive"] 	= 1,
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
		ix.progression.status["quarterMasterDelivery_activateItem"].complexData = ix.progression.status["quarterMasterDelivery_activateItem"].complexData or {}
		ix.progression.status["quarterMasterDelivery_activateItem"].complexData[dat] = ix.progression.status["quarterMasterDelivery_activateItem"].complexData[dat] or 0
		ix.progression.status["quarterMasterDelivery_activateItem"].complexData[dat] = ix.progression.status["quarterMasterDelivery_activateItem"].complexData[dat]+1
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quarterMasterDelivery_activateItem"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quarterMasterDelivery_activateItem"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quarterMasterDelivery_activateItem"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then
			
			timer.Simple(5, function()
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Quartermaster'",
					message = "Alright, we can talk business, come over here."
				})
			end)

			ix.progression.SetActive("quarterMasterDelivery_activateItem", false)

			ix.progression.SetActive("quarterMasterDelivery_main", true) -- Main Progression
		end
	end
})

ix.progression.Register("quarterMasterDelivery_main", {
	name = "Whetting the Whistle",
	description = "Bring Quartermaster something to drink.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quarterMasterDelivery_main"] = ix.progression.status["quarterMasterDelivery_main"] or {}
		local dat = ix.progression.status["quarterMasterDelivery_main"].complexData
		local itemids = self:GetItemIds()

		local str = "Alright boys, lets see some hands, who likes booze? That's right, I do. I'm gonna need you to find some stuff to drink, and smoke. I made a little list for you so you wont forget:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		str = str.."\n\nNow chop-chop, get going, that booze isn't gonna find itself."

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["drink_spirits_3"] 	= 10,
			["drink_vodka_5"] 		= 10,
			["drink_vodka_6"] 		= 10,
			["drug_cigar"] 			= 40,
			["drug_cocaine"] 		= 5,
			["drug_cigarette_5"] 	= 30,
			["drug_cigarette_6"] 	= 30,
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
		ix.progression.status["quarterMasterDelivery_main"].complexData = ix.progression.status["quarterMasterDelivery_main"].complexData or {}
		ix.progression.status["quarterMasterDelivery_main"].complexData[dat] = ix.progression.status["quarterMasterDelivery_main"].complexData[dat] or 0
		ix.progression.status["quarterMasterDelivery_main"].complexData[dat] = ix.progression.status["quarterMasterDelivery_main"].complexData[dat]+1
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quarterMasterDelivery_main"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quarterMasterDelivery_main"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quarterMasterDelivery_main"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then
			
			timer.Simple(5, function()
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Quartermaster'",
					message = "Thanks for the booze, I got keycards for the bunker for sale, if you got the cash for it."
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("accesscard_ecologists", nil, 5, "SELLANDBUY", 5, 3, 5) -- Main Progression
			end

			ix.progression.SetActive("quarterMasterDelivery_main", false)

			ix.progression.SetActive("egghead_dataTasks", true) -- Main Progression
		end
	end
})

ix.progression.Register("egghead_dataTasks", {
	name = "Extracting Information",
	description = "Scanning the Zone",
	keyNpc = "'Egghead'",
	defaultActive = true,
	BuildResponse = function(self, status)
		-- Find next treshold
		local tresh = 0

		for k,v in ipairs( self.progressthresholds ) do
			if v > status.value then
				tresh = v
				break
			end
		end

		return string.format("You'll need to complete %d contracts relating to extracting data from computers in the old underground complexes around the zone.", tresh-status.value)
	end,
	progressfunctions = {
		[1] = {
			OnRun = function()			
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Egghead'",
					message = "Good work stalkers, you've gotten me a lot of interesting information, I think I might have an idea what has happened here, please come to the bunker for further jobs."
				})

				-- Add computer activation item to vendorlist here
			end,
			RunOnce = true
		},
	},
	progressthresholds = {
		[1] = 100,
	}
})