local function squadStorage()
	FeatureReset()
	local leader, inventory = FeatureClient(1)
	local officer = FeatureClient(2)
	local member = FeatureClient(3)
	local outsider = FeatureClient(4)
	local instance, record = FeatureHome(leader, true)
	ix.squad.list.squad1.members[2], ix.squad.list.squad1.members[3] = 1, 0
	PLUGIN.state.templates.room.containers = {left = {recipe = "general", pos = Vector()}}
	local entity = NewEntity(nil, instance.origin)
	entity.ixHideout, entity.ixHideoutSlot = record.id, "left"
	instance.containers.left = entity
	for _, client in ipairs({officer, member, outsider}) do
		client.position, PLUGIN.members[client] = instance.origin, record.id
	end
	return leader, officer, member, outsider, instance, record, inventory
end

Test("squad containers admit every member by default and preserve independent rank controls", function()
	local leader, officer, member, outsider, instance, record = squadStorage()
	assert(PLUGIN:CanUseContainer(member, record, "left"))
	assert(not PLUGIN:CanManageContainer(member, record, "left"))
	record.access = "public"
	assert(not PLUGIN:CanUseContainer(outsider, record, "left"))
	assert(PLUGIN:SetContainerRank(officer, record, "left", 1))
	assert(not PLUGIN:CanUseContainer(member, record, "left"))
	assert(PLUGIN:CanUseContainer(officer, record, "left"))
	assert(not PLUGIN:SetContainerRank(officer, record, "left", 2))
	assert(PLUGIN:SetContainerRank(leader, record, "left", 2))
	assert(not PLUGIN:CanManageContainer(officer, record, "left"))
	assert(not PLUGIN:SetContainerRank(officer, record, "left", 0))
	assert(PLUGIN:SetContainerRank(leader, record, "left", 0))
	assert(PLUGIN:CanUseContainer(member, record, "left"))
end)

Test("squad storage upgrades require an officer and preserve contents and access", function()
	local leader, officer, member, outsider, instance, record = squadStorage()
	ix.item.list.value_container_smallitems = {model = "case.mdl", name = "Case"}
	local input = FeatureItem(officer:GetCharacter():GetInventory(), {}, "value_container_smallitems")
	assert(not PLUGIN:UpgradeContainer(member, record, "left", 0))
	assert(PLUGIN:SetContainerRank(leader, record, "left", 1))
	assert(PLUGIN:UpgradeContainer(officer, record, "left", 0))
	local slot = record.containers.left
	assert(slot.tier == 1 and slot.minimumRank == 1 and not ix.item.instances[input:GetID()])
	assert(not PLUGIN:UpgradeContainer(officer, record, "left", 0))
	assert(not PLUGIN:CanUseContainer(member, record, "left"))
	PLUGIN:OpenStorage(officer, instance.containers.left)
	assert(officer.cotzHideoutMenu.scope == "container")
	ix.squad.list.squad1.members[2] = 0
	assert(not PLUGIN:HandleManagementAction(officer, record.id, 10, "left", 1))
end)

Test("a demotion while a squad upgrade awaits SQL prevents consumption", function()
	local leader, officer, member, outsider, instance, record = squadStorage()
	ix.item.list.value_container_smallitems = {model = "case.mdl", name = "Case"}
	local inventory = officer:GetCharacter():GetInventory()
	local input = FeatureItem(inventory, {}, "value_container_smallitems")
	local originalQuery, resume = ix.crossserver.Query
	ix.crossserver.Query = function(query, callback)
		if query.tableName == "ix_items" then
			query:Callback(function(rows) resume = function() callback(rows) end end)
			query:Execute()
		else originalQuery(query, callback) end
	end
	assert(PLUGIN:UpgradeContainer(officer, record, "left", 0))
	assert(resume and officer.cotzHideoutOperation)
	ix.squad.list.squad1.members[2] = 0
	ix.crossserver.Query = originalQuery
	resume()
	assert(input.invID == inventory:GetID() and record.containers.left.tier == 0)
	assert(not officer.cotzHideoutOperation)
end)

