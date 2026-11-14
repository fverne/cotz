local originalNew = ix.item.New
ix.item.New = function(uniqueID, id)
	local item = originalNew(uniqueID, id)
	if uniqueID:match("^hideout_crate_") then
		AttachCore(item)
		item.width, item.height = 2, 2
		item.GetData, item.SetData = ix.meta.item.GetData, ix.meta.item.SetData
	end

	return item
end

local function craftingHome(squad, balance)
	FeatureReset()
	PLUGIN.personalContacts.testmap = PLUGIN.personalContacts.rp_marsh_cs
	ix.progression = {
		definitions = {},
		IsCompleted = function(character, id) return (character.completed or {})[id] == true end,
		CanUseNPC = function() return true end,
		SetCompleted = function(character, id) character.completed[id] = true end,
	}
	for level = 1, 12 do
		ix.progression.definitions["cotz/town/ballast/v3/hideout/" .. string.format("%02d", level)] = {}
	end
	local owner, inventory = FeatureClient(1, balance or 10000)
	owner:GetCharacter().completed = {["cotz/town/ballast/v3/hideout/access"] = true}
	local instance, record = FeatureHome(owner, squad)
	local vendor = NewEntity(nil, owner:GetPos())
	vendor.GetClass = function() return "ix_vendor_adv" end
	vendor.GetDisplayName = function() return "'Ballast'" end
	vendor.CanAccess = function() return true end

	return owner, inventory, record, vendor, instance
end

local function material(inventory, id, quantity)
	ix.item.list[id] = {name = id, width = 1, height = 1}

	return FeatureItem(inventory, {quantity = quantity}, id)
end

local function quote(owner, vendor, squad)
	local result
	PLUGIN:QuoteCrate(owner, vendor, "general", 1, squad, function(value, reason)
		assert(value, reason)
		result = value
	end)

	return assert(result)
end

local function craft(owner, vendor, current)
	local result, reason
	PLUGIN:CraftCrate(owner, vendor, current.token, function(ok, text) result, reason = ok, text end)

	return result, reason
end

local function treasury(record, amount)
	PLUGIN:GetTreasury(record, function(balance) assert(balance ~= nil) end)
	local query = mysql:Update("ix_hideout_treasuries")
	query:Update("balance", amount)
	query:Where("scope", Schema.folder)
	query:Where("squad", record.squadID)
	query:Execute()
end

local function balance(record)
	local result
	PLUGIN:GetTreasury(record, function(value) result = value end)

	return result
end

Test("all crate recipes grow, use exact triple squad costs and expose twelve larger squad capacities", function()
	for family in pairs(PLUGIN.crateMaterials) do
		local previousPrice, previousUnits = 0, 0
		for level = 1, 12 do
			local personal = PLUGIN:GetCrateRecipe(family, level, false)
			local squad = PLUGIN:GetCrateRecipe(family, level, true)
			assert(personal.price > previousPrice and squad.price == 3 * personal.price)
			local units = 0
			for index, group in ipairs(personal.groups) do
				assert(squad.groups[index].quantity == group.quantity * 3)
				units = units + group.quantity
			end
			assert(units > previousUnits)
			local personalSize = PLUGIN.personalContainerRecipes[family].tiers[level]
			local squadSize = PLUGIN.containerRecipes[family].tiers[level]
			assert(squadSize.width == personalSize.width + 2 and squadSize.height == personalSize.height + 1)
			previousPrice, previousUnits = personal.price, units
		end
	end
	assert(not PLUGIN:GetCrateRecipe("general", 0, false))
	assert(not PLUGIN:GetCrateRecipe("general", 13, false))
end)

Test("mixed fasteners and split stacks consume whole batches and preserve raw surplus", function()
	local owner, inventory, record, vendor = craftingHome(false)
	local first = material(inventory, "value_nuts", 2)
	local second = material(inventory, "value_nuts", 2)
	local bolts = material(inventory, "value_bolts", 5)
	material(inventory, "value_tape_duct", 1)
	local current = quote(owner, vendor, false)
	local ok, reason = craft(owner, vendor, current)
	assert(ok, reason)
	assert(not ix.item.instances[first:GetID()] and second:GetData("quantity") == 1)
	assert(bolts:GetData("quantity") == 1 and owner:GetCharacter():GetMoney() == 9400)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_items WHERE unique_id = 'hideout_crate_general'")) == 1)
	local crate = PLUGIN:FindUpgradeCrate(owner, "general", 1, false)
	assert(crate and crate:GetData("cotzHideoutCrate").level == 1)
	assert(not PLUGIN:FindUpgradeCrate(owner, "general", 2, false))
	assert(not PLUGIN:FindUpgradeCrate(owner, "general", 1, true))
	assert(craft(owner, vendor, current) == false)
end)

