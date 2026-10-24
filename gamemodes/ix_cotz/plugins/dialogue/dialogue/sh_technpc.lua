DIALOGUE.name = "Technut"

DIALOGUE.addTopic("GREETING", {
	response = "Hello, buddy!",
	options = {
		"TradeTopic",
		"RepairItems",
		"PaintSuit",
		"BackgroundTopic",
		"AboutWorkTopic",
		-- "GetTask",
		"GetTaskByDifficulty",
		"AboutProgression",
		"GOODBYE",
	},
	preCallback = function(self, client, target)
		-- netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"repair", "mechanical",
		-- "electronics"}, 4)
		if SERVER then
			if target:GetNetVar("possibleJobs") == nil then
				local possibleJobs = {}
				possibleJobs["easy"] = { "item_world_NPC_easy" }
				possibleJobs["medium"] = { "item_world_NPC_medium" }
				possibleJobs["hard"] = { "item_world_NPC_hard" }

				target:SetNetVar("possibleJobs", possibleJobs)
			end
		end
	end,
})

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "Absolutely!",
	postCallback = function(self, client, target)
		if SERVER then
			local character = client:GetCharacter()

			target.receivers[#target.receivers + 1] = client

			local items = {}

			-- Only send what is needed.
			for k, v in pairs(target.items) do
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

DIALOGUE.addTopic("RepairItems", {
	statement = "Can you clean my guns, and repair my items?",
	response = "Hoho! Sure! What would you like me to look at?",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	-- ShouldAdd = function(self, client, target) return ix.GetProgression("funy") end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		local items = client:GetCharacter():GetInventory():GetItems()

		for _, v in pairs(items) do
			if v.canRepair then
				if v.isWeapon then
					local percenttorepair = (100 - v:GetData("wear", 100))
					if percenttorepair < 0.5 then
						continue
					end
					local repaircost = math.Round(percenttorepair * v:GetRepairCost())

					table.insert(dynamicOptions, {
						statement = v:GetName()
							.. " ( "
							.. math.Round(v:GetData("wear", 100))
							.. "% Cleanliness ) - "
							.. ix.currency.Get(repaircost),
						topicID = "RepairItems",
						dynamicData = {
							itemuid = v.uniqueID,
							itemID = v:GetID(),
							cost = repaircost,
							type = "wear",
						},
					})
				else
					local percenttorepair = (100 - v:GetData("durability", 100))
					if percenttorepair < 0.5 then
						continue
					end
					local repaircost = math.Round(percenttorepair * v:GetRepairCost())

					table.insert(dynamicOptions, {
						statement = v:GetName()
							.. " ( "
							.. math.Round(v:GetData("durability", 100))
							.. "% Durability ) - "
							.. ix.currency.Get(repaircost),
						topicID = "RepairItems",
						dynamicData = {
							itemuid = v.uniqueID,
							itemID = v:GetID(),
							cost = repaircost,
							type = "durability",
						},
					})
				end
			end
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		-- Return the next topicID
		if not client:GetCharacter():HasMoney(dynamicData.cost) then
			return "NotEnoughMoneyRepair"
		end

		return "ConfirmRepair", dynamicData
	end,
})

DIALOGUE.addTopic("ConfirmRepair", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, player, target, dynamicData)
		if dynamicData then
			if CLIENT then
				self.response = string.format(
					"Jeesh! Fixing that %s will cost you %s, is that a deal?",
					ix.item.list[dynamicData.itemuid].name,
					ix.currency.Get(dynamicData.cost)
				)
			else
				target.repairstruct = { dynamicData.itemid, dynamicData.cost, dynamicData.type }
			end
		end
	end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {
			{
				statement = "That's fine, fix it.",
				topicID = "ConfirmRepair",
				dynamicData = { accepted = true },
			},
			{
				statement = "On second thought...",
				topicID = "ConfirmRepair",
				dynamicData = { accepted = false },
			},
		}

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		if SERVER and dynamicData.accepted then
			ix.dialogue.notifyMoneyLost(client, target.repairstruct[2])
			client:GetCharacter():TakeMoney(target.repairstruct[2])

			ix.item.instances[target.repairstruct[1]]:SetData(target.repairstruct[3], 100)

			if ix.item.instances[target.repairstruct[1]].class then
				local wep = client:GetWeapon(ix.item.instances[target.repairstruct[1]].class)
				if IsValid(wep) then
					wep:SetWeaponWear(100)
				end
			end
		end
		if SERVER then
			target.repairstruct = nil
		end
		-- Return the next topicID

		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneyRepair", {
	statement = "",
	response = "Oh no... You don't have enough money to fix that..",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("PaintSuit", {
	statement = "Can you paint my equipped suit?",
	response = "Absolutely! Which color would you like it to be?",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}
		local items = client:GetCharacter():GetInventory():GetItems()

		for _, v in pairs(items) do
			local paintcost = 100 -- Change to taking from an item maybe?

			if v:GetData("equip") and v.isBodyArmor and v.skincustom then
				for _, v2 in pairs(v.skincustom) do
					table.insert(dynamicOptions, {
						statement = v:GetName()
							.. " ( Current Skin: "
							.. v:GetData("setSkin", 0)
							.. ", New Skin: "
							.. v2.skingroup
							.. " ) - "
							.. ix.currency.Get(paintcost),
						topicID = "PaintSuit",
						dynamicData = {
							itemuid = v.uniqueID,
							itemID = v:GetID(),
							cost = paintcost,
							skin = v2.skingroup,
							preview = false,
						},
					})
				end
			end
		end

		if dynamicOptions ~= {} then
			table.insert(dynamicOptions, 1, {
				statement = "Can I see what the different paints look like?",
				topicID = "PaintSuit",
				dynamicData = { preview = true },
			})
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		if dynamicData.preview then
			return "PaintView"
		end

		-- Return the next topicID
		if not client:GetCharacter():HasMoney(dynamicData.cost) then
			return "NotEnoughMoneyPaint"
		end

		return "ConfirmPaint", dynamicData
	end,
	ShouldAdd = function(self, client, target)
		if ix.progression.IsCompleted(client:GetCharacter(), "technutItemDelivery_SuitPainting") then
			return true
		end
	end,
})

