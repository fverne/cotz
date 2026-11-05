local serial = 0
local function marker(role, slotID, recipeID, position, angles)
	serial = serial + 1
	local entity = ents.Create("ix_hideout_marker")
	for key, value in pairs(TEST_MARKER_ENTITY) do entity[key] = value end
	function entity:NetworkVar(_, _, name)
		self["Get" .. name] = function(self) return self["test" .. name] or "" end
		self["Set" .. name] = function(self, value) self["test" .. name] = value end
	end
	function entity:SetSolid() end
	function entity:SetUseType() end
	function entity:EntIndex() return serial end
	function entity:GetNetVar(key, default) return self[key] == nil and default or self[key] end
	entity:SetupDataTables()
	entity:Initialize()
	assert(PLUGIN:ApplyMarkerSettings(entity, role, slotID or "", recipeID or ""))
	entity:SetPos(position or Vector())
	entity:SetAngles(angles or Angle())

	return entity
end

local function home()
	FeatureReset()
	local owner = FeatureClient(1)
	local instance, record = FeatureHome(owner)
	local template = PLUGIN.state.templates.room
	template.mins, template.maxs = Vector(-200, -200, -16), Vector(200, 200, 200)
	template.containers = {old = {pos = Vector(), recipe = "general"}}

	return instance, record, template, owner
end

Test("markers retain their settings through the entity duplicator modifier", function()
	FeatureReset()
	local original = marker("container", "ammo_shelf", "ammo")
	local data
	duplicator.StoreEntityModifier = function(entity, name, value)
		assert(entity == original and name == "cotzHideoutMarker")
		data = table.Copy(value)
	end
	original:PreEntityCopy()
	local pasted = marker("container", "temporary", "general")
	TEST_MARKER_MODIFIER(nil, pasted, data)
	assert(pasted:GetMarkerRole() == "container" and pasted:GetSlotID() == "ammo_shelf")
	assert(pasted:GetRecipeID() == "ammo")
	TEST_MARKER_MODIFIER(nil, pasted, {role = "container", slot = "ammo_shelf", recipe = "invalid"})
	assert(pasted:GetMarkerRole() == "", "invalid saved settings must fail loading rather than change meaning")
end)

Test("dupe markers resolve exact local positions and angles without changing manual configuration", function()
	local instance, record, template = home()
	local exit = marker("exit", nil, nil, instance.origin + Vector(12, 36, 24), Angle(0, 90, 0))
	local spawn = marker("spawn", nil, nil, instance.origin + Vector(0, 0, 8), Angle(10, 180, 20))
	local container = marker("container", "left", "ammo", instance.origin + Vector(60, 0, 24))
	local resolved = assert(PLUGIN:ResolveTemplateMarkers(instance, {[2] = exit, [3] = spawn, [4] = container}, template))
	instance.template = resolved
	assert(resolved.exit.x == 12 and resolved.exitAngles.y == 90)
	assert(resolved.spawns[1].z == 8 and PLUGIN:GetSpawnFacing(instance, spawn:GetPos()).y == 180)
	assert(resolved.spawnAngles[1].p == 0 and resolved.spawnAngles[1].r == 0)
	assert(resolved.containers.left.recipe == "ammo" and not resolved.containers.old)
	assert(template.exit.x == 0 and template.containers.old and not template.containers.left)
	assert(not IsValid(exit) and not IsValid(spawn) and not IsValid(container))
	assert(PLUGIN:GetTemplate(record) == resolved)
	template.vendor = Vector(80, 0, 24)
	assert(resolved.vendor.x == 80, "unmarked roles must continue to inherit manual edits")
end)

Test("each spawn marker keeps its own facing and absent markers preserve manual templates", function()
	local instance, record, template = home()
	local source = {
		[1] = marker("spawn", nil, nil, instance.origin + Vector(0, 0, 8), Angle(0, 45, 0)),
		[2] = marker("spawn", nil, nil, instance.origin + Vector(48, 0, 8), Angle(0, 270, 0)),
	}
	instance.template = assert(PLUGIN:ResolveTemplateMarkers(instance, source, template))
	assert(PLUGIN:GetSpawnFacing(instance, source[1]:GetPos()).y == 45)
	assert(PLUGIN:GetSpawnFacing(instance, source[2]:GetPos()).y == 270)
	assert(PLUGIN:ResolveTemplateMarkers(instance, {}, template) == template)
end)