Test("squad crafting takes treasury first and only the remainder from the officer", function()
	for _, funds in ipairs({0, 1000, 1800, 2500}) do
		local owner, inventory, record, vendor = craftingHome(true)
		record.fundUpgrades = true
		treasury(record, funds)
		material(inventory, "value_screws", 6)
		material(inventory, "value_rope", 3)
		local current = quote(owner, vendor, true)
		local paid = math.min(1800, funds)
		assert(current.funding.treasury == paid and current.funding.player == 1800 - paid)
		local ok, reason = craft(owner, vendor, current)
		assert(ok, reason)
		assert(balance(record) == funds - paid and owner:GetCharacter():GetMoney() == 10000 - (1800 - paid))
		assert(PLUGIN:FindUpgradeCrate(owner, "general", 1, true))
	end
end)

Test("disabled squad funding leaves vendor funds intact and personal crates always use player cash", function()
	for _, squad in ipairs({false, true}) do
		local owner, inventory, record, vendor = craftingHome(true)
		record.fundUpgrades = not squad
		treasury(record, 10000)
		material(inventory, "value_screws", squad and 6 or 2)
		material(inventory, "value_rope", squad and 3 or 1)
		local current = quote(owner, vendor, squad)
		assert(current.funding.treasury == 0)
		local ok, reason = craft(owner, vendor, current)
		assert(ok, reason)
		assert(balance(record) == 10000 and owner:GetCharacter():GetMoney() == 10000 - (squad and 1800 or 600))
	end
end)

Test("insufficient combined funds and failed commits preserve all materials and both balances", function()
	for _, rollback in ipairs({false, true}) do
		local owner, inventory, record, vendor = craftingHome(true, rollback and 10000 or 100)
		record.fundUpgrades = true
		treasury(record, 1000)
		local screws = material(inventory, "value_screws", 6)
		local rope = material(inventory, "value_rope", 3)
		local current = quote(owner, vendor, true)
		local atomic = PLUGIN.RunAtomicQueries
		if rollback then PLUGIN.RunAtomicQueries = function(_, _, callback) callback(false, "rollback") end end
		assert(craft(owner, vendor, current) == false)
		PLUGIN.RunAtomicQueries = atomic
		assert(balance(record) == 1000 and owner:GetCharacter():GetMoney() == (rollback and 10000 or 100))
		assert(screws:GetData("quantity") == 6 and rope:GetData("quantity") == 3)
		assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_hideout_operations")) == 0)
	end
end)

Test("funding changes, changed treasury balances and full destinations invalidate quotes without consuming inputs", function()
	for _, failure in ipairs({"setting", "balance", "space", "rank", "expired", "remote", "token"}) do
		local owner, inventory, record, vendor = craftingHome(true)
		record.fundUpgrades = true
		treasury(record, 1000)
		local screws = material(inventory, "value_screws", 6)
		material(inventory, "value_rope", 3)
		local current = quote(owner, vendor, true)
		if failure == "setting" then record.fundUpgrades = false end
		if failure == "balance" then treasury(record, 900) end
		if failure == "space" then
			for x = 1, inventory.w do
				inventory.slots[x] = {}
				for y = 1, inventory.h do inventory.slots[x][y] = true end
			end
		end
		if failure == "rank" then ix.squad.list.squad1.members[1] = nil end
		if failure == "expired" then current.expires = -1 end
		if failure == "remote" then owner.position = Vector(50000, 0, 0) end
		if failure == "token" then current.token = "different" end
		local token = failure == "token" and "original" or current.token
		local ok
		PLUGIN:CraftCrate(owner, vendor, token, function(success) ok = success end)
		assert(ok == false, failure)
		assert(owner:GetCharacter():GetMoney() == 10000 and screws:GetData("quantity") == 6, failure)
		assert(balance(record) == (failure == "balance" and 900 or 1000), failure)
	end
end)

