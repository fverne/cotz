local PLUGIN = PLUGIN
local MARKER_CLASS = "ix_hideout_marker"
local USE_DISTANCE_SQUARED = 128 * 128
local MAX_CONTAINERS = 32
local MAX_SPAWNS = 8
util.AddNetworkString("cotz/hideouts/marker")
util.AddNetworkString("cotz/hideouts/marker-save")

function PLUGIN:ApplyMarkerSettings(entity, role, slotID, recipeID)
	local ok, reason = self:ValidateMarkerSettings(role, slotID, recipeID)
	if not ok then return false, reason end
	entity:SetMarkerRole(role)
	entity:SetSlotID(role == "container" and slotID or "")
	entity:SetRecipeID(role == "container" and recipeID or "")
	entity:SetModel(self.markerRoles[role].model)
	entity:PhysicsInit(SOLID_VPHYSICS)
	entity:SetSolid(SOLID_VPHYSICS)
	local physics = entity:GetPhysicsObject()
	if IsValid(physics) then physics:EnableMotion(false) end

	return true
end

duplicator.RegisterEntityModifier("cotzHideoutMarker", function(_, entity, data)
	if not IsValid(entity) or entity:GetClass() ~= MARKER_CLASS then return end
	local ok = istable(data) and PLUGIN:ApplyMarkerSettings(entity, data.role, data.slot, data.recipe)
	if not ok then entity:SetMarkerRole("") end
end)

function PLUGIN:CanEditMarker(client, entity)
	return client:IsAdmin() and IsValid(entity) and entity:GetClass() == MARKER_CLASS
		and not entity.ixHideout and not self:FindInstance(entity:GetPos())
		and client:GetPos():DistToSqr(entity:GetPos()) <= USE_DISTANCE_SQUARED
end

function PLUGIN:OpenMarkerMenu(client, entity)
	if not self:CanEditMarker(client, entity) or (client.cotzMarkerNextOpen or 0) > CurTime() then return end
	client.cotzMarkerNextOpen = CurTime() + 0.5
	client.cotzMarkerEditor = {entity = entity, character = client:GetCharacter(), expires = CurTime() + 120}
	net.Start("cotz/hideouts/marker")
	net.WriteEntity(entity)
	net.Send(client)
end

function PLUGIN:SaveMarkerSettings(client, entity, role, slotID, recipeID)
	if (client.cotzMarkerNextSave or 0) > CurTime() then return false end
	client.cotzMarkerNextSave = CurTime() + 0.5
	local session = client.cotzMarkerEditor
	if not session or session.entity ~= entity or session.character ~= client:GetCharacter()
		or session.expires < CurTime() or not self:CanEditMarker(client, entity) then return false end
	local ok, reason = self:ApplyMarkerSettings(entity, role, slotID, recipeID)
	if not ok then client:Notify(reason) return false end
	client.cotzMarkerEditor = nil
	client:Notify("Hideout marker updated. Save it with the shell in AdvDupe2.")

	return true
end

net.Receive("cotz/hideouts/marker-save", function(_, client)
	PLUGIN:SaveMarkerSettings(client, net.ReadEntity(), net.ReadString(), net.ReadString(), net.ReadString())
end)

local function finite(value)
	return isnumber(value) and value == value and value > -math.huge and value < math.huge
end

local function captureMarker(plugin, resolved, record, entity, instance, seen)
	local role, slotID, recipeID = entity:GetMarkerRole(), entity:GetSlotID(), entity:GetRecipeID()
	local ok, reason = plugin:ValidateMarkerSettings(role, slotID, recipeID)
	if not ok then return false, reason end
	local position = entity:GetPos() - instance.origin
	local angles = entity:GetAngles()
	if not finite(position.x) or not finite(position.y) or not finite(position.z)
		or not finite(angles.p) or not finite(angles.y) or not finite(angles.r)
		or not plugin:Contains(position, resolved.mins, resolved.maxs) then
		return false, "A hideout marker is outside the template bounds or has an invalid transform."
	end
	if role == "spawn" then
		resolved.spawns = seen.spawn and resolved.spawns or {}
		resolved.spawnAngles = resolved.spawnAngles or {}
		if #resolved.spawns >= MAX_SPAWNS then return false, "A template can have at most 8 spawn markers." end
		table.insert(resolved.spawns, position)
		table.insert(resolved.spawnAngles, Angle(0, angles.y, 0))
	elseif role == "container" then
		resolved.containers = seen.container and resolved.containers or {}
		if resolved.containers[slotID] then return false, "Duplicate hideout container slot: " .. slotID end
		if table.Count(resolved.containers) >= MAX_CONTAINERS then
			return false, "A template can have at most 32 container markers."
		end
		local saved = (record.containers or {})[slotID]
		local previous = plugin.state.templates[record.template].containers or {}
		local recipe = saved and saved.recipe or previous[slotID] and previous[slotID].recipe
		if recipe and recipe ~= recipeID then
			return false, "Container " .. slotID .. " changed recipe; keep its recipe or use a new slot ID."
		end
		resolved.containers[slotID] = {pos = position, angles = angles, recipe = recipeID}
	else
		if seen[role] then return false, "Duplicate hideout marker role: " .. role end
		resolved[role], resolved[role .. "Angles"] = position, angles
	end
	seen[role] = true

	return true
end

function PLUGIN:ResolveTemplateMarkers(instance, source, template)
	-- Unmarked fields inherit manual configuration, including live admin point edits.
	local resolved = setmetatable({}, {__index = template})
	local seen, markers = {}, {}
	local keys = table.GetKeys(source)
	table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
	for _, key in ipairs(keys) do
		local entity = source[key]
		if not IsValid(entity) or entity:GetClass() ~= MARKER_CLASS then continue end
		local ok, reason = captureMarker(self, resolved, self:GetHideout(instance.id), entity, instance, seen)
		if not ok then return nil, reason end
		markers[#markers + 1] = entity
	end
	for _, entity in ipairs(markers) do entity:Remove() end
	resolved.dupeMarkerRoles = seen

	return next(seen) and resolved or template
end

function PLUGIN:GetSpawnFacing(instance, position)
	local template = self:GetTemplate(self:GetHideout(instance.id))
	for index, offset in ipairs(template.spawns) do
		if position:DistToSqr(instance.origin + offset) < 1 then
			return template.spawnAngles and template.spawnAngles[index] or template.facing or angle_zero
		end
	end

	return template.facing or angle_zero
end
