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

Test("administrators enter private personal and squad hideouts without invitations while noclipping", function()
	local owner, inventory, instance, record = containerHome()
	local admin = FeatureClient(2)
	assert(not PLUGIN:CanAccess(admin, record))
	admin.IsAdmin = function() return true end
	assert(PLUGIN:CanAccess(admin, record))
	record.ownerType, record.owner, record.squadID, record.access = "squad", nil, "absent", "squad"
	assert(PLUGIN:CanAccess(admin, record))
	record.frozen = true
	assert(not PLUGIN:CanAccess(admin, record))
	record.frozen = nil
	admin.position = PLUGIN.state.entrances.gate.pos
	admin.GetMoveType = function() return MOVETYPE_NOCLIP end
	assert(PLUGIN:RequestEntry(admin, record.id))
	assert(PLUGIN.members[admin] == record.id)
	PLUGIN:EnforceAccess(instance)
	assert(PLUGIN.members[admin] == record.id)
end)

Test("occupancy audits leave visiting administrators in place and still eject uninvited players", function()
	local owner, inventory, instance, record = containerHome()
	local admin = FeatureClient(2)
	local intruder = FeatureClient(3)
	admin.IsAdmin = function() return true end
	admin.position, intruder.position = instance.origin, instance.origin
	admin.GetClass = function() return "player" end
	local findInBox = ents.FindInBox
	ents.FindInBox = function() return {admin, intruder} end
	PLUGIN.nextAudit, instance.nextCheckpoint = 0, math.huge
	PLUGIN:Think()
	ents.FindInBox = findInBox
	assert(admin.position == instance.origin and not PLUGIN.members[admin])
	assert(not PLUGIN:Contains(intruder:GetPos(), instance.mins, instance.maxs))
end)

