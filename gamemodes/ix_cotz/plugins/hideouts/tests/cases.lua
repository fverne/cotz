Test("character ownership and multiple hideouts", function()
	Reset()
	local owner, other = NewClient(1), NewClient(2)
	PLUGIN.state.templates.room = {}
	local ok, first = PLUGIN:GrantHideout(owner, "room", "gate", "First")
	local ok2, second = PLUGIN:GrantHideout(owner, "room", "gate", "Second")
	assert(ok and ok2 and first ~= second)
	assert(PLUGIN:CanAccess(owner, PLUGIN:GetHideout(first)))
	assert(not PLUGIN:CanAccess(other, PLUGIN:GetHideout(first)))
end)

Test("restart restores hideout IDs, guest access, shell and seed keys", function()
	Reset()
	local owner, guest = NewClient(1), NewClient(2)
	PLUGIN.state.templates.room = {}
	local ok, id = PLUGIN:GrantHideout(owner, "room", "gate", "Restart home")
	assert(ok)
	local record = PLUGIN:GetHideout(id)
	record.guests["2"] = true
	record.shell["635"] = false
	record.seeds = { ["83"] = { initialized = true } }
	assert(PLUGIN:Persist())
	assert(PLUGIN:GetData().hideouts[tonumber(id)]) -- GMod's default JSON key conversion.
	PLUGIN.state, PLUGIN.instances, PLUGIN.members = nil, {}, {}
	PLUGIN:LoadData()
	local restored = PLUGIN:GetHideout(id)
	assert(restored, "saved hideout ID must remain accessible after restart")
	assert(restored.id == id and PLUGIN:CanAccess(owner, restored) and PLUGIN:CanAccess(guest, restored))
	assert(restored.shell["635"] == false and restored.seeds["83"].initialized)
end)

Test("allocator reserves clearance and reports exhaustion", function()
	Reset()
	PLUGIN.state.areas.remote = { mins = Vector(), maxs = Vector(1500, 300, 300) }
	local template = { mins = Vector(), maxs = Vector(256, 256, 256) }
	local origin, mins, maxs = PLUGIN:Allocate(template)
	assert(origin and mins.x == 0)
	PLUGIN.instances.a = { mins = mins, maxs = maxs }
	local other, otherMin, otherMax = PLUGIN:Allocate(template)
	assert(other and otherMin.x >= maxs.x + 512)
	PLUGIN.instances.b = { mins = otherMin, maxs = otherMax }
	local third = PLUGIN:Allocate(template)
	assert(third == nil)
end)

Test("allocator distinguishes missing map areas from exhausted space", function()
	Reset()
	local template = {mins = Vector(-512, -512, -16), maxs = Vector(512, 512, 512)}
	local origin, _, _, reason = PLUGIN:Allocate(template)
	assert(not origin and reason:find("No hideout allocation area", 1, true))
	assert(table.IsEmpty(PLUGIN.state.areas) and table.IsEmpty(PLUGIN.instances))
end)

Test("allocator reports full template dimensions including the below-anchor floor margin", function()
	Reset()
	local template = {mins = Vector(-512, -512, -16), maxs = Vector(512, 512, 512)}
	PLUGIN.state.areas.remote = {mins = Vector(), maxs = Vector(1024, 1024, 512)}
	local origin, _, _, reason = PLUGIN:Allocate(template)
	assert(not origin and reason:find("1024 x 1024 x 528", 1, true))
	PLUGIN.state.areas.remote.maxs.z = 528
	local allocated, mins, maxs = PLUGIN:Allocate(template)
	assert(allocated and allocated.z == 16 and mins.z == 0 and maxs.z == 528)
end)

Test("allocator retains geometry checks when an area has sufficient dimensions", function()
	Reset()
	PLUGIN.state.areas.remote = {mins = Vector(), maxs = Vector(1024, 1024, 528)}
	local traceHull = util.TraceHull
	util.TraceHull = function() return {StartSolid = true} end
	local origin, _, _, reason = PLUGIN:Allocate({mins = Vector(), maxs = Vector(256, 256, 256)})
	util.TraceHull = traceHull
	assert(not origin and reason:find("No clear, unreserved", 1, true))
end)

