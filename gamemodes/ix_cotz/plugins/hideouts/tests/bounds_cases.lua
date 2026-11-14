local function setup()
	Reset()
	local template = {
		mins = Vector(-512, -512, -16),
		maxs = Vector(512, 512, 512),
		spawns = {Vector(0, 0, 8)},
		storage = Vector(80, 64, 24),
		containers = {starter = {recipe = "general", pos = Vector(80, 64, 24)}},
	}
	PLUGIN.state.templates.room = template

	return template, TEST_COMMANDS.HideoutTemplateDepth
end

Test("template depth preserves layout and persists across reload", function()
	local template, command = setup()
	local spawns, storage, containers, maxs = template.spawns, template.storage, template.containers, template.maxs
	command:OnRun(NewClient(1), "room", 80)
	assert(template.mins.x == -512 and template.mins.y == -512 and template.mins.z == -80)
	assert(template.spawns == spawns and template.storage == storage)
	assert(template.containers == containers and template.maxs == maxs)
	PLUGIN:LoadData()
	assert(PLUGIN.state.templates.room.mins.z == -80)
	assert(PLUGIN.state.templates.room.containers.starter.recipe == "general")
end)

Test("template depth rejects invalid values, unknown templates and loaded instances", function()
	local template, command = setup()
	local client = NewClient(1)
	for _, depth in ipairs({-1, 16001, math.huge, -math.huge, 0 / 0}) do
		assert(command:OnRun(client, "room", depth):find("between 0 and 16000", 1, true))
		assert(template.mins.z == -16)
	end
	assert(command:OnRun(client, "missing", 80) == "Unknown hideout template.")
	for _, state in ipairs({"loading", "active", "saving"}) do
		PLUGIN.instances.test = {state = state}
		assert(command:OnRun(client, "room", 80):find("Unload all hideouts", 1, true))
		assert(template.mins.z == -16)
	end
	PLUGIN.instances = {}
	PLUGIN.ready = false
	assert(command:OnRun(client, "room", 80) == "Hideout persistence is not ready.")
	assert(template.mins.z == -16)
end)

Test("template depth restores the previous bounds on persistence failure", function()
	local template, command = setup()
	local previous, persist = template.mins, PLUGIN.Persist
	PLUGIN.Persist = function() return false end
	local result = command:OnRun(NewClient(1), "room", 80)
	PLUGIN.Persist = persist
	assert(result == "Could not save the template depth." and template.mins == previous)
end)

Test("below-floor shell reports the offending model and fits after depth adjustment", function()
	local template, command = setup()
	local record = {id = "1", template = "room", owner = 1, shell = {}}
	PLUGIN.state.hideouts[record.id] = record
	PLUGIN.state.areas.remote = {mins = Vector(), maxs = Vector(1024, 1024, 592)}
	local lookup, resolve = ix.plugin.Get, PLUGIN.ResolveTemplateMarkers
	local integration = {DespawnDupe = function() end}
	function integration:SpawnDupe(name, id, offset, origin, options, callback)
		local entity = NewEntity(nil, origin + Vector(0, 0, -50))
		entity:SetModel("models/test/below_floor.mdl")
		callback(true, {entity}, {})
	end
	ix.plugin.Get = function(name)
		if name == "advdupeint" then return integration end

		return lookup(name)
	end
	PLUGIN.ResolveTemplateMarkers = function() return false, "Passed shell bounds." end
	local reason
	PLUGIN:SpawnInstance(record, function(ok, message) reason = message end)
	assert(reason:find("models/test/below_floor.mdl", 1, true))
	assert(reason:find("Local bounds (-1, -1, -51)", 1, true))
	assert(reason:find("template bounds (-512, -512, -16)", 1, true))
	assert(table.IsEmpty(PLUGIN.instances))
	command:OnRun(NewClient(1), "room", 80)
	PLUGIN:SpawnInstance(record, function(ok, message) reason = message end)
	ix.plugin.Get, PLUGIN.ResolveTemplateMarkers = lookup, resolve
	assert(reason == "Passed shell bounds.")
	assert(table.IsEmpty(PLUGIN.instances) and template.mins.z == -80)
end)
