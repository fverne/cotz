local integration = PLUGIN
AdvDupe2 = { DataFolder = "advdupe2", duplicator = {} }
file = {
	Read = function()
		return "test"
	end,
}
AdvDupe2.Decode = function()
	return true,
		{ Entities = { [1] = { Class = "prop_physics" } }, Constraints = {}, HeadEnt = { Pos = Vector() } }
end
Test("AdvDupe instances clean up independently and reject duplicate IDs", function()
	local a, b = NewEntity(), NewEntity()
	local pastes = 0
	AdvDupe2.duplicator.Paste = function()
		pastes = pastes + 1

		return { [1] = pastes == 1 and a or b }, {}
	end
	assert(integration:SpawnDupe("room", "a", nil, nil, { noItems = true }))
	assert(integration:SpawnDupe("room", "b", nil, nil, { noItems = true }))
	assert(not integration:SpawnDupe("room", "a", nil, nil, { noItems = true }))
	integration:DespawnDupe("a")
	assert(not a.valid and b.valid)
	integration:DespawnDupe("b")
end)

Test("AdvDupe partial-paste errors clean captured entities", function()
	local ent = NewEntity()
	AdvDupe2.duplicator.Paste = function()
		integration:OnEntityCreated(ent)
		error("partial paste")
	end
	local result
	assert(not integration:SpawnDupe("room", "broken", nil, nil, {}, function(ok)
		result = ok
	end))
	assert(result == false and not ent.valid and not ix.AdvDupeIntegration.CreatedEntities.broken)
end)

Test("dummy conversion is scoped and late callbacks clean up", function()
	local unrelated = NewEntity()
	function unrelated:GetClass()
		return "ix_dupedummyitem"
	end
	local dummy = NewEntity()
	function dummy:GetClass()
		return "ix_dupedummyitem"
	end
	function dummy:GetRepresentedItem()
		return { "water", { quantity = 4 } }
	end
	function dummy:GetShouldUnfreeze()
		return false
	end
	AdvDupe2.duplicator.Paste = function()
		return { [1] = dummy }, {}
	end
	local spawn = ix.item.Spawn
	local pending
	ix.item.Spawn = function(_, _, callback)
		pending = callback
	end
	local completed = false
	assert(integration:SpawnDupe("room", "async", nil, nil, {}, function()
		completed = true
	end))
	assert(not completed and unrelated.valid and not dummy.valid)
	integration:DespawnDupe("async")
	local item = NewItem()
	local ent = item:Spawn(Vector(), Angle())
	pending(item, ent)
	assert(not completed and not ent.valid and not DB.rows[item.id])
	ix.item.Spawn = spawn
end)