Test("management sends actual invitations and permits revoking an offline invited character", function()
	local owner, inventory, instance, record = containerHome()
	local guest = FeatureClient(2)
	record.guests = {["2"] = true, ["3"] = false, ["4"] = true}
	local writeUInt, writeString = net.WriteUInt, net.WriteString
	local ids, names, price = {}, {}, nil
	net.WriteUInt = function(value, bits)
		if bits == 32 then
			if not price then price = value else ids[#ids + 1] = value end
		end
	end
	net.WriteString = function(value) names[value] = true end
	owner.position = PLUGIN.state.entrances.gate.pos
	PLUGIN:ShowManagement(owner, record.id, "entrance")
	net.WriteUInt, net.WriteString = writeUInt, writeString
	assert(price == 5000 and #ids == 2 and ids[1] == 2 and ids[2] == 4)
	assert(names["Character 2"] and names["Character #4"])
	assert(PLUGIN:HandleManagementAction(owner, record.id, 7, "4", 0))
	assert(record.guests["4"] == nil and record.guests["2"] == true)
	assert(not PLUGIN:HandleManagementAction(owner, record.id, 7, "3", 0))
end)

Test("administrator keypads list public squad rooms alongside owned rooms and invitations", function()
	local owner, inventory, instance, record = containerHome()
	local admin = FeatureClient(2)
	admin.IsAdmin = function() return true end
	admin.position = PLUGIN.state.entrances.gate.pos
	local owned = table.Copy(record)
	owned.id, owned.owner = "owned", admin:GetCharacter():GetID()
	PLUGIN.state.hideouts.owned = owned
	local invited = table.Copy(record)
	invited.id, invited.guests = "invited", {["2"] = true}
	PLUGIN.state.hideouts.invited = invited
	local squad = table.Copy(record)
	squad.id, squad.owner, squad.ownerType, squad.squadID, squad.access = "squad", nil, "squad", "squad1", "public"
	PLUGIN.state.hideouts.squad = squad
	ix.squad.list.squad1 = {members = {[2] = 2}}
	local start = netstream.Start
	local shown
	netstream.Start = function(client, message, entrance, records)
		assert(client == admin and message == "ixHideoutMenu" and entrance == "gate")
		shown = {}
		for _, entry in ipairs(records) do shown[entry.id] = true end
	end
	PLUGIN:ShowEntrance(admin, "gate")
	netstream.Start = start
	assert(shown.owned and shown.invited and shown.squad and not shown[record.id])
	assert(PLUGIN:CanAccess(admin, record) and PLUGIN:CanAccess(admin, squad))

	admin.ixHideoutMenuTime = nil
	invited.guests["2"] = nil
	ix.squad.list.squad1.members[2] = nil
	netstream.Start = function(client, message, entrance, records)
		local visible = {}
		for _, entry in ipairs(records) do visible[entry.id] = true end
		assert(#records == 2 and visible.owned and visible.squad)
	end
	PLUGIN:ShowEntrance(admin, "gate")
	admin.ixHideoutMenuTime = nil
	squad.access = "squad"
	netstream.Start = function(_, _, _, records)
		assert(#records == 1 and records[1].id == "owned")
	end
	PLUGIN:ShowEntrance(admin, "gate")
	netstream.Start = start
end)

Test("squad rooms use a shared entrance without a placed or configured squad entrance", function()
	FeatureReset()
	local leader = FeatureClient(1)
	local instance, record = FeatureHome(leader, true)
	record.entrance = "squad:" .. record.id
	PLUGIN.members[leader], instance.occupants[leader] = nil, nil
	leader.position = PLUGIN.state.entrances.gate.pos
	assert(not PLUGIN.state.entrances[record.entrance])
	assert(PLUGIN:FindHideoutEntrance(leader, record) == "gate")
	assert(PLUGIN:IsManagementLocation(leader, record, "entrance"))
	local start, shown = netstream.Start, nil
	netstream.Start = function(_, _, _, records) shown = records end
	PLUGIN:ShowEntrance(leader, "gate")
	netstream.Start = start
	assert(#shown == 1 and shown[1].id == record.id and shown[1].manage)
	assert(PLUGIN:RequestEntry(leader, record.id))
	assert(PLUGIN.members[leader] == record.id)
	assert(instance.occupants[leader].returnPoint[1] == PLUGIN.state.entrances.gate.pos)
end)

Test("squad shared-entrance admission rechecks the entrance after character save", function()
	FeatureReset()
	local leader = FeatureClient(1)
	local instance, record = FeatureHome(leader, true)
	record.entrance = "squad:" .. record.id
	PLUGIN.members[leader], instance.occupants[leader] = nil, nil
	leader.position = PLUGIN.state.entrances.gate.pos
	local saved
	leader:GetCharacter().Save = function(_, callback) saved = callback end
	assert(PLUGIN:RequestEntry(leader, record.id) and saved)
	PLUGIN.state.entrances.gate = nil
	saved()
	assert(not PLUGIN.members[leader] and not instance.occupants[leader])
end)

Test("prop capacity upgrades charge once and replay after a lost projection for both owner types", function()
	for _, squad in ipairs({false, true}) do
		FeatureReset()
		local owner = FeatureClient(1, 100000)
		local instance, record = FeatureHome(owner, squad)
		instance.exit = NewEntity(nil, instance.origin)
		PLUGIN:ShowManagement(owner, record.id, "exit")
		assert(PLUGIN:GetHideoutPropLimit(record) == 30)
		for tier, limit in ipairs({40, 50, 60}) do
			assert(PLUGIN:HandleManagementAction(owner, record.id, 0, "", tier))
			assert(PLUGIN:GetHideoutPropLimit(record) == limit)
			local balance = owner:GetCharacter():GetMoney()
			assert(not PLUGIN:HandleManagementAction(owner, record.id, 0, "", tier))
			assert(owner:GetCharacter():GetMoney() == balance)
		end
		assert(owner:GetCharacter():GetMoney() == 65000)
		assert(not PLUGIN:HandleManagementAction(owner, record.id, 0, "", 4))
		record.propTier = nil
		PLUGIN:RecoverUpgradeEntitlements(function(ok) assert(ok) end)
		assert(PLUGIN:GetHideoutPropLimit(record) == 60 and owner:GetCharacter():GetMoney() == 65000)
	end
end)

Test("prop capacity purchases reject insufficient funds, guests, demotion and failed commits", function()
	FeatureReset()
	local owner = FeatureClient(1, 100000)
	local instance, record = FeatureHome(owner, true)
	instance.exit = NewEntity(nil, instance.origin)
	PLUGIN:ShowManagement(owner, record.id, "exit")
	owner:GetCharacter().money = 0
	assert(not PLUGIN:HandleManagementAction(owner, record.id, 0, "", 1))
	assert(not record.propTier)
	owner:GetCharacter().money = 100000
	local commit = PLUGIN.CommitOperation
	PLUGIN.CommitOperation = function(_, _, _, _, callback) callback(false, "Database failure") end
	assert(PLUGIN:HandleManagementAction(owner, record.id, 0, "", 1))
	PLUGIN.CommitOperation = commit
	assert(not record.propTier and not PLUGIN.capacityPurchases[record.id] and instance.operations == 0)
	assert(owner:GetCharacter():GetMoney() == 100000)
	ix.squad.list.squad1.members[1] = 0
	assert(not PLUGIN:HandleManagementAction(owner, record.id, 0, "", 1))
	local guest = FeatureClient(2, 100000)
	record.guests["2"] = true
	guest.position, PLUGIN.members[guest] = instance.origin, record.id
	PLUGIN:ShowManagement(guest, record.id, "exit")
	assert(not PLUGIN:HandleManagementAction(guest, record.id, 0, "", 1))
end)

Test("pending prop purchases reject duplicates and recheck a delayed role response", function()
	FeatureReset()
	local owner = FeatureClient(1, 100000)
	local instance, record = FeatureHome(owner, true)
	instance.exit = NewEntity(nil, instance.origin)
	PLUGIN:ShowManagement(owner, record.id, "exit")
	local checkRole, pending = PLUGIN.CheckSquadRole, nil
	PLUGIN.CheckSquadRole = function(_, _, _, _, callback) pending = callback end
	assert(PLUGIN:HandleManagementAction(owner, record.id, 0, "", 1) and pending)
	assert(not PLUGIN:HandleManagementAction(owner, record.id, 0, "", 1))
	local deleted
	PLUGIN:DeleteHideout(record.id, function(ok) deleted = ok end)
	assert(deleted == false and not record.deleting)
	ix.squad.list.squad1.members[1] = 0
	pending(true)
	PLUGIN.CheckSquadRole = checkRole
	assert(not record.propTier and not PLUGIN.capacityPurchases[record.id] and instance.operations == 0)
	assert(owner:GetCharacter():GetMoney() == 100000)
end)