Test("an unacknowledged successful commit is verified without issuing a second crate", function()
	local owner, inventory, record, vendor = craftingHome(false)
	material(inventory, "value_screws", 2)
	material(inventory, "value_rope", 1)
	local current = quote(owner, vendor, false)
	local atomic = PLUGIN.RunAtomicQueries
	PLUGIN.RunAtomicQueries = function(self, queries, callback)
		atomic(self, queries, function(ok, result) assert(ok) callback(nil, "lost acknowledgement") end)
	end
	local ok, reason = craft(owner, vendor, current)
	PLUGIN.RunAtomicQueries = atomic
	assert(ok, reason)
	assert(owner:GetCharacter():GetMoney() == 9400)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_items WHERE unique_id = 'hideout_crate_general'")) == 1)
end)

Test("only a leader can persist the treasury funding setting through hideout management", function()
	local owner, inventory, record, vendor, instance = craftingHome(true)
	owner.cotzHideoutMenu = {character = owner:GetCharacter(), scope = "squad", ids = {[record.id] = true}}
	assert(PLUGIN:SetUpgradeFunding(owner, record, true))
	assert(record.fundUpgrades == true)
	local restored = PLUGIN:GetData(nil, false, false, true)
	assert(restored.hideouts[tonumber(record.id) or record.id].fundUpgrades == true)
	ix.squad.list.squad1.members[1] = 1
	assert(not PLUGIN:SetUpgradeFunding(owner, record, false))
	assert(record.fundUpgrades == true)
end)

Test("starter ownership and installed levels reconcile only the owner's local personal milestones", function()
	local owner, inventory, record = craftingHome(false)
	PLUGIN:ReconcileInstalledLevels(owner:GetCharacter())
	assert(owner:GetCharacter().completed["cotz/town/ballast/v3/hideout/01"])
	assert(PLUGIN:GetCrateUnlock(owner:GetCharacter(), 2))
	assert(not PLUGIN:GetCrateUnlock(owner:GetCharacter(), 3))
	record.personalVersion = 1
	record.containers.general = {tier = 4}
	PLUGIN:ReconcileInstalledLevels(owner:GetCharacter())
	assert(owner:GetCharacter().completed["cotz/town/ballast/v3/hideout/04"])
	assert(not owner:GetCharacter().completed["cotz/town/cleaner/v3/hideout/04"])
	record.ownerType = "squad"
	record.containers.general.tier = 12
	PLUGIN:ReconcileInstalledLevels(owner:GetCharacter())
	assert(not owner:GetCharacter().completed["cotz/town/ballast/v3/hideout/12"])
end)

Test("a real output insertion failure rolls back earlier material and treasury statements", function()
	local owner, inventory, record, vendor = craftingHome(true)
	record.fundUpgrades = true
	treasury(record, 1000)
	local screws = material(inventory, "value_screws", 7)
	material(inventory, "value_rope", 3)
	local current = quote(owner, vendor, true)
	local atomic = PLUGIN.RunAtomicQueries
	PLUGIN.RunAtomicQueries = function(self, queries, callback)
		for _, query in ipairs(queries) do
			if query.tableName == "ix_items" and query.insertSource then query.tableName = "missing_output" end
		end
		atomic(self, queries, callback)
	end
	local ok = craft(owner, vendor, current)
	PLUGIN.RunAtomicQueries = atomic
	assert(ok == false and owner:GetCharacter():GetMoney() == 10000 and balance(record) == 1000)
	local row = sql.Query("SELECT data FROM ix_items WHERE item_id = " .. screws:GetID())[1]
	assert(util.JSONToTable(row.data).quantity == 7 and screws:GetData("quantity") == 7)
end)

Test("a post-commit character switch retains the crate row for a fresh inventory restore", function()
	local owner, inventory, record, vendor = craftingHome(false)
	material(inventory, "value_screws", 2)
	material(inventory, "value_rope", 1)
	local character = owner:GetCharacter()
	local replacement = FeatureClient(2)
	local current = quote(owner, vendor, false)
	local atomic = PLUGIN.RunAtomicQueries
	PLUGIN.RunAtomicQueries = function(self, queries, callback)
		atomic(self, queries, function(ok, result)
			owner.character = replacement:GetCharacter()
			callback(ok, result)
		end)
	end
	local ok, reason = craft(owner, vendor, current)
	PLUGIN.RunAtomicQueries = atomic
	assert(ok, reason)
	assert(character.cotzHideoutStale and ix.item.inventories[inventory:GetID()] == nil)
	assert(tonumber(sql.QueryValue("SELECT money FROM ix_characters WHERE id = 1")) == 9400)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_items WHERE unique_id = 'hideout_crate_general'")) == 1)
end)

