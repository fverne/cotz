local function personalHome()
	FeatureReset()
	PLUGIN.personalPurchases = {}
	PLUGIN.personalContacts.testmap = PLUGIN.personalContacts.rp_marsh_cs
	ix.progression = {IsCompleted = function(character, id) return (character.completed or {})[id] == true end}
	ix.currency = {Get = function(amount) return amount .. " roubles" end}
	local owner, inventory = FeatureClient(1, 100000)
	owner:GetCharacter().completed = {}
	local instance, record = FeatureHome(owner)
	PLUGIN.state.templates.room.containers = {
		general = {recipe = "general", pos = Vector()}, ammo = {recipe = "ammo", pos = Vector(40, 0, 0)},
		medical = {recipe = "medical", pos = Vector(-40, 0, 0)}, weapon = {recipe = "weapon", pos = Vector(0, 40, 0)},
	}
	for _, recipe in pairs(PLUGIN.personalContainerRecipes) do
		ix.item.list[recipe.item] = {model = recipe.models[1], name = recipe.name, width = 2, height = 2}
	end
	assert(PLUGIN:PreparePersonalStorage(instance))
	local target = NewEntity(nil, owner:GetPos())
	target.GetClass = function() return "ix_hideout_entrance" end
	target.ixEntranceID = "gate"
	PLUGIN.entranceEntities = {gate = target}
	PLUGIN.state.entrances.gate.pos = owner:GetPos()

	return owner, inventory, instance, record, target
end

local function complete(client, step)
	for index = 1, step do
		client:GetCharacter().completed["cotz/town/ballast/v3/hideout/" .. string.format("%02d", index)] = true
	end
end

Test("locations claim one free room each while admin grants allow several at one entrance", function()
	local owner, inventory, instance, record, target = personalHome()
	PLUGIN.state.hideouts = {}
	PLUGIN.instances, PLUGIN.members = {}, {}
	assert(PLUGIN:AddPersonalLocation("village", "room", "gate", "Village room"):find("registered"))
	assert(not PLUGIN:ClaimPersonalLocation(owner, target, "village"))
	owner:GetCharacter().completed["cotz/town/ballast/v3/hideout/access"] = true
	assert(PLUGIN:ClaimPersonalLocation(owner, target, "village"))
	assert(not PLUGIN:ClaimPersonalLocation(owner, target, "village"))
	local granted, grantedID = PLUGIN:GrantHideout(owner, "room", "gate", "Admin extra")
	assert(granted)
	local grantedRecord = PLUGIN:GetHideout(grantedID)
	assert(grantedRecord.ownerName == owner:GetCharacter():GetName())
	assert(PLUGIN:GetHideoutName(grantedRecord) == "Character 1's Admin extra")
	assert(table.Count(PLUGIN.state.hideouts) == 2)
	assert(owner:GetCharacter():GetMoney() == 100000)
	assert(not PLUGIN:ClaimPersonalLocation(owner, target, "missing"))
	target.ixEntranceID = "missing"
	assert(not PLUGIN:ClaimPersonalLocation(owner, target, "village"))
	assert(TEST_COMMANDS.HideoutLocationAdd.adminOnly and TEST_COMMANDS.HideoutGrant.adminOnly)
end)

Test("personal rooms begin with exactly one private 2 by 3 crate and no unpurchased entities", function()
	local owner, inventory, instance, record = personalHome()
	instance.state = "loading"
	PLUGIN:RestoreStorage(instance, function(ok) assert(ok) end)
	assert(record.containers.general.tier == 1 and record.containers.general.width == 2)
	assert(record.containers.general.height == 3 and not record.containers.general.public)
	assert(IsValid(instance.containers.general) and table.Count(instance.containers) == 1)
	assert(record.containers.ammo.tier == 0 and not instance.containers.ammo)
	assert(PLUGIN:GetPersonalFloorLimit(record) == 4 and not PLUGIN:CanBuildInHideout(owner))
	assert(PLUGIN:PreparePersonalStorage(instance))
	assert(record.containers.general.tier == 1)
end)

