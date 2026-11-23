local POLICY = include("cotz/attachment_policy.lua")

local editor

local UNIT_SCALE = Vector(1, 1, 1)
local ZERO = Vector(0, 0, 0)
local ZERO_ANGLE = Angle(0, 0, 0)
local FORWARD = Vector(1, 0, 0)
local MIN_FORWARD_ALIGNMENT = 0.95
local IDLE_SAMPLES = 16
local MATCH_EPSILON = 0.0005
local SIGHT_HEADER = "Sight"
local DEFAULT_SLOT_OFFSET = {800, -300}
local OUTPUT_DIR = "cotz_attachment_placement"
local RAIL_ID = "md_rail"
local RAIL_ADAPTER = "models/wystan/attachments/akrailmount.mdl"

-- Model-space aperture centers and lines of sight. Unmeasured sights derive their axis from a donor's aim.
local SCOPE_GEOMETRY = {
	["models/cw2/attachments/microt1.mdl"] = {lens = Vector(0.0471, -2.3467, 1.9022), forward = Vector(0, 1, 0)},
	["models/cw2/attachments/schmidt.mdl"] = {lens = Vector(0, 0.36735, 6.78505), forward = Vector(1, 0, 0)},
	["models/wystan/attachments/2cog.mdl"] = {lens = Vector(0.36575, -3.2889, 7.10015), forward = Vector(0, -1, 0)},
	["models/cw2/attachments/l96_scope.mdl"] = {lens = Vector(0, 0.09362, -0.085635), forward = Vector(1, 0, 0)},
}

-- Scope render functions index these tables without a nil check, so new scopes need them.
local ALIGN_KEYS = {
	md_schmidt_shortdot = "SchmidtShortDotAxisAlign",
	md_acog = "ACOGAxisAlign",
	md_nightforce_nxs = "NXSAlign",
	md_pso1 = "PSO1AxisAlign",
}

local function isPlacement(data)
	return data and not data.models and isvector(data.pos) and isangle(data.angle) and isstring(data.bone)
end

local function sameBone(first, second)
	return first.bone:lower() == second.bone:lower()
end

local function vectorsMatch(first, second)
	return math.abs(first.x - second.x) < MATCH_EPSILON and math.abs(first.y - second.y) < MATCH_EPSILON
		and math.abs(first.z - second.z) < MATCH_EPSILON
end

local function anglesMatch(first, second)
	return math.abs(first.p - second.p) < MATCH_EPSILON and math.abs(first.y - second.y) < MATCH_EPSILON
		and math.abs(first.r - second.r) < MATCH_EPSILON
end

local function getAttachment(id)
	return CustomizableWeaponry.registeredAttachmentsSKey[id]
end

local function toSourcePosition(pos)
	-- CW uses positive Y along Right, while Source local coordinates use Left.
	return Vector(pos.x, -pos.y, pos.z)
end

local function toSourceAngle(angle)
	-- CW applies yaw, then rotates around Right for pitch, then Forward for roll.
	return Angle(-angle.p, angle.y, angle.r)
end

local function modelPoint(point, scale, pos, angle)
	local scaled = Vector(point.x * scale.x, point.y * scale.y, point.z * scale.z)

	return (LocalToWorld(scaled, ZERO_ANGLE, toSourcePosition(pos), toSourceAngle(angle)))
end

local function aimRay(aimAng)
	return (WorldToLocal(FORWARD, ZERO_ANGLE, ZERO, toSourceAngle(Angle(aimAng.x, aimAng.y, aimAng.z))))
end

local sampleCache = {}

