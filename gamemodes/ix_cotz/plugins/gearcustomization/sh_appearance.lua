ix.gearAppearance = ix.gearAppearance or {}
ix.gearAppearance.price = 100
ix.gearAppearance.maxBodygroups = 16

local function findOption(options, id)
	for _, option in ipairs(options or {}) do
		if option.id == id then return option end
	end
end

local function targetNode(tree, path)
	local node = tree[path[1]]
	for index = 2, #path do
		node = node and node.children and node.children[path[index]]
	end

	return node
end

function ix.gearAppearance.ValidateDefinition(item)
	local config = item.appearanceCustomization
	local function validID(value)
		return type(value) == "string" and #value <= 64 and value:match("^[%w_%-]+$") ~= nil
	end
	local function validOptions(options, default, field)
		if type(options) ~= "table" then return false end
		local ids, found = {}, false
		for _, option in ipairs(options or {}) do
			local value = option[field]
			if not validID(option.id) or ids[option.id] or type(option.name) ~= "string"
				or type(value) ~= "number" or value < 0 or value % 1 ~= 0 then return false end
			ids[option.id] = true
			found = found or option.id == default
		end

		return found or #(options or {}) == 0
	end
	local function validTargets(targets)
		if type(targets) ~= "table" or #targets == 0 then return false end
		for _, path in ipairs(targets) do
			if type(path) ~= "table" or #path == 0 then return false end
			local node = targetNode(item.pacData, path)
			if not node or not node.self or not node.self.Model then return false end
		end

		return true
	end
	if not validTargets(config.targets) then return false, "missing PAC targets" end
	if not validOptions(config.skins, config.defaultSkin, "skin") then return false, "invalid skins/default" end
	local groups = {}
	if #(config.bodygroups or {}) > ix.gearAppearance.maxBodygroups then return false, "too many bodygroups" end
	for _, group in ipairs(config.bodygroups or {}) do
		if not validID(group.id) or groups[group.id] or type(group.name) ~= "string"
			or type(group.group) ~= "string" or not validTargets(group.targets or config.targets)
			or type(group.options) ~= "table" or #group.options == 0
			or not validOptions(group.options, group.default, "value") then return false, "invalid bodygroup" end
		groups[group.id] = true
	end

	return true
end

function ix.gearAppearance.GetConfiguration(item)
	if not item.isBodyArmor then return item.appearanceCustomization end
	if not item.skincustom or not next(item.skincustom) then return end
	local skins = {}
	for _, paint in pairs(item.skincustom) do
		local name = paint.name:gsub("[Ss]kin", "Finish")
		skins[#skins + 1] = {id = tostring(paint.skingroup), name = name, skin = paint.skingroup,
			model = paint.modelOverride}
	end
	table.sort(skins, function(first, second) return first.skin < second.skin end)

	return {skins = skins, defaultSkin = tostring(item.newSkin or 0), bodygroups = {}}
end

function ix.gearAppearance.CanCustomize(item, character, target)
	if item.isBodyArmor then
		return ix.gearAppearance.GetConfiguration(item) ~= nil
			and ix.townNPCs:HasService(character, "painting", target:GetDisplayName())
	end

	return ix.gearAppearance.IsSupported(item)
end

function ix.gearAppearance.IsSupported(item)
	local config = item.appearanceCustomization
	if not config or not item.pacData or item.isBodyArmor then return false end
	if #(config.skins or {}) > 1 then return true end
	for _, group in ipairs(config.bodygroups or {}) do
		if #group.options > 1 then return true end
	end

	return false
end

