local SETUP_FIELDS = {"areas", "templates", "entrances", "locations"}
local DEFINITION_FIELDS = {
	areas = {"mins", "maxs"},
	templates = {
		"dupe", "mins", "maxs", "spawns", "spawnAngles", "facing", "exit", "exitAngles",
		"storage", "storageAngles", "vendor", "vendorAngles", "containers",
	},
	entrances = {"pos", "angles", "outside", "invisible"},
	locations = {"template", "entrance", "name"},
}

local function finite(value)
	return isnumber(value) and value == value and math.abs(value) < math.huge
end

local function validVector(value)
	return isvector(value) and finite(value.x) and finite(value.y) and finite(value.z)
end

local function validAngle(value)
	return isangle(value) and finite(value.p) and finite(value.y) and finite(value.r)
end

local function validBounds(definition)
	local mins, maxs = definition.mins, definition.maxs

	return validVector(mins) and validVector(maxs) and mins.x < maxs.x and mins.y < maxs.y and mins.z < maxs.z
end

function PLUGIN:GetFTSData()
	if not self.ready then return {} end
	local data = {}
	for _, field in ipairs(SETUP_FIELDS) do
		data[field] = {}
		for id, definition in pairs(self.state[field] or {}) do
			-- Squad-placed entrances belong to individual saved hideouts, not the reusable map setup.
			if field ~= "entrances" or not definition.hideout then
				local exported = {}
				for _, key in ipairs(DEFINITION_FIELDS[field]) do exported[key] = definition[key] end
				data[field][id] = table.Copy(exported)
			end
		end
	end
	data.recovery = self.state.recovery

	return table.Copy(data)
end

local function validateTemplate(plugin, template)
	if not validBounds(template) or not isstring(template.dupe) or template.dupe == ""
		or not istable(template.spawns) or #template.spawns == 0 or #template.spawns > 8 then
		return false, "Invalid template bounds, dupe name or spawn candidates."
	end
	for _, position in ipairs(template.spawns) do
		if not validVector(position) or not plugin:Contains(position, template.mins, template.maxs) then
			return false, "A template spawn is outside its bounds."
		end
	end
	for _, key in ipairs({"exit", "storage", "vendor"}) do
		local position = template[key]
		if (key ~= "vendor" or position ~= nil)
			and (not validVector(position) or not plugin:Contains(position, template.mins, template.maxs)) then
			return false, "Invalid template point: " .. key
		end
	end
	for _, key in ipairs({"facing", "exitAngles", "storageAngles", "vendorAngles"}) do
		if template[key] ~= nil and not validAngle(template[key]) then return false, "Invalid template angle." end
	end
	if template.spawnAngles ~= nil and not istable(template.spawnAngles) then
		return false, "Invalid spawn angles."
	end
	for _, angles in pairs(template.spawnAngles or {}) do
		if not validAngle(angles) then return false, "Invalid spawn angle." end
	end
	if template.containers ~= nil and not istable(template.containers) then
		return false, "Invalid template containers."
	end
	if table.Count(template.containers or {}) > 32 then return false, "A template can have at most 32 containers." end
	for id, container in pairs(template.containers or {}) do
		if not istable(container) or not validVector(container.pos)
			or not plugin:Contains(container.pos, template.mins, template.maxs)
			or container.angles ~= nil and not validAngle(container.angles) then
			return false, "Invalid container transform: " .. tostring(id)
		end
		local ok, reason = plugin:ValidateMarkerSettings("container", id, container.recipe)
		if not ok then return false, reason end
	end
	local integration = ix.plugin.Get("advdupeint")
	if not integration then return false, "AdvDupe integration is unavailable." end
	local dupe, reason = integration:ReadDupe(template.dupe)
	if not dupe then return false, reason end

	return plugin:ValidateDupe(dupe, template)
end

local function validateDefinition(plugin, field, definition)
	if field == "areas" then return validBounds(definition), "Invalid allocation area bounds." end
	if field == "templates" then return validateTemplate(plugin, definition) end
	if field == "entrances" then
		return not definition.hideout and validVector(definition.pos) and validVector(definition.outside)
			and validAngle(definition.angles), "Invalid fixed entrance."
	end

	return isstring(definition.template) and isstring(definition.entrance) and isstring(definition.name),
		"Invalid trader location."
end

function PLUGIN:ImportFTSData(payload)
	if not istable(payload) then return false, "Expected a hideout setup table." end
	if not next(payload) then return true end
	if not self.ready then return false, "Hideout data is not ready." end
	if next(self.instances) then return false, "Unload all hideouts before importing setup." end
	for field in pairs(payload) do
		if not DEFINITION_FIELDS[field] and field ~= "recovery" then
			return false, "Unsupported hideout setup field: " .. tostring(field)
		end
	end
	local staged = {}
	for _, field in ipairs(SETUP_FIELDS) do
		if payload[field] ~= nil and not istable(payload[field]) then return false, "Invalid setup field: " .. field end
		staged[field] = table.Copy(self.state[field] or {})
		for id, definition in pairs(payload[field] or {}) do
			if not isstring(id) or id == "" or not istable(definition) then return false, "Invalid setup definition." end
			-- Existing IDs are authoritative. Applying a preset must not rebind owned rooms or saved container slots.
			if not staged[field][id] then
				local ok, reason = validateDefinition(self, field, definition)
				if not ok then return false, field .. "/" .. id .. ": " .. reason end
				local imported = {}
				for _, key in ipairs(DEFINITION_FIELDS[field]) do imported[key] = definition[key] end
				staged[field][id] = table.Copy(imported)
			end
		end
	end
	for id, location in pairs(staged.locations) do
		local entrance = staged.entrances[location.entrance]
		if not staged.templates[location.template] or not entrance or entrance.hideout then
			return false, "Trader location " .. id .. " needs a template and fixed entrance."
		end
	end
	if payload.recovery ~= nil and not validVector(payload.recovery) then return false, "Invalid recovery position." end
	local previous = {recovery = self.state.recovery}
	for _, field in ipairs(SETUP_FIELDS) do
		previous[field], self.state[field] = self.state[field], staged[field]
	end
	self.state.recovery = self.state.recovery or payload.recovery
	if not self:Persist() then
		for _, field in ipairs(SETUP_FIELDS) do self.state[field] = previous[field] end
		self.state.recovery = previous.recovery

		return false, "Could not save hideout setup."
	end
	self:SpawnEntrances()

	return true
end