Test("purchased personal containers follow current tier models on restore and refresh", function()
	for _, recipeID in ipairs({"general", "ammo", "medical", "weapon"}) do
		for _, level in ipairs({1, 3}) do
			local owner, inventory, instance, record = personalHome()
			local slot = record.containers[recipeID]
			local tier = PLUGIN.personalContainerRecipes[recipeID].tiers[level]
			slot.tier, slot.model = level, "old-purchase.mdl"
			slot.width, slot.height = 12, 14
			slot.public, slot.guests = true, {["2"] = true}
			slot.transform = {pos = Vector(10, 20, 30), angles = Angle(0, 45, 0)}
			local storage = ix.inventory.Create(12, 14, 880)
			slot.inventoryID = storage:GetID()
			local item = FeatureItem(storage, {name = "Keep this"})
			local saved = table.Copy(slot)
			instance.state = "loading"
			PLUGIN:RestoreStorage(instance, function(ok) assert(ok) end)
			assert(instance.containers[recipeID].model == tier.model)
			instance.state = "active"
			local entity = instance.containers[recipeID]
			entity:SetModel("outdated-live.mdl")
			PLUGIN:RefreshPersonalContainer(record, recipeID)
			assert(instance.containers[recipeID] == entity and entity.model == tier.model)
			entity:Remove()
			PLUGIN:RefreshPersonalContainer(record, recipeID)
			entity = instance.containers[recipeID]
			assert(IsValid(entity) and entity.model == tier.model)
			assert(entity:GetPos():DistToSqr(instance.origin + saved.transform.pos) == 0)
			assert(entity:GetAngles().p == saved.transform.angles.p)
			assert(entity:GetAngles().y == saved.transform.angles.y)
			assert(entity:GetAngles().r == saved.transform.angles.r)
			assert(slot.model == saved.model and slot.tier == saved.tier)
			assert(slot.width == saved.width and slot.height == saved.height)
			assert(slot.inventoryID == saved.inventoryID and item.invID == saved.inventoryID)
			assert(slot.public and slot.guests["2"])
		end
	end
end)

Test("unmarked personal templates get one starter crate at the configured storage point", function()
	local owner, inventory, instance, record = personalHome()
	record.containers, record.starterSlot, record.personalLayout = {}, nil, nil
	instance.template = nil
	PLUGIN.state.templates.room.containers = nil
	assert(PLUGIN:PreparePersonalStorage(instance))
	assert(record.starterSlot == "personal_starter" and record.containers.personal_starter.width == 2)
	assert(table.Count(record.personalLayout) == 1)
end)

Test("local milestones grant purchase permissions separately from each room's purchases", function()
	local owner, inventory, instance, record, target = personalHome()
	local quote = PLUGIN:BuildPersonalOffer(owner, record, "container", "ammo")
	assert(not quote.allowed and not PLUGIN:PurchasePersonalOffer(owner, target, quote))
	complete(owner, 1)
	quote = PLUGIN:BuildPersonalOffer(owner, record, "container", "ammo")
	assert(quote.allowed and not PLUGIN:PurchasePersonalOffer(owner, target, quote))
	local input = FeatureItem(inventory, {}, quote.item)
	assert(PLUGIN:PurchasePersonalOffer(owner, target, quote))
	assert(not ix.item.instances[input:GetID()] and owner:GetCharacter():GetMoney() == 100000 - quote.price)
	assert(record.containers.ammo.width == 4 and record.containers.ammo.height == 4)
	assert(IsValid(instance.containers.ammo) and instance.containers.ammo.model == quote.model)
	assert(not PLUGIN:PurchasePersonalOffer(owner, target, quote))
	local floor = PLUGIN:BuildPersonalOffer(owner, record, "floor")
	assert(not floor.allowed)
	complete(owner, 2)
	floor = PLUGIN:BuildPersonalOffer(owner, record, "floor")
	assert(PLUGIN:PurchasePersonalOffer(owner, target, floor) and PLUGIN:GetPersonalFloorLimit(record) == 6)
	complete(owner, 4)
	assert(PLUGIN:PurchasePersonalOffer(owner, target, PLUGIN:BuildPersonalOffer(owner, record, "floor")))
	assert(PLUGIN:GetPersonalFloorLimit(record) == 8)
	assert(not PLUGIN:BuildPersonalOffer(owner, record, "floor").allowed)
	complete(owner, 3)
	assert(PLUGIN:PurchasePersonalOffer(owner, target, PLUGIN:BuildPersonalOffer(owner, record, "furnishing")))
	assert(PLUGIN:CanBuildInHideout(owner))
	for _, contact in pairs(PLUGIN.personalContacts) do
		assert(contact.name and contact.prefix and contact.id)
	end
end)

