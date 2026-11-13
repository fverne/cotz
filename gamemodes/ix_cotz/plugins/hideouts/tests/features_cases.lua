Test("personal containers default private and sharing is independent per spot", function()
	FeatureReset()
	local owner = FeatureClient(1)
	local guest = FeatureClient(2)
	local instance, record = FeatureHome(owner)
	PLUGIN.state.templates.room.containers = {
		left = {recipe = "general", pos = Vector()}, right = {recipe = "general", pos = Vector(40, 0, 0)},
	}
	record.guests["2"] = true
	local left = PLUGIN:GetContainer(record, "left")
	assert(left.public == false and PLUGIN:CanUseContainer(owner, record, "left"))
	assert(not PLUGIN:CanUseContainer(guest, record, "left"))
	assert(PLUGIN:SetContainerPublic(owner, record, "left", true))
	assert(PLUGIN:CanUseContainer(guest, record, "left"))
	assert(not PLUGIN:CanUseContainer(guest, record, "right"))
	assert(not PLUGIN:SetContainerPublic(guest, record, "right", true))
	record.guests["2"] = nil
	assert(not PLUGIN:CanUseContainer(guest, record, "left"))
	assert(PLUGIN:SetContainerPublic(owner, record, "left", false))
	assert(not PLUGIN:CanUseContainer(guest, record, "left"))
end)

Test("container transfer checks the selected spot rather than the legacy bank fixture", function()
	FeatureReset()
	local owner, inventory = FeatureClient(1)
	local guest = FeatureClient(2)
	local instance, record = FeatureHome(owner)
	PLUGIN.state.templates.room.containers = {ammo = {recipe = "ammo", pos = Vector()}}
	local slot = PLUGIN:GetContainer(record, "ammo")
	slot.tier, slot.width, slot.height = 1, 4, 4
	local storage = ix.inventory.Create(4, 4, 80)
	storage.vars.hideout, storage.vars.hideoutSlot = record.id, "ammo"
	local entity = NewEntity(nil, instance.origin)
	entity.ixHideout, entity.ixHideoutSlot = record.id, "ammo"
	instance.containers.ammo = entity
	local item = FeatureItem(inventory)
	assert(PLUGIN:CanTransferHideoutItem(item, inventory, storage, owner) == false)
	item.isAmmo = true
	assert(PLUGIN:CanTransferHideoutItem(item, inventory, storage, owner) == nil)
	assert(PLUGIN:CanTransferHideoutItem(item, inventory, storage, guest) == false)
	owner.position = Vector(10000, 0, 0)
	assert(PLUGIN:CanTransferHideoutItem(item, inventory, storage, owner) == false)
end)

local function shop()
	FeatureReset()
	local officer, inventory = FeatureClient(1, 1000)
	local buyer, destination = FeatureClient(2, 1000)
	local instance, record = FeatureHome(officer, true)
	local stock = ix.inventory.Create(10, 8, 80)
	stock.vars.hideout, stock.vars.hideoutSlot = record.id, "shop"
	instance.stock = stock
	instance.vendor = NewEntity(nil, instance.origin)
	instance.vendor.ixHideout = record.id
	instance.shopClients = {}
	record.access = "public"
	PLUGIN.members[buyer] = instance.id
	buyer.position = instance.origin
	instance.shopClients[buyer] = {character = 2}
	instance.shopClients[officer] = {character = 1}
	PLUGIN:GetTreasury(record, function(balance) assert(balance == 0) end)
	return officer, inventory, buyer, destination, instance, record, stock
end

