local PANEL = {}
local gradient = ix.util.GetMaterial("vgui/gradient-d")
local OPTION_INPUT_DELAY = 0.6

function PANEL:Init()
	self.loading = true

	self.ANIM_SPEED = 0

	gui.EnableScreenClicker(true)
	self:MakePopup()

	self:Dock(BOTTOM)
	self:DockMargin(ScrW() * 0.25, 0, ScrW() * 0.25, ScrH() * 0.05)
	self:SetTall(ScrH() * 0.9)
	self:SetAlpha(0)
	self:AlphaTo(255, self.ANIM_SPEED)

	self.chatbox = self:Add("DScrollPanel")
	self.chatbox:Dock(TOP)
	self.chatbox:SetTall(ScrH() * 0.52)
	self.chatbox:DockMargin(ScrW() * 0.025, ScrH() * 0.048, ScrW() * 0.025, ScrH() * 0.02)
	self:InvalidateLayout(true)
	self:InvalidateChildren(true)

	self.options = self:Add("DScrollPanel")
	self.options:Dock(FILL)
	self.options:DockMargin(ScrW() * 0.024, ScrH() * 0.03, ScrW() * 0.024, ScrH() * 0.063)
end

function PANEL:Think()
	if self.exiting then return end

	if self.loading then
		if self.target and self.treeID then
			self.tree = ix.dialogue.list[self.treeID].tree
			self:startTopic("GREETING")

			self.loading = false
		end
	end

	gui.EnableScreenClicker(true)
	if self.optionInputDeadline and RealTime() >= self.optionInputDeadline then
		local optionIndex = tonumber(self.optionInput)
		self.optionInput = nil
		self.optionInputDeadline = nil
		if self:HasFocus() then
			self:SelectOption(optionIndex)
		end
	end
end

function PANEL:SelectOption(optionIndex)
	local button = self.buttonList and self.buttonList[optionIndex]
	if self.exiting or not IsValid(button) then return end

	button:DoClick()
end

function PANEL:OnKeyCodePressed(keyCode)
	if self.loading or self.exiting or not self.buttonList then return end

	local digit
	if keyCode >= KEY_0 and keyCode <= KEY_9 then
		digit = keyCode - KEY_0
	elseif keyCode >= KEY_PAD_0 and keyCode <= KEY_PAD_9 then
		digit = keyCode - KEY_PAD_0
	else
		return
	end

	local optionInput = (self.optionInput or "") .. digit
	local optionIndex = tonumber(optionInput)
	self.optionInput = nil
	self.optionInputDeadline = nil
	if optionIndex < 1 or optionIndex > #self.buttonList then return end

	-- Wait only when another visible option starts with the same digits (e.g. 1 and 10).
	if optionIndex * 10 <= #self.buttonList then
		self.optionInput = optionInput
		self.optionInputDeadline = RealTime() + OPTION_INPUT_DELAY

		return
	end

	self:SelectOption(optionIndex)
end

function PANEL:targetName()
	if self.target.GetDisplayName then
		return self.target:GetDisplayName()
	end

	return self.target.PrintName or "Unknown"
end

function PANEL:startTopic(topicID, dynamicData)
	if self.exiting then return end

	self.currentTopicID = topicID
	topic = self.tree[topicID]

	self.options:Clear()
	self.buttonList = {}
	self.optionInput = nil
	self.optionInputDeadline = nil

	-- Run pre-callback, if there is one
	if isfunction(topic.preCallback) then
		topic.preCallback(topic, LocalPlayer(), self.target)
		net.Start("ixPreCallback")
		net.WriteString(self.treeID)
		net.WriteString(topicID)
		net.WriteEntity(self.target)
		net.SendToServer()
	end

	if dynamicData and topic.IsDynamicFollowup and isfunction(topic.DynamicPreCallback) then
		topic.DynamicPreCallback(topic, LocalPlayer(), self.target, dynamicData)
		net.Start("ixPreDynamicCallback")
		net.WriteString(self.treeID)
		net.WriteString(topicID)
		net.WriteEntity(self.target)
		net.WriteTable(dynamicData)
		net.SendToServer()
	end

	if topic.statement ~= "" then
		self:dialogue(LocalPlayer():GetCharacter():GetName(), topic.statement, true)
	end

	if topic.waitForProgressionResponse then
		self:prepareOptions(topic.options)
	else
		self:dialogue(self:targetName(), topic.response, true, ix.config.Get("chatColor"), topicID)
	end
end

