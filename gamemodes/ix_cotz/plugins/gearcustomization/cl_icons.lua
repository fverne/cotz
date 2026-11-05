local renderContext
local definitionHashes = setmetatable({}, {__mode = "k"})
local itemIcons = setmetatable({}, {__mode = "k"})

function ix.gearAppearance.GetIcon(item)
	local config = item.appearanceCustomization
	local state = item:GetData("gearAppearance")
	if not config or not state then return end
	local cached = itemIcons[item]
	if not cached or cached.state ~= state or cached.definition ~= config then
		definitionHashes[config] = definitionHashes[config] or util.CRC(util.TableToJSON(config))
		local signature = item:GetModel() .. ix.gearAppearance.Fingerprint(item) .. definitionHashes[config]
		cached = {state = state, definition = config, key = "gear_" .. item.uniqueID .. "_" .. util.CRC(signature)}
		itemIcons[item] = cached
	end
	local key = cached.key
	local material = ikon:GetIcon(key)
	if material then return material end
	renderContext = item
	ikon:renderIcon(key, item.width, item.height, item:GetModel(), item.iconCam, nil, item:GetMaterial())
	renderContext = nil

	return ikon:GetIcon(key)
end

function PLUGIN:InstallIconRenderer()
	-- The bundled renderer has no appearance callback. Scope the detour to our own synchronous renders.
	local renderHook = ikon.renderHook
	function ikon:renderHook(...)
		local item = renderContext
		if not item then return renderHook(self, ...) end
		local entity = self.renderEntity
		local skin = entity:GetSkin()
		local materials, groups = {}, {}
		for _, index in ipairs(item.appearanceCustomization.worldMaterialSlots or {}) do
			materials[index] = entity:GetSubMaterial(index)
		end
		for _, group in ipairs(item.appearanceCustomization.bodygroups or {}) do
			local index = entity:FindBodygroupByName(group.worldGroup or group.group)
			if index >= 0 then groups[index] = entity:GetBodygroup(index) end
		end
		ix.gearAppearance.ApplyWorld(entity, item)
		renderHook(self, ...)
		entity:SetSkin(skin)
		for index, material in pairs(materials) do entity:SetSubMaterial(index, material) end
		for index, value in pairs(groups) do entity:SetBodygroup(index, value) end
	end
end