Test("prop upgrades use the confirmed treasury contribution and leave ordinary members' exit menus available", function()
	local owner, inventory, record, vendor, instance = craftingHome(true)
	record.fundUpgrades = true
	treasury(record, 3000)
	PLUGIN:ShowManagement(owner, record.id, "squad")
	assert(owner.cotzHideoutMenu.funding[record.id].player == 2000)
	assert(PLUGIN:UpgradePropCapacity(owner, record, 1))
	assert(record.propTier == 2 and owner:GetCharacter():GetMoney() == 8000 and balance(record) == 0)
	local member = FeatureClient(2)
	ix.squad.list.squad1.members[2] = 0
	member.position, PLUGIN.members[member] = instance.origin, record.id
	instance.exit = NewEntity(nil, instance.origin)
	PLUGIN:ShowManagement(member, record.id, "exit")
	assert(member.cotzHideoutMenu.scope == "exit" and PLUGIN:CanUseManagementMenu(member, record.id))
end)

Test("legacy squad dimensions migrate once without changing inventory, contents or access", function()
	local owner, inventory, record = craftingHome(true)
	PLUGIN.state.templates.room.containers = {general = {recipe = "general", pos = Vector()}}
	record.containers.general = {recipe = "general", tier = 3, width = 10, height = 8,
		inventoryID = 800, minimumRank = 2}
	local slot = record.containers.general
	PLUGIN:MigrateSquadContainers(record)
	assert(slot.tier == 12 and slot.width == 10 and slot.height == 8)
	assert(slot.inventoryID == 800 and slot.minimumRank == 2)
	PLUGIN:MigrateSquadContainers(record)
	assert(slot.tier == 12 and slot.crateVersion == PLUGIN.crateVersion)
end)

Test("carrying checks account for consumed salvage and the remaining stack weight before payment", function()
	local owner, inventory, record, vendor = craftingHome(false)
	local screws = material(inventory, "value_screws", 3)
	material(inventory, "value_rope", 1)
	local originalWeight = ix.weight
	local originalGetWeight = ix.item.list.hideout_crate_general.GetWeight
	ix.item.list.hideout_crate_general.GetWeight = function() return 1 end
	for _, item in pairs(inventory:GetItems()) do
		item.GetWeight = function(self) return self:GetData("quantity", 1) * 0.2 end
	end
	local capacity = 99
	ix.weight = {
		CalculateWeight = function() return 100 end,
		CanCarry = function(weight, carry) return carry + weight <= capacity end,
	}
	local current = quote(owner, vendor, false)
	assert(craft(owner, vendor, current) == false)
	assert(owner:GetCharacter():GetMoney() == 10000 and screws:GetData("quantity") == 3)
	capacity = 101
	current = quote(owner, vendor, false)
	local ok, reason = craft(owner, vendor, current)
	ix.weight = originalWeight
	ix.item.list.hideout_crate_general.GetWeight = originalGetWeight
	assert(ok, reason)
	assert(screws:GetData("quantity") == 1)
end)

Test("ordinary squad members craft against their own milestones but cannot install squad storage", function()
	local owner, inventory, record, vendor = craftingHome(true)
	ix.squad.list.squad1.members[1] = 0
	record.fundUpgrades = true
	treasury(record, 1000)
	material(inventory, "value_screws", 6)
	material(inventory, "value_rope", 3)
	local current = quote(owner, vendor, true)
	local ok, reason = craft(owner, vendor, current)
	assert(ok, reason)
	assert(balance(record) == 0 and owner:GetCharacter():GetMoney() == 9200)
	assert(not PLUGIN:CanManageHideout(owner, record))
	local locked
	PLUGIN:QuoteCrate(owner, vendor, "general", 3, true, function(value) locked = value == nil end)
	assert(locked)
end)

ix.item.New = originalNew