Test("squad home claims enforce one map and preserve conflicting existing assets", function()
	FeatureReset()
	local leader = FeatureClient(1)
	local _, record = FeatureHome(leader, true)
	local allowed
	PLUGIN:ClaimSquadHome(record, function(ok) allowed = ok end)
	assert(allowed)
	local conflicting = table.Copy(record)
	conflicting.id = "999"
	PLUGIN:ClaimSquadHome(conflicting, function(ok) allowed = ok end)
	assert(not allowed)
	local update = mysql:Update("ix_hideout_homes")
	update:Update("map", "other_map")
	update:Where("squad", record.squadID)
	update:Execute()
	PLUGIN:InitializeSquadHomes(function(ok) assert(ok) end)
	assert(record.homeConflict and not PLUGIN:CanAccess(leader, record))
	assert(PLUGIN:GetHideout(record.id) == record)
end)

Test("personal room limits reject new grants without deleting existing rooms", function()
	FeatureReset()
	local owner = FeatureClient(1)
	PLUGIN.state.templates.room = {}
	local oldConfig = ix.config.Get
	ix.config.Get = function(key, default) if key == "hideoutPersonalLimit" then return 2 end return default end
	local first, second = PLUGIN:GrantHideout(owner, "room", "gate", "First")
	assert(PLUGIN:GrantHideout(owner, "room", "gate", "Second"))
	local third = PLUGIN:GrantHideout(owner, "room", "gate", "Third")
	ix.config.Get = oldConfig
	assert(first and not third and PLUGIN:GetHideout(second))
end)

local function sherpaStock()
	FeatureReset()
	local owner, inventory = FeatureClient(1, 1000)
	local buyer, destination = FeatureClient(2, 1000)
	local entity = NewEntity(nil, Vector())
	owner.position, buyer.position = Vector(), Vector()
	entity:SetSherpa(true)
	entity.sherpaID = "123456789abc"
	entity.sherpaClients = {[owner] = owner:GetCharacter(), [buyer] = buyer:GetCharacter()}
	owner:GetCharacter().HasSherpaVendor = function() return true end
	buyer:GetCharacter().HasSherpaVendor = function() return false end
	local record = ix.sherpa.GetRecord(entity)
	local stock = ix.inventory.Create(10, 8, 80)
	stock.vars.sherpa = entity
	record.shop.inventoryID = stock:GetID()
	PLUGIN:GetTreasury(record, function(balance) assert(balance == 0) end)
	return owner, inventory, buyer, destination, entity, stock, record
end

Test("individual Sherpas donate and sell original instances through the transaction adapter", function()
	local owner, inventory, buyer, destination, entity, stock, record = sherpaStock()
	local item = FeatureItem(inventory, {quantity = 7, durability = 31, name = "Saved rifle"})
	local id = item:GetID()
	ix.sherpa.Action(owner, entity, "donate", id, 0, 0)
	assert(item.invID == stock:GetID() and owner:GetCharacter():GetMoney() == 1000)
	entity.sherpaClients = {[owner] = owner:GetCharacter(), [buyer] = buyer:GetCharacter()}
	ix.sherpa.Action(owner, entity, "price", id, 200, 1)
	assert(item:GetData("cotzHideoutStock").price == 200)
	entity.sherpaClients = {[owner] = owner:GetCharacter(), [buyer] = buyer:GetCharacter()}
	ix.sherpa.Action(buyer, entity, "buy", id, 200, 2)
	assert(item.invID == destination:GetID() and item:GetID() == id)
	assert(item:GetData("quantity") == 7 and item:GetData("durability") == 31)
	assert(item:GetData("name") == "Saved rifle" and buyer:GetCharacter():GetMoney() == 800)
	PLUGIN:GetTreasury(record, function(balance) assert(balance == 190) end)
	entity.sherpaClients[owner] = owner:GetCharacter()
	ix.sherpa.Action(owner, entity, "withdraw", 0, 190, 0)
	assert(owner:GetCharacter():GetMoney() == 1190)
	PLUGIN:GetTreasury(record, function(balance) assert(balance == 0) end)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_items")) == 1)
end)