DIALOGUE.addTopic("ConfirmPaint", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, player, target, dynamicData)
		if dynamicData then
			if CLIENT then
				self.response = string.format(
					"Alright friend, painting that %s will cost you %s, is that a a-okay?",
					ix.item.list[dynamicData.itemuid].name,
					ix.currency.Get(dynamicData.cost)
				)
			else
				target.paintstruct = { dynamicData.itemid, dynamicData.cost, dynamicData.skin }
			end
		end
	end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {
			{
				statement = "That's okay, paint it.",
				topicID = "ConfirmPaint",
				dynamicData = { accepted = true },
			},
			{
				statement = "On second thought...",
				topicID = "ConfirmPaint",
				dynamicData = { accepted = false },
			},
		}

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		if SERVER and dynamicData.accepted then
			ix.dialogue.notifyMoneyLost(client, target.paintstruct[2])
			client:GetCharacter():TakeMoney(target.paintstruct[2])

			client:SetSkin(target.paintstruct[3])
			ix.item.instances[target.paintstruct[1]]:SetData("setSkin", target.paintstruct[3])
		end
		if SERVER then
			target.paintstruct = nil
		end
		-- Return the next topicID

		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneyPaint", {
	statement = "",
	response = "My painting services are not free, you know?",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("AboutWorkTopic", {
	statement = "About work...",
	response = "",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		if client:ixHasJobFromNPC(target:GetDisplayName()) then
			local jobs = client:GetCharacter():GetJobs()

			-- If it's an item delivery quest
			local itemuid = ix.jobs.isItemJob(jobs[target:GetDisplayName()].identifier)

			if itemuid and not jobs[target:GetDisplayName()].isCompleted then
				dynamicOptions = {
					{
						statement = string.format("Hand over 1 %s", ix.item.list[itemuid].name),
						topicID = "AboutWorkTopic",
						dynamicData = { identifier = itemuid },
					},
				}
			end
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	preCallback = function(self, client, target)
		if client:ixHasJobFromNPC(target:GetDisplayName()) then
			local jobs = client:GetCharacter():GetJobs()
			if jobs[target:GetDisplayName()].isCompleted then
				if SERVER then
					ix.dialogue.notifyTaskComplete(
						client,
						ix.jobs.getFormattedName(jobs[target:GetDisplayName()])
					)
					client:ixJobComplete(target:GetDisplayName())
				end
				if CLIENT then
					self.response = "Very nice! This is for you, for your efforts."
				end
			else
				if CLIENT then
					self.response = string.format(
						"Have you finished %s yet?",
						ix.jobs.getFormattedName(jobs[target:GetDisplayName()])
					)
				end
			end
		else
			if CLIENT then
				self.response = "Uhh... I haven't talked to you about any tasks?"
			end
		end
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		netstream.Start("job_deliveritem", target:GetDisplayName())

		-- Return the next topicID

		return "BackTopic"
	end,
	ShouldAdd = function(self, client, target)
		if LocalPlayer():GetCharacter():GetJobs()["'Technut'"] then
			return true
		end
	end,
})