function ix.gearAppearance.Normalize(item, state, strict)
	local config = ix.gearAppearance.GetConfiguration(item)
	if not config then return end
	if not state and item.isBodyArmor then
		state = {skin = tostring(item:GetData("setSkin", item.newSkin or 0)), bodygroups = {}}
	end
	state = state or item:GetData("gearAppearance", {})
	if type(state) ~= "table" or type(state.bodygroups or {}) ~= "table" then return end
	local skin = findOption(config.skins, state.skin)
	if strict and (not skin and #(config.skins or {}) > 0) then return end
	local result = {skin = skin and skin.id or config.defaultSkin or "", bodygroups = {}}
	local known = {}
	for _, group in ipairs(config.bodygroups or {}) do
		known[group.id] = true
		local option = findOption(group.options, (state.bodygroups or {})[group.id])
		if strict and not option then return end
		result.bodygroups[group.id] = option and option.id or group.default
	end
	if strict then
		if result.skin ~= (state.skin or "") then return end
		for id in pairs(state.bodygroups or {}) do
			if not known[id] then return end
		end
	end

	return result
end

function ix.gearAppearance.Fingerprint(item, state)
	local normalized = ix.gearAppearance.Normalize(item, state)
	if not normalized then return "" end
	local parts = {normalized.skin}
	for _, group in ipairs(ix.gearAppearance.GetConfiguration(item).bodygroups or {}) do
		parts[#parts + 1] = group.id .. "=" .. normalized.bodygroups[group.id]
	end

	return table.concat(parts, ";")
end

function ix.gearAppearance.Describe(item, state)
	local normalized = ix.gearAppearance.Normalize(item, state)
	if not normalized then return "Factory appearance" end
	local parts = {}
	local skin = findOption(ix.gearAppearance.GetConfiguration(item).skins, normalized.skin)
	if skin then parts[#parts + 1] = skin.name end
	for _, group in ipairs(ix.gearAppearance.GetConfiguration(item).bodygroups or {}) do
		local option = findOption(group.options, normalized.bodygroups[group.id])
		if option then parts[#parts + 1] = group.name .. ": " .. option.name end
	end

	return table.concat(parts, ", ")
end

local function applyBodygroup(node, name, value)
	node.children = node.children or {}
	for _, child in ipairs(node.children) do
		if child.self.ClassName == "bodygroup" and child.self.BodyGroupName == name then
			child.self.ModelIndex = value

			return
		end
	end
	node.children[#node.children + 1] = {
		self = {ClassName = "bodygroup", BodyGroupName = name, ModelIndex = value}, children = {},
	}
end

function ix.gearAppearance.BuildPAC(item, state, instanceKey, source)
	local config = item.appearanceCustomization
	local normalized = ix.gearAppearance.Normalize(item, state)
	local tree = table.Copy(source or item.pacData)
	if not config or not normalized then return tree end
	local skin = findOption(config.skins, normalized.skin)
	for _, path in ipairs(config.targets or {}) do
		local node = targetNode(tree, path)
		if node and skin then node.self.Skin = skin.skin end
	end
	for _, group in ipairs(config.bodygroups or {}) do
		local option = findOption(group.options, normalized.bodygroups[group.id])
		for _, path in ipairs(group.targets or config.targets or {}) do
			local node = targetNode(tree, path)
			if node and option then applyBodygroup(node, group.group, option.value) end
		end
	end
	local references = {}
	local function identify(nodes, prefix)
		for index, node in ipairs(nodes) do
			local path = prefix .. "/" .. index
			local id = "cotz/gear/" .. instanceKey .. path
			if node.self.UniqueID then references[node.self.UniqueID] = references[node.self.UniqueID] or id end
			node.self.UniqueID = id
			identify(node.children or {}, path)
		end
	end
	local function remap(nodes)
		for _, node in ipairs(nodes) do
			for key, value in pairs(node.self) do
				if key:sub(-3) == "UID" and references[value] then node.self[key] = references[value] end
			end
			remap(node.children or {})
		end
	end
	identify(tree, "")
	remap(tree)

	return tree
end

function ix.gearAppearance.ApplyWorld(entity, item, state)
	local normalized = ix.gearAppearance.Normalize(item, state)
	if not normalized then return end
	local config = item.appearanceCustomization
	local skin = findOption(config.skins, normalized.skin)
	entity:SetSkin(skin and skin.worldSkin or item.skin or 0)
	for _, index in ipairs(config.worldMaterialSlots or {}) do
		entity:SetSubMaterial(index, skin and skin.worldMaterials and skin.worldMaterials[index] or nil)
	end
	for _, group in ipairs(config.bodygroups or {}) do
		local option = findOption(group.options, normalized.bodygroups[group.id])
		local index = entity:FindBodygroupByName(group.worldGroup or group.group)
		if index >= 0 and option and option.worldValue ~= nil then entity:SetBodygroup(index, option.worldValue) end
	end
end

function ix.gearAppearance.WriteState(state)
	net.WriteString(state.skin or "")
	local ids = table.GetKeys(state.bodygroups or {})
	table.sort(ids)
	net.WriteUInt(#ids, 5)
	for _, id in ipairs(ids) do
		net.WriteString(id)
		net.WriteString(state.bodygroups[id])
	end
end

function ix.gearAppearance.ReadState()
	local state = {skin = net.ReadString(), bodygroups = {}}
	local count = net.ReadUInt(5)
	if #state.skin > 64 or count > ix.gearAppearance.maxBodygroups then return end
	for _ = 1, count do
		local id, option = net.ReadString(), net.ReadString()
		if #id > 64 or #option > 64 or state.bodygroups[id] then return end
		state.bodygroups[id] = option
	end

	return state
end

function ix.gearAppearance.WriteDescriptor(descriptor)
	net.WriteBool(type(descriptor) == "table")
	if type(descriptor) ~= "table" then return end
	net.WriteUInt(descriptor.itemID, 32)
	ix.gearAppearance.WriteState(descriptor.appearance)
end

function ix.gearAppearance.ReadDescriptor()
	if not net.ReadBool() then return true end
	local id = net.ReadUInt(32)
	local state = ix.gearAppearance.ReadState()
	if not state then return end

	return {itemID = id, appearance = state}
end