Test("Sherpa access cannot bypass stock permissions through transfers or actions", function()
	local owner, inventory, buyer, destination, entity, stock = sherpaStock()
	local item = FeatureItem(stock, {cotzHideoutStock = {price = 100, revision = 1}})
	ix.sherpa.Action(buyer, entity, "recover", item:GetID(), 0, 1)
	ix.sherpa.Action(buyer, entity, "price", item:GetID(), 1, 1)
	assert(item.invID == stock:GetID() and item:GetData("cotzHideoutStock").price == 100)
	assert(sherpaPlugin:CanTransferHideoutItem(item, stock, destination) == false)
	assert(sherpaPlugin:CanPlayerInteractItem(buyer, "drop", item) == false)
	ix.sherpa.Action(buyer, entity, "buy", item:GetID(), 100, 0)
	assert(buyer:GetCharacter():GetMoney() == 1000)
	buyer.position = Vector(10000, 0, 0)
	ix.sherpa.Action(buyer, entity, "buy", item:GetID(), 100, 1)
	assert(item.invID == stock:GetID())
end)

Test("full Sherpa destinations and failed SQL preserve stock and buyer money", function()
	local owner, inventory, buyer, destination, entity, stock = sherpaStock()
	local item = FeatureItem(stock, {cotzHideoutStock = {price = 100, revision = 1}})
	for x = 1, destination.w do
		destination.slots[x] = {}
		for y = 1, destination.h do destination.slots[x][y] = true end
	end
	ix.sherpa.Action(buyer, entity, "buy", item:GetID(), 100, 1)
	assert(item.invID == stock:GetID() and buyer:GetCharacter():GetMoney() == 1000)
	destination.slots = {}
	assert(sql.Query("CREATE TRIGGER reject_sherpa BEFORE UPDATE ON ix_items BEGIN SELECT RAISE(ABORT, 'test'); END") ~= false)
	ix.sherpa.Action(buyer, entity, "buy", item:GetID(), 100, 1)
	assert(item.invID == stock:GetID() and buyer:GetCharacter():GetMoney() == 1000)
end)

Test("standalone stock assignments survive a cold restore without recreating donated items", function()
	local owner, inventory, buyer, destination, entity, stock, record = sherpaStock()
	local saved
	sherpaPlugin.SetData = function(self, value) saved = table.Copy(value) end
	sherpaPlugin.GetData = function() return DecodeSavedKeys(saved or {}) end
	assert(sherpaPlugin:PersistStock())
	local item = FeatureItem(stock, {quantity = 11})
	local id = item:GetID()
	assert(sql.Query("UPDATE ix_items SET x = 1, y = 1 WHERE item_id = " .. id) ~= false)
	local originalNew = ix.item.New
	ix.item.New = function(uniqueID, itemID)
		local restored = originalNew(uniqueID, itemID)
		AttachCore(restored)
		restored.GetData = ix.meta.item.GetData
		return restored
	end
	ix.item.inventories[stock:GetID()], ix.item.instances[id] = nil, nil
	sherpaPlugin.records = nil
	sherpaPlugin:LoadData()
	local replacement = NewEntity(nil, Vector())
	replacement:SetSherpa(true)
	replacement.sherpaID = entity.sherpaID
	local restored
	ix.sherpa.LoadStock(replacement, function(inventory) restored = inventory end)
	ix.item.New = originalNew
	assert(restored and restored:GetID() == stock:GetID())
	assert(restored:GetItems(true)[id]:GetData("quantity") == 11)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_items")) == 1)
	assert(restored.vars.sherpa == replacement and not restored.vars.hideout)
end)

Test("personal owners have the same furnishing privileges while invited guests cannot build", function()
	FeatureReset()
	local owner = FeatureClient(1)
	local guest = FeatureClient(2)
	local instance, record = FeatureHome(owner)
	local prop = NewEntity(nil, instance.origin)
	instance.props[prop], prop.ixHideout = true, record.id
	guest.position, PLUGIN.members[guest], record.guests["2"] = instance.origin, record.id, true
	assert(PLUGIN:CanBuildInHideout(owner))
	assert(PLUGIN:GetHideoutEntityPermission(owner, prop))
	assert(not PLUGIN:CanBuildInHideout(guest))
	assert(not PLUGIN:GetHideoutEntityPermission(guest, prop))
end)

