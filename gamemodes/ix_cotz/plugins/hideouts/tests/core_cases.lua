function AttachCore(item)
	item.Transfer = ix.meta.item.Transfer
	item.width, item.height = 1, 1
	function item:GetPlayerID()
		return self.playerID
	end
	function item:GetCharacterID()
		return self.characterID
	end
end

function CoreInventory(id, owner)
	local inventory = { slots = {}, vars = {} }
	function inventory:GetID()
		return id
	end
	function inventory:GetOwner()
		return owner
	end
	function inventory:FindEmptySlot()
		return 1, 1
	end
	function inventory:SendSlot() end
	function inventory:Remove()
		return true
	end
	inventory.Add = ix.meta.inventory.Add
	ix.item.inventories[id] = inventory

	return inventory
end

Test("real Helix pickup updates custody and location in one statement", function()
	Reset()
	local instance = NewInstance()
	local client = NewClient(1)
	PLUGIN.members[client] = instance.id
	local target = CoreInventory(22, client)
	local item = NewItem({ quantity = 11 })
	AttachCore(item)
	local ent = item:Spawn(Vector(150, 250, 8), Angle())
	PLUGIN:SaveFloorItem(instance, ent)
	assert(item:Transfer(22, nil, nil, client))
	assert(DB.rows[item.id].inventory_id == 22)
	assert(not util.JSONToTable(DB.rows[item.id].data).cotzHideout)
	assert(util.JSONToTable(DB.rows[item.id].data).quantity == 11)
	local atomic = false
	for _, statement in ipairs(DB.history) do
		if statement.values.inventory_id == 22 and statement.values.data then
			atomic = true
		end
	end
	assert(atomic and not instance.items[item.id])
end)

Test("real Helix drop records world custody and hideout placement together", function()
	Reset()
	local instance = NewInstance()
	local client = NewClient(1)
	client.position = instance.origin + Vector(30, 40, 8)
	PLUGIN.members[client] = instance.id
	CoreInventory(22, client)
	local item = NewItem({ durability = 35 })
	AttachCore(item)
	item.invID = 22
	DB.rows[item.id].inventory_id = 22
	assert(item:Transfer(0, nil, nil, client, false, true))
	local row = DB.rows[item.id]
	local data = util.JSONToTable(row.data)
	assert(row.inventory_id == 0 and data.cotzHideout.id == instance.id)
	assert(data.cotzHideout.pos.x == 30 and data.durability == 35)
	local atomic = false
	for _, statement in ipairs(DB.history) do
		if statement.values.inventory_id == 0 and statement.values.data then
			atomic = true
		end
	end
	assert(atomic)
end)

Test("real Helix transfer guard runs before permissive general hooks", function()
	Reset()
	local instance = NewInstance()
	instance.saving = true
	local client = NewClient(1)
	PLUGIN.members[client] = instance.id
	CoreInventory(22, client)
	local item = NewItem()
	AttachCore(item)
	item.invID = 22
	DB.rows[item.id].inventory_id = 22
	local result = item:Transfer(0, nil, nil, client, false, true)
	assert(result == false and DB.rows[item.id].inventory_id == 22)
end)

Test("deletion removes hideout floor rows and retains exported items", function()
	Reset()
	local instance = NewInstance()
	local floor = NewItem()
	local exported = NewItem()
	local first = floor:Spawn(Vector(150, 250, 8), Angle())
	local second = exported:Spawn(Vector(160, 250, 8), Angle())
	PLUGIN:SaveFloorItem(instance, first)
	PLUGIN:SaveFloorItem(instance, second)
	PLUGIN:DetachFloorItems(instance)
	DB.rows[exported.id].inventory_id = 44
	local deleted
	PLUGIN:DeleteHideout(instance.id, function(ok)
		deleted = ok
	end)
	assert(deleted and not PLUGIN:GetHideout(instance.id))
	assert(not DB.rows[floor.id] and DB.rows[exported.id])
end)

Test("schema inventory action override removes consumed floor items", function()
	Reset()
	local instance = NewInstance()
	local client = NewClient(1)
	PLUGIN.members[client] = instance.id
	local item = NewItem({ quantity = 1 })
	AttachCore(item)
	local entity = item:Spawn(instance.origin, Angle())
	client.position = instance.origin
	PLUGIN:SaveFloorItem(instance, entity)
	ix.item.inventories[0].OnCheckAccess = function()
		return true
	end
	item.functions = { consume = {
		OnRun = function()
			return true
		end,
	} }
	item.hooks, item.postHooks = {}, {}
	assert(ix.item.PerformInventoryAction(client, "consume", entity))
	assert(not entity.valid and not DB.rows[item.id] and not instance.items[item.id])
end)