Test("container upgrades preserve inventory, sharing, contents and change model at configured levels", function()
	local owner, inventory, instance, record, target = personalHome()
	complete(owner, 1)
	complete(owner, 3)
	record.containers.general.public = true
	local quote = PLUGIN:BuildPersonalOffer(owner, record, "container", "general")
	target = instance.containers.general or NewEntity(nil, instance.origin)
	target.GetClass = function() return "ix_hideout_storage" end
	target.ixHideout, target.ixHideoutSlot = record.id, "general"
	instance.containers.general = target
	FeatureItem(inventory, {cotzHideoutCrate = {level = quote.level, squad = false, version = 1}}, quote.item)
	assert(PLUGIN:PurchasePersonalOffer(owner, target, quote))
	local slot = record.containers.general
	local id = slot.inventoryID
	local storage = ix.inventory.Get(id)
	local item = FeatureItem(storage, {name = "Keep this"})
	quote = PLUGIN:BuildPersonalOffer(owner, record, "container", "general")
	FeatureItem(inventory, {cotzHideoutCrate = {level = quote.level, squad = false, version = 1}}, quote.item)
	assert(PLUGIN:PurchasePersonalOffer(owner, target, quote))
	assert(slot.tier == 3 and slot.width == 3 and slot.height == 4)
	assert(slot.inventoryID == id and slot.public and item.invID == id)
	assert(instance.containers.general.model == PLUGIN.personalContainerRecipes.general.tiers[3].model)
	assert(PLUGIN:BuildPersonalOffer(owner, record, "container", "general").allowed)
	PLUGIN.instances, PLUGIN.members = {}, {}
	local offline = PLUGIN:BuildPersonalOffer(owner, record, "container", "ammo")
	local input = FeatureItem(inventory, {}, offline.item)
	assert(not PLUGIN:PurchasePersonalOffer(owner, target, offline))
	assert(ix.item.instances[input:GetID()] and record.containers.ammo.tier == 0)
end)

Test("failed transactions retain cash, required items and entitlements", function()
	local owner, inventory, instance, record, target = personalHome()
	complete(owner, 1)
	local quote = PLUGIN:BuildPersonalOffer(owner, record, "container", "ammo")
	local item = FeatureItem(inventory, {}, quote.item)
	local atomic = PLUGIN.RunAtomicQueries
	PLUGIN.RunAtomicQueries = function(self, queries, callback) callback(false, "Simulated rollback") end
	assert(PLUGIN:PurchasePersonalOffer(owner, target, quote))
	PLUGIN.RunAtomicQueries = atomic
	assert(owner:GetCharacter():GetMoney() == 100000 and ix.item.instances[item:GetID()] == item)
	assert(record.containers.ammo.tier == 0 and not PLUGIN.personalPurchases[record.id])
	assert(not owner.cotzHideoutOperation and instance.operations == 0)
end)

Test("purchases revalidate after asynchronous inventory loading and block duplicate room work", function()
	local owner, inventory, instance, record, target = personalHome()
	complete(owner, 1)
	local quote = PLUGIN:BuildPersonalOffer(owner, record, "container", "ammo")
	local item = FeatureItem(inventory, {}, quote.item)
	local load, pending = PLUGIN.LoadOwnedInventory
	PLUGIN.LoadOwnedInventory = function(self, ...) pending = select(7, ...) end
	assert(PLUGIN:PurchasePersonalOffer(owner, target, quote))
	assert(not PLUGIN:PurchasePersonalOffer(owner, target, quote))
	assert(not PLUGIN:RequestEntry(owner, record.id))
	target.position = Vector(10000, 0, 0)
	pending(ix.inventory.Create(1, 1, 80))
	PLUGIN.LoadOwnedInventory = load
	assert(owner:GetCharacter():GetMoney() == 100000 and ix.item.instances[item:GetID()] == item)
	assert(not PLUGIN.personalPurchases[record.id] and instance.operations == 0)
end)