Test("allocator ignores non-blocking trigger brushes and map logic entities", function()
	Reset()
	PLUGIN.state.areas.remote = {mins = Vector(), maxs = Vector(256, 256, 256)}
	local soundscape = ents.Create("trigger_soundscape")
	function soundscape:GetSolid() return SOLID_BSP end
	function soundscape:IsSolid() return false end
	local logic = ents.Create("env_soundscape")
	function logic:GetSolid() return SOLID_NONE end
	local invalid = NewEntity()
	invalid.valid = false
	local findInBox = ents.FindInBox
	ents.FindInBox = function() return {soundscape, logic, invalid} end
	local origin = PLUGIN:Allocate({mins = Vector(), maxs = Vector(256, 256, 256)})
	ents.FindInBox = findInBox
	assert(origin, "non-blocking map entities must not exhaust the only available placement")
end)

Test("allocator still rejects solid props, invisible collision brushes and non-solid players", function()
	Reset()
	PLUGIN.state.areas.remote = {mins = Vector(), maxs = Vector(256, 256, 256)}
	local prop = ents.Create("prop_physics")
	local invisible = ents.Create("func_brush")
	function invisible:GetSolid() return SOLID_BSP end
	function invisible:GetNoDraw() return true end
	local player = NewClient(1)
	function player:GetSolid() return SOLID_NONE end
	function player:IsSolid() return false end
	local findInBox = ents.FindInBox
	for _, obstruction in ipairs({prop, invisible, player}) do
		ents.FindInBox = function() return {obstruction} end
		local origin, _, _, reason = PLUGIN:Allocate({mins = Vector(), maxs = Vector(256, 256, 256)})
		assert(not origin and reason:find("No clear, unreserved", 1, true))
	end
	ents.FindInBox = findInBox
end)

Test("hideout loading forwards the missing-area setup error", function()
	Reset()
	local template = {mins = Vector(-512, -512, -16), maxs = Vector(512, 512, 512)}
	PLUGIN.state.templates.room = template
	local lookup = ix.plugin.Get
	ix.plugin.Get = function(name)
		if name == "advdupeint" then return {} end
		return lookup(name)
	end
	local success, reason
	PLUGIN:SpawnInstance({id = "1", template = "room"}, function(ok, message) success, reason = ok, message end)
	ix.plugin.Get = lookup
	assert(success == false and reason:find("No hideout allocation area", 1, true))
	assert(table.IsEmpty(PLUGIN.instances))
end)

Test("standing template spawn records local feet position and facing", function()
	Reset()
	local instance = NewInstance()
	local client = NewClient(1)
	client.position, client.angles = instance.origin + Vector(24, 48, 8), Angle(20, 135, 0)
	local template = PLUGIN.state.templates.room
	template.mins, template.maxs = Vector(-100, -100, -16), Vector(500, 500, 500)
	assert(PLUGIN:SetTemplatePoint(client, "room", "spawn"))
	assert(
		#template.spawns == 1
			and template.spawns[1].x == 24
			and template.spawns[1].y == 48
			and template.spawns[1].z == 8
	)
	assert(template.facing.y == 135 and template.facing.p == 0)
	assert(client:GetPos().x == instance.origin.x + 24)
end)

Test("standing utility placement updates all instances of the template", function()
	Reset()
	local first, second = NewInstance("1"), NewInstance("2")
	second.origin, second.mins, second.maxs =
		Vector(2000, 0, 0), Vector(1900, -100, -16), Vector(3000, 1000, 1000)
	local template = PLUGIN.state.templates.room
	template.mins, template.maxs = Vector(-100, -100, -16), Vector(500, 500, 500)
	local client = NewClient(1)
	client.position = first.origin + Vector(24, 48, 8)
	for _, instance in ipairs({ first, second }) do
		instance.exit = NewEntity(nil, instance.origin)
		instance.storage = NewEntity(nil, instance.origin)
	end
	for _, point in ipairs({ "exit", "storage" }) do
		assert(PLUGIN:SetTemplatePoint(client, "room", point))
		assert(template[point].x == 24 and template[point].y == 48 and template[point].z == 30)
		assert(first[point]:GetPos().x == first.origin.x + 24)
		assert(second[point]:GetPos().x == second.origin.x + 24)
	end
end)

Test("template placement rejects wrong interiors and partial coordinates", function()
	Reset()
	local instance = NewInstance()
	local template = PLUGIN.state.templates.room
	template.mins, template.maxs = Vector(-100, -100, -16), Vector(500, 500, 500)
	local client = NewClient(1)
	assert(not PLUGIN:SetTemplatePoint(client, "room", "spawn"))
	assert(not PLUGIN:SetTemplatePoint(client, "room", "spawn", 1, 2))
	assert(not PLUGIN:SetTemplatePoint(client, "room", "spawn", 10000, 0, 8))
	client.position = instance.origin + Vector(0, 0, 8)
	instance.saving = true
	assert(not PLUGIN:SetTemplatePoint(client, "room", "exit"))
	instance.saving = false
	assert(PLUGIN:SetTemplatePoint(client, "room", "exit", 10, 20, 30))
	assert(template.exit.x == 10 and template.exit.z == 30)
end)