Test("admin vendor properties do not depend on squad membership or hook order", function()
	local leader, officer, member, admin, instance, record = squadStorage()
	local entity = NewEntity(nil, instance.origin)
	entity.GetClass = function() return "ix_hideout_vendor" end
	entity.ixHideout = record.id
	entity:SetSherpa(true)
	admin.IsAdmin = function() return true end
	assert(PLUGIN:GetHideoutEntityPermission(admin, entity, "vendor_edit"))
	assert(PLUGIN:CanProperty(admin, "vendor_edit", entity))
	assert(not PLUGIN:GetHideoutEntityPermission(member, entity, "vendor_edit"))
	assert(not PLUGIN:GetHideoutEntityPermission(admin, entity, "remover"))
	assert(ix.sherpa.ValidateAppearanceEdit(admin, entity, "name", "Our quartermaster"))
end)

Test("squad rooms restore the same container markers as personal rooms", function()
	local leader, officer, member, outsider, instance, record = squadStorage()
	instance.state = "loading"
	local restoreShop = PLUGIN.RestoreShop
	PLUGIN.RestoreShop = function(self, current, callback) callback(true) end
	local completed
	PLUGIN:RestoreStorage(instance, function(ok) completed = ok end)
	PLUGIN.RestoreShop = restoreShop
	assert(completed and IsValid(instance.containers.left))
	assert(instance.containers.left.ixHideoutSlot == "left")
	assert(record.containers.left.tier == 0)
end)

Test("bank callbacks recheck character and vendor distance before opening storage", function()
	local owner, inventory, buyer, destination, entity = sherpaStock()
	local originalGet, pending, opened = ix.plugin.Get, nil, 0
	local bank = {
		GetPersonalInventory = function(self, character, callback) pending = callback end,
		OpenPersonalInventory = function() opened = opened + 1 end,
	}
	ix.plugin.Get = function(name) if name == "personalstorage" then return bank end return originalGet(name) end
	ix.sherpa.OpenPersonalStorage(owner, entity)
	assert(pending)
	owner.position = Vector(10000, 0, 0)
	pending(inventory)
	assert(opened == 0)
	owner.position = Vector()
	owner.cotzSherpaStorage = nil
	ix.sherpa.OpenPersonalStorage(owner, entity)
	local character = owner.character
	owner.character = buyer:GetCharacter()
	pending(inventory)
	assert(opened == 0)
	owner.character = character
	owner.cotzSherpaStorage = nil
	ix.sherpa.OpenPersonalStorage(owner, entity)
	pending(inventory)
	assert(opened == 1)
	ix.plugin.Get = originalGet
end)

Test("squad provisioning reserves one durable home and rejects a second grant", function()
	FeatureReset()
	local leader = FeatureClient(1)
	PLUGIN.state.templates.room = {}
	local id
	assert(PLUGIN:GrantSquadHideout(leader, "room", "Headquarters", function(ok, result)
		assert(ok)
		id = result
	end))
	local record = PLUGIN:GetHideout(id)
	assert(record and record.ownerType == "squad" and not record.homePending)
	assert(not PLUGIN:GrantSquadHideout(leader, "room", "Second"))
	local row = sql.Query("SELECT * FROM ix_hideout_homes")[1]
	assert(tostring(row.hideout) == id and row.map == game.GetMap())
	PLUGIN:ReleaseSquadHome(record, function(ok) assert(ok) end)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_hideout_homes")) == 0)
end)

Test("squad repricing rechecks the listing revision after delayed role verification", function()
	local leader, officer, member, outsider, instance, record = squadStorage()
	local stock = ix.inventory.Create(10, 8, 80)
	instance.stock, instance.vendor = stock, NewEntity(nil, instance.origin)
	instance.vendor.ixHideout = record.id
	instance.shopClients = {[officer] = {character = officer:GetCharacter():GetID()}}
	local item = FeatureItem(stock, {cotzHideoutStock = {price = 100, revision = 1}})
	local originalCheck, resume = PLUGIN.CheckSquadRole
	PLUGIN.CheckSquadRole = function(self, client, home, rank, callback) resume = callback end
	PLUGIN:ShopAction(officer, record, "price", item:GetID(), 200, 1)
	item:SetData("cotzHideoutStock", {price = 300, revision = 2})
	PLUGIN.CheckSquadRole = originalCheck
	resume(true)
	assert(item:GetData("cotzHideoutStock").price == 300)
	assert(item:GetData("cotzHideoutStock").revision == 2)
end)