Test("personal receipts replay without another payment and legacy storage never shrinks", function()
	local owner, inventory, instance, record, target = personalHome()
	complete(owner, 1)
	complete(owner, 2)
	local quote = PLUGIN:BuildPersonalOffer(owner, record, "container", "ammo")
	FeatureItem(inventory, {}, quote.item)
	assert(PLUGIN:PurchasePersonalOffer(owner, target, quote))
	assert(PLUGIN:PurchasePersonalOffer(owner, target, PLUGIN:BuildPersonalOffer(owner, record, "floor")))
	local balance = owner:GetCharacter():GetMoney()
	record.containers.ammo.tier, record.floorLevel = 0, nil
	PLUGIN:RecoverUpgradeEntitlements(function(ok) assert(ok) end)
	assert(record.containers.ammo.tier == 1 and record.floorLevel == 1)
	assert(owner:GetCharacter():GetMoney() == balance)
	record.personalVersion, record.starterSlot = nil, "general"
	record.containers.general = {recipe = "general", tier = 3, width = 10, height = 8, inventoryID = 888, public = true}
	assert(PLUGIN:PreparePersonalStorage(instance))
	assert(record.containers.general.width == 10 and record.containers.general.height == 8)
	assert(record.containers.general.inventoryID == 888 and record.containers.general.public)
	assert(not PLUGIN:BuildPersonalOffer(owner, record, "container", "general"))
end)

Test("specialized storage rejects other item families and inventory-bearing bags", function()
	local owner, inventory, instance, record = personalHome()
	local item = FeatureItem(inventory)
	assert(not PLUGIN:ContainerAccepts(record, "ammo", item))
	item.isAmmo = true
	assert(PLUGIN:ContainerAccepts(record, "ammo", item))
	assert(not PLUGIN:ContainerAccepts(record, "weapon", item))
	item.isWeapon = true
	assert(PLUGIN:ContainerAccepts(record, "weapon", item))
	assert(not PLUGIN:ContainerAccepts(record, "medical", item))
	item.base = "base_aid"
	assert(PLUGIN:ContainerAccepts(record, "medical", item))
	item.isBag = true
	assert(not PLUGIN:ContainerAccepts(record, "medical", item))
	assert(not PLUGIN:ContainerAccepts(record, "general", item))
end)

Test("floor limit blocks direct transfers to the world and counts guests against the same room", function()
	local owner, inventory, instance, record = personalHome()
	for index = 1, 4 do instance.items[index + 100] = NewEntity(nil, instance.origin) end
	local item = FeatureItem(inventory)
	assert(PLUGIN:CanPlayerDropItem(owner, item:GetID()) == false)
	assert(not item:Transfer(0, nil, nil, owner, false, true))
	assert(item.invID == inventory:GetID())
	local guest = FeatureClient(2)
	guest.position, PLUGIN.members[guest], record.guests["2"] = instance.origin, record.id, true
	assert(PLUGIN:CanPlayerDropItem(guest, item) == false)
	record.floorLevel = 1
	assert(PLUGIN:CanPlayerDropItem(owner, item:GetID()) == nil)
	assert(item:Transfer(0, nil, nil, owner, false, true))
end)

Test("individual invited characters receive container access without furnishing or PET rights", function()
	local owner, inventory, instance, record = personalHome()
	local guest = FeatureClient(2)
	local other = FeatureClient(3)
	record.guests["2"], record.guests["3"] = true, true
	guest.position, PLUGIN.members[guest] = instance.origin, record.id
	assert(PLUGIN:SetContainerGuest(owner, record, "general", 2, true))
	assert(PLUGIN:CanUseContainer(guest, record, "general"))
	assert(not PLUGIN:CanUseContainer(other, record, "general"))
	assert(not PLUGIN:CanUseContainer(guest, record, "ammo"))
	record.furnishingLevel = 1
	assert(not PLUGIN:CanBuildInHideout(guest) and PLUGIN:CharacterHasFlags(guest:GetCharacter(), "pet") == nil)
	assert(not PLUGIN:SetContainerGuest(guest, record, "general", 3, true))
	assert(PLUGIN:SetContainerGuest(owner, record, "general", 2, false))
	assert(not PLUGIN:CanUseContainer(guest, record, "general"))
	assert(PLUGIN:Persist())
	PLUGIN:LoadData()
	assert(not PLUGIN:CanUseContainer(guest, PLUGIN:GetHideout(record.id), "general"))
end)

