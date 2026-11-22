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

local function upgradeHome(squad, balance)
	FeatureReset()
	PLUGIN.personalPurchases = {}
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
	PLUGIN.state.templates.room.containers = {
		general = {recipe = "general", pos = Vector()}, ammo = {recipe = "ammo", pos = Vector(40, 0, 0)},
	}
	if not squad then assert(PLUGIN:PreparePersonalStorage(instance)) end
	local vendor = FeatureContact(owner)

	return owner, inventory, record, vendor, instance
end

local function material(inventory, id, quantity)
	ix.item.list[id] = ix.item.list[id] or {name = id, width = 1, height = 1}

	return FeatureItem(inventory, {quantity = quantity}, id)
end

local function unlock(owner, step)
	for index = 1, step do
		owner:GetCharacter().completed["cotz/town/ballast/v3/hideout/" .. string.format("%02d", index)] = true
	end
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

Test("all upgrade recipes grow, use exact triple squad costs and expose twelve larger squad capacities", function()
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

Test("the contact installs personal storage directly from mixed fasteners and preserves raw surplus", function()
	local owner, inventory, record, vendor, instance = upgradeHome(false)
	unlock(owner, 1)
	local first = material(inventory, "value_nuts", 2)
	local second = material(inventory, "value_nuts", 2)
	local bolts = material(inventory, "value_bolts", 5)
	material(inventory, "value_paracord", 1)
	local ok, reason, offer = FeatureUpgrade(owner, record, "container", "ammo")
	assert(ok, reason)
	assert(offer.price == 900 and owner:GetCharacter():GetMoney() == 9100)
	assert(not ix.item.instances[first:GetID()] and second:GetData("quantity") == 1 and bolts:GetData("quantity") == 1)
	assert(record.containers.ammo.tier == 1 and record.containers.ammo.width == 2)
	assert(IsValid(instance.containers.ammo) and record.containers.ammo.inventoryID)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_items WHERE unique_id LIKE 'hideout_crate_%'")) == 0)
	assert(owner:GetCharacter().completed["cotz/town/ballast/v3/hideout/01"])
	assert(not PLUGIN:ExecuteUpgrade(owner, vendor, {revision = owner.cotzUpgradeRevision - 1, index = 1}))
end)

Test("offers list every personal improvement with costs, materials and locked reasons", function()
	local owner, inventory, record, vendor = upgradeHome(false)
	PLUGIN:SendUpgradeOffers(owner, vendor, record.id, true)
	local features = {}
	for _, offer in ipairs(owner.cotzHideoutUpgrades.offers) do
		features[offer.feature .. (offer.slot and ":" .. offer.slot or "")] = offer
		assert(offer.description:find("Cost:", 1, true) and offer.summary ~= "")
	end
	assert(features["container:ammo"] and features["container:general"] and features.floor)
	assert(features.furnishing and features.cassette and features.props)
	local ammo, furnishing = features["container:ammo"], features.furnishing
	assert(ammo.allowed and not ammo.payable and ammo.description:find("Not enough materials", 1, true))
	assert(ammo.description:find("batches:", 1, true) and features["container:general"].level == 2)
	assert(not furnishing.allowed and not furnishing.payable and furnishing.description:find("Requires", 1, true))
	assert(features.props.payable and features.props.price == 5000)
end)

Test("tooltip materials list only unlocked next-level upgrades with their hideout names", function()
	local owner, _, record = upgradeHome(false)
	local name = PLUGIN:GetHideoutName(record):sub(1, 128)
	-- Installing the starter storage completes step 01; clear it so general level 2 is locked.
	owner:GetCharacter().completed["cotz/town/ballast/v3/hideout/01"] = nil
	local items = PLUGIN:CollectUpgradeItems(owner)
	assert(items.value_nuts[name] and items.value_gunoil[name] and items.value_paracord[name])
	assert(not items.value_tape_duct, "Locked general level 2 materials stay hidden")
	unlock(owner, 1)
	items = PLUGIN:CollectUpgradeItems(owner)
	assert(items.value_tape_duct[name] and items.value_rope[name])
	assert(next(PLUGIN:CollectUpgradeItems(FeatureClient(2, 0))) == nil, "Other characters' rooms are excluded")
end)

Test("squad upgrades take treasury first and only the remainder from the officer", function()
	for _, funds in ipairs({0, 1000, 2700, 4000}) do
		local owner, inventory, record = upgradeHome(true)
		unlock(owner, 1)
		record.fundUpgrades = true
		treasury(record, funds)
		material(inventory, "value_screws", 6)
		material(inventory, "value_paracord", 3)
		local paid = math.min(2700, funds)
		local ok, reason, offer = FeatureUpgrade(owner, record, "container", "ammo")
		assert(ok, reason)
		assert(offer.funding.treasury == paid and offer.funding.player == 2700 - paid)
		assert(balance(record) == funds - paid and owner:GetCharacter():GetMoney() == 10000 - (2700 - paid))
		assert(record.containers.ammo.tier == 1 and record.containers.ammo.width == 4)
	end
end)

Test("disabled squad funding leaves vendor funds intact and personal upgrades always use player cash", function()
	for _, squad in ipairs({false, true}) do
		local owner, inventory, record = upgradeHome(squad)
		unlock(owner, 1)
		if squad then
			record.fundUpgrades = false
			treasury(record, 10000)
		end
		material(inventory, "value_screws", squad and 6 or 2)
		material(inventory, "value_paracord", squad and 3 or 1)
		local ok, reason, offer = FeatureUpgrade(owner, record, "container", "ammo")
		assert(ok, reason)
		assert(offer.funding.treasury == 0)
		assert(owner:GetCharacter():GetMoney() == 10000 - (squad and 2700 or 900))
		if squad then assert(balance(record) == 10000) end
	end
end)

Test("personal upgrades cannot use squad-backed payment when the wallet is short", function()
	local owner, inventory, record = upgradeHome(false, 100)
	unlock(owner, 1)
	local screws = material(inventory, "value_screws", 2)
	local rope = material(inventory, "value_paracord", 1)
	local ok = FeatureUpgrade(owner, record, "container", "ammo")
	assert(not ok and owner:GetCharacter():GetMoney() == 100)
	ok = FeatureUpgrade(owner, record, "container", "ammo", {prepare = function(_, offer)
		offer.funding = {player = 0, treasury = 900, balance = 10000, enabled = true, rank = 0}
	end})
	assert(not ok and owner:GetCharacter():GetMoney() == 100)
	assert(screws:GetData("quantity") == 2 and rope:GetData("quantity") == 1 and record.containers.ammo.tier == 0)
end)

Test("insufficient combined funds and failed commits preserve all materials and both balances", function()
	for _, rollback in ipairs({false, true}) do
		local owner, inventory, record = upgradeHome(true, rollback and 10000 or 100)
		unlock(owner, 1)
		record.fundUpgrades = true
		treasury(record, 1000)
		local screws = material(inventory, "value_screws", 6)
		local rope = material(inventory, "value_paracord", 3)
		local atomic = PLUGIN.RunAtomicQueries
		if rollback then PLUGIN.RunAtomicQueries = function(_, _, callback) callback(false, "rollback") end end
		FeatureUpgrade(owner, record, "container", "ammo")
		PLUGIN.RunAtomicQueries = atomic
		assert(balance(record) == 1000 and owner:GetCharacter():GetMoney() == (rollback and 10000 or 100))
		assert(screws:GetData("quantity") == 6 and rope:GetData("quantity") == 3)
		assert(record.containers.ammo.tier == 0 and not PLUGIN.personalPurchases[record.id])
		assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_hideout_operations")) == 0)
	end
end)

Test("funding changes, treasury balances, rank, expiry, distance and revisions invalidate reviewed offers", function()
	for _, failure in ipairs({"setting", "balance", "rank", "expired", "remote", "revision", "changed"}) do
		local owner, inventory, record, vendor = upgradeHome(true)
		unlock(owner, 1)
		record.fundUpgrades = true
		treasury(record, 1000)
		local screws = material(inventory, "value_screws", 6)
		material(inventory, "value_paracord", 3)
		local offer, index, session = FeatureUpgradeOffer(owner, record, "container", "ammo", vendor)
		local revision = session.revision
		if failure == "setting" then record.fundUpgrades = false end
		if failure == "balance" then treasury(record, 900) end
		if failure == "rank" then ix.squad.list.squad1.members[1] = 0 end
		if failure == "expired" then session.expires = -1 end
		if failure == "remote" then owner.position = Vector(50000, 0, 0) end
		if failure == "revision" then revision = revision + 1 end
		if failure == "changed" then record.containers.ammo.tier = 1 end
		PLUGIN:ExecuteUpgrade(owner, vendor, {revision = revision, index = index})
		assert(owner:GetCharacter():GetMoney() == 10000 and screws:GetData("quantity") == 6, failure)
		assert(balance(record) == (failure == "balance" and 900 or 1000), failure)
		assert(record.containers.ammo.tier == (failure == "changed" and 1 or 0), failure)
	end
end)

Test("an unacknowledged successful commit is verified and applied once", function()
	local owner, inventory, record = upgradeHome(false)
	unlock(owner, 1)
	material(inventory, "value_screws", 2)
	material(inventory, "value_paracord", 1)
	local atomic = PLUGIN.RunAtomicQueries
	PLUGIN.RunAtomicQueries = function(self, queries, callback)
		atomic(self, queries, function(ok) assert(ok) callback(nil, "lost acknowledgement") end)
	end
	local ok, reason = FeatureUpgrade(owner, record, "container", "ammo")
	PLUGIN.RunAtomicQueries = atomic
	assert(ok, reason)
	assert(owner:GetCharacter():GetMoney() == 9100 and record.containers.ammo.tier == 1)
	assert(tonumber(sql.QueryValue("SELECT COUNT(*) FROM ix_hideout_operations")) == 1)
end)

Test("carried legacy crates install the matching level without cash or materials", function()
	local owner, inventory, record = upgradeHome(false)
	unlock(owner, 1)
	local wrong = FeatureItem(inventory, {cotzHideoutCrate = {level = 2, squad = false, version = 1}},
		"hideout_crate_ammo")
	local offer = FeatureUpgradeOffer(owner, record, "container", "ammo")
	assert(not offer.redeemable and not offer.payable)
	local crate = FeatureItem(inventory, {cotzHideoutCrate = {level = 1, squad = false, version = 1}},
		"hideout_crate_ammo")
	local ok, reason
	ok, reason, offer = FeatureUpgrade(owner, record, "container", "ammo", {crate = true})
	assert(ok, reason)
	assert(offer.redeemable and not ix.item.instances[crate:GetID()] and ix.item.instances[wrong:GetID()])
	assert(owner:GetCharacter():GetMoney() == 10000 and record.containers.ammo.tier == 1)
	unlock(owner, 2)
	assert(FeatureUpgradeOffer(owner, record, "container", "ammo").redeemable)
	FeatureItem(inventory, {cotzHideoutCrate = {level = 2, squad = true, version = 1}}, "hideout_crate_general")
	assert(not FeatureUpgradeOffer(owner, record, "container", "general").redeemable)
end)

Test("squad crates redeem on rank alone, while the leader-only restriction still applies", function()
	local owner, inventory, record = upgradeHome(true)
	record.containers.ammo = {recipe = "ammo", tier = 0, minimumRank = 2}
	ix.squad.list.squad1.members[1] = 1
	local crate = FeatureItem(inventory, {cotzHideoutCrate = {level = 1, squad = true, version = 1}},
		"hideout_crate_ammo")
	local offer = FeatureUpgradeOffer(owner, record, "container", "ammo")
	assert(not offer.allowed and not offer.redeemable and offer.reason:find("leader", 1, true))
	ix.squad.list.squad1.members[1] = 2
	local ok, reason = FeatureUpgrade(owner, record, "container", "ammo", {crate = true})
	assert(ok, reason)
	assert(not ix.item.instances[crate:GetID()] and record.containers.ammo.tier == 1)
	local receipt = sql.Query("SELECT kind, payload FROM ix_hideout_operations")[1]
	assert(receipt.kind == "upgrade" and util.JSONToTable(receipt.payload).crateVersion == PLUGIN.crateVersion)
end)

Test("ordinary squad members are offered no squad hideout upgrades", function()
	local owner, inventory, record, vendor = upgradeHome(true)
	ix.squad.list.squad1.members[1] = 0
	assert(not PLUGIN:IsUpgradeHideout(owner, record))
	owner.cotzHideoutUpgrades = nil
	PLUGIN:SendUpgradeOffers(owner, vendor, record.id, true)
	assert(owner.cotzHideoutUpgrades == nil)
end)

Test("prop capacity upgrades at the contact use the treasury contribution", function()
	local owner, inventory, record = upgradeHome(true)
	record.fundUpgrades = true
	treasury(record, 3000)
	local ok, reason, offer = FeatureUpgrade(owner, record, "props")
	assert(ok, reason)
	assert(offer.funding.player == 2000 and offer.funding.treasury == 3000)
	assert(record.propTier == 2 and owner:GetCharacter():GetMoney() == 8000 and balance(record) == 0)
	record.propTier = 1
	PLUGIN:RecoverUpgradeEntitlements(function(recovered) assert(recovered) end)
	assert(record.propTier == 2)
end)

Test("a pending purchase blocks a second upgrade to the same hideout", function()
	local owner, inventory, record, vendor = upgradeHome(false)
	unlock(owner, 2)
	material(inventory, "value_screws", 2)
	material(inventory, "value_paracord", 1)
	local load, pending = PLUGIN.LoadOwnedInventory
	PLUGIN.LoadOwnedInventory = function(self, ...) pending = select(7, ...) end
	assert(FeatureUpgrade(owner, record, "container", "ammo", {vendor = vendor}))
	PLUGIN.LoadOwnedInventory = load
	local ok, reason = FeatureUpgrade(owner, record, "cassette", nil, {vendor = vendor})
	assert(not ok and reason:find("pending", 1, true))
	assert(not PLUGIN:RequestEntry(owner, record.id))
	owner.position = Vector(50000, 0, 0)
	pending(ix.inventory.Create(1, 1, 80))
	assert(owner:GetCharacter():GetMoney() == 10000 and record.containers.ammo.tier == 0)
	assert(not PLUGIN.personalPurchases[record.id])
end)

Test("only a leader can persist the treasury funding setting through hideout management", function()
	local owner, inventory, record = upgradeHome(true)
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
	local owner, inventory, record = upgradeHome(false)
	PLUGIN:ReconcileInstalledLevels(owner:GetCharacter())
	assert(owner:GetCharacter().completed["cotz/town/ballast/v3/hideout/01"])
	assert(PLUGIN:GetCrateUnlock(owner:GetCharacter(), 2))
	assert(not PLUGIN:GetCrateUnlock(owner:GetCharacter(), 3))
	record.containers.general.tier = 4
	PLUGIN:ReconcileInstalledLevels(owner:GetCharacter())
	assert(owner:GetCharacter().completed["cotz/town/ballast/v3/hideout/04"])
	assert(not owner:GetCharacter().completed["cotz/town/cleaner/v3/hideout/04"])
	record.ownerType = "squad"
	record.containers.general.tier = 12
	PLUGIN:ReconcileInstalledLevels(owner:GetCharacter())
	assert(not owner:GetCharacter().completed["cotz/town/ballast/v3/hideout/12"])
end)

Test("a post-commit character switch keeps the committed upgrade without a stale character save", function()
	local owner, inventory, record = upgradeHome(false)
	unlock(owner, 1)
	local character = owner:GetCharacter()
	local replacement = FeatureClient(2)
	local atomic = PLUGIN.RunAtomicQueries
	PLUGIN.RunAtomicQueries = function(self, queries, callback)
		atomic(self, queries, function(ok, result)
			owner.character = replacement:GetCharacter()
			callback(ok, result)
		end)
	end
	local ok, reason = FeatureUpgrade(owner, record, "cassette")
	PLUGIN.RunAtomicQueries = atomic
	assert(ok, reason)
	assert(character.cotzHideoutStale and record.cassetteLevel == 1)
	assert(tonumber(sql.QueryValue("SELECT money FROM ix_characters WHERE id = 1")) == 8500)
end)

Test("legacy squad dimensions migrate once without changing inventory, contents or access", function()
	local owner, inventory, record = upgradeHome(true)
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

ix.item.New = originalNew