DIALOGUE.addTopic("ConfirmTask", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, player, target, dynamicData)
		if dynamicData then
			if CLIENT then
				self.response = dynamicData.description
			else
				target.taskid = dynamicData.identifier
			end
		end
	end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {
			{ statement = "I'll take it", topicID = "ConfirmTask", dynamicData = { accepted = true } },
			{ statement = "I'll pass", topicID = "ConfirmTask", dynamicData = { accepted = false } },
		}
		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		if SERVER then
			if dynamicData.accepted then
				if not ix.jobs.NPCHasJob(target:GetDisplayName(), target.taskid) then
					client:Notify("Task was taken by somebody else!")
				else
					ix.dialogue.notifyTaskGet(client, ix.jobs.getFormattedNameInactive(target.taskid))

					client:ixJobAdd(target.taskid, target:GetDisplayName())

					ix.jobs.setNPCJobTaken(target:GetDisplayName(), target.taskid)
				end
			end

			target.taskid = nil
		end

		-- Return the next topicID

		return "BackTopic"
	end,
})

DIALOGUE.addTopic("GetTask", {
	statement = "Do you have any work for me?",
	response = "I do, actually. Check this out.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if client:ixHasJobFromNPC(target:GetDisplayName()) and CLIENT then
			self.response = "You already have a task, which isn't completed yet..."
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		if not client:ixHasJobFromNPC(target:GetDisplayName()) then
			local jobs = target:GetNetVar("jobs")

			for _, v in pairs(jobs) do
				table.insert(dynamicOptions, {
					statement = ix.jobs.getFormattedNameInactive(v),
					topicID = "GetTask",
					dynamicData = { identifier = v },
				})
			end
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		-- Return the next topicID

		return "ConfirmTask",
			{
				description = ix.jobs.getFormattedDescInactive(dynamicData.identifier),
				identifier = dynamicData.identifier,
			}
	end,
	ShouldAdd = function(self, client, target)
		if not LocalPlayer():GetCharacter():GetJobs()["'Technut'"] then
			return true
		end
	end,
})

