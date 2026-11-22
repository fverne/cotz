local editor

local function isPlacement(data)
	return data and not data.models and isvector(data.pos) and isangle(data.angle) and isstring(data.bone)
end

local function sameBone(first, second)
	return first.bone:lower() == second.bone:lower()
end

local UNIT_SCALE = Vector(1, 1, 1)
local ZERO = Vector(0, 0, 0)

local function toSourcePosition(pos)
	-- CW uses positive Y along Right, while Source local coordinates use Left.
	return Vector(pos.x, -pos.y, pos.z)
end

local function toSourceAngle(angle)
	-- CW applies yaw, then rotates around Right for pitch, then Forward for roll.
	return Angle(-angle.p, angle.y, angle.r)
end

local function getPlacements(target, reference, slot, anchorID)
	local targetModels = target.AttachmentModelsVM
	local referenceModels = reference.AttachmentModelsVM
	local targetAnchor = targetModels[anchorID]
	local referenceAnchor = referenceModels[anchorID]
	if not isPlacement(referenceAnchor) or targetAnchor.model ~= referenceAnchor.model then return end

	local referenceSlot
	for _, category in pairs(reference.Attachments or {}) do
		if category.header == slot.header and table.HasValue(category.atts or {}, anchorID) then
			referenceSlot = category
			break
		end
	end
	if not referenceSlot then return end

	local targetScale = targetAnchor.size or UNIT_SCALE
	local referenceScale = referenceAnchor.size or UNIT_SCALE
	if referenceScale.x <= 0 or referenceScale.y <= 0 or referenceScale.z <= 0 then return end

	local scale = targetScale.x / referenceScale.x
	if scale <= 0 or math.abs(targetScale.y / referenceScale.y - scale) > 0.001
		or math.abs(targetScale.z / referenceScale.z - scale) > 0.001 then return end

	local placements = {}
	local ids = {}
	local sourceFrame = toSourceAngle(referenceAnchor.angle)
	local targetFrame = toSourceAngle(targetAnchor.angle)
	for _, id in ipairs(referenceSlot.atts) do
		local entry = targetModels[id]
		local source = referenceModels[id]
		local compatible = isPlacement(source) and sameBone(source, referenceAnchor)
		if id == "md_pso1" and not entry and target.HasDovetailMount ~= true then
			compatible = false
		end
		if entry then
			compatible = compatible and isPlacement(entry) and entry.model == source.model
				and sameBone(entry, targetAnchor)
		end

		if compatible then
			local delta = toSourcePosition(source.pos - referenceAnchor.pos)
			local localPos, localAngle = WorldToLocal(delta, toSourceAngle(source.angle), ZERO, sourceFrame)
			local offset, angle = LocalToWorld(localPos * scale, localAngle, ZERO, targetFrame)
			placements[id] = {
				offset = toSourcePosition(offset),
				angle = entry and entry.angle or toSourceAngle(angle),
				model = source.model,
				bone = targetAnchor.bone,
				size = entry and (entry.size or UNIT_SCALE) or (source.size or UNIT_SCALE) * scale,
				isNew = not entry,
			}
			ids[#ids + 1] = id
		end
	end

	return placements, ids
end

local function formatVector(vector)
	return string.format("Vector(%.6f, %.6f, %.6f)", vector.x, vector.y, vector.z)
end

local function exportPlacements(placements, ids, positions, slotIndex)
	local lines = {}
	local newIDs = {}
	for _, id in ipairs(ids) do
		local data = placements[id]
		local key = string.format("SWEP.AttachmentModelsVM[%q]", id)
		local pos = formatVector(positions[id])
		if data.isNew then
			lines[#lines + 1] = string.format(
				"%s = {model = %q, bone = %q, pos = %s, angle = Angle(%.6f, %.6f, %.6f), size = %s}",
				key, data.model, data.bone, pos, data.angle.p, data.angle.y, data.angle.r, formatVector(data.size)
			)
			newIDs[#newIDs + 1] = id
		else
			lines[#lines + 1] = key .. ".pos = " .. pos
		end
	end

	if #newIDs > 0 then
		lines[#lines + 1] = ""
		lines[#lines + 1] = "-- Add after SWEP.Attachments in shared code."
		for _, id in ipairs(newIDs) do
			local index = type(slotIndex) == "number" and tostring(slotIndex) or string.format("%q", slotIndex)
			lines[#lines + 1] = string.format("table.insert(SWEP.Attachments[%s].atts, %q)", index, id)
		end
	end

	return table.concat(lines, "\n"), #newIDs
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
	local placements, ids, slotIndex, slotIDs, previewID, positions
	local previewModel, previewModelID
	local function clearModel()
		if IsValid(previewModel) then previewModel:Remove() end
		previewModel, previewModelID = nil, nil
	end

	local function refresh()
		weapon.cotzAttachmentPreview = nil
		positions = nil
		local data = placements and placements[previewID]
		if not data then return end

		local x, y, z = readComponent(entries[1]), readComponent(entries[2]), readComponent(entries[3])
		if not (x and y and z) then return end

		local position = Vector(x, y, z)
		positions = {}
		for id, placement in pairs(placements) do
			positions[id] = position + placement.offset
		end

		if previewModelID ~= previewID then clearModel() end
		local previewData
		if data.isNew and IsValid(weapon.CW_VM) then
			local bone = weapon.CW_VM:LookupBone(data.bone)
			if not bone then return end

			if not IsValid(previewModel) then
				previewModel = ClientsideModel(data.model, RENDERGROUP_BOTH)
				if not IsValid(previewModel) then return end

				previewModelID = previewID
				previewModel:SetNoDraw(true)
				local matrix = Matrix()
				matrix:Scale(data.size)
				previewModel:EnableMatrix("RenderMultiply", matrix)
			end
			previewData = {ent = previewModel, _bone = bone, angle = data.angle}
		end
		weapon.cotzAttachmentPreview = {
			id = previewID,
			pos = positions[previewID],
			slot = slotIDs,
			data = previewData,
		}
	end

	anchor.OnSelect = function(_, _, _, choice)
		local slot = choice.slot
		slotIndex = choice.index
		clearModel()
		slotIDs = {}
		for _, id in ipairs(slot.atts) do
			slotIDs[id] = true
		end
		previewID = choice.id
		placements, ids = getPlacements(target, reference, slot, choice.id)
		preview:Clear()
		preview:SetValue("Preview attachment")

		if not placements then
			status:SetText("Choose a reference with the same slot and anchor model, and a proportional anchor scale.")
			refresh()
			return
		end

		for _, id in ipairs(ids) do
			local label = placements[id].isNew and (id .. " (new)") or id
			preview:AddChoice(label, id, id == previewID)
		end

		local position = target.AttachmentModelsVM[choice.id].pos
		for index, value in ipairs({position.x, position.y, position.z}) do
			entries[index]:SetText(string.format("%.6f", value))
		end

		status:SetText(string.format("%d compatible reference models.", #ids))
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
				anchor:AddChoice(label, {id = id, slot = category, index = index})
			end
		end
	end

	ix.cotzUI.Button(scroll, "Copy Lua placements", function()
		if not positions then return end

		local output, added = exportPlacements(placements, ids, positions, slotIndex)
		SetClipboardText(output)
		status:SetText(string.format("Copied %d placements, including %d new models.", #ids, added))
	end)

	frame:CallOnRemove("cotz/attachment-placement/clear", function()
		clearModel()
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