Test("failed template save preserves configuration and live placement", function()
	Reset()
	local instance = NewInstance()
	local template = PLUGIN.state.templates.room
	template.mins, template.maxs = Vector(-100, -100, -16), Vector(500, 500, 500)
	local client = NewClient(1)
	client.position = instance.origin + Vector(24, 48, 8)
	instance.storage = NewEntity(nil, instance.origin)
	local previous, persist = template.storage, PLUGIN.Persist
	PLUGIN.Persist = function()
		return false
	end
	assert(not PLUGIN:SetTemplatePoint(client, "room", "storage"))
	assert(template.storage == previous and instance.storage:GetPos() == instance.origin)
	PLUGIN.Persist = persist
end)

Test("unload/load retains full item data without another DB row", function()
	Reset()
	local instance = NewInstance()
	local item =
		NewItem({ quantity = 17, durability = 42, upgrades = { scope = "custom" }, name = "Personal" })
	local id = item:GetID()
	local ent = item:Spawn(Vector(140, 240, 8), Angle())
	local saved
	PLUGIN:SaveFloorItem(instance, ent, function(ok)
		saved = ok
	end)
	assert(saved and ent.bTemporary)
	PLUGIN:DetachFloorItems(instance)
	assert(DB.rows[id] and not ent.valid and not ix.item.instances[id])
	for _ = 1, 3 do
		instance.state = "loading"
		local restored
		PLUGIN:RestoreFloorItems(instance, function(ok)
			restored = ok
		end)
		assert(restored and table.Count(DB.rows) == 1)
		local live = ix.item.instances[id]
		assert(live:GetData("quantity") == 17 and live:GetData("durability") == 42)
		assert(live:GetData("upgrades").scope == "custom" and live:GetData("name") == "Personal")
		assert(instance.items[id]:GetPos().x == 140)
		PLUGIN:DetachFloorItems(instance)
	end
end)

Test("pickup and deletion override stale hideout metadata", function()
	Reset()
	local instance = NewInstance()
	local item = NewItem({ quantity = 3 })
	local ent = item:Spawn(Vector(150, 250, 8), Angle())
	PLUGIN:SaveFloorItem(instance, ent)
	PLUGIN:DetachFloorItems(instance)
	DB.rows[item.id].inventory_id = 77 -- Atomic authoritative pickup write.
	instance.state = "loading"
	PLUGIN:RestoreFloorItems(instance, function(ok)
		assert(ok)
	end)
	assert(table.IsEmpty(instance.items))
	DB.rows[item.id] = nil -- Destruction/consumption.
	PLUGIN:RestoreFloorItems(instance, function(ok)
		assert(ok)
	end)
	assert(table.IsEmpty(instance.items))
end)

Test("successful world consumption deletes the restorable row", function()
	Reset()
	local instance = NewInstance()
	local item = NewItem()
	local ent = item:Spawn(Vector(150, 250, 8), Angle())
	PLUGIN:SaveFloorItem(instance, ent)
	PLUGIN:OnItemActionCompleted(NewClient(1), "consume", item, ent)
	assert(not DB.rows[item.id] and not instance.items[item.id])
end)

Test("late floor checkpoint cannot move a picked-up item back to world", function()
	Reset()
	local instance = NewInstance()
	local item = NewItem({ quantity = 9 })
	local ent = item:Spawn(Vector(150, 250, 8), Angle())
	DB.rows[item.id].inventory_id = 44
	PLUGIN:SaveFloorItem(instance, ent)
	assert(DB.rows[item.id].inventory_id == 44)
end)

Test("failed persistence retains entities and reservation", function()
	Reset()
	local instance = NewInstance()
	local original = PLUGIN.Persist
	PLUGIN.Persist = function()
		return false
	end
	PLUGIN:UnloadInstance(instance)
	assert(PLUGIN.instances[instance.id] == instance and instance.state == "failed")
	PLUGIN.Persist = original
	PLUGIN:UnloadInstance(instance)
	assert(not PLUGIN.instances[instance.id])
end)