DIALOGUE.addTopic("GetTaskByDifficulty", {
	statement = "Do you have any work for me?",
	response = "Yes, what difficulty task are you looking for?.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if client:ixHasJobFromNPC(target:GetDisplayName()) and CLIENT then
			self.response = "I already gave you some work."
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		if not client:ixHasJobFromNPC(target:GetDisplayName()) then
			table.insert(dynamicOptions, {
				statement = "A trivial task.",
				topicID = "GetTaskByDifficulty",
				dynamicData = { difficulty = "easy" },
			})
			table.insert(dynamicOptions, {
				statement = "A challenging task.",
				topicID = "GetTaskByDifficulty",
				dynamicData = { difficulty = "medium" },
			})
			table.insert(dynamicOptions, {
				statement = "A hard task.",
				topicID = "GetTaskByDifficulty",
				dynamicData = { difficulty = "hard" },
			})
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		if SERVER then
			local possibleJobs = target:GetNetVar("possibleJobs")
			local jobCategories = table.Random(possibleJobs[dynamicData.difficulty])
			local jobid = ix.jobs.getJobFromCategory(jobCategories)

			if not client:ixJobAdd(jobid, target:GetDisplayName()) then
				return "BackTopic", dynamicOptions
			end
			ix.dialogue.notifyTaskGet(client, ix.jobs.getFormattedNameInactive(jobid))
			ix.jobs.setNPCJobTaken(target:GetDisplayName(), jobid)
		end

		-- Return the next topicID

		return "BackTopic", dynamicOptions
	end,
	ShouldAdd = function(self, client, target)
		if not LocalPlayer():GetCharacter():GetJobs()["'Technut'"] then
			return true
		end
	end,
})

DIALOGUE.addTopic("HandInComplexProgressionItemTopic", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	options = { "BackTopic" },
	DynamicPreCallback = function(self, player, target, dynamicData)
		if SERVER and istable(dynamicData) then
			ix.progression.TurnIn(player, target, dynamicData.progid, dynamicData.itemid)
		elseif CLIENT then
			self.response = "Let me check what you have brought."
		end
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
		local dynamicOptions = {}

		-- disgusting
		-- local identifier = player:GetCharacter():GetData("curdialogprog")
		local identifier = self.tmp
		self.tmp = nil
		local progressionStatus = ix.progression.GetComplexProgressionValue(client:GetCharacter(), identifier)
		local definition = ix.progression.definitions[identifier]
		if definition.GetItemIds then
			local progitems = definition.GetItemIds()
			local missingitems = {}

			for progitem, cnt in pairs(progitems) do
				local curcnt = 0
				if progressionStatus and progressionStatus[progitem] then
					curcnt = progressionStatus[progitem]
				end

				if curcnt < cnt and client:GetCharacter():GetInventory():HasItem(progitem) then
					table.insert(missingitems, progitem)
				end
			end

			for _, progitem in pairs(missingitems) do
				table.insert(dynamicOptions, {
					statement = "Hand over " .. ix.item.list[progitem].name,
					topicID = "ViewProgression",
					dynamicData = { progressionID = identifier, itemID = progitem },
				})
			end
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
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

				if definition.GetItemIds then
					progressionStatus = ix.progression.GetComplexProgressionValue(
						player:GetCharacter(),
						dynamicData.identifier
					)
				end

				self.response = definition:BuildResponse(target:GetDisplayName(), progressionStatus)
				self.tmp = dynamicData.identifier
			end
		end
	end,
})

