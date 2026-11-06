local PLUGIN = PLUGIN
local POINT_LIFT = Vector(0, 0, 8)
local MAX_TEXT_LENGTH = 128
local ENTITY_PREFIXES = {"ix_", "npc_mutant_", "npc_human_", "anom_", "sanom_", "rad_"}

util.AddNetworkString("cotz/camera/photo")

function PLUGIN:IsPhotoPointVisible(position, photo, entity)
	local offset = position - photo.origin
	local depth = offset:Dot(photo.angles:Forward())
	if depth <= 0 or offset:LengthSqr() > self.photoRange ^ 2 then return false end

	local halfWidth = depth * math.tan(math.rad(self.photoFOV / 2))
	if math.abs(offset:Dot(photo.angles:Right())) > halfWidth then return false end
	if math.abs(offset:Dot(photo.angles:Up())) > halfWidth / self.photoAspect then return false end

	local trace = util.TraceLine({
		start = photo.origin,
		endpos = position,
		filter = {photo.client, photo.weapon},
		mask = MASK_VISIBLE,
	})

	return not trace.StartSolid and (not trace.Hit or (IsValid(entity) and trace.Entity == entity))
end

function PLUGIN:IsPhotoEntityVisible(entity, photo)
	if self:IsPhotoPointVisible(entity:WorldSpaceCenter(), photo, entity) then return true end

	local minimum, maximum = entity:OBBMins(), entity:OBBMaxs()
	for corner = 0, 7 do
		local position = Vector(
			bit.band(corner, 1) == 0 and minimum.x or maximum.x,
			bit.band(corner, 2) == 0 and minimum.y or maximum.y,
			bit.band(corner, 4) == 0 and minimum.z or maximum.z
		)
		if self:IsPhotoPointVisible(entity:LocalToWorld(position), photo, entity) then return true end
	end

	return false
end

local function isCotzEntity(entity)
	local class = entity:GetClass()

	for _, prefix in ipairs(ENTITY_PREFIXES) do
		if string.sub(class, 1, #prefix) == prefix then return true end
	end

	return class == "teleport" or entity.IsSTALKERNPC == true
end

local function addSubject(photo, subject, limit)
	if #photo.subjects >= limit then
		photo.truncated = true

		return
	end

	subject.id = string.sub(subject.id, 1, MAX_TEXT_LENGTH)
	subject.class = string.sub(subject.class, 1, MAX_TEXT_LENGTH)
	subject.label = string.sub(subject.label, 1, MAX_TEXT_LENGTH)
	photo.subjects[#photo.subjects + 1] = subject
end

function PLUGIN:CollectPhotoSubjects(photo)
	for _, entity in ipairs(ents.FindInSphere(photo.origin, self.photoRange)) do
		if entity ~= photo.client and entity ~= photo.weapon and isCotzEntity(entity)
			and not entity:GetNoDraw() and self:IsPhotoEntityVisible(entity, photo) then
			addSubject(photo, {
				kind = "entity",
				entity = entity,
				id = tostring(entity:EntIndex()),
				class = entity:GetClass(),
				label = entity:GetClass() .. " #" .. entity:EntIndex(),
				position = entity:WorldSpaceCenter(),
			}, self.maxPhotoSubjects)
		end
	end

	local spawns = ix.plugin.Get("spawnpointesp")
	if not spawns then return end

	for _, category in ipairs(spawns.spawnCategories) do
		for _, point in ipairs(spawns:CollectSpawnPoints(category)) do
			if self:IsPhotoPointVisible(point.position + POINT_LIFT, photo, point.entity) then
				addSubject(photo, {
					kind = "spawnpoint",
					id = category.key .. "/" .. point.id,
					class = category.key,
					label = category.name .. " [" .. point.label .. "]",
					position = point.position,
				}, self.maxPhotoSubjects)
			end
		end
	end
end

function PLUGIN:TakePhoto(client, weapon)
	if not IsValid(client) or not client:IsPlayer() or not client:Alive() or not client:GetCharacter() then return end
	if not IsValid(weapon) or weapon:GetClass() ~= "ix_camera" then return end
	if weapon:GetOwner() ~= client or client:GetActiveWeapon() ~= weapon then return end
	if client:InVehicle() or client:GetViewEntity() ~= client then return end
	if (client.ixNextCameraPhoto or 0) > CurTime() then return end

	client.ixNextCameraPhoto = CurTime() + self.photoCooldown
	local photo = {
		client = client,
		weapon = weapon,
		characterID = client:GetCharacter():GetID(),
		map = game.GetMap(),
		origin = client:GetShootPos(),
		angles = client:EyeAngles(),
		subjects = {},
		truncated = false,
	}
	self:CollectPhotoSubjects(photo)
	-- Only the latest result is retained. Entity IDs are session references, not persistent job identities.
	weapon.lastPhoto = photo
	hook.Run("cotz/camera/photo-taken", photo)
	weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	net.Start("cotz/camera/photo")
	net.WriteVector(photo.origin)
	net.WriteAngle(photo.angles)
	net.WriteBool(photo.truncated)
	net.WriteUInt(#photo.subjects, 8)
	for _, subject in ipairs(photo.subjects) do
		net.WriteBool(subject.kind == "spawnpoint")
		net.WriteString(subject.id)
		net.WriteString(subject.class)
		net.WriteString(subject.label)
		net.WriteVector(subject.position)
	end
	net.Send(client)

	return photo
end
