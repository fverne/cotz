local activeFrame
local nextRequest = 0

local function sendRequest(name, write, frame)
	local delay = math.max(0, nextRequest - RealTime())
	nextRequest = RealTime() + delay + 0.3
	timer.Simple(delay, function()
		if not IsValid(frame) then return end
		net.Start("cotz/gear-appearance/" .. name)
		write()
		net.SendToServer()
	end)
end

local function clearPreview(model)
	if model.gearTree and IsValid(model.Entity) and model.Entity.RemovePACPart then
		model.Entity:RemovePACPart(model.gearTree)
	end
	model.gearTree = nil
end

local function combo(parent, label, options, selected, callback)
	ix.cotzUI.Label(parent, label, true)
	local control = ix.cotzUI.StyleCombo(parent:Add("DComboBox"))
	control:Dock(TOP)
	ix.cotzUI.SetHeight(control, 34)
	control:SetSortItems(false)
	for _, option in ipairs(options) do
		control:AddChoice(option.name, option.id, option.id == selected)
	end
	control.OnSelect = function(_, _, _, id) callback(id) end

	return control
end

function ix.gearAppearance.OpenMenu(target)
	if IsValid(activeFrame) then activeFrame:Remove() end
	if not pac then LocalPlayer():Notify("The workshop preview is unavailable.") return end
	local character = LocalPlayer():GetCharacter()
	if not character then return end
	local frame, unused = ix.cotzUI.Frame("Customize Gear", 0.9, 0.85, 1100)
	unused:Remove()
	activeFrame = frame
	if ix.dialogue and ix.dialogue.TrackRelatedPanel then ix.dialogue.TrackRelatedPanel(frame) end
	frame.character = character
	frame.target = target
	local actions = frame:Add("DPanel")
	actions:Dock(BOTTOM)
	ix.cotzUI.SetHeight(actions, 42)
	actions.Paint = function() end
	local content = frame:Add("DPanel")
	content:Dock(FILL)
	content.Paint = function() end
	local model = content:Add("DModelPanel")
	model:Dock(LEFT)
	model:SetFOV(35)
	model:SetModel(LocalPlayer():GetModel())
	model.Entity:SetSkin(LocalPlayer():GetSkin())
	for _, group in ipairs(LocalPlayer():GetBodyGroups()) do
		model.Entity:SetBodygroup(group.id, LocalPlayer():GetBodygroup(group.id))
	end
	pac.SetupENT(model.Entity)
	model.Entity:SetSequence(model.Entity:LookupSequence("idle_all_01"))
	model.rotation = 0
	model.LayoutEntity = function(panel, entity) entity:SetAngles(Angle(0, panel.rotation, 0)) end
	model.PreDrawModel = function(_, entity)
		pac.ShowEntityParts(entity)
		-- Preview entities can be outside PAC's world draw distance; update their attachments explicitly.
		pac.RenderOverride(entity, "update")
		pac.RenderOverride(entity, "update_legacy_bones")
		pac.SetupBones(entity)
	end
	model.PostDrawModel = function(_, entity)
		pac.RenderOverride(entity, "opaque")
		pac.RenderOverride(entity, "translucent", true)
	end
	local removeModel = model.OnRemove
	model.OnRemove = function(panel)
		clearPreview(panel)
		if removeModel then removeModel(panel) end
	end
	local controls = content:Add("DScrollPanel")
	controls:Dock(FILL)
	ix.cotzUI.StyleScroll(controls)
	local layout = frame.PerformLayout
	frame.PerformLayout = function(panel, width, height)
		layout(panel, width, height)
		model:SetWide(width * 0.5)
	end
	local function action(text, callback)
		local button = ix.cotzUI.StyleButton(actions:Add("DButton"))
		button:Dock(LEFT)
		button.cotzRefresh = function(panel) panel:SetWide(ix.cotzUI.Scale(150)) end
		button:cotzRefresh()
		button:SetText(text)
		button.DoClick = callback

		return button
	end
	local apply = action("Apply — 100 rubles", function()
		if not frame.item or frame.pending then return end
		frame.pending = RealTime() + 8
		local itemID, state = frame.item:GetID(), table.Copy(frame.selection)
		sendRequest("quote", function()
			net.WriteEntity(target)
			net.WriteUInt(itemID, 32)
			ix.gearAppearance.WriteState(state)
		end, frame)
	end)
	frame.RefreshPreview = function(panel)
		clearPreview(model)
		if not panel.item then return end
		if panel.item.isBodyArmor then
			for _, paint in ipairs(ix.gearAppearance.GetConfiguration(panel.item).skins) do
				if paint.id == panel.selection.skin then
					local previewModel = paint.model or panel.item.newModel
					if model:GetModel() ~= previewModel then model:SetModel(previewModel) end
					pac.SetupENT(model.Entity)
					model.Entity:SetSequence(model.Entity:LookupSequence("idle_all_01"))
					model.Entity:SetSkin(paint.skin)
				end
			end
		else
			if model:GetModel() ~= LocalPlayer():GetModel() then model:SetModel(LocalPlayer():GetModel()) end
			model.Entity:SetSkin(LocalPlayer():GetSkin())
			for _, group in ipairs(LocalPlayer():GetBodyGroups()) do
				model.Entity:SetBodygroup(group.id, LocalPlayer():GetBodygroup(group.id))
			end
			pac.SetupENT(model.Entity)
			local key = "preview:" .. panel.item:GetID()
			model.gearTree = ix.gearAppearance.BuildPAC(panel.item, panel.selection, key)
			model.Entity:AttachPACPart(model.gearTree)
		end
		local center = panel.item.isBodyArmor or panel.item.isBackpack or panel.item.isExoskeleton
		model:SetLookAt(center and Vector(0, 0, 40) or Vector(0, 0, 65))
		model:SetCamPos(center and Vector(110, 0, 55) or Vector(55, 0, 66))
		if IsValid(panel.summary) then
			panel.summary:SetText("Current: " .. ix.gearAppearance.Describe(panel.item)
				.. "\nPreview: " .. ix.gearAppearance.Describe(panel.item, panel.selection))
		end
		panel.currentAppearance = panel.item:GetData("gearAppearance")
		panel.currentSuitSkin = panel.item:GetData("setSkin")
		panel.changed = ix.gearAppearance.Fingerprint(panel.item)
			~= ix.gearAppearance.Fingerprint(panel.item, panel.selection)
	end
	local items = {}
	for _, item in pairs(character:GetInventory():GetItems()) do
		if item:GetData("equip", false) and ix.gearAppearance.CanCustomize(item, character, target) then
			items[#items + 1] = item
		end
	end
	table.sort(items, function(first, second) return first:GetName() < second:GetName() end)
	local chooseItem
	chooseItem = function(item)
		controls:Clear()
		frame.item = item
		frame.changed = false
		frame.selection = item and ix.gearAppearance.Normalize(item) or nil
		local choices = {}
		for _, candidate in ipairs(items) do
			choices[#choices + 1] = {name = candidate:GetName(), id = candidate:GetID()}
		end
		if not item then
			ix.cotzUI.Label(controls, "None of your worn gear has another finish available.", true)
			ix.cotzUI.Label(controls, "Put on the gear you want changed, then ask Technut again.")

			return
		end
		combo(controls, "Equipped gear", choices, item:GetID(), function(id)
			local selected = character:GetInventory():GetItems()[id]
			if selected and not frame.pending then chooseItem(selected) end
		end)
		local config = ix.gearAppearance.GetConfiguration(item)
		if #config.skins > 1 then
			combo(controls, "Finish", config.skins, frame.selection.skin, function(id)
				if frame.pending or IsValid(frame.confirmation) then return end
				frame.selection.skin = id
				frame:RefreshPreview()
			end)
		end
		for _, group in ipairs(config.bodygroups or {}) do
			if #group.options > 1 then
				local groupID = group.id
				combo(controls, group.name, group.options, frame.selection.bodygroups[groupID], function(id)
					if frame.pending or IsValid(frame.confirmation) then return end
					frame.selection.bodygroups[groupID] = id
					frame:RefreshPreview()
				end)
			end
		end
		ix.cotzUI.Label(controls, "Rotate preview")
		local rotation = controls:Add("DNumSlider")
		rotation:Dock(TOP)
		ix.cotzUI.SetHeight(rotation, 34)
		rotation:SetText("")
		rotation:SetMinMax(0, 360)
		rotation:SetDecimals(0)
		rotation:SetValue(model.rotation)
		rotation.OnValueChanged = function(_, value) model.rotation = value end
		frame.summary = ix.cotzUI.Label(controls, "")
		ix.cotzUI.Label(controls, "100 rubles per item. Previewing is free; protection and carry capacity stay the same.")
		if config.worldNotice then ix.cotzUI.Label(controls, config.worldNotice) end
		frame:RefreshPreview()
	end
	frame.SelectItem = chooseItem
	action("Reset Preview", function() if not frame.pending then chooseItem(frame.item) end end)
	action("Cancel", function() frame:Close() end)
	chooseItem(items[1])
	local think = frame.Think
	frame.Think = function(panel)
		think(panel)
		if LocalPlayer():GetCharacter() ~= character or not IsValid(target)
			or LocalPlayer():GetPos():DistToSqr(target:GetPos()) > 192 ^ 2 then panel:Close() return end
		if panel.pending and panel.pending <= RealTime() then
			panel.pending = nil
			LocalPlayer():Notify("Technut needs another look at your gear. Try again.")
		end
		local item = panel.item
		if item and (panel.currentAppearance ~= item:GetData("gearAppearance")
			or panel.currentSuitSkin ~= item:GetData("setSkin")) then panel:RefreshPreview() end
		apply:SetEnabled(panel.changed and not panel.pending and not IsValid(panel.confirmation) or false)
	end
	frame.OnRemove = function(panel)
		if IsValid(panel.confirmation) then panel.confirmation:Remove() end
		clearPreview(model)
		if activeFrame == panel then activeFrame = nil end
		if IsValid(ix.gui.dialogue) then ix.gui.dialogue:MakePopup() end
	end
end

net.Receive("cotz/gear-appearance/open", function()
	ix.gearAppearance.OpenMenu(net.ReadEntity())
end)

net.Receive("cotz/gear-appearance/quote", function()
	local token, itemID, price = net.ReadUInt(32), net.ReadUInt(32), net.ReadUInt(32)
	local state = ix.gearAppearance.ReadState()
	local frame = activeFrame
	if not state or not IsValid(frame) or not frame.item or frame.item:GetID() ~= itemID then return end
	frame.pending = nil
	local function confirm(accepted)
		if not IsValid(frame) then return end
		frame.confirmation = nil
		frame.pending = RealTime() + 8
		sendRequest("confirm", function()
			net.WriteUInt(token, 32)
			net.WriteBool(accepted)
		end, frame)
	end
	frame.confirmation = ix.cotzUI.Query(
		"Apply " .. ix.gearAppearance.Describe(frame.item, state) .. " to " .. frame.item:GetName()
			.. " for " .. ix.currency.Get(price) .. "?",
		"Confirm Gear Customization", "Apply", function() confirm(true) end, "Cancel", function() confirm(false) end
	)
	if ix.dialogue and ix.dialogue.TrackRelatedPanel then
		ix.dialogue.TrackRelatedPanel(frame.confirmation, function()
			if IsValid(frame.confirmation) then frame.confirmation:Close() end
			confirm(false)
		end)
	end
end)

net.Receive("cotz/gear-appearance/result", function()
	local success, message = net.ReadBool(), net.ReadString()
	LocalPlayer():Notify(message)
	if not IsValid(activeFrame) then return end
	activeFrame.pending = nil
	if success then activeFrame.SelectItem(activeFrame.item) end
end)
