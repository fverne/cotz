DIALOGUE.name = "Technut"
DIALOGUE.townContact = "technut"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Let's see what you have for trade.",
	"Certainly, buddy. Give me a moment to put the unfinished bits out of your way."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello, buddy! Mind that loose lead. I know precisely where it belongs; the rest of the bench is still under discussion. What have you brought?",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"RepairItems",
		"PaintSuit",
		"CustomizeGear",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("CustomizeGear", {
	statement = "Can you change the finish on my equipped gear?",
	response = "Yes! Keep it equipped and we'll look at the finishes available. You can decide before anything's changed.",
	options = {"BackTopic"},
	preCallback = function(self, client, target)
		local customization = ix.plugin.Get("gearcustomization")
		if SERVER and customization then customization:Open(client, target) end
	end,
	ShouldAdd = function()
		return ix.plugin.Get("gearcustomization") ~= nil and ix.pac ~= nil
	end,
})

DIALOGUE.addTopic("RepairItems", {
	statement = "Can you repair my equipment or clean my weapons?",
	response = "Let's have a look. Tell me what needs attention; I'll show you the work and the price.",
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
	response = "You're short for that repair, buddy. Leave that one for now.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("PaintSuit", {
	statement = "Can you repaint my equipped suit?",
	response = "Certainly. Let's see which colours that suit can take.",
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
					"Painting the %s will cost %s, buddy. Do you want to go ahead?",
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
	response = "Not quite enough to cover the painting. The colour can wait, buddy.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "What did you do before you opened the workshop?",
	response = "Army work. Left in 2007, after we were cut off. Deserted. I can say the word; it doesn't explain the whole day. I wanted out and found a way. Here someone puts a broken thing on the bench and I get to make myself useful with my hands. I like the questions a repair gives me. What moved, what wore through, why the owner kept pushing that button. Easier questions to keep company with.",
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Do people here know about that?",
	response = "Some. If they ask, I tell them. Then Gasket arrives wanting the parts I borrowed, and we return to an argument I can actually finish. Well, finish my side of. He'd like to see the assembled result before considering the subject closed. Fair enough. I've promised him rather a lot of assembled results.",
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "We can talk about the workshop instead.",
	response = "Gladly. There's something on practically every inch of it I'd enjoy discussing.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Go on. If I keep turning this over, I'm still listening.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"RepairItems",
		"PaintSuit",
		"CustomizeGear",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("PaintView", {
	statement = "Can I preview the suit colours?",
	response = "Here we are. Have a look before you make up your mind.",
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
	statement = "I'll let you get back to the bench.",
	response = "See you, buddy. If you remember what it was doing before it failed, come and tell me. Those details keep me entertained.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "How do you decide an improvement is finished?",
	response = "The sensible answer involves the owner needing the thing back. I can go on finding another adjustment indefinitely. Something comes back from an anomaly field held together with wire, and immediately I want to understand every turn of the wire. Its owner would like a repair and some supper. Gasket is excellent at reminding me which of us is waiting. Sometimes a little forcefully, considering how interesting the problem has become.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What is the best part of repairing something?",
	response = "When they stop watching my hands. They've been leaning over the bench certain it's finished for good, then it works and they start telling me about the trip instead. I could do with another moment of admiration. But I like hearing the journey once the broken thing has stopped being the most important part of it. Usually there's a detail that explains the fault, too.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Do you keep anything people bring back from anomaly fields?",
	response = "Broken fasteners, usually. Everyone else wants to see the artifact. I want the clasp the owner has held together with wire for three days. There's a decision in that repair! What they had, what they tried, which bit they were prepared to sacrifice. Sometimes I ask and get the whole expedition instead. Fine by me, buddy. Sit down. Although tell me before I take the wire off if it's the only thing keeping the rest together.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "What happens when you visit Mute's bench?",
	response = "Depends how close my hands get. He's got a way of putting a tray down that ends a suggestion before I've finished making it. Very economical. I once spent a whole visit describing an arrangement he'd already tried. He let me reach the exciting part, then produced the rejected piece. Kept it labelled, too. I admired that. Would've admired it more if he'd shown me five minutes earlier.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you leave his equipment alone?",
	response = "When he asks. Well, when he makes it sufficiently clear. Usually by moving it away. I like seeing work done differently, even if the owner won't allow a perfectly reasonable experiment. You should see how clean he leaves the bench. Almost discourages thought.",
	options = {"BackTopic"},
})
