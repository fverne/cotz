local function containerHome()
	FeatureReset()
	local owner, inventory = FeatureClient(1)
	local instance, record = FeatureHome(owner)
	PLUGIN.state.templates.room.containers = {
		left = {recipe = "general", pos = Vector()}, right = {recipe = "general", pos = Vector(40, 0, 0)},
	}
	for _, slotID in ipairs({"left", "right"}) do
		PLUGIN:GetContainer(record, slotID)
		local entity = NewEntity(nil, instance.origin)
		entity.ixHideout, entity.ixHideoutSlot = record.id, slotID
		instance.containers[slotID] = entity
	end

	return owner, inventory, instance, record
end

Test("menu actions retain administrator-only chat counterparts", function()
	for _, name in ipairs({"HideoutManage", "HideoutEntrancePlace", "HideoutAccess", "HideoutVendorReset",
		"HideoutContainerUpgrade", "HideoutContainerPublic"}) do
		assert(TEST_COMMANDS[name].adminOnly == true, name)
	end
end)

Test("using a personal container opens its owner controls without a command", function()
	local owner, inventory, instance, record = containerHome()
	PLUGIN:OpenStorage(owner, instance.containers.left)
	assert(owner.cotzHideoutMenu.scope == "container" and owner.cotzHideoutMenu.slot == "left")
	assert(not owner.ixOpenStorage)
	assert(PLUGIN:HandleManagementAction(owner, record.id, 5, "left", 0))
	assert(record.containers.left.public == true and record.containers.right.public == false)
	assert(not PLUGIN:HandleManagementAction(owner, record.id, 5, "right", 0))
	owner.position = Vector(10000, 0, 8)
	assert(not PLUGIN:HandleManagementAction(owner, record.id, 5, "left", 0))
	assert(record.containers.left.public == true)
end)

Test("personal container menus direct purchases to the trader without consuming items", function()
	local owner, inventory, instance, record = containerHome()
	ix.item.list.value_container_smallitems = {model = "case.mdl", name = "Case"}
	local input = FeatureItem(inventory, {}, "value_container_smallitems")
	PLUGIN:OpenStorage(owner, instance.containers.left)
	assert(not PLUGIN:HandleManagementAction(owner, record.id, 4, "left", 0))
	assert(record.containers.left.tier == 0 and record.containers.right.tier == 0)
	assert(ix.item.instances[input:GetID()] == input)
end)

Test("invited guests open shared storage but cannot obtain owner controls", function()
	local owner, inventory, instance, record = containerHome()
	local guest = FeatureClient(2)
	record.guests["2"] = true
	local slot = record.containers.left
	slot.tier, slot.width, slot.height, slot.inventoryID, slot.public = 1, 3, 3, 80, true
	ix.inventory.Create(3, 3, 80)
	PLUGIN.members[guest] = record.id
	guest.position = instance.origin
	PLUGIN:OpenStorage(guest, instance.containers.left)
	assert(guest.ixOpenStorage and not guest.cotzHideoutMenu)
	PLUGIN:ShowContainerMenu(guest, instance.containers.left)
	assert(not guest.cotzHideoutMenu)
	assert(not PLUGIN:HandleManagementAction(guest, record.id, 5, "left", 1))
end)

Test("entrance menus allow access management and invalidate after a character change", function()
	local owner, inventory, instance, record = containerHome()
	local guest = FeatureClient(2)
	owner.position = PLUGIN.state.entrances.gate.outside
	PLUGIN:OpenManagementMenu(owner, record.id, "entrance")
	assert(owner.cotzHideoutMenu.ids[record.id])
	assert(PLUGIN:HandleManagementAction(owner, record.id, 6, "2", 0))
	assert(record.guests["2"] == true)
	assert(PLUGIN:HandleManagementAction(owner, record.id, 7, "2", 0))
	assert(not record.guests["2"])
	assert(not PLUGIN:HandleManagementAction(owner, record.id, 5, "left", 0))
	local original = owner.character
	owner.character = guest:GetCharacter()
	assert(not PLUGIN:HandleManagementAction(owner, record.id, 6, "2", 0))
	assert(not record.guests["2"])
	owner.character = original
end)

Test("guests can leave through the exit menu without receiving management privileges", function()
	local owner, inventory, instance, record = containerHome()
	local guest = FeatureClient(2)
	record.guests["2"] = true
	guest.position = instance.origin
	PLUGIN.members[guest] = record.id
	instance.occupants[guest] = {character = 2, returnPoint = {Vector(10000, 0, 8), Angle(), game.GetMap()}}
	instance.exit = NewEntity(nil, instance.origin)
	PLUGIN:OpenManagementMenu(guest, record.id, "exit")
	assert(guest.cotzHideoutMenu.ids[record.id])
	assert(not PLUGIN:HandleManagementAction(guest, record.id, 6, "1", 0))
	assert(PLUGIN:HandleManagementAction(guest, record.id, 9, "", 0))
	assert(not PLUGIN.members[guest] and guest:GetPos().x == 10000)
	assert(not guest.cotzHideoutMenu)
end)

Test("squad menu permits initial entrance placement but not a remote vendor reset", function()
	FeatureReset()
	local officer = FeatureClient(1)
	local instance, record = FeatureHome(officer, true)
	record.entrance = "squad:1"
	PLUGIN.members[officer], instance.occupants[officer] = nil, nil
	officer.position = Vector(10000, 0, 8)
	getmetatable(Vector()).Angle = function() return Angle() end
	officer.GetEyeTrace = function()
		return {Hit = true, HitPos = Vector(10032, 0, 8), HitNormal = Vector(0, 0, 1)}
	end
	local spawn = PLUGIN.SpawnEntrances
	local spawned
	PLUGIN.SpawnEntrances = function() spawned = true end
	PLUGIN:OpenManagementMenu(officer, "", "squad")
	assert(officer.cotzHideoutMenu.ids[record.id])
	assert(not PLUGIN:HandleManagementAction(officer, record.id, 2, "", 0))
	assert(PLUGIN:HandleManagementAction(officer, record.id, 1, "", 0))
	PLUGIN.SpawnEntrances = spawn
	assert(spawned and not PLUGIN.state.entrances[record.entrance].invisible)
	ix.squad.list.squad1.members[1] = 0
	assert(not PLUGIN:HandleManagementAction(officer, record.id, 1, "", 0))
end)

Test("exit management resets a missing squad vendor without reaching it", function()
	FeatureReset()
	local officer = FeatureClient(1)
	local instance, record = FeatureHome(officer, true)
	instance.exit = NewEntity(nil, instance.origin)
	assert(not IsValid(instance.vendor))
	PLUGIN:OpenManagementMenu(officer, record.id, "exit")
	assert(PLUGIN:HandleManagementAction(officer, record.id, 2, "", 0))
	assert(IsValid(instance.vendor))
end)