Test("barter sessions reject stale confirmations, character switches, expiry and remote requests", function()
	local owner, inventory, instance, record, target = personalHome()
	complete(owner, 2)
	PLUGIN:OpenPersonalBarter(owner, target, 1, false, record.id)
	local session = owner.cotzPersonalBarter
	assert(session and #session.offers > 0)
	assert(not PLUGIN:HandlePersonalPurchase(owner, 1, session.revision + 1))
	assert(owner.cotzPersonalBarter == session)
	owner.cotzPersonalBuyAt = 0
	session.expires = -1
	assert(not PLUGIN:HandlePersonalPurchase(owner, 1, session.revision))
	owner.cotzPersonalBuyAt, owner.cotzPersonalOpenAt = 0, 0
	PLUGIN:OpenPersonalBarter(owner, target, 1, false, record.id)
	session = owner.cotzPersonalBarter
	local guest = FeatureClient(2)
	owner.character = guest:GetCharacter()
	assert(not PLUGIN:HandlePersonalPurchase(owner, 1, session.revision))
	assert(record.floorLevel == nil)
end)


Test("scripted overflow keeps original rows, waits for room and restores safely after unloading", function()
	local owner, inventory, instance, record = personalHome()
	local encode, decode = util.TableToJSON, util.JSONToTable
	-- The SQL LIKE query must see the field name even though the engine JSON mock uses opaque tokens.
	util.TableToJSON = function(data) return (data.cotzHideout and "\"cotzHideout\":" or "") .. encode(data) end
	util.JSONToTable = function(value) return decode(value:gsub("^\"cotzHideout\":", "")) end
	for index = 1, 4 do instance.items[index + 100] = NewEntity(nil, instance.origin) end
	local item = FeatureItem(inventory, {quantity = 19, name = "Overflow ammo"})
	local id = item:GetID()
	local update = mysql:Update("ix_items")
	update:Update("inventory_id", 0)
	update:Where("item_id", id)
	update:Execute()
	inventory:Remove(id, false, true)
	item.invID = 0
	ix.item.inventories[0][id] = item
	local entity = NewEntity(item, instance.origin + Vector(30, 0, 10))
	PLUGIN:SaveFloorItem(instance, entity)
	assert(not IsValid(entity) and instance.queuedItems[id])
	assert(not instance.items[id] and instance.operations == 0)
	local row = sql.Query("SELECT * FROM ix_items WHERE item_id = " .. id)[1]
	assert(tonumber(row.inventory_id) == 0 and util.JSONToTable(row.data).quantity == 19)
	assert(util.JSONToTable(row.data).cotzHideout.id == instance.id)
	instance.items[101]:Remove()
	PLUGIN:AuditPersonalFloorItems(instance)
	assert(not instance.queuedItems[id] and IsValid(instance.items[id]))
	assert(item:GetData("quantity") == 19)
	-- Five persisted legacy items restore as four entities plus one waiting original row.
	PLUGIN:DetachFloorItems(instance)
	for index = 1, 4 do
		local other
		ix.item.Instance(0, "water", {cotzHideout = {
			schema = Schema.folder, map = game.GetMap(), id = instance.id, pos = Vector(), angles = Angle(),
		}}, 1, 1, function(created) other = created end)
	end
	instance.state = "loading"
	PLUGIN:RestoreFloorItems(instance, function(ok) assert(ok) end)
	assert(table.Count(instance.items) == 4 and table.Count(instance.queuedItems) == 1)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_items WHERE inventory_id = 0")) == 5)
	util.TableToJSON, util.JSONToTable = encode, decode
end)

Test("each map requires local initial claim access and retains saved improvements", function()
	local owner = personalHome()
	local currentMap = game.GetMap
	for _, map in ipairs({"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation"}) do
		game.GetMap = function() return map end
		local contact = PLUGIN.personalContacts[map]
		owner:GetCharacter().completed = {}
		local originalClaimStep = contact.claimStep
		assert(not PLUGIN:GetPersonalUnlock(owner:GetCharacter(), "claim", 1))
		assert(not PLUGIN:GetPersonalUnlock(owner:GetCharacter(), "ammo", 1))
		local id = "cotz/town/" .. contact.id .. "/v3/hideout/01"
		owner:GetCharacter().completed[id] = true
		assert(PLUGIN:GetPersonalUnlock(owner:GetCharacter(), "ammo", 1))
		assert(not PLUGIN:GetPersonalUnlock(owner:GetCharacter(), "claim", 1))
		owner:GetCharacter().completed["cotz/town/" .. contact.id .. "/v3/hideout/access"] = true
		assert(PLUGIN:GetPersonalUnlock(owner:GetCharacter(), "claim", 1))
		contact.claimStep = 2
		assert(not PLUGIN:GetPersonalUnlock(owner:GetCharacter(), "claim", 1))
		contact.claimStep = originalClaimStep
	end
	game.GetMap = currentMap
end)

Test("town contacts no longer expose hideout purchases", function()
	local previousDialogue = ix.dialogue
	ix.dialogue = {}
	dofile("gamemodes/ix_cotz/plugins/dialogue/libs/sh_townservices.lua")
	for _, id in ipairs({"ballast", "cleaner", "ledger"}) do
		local dialogue = {tree = {GREETING = {options = {}}, BackTopic = {options = {}}}}
		dialogue.addTopic = function(name, topic) dialogue.tree[name] = topic end
		ix.dialogue.ConfigureTownServices(dialogue, {id = id})
		assert(not dialogue.tree.HideoutBarter)
	end
	ix.dialogue = previousDialogue
end)

Test("door offers are limited to its selected room and initial container installations", function()
	local owner, inventory, instance, record, target = personalHome()
	local other = table.Copy(record)
	other.id = "other"
	PLUGIN.state.hideouts.other = other
	PLUGIN:OpenPersonalBarter(owner, target, 1, false, record.id)
	local session = owner.cotzPersonalBarter
	assert(session and #session.offers > 0)
	for _, offer in ipairs(session.offers) do
		assert(offer.record == record.id)
		if offer.feature == "container" then assert(offer.level == 1 and offer.slot ~= "general") end
	end
	local quote = PLUGIN:BuildPersonalOffer(owner, record, "container", "general")
	complete(owner, 2)
	assert(not PLUGIN:PurchasePersonalOffer(owner, target, quote))
end)

Test("failed inventory assignment releases purchase locks without charging or allocating again", function()
	local owner, inventory, instance, record, target = personalHome()
	complete(owner, 1)
	local quote = PLUGIN:BuildPersonalOffer(owner, record, "container", "ammo")
	local input = FeatureItem(inventory, {}, quote.item)
	local persist = PLUGIN.Persist
	PLUGIN.Persist = function() return false end
	assert(PLUGIN:PurchasePersonalOffer(owner, target, quote))
	local id = record.containers.ammo.inventoryID
	assert(id and record.containers.ammo.assignmentPending)
	assert(owner:GetCharacter():GetMoney() == 100000 and ix.item.instances[input:GetID()] == input)
	assert(not PLUGIN.personalPurchases[record.id] and instance.operations == 0)
	PLUGIN.Persist = persist
	assert(PLUGIN:PurchasePersonalOffer(owner, target, quote))
	assert(record.containers.ammo.inventoryID == id and not record.containers.ammo.assignmentPending)
	assert(record.containers.ammo.tier == 1 and not ix.item.instances[input:GetID()])
end)

Test("individual storage permissions and marker layouts retain string keys after cold reload", function()
	local owner, inventory, instance, record = personalHome()
	local guest = FeatureClient(2)
	record.guests["2"] = true
	assert(PLUGIN:SetContainerGuest(owner, record, "general", 2, true))
	assert(PLUGIN:Persist())
	PLUGIN.instances, PLUGIN.members = {}, {}
	PLUGIN:LoadData()
	local restored = PLUGIN:GetHideout(record.id)
	assert(restored.personalLayout.ammo.recipe == "ammo")
	assert(restored.containers.general.guests["2"] and PLUGIN:CanUseContainer(guest, restored, "general"))
end)

Test("unloading a stale overflow reference cannot discard a subsequently owned item", function()
	local owner, inventory, instance = personalHome()
	local item = FeatureItem(inventory)
	instance.queuedItems = {[item:GetID()] = true}
	PLUGIN:DetachFloorItems(instance)
	assert(ix.item.instances[item:GetID()] == item and item.invID == inventory:GetID())
end)

Test("fridge installation filters consumables and preserves its inventory through container upgrades", function()
	local owner, inventory, instance, record, door = personalHome()
	PLUGIN.state.templates.room.containers.fridge = {recipe = "fridge", pos = Vector(0, -64, 0)}
	instance.template = nil
	assert(PLUGIN:PreparePersonalStorage(instance))
	complete(owner, 2)
	local quote = PLUGIN:BuildPersonalOffer(owner, record, "container", "fridge")
	FeatureItem(inventory, {}, quote.item)
	assert(PLUGIN:PurchasePersonalOffer(owner, door, quote))
	local slot = record.containers.fridge
	local storage = ix.inventory.Get(slot.inventoryID)
	local food = FeatureItem(storage)
	food.base = "base_consumables"
	assert(PLUGIN:ContainerAccepts(record, "fridge", food))
	assert(not PLUGIN:ContainerAccepts(record, "fridge", FeatureItem(inventory)))
	food.isBag = true
	assert(not PLUGIN:ContainerAccepts(record, "fridge", food))
	food.isBag = nil
	local entity = instance.containers.fridge
	local inventoryID = slot.inventoryID
	quote = PLUGIN:BuildPersonalOffer(owner, record, "container", "fridge")
	assert(not PLUGIN:PurchasePersonalOffer(owner, door, quote))
	FeatureItem(inventory, {cotzHideoutCrate = {level = quote.level, squad = false, version = 1}}, quote.item)
	assert(PLUGIN:PurchasePersonalOffer(owner, entity, quote))
	assert(slot.tier == 2 and slot.inventoryID == inventoryID and food.invID == inventoryID)
	assert(entity.model == "models/props_c17/FurnitureFridge001a.mdl")
end)

Test("cassette purchases restore one persistent player and replay receipts without charging again", function()
	local owner, inventory, instance, record, door = personalHome()
	complete(owner, 1)
	local quote = PLUGIN:BuildPersonalOffer(owner, record, "cassette")
	local balance = owner:GetCharacter():GetMoney()
	assert(PLUGIN:PurchasePersonalOffer(owner, door, quote))
	local entity = instance.cassette
	assert(IsValid(entity) and record.cassetteLevel == 1)
	assert(owner:GetCharacter():GetMoney() == balance - quote.price)
	assert(not PLUGIN:BuildPersonalOffer(owner, record, "cassette"))
	PLUGIN:RefreshPersonalCassette(record)
	assert(instance.cassette == entity)
	entity:SetPos(instance.origin + Vector(30, 40, 20))
	entity:SetAngles(Angle(0, 90, 0))
	PLUGIN:AuditContainers(instance)
	assert(record.cassetteTransform.pos.x == 30 and record.cassetteTransform.angles.y == 90)
	entity:Remove()
	PLUGIN:RefreshPersonalCassette(record)
	assert(IsValid(instance.cassette) and instance.cassette ~= entity)
	assert(instance.cassette:GetPos().x == instance.origin.x + 30)
	record.cassetteLevel = nil
	PLUGIN:RecoverUpgradeEntitlements(function(ok) assert(ok) end)
	assert(record.cassetteLevel == 1 and owner:GetCharacter():GetMoney() == balance - quote.price)
end)

Test("management purchase submenus bind the selected room and container and reject stale locations", function()
	local owner, inventory, instance, record, door = personalHome()
	complete(owner, 2)
	PLUGIN:ShowManagement(owner, record.id, "entrance")
	PLUGIN:OpenPersonalManagementBarter(owner, record.id, "")
	assert(owner.cotzPersonalBarter.target == door and owner.cotzPersonalBarter.record == record.id)
	owner.cotzPersonalOpenAt = 0
	instance.state = "loading"
	PLUGIN:RestoreStorage(instance, function(ok) assert(ok) end)
	instance.state = "active"
	local entity = instance.containers.general
	PLUGIN:ShowContainerMenu(owner, entity)
	PLUGIN:OpenPersonalManagementBarter(owner, record.id, "")
	local session = owner.cotzPersonalBarter
	assert(session.target == entity and #session.offers == 1)
	assert(session.offers[1].slot == "general" and session.offers[1].level == 2)
	owner.position = Vector(10000, 0, 0)
	assert(not PLUGIN:HandlePersonalPurchase(owner, 1, session.revision))
	assert(record.containers.general.tier == 1)
end)

Test("all twelve levels grow monotonically while general crates remain far smaller", function()
	for name, recipe in pairs(PLUGIN.personalContainerRecipes) do
		assert(#recipe.tiers == 12)
		for level, tier in ipairs(recipe.tiers) do
			local previous = recipe.tiers[level - 1]
			if previous then
				assert(tier.width >= previous.width and tier.height >= previous.height)
				assert(tier.width * tier.height > previous.width * previous.height)
				assert(tier.price == 0 and previous.price == 0)
			end
			local general = PLUGIN.personalContainerRecipes.general.tiers[level]
			if name == "gear" or name == "weapon" or name == "fridge" then
				assert(tier.width * tier.height >= 2.5 * general.width * general.height, name .. " level " .. level)
			end
		end
	end
end)
