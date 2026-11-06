local PLUGIN = PLUGIN
local DUMP_COOLDOWN = 5
local nextDumpTime = 0

local function getAppearanceEntity(entity)
	if entity:GetClass() == "prop_effect" and IsValid(entity.AttachedEntity) then
		return entity.AttachedEntity
	end

	return entity
end

local function serialize(value, depth)
	if isvector(value) then
		return string.format("Vector(%.17g, %.17g, %.17g)", value.x, value.y, value.z)
	elseif isangle(value) then
		return string.format("Angle(%.17g, %.17g, %.17g)", value.p, value.y, value.r)
	elseif IsColor(value) then
		return string.format("Color(%d, %d, %d, %d)", value.r, value.g, value.b, value.a)
	elseif isstring(value) then
		return string.format("%q", value)
	elseif isnumber(value) then
		return string.format("%.17g", value)
	elseif isbool(value) then
		return tostring(value)
	end

	local keys = {}

	for key in pairs(value) do
		keys[#keys + 1] = key
	end

	table.sort(keys)

	local lines = {"{"}

	for _, key in ipairs(keys) do
		local name = isnumber(key) and ("[" .. key .. "]") or key
		lines[#lines + 1] = string.rep("\t", depth + 1) .. name .. " = " .. serialize(value[key], depth + 1) .. ","
	end

	lines[#lines + 1] = string.rep("\t", depth) .. "}"

	return table.concat(lines, "\n")
end

function PLUGIN:GetPersistentEntityData(entity)
	local appearance = getAppearanceEntity(entity)
	local data = {
		class = entity.ClassOverride or entity:GetClass(),
		position = entity:GetPos(),
		angles = entity:GetAngles(),
		model = appearance:GetModel(),
		skin = appearance:GetSkin(),
		color = appearance:GetColor(),
		material = appearance:GetMaterial(),
		renderMode = appearance:GetRenderMode(),
		renderFX = appearance:GetRenderFX(),
		modelScale = appearance:GetModelScale(),
		collisionGroup = entity:GetCollisionGroup(),
		bodygroups = {},
		submaterials = {},
		persistent = true,
	}

	for _, group in ipairs(appearance:GetBodyGroups() or {}) do
		data.bodygroups[group.id] = appearance:GetBodygroup(group.id)
	end

	for index in ipairs(appearance:GetMaterials() or {}) do
		local material = appearance:GetSubMaterial(index - 1)

		if material ~= "" then
			data.submaterials[index - 1] = material
		end
	end

	local physicsObject = entity:GetPhysicsObject()

	if IsValid(physicsObject) then
		data.movable = physicsObject:IsMoveable()
	end

	return data
end

function PLUGIN:DumpPersistentEntities()
	local persistence = ix.plugin.list["persistence"]

	if not persistence then
		return nil, "The Helix persistence plugin is not loaded."
	end
	if CurTime() < nextDumpTime then
		return nil, "Please wait a few seconds before dumping persistent entities again."
	end

	nextDumpTime = CurTime() + DUMP_COOLDOWN

	local entities = {}
	local seen = {}

	for _, entity in ipairs(persistence.stored) do
		if IsValid(entity) and entity:GetNetVar("Persistent", false) and not seen[entity] then
			seen[entity] = true
			entities[#entities + 1] = entity
		end
	end

	table.sort(entities, function(left, right)
		return left:EntIndex() < right:EntIndex()
	end)

	local lines = {"entities = {"}

	for _, entity in ipairs(entities) do
		lines[#lines + 1] = "\t" .. serialize(self:GetPersistentEntityData(entity), 1) .. ","
	end

	lines[#lines + 1] = "},\n"

	local filename = "ftsdump/" .. game.GetMap():lower() .. "_persistent_entities.txt"
	local contents = table.concat(lines, "\n")
	file.CreateDir("ftsdump")
	file.Write(filename, contents)

	if file.Read(filename, "DATA") ~= contents then
		return nil, "Could not write the persistent entity dump. Check the server console and data folder permissions."
	end

	return filename, #entities
end

function PLUGIN:SpawnEntity(data)
	local persistence = ix.plugin.list["persistence"]

	if data.persistent and not persistence then
		ErrorNoHalt("[FTS] Cannot spawn persistent entity without the Helix persistence plugin.\n")
		return
	end

	local entity = ents.Create(data.class)

	if not IsValid(entity) then
		ErrorNoHalt("[FTS] Could not create entity class " .. tostring(data.class) .. ".\n")
		return
	end

	entity:SetPos(data.position)
	entity:SetAngles(data.angles)

	if data.model then
		entity:SetModel(data.model)
	end

	entity:Spawn()
	entity:Activate()

	local appearance = getAppearanceEntity(entity)

	if data.skin ~= nil then appearance:SetSkin(data.skin) end
	if data.color then appearance:SetColor(data.color) end
	if data.material then appearance:SetMaterial(data.material) end
	if data.renderMode ~= nil then appearance:SetRenderMode(data.renderMode) end
	if data.renderFX ~= nil then appearance:SetRenderFX(data.renderFX) end
	if data.modelScale then appearance:SetModelScale(data.modelScale, 0) end
	if data.collisionGroup ~= nil then entity:SetCollisionGroup(data.collisionGroup) end

	for id, value in pairs(data.bodygroups or {}) do
		appearance:SetBodygroup(id, value)
	end

	for index, material in pairs(data.submaterials or {}) do
		appearance:SetSubMaterial(index, material)
	end

	local physicsObject = entity:GetPhysicsObject()

	if IsValid(physicsObject) then
		-- Existing presets omit movable and retain FTS's original frozen default.
		physicsObject:EnableMotion(data.movable == true)

		if not data.movable then
			physicsObject:Sleep()
		end
	end

	if data.persistent then
		persistence.stored[#persistence.stored + 1] = entity
		entity:SetNetVar("Persistent", true)
	end

	return entity
end