-- Bone matrices across the idle animation, with the viewmodel at the origin.
local function sampleIdleBone(swep, boneName)
	local idle = swep.Animations and swep.Animations.idle
	if swep.ViewModelFlip or not isstring(idle) or not isstring(swep.ViewModel) then return end

	local key = swep.ViewModel .. "|" .. idle .. "|" .. boneName:lower()
	if sampleCache[key] ~= nil then return sampleCache[key] or nil end

	local probe = ClientsideModel(swep.ViewModel, RENDERGROUP_OTHER)
	if not IsValid(probe) then return end

	probe:SetNoDraw(true)
	probe:SetPos(ZERO)
	probe:SetAngles(ZERO_ANGLE)
	-- Some SWEPs name an idle sequence their model lacks; the engine then shows the first sequence.
	local sequence = math.max(probe:LookupSequence(idle), 0)
	local bone = probe:LookupBone(boneName)
	local samples = {}
	if sequence >= 0 and bone then
		probe:ResetSequence(sequence)
		for index = 1, IDLE_SAMPLES do
			probe:SetCycle((index - 1) / IDLE_SAMPLES)
			probe:InvalidateBoneCache()
			probe:SetupBones()
			samples[index] = probe:GetBoneMatrix(bone)
			if not samples[index] then break end
		end
	end
	probe:Remove()

	sampleCache[key] = #samples == IDLE_SAMPLES and samples or false

	return sampleCache[key] or nil
end