Test("failed item verification retains a live item for retry", function()
	Reset()
	local instance = NewInstance()
	local item = NewItem({ quantity = 1 })
	local ent = item:Spawn(Vector(150, 250, 8), Angle())
	instance.items[item.id] = ent
	DB.rejectWrite = true
	PLUGIN:UnloadInstance(instance)
	assert(instance.state == "failed" and ent.valid and DB.rows[item.id])
	DB.rejectWrite = false
	PLUGIN:UnloadInstance(instance)
	assert(not PLUGIN.instances[instance.id] and not ent.valid and DB.rows[item.id])
end)

Test("transfers stay locked until save callbacks finish", function()
	Reset()
	local instance = NewInstance()
	local item = NewItem()
	local ent = item:Spawn(Vector(150, 250, 8), Angle())
	PLUGIN:SaveFloorItem(instance, ent)
	DB.hold = true
	PLUGIN:UnloadInstance(instance)
	assert(instance.state == "saving" and ent.valid)
	assert(PLUGIN:CanTransferHideoutItem(item, {}, {}, NewClient(1)) == false)
	DB:Flush()
	assert(not PLUGIN.instances[instance.id] and not ent.valid and DB.rows[item.id])
end)

Test("initial loot seeds once and recovers an interrupted initialization", function()
	Reset()
	local instance = NewInstance()
	instance.state = "loading"
	local record = PLUGIN:GetHideout(instance.id)
	record.seeds.a = {
		uniqueID = "water",
		data = { quantity = 5 },
		pos = Vector(50, 50, 8),
		angles = Angle(),
		movable = false,
	}
	PLUGIN:SeedItems(instance, function(ok)
		assert(ok)
	end)
	assert(record.seeds.a.initialized and table.Count(DB.rows) == 1)
	record.seeds.a.initialized = nil -- Simulate losing only the initialization file write.
	PLUGIN:SeedItems(instance, function(ok)
		assert(ok)
	end)
	assert(record.seeds.a.initialized and table.Count(DB.rows) == 1)
	DB.rows = {} -- Loot was subsequently taken and consumed.
	PLUGIN:SeedItems(instance, function(ok)
		assert(ok)
	end)
	assert(table.Count(DB.rows) == 0)
end)