Test("visiting administrators can open and buy squad stock without gaining management access", function()
	local officer, inventory, admin, destination, instance, record, stock = shop()
	PLUGIN.members[admin], instance.shopClients[admin] = nil, nil
	assert(not PLUGIN:IsNearUtility(admin, instance.vendor))
	admin.IsAdmin = function() return true end
	local listed = FeatureItem(stock, {cotzHideoutStock = {price = 100, revision = 1}})
	FeatureItem(stock, {cotzHideoutStock = {price = 0, revision = 1}})
	local sendStock, opened = ix.sherpa.SendStock, false
	ix.sherpa.SendStock = function(client, entity, id, name, rank, balance, commission, page, pages, rows)
		assert(client == admin and entity == instance.vendor and id == record.id)
		assert(rank == nil and balance == 0 and #rows == 1 and rows[1] == listed)
		opened = true
	end
	PLUGIN:OpenShop(admin, instance.vendor)
	ix.sherpa.SendStock = sendStock
	assert(opened and instance.shopClients[admin])
	assert(not PLUGIN:CanManageHideout(admin, record))
	PLUGIN:ShopAction(admin, record, "price", listed:GetID(), 1, 1)
	assert(listed:GetData("cotzHideoutStock").price == 100)
	PLUGIN:ShopAction(admin, record, "buy", listed:GetID(), 100, 1)
	assert(listed.invID == destination:GetID() and admin:GetCharacter():GetMoney() == 900)
	local container = NewEntity(nil, instance.origin)
	container.ixHideout = record.id
	assert(not PLUGIN:IsNearUtility(admin, container))
	instance.saving = true
	assert(not PLUGIN:IsNearUtility(admin, instance.vendor))
	instance.saving = nil
	admin.position = instance.origin + Vector(1000, 0, 0)
	assert(not PLUGIN:IsNearUtility(admin, instance.vendor))
end)

Test("donation pays nothing and purchase preserves the same item row and data", function()
	local officer, inventory, buyer, destination, instance, record, stock = shop()
	local item = FeatureItem(inventory, {quantity = 19, durability = 37, name = "Unique rifle"})
	local id = item:GetID()
	PLUGIN:TransferShopItem(officer, record, instance, item, stock, 0, 0, 0, 0)
	assert(item.invID == stock:GetID() and officer:GetCharacter():GetMoney() == 1000)
	PLUGIN:GetTreasury(record, function(balance) assert(balance == 0) end)
	item:SetData("cotzHideoutStock", {price = 200, revision = 1})
	instance.shopClients[buyer] = {character = 2}
	PLUGIN:ShopAction(buyer, record, "buy", id, 200, 1)
	assert(item:GetID() == id and item.invID == destination:GetID())
	assert(item:GetData("quantity") == 19 and item:GetData("durability") == 37)
	assert(item:GetData("name") == "Unique rifle" and item:GetData("cotzHideoutStock") == nil)
	assert(buyer:GetCharacter():GetMoney() == 800)
	PLUGIN:GetTreasury(record, function(balance) assert(balance == 190) end)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_items")) == 1)
	local row = sql.Query("SELECT * FROM ix_items WHERE item_id = " .. id)[1]
	assert(tonumber(row.inventory_id) == destination:GetID())
	assert(util.JSONToTable(row.data).quantity == 19)
	assert(PLUGIN:CanTransferHideoutItem(item, destination, stock, buyer) == false)
end)

Test("failed database commit rolls back receipt, custody, treasury, and reserved payment", function()
	local officer, inventory, buyer, destination, instance, record, stock = shop()
	local item = FeatureItem(stock, {quantity = 8, cotzHideoutStock = {price = 100, revision = 1}})
	local trigger = "CREATE TRIGGER reject_item BEFORE UPDATE ON ix_items BEGIN SELECT RAISE(ABORT, 'test'); END"
	assert(sql.Query(trigger) ~= false)
	PLUGIN:ShopAction(buyer, record, "buy", item:GetID(), 100, 1)
	assert(item.invID == stock:GetID() and buyer:GetCharacter():GetMoney() == 1000)
	PLUGIN:GetTreasury(record, function(balance) assert(balance == 0) end)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_hideout_operations")) == 0)
	assert(tonumber(sql.QueryValue("SELECT inventory_id FROM ix_items")) == stock:GetID())
	assert(not buyer.cotzHideoutOperation)
end)

Test("stale and repeated purchases cannot pay or acquire another item copy", function()
	local officer, inventory, buyer, destination, instance, record, stock = shop()
	local item = FeatureItem(stock, {cotzHideoutStock = {price = 100, revision = 2}})
	PLUGIN:ShopAction(buyer, record, "buy", item:GetID(), 100, 1)
	assert(buyer:GetCharacter():GetMoney() == 1000 and item.invID == stock:GetID())
	PLUGIN:ShopAction(buyer, record, "buy", item:GetID(), 100, 2)
	assert(buyer:GetCharacter():GetMoney() == 900)
	instance.shopClients[buyer] = {character = 2}
	PLUGIN:ShopAction(buyer, record, "buy", item:GetID(), 100, 2)
	assert(buyer:GetCharacter():GetMoney() == 900)
	PLUGIN:GetTreasury(record, function(balance) assert(balance == 95) end)
end)

Test("full inventories leave stock and payment untouched", function()
	local officer, inventory, buyer, destination, instance, record, stock = shop()
	local item = FeatureItem(stock, {cotzHideoutStock = {price = 100, revision = 1}})
	for x = 1, destination.w do
		destination.slots[x] = {}
		for y = 1, destination.h do destination.slots[x][y] = true end
	end
	PLUGIN:ShopAction(buyer, record, "buy", item:GetID(), 100, 1)
	assert(item.invID == stock:GetID() and buyer:GetCharacter():GetMoney() == 1000)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_hideout_operations")) == 0)
end)

Test("upgrade consumption recovers its entitlement without consuming a second container", function()
	FeatureReset()
	local owner, inventory = FeatureClient(1, 1000)
	local instance, record = FeatureHome(owner, true)
	PLUGIN.state.templates.room.containers = {left = {recipe = "general", pos = Vector()},
		right = {recipe = "general", pos = Vector(40, 0, 0)}}
	ix.item.list.value_container_smallitems = {model = "case.mdl", name = "Case"}
	local input = FeatureItem(inventory, {}, "value_container_smallitems")
	local entity = NewEntity(nil, instance.origin)
	entity.ixHideout, entity.ixHideoutSlot = record.id, "left"
	instance.containers.left = entity
	assert(PLUGIN:UpgradeContainer(owner, record, "left"))
	assert(not ix.item.instances[input:GetID()])
	assert(record.containers.left.tier == 1 and record.containers.left.public == false)
	assert((record.containers.right or {}).tier == nil)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_items")) == 0)
	record.containers.left.tier = 0
	PLUGIN:RecoverUpgradeEntitlements(function(ok) assert(ok) end)
	assert(record.containers.left.tier == 1 and record.containers.left.width == 3)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_items")) == 0)
end)

Test("squad members always enter while guests follow the selected policy", function()
	FeatureReset()
	local owner = FeatureClient(1)
	local guest = FeatureClient(2)
	local instance, record = FeatureHome(owner, true)
	assert(PLUGIN:CanAccess(owner, record) and not PLUGIN:CanAccess(guest, record))
	record.access = "invite"
	record.guests["2"] = true
	assert(PLUGIN:CanAccess(guest, record))
	record.access = "squad"
	assert(not PLUGIN:CanAccess(guest, record) and PLUGIN:CanAccess(owner, record))
	record.access = "public"
	assert(PLUGIN:CanAccess(guest, record))
	ix.squad.list.squad1 = nil
	assert(not PLUGIN:CanAccess(guest, record))
end)

Test("officer permissions protect the shell and allow the squad vendor", function()
	local owner, inventory, guest, destination, instance, record = shop()
	local shell = NewEntity(nil, instance.origin)
	shell.ixHideout = record.id
	assert(PLUGIN:GetHideoutEntityPermission(owner, shell) == false)
	assert(PLUGIN:GetHideoutEntityPermission(owner, instance.vendor) == true)
	assert(PLUGIN:GetHideoutEntityPermission(guest, instance.vendor) == false)
	assert(PLUGIN:CanTool(owner, {Entity = shell}, "remover") == false)
	assert(PLUGIN:CanTool(owner, {Entity = instance.vendor}, "duplicator") == false)
	assert(PLUGIN:CharacterHasFlags(owner:GetCharacter(), "e") == true)
	owner.position = Vector(10000, 0, 0)
	assert(not PLUGIN:CanBuildInHideout(owner))
end)

Test("artifact destination follows hideout identity after instance relocation", function()
	FeatureReset()
	local owner = FeatureClient(1)
	local instance, record = FeatureHome(owner)
	owner.position = instance.origin + Vector(20, 0, 8)
	local destination = PLUGIN:CaptureDestination(owner)
	assert(destination.id == record.id and destination.pos.x == 20 and destination.map == "testmap")
	instance.origin = instance.origin + Vector(300, 0, 0)
	instance.mins, instance.maxs = Vector(), Vector(1000, 1000, 1000)
	PLUGIN.members[owner] = nil
	instance.occupants[owner] = nil
	owner.position = Vector(10000, 0, 8)
	local arrived
	PLUGIN:RequestTeleportEntry(owner, destination, function(ok) arrived = ok end)
	assert(arrived and owner:GetPos().x == instance.origin.x + 20)
	assert(PLUGIN.members[owner] == record.id and instance.occupants[owner])
	record.owner = 99
	local denied
	PLUGIN:RequestTeleportEntry(owner, destination, function(ok) denied = not ok end)
	assert(denied)
end)

Test("pending purchase reserves custody and preserves unrelated wallet changes and saves", function()
	local officer, inventory, buyer, destination, instance, record, stock = shop()
	local other = FeatureClient(3, 1000)
	other.position = instance.origin
	PLUGIN.members[other] = instance.id
	instance.shopClients[other] = {character = 3}
	local item = FeatureItem(stock, {cotzHideoutStock = {price = 100, revision = 1}})
	local atomic, queries, complete = PLUGIN.RunAtomicQueries
	PLUGIN.RunAtomicQueries = function(self, batch, callback) queries, complete = batch, callback end
	PLUGIN:ShopAction(buyer, record, "buy", item:GetID(), 100, 1)
	assert(buyer.cotzHideoutOperation and buyer:GetCharacter():GetMoney() == 900)
	local saved
	buyer:GetCharacter():GiveMoney(25)
	buyer:GetCharacter():Save(function() saved = true end)
	assert(not saved and tonumber(sql.QueryValue("SELECT money FROM ix_characters WHERE id=2")) == 1000)
	PLUGIN:ShopAction(other, record, "buy", item:GetID(), 100, 1)
	assert(other:GetCharacter():GetMoney() == 1000 and not other.cotzHideoutOperation)
	assert(PLUGIN:CanTransferHideoutItem(item, stock, destination, buyer) == false)
	atomic(PLUGIN, queries, complete)
	PLUGIN.RunAtomicQueries = atomic
	assert(saved and buyer:GetCharacter():GetMoney() == 925)
	assert(tonumber(sql.QueryValue("SELECT money FROM ix_characters WHERE id=2")) == 925)
	assert(item.invID == destination:GetID())
	PLUGIN:GetTreasury(record, function(balance) assert(balance == 95) end)
end)

Test("treasury withdrawals require actual funds and never overdraw", function()
	local officer, inventory, buyer, destination, instance, record, stock = shop()
	assert(sql.Query("UPDATE ix_hideout_treasuries SET balance=75") ~= false)
	PLUGIN:ShopAction(officer, record, "withdraw", 0, 50, 0)
	assert(officer:GetCharacter():GetMoney() == 1050)
	PLUGIN:GetTreasury(record, function(balance) assert(balance == 25) end)
	PLUGIN:ShopAction(officer, record, "withdraw", 0, 50, 0)
	assert(officer:GetCharacter():GetMoney() == 1050)
	PLUGIN:GetTreasury(record, function(balance) assert(balance == 25) end)
	PLUGIN:ShopAction(buyer, record, "withdraw", 0, 10, 0)
	assert(buyer:GetCharacter():GetMoney() == 1000)
end)

Test("demotion between permission check and commit cannot withdraw treasury funds", function()
	local officer, inventory, buyer, destination, instance, record, stock = shop()
	assert(sql.Query("CREATE TABLE IF NOT EXISTS ix_squads_members(scope TEXT, squad_id TEXT, "
		.. "character_id INTEGER, member_rank INTEGER)") ~= false)
	assert(sql.Query("CREATE TABLE IF NOT EXISTS ix_squads_state(scope TEXT, squad_id TEXT, active INTEGER)") ~= false)
	assert(sql.Query("DELETE FROM ix_squads_members") ~= false)
	assert(sql.Query("DELETE FROM ix_squads_state") ~= false)
	assert(sql.Query("INSERT INTO ix_squads_state VALUES ('testschema','squad1',1)") ~= false)
	assert(sql.Query("INSERT INTO ix_squads_members VALUES ('testschema','squad1',1,2)") ~= false)
	assert(sql.Query("UPDATE ix_hideout_treasuries SET balance=75") ~= false)
	ix.squad.list.squad1.hideoutFresh = CurTime()
	ix.squad.cross = {Enabled = function() return true end, ready = true, Query = ix.crossserver.Query}
	local atomic, queries, complete = PLUGIN.RunAtomicQueries
	PLUGIN.RunAtomicQueries = function(self, batch, callback) queries, complete = batch, callback end
	PLUGIN:ShopAction(officer, record, "withdraw", 0, 50, 0)
	assert(queries)
	assert(sql.Query("UPDATE ix_squads_members SET member_rank=0") ~= false)
	atomic(PLUGIN, queries, complete)
	PLUGIN.RunAtomicQueries = atomic
	ix.squad.cross = {Enabled = function() return false end}
	assert(officer:GetCharacter():GetMoney() == 1000)
	PLUGIN:GetTreasury(record, function(balance) assert(balance == 75) end)
end)

Test("vendor reset repairs an unreachable or missing entity without touching stock", function()
	local officer, inventory, buyer, destination, instance, record, stock = shop()
	local item = FeatureItem(stock, {durability = 42, cotzHideoutStock = {price = 100, revision = 1}})
	instance.vendor.position = Vector(50000, 0, 0)
	assert(PLUGIN:ResetVendor(officer, record))
	assert(instance.vendor:GetPos().x == instance.origin.x)
	assert(item.invID == stock:GetID() and item:GetData("durability") == 42)
	Advance(6)
	instance.vendor.valid = false
	assert(PLUGIN:ResetVendor(officer, record))
	assert(IsValid(instance.vendor) and instance.stock == stock)
	assert(not PLUGIN:ResetVendor(buyer, record))
	PLUGIN:GetTreasury(record, function(balance) assert(balance == 0) end)
end)

Test("cross-map artifact intent admits once after destination load and sets cooldown", function()
	FeatureReset()
	local owner, inventory = FeatureClient(1)
	local instance, record = FeatureHome(owner)
	local artifact = FeatureItem(inventory, {quantity = 1})
	local destination = PLUGIN:CaptureDestination(owner)
	PLUGIN.members[owner], instance.occupants[owner] = nil, nil
	owner.position = Vector(10000, 0, 8)
	local getMap, getPlugin = game.GetMap, ix.plugin.Get
	game.GetMap = function() return "source_map" end
	local requested
	ix.plugin.Get = function(name)
		if name == "simplecrossserver" then
			return {mapdata = {testmap = {}}, RedirectPlayerNoLoadZone = function(self, client, map, callback)
				assert(map == "testmap" and client:GetCharacter():GetData("pendingHideoutArrival"))
				requested = true
				callback(true)
			end}
		end
		return getPlugin(name)
	end
	local handedOff
	PLUGIN:BeginArtifactTravel(owner, destination, artifact, function(ok, reason)
		handedOff = ok and reason == "handoff"
	end)
	assert(requested and handedOff and owner:GetCharacter():GetData("pendingHideoutArrival"))
	game.GetMap, ix.plugin.Get = getMap, getPlugin
	assert(PLUGIN:GetCharacterRestorePosition(owner, owner:GetCharacter(), {}) == false)
	PLUGIN:PlayerLoadedCharacter(owner, owner:GetCharacter())
	RunFeatureTimers(0.1)
	assert(PLUGIN.members[owner] == record.id and not owner:GetCharacter():GetData("pendingHideoutArrival"))
	assert(artifact:GetData("cooldown") > os.time())
	local position = owner:GetPos()
	PLUGIN:PlayerLoadedCharacter(owner, owner:GetCharacter())
	RunFeatureTimers(0.1)
	assert(owner:GetPos() == position)
end)

Test("cross-map arrival rejects revoked access and leaves the artifact unspent", function()
	FeatureReset()
	local owner, inventory = FeatureClient(1)
	local instance, record = FeatureHome(owner)
	local artifact = FeatureItem(inventory)
	local destination = PLUGIN:CaptureDestination(owner)
	PLUGIN.members[owner], instance.occupants[owner] = nil, nil
	record.owner = 99
	owner:GetCharacter():SetData("pendingHideoutArrival", {
		destination = destination, token = "arrival", character = 1, artifact = artifact:GetID(), expires = os.time() + 180,
	})
	PLUGIN:PlayerLoadedCharacter(owner, owner:GetCharacter())
	RunFeatureTimers(0.1)
	assert(not PLUGIN.members[owner] and not owner:GetCharacter():GetData("pendingHideoutArrival"))
	assert(not artifact:GetData("cooldown"))
	assert(owner:GetPos().x == 10000)
end)

Test("a lost commit acknowledgement is resolved from its receipt without refunding a completed sale", function()
	local officer, inventory, buyer, destination, instance, record, stock = shop()
	local item = FeatureItem(stock, {cotzHideoutStock = {price = 100, revision = 1}})
	local atomic = PLUGIN.RunAtomicQueries
	PLUGIN.RunAtomicQueries = function(self, queries, callback)
		atomic(self, queries, function(ok) assert(ok) callback(nil, "lost acknowledgement") end)
	end
	PLUGIN:ShopAction(buyer, record, "buy", item:GetID(), 100, 1)
	PLUGIN.RunAtomicQueries = atomic
	assert(buyer:GetCharacter():GetMoney() == 900 and item.invID == destination:GetID())
	PLUGIN:GetTreasury(record, function(balance) assert(balance == 95) end)
end)

Test("disconnect during commit cannot write a stale wallet over a newer session", function()
	local officer, inventory, buyer, destination, instance, record, stock = shop()
	local item = FeatureItem(stock, {cotzHideoutStock = {price = 100, revision = 1}})
	local atomic, complete = PLUGIN.RunAtomicQueries
	PLUGIN.RunAtomicQueries = function(self, queries, callback)
		atomic(self, queries, function(ok, rows) complete = function() callback(ok, rows) end end)
	end
	PLUGIN:ShopAction(buyer, record, "buy", item:GetID(), 100, 1)
	assert(PLUGIN:IsCharacterOperationPending(buyer:GetCharacter()))
	buyer.valid = false
	assert(sql.Query("UPDATE ix_characters SET money=800 WHERE id=2") ~= false)
	complete()
	PLUGIN.RunAtomicQueries = atomic
	assert(tonumber(sql.QueryValue("SELECT money FROM ix_characters WHERE id=2")) == 800)
	assert(buyer:GetCharacter().cotzHideoutStale)
	buyer:GetCharacter():Save()
	assert(tonumber(sql.QueryValue("SELECT money FROM ix_characters WHERE id=2")) == 800)
end)

Test("making an open container private expires the guest session and its transfers", function()
	FeatureReset()
	local owner, inventory = FeatureClient(1)
	local guest = FeatureClient(2)
	local instance, record = FeatureHome(owner)
	PLUGIN.state.templates.room.containers = {left = {recipe = "general", pos = Vector()}}
	local storage = ix.inventory.Create(3, 3, 80)
	record.containers.left = {tier = 1, width = 3, height = 3, inventoryID = 80, public = true}
	record.guests["2"] = true
	local entity = NewEntity(nil, instance.origin)
	entity.ixHideout, entity.ixHideoutSlot = record.id, "left"
	instance.containers.left = entity
	PLUGIN.members[guest] = instance.id
	guest.position = instance.origin
	PLUGIN:OpenStorage(guest, entity)
	assert(guest.ixOpenStorage == storage)
	assert(PLUGIN:SetContainerPublic(owner, record, "left", false))
	assert(not guest.ixOpenStorage)
	local item = FeatureItem(inventory)
	assert(PLUGIN:CanTransferHideoutItem(item, storage, inventory, guest) == false)
end)

Test("retirement retains container references for explicit administrator recovery", function()
	FeatureReset()
	local owner, inventory = FeatureClient(1)
	local instance, record = FeatureHome(owner)
	local storage = ix.inventory.Create(3, 3, 80)
	record.containers.left = {tier = 1, width = 3, height = 3, inventoryID = 80, public = false}
	local item = FeatureItem(storage, {quantity = 5})
	local deleted
	PLUGIN:DeleteHideout(record.id, function(ok) deleted = ok end)
	assert(deleted and not PLUGIN:GetHideout(record.id))
	assert(PLUGIN.state.retired[record.id].containers.left.inventoryID == 80)
	assert(tonumber(sql.QueryValue("SELECT inventory_id FROM ix_items")) == 80)
	owner.IsAdmin = function() return true end
	assert(PLUGIN:OpenRecoveryInventory(owner, record.id, "left"))
	assert(item:Transfer(inventory:GetID(), nil, nil, owner))
	assert(item:GetData("quantity") == 5 and item.invID == inventory:GetID())
end)

Test("an unverifiable outcome keeps funds reserved until receipt absence is established", function()
	local officer, inventory, buyer, destination, instance, record, stock = shop()
	local item = FeatureItem(stock, {cotzHideoutStock = {price = 100, revision = 1}})
	local atomic, query, resolve = PLUGIN.RunAtomicQueries, ix.crossserver.Query
	PLUGIN.RunAtomicQueries = function(self, batch, callback) callback(nil, "connection interrupted") end
	ix.crossserver.Query = function(statement, callback)
		if statement.tableName == "ix_hideout_operations" then resolve = callback return end
		query(statement, callback)
	end
	PLUGIN:ShopAction(buyer, record, "buy", item:GetID(), 100, 1)
	assert(resolve and buyer.cotzHideoutOperation and buyer:GetCharacter():GetMoney() == 900)
	assert(item.invID == stock:GetID())
	ix.crossserver.Query = query
	resolve({}, nil)
	PLUGIN.RunAtomicQueries = atomic
	assert(not buyer.cotzHideoutOperation and buyer:GetCharacter():GetMoney() == 1000)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_hideout_operations")) == 0)
end)