function PANEL:dialogue(name, message, instant, color, topicID)
	if self.exiting then return end

	self.nametitle = self.chatbox:Add("DLabel")
	self.nametitle:Dock(TOP)
	self.nametitle:DockMargin(0, 0, 0, 4)
	self.nametitle:SetFont("stalkerregulartitlefont")
	self.nametitle:SetWrap(true)
	self.nametitle:SetAutoStretchVertical(true)
	self.nametitle:SetText("")

	self.message = self.chatbox:Add("DLabel")
	self.message:Dock(TOP)
	self.message:DockMargin(ScrW() * 0.01, 0, 0, 4)
	self.message:SetFont("ixSmallFont")
	self.message:SetWrap(true)
	self.message:SetAutoStretchVertical(true)
	self.message:SetText("")

	local function scrollToBottom()
		self.chatbox:GetVBar():AnimateTo(self.chatbox:GetCanvas():GetTall(), 0.1, 0.1)
	end

	scrollToBottom()

	if name == LocalPlayer():GetCharacter():GetName() then
		self.nametitle:SetTextColor(Color(150, 200, 150))
	else
		self.nametitle:SetTextColor(Color(206, 108, 86))
	end

	if color then
		self.message:SetTextColor(color)
	end

	local parseMessage = "''" .. message .. "''"

	if instant then
		self.nametitle:SetText(name)
		self.message:SetText(parseMessage)

		if topicID then
			topic = self.tree[topicID]
			-- Run post-callback, if there is one
			if isfunction(topic.postCallback) then
				topic.postCallback(topic, LocalPlayer(), self.target)
				net.Start("ixPostCallback")
				net.WriteString(self.treeID)
				net.WriteString(topicID)
				net.WriteEntity(self.target)
				net.SendToServer()
			end

			if topicID == "GOODBYE" then
				self:exit()
			end

			if topic.IsDynamic then
				local dynamicOptions = topic.GetDynamicOptions(topic, LocalPlayer(), self.target)
				self:prepareDynamicOptions(dynamicOptions, topic.options)
			else
				self:prepareOptions(topic.options)
			end
		end

		return
	end

	-- unused, as its just for making the text appear slower
	i = 1
	messageTable = string.ToTable(parseMessage)
	concatMessage = ""
	timer.Create("typewriter", 0.05, string.len(parseMessage), function()
		concatMessage = concatMessage .. messageTable[i]
		i = i + 1

		self.message:SetText(concatMessage)

		-- End of message
		if i == (table.Count(messageTable) + 1) then
			scrollToBottom()

			if topicID then
				topic = self.tree[topicID]
				-- Run post-callback, if there is one
				if isfunction(topic.postCallback) then
					topic.postCallback(topic, LocalPlayer(), self.target)
					net.Start("ixPostCallback")
					net.WriteString(self.treeID)
					net.WriteString(topicID)
					net.WriteEntity(self.target)
					net.SendToServer()
				end

				if topicID == "GOODBYE" then
					self:exit()
				end

				if topic.IsDynamic then
					local dynamicOptions = topic.GetDynamicOptions(topic, LocalPlayer(), self.target)
					self:prepareDynamicOptions(dynamicOptions, topic.options)
				else
					self:prepareOptions(topic.options)
				end
			end

			timer.Destroy("typewriter")
		end
	end)
end

function PANEL:prepareOptions(options)
	self.buttonList = {}
	for _, topicID in ipairs(ix.dialogue.OrderOptions(options)) do
		local topic = self.tree[topicID]
		if topic.statement ~= "" and topic:ShouldAdd(LocalPlayer(), self.target) then
			local k = #self.buttonList + 1
			self.buttonList[k] = self.options:Add("DLabel")
			self.buttonList[k]:Dock(TOP)
			self.buttonList[k]:DockMargin(4, 0, 4, 4)
			self.buttonList[k]:SetText(k .. ". " .. topic.statement)
			self.buttonList[k]:SetTextColor(Color(20, 20, 20, 255))
			self.buttonList[k]:SetFont("ixSmallFont")
			self.buttonList[k]:SetMouseInputEnabled(true)
			self.buttonList[k].Think = function()
				if self.buttonList[k]:IsHovered() then
					self.buttonList[k]:SetTextColor(Color(255, 255, 255))
				else
					self.buttonList[k]:SetTextColor(Color(220, 220, 220))
				end
			end
			self.buttonList[k].DoClick = function()
				self:startTopic(topicID)
			end
		end
	end
end