Test("simultaneous entrants share the pending load", function()
	Reset()
	local first, second = NewClient(1), NewClient(2)
	local record = { id = "1", owner = 1, entrance = "gate", guests = { ["2"] = true } }
	PLUGIN.state.hideouts["1"] = record
	local original = PLUGIN.SpawnInstance
	local count = 0
	PLUGIN.SpawnInstance = function(self, value, callback)
		count = count + 1
		self.instances[value.id] = { id = value.id, state = "loading", callbacks = { callback } }
	end
	assert(PLUGIN:RequestEntry(first, "1"))
	assert(PLUGIN:RequestEntry(second, "1"))
	assert(count == 1 and #PLUGIN.instances["1"].callbacks == 2)
	PLUGIN.SpawnInstance = original
end)

Test("one remaining occupant prevents unload", function()
	Reset()
	local instance = NewInstance()
	local first, second = NewClient(1), NewClient(2)
	for _, client in ipairs({ first, second }) do
		instance.occupants[client] = {
			character = client:GetCharacter():GetID(),
			returnPoint = { Vector(10000, 0, 8), Angle(), "testmap" },
		}
		PLUGIN.members[client] = instance.id
	end
	assert(PLUGIN:LeaveHideout(first, false))
	assert(PLUGIN.instances[instance.id] == instance)
	assert(PLUGIN:LeaveHideout(second, false))
	assert(not PLUGIN.instances[instance.id])
end)

Test("only outside positions are saved for hideout occupants", function()
	Reset()
	local instance = NewInstance()
	local client = NewClient(1)
	local point = { Vector(10000, 0, 8), Angle(), "testmap" }
	instance.occupants[client] = { character = 1, returnPoint = point }
	PLUGIN.members[client] = instance.id
	assert(PLUGIN:GetCharacterSavePosition(client:GetCharacter()) == point)
end)

Test("storage transfers reject stale sessions and other instances", function()
	Reset()
	local instance = NewInstance()
	local client = NewClient(1)
	local item = NewItem()
	instance.storage = NewEntity()
	instance.storage:SetPos(client:GetPos())
	local current = { vars = { hideout = instance.id } }
	assert(PLUGIN:CanTransferHideoutItem(item, current, {}, client) == false)
	PLUGIN.members[client] = instance.id
	assert(PLUGIN:CanTransferHideoutItem(item, current, {}, client) == nil)
	assert(PLUGIN:CanTransferHideoutItem(item, current, { vars = { hideout = "other" } }, client) == false)
	instance.saving = true
	assert(PLUGIN:CanTransferHideoutItem(item, current, {}, client) == false)
end)

Test("complete entry, second occupant, exit and cold restart reentry", function()
	Reset()
	local owner, guest = NewClient(1), NewClient(2)
	PLUGIN.state.areas.remote = { mins = Vector(), maxs = Vector(2000, 2000, 1000) }
	PLUGIN.state.templates.room = {
		dupe = "room",
		mins = Vector(-256, -256, -16),
		maxs = Vector(256, 256, 400),
		spawns = { Vector(0, 0, 8) },
		exit = Vector(0, 64, 24),
		storage = Vector(80, 64, 24),
	}
	local ok, id = PLUGIN:GrantHideout(owner, "room", "gate", "Test home")
	assert(ok)
	PLUGIN:GetHideout(id).guests["2"] = true
	PLUGIN:GetHideout(id).storageID = 100 -- Existing private stash remains recoverable.
	local getPlugin = ix.plugin.Get
	local pasteCount = 0
	local integration = {
		SpawnDupe = function(self, name, dupeID, offset, origin, options, callback)
			pasteCount = pasteCount + 1
			local shell = NewEntity(nil, origin + Vector(0, 0, 16))
			callback(true, { shell }, { [1] = shell })
		end,
		DespawnDupe = function() end,
	}
	ix.plugin.Get = function(name)
		return name == "advdupeint" and integration or getPlugin(name)
	end
	local safe = PLUGIN.FindSafePosition
	PLUGIN.FindSafePosition = function(self, client, candidates)
		return candidates[1]
	end
	ix.inventory.New = function(_, _, callback)
		local inv = { vars = {} }
		function inv:GetID()
			return 100
		end
		function inv:GetReceivers()
			return {}
		end
		ix.item.inventories[100] = inv
		callback(inv)
	end
	ix.inventory.Get = function(invID)
		return ix.item.inventories[invID]
	end
	local storageRestores = 0
	ix.inventory.Restore = function(invID, width, height, callback)
		assert(invID == 100 and width == 8 and height == 6)
		storageRestores = storageRestores + 1
		ix.inventory.New(0, "hideout", callback)
	end
	assert(PLUGIN:RequestEntry(owner, id))
	assert(PLUGIN.members[owner] == id and PLUGIN.instances[id].state == "active")
	assert(owner:GetCharacter():GetData("hideoutReturn")[1].x == 10000)
	assert(PLUGIN:RequestEntry(guest, id) and pasteCount == 1)
	assert(PLUGIN:LeaveHideout(owner, true) and PLUGIN.instances[id])
	assert(owner:GetPos().x == 10000 and not owner:GetCharacter():GetData("hideoutReturn"))
	assert(PLUGIN:LeaveHideout(guest, true) and not PLUGIN.instances[id])
	Advance(3)
	assert(PLUGIN:RequestEntry(owner, id) and pasteCount == 2)
	local item = NewItem({ quantity = 7, durability = 42 })
	local entity = item:Spawn(PLUGIN.instances[id].origin + Vector(32, 32, 8), Angle())
	PLUGIN:SaveFloorItem(PLUGIN.instances[id], entity)
	assert(PLUGIN:LeaveHideout(owner, true) and not PLUGIN.instances[id])
	-- Discard runtime state and reload the saved numeric-key representation.
	PLUGIN.state, PLUGIN.instances, PLUGIN.members = nil, {}, {}
	ix.item.instances, ix.item.inventories = {}, { [0] = {} }
	PLUGIN:LoadData()
	Advance(3)
	assert(PLUGIN:RequestEntry(owner, id) and pasteCount == 3)
	assert(PLUGIN.members[owner] == id and storageRestores == 2)
	assert(PLUGIN.instances[id].items[item.id])
	assert(
		ix.item.instances[item.id]:GetData("quantity") == 7
			and ix.item.instances[item.id]:GetData("durability") == 42
	)
	assert(PLUGIN:RequestEntry(guest, id) and pasteCount == 3)
	assert(PLUGIN:LeaveHideout(owner, true) and PLUGIN.instances[id])
	assert(PLUGIN:LeaveHideout(guest, true) and not PLUGIN.instances[id])
	PLUGIN.FindSafePosition, ix.plugin.Get = safe, getPlugin
end)
