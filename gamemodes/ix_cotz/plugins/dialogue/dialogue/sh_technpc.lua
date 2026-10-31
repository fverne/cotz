DIALOGUE.name = "Technut"
DIALOGUE.townContact = "technut"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Absolutely!")

DIALOGUE.addTopic("GREETING", {
	response = "Hello, buddy!",
	options = {
		"TradeTopic",
		"RepairItems",
		"PaintSuit",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
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
		return ix.progression.GetRepairOptions(client, target)
	end,
	ResolveDynamicOption = function(self, client, target, data)
		return ix.progression.ResolveServiceOffer(client, target, "repair", data)
	end,
})

DIALOGUE.addTopic("ConfirmRepair", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, client, target, data)
		ix.progression.ConfirmService(self, client, target, "repair", data)
	end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {
			{
				statement = "That's fine, fix it.",
				topicID = "ConfirmRepair",
				dyndata = { accepted = true },
			},
			{
				statement = "On second thought...",
				topicID = "ConfirmRepair",
				dyndata = { accepted = false },
			},
		}

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, data)
		if SERVER then
			local accepted = type(data) == "table" and data.accepted == true
			local completed = ix.progression.ExecuteService(client, target, "repair", accepted)
			if accepted and not completed then
				client:Notify("That service could not be completed. Please request a fresh quote.")
			end
		end

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
						dyndata = {
							itemuid = v.uniqueID,
							itemid = v:GetID(),
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
				dyndata = { preview = true },
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
		if ix.progression.IsCompleted(client:GetCharacter(), "cotz/town/technut/TN13") then
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
				dyndata = { accepted = true },
			},
			{
				statement = "On second thought...",
				topicID = "ConfirmPaint",
				dyndata = { accepted = false },
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
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
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