-- Recovers a sight's line of sight in its own model space from a hand-tuned aim on `swep`.
local function deriveSightAxis(swep, id, placement, samples)
	local attachment = getAttachment(id)
	local aimKeys = attachment and attachment.aimPos
	local aimPos = aimKeys and swep[aimKeys[1]]
	if not isvector(aimPos) then return end

	-- Inverse of fitScopeAim: the eye looks along `ray` through this viewmodel-space point.
	local origin = Vector(-aimPos.y, aimPos.x, -aimPos.z)
	local ray = aimRay(swep[aimKeys[2]] or swep.IronsightAng or ZERO)
	local size = placement.size or UNIT_SCALE
	local modelPos, modelAngle = toSourcePosition(placement.pos), toSourceAngle(placement.angle)
	local lens, forward = Vector(0, 0, 0), Vector(0, 0, 0)
	for _, sample in ipairs(samples) do
		local boneAngle = sample:GetAngles()
		local point = WorldToLocal(origin, ZERO_ANGLE, sample:GetTranslation(), boneAngle)
		point = WorldToLocal(point, ZERO_ANGLE, modelPos, modelAngle)
		local direction = WorldToLocal(ray, ZERO_ANGLE, ZERO, boneAngle)
		direction = WorldToLocal(direction, ZERO_ANGLE, ZERO, modelAngle)

		point = Vector(point.x / size.x, point.y / size.y, point.z / size.z)
		direction = Vector(direction.x / size.x, direction.y / size.y, direction.z / size.z)
		direction:Normalize()
		-- Keep the point on the sight axis closest to the model origin.
		lens = lens + point - direction * point:Dot(direction)
		forward = forward + direction
	end
	forward:Normalize()

	-- The point is only somewhere on the sight line, so it may sit behind the eye.
	return {lens = lens / #samples, forward = forward, derived = true}
end

local function sightGeometry(placement)
	local geometry = SCOPE_GEOMETRY[placement.model]
	if geometry then return geometry end

	local source = placement.aimSource
	local samples = source and sampleIdleBone(source.swep, source.placement.bone)
	if samples then return deriveSightAxis(source.swep, placement.id, source.placement, samples) end
end

local function eyeRelief(target, aimKeys, source)
	local own = target[aimKeys[1]]
	if isvector(own) then return own.y end

	local ironsight = target.IronsightPos
	local donorAim = source and source.swep[aimKeys[1]]
	local donorIronsight = source and source.swep.IronsightPos
	if isvector(ironsight) and isvector(donorAim) and isvector(donorIronsight) then
		return ironsight.y + donorAim.y - donorIronsight.y
	end

	return isvector(ironsight) and ironsight.y or 0
end

local function fitScopeAim(target, placement, pos, samples)
	local attachment = getAttachment(placement.id)
	local aimKeys = attachment and attachment.aimPos
	if not aimKeys then return end

	local geometry = sightGeometry(placement)
	if not geometry then return end

	local lens = modelPoint(geometry.lens, placement.size, pos, placement.angle)
	local aimAng = target[aimKeys[2]] or target.IronsightAng or ZERO
	local ray = aimRay(aimAng)
	local lensForward = modelPoint(geometry.forward, UNIT_SCALE, ZERO, placement.angle)
	local worldForward = LocalToWorld(lensForward, ZERO_ANGLE, ZERO, samples[1]:GetAngles())
	if worldForward:Dot(ray) < MIN_FORWARD_ALIGNMENT then return end

	local relief = eyeRelief(target, aimKeys, placement.aimSource)
	local x, z = 0, 0
	for _, sample in ipairs(samples) do
		local center = LocalToWorld(lens, ZERO_ANGLE, sample:GetTranslation(), sample:GetAngles())
		local distance = (center.x + relief) / ray.x
		if distance <= 0 and not geometry.derived then return end

		x = x + center.y - ray.y * distance
		z = z - center.z + ray.z * distance
	end

	return {
		aimKeys = aimKeys,
		aimPos = Vector(x / #samples, relief, z / #samples),
		aimAng = aimAng,
	}
end

-- Re-expresses `source` relative to `fromAnchor` in the frame of `toAnchor`.
local function transfer(source, fromAnchor, toAnchor, scale)
	local delta = toSourcePosition(source.pos - fromAnchor.pos)
	local fromFrame, toFrame = toSourceAngle(fromAnchor.angle), toSourceAngle(toAnchor.angle)
	local localPos, localAngle = WorldToLocal(delta, toSourceAngle(source.angle), ZERO, fromFrame)
	local offset, angle = LocalToWorld(localPos * scale, localAngle, ZERO, toFrame)

	return toSourcePosition(offset), toSourceAngle(angle)
end

local function findSlot(swep, header, id)
	for key, category in pairs(swep.Attachments or {}) do
		if category.header == header and (not id or table.HasValue(category.atts or {}, id)) then
			return key, category
		end
	end
end

local function freeSlotKey(swep)
	local key = 1
	while swep.Attachments and swep.Attachments[key] do
		key = key + 1
	end

	return key
end

local function uniformScale(targetSize, sourceSize)
	if sourceSize.x <= 0 or sourceSize.y <= 0 or sourceSize.z <= 0 then return end

	local scale = targetSize.x / sourceSize.x
	if scale <= 0 or math.abs(targetSize.y / sourceSize.y - scale) > 0.001
		or math.abs(targetSize.z / sourceSize.z - scale) > 0.001 then return end

	return scale
end

local function allowedSights(class, swep, category)
	local family = POLICY.weapons[class] or POLICY.categoryFamilies[category or ""] or "rifle"
	local rules = POLICY.families[family]
	local mount = POLICY.mounts[class] or (swep.HasDovetailMount == true and "dovetail" or nil)
	local allowed = {}
	if not rules or (rules.requiresMount and not mount) then return allowed, family, mount end

	for _, id in ipairs(rules.sights) do
		if not POLICY.dovetailSights[id] or mount == "dovetail" then
			allowed[id] = true
		end
	end

	return allowed, family, mount
end

-- Donors that place the anchor's model in a slot with the same header and a proportional scale.
local function donorContexts(donorClasses, targetClass, anchorID, anchor, header)
	local contexts = {}
	for _, class in ipairs(donorClasses) do
		local swep = class ~= targetClass and weapons.Get(class)
		local donorAnchor = swep and swep.AttachmentModelsVM and swep.AttachmentModelsVM[anchorID]
		if isPlacement(donorAnchor) and donorAnchor.model == anchor.model then
			local _, slot = findSlot(swep, header, anchorID)
			local scale = slot and uniformScale(anchor.size or UNIT_SCALE, donorAnchor.size or UNIT_SCALE)
			if scale then
				contexts[#contexts + 1] = {class = class, swep = swep, anchor = donorAnchor, slot = slot, scale = scale}
			end
		end
	end

	return contexts
end

local function donorPlacement(context, id, anchor)
	local source = context.swep.AttachmentModelsVM[id]
	if not isPlacement(source) or not sameBone(source, context.anchor) then return end

	local offset, angle = transfer(source, context.anchor, anchor, context.scale)

	return {
		id = id,
		model = source.model,
		bone = anchor.bone,
		offset = offset,
		angle = angle,
		size = (source.size or UNIT_SCALE) * context.scale,
		isNew = true,
		donor = context.class,
		aimSource = {swep = context.swep, placement = source},
	}
end

--[[
	options: class, target, anchorID, anchor ({model, bone, angle, size}), header, donors, allowed,
	mount, reseat, and either authored (the target's own anchor entry) or seedSource ({swep, placement}).
	Existing models keep their authored offsets from the anchor unless `reseat` asks for donor offsets.
]]
local function buildSetup(options)
	local target, anchor, authored = options.target, options.anchor, options.authored
	local models = target.AttachmentModelsVM or {}
	local slotKey, slot = findSlot(target, options.header, authored and options.anchorID)
	if not slotKey then slotKey, slot = findSlot(target, options.header) end
	local contexts = donorContexts(options.donors, options.class, options.anchorID, anchor, options.header)
	local placements, ids = {}, {}
	local function add(data)
		if placements[data.id] then return end

		placements[data.id] = data
		ids[#ids + 1] = data.id
	end

	add({
		id = options.anchorID,
		model = anchor.model,
		bone = anchor.bone,
		offset = ZERO,
		angle = anchor.angle,
		size = anchor.size or UNIT_SCALE,
		isNew = not authored,
		authored = authored,
		aimSource = authored and {swep = target, placement = authored} or options.seedSource,
	})

	for _, id in ipairs(authored and slot and slot.atts or {}) do
		local entry = models[id]
		if id ~= options.anchorID and isPlacement(entry) and sameBone(entry, authored) then
			local data
			for _, context in ipairs(options.reseat and contexts or {}) do
				data = donorPlacement(context, id, anchor)
				if data and data.model == entry.model then break end
				data = nil
			end

			if data then
				data.isNew, data.angle, data.size = false, entry.angle, entry.size or UNIT_SCALE
			else
				local offset, angle = transfer(entry, authored, anchor, 1)
				data = {
					id = id,
					model = entry.model,
					bone = entry.bone,
					offset = offset,
					angle = anglesMatch(anchor.angle, authored.angle) and entry.angle or angle,
					size = entry.size or UNIT_SCALE,
					isNew = false,
				}
			end
			data.authored = entry
			data.aimSource = {swep = target, placement = entry}
			add(data)
		end
	end

	local candidates, seen = {}, {}
	for _, context in ipairs(contexts) do
		for _, id in ipairs(context.slot.atts or {}) do
			if not seen[id] then
				seen[id] = true
				candidates[#candidates + 1] = id
			end
		end
	end

	for _, id in ipairs(candidates) do
		if not placements[id] and not isPlacement(models[id]) and options.allowed[id] then
			for _, context in ipairs(contexts) do
				local data = donorPlacement(context, id, anchor)
				if data then
					add(data)
					break
				end
			end
		end
	end

	local needsRail = false
	for _, id in ipairs(ids) do
		local attachment = getAttachment(id)
		if placements[id].isNew and attachment and attachment.isSight and not attachment.withoutRail then
			needsRail = true
		end
	end

	-- Rail optics on a dovetail without a rail mount through the AK rail adapter.
	if needsRail and options.mount == "dovetail" and not isPlacement(models[RAIL_ID]) then
		for _, context in ipairs(contexts) do
			local rail = context.swep.AttachmentModelsVM[RAIL_ID]
			local data = isPlacement(rail) and rail.model == RAIL_ADAPTER and donorPlacement(context, RAIL_ID, anchor)
			if data then
				data.isRail = true
				add(data)
				break
			end
		end
	end

	local flags = {}
	if needsRail and (placements[RAIL_ID] or isPlacement(models[RAIL_ID])) and not target.SightWithRail then
		flags.SightWithRail = true
	end

	return {
		placements = placements,
		ids = ids,
		slotKey = slotKey or freeSlotKey(target),
		slot = slot,
		createSlot = slot == nil,
		header = options.header,
		flags = flags,
		donorCount = #contexts,
	}
end

local function computePositions(setup, anchorPos)
	local positions = {}
	for id, data in pairs(setup.placements) do
		positions[id] = anchorPos + data.offset
	end

	return positions
end

local function isChanged(data, pos)
	return data.isNew or not vectorsMatch(data.authored.pos, pos) or not anglesMatch(data.authored.angle, data.angle)
end

local function fitAims(target, setup, positions, samples)
	local fits, count = {}, 0
	if not samples then return fits, count end

	for _, id in ipairs(setup.ids) do
		local data = setup.placements[id]
		if isChanged(data, positions[id]) then
			fits[id] = fitScopeAim(target, data, positions[id], samples)
			count = count + (fits[id] and 1 or 0)
		end
	end

	return fits, count
end

local function roundNumber(value)
	return tonumber(string.format("%.6f", value))
end

local function vectorList(vector)
	return {roundNumber(vector.x), roundNumber(vector.y), roundNumber(vector.z)}
end

local function angleList(angle)
	return {roundNumber(angle.p), roundNumber(angle.y), roundNumber(angle.r)}
end

-- New sights without an aim offset would break aiming, so they are reported instead of exported.
local function buildExport(class, target, setup, positions, fits)
	local export = {
		version = 1,
		class = class,
		slot = {key = setup.slotKey, header = setup.header, create = setup.createSlot, offset = DEFAULT_SLOT_OFFSET},
		models = {},
		fields = {},
		attachments = {},
		skipped = {},
	}

	for _, id in ipairs(setup.ids) do
		local data = setup.placements[id]
		local attachment = getAttachment(id)
		local fit = fits[id]
		if data.isNew and attachment and attachment.aimPos and not fit then
			export.skipped[#export.skipped + 1] = id
		elseif isChanged(data, positions[id]) then
			export.models[#export.models + 1] = {
				id = id,
				model = data.model,
				bone = data.bone,
				pos = vectorList(positions[id]),
				angle = angleList(data.angle),
				size = vectorList(data.size),
				new = data.isNew,
				donor = data.donor,
			}
			if data.isNew and not data.isRail then
				export.attachments[#export.attachments + 1] = id
			end
			if fit then
				export.fields[#export.fields + 1] = {name = fit.aimKeys[1], kind = "vector", value = vectorList(fit.aimPos)}
				export.fields[#export.fields + 1] = {name = fit.aimKeys[2], kind = "vector", value = vectorList(fit.aimAng)}
			end
			if data.isNew and ALIGN_KEYS[id] and target[ALIGN_KEYS[id]] == nil then
				export.fields[#export.fields + 1] = {name = ALIGN_KEYS[id], kind = "align", value = {right = 0, up = 0, forward = 0}}
			end
		end
	end

	for name, value in SortedPairs(setup.flags) do
		export.fields[#export.fields + 1] = {name = name, kind = "bool", value = value}
	end

	return export
end

local function writeExport(export)
	file.CreateDir(OUTPUT_DIR)
	local path = OUTPUT_DIR .. "/" .. export.class .. ".json"
	file.Write(path, util.TableToJSON(export, true))

	return "data/" .. path
end

local function weaponCategory(class)
	for _, item in pairs(ix.item.list) do
		if item.class == class and item.weaponCategory then return item.weaponCategory end
	end
end

local function autoAnchor(class, target, donors)
	local _, slot = findSlot(target, SIGHT_HEADER)
	for _, id in ipairs(slot and slot.atts or {}) do
		local entry = target.AttachmentModelsVM[id]
		if isPlacement(entry) and #donorContexts(donors, class, id, entry, SIGHT_HEADER) > 0 then
			return id, entry
		end
	end
end

-- Generates exports for weapons whose sight slot already has a placed anchor shared with a donor.
local function runBatch(classes)
	for _, class in ipairs(classes) do
		local target = weapons.Get(class)
		local anchorID, anchor
		if target and target.AttachmentModelsVM then
			anchorID, anchor = autoAnchor(class, target, POLICY.donors)
		end

		if not anchorID then
			print(class .. ": no placed sight shared with a donor; use the editor's seed mode.")
		else
			local allowed, _, mount = allowedSights(class, target, weaponCategory(class))
			local setup = buildSetup({
				class = class, target = target, anchorID = anchorID, anchor = anchor, authored = anchor,
				header = SIGHT_HEADER, donors = POLICY.donors, allowed = allowed, mount = mount,
			})
			local positions = computePositions(setup, anchor.pos)
			local fits = fitAims(target, setup, positions, sampleIdleBone(target, anchor.bone))
			local export = buildExport(class, target, setup, positions, fits)
			if #export.models == 0 then
				print(string.format("%s: nothing to add (skipped: %s).", class, table.concat(export.skipped, ", ")))
			else
				print(string.format("%s: anchor %s, %d models, skipped %s -> %s", class, anchorID, #export.models,
					#export.skipped > 0 and table.concat(export.skipped, ", ") or "none", writeExport(export)))
			end
		end
	end
end

local function addCombo(parent, caption)
	local combo = ix.cotzUI.StyleCombo(parent:Add("DComboBox"))
	combo:Dock(TOP)
	combo:SetValue(caption)
	ix.cotzUI.SetHeight(combo, 32)

	return combo
end

local function addEntries(parent, caption, placeholders)
	ix.cotzUI.Label(parent, caption)
	local entries = {}
	for _, placeholder in ipairs(placeholders) do
		local entry = ix.cotzUI.StyleEntry(parent:Add("DTextEntry"))
		entry:Dock(TOP)
		entry:SetPlaceholderText(placeholder)
		entry:SetUpdateOnType(true)
		ix.cotzUI.SetHeight(entry, 28)
		entries[#entries + 1] = entry
	end

	return entries
end

local function setEntries(entries, values)
	for index, value in ipairs(values) do
		entries[index]:SetText(string.format("%.6f", value))
	end
end

local function readComponent(entry)
	local value = tonumber(entry:GetValue())
	if value and value == value and math.abs(value) < math.huge then return value end
end

local function readEntries(entries)
	local values = {}
	for index, entry in ipairs(entries) do
		values[index] = readComponent(entry)
		if not values[index] then return end
	end

	return values
end

local function openEditor(weapon, class, donors)
	if IsValid(editor) then editor:Remove() end

	local target = weapons.Get(class)
	local models = target.AttachmentModelsVM or {}
	local allowed, family, mount = allowedSights(class, target, weaponCategory(class))
	-- CW skips attachment drawing without this table, which would hide previews on bare weapons.
	local addedModelTable = weapon.AttachmentModelsVM == nil
	if addedModelTable then weapon.AttachmentModelsVM = {} end

	local frame, scroll = ix.cotzUI.Frame("CW Attachment Placement", 0.38, 0.8, 490)
	editor = frame
	frame:SetPos(ix.cotzUI.Scale(16), frame:GetY())

	local donorText = #donors > 0 and table.concat(donors, ", ") or "none (moves existing models)"
	ix.cotzUI.Label(scroll, string.format("%s  /  %s  /  mount: %s", class, family, mount or "none"))
	ix.cotzUI.Label(scroll, "Donors: " .. donorText)
	local anchorCombo = addCombo(scroll, "Choose an anchor or a seed")
	local previewCombo = addCombo(scroll, "Preview attachment")
	local boneCombo = addCombo(scroll, "Seed bone")
	local posEntries = addEntries(scroll, "Anchor position (X / Y / Z)", {"X", "Y", "Z"})
	local angleEntries = addEntries(scroll, "Anchor angle (P / Y / R)", {"P", "Y", "R"})
	local scaleEntries = addEntries(scroll, "Seed scale", {"Scale"})
	local reseat = scroll:Add("DCheckBoxLabel")
	reseat:Dock(TOP)
	reseat:SetText("Re-seat existing models from donors")
	local status = ix.cotzUI.Label(scroll, "")

	if IsValid(weapon.CW_VM) then
		for bone = 0, weapon.CW_VM:GetBoneCount() - 1 do
			local name = weapon.CW_VM:GetBoneName(bone)
			if name and name ~= "__INVALIDBONE__" then boneCombo:AddChoice(name, name) end
		end
	end

	local choice, setup, positions, previewID, slotIDs
	local seedBone
	local previewModel, previewModelID
	local function clearModel()
		if IsValid(previewModel) then previewModel:Remove() end
		previewModel, previewModelID = nil, nil
	end

	local function currentAnchor()
		local angles = readEntries(angleEntries)
		if not choice or not angles then return end

		local source = choice.authored or choice.seedSource.placement
		local size = source.size or UNIT_SCALE
		if not choice.authored then
			local scale = readEntries(scaleEntries)
			if not scale or scale[1] <= 0 then return end

			size = size * scale[1]
		end

		return {
			model = source.model,
			bone = choice.authored and source.bone or seedBone,
			angle = Angle(angles[1], angles[2], angles[3]),
			size = size,
		}
	end

	local function refresh()
		weapon.cotzAttachmentPreview = nil
		positions = nil
		local values = readEntries(posEntries)
		local data = setup and values and setup.placements[previewID]
		if not data then return end

		positions = computePositions(setup, Vector(values[1], values[2], values[3]))
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
			end
			local matrix = Matrix()
			matrix:Scale(data.size)
			previewModel:EnableMatrix("RenderMultiply", matrix)
			previewData = {ent = previewModel, _bone = bone, angle = data.angle}
		end

		weapon.cotzAttachmentPreview = {id = previewID, pos = positions[previewID], slot = slotIDs, data = previewData}
	end

	local function rebuild()
		setup = nil
		local anchor = currentAnchor()
		if anchor then
			setup = buildSetup({
				class = class, target = target, anchorID = choice.id, anchor = anchor, authored = choice.authored,
				seedSource = choice.seedSource, header = choice.header, donors = donors, allowed = allowed,
				mount = mount, reseat = reseat:GetChecked(),
			})
		end

		previewCombo:Clear()
		previewCombo:SetValue("Preview attachment")
		if not setup then
			status:SetText("Enter a valid anchor angle and scale.")
			refresh()
			return
		end

		slotIDs = {}
		for _, id in ipairs(setup.slot and setup.slot.atts or {}) do
			slotIDs[id] = true
		end
		if not setup.placements[previewID] then previewID = choice.id end
		for _, id in ipairs(setup.ids) do
			local label = setup.placements[id].isNew and string.format("%s (new, %s)", id, setup.placements[id].donor or "seed")
				or id
			previewCombo:AddChoice(label, id, id == previewID)
		end

		status:SetText(string.format("%d donors, %d models.", setup.donorCount, #setup.ids))
		refresh()
	end

	anchorCombo.OnSelect = function(_, _, _, selected)
		choice = selected
		previewID = selected.id
		clearModel()
		local source = selected.authored or selected.seedSource.placement
		setEntries(posEntries, {source.pos.x, source.pos.y, source.pos.z})
		setEntries(angleEntries, {source.angle.p, source.angle.y, source.angle.r})
		setEntries(scaleEntries, {1})
		boneCombo:SetEnabled(not selected.authored)
		if not selected.authored then
			local found = IsValid(weapon.CW_VM) and weapon.CW_VM:LookupBone(source.bone)
			seedBone = found and weapon.CW_VM:GetBoneName(found) or boneCombo:GetOptionData(1)
			boneCombo:SetValue(seedBone or "Seed bone")
		end
		rebuild()
	end

	boneCombo.OnSelect = function(_, _, _, bone)
		seedBone = bone
		clearModel()
		rebuild()
	end

	previewCombo.OnSelect = function(_, _, _, id)
		previewID = id
		refresh()
	end

	for _, entry in ipairs(posEntries) do
		entry.OnValueChange = refresh
	end
	for _, entry in ipairs(angleEntries) do
		entry.OnValueChange = rebuild
	end
	scaleEntries[1].OnValueChange = rebuild
	reseat.OnChange = rebuild

	for key, category in pairs(target.Attachments or {}) do
		for _, id in ipairs(category.atts or {}) do
			if isPlacement(models[id]) then
				local label = string.format("%s / %s (%s)", category.header or "Slot", id, key)
				anchorCombo:AddChoice(label, {id = id, authored = models[id], header = category.header})
			end
		end
	end

	local seeded = {}
	for _, donorClass in ipairs(donors) do
		local donor = weapons.Get(donorClass)
		local _, slot = donor and findSlot(donor, SIGHT_HEADER)
		for _, id in ipairs(slot and slot.atts or {}) do
			local placement = donor.AttachmentModelsVM and donor.AttachmentModelsVM[id]
			if allowed[id] and not seeded[id] and not isPlacement(models[id]) and isPlacement(placement) then
				seeded[id] = true
				anchorCombo:AddChoice(string.format("Seed / %s from %s", id, donorClass), {
					id = id, header = SIGHT_HEADER, seedSource = {swep = donor, placement = placement},
				})
			end
		end
	end

	ix.cotzUI.Button(scroll, "Save placements", function()
		if not setup or not positions then return end

		local anchor = setup.placements[choice.id]
		local fits, fitted = fitAims(target, setup, positions, sampleIdleBone(target, anchor.bone))
		local export = buildExport(class, target, setup, positions, fits)
		local path = writeExport(export)
		local skipped = #export.skipped > 0 and (" Skipped without aim: " .. table.concat(export.skipped, ", ")) or ""
		status:SetText(string.format("Saved %d models and %d aim offsets to %s.%s", #export.models, fitted, path, skipped))
	end)

	frame:CallOnRemove("cotz/attachment-placement/clear", function()
		clearModel()
		if not IsValid(weapon) then return end

		weapon.cotzAttachmentPreview = nil
		if addedModelTable then weapon.AttachmentModelsVM = nil end
	end)

	local think = frame.Think
	frame.Think = function(panel)
		think(panel)
		if not IsValid(weapon) or LocalPlayer():GetActiveWeapon() ~= weapon then panel:Remove() end
	end
end

local function canUseTool()
	local client = LocalPlayer()

	return IsValid(client) and (game.SinglePlayer() or client:IsListenServerHost()) and ix and ix.cotzUI and ix.item
end

concommand.Add("cotz_attachment_placement", function(_, _, args)
	if not canUseTool() then return end

	local weapon = LocalPlayer():GetActiveWeapon()
	if not IsValid(weapon) or not weapon.CW20Weapon then
		print("Equip a CW weapon to edit its attachment positions.")
		return
	end

	local class = weapon:GetClass()
	local donors = #args > 0 and args or POLICY.donors
	if args[1] == class then donors = {} end

	openEditor(weapon, class, donors)
end)

concommand.Add("cotz_attachment_batch", function(_, _, args)
	if not canUseTool() then return end

	local classes = args
	if #args == 0 or args[1] == "all" then
		local seen = {}
		classes = {}
		for _, item in SortedPairs(ix.item.list) do
			local class = item.class
			if isstring(class) and not seen[class] and weapons.IsBasedOn(class, "cw_base") then
				seen[class] = true
				classes[#classes + 1] = class
			end
		end
	end

	runBatch(classes)
end)

-- Exposed for the standalone spec; GMod ignores autorun return values.
return {
	allowedSights = allowedSights,
	buildSetup = buildSetup,
	buildExport = buildExport,
	computePositions = computePositions,
	deriveSightAxis = deriveSightAxis,
	fitScopeAim = fitScopeAim,
	sampleIdleBone = sampleIdleBone,
	sightGeometry = sightGeometry,
	modelPoint = modelPoint,
	aimRay = aimRay,
}