function PANEL:prepareDynamicOptions(dynamicOptions, normalOptions)
	self.buttonList = {}
	local combined = {}
	for _, data in ipairs(dynamicOptions or {}) do
		combined[#combined + 1] = {topicID = data.topicID, statement = data.statement,
			data = data.dyndata, dynamic = true}
	end
	for _, topicID in ipairs(normalOptions or {}) do
		combined[#combined + 1] = {topicID = topicID}
	end
	for _, option in ipairs(ix.dialogue.OrderOptions(combined)) do
		local topic = self.tree[option.topicID]
		local statement = option.statement or topic.statement
		if statement ~= "" and (not topic.ShouldAdd or topic:ShouldAdd(LocalPlayer(), self.target)) then
			local label = self.options:Add("DLabel")
			self.buttonList[#self.buttonList + 1] = label
			label:Dock(TOP)
			label:DockMargin(4, 0, 4, 4)
			label:SetText(#self.buttonList .. ". " .. statement)
			label:SetTextColor(Color(20, 20, 20, 255))
			label:SetFont("ixSmallFont")
			label:SetWrap(true)
			label:SetAutoStretchVertical(true)
			label:SetMouseInputEnabled(true)
			local baseThink = label.Think
			label.Think = function()
				baseThink(label)
				label:SetTextColor(label:IsHovered() and Color(255, 255, 255) or Color(220, 220, 220))
			end
			label.DoClick = function()
				if option.dynamic then
					local nextTopic, data = self:ResolveDynamicOption(option.topicID,
						LocalPlayer(), self.target, option.data)
					self:startTopic(nextTopic, data)
				else
					self:startTopic(option.topicID)
				end
			end
		end
	end
end

function PANEL:ResolveDynamicOption(topicID, client, target, dynamicData)
	local topic = self.tree[topicID]
	local ret = topicID
	local data = {}

	if isfunction(topic.ResolveDynamicOption) then
		ret, data = topic.ResolveDynamicOption(topicID, LocalPlayer(), self.target, dynamicData)
		net.Start("ixDialogueResolveDynamic")
		net.WriteString(self.treeID)
		net.WriteString(topicID)
		net.WriteEntity(self.target)
		net.WriteTable(dynamicData)
		net.SendToServer()
	end

	return ret, data
end

function PANEL:exit()
	if self.exiting then return end

	self.exiting = true
	self.optionInput = nil
	self.optionInputDeadline = nil
	self:SetKeyboardInputEnabled(false)
	self:SetMouseInputEnabled(false)

	if timer.Exists("typewriter") then
		timer.Remove("typewriter")
	end

	gui.EnableScreenClicker(false)
	net.Start("ixDialogueFreeze")
	net.WriteBool(false)
	net.SendToServer()
	if ix.gui.dialogue == self then
		ix.gui.dialogue = nil
	end

	self:AlphaTo(0, self.ANIM_SPEED, 0, function()
		self:Remove()
	end)
end

function PANEL:Paint(w, h)
	--	surface.SetDrawColor(0, 0, 0, 250)
	--	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(0, 0, 0, 180)
	surface.DrawRect(30, 15, w - 60, h - 30)

	surface.SetMaterial(Material("cotz/panels/dialogue.png"))
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0, 0, w, h)
end

vgui.Register("ixDialogue", PANEL, "EditablePanel")

hook.Add("OnPauseMenuShow", "cotz/dialogue/escape-exit", function()
	local vendor = ix.gui.vendor
	if IsValid(vendor) and vendor:IsVisible() then
		vendor:Close()

		return false
	end

	local panel = ix.gui.dialogue
	if not IsValid(panel) or panel.exiting or not panel:HasFocus() then return end

	panel:exit()

	return false
end)

net.Receive("ixDialogue", function()
	local target = net.ReadEntity()
	local treeID = net.ReadString()

	ix.gui.dialogue = vgui.Create("ixDialogue")
	ix.gui.dialogue.target = target
	ix.gui.dialogue.treeID = treeID
end)

net.Receive("cotz/dialogue/progression-response", function()
	local target = net.ReadEntity()
	local response = net.ReadString()
	local panel = ix.gui.dialogue
	if IsValid(panel) and panel.target == target then
		panel:dialogue(panel:targetName(), response, true, ix.config.Get("chatColor"))
	end
end)

net.Receive("ixDialogueNotify", function()
	local notitype = net.ReadUInt(4)
	local notidesc = net.ReadString()

	local typetextarr = {
		"Got item: ",
		"Lost item: ",
		"New task: ",
		"Completed task: ",
		"Money wired to account: ",
		"Lost money: ",
		"Received reputation: ",
		"Lost reputation: ",
	}

	local typeimgarr = {
		"propic/event/lootdown", -- ITEM GET
		"propic/event/lootup", -- ITEM LOSE
		"propic/event/compass", -- NEW TASK
		"propic/event/negotiation", -- COMPLETED TASK
		"propic/event/moneydown", -- MONEY GET
		"propic/event/moneyup", -- MONEY LOSE
		"propic/event/group2", -- REP GET
		"propic/event/system", -- REP LOSE
	}

	local typetext = typetextarr[notitype + 1] or "INVALID TYPE: "
	local typeimg = typeimgarr[notitype + 1] or typeimgarr[1]

	local notitext = typetext .. notidesc

	if ix.gui.dialogue then
		local notif = ix.gui.dialogue.chatbox:Add("DLabel")
		notif:Dock(TOP)
		notif:DockMargin(ScrW() * 0.02, 0, 0, 4)
		notif:SetText("")

		local img = notif:Add("DImage")
		img:Dock(LEFT)
		img:SetImage(typeimg)
		img:SetSize(ScrW() * 0.04, ScrH() * 0.035)

		local txt = notif:Add("DLabel")
		txt:Dock(FILL)
		txt:SetFont("ixSmallFont")
		txt:DockMargin(8, 0, 0, 0)
		txt:SetText(notitext)
		txt:SetSize(ScrW() * 0.1, ScrH() * 0.02)

		notif:SizeToChildren(true, true)
	else
		LocalPlayer():Notify(notitext)
	end
end)