DIALOGUE.addTopic("AboutProgression", {
	statement = "What do you need help with?",
	response = "I have a few things I need done.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			if #ix.progression.GetActiveProgressions(client:GetCharacter(), "'Technut'") <= 0 then
				self.response = "Nothing at the moment."
			end
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		for _, progressionID in
			pairs(ix.progression.GetActiveProgressions(client:GetCharacter(), "'Technut'"))
		do
			table.insert(dynamicOptions, {
				statement = ix.progression.definitions[progressionID].name,
				topicID = "AboutProgression",
				dynamicData = { identifier = progressionID },
			})
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		-- Return the next topicID

		return "ViewProgression", dynamicData
	end,
	ShouldAdd = function(self, client, target)
		return #ix.progression.GetActiveProgressions(client:GetCharacter(), "'Technut'") > 0
	end,
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = "Hoho! Well, what is there to say? I live here, after... Well, deserting!",
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Really? Is that so?",
	response = (
		"Yeah, it happened back in 2007, after the first incident "
		.. "we were all cut off, I didn't want to stick any longer "
		.. "so I left."
	),
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "Sorry to hear that...",
	response = "Dont worry about it. Anything else?",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about another topic.",
	response = "Don't worry about it. Anything else?",
	options = {
		"TradeTopic",
		"RepairItems",
		"PaintSuit",
		"BackgroundTopic",
		"AboutWorkTopic",
		-- "GetTask",
		"GetTaskByDifficulty",
		"AboutProgression",
		"GOODBYE",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("PaintView", {
	statement = "Can I see what the different paints look like?",
	response = "Sure, sure! Take a look.",
	options = {
		"PaintSuit",
		"BackTopic",
	},
	postCallback = function(self, client, target)
		if CLIENT then
			previewBackground = vgui.Create("DFrame")
			previewBackground:SetSize(ScrW(), ScrH())
			previewBackground:SetTitle("")
			previewBackground:ShowCloseButton(false)

			previewBackground.Paint = function(panel, w, h)
				ix.util.DrawBlur(panel, 10)
			end

			previewSkins = vgui.Create("DFrame")
			previewSkins:SetSize(500, 900)
			previewSkins:SetPos(ScrW() / 2 - 250, ScrH() / 2 - 450)
			previewSkins:SetTitle("")

			function previewSkins:OnClose()
				previewBackground:Close()
			end

			local playermodel = LocalPlayer():GetModel()
			local skincount = LocalPlayer():SkinCount() - 2
			local bodygroups = LocalPlayer():GetBodyGroups()
			local mdl = previewSkins:Add("DModelPanel")
			mdl:Dock(FILL)
			mdl:SetFOV(36)
			mdl:SetCamPos(Vector(95, 0, 60))
			mdl:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
			mdl:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
			mdl:SetAmbientLight(Vector(-64, -64, -64))
			mdl:SetAnimated(true)
			mdl:SetLookAt(Vector(-100, 0, 10))
			mdl:SetModel(playermodel)
			local ent = mdl:GetEntity()
			mdl.Angles = Angle(0, 0, 0)
			local sheet = previewSkins:Add("DPropertySheet")
			sheet:Dock(BOTTOM)
			sheet:SetSize(0, 200)
			local bgpanel = previewSkins:Add("DPanel")
			bgpanel:DockPadding(8, 8, 8, 8)
			local bgpanelcontrols = bgpanel:Add("DScrollPanel")
			bgpanelcontrols:Dock(FILL)

			if skincount > 0 then
				local skinslider = bgpanelcontrols:Add("DNumSlider")
				local curskin = LocalPlayer():GetSkin()
				ent:SetSkin(curskin)
				skinslider:Dock(TOP)
				skinslider:DockMargin(0, 0, 0, 5)
				skinslider:SetText("Skin")
				skinslider:SetMin(0)
				skinslider:SetMax(skincount + 1)
				skinslider:SetDecimals(0)
				skinslider:SetValue(curskin)

				function skinslider:OnValueChanged(value)
					local val = math.Round(value)
					ent:SetSkin(val)
				end
			end

			for _, v in ipairs(bodygroups) do
				local curbg = LocalPlayer():GetBodygroup(v.id)

				ent:SetBodygroup(v.id, curbg)
			end

			local bgtab = sheet:AddSheet("Inspect Skins", bgpanel, "icon16/cog.png")

			function mdl:DragMousePress()
				self.PressX, self.PressY = gui.MousePos()
				self.Pressed = true
			end

			function mdl:DragMouseRelease()
				self.Pressed = false
			end

			function mdl:LayoutEntity(ent)
				if self.bAnimated then
					self:RunAnimation()
				end

				if self.Pressed then
					local mx, my = gui.MousePos()
					self.Angles = self.Angles - Angle(0, (self.PressX or mx) - mx, 0)
					self.PressX, self.PressY = gui.MousePos()
				end

				ent:SetAngles(self.Angles)
			end
		end
	end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll talk to you later.",
	response = "Hey, come back soon!",
})