Test("duplicate marker roles and slot IDs fail before consuming build markers", function()
	local instance, record, template = home()
	for _, role in ipairs({"exit", "vendor", "storage", "container"}) do
		local first = marker(role, "same", "general", instance.origin)
		local second = marker(role, "same", "general", instance.origin)
		local resolved, reason = PLUGIN:ResolveTemplateMarkers(instance, {first, second}, template)
		assert(not resolved and reason:find("Duplicate", 1, true))
		assert(IsValid(first) and IsValid(second))
	end
end)

Test("marker bounds and container recipe identity are validated before any inventory changes", function()
	local instance, record, template = home()
	local invalid = marker("exit", nil, nil, instance.origin + Vector(1000, 0, 0))
	assert(not PLUGIN:ResolveTemplateMarkers(instance, {invalid}, template))
	record.containers.left = {recipe = "ammo", tier = 2, inventoryID = 77, public = true, width = 6, height = 6}
	local changed = marker("container", "left", "medical", instance.origin)
	local resolved, reason = PLUGIN:ResolveTemplateMarkers(instance, {changed}, template)
	assert(not resolved and reason:find("changed recipe", 1, true))
	assert(record.containers.left.inventoryID == 77 and record.containers.left.public)
	assert(record.containers.left.tier == 2)
	local manual = marker("container", "old", "ammo", instance.origin)
	assert(not PLUGIN:ResolveTemplateMarkers(instance, {manual}, template))
end)

Test("marker editor rejects non-admins, distant edits, expired sessions and character changes", function()
	FeatureReset()
	local admin = FeatureClient(1)
	admin.IsAdmin = function() return true end
	local entity = marker("container", "left", "general", admin:GetPos())
	net.WriteEntity = function() end
	entity:Use(admin)
	assert(admin.cotzMarkerEditor.entity == entity)
	assert(PLUGIN:SaveMarkerSettings(admin, entity, "vendor", "", ""))
	assert(entity:GetMarkerRole() == "vendor")
	Advance(1)
	entity:Use(admin)
	admin.position = admin.position + Vector(1000, 0, 0)
	assert(not PLUGIN:SaveMarkerSettings(admin, entity, "exit", "", ""))
	admin.position = entity:GetPos()
	Advance(121)
	assert(not PLUGIN:SaveMarkerSettings(admin, entity, "exit", "", ""))
	entity:Use(admin)
	admin.cotzMarkerEditor.character = {}
	Advance(1)
	assert(not PLUGIN:SaveMarkerSettings(admin, entity, "exit", "", ""))
	entity:Use(admin)
	admin.IsAdmin = function() return false end
	Advance(1)
	assert(not PLUGIN:SaveMarkerSettings(admin, entity, "exit", "", ""))
	assert(entity:GetMarkerRole() == "vendor")
end)

Test("marker container identity survives dupe relocation and cold reload", function()
	local instance, record, template = home()
	local spot = marker("container", "left", "ammo", instance.origin + Vector(60, 0, 24))
	instance.template = assert(PLUGIN:ResolveTemplateMarkers(instance, {spot}, template))
	local slot = PLUGIN:GetContainer(record, "left")
	slot.tier, slot.inventoryID, slot.width, slot.height, slot.public = 2, 77, 6, 6, true
	assert(PLUGIN:Persist())
	PLUGIN.instances, PLUGIN.members = {}, {}
	PLUGIN:LoadData()
	local restored = PLUGIN:GetHideout(record.id)
	local nextInstance = {id = record.id, origin = Vector(2000, 2000, 0)}
	PLUGIN.instances[record.id] = nextInstance
	local moved = marker("container", "left", "ammo", nextInstance.origin + Vector(100, 0, 24))
	nextInstance.template = assert(PLUGIN:ResolveTemplateMarkers(nextInstance, {moved}, template))
	local retained, definition = PLUGIN:GetContainer(restored, "left")
	assert(retained.inventoryID == 77 and retained.tier == 2 and retained.public and retained.recipe == "ammo")
	assert(definition.pos.x == 100 and retained.width == 6 and retained.height == 6)
end)

