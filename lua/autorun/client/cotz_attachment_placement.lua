local editor

local function isPlacement(data)
	return data and not data.models and isvector(data.pos) and isangle(data.angle) and isstring(data.bone)
end

local function sameBone(first, second)
	return first.bone:lower() == second.bone:lower()
end

local function getOffsets(target, reference, slot, anchorID)
	local targetModels = target.AttachmentModelsVM
	local referenceModels = reference.AttachmentModelsVM
	local targetAnchor = targetModels[anchorID]
	local referenceAnchor = referenceModels and referenceModels[anchorID]
	if not isPlacement(referenceAnchor) or targetAnchor.model ~= referenceAnchor.model then return end

	-- Position components use the CW bone's forward, right and up axes.
	-- The matching anchor orientations establish that the reference uses the same axes.
	local angle = targetAnchor.angle
	local referenceAngle = referenceAnchor.angle
	if math.abs(math.AngleDifference(angle.p, referenceAngle.p)) > 0.01
		or math.abs(math.AngleDifference(angle.y, referenceAngle.y)) > 0.01
		or math.abs(math.AngleDifference(angle.r, referenceAngle.r)) > 0.01 then return end

	local referenceSlots = {}
	for _, category in pairs(reference.Attachments or {}) do
		if table.HasValue(category.atts or {}, anchorID) then
			for _, id in ipairs(category.atts) do
				referenceSlots[id] = true
			end
		end
	end

	local offsets = {}
	local skipped = {}
	for _, id in ipairs(slot.atts) do
		local entry = targetModels[id]
		local source = referenceModels[id]
		if referenceSlots[id] and isPlacement(entry) and isPlacement(source) and entry.model == source.model
			and sameBone(entry, targetAnchor) and sameBone(source, referenceAnchor) then
			offsets[id] = source.pos - referenceAnchor.pos
		elseif entry then
			skipped[#skipped + 1] = id
		end
	end

	return offsets, skipped
end

local function addCombo(parent, caption)
	local combo = ix.cotzUI.StyleCombo(parent:Add("DComboBox"))
	combo:Dock(TOP)
	combo:SetValue(caption)
	ix.cotzUI.SetHeight(combo, 32)

	return combo
end

local function readComponent(entry)
	local value = tonumber(entry:GetValue())
	if value and value == value and math.abs(value) < math.huge then return value end
end

local function openEditor(weapon, target, reference, referenceClass)
	if IsValid(editor) then editor:Remove() end

	local frame, scroll = ix.cotzUI.Frame("CW Attachment Placement", 0.38, 0.73, 490)
	editor = frame
	frame:SetPos(ix.cotzUI.Scale(16), frame:GetY())

	ix.cotzUI.Label(scroll, weapon:GetClass() .. "  /  Reference: " .. referenceClass)
	local anchor = addCombo(scroll, "Choose an anchor attachment")
	local preview = addCombo(scroll, "Preview attachment")
	ix.cotzUI.Label(scroll, "Anchor position (X / Y / Z)")
	local entries = {}
	for _, axis in ipairs({"X", "Y", "Z"}) do
		local entry = ix.cotzUI.StyleEntry(scroll:Add("DTextEntry"))
		entry:Dock(TOP)
		entry:SetPlaceholderText(axis)
		entry:SetUpdateOnType(true)
		ix.cotzUI.SetHeight(entry, 28)
		entries[#entries + 1] = entry
	end

	local status = ix.cotzUI.Label(scroll, "")
	local offsets, slot, slotIDs, previewID, positions
	local function refresh()
		weapon.cotzAttachmentPreview = nil
		positions = nil
		if not offsets then return end

		local x, y, z = readComponent(entries[1]), readComponent(entries[2]), readComponent(entries[3])
		if not (x and y and z) then return end

		local position = Vector(x, y, z)
		positions = {}
		for id, offset in pairs(offsets) do
			positions[id] = position + offset
		end

		weapon.cotzAttachmentPreview = {id = previewID, pos = positions[previewID], slot = slotIDs}
	end

	anchor.OnSelect = function(_, _, _, choice)
		slot = choice.slot
		slotIDs = {}
		for _, id in ipairs(slot.atts) do
			slotIDs[id] = true
		end
		previewID = choice.id
		local skipped
		offsets, skipped = getOffsets(target, reference, slot, choice.id)
		preview:Clear()
		preview:SetValue("Preview attachment")

		if not offsets then
			status:SetText("The reference needs the same anchor model and orientation.")
			refresh()
			return
		end

		for _, id in ipairs(slot.atts) do
			if offsets[id] then preview:AddChoice(id, id, id == previewID) end
		end

		local position = target.AttachmentModelsVM[choice.id].pos
		for index, value in ipairs({position.x, position.y, position.z}) do
			entries[index]:SetText(string.format("%.6f", value))
		end

		status:SetText(#skipped == 0 and "All modelled attachments in this slot are available."
			or "Skipped incompatible entries: " .. table.concat(skipped, ", "))
		refresh()
	end

	preview.OnSelect = function(_, _, _, id)
		previewID = id
		refresh()
	end

	for _, entry in ipairs(entries) do
		entry.OnValueChange = refresh
	end

	for index, category in pairs(target.Attachments or {}) do
		for _, id in ipairs(category.atts or {}) do
			if isPlacement(target.AttachmentModelsVM[id]) then
				local label = string.format("%s / %s (%s)", category.header or "Slot", id, index)
				anchor:AddChoice(label, {id = id, slot = category})
			end
		end
	end

	ix.cotzUI.Button(scroll, "Copy Lua positions", function()
		if not positions then return end

		local lines = {}
		for _, id in ipairs(slot.atts) do
			local pos = positions[id]
			if pos then
				lines[#lines + 1] = string.format(
					"SWEP.AttachmentModelsVM[%q].pos = Vector(%.6f, %.6f, %.6f)", id, pos.x, pos.y, pos.z
				)
			end
		end

		SetClipboardText(table.concat(lines, "\n"))
		status:SetText(string.format("Copied %d Lua positions.", #lines))
	end)

	frame:CallOnRemove("cotz/attachment-placement/clear", function()
		if IsValid(weapon) then weapon.cotzAttachmentPreview = nil end
	end)

	local think = frame.Think
	frame.Think = function(panel)
		think(panel)
		if not IsValid(weapon) or LocalPlayer():GetActiveWeapon() ~= weapon then panel:Remove() end
	end
end

concommand.Add("cotz_attachment_placement", function(_, _, args)
	local client = LocalPlayer()
	if not IsValid(client) or not (game.SinglePlayer() or client:IsListenServerHost()) then return end
	if not ix or not ix.cotzUI then return end

	local weapon = client:GetActiveWeapon()
	if not IsValid(weapon) or not weapon.CW20Weapon then
		print("Equip a CW weapon to edit its attachment positions.")
		return
	end

	local target = weapons.GetStored(weapon:GetClass())
	local referenceClass = args[1] or weapon:GetClass()
	local reference = weapons.GetStored(referenceClass)
	if not target or not target.AttachmentModelsVM or not reference or not reference.AttachmentModelsVM then
		print("Both weapon classes need CW AttachmentModelsVM definitions.")
		return
	end

	openEditor(weapon, target, reference, referenceClass)
end)