Test("squad vendor reset uses the marker transform while saved vendor movement remains independent", function()
	local instance, record, template, owner = home()
	record.ownerType, record.squadID = "squad", "squad1"
	ix.squad.list.squad1 = {members = {[1] = 2}, leaderID = 1}
	local vendor = marker("vendor", nil, nil, instance.origin + Vector(84, 0, 24), Angle(0, 90, 0))
	instance.template = assert(PLUGIN:ResolveTemplateMarkers(instance, {vendor}, template))
	local default = PLUGIN:GetVendorDefault(record)
	assert(default.pos.x == 84 and default.angles.y == 90)
	record.vendor = table.Copy(default)
	record.vendor.pos = Vector(120, 0, 24)
	PLUGIN:CreateVendor(instance)
	assert(instance.vendor:GetPos().x == instance.origin.x + 120)
	assert(PLUGIN:ResetVendor(owner, record))
	assert(instance.vendor:GetPos().x == instance.origin.x + 84 and instance.vendor:GetAngles().y == 90)
end)

Test("admins can manipulate build markers and manual point commands reject marker-owned roles", function()
	local instance, record, template, owner = home()
	owner.IsAdmin = function() return true end
	local exit = marker("exit", nil, nil, instance.origin + Vector(20, 20, 24))
	assert(PLUGIN:GetHideoutEntityPermission(owner, exit) == true)
	assert(PLUGIN:PhysgunPickup(owner, exit) == nil)
	assert(PLUGIN:CanTool(owner, {Entity = exit}, "advdupe2") == nil)
	owner.IsAdmin = function() return false end
	assert(PLUGIN:PhysgunPickup(owner, exit) == false)
	assert(PLUGIN:CanTool(owner, {Entity = exit}, "advdupe2") == false)
	owner.IsAdmin = function() return true end
	instance.template = assert(PLUGIN:ResolveTemplateMarkers(instance, {exit}, template))
	local ok, reason = PLUGIN:SetTemplatePoint(owner, "room", "exit", 50, 50, 24)
	assert(not ok and reason:find("dupe marker", 1, true))
	assert(template.exit.x == 0)
end)

Test("the full paste lifecycle replaces marker entities with protected utilities and independent locked spots", function()
	local prior, record, template, owner = home()
	PLUGIN.instances, PLUGIN.members = {}, {}
	PLUGIN.state.areas.remote = {mins = Vector(), maxs = Vector(1000, 1000, 1000)}
	template.dupe = "marker_test"
	local lookup = ix.plugin.Get
	local pasted, created
	local integration = {DespawnDupe = function() end}
	function integration:SpawnDupe(_, _, _, origin, options, callback)
		assert(options.validate({Entities = {
			{Class = "prop_physics"}, {Class = "ix_hideout_marker"},
		}, HeadEnt = {Pos = Vector()}}))
		pasted = {
			[1] = NewEntity(nil, origin + Vector(0, 80, 24)),
			[2] = marker("spawn", nil, nil, origin + Vector(0, 0, 8), Angle(0, 135, 0)),
			[3] = marker("exit", nil, nil, origin + Vector(64, 0, 24), Angle(0, 90, 0)),
			[4] = marker("container", "left", "general", origin + Vector(80, 0, 24)),
			[5] = marker("container", "right", "ammo", origin + Vector(-80, 0, 24)),
		}
		callback(true, pasted, pasted)
	end
	ix.plugin.Get = function(name) return name == "advdupeint" and integration or lookup(name) end
	PLUGIN:SpawnInstance(record, function(ok, result)
		assert(ok, result)
		created = result
		created.occupants[owner] = {character = 1}
	end)
	ix.plugin.Get = lookup
	assert(created and created.state == "active")
	assert(created.exit:GetPos().x == created.origin.x + 64 and created.exit:GetAngles().y == 90)
	assert(created.containers.left.ixHideoutSlot == "left" and created.containers.right.ixHideoutSlot == "right")
	assert(record.containers.left.tier == 0 and record.containers.right.tier == 0)
	assert(record.containers.left.recipe == "general" and record.containers.right.recipe == "ammo")
	assert(record.containers.left.public == false and record.containers.right.public == false)
	assert(not created.storage and not created.vendor)
	assert(created.shell["1"] == pasted[1] and not created.shell["2"] and not created.shell["4"])
	assert(not IsValid(pasted[2]) and not IsValid(pasted[5]))
	assert(PLUGIN:GetTemplate(record).spawns[1].z == 8)
end)
