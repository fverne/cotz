local PLUGIN = PLUGIN
local SESSION_LIFETIME = 120
local CONTACT_DISTANCE_SQUARED = 192 * 192
local MAX_LISTED_HIDEOUTS = 32
local MAX_UPGRADE_OFFERS = 63
local REQUEST_INTERVAL = 0.3
local ITEMS_REQUEST_INTERVAL = 1
local MAX_UPGRADE_ITEMS = 255
util.AddNetworkString("cotz/hideouts/upgrade-hideouts")
util.AddNetworkString("cotz/hideouts/upgrade-offers")
util.AddNetworkString("cotz/hideouts/upgrade-items")

function PLUGIN:CanUseUpgradeContact(client, target)
	local contact = self.personalContacts[game.GetMap()]
	local character = IsValid(client) and client:GetCharacter()

	return self.ready and self.operationsReady and character and contact and IsValid(target)
		and target:GetClass() == "ix_vendor_adv" and target:GetDisplayName() == contact.name
		and target:CanAccess(client) and client:GetPos():DistToSqr(target:GetPos()) <= CONTACT_DISTANCE_SQUARED
		and ix.progression.CanUseNPC(character, contact.name)
end

function PLUGIN:IsUpgradeHideout(client, record)
	local character = client:GetCharacter()
	if not character or not record or record.deleting or record.frozen then return false end
	if record.ownerType == "squad" then return self:CanManageHideout(client, record) end

	return record.owner == character:GetID()
end

function PLUGIN:BuildSquadContainerOffer(client, record, slotID)
	local character = client:GetCharacter()
	local rank = self:GetSquadRank(client, record)
	if not character or rank == nil or rank < 1 then return end
	local slot, definition = self:GetContainer(record, slotID)
	local recipe = slot and self.containerRecipes[definition.recipe]
	if not recipe then return end
	local level = (slot.tier or 0) + 1
	local tier = recipe.tiers[level]
	local materials = self:GetCrateRecipe(definition.recipe, level, true)
	if not tier or not materials or tier.width < (slot.width or 1) or tier.height < (slot.height or 1) then return end
	local offer = {
		record = record.id, feature = "container", slot = slotID, level = level, recipe = definition.recipe,
		width = tier.width, height = tier.height, model = tier.model, price = materials.price,
		materials = materials, item = materials.item, squad = true, rank = math.max(1, slot.minimumRank or 0),
		label = slotID .. ": " .. recipe.name .. " level " .. level,
		detail = string.format("%d × %d slots; %s items", tier.width, tier.height, recipe.filter),
	}
	offer.rankAllowed = rank >= offer.rank
	offer.allowed, offer.reason = self:GetCrateUnlock(character, level)
	if not offer.rankAllowed then
		offer.allowed, offer.reason = false, "Only the squad leader can upgrade this container."
	end

	return offer
end

function PLUGIN:BuildPropOffer(client, record)
	if not self:CanManageHideout(client, record) then return end
	local current = self.propCapacityTiers[self:GetHideoutPropTier(record)]
	local level = self:GetHideoutPropTier(record) + 1
	local upgrade = self.propCapacityTiers[level]
	if not upgrade then return end

	return {
		record = record.id, feature = "props", level = level, price = upgrade.price,
		squad = record.ownerType == "squad", rank = 1, allowed = true, rankAllowed = true,
		label = "Prop capacity: " .. upgrade.limit,
		detail = "Player-placed furnishings allowed in this hideout; currently " .. current.limit .. ".",
	}
end

function PLUGIN:BuildUpgradeOffer(client, record, feature, slotID)
	if not record or record.deleting or record.frozen or not self:IsUpgradeHideout(client, record) then return end
	local instance = self.instances[record.id]
	if instance and (instance.state ~= "active" or instance.saving) then return end
	if feature == "props" then return self:BuildPropOffer(client, record) end
	if record.ownerType == "squad" then
		return feature == "container" and self:BuildSquadContainerOffer(client, record, slotID) or nil
	end
	local offer = self:BuildPersonalOffer(client, record, feature, slotID)
	if offer then offer.rank, offer.rankAllowed = nil, true end

	return offer
end

function PLUGIN:SameUpgradeOffer(first, second)
	return first.feature == second.feature and first.slot == second.slot and first.level == second.level
		and first.price == second.price and first.width == second.width and first.height == second.height
		and first.model == second.model and first.item == second.item and first.rank == second.rank
end

function PLUGIN:CollectUpgradeOffers(client, record)
	local offers = {}
	local function append(feature, slotID)
		local offer = #offers < MAX_UPGRADE_OFFERS and self:BuildUpgradeOffer(client, record, feature, slotID)
		if offer then offers[#offers + 1] = offer end
	end
	if record.ownerType == "squad" then
		local template = self:GetTemplate(record)
		for slotID in SortedPairs(template and template.containers or {}) do append("container", slotID) end
	else
		for slotID in SortedPairs(record.personalLayout or {}) do append("container", slotID) end
		append("floor")
		append("furnishing")
		append("cassette")
	end
	append("props")

	return offers
end

local function addOfferItems(items, offer, name)
	if offer.allowed ~= true or not offer.materials then return end
	for _, group in ipairs(offer.materials.groups) do
		for _, itemID in ipairs(group.items) do
			items[itemID] = items[itemID] or {}
			items[itemID][name] = true
		end
	end
end

-- Materials accepted by the next unlocked upgrade of each hideout the character can improve, keyed by item
-- ID with the hideout names that need them. Inventory tooltips show these beside task and progression needs.
function PLUGIN:CollectUpgradeItems(client)
	local items = {}
	if not self.ready or not IsValid(client) or not client:GetCharacter() then return items end
	for _, record in SortedPairs(self.state.hideouts or {}) do
		if self:IsUpgradeHideout(client, record) then
			local name = self:GetHideoutName(record):sub(1, 128)
			for _, offer in ipairs(self:CollectUpgradeOffers(client, record)) do addOfferItems(items, offer, name) end
		end
	end

	return items
end

function PLUGIN:SendUpgradeItems(client)
	if (client.cotzUpgradeItemsAt or 0) > CurTime() then return end
	client.cotzUpgradeItemsAt = CurTime() + ITEMS_REQUEST_INTERVAL
	local entries = {}
	for itemID, names in SortedPairs(self:CollectUpgradeItems(client)) do
		if #entries < MAX_UPGRADE_ITEMS then entries[#entries + 1] = {itemID, table.GetKeys(names)} end
	end
	net.Start("cotz/hideouts/upgrade-items")
	net.WriteUInt(#entries, 8)
	for _, entry in ipairs(entries) do
		net.WriteString(entry[1])
		net.WriteUInt(math.min(#entry[2], MAX_LISTED_HIDEOUTS), 6)
		for index = 1, math.min(#entry[2], MAX_LISTED_HIDEOUTS) do net.WriteString(entry[2][index]) end
	end
	net.Send(client)
end

net.Receive("cotz/hideouts/upgrade-items", function(_, client)
	PLUGIN:SendUpgradeItems(client)
end)

function PLUGIN:DescribeUpgradeMaterials(materials)
	local lines = {}
	for _, group in ipairs(materials.groups) do
		local names = {}
		for _, itemID in ipairs(group.items) do
			local size = self.crateBatchSizes[itemID] or 1
			local item = ix.item.list[itemID]
			names[#names + 1] = (item and item.name or itemID) .. (size > 1 and " x" .. size or "")
		end
		lines[#lines + 1] = group.quantity .. " batches: " .. table.concat(names, " / ") .. " (" .. group.name .. ")"
	end
	lines[#lines + 1] = "Each batch accepts one listed alternative from your main inventory."

	return table.concat(lines, "\n")
end

-- Prices the offer for the actor and records what each payment option needs, for display and the session.
function PLUGIN:PrepareUpgradeOffer(client, offer, treasury)
	local character = client:GetCharacter()
	local contribution = treasury.enabled and offer.squad and math.min(offer.price, treasury.balance or 0) or 0
	offer.funding = {
		player = offer.price - contribution, treasury = contribution, balance = offer.squad and treasury.balance or nil,
		enabled = offer.squad and treasury.enabled == true, rank = offer.rank or 1,
	}
	local lines = {offer.detail}
	if offer.squad and offer.funding.enabled then
		lines[#lines + 1] = "Cost: " .. ix.currency.Get(offer.price) .. " (squad treasury "
			.. ix.currency.Get(offer.funding.treasury) .. "; your share " .. ix.currency.Get(offer.funding.player) .. ")"
	else
		lines[#lines + 1] = "Cost: " .. ix.currency.Get(offer.price)
	end
	offer.payable = offer.allowed == true
	if offer.materials then
		lines[#lines + 1] = self:DescribeUpgradeMaterials(offer.materials)
		local inputs, missing = self:CollectCrateInputs(client, offer.materials)
		if not inputs then
			offer.payable = false
			lines[#lines + 1] = missing
		end
	end
	if offer.payable and not character:HasMoney(offer.funding.player) then
		offer.payable = false
		lines[#lines + 1] = "Not enough roubles."
	end
	if not offer.allowed and offer.reason then lines[#lines + 1] = offer.reason end
	-- Crates assembled before direct installation remain redeemable for the matching slot and tier.
	local crate = offer.materials and offer.item
		and self:FindUpgradeCrate(client, offer.recipe, offer.level, offer.squad == true)
	offer.redeemable = crate ~= nil and (offer.squad and offer.rankAllowed or offer.allowed) == true
	if offer.redeemable then
		lines[#lines + 1] = "You carry a matching tier " .. offer.level .. " crate. It can be installed instead of paying."
	end
	offer.description = table.concat(lines, "\n")
	offer.summary = ix.currency.Get(offer.price) .. (offer.materials and " + materials" or "")
		.. (offer.redeemable and " (crate carried)" or offer.payable and "" or " (unavailable)")

	return offer
end

function PLUGIN:SendUpgradeHideouts(client, target)
	if not self:CanUseUpgradeContact(client, target) then return end
	if (client.cotzUpgradeHideoutsAt or 0) > CurTime() then return end
	client.cotzUpgradeHideoutsAt = CurTime() + REQUEST_INTERVAL
	self:ReconcileInstalledLevels(client:GetCharacter())
	local hideouts = {}
	for _, record in SortedPairs(self.state.hideouts) do
		if #hideouts < MAX_LISTED_HIDEOUTS and self:IsUpgradeHideout(client, record) then
			hideouts[#hideouts + 1] = record
		end
	end
	net.Start("cotz/hideouts/upgrade-hideouts")
	net.WriteEntity(target)
	net.WriteUInt(#hideouts, 6)
	for _, record in ipairs(hideouts) do
		net.WriteString(record.id)
		net.WriteString(self:GetHideoutName(record):sub(1, 128))
		net.WriteBool(record.ownerType == "squad")
	end
	net.Send(client)
end

function PLUGIN:SendUpgradeOffers(client, target, id, refresh)
	if type(id) ~= "string" or #id > 20 or not self:CanUseUpgradeContact(client, target) then return end
	if not refresh and (client.cotzUpgradeOffersAt or 0) > CurTime() then return end
	client.cotzUpgradeOffersAt = CurTime() + REQUEST_INTERVAL
	local record = self:GetHideout(id)
	if not self:IsUpgradeHideout(client, record) then return end
	local character = client:GetCharacter()
	local function send(treasury)
		if not IsValid(client) or client:GetCharacter() ~= character or not self:CanUseUpgradeContact(client, target)
			or self:GetHideout(id) ~= record then return end
		local offers = self:CollectUpgradeOffers(client, record)
		local pending = self.personalPurchases[record.id]
		for _, offer in ipairs(offers) do
			self:PrepareUpgradeOffer(client, offer, treasury)
			if pending then
				offer.payable, offer.redeemable = false, false
				offer.description = offer.description .. "\nA purchase for this hideout is still being completed."
			end
		end
		client.cotzUpgradeRevision = ((client.cotzUpgradeRevision or 0) + 1) % 4294967296
		client.cotzHideoutUpgrades = {
			character = character, target = target, record = record.id, offers = offers,
			revision = client.cotzUpgradeRevision, expires = CurTime() + SESSION_LIFETIME,
		}
		net.Start("cotz/hideouts/upgrade-offers")
		net.WriteEntity(target)
		net.WriteString(record.id)
		net.WriteUInt(client.cotzUpgradeRevision, 32)
		net.WriteUInt(#offers, 6)
		for _, offer in ipairs(offers) do
			net.WriteString(offer.label:sub(1, 128))
			net.WriteString(offer.summary:sub(1, 128))
			net.WriteString(offer.description:sub(1, 1024))
			net.WriteBool(offer.payable)
			net.WriteBool(offer.redeemable)
		end
		net.Send(client)
	end
	if record.ownerType ~= "squad" then send({enabled = false}) return end
	self:QuoteHideoutFunding(client, record, 0, function(funding, reason)
		if not funding then
			if IsValid(client) then client:Notify(reason or "Squad funding is unavailable.") end
			return
		end
		send(funding)
	end, 1)
end

function PLUGIN:BuildUpgradePayload(offer, funding, redeem)
	local paid = redeem and 0 or funding.player
	local treasury = redeem and 0 or -funding.treasury
	if offer.feature == "props" then
		return {kind = "props", tier = offer.level, treasury = treasury, paid = paid}
	end
	if offer.squad then
		return {kind = "upgrade", slot = offer.slot, tier = offer.level, width = offer.width, height = offer.height,
			crateVersion = self.crateVersion, treasury = treasury, paid = paid, redeemed = redeem or nil}
	end

	return {
		kind = "personal", feature = offer.feature, slot = offer.slot, level = offer.level, recipe = offer.recipe,
		width = offer.width, height = offer.height, model = offer.model, paid = paid, redeemed = redeem or nil,
	}
end

function PLUGIN:RefreshSquadContainer(record, slotID)
	local instance = self.instances[record.id]
	local entity = instance and instance.state == "active" and instance.containers and instance.containers[slotID]
	if not IsValid(entity) then return end
	local slot, definition = self:GetContainer(record, slotID)
	local recipe = slot and self.containerRecipes[definition.recipe]
	local tier = recipe and recipe.tiers[slot.tier or 0]
	local item = tier and ix.item.list[tier.item]
	local model = tier and (tier.model or item and item.model)
	if not model then return end
	entity:SetModel(model)
	entity:PhysicsInit(SOLID_VPHYSICS)
	local physics = entity:GetPhysicsObject()
	if IsValid(physics) then physics:EnableMotion(false) end
	self:AuditContainers(instance)
end

function PLUGIN:ApplyUpgradePayload(record, payload, storage)
	if payload.kind == "props" then
		record.propTier = math.max(self:GetHideoutPropTier(record), payload.tier)
	elseif payload.kind == "personal" then
		self:ApplyPersonalEntitlement(record, payload)
		if payload.feature == "cassette" then self:RefreshPersonalCassette(record) end
	else
		local slot = self:GetContainer(record, payload.slot)
		if slot and (slot.tier or 0) < payload.tier then
			slot.tier, slot.width, slot.height = payload.tier, payload.width, payload.height
		end
	end
	if not storage then return end
	storage:SetSize(payload.width, payload.height)
	if payload.kind == "personal" then
		self:RefreshPersonalContainer(record, payload.slot)
	else
		self:RefreshSquadContainer(record, payload.slot)
	end
end

-- Validates the reviewed offer again, then charges and installs it in one recorded operation.
function PLUGIN:ExecuteUpgrade(client, target, data)
	if (client.cotzUpgradeBuyAt or 0) > CurTime() then return false end
	client.cotzUpgradeBuyAt = CurTime() + 0.5
	local session = client.cotzHideoutUpgrades
	if type(data) ~= "table" or not session or data.revision ~= session.revision then
		return false, "Review the hideout upgrade again."
	end
	client.cotzHideoutUpgrades = nil
	local character = client:GetCharacter()
	local quoted = isnumber(data.index) and session.offers[data.index]
	if not quoted or session.character ~= character or session.target ~= target or session.expires < CurTime()
		or not self:CanUseUpgradeContact(client, target) then
		return false, "Review the hideout upgrade again."
	end
	local record = self:GetHideout(session.record)
	local offer = self:BuildUpgradeOffer(client, record, quoted.feature, quoted.slot)
	if not offer or not self:SameUpgradeOffer(offer, quoted) then
		return false, "That upgrade changed. Review it again."
	end
	local redeem = data.crate == true
	local funding = quoted.funding
	if redeem and not quoted.redeemable or not redeem and not offer.allowed then
		return false, offer.reason or "That upgrade is unavailable."
	end
	if self.personalPurchases[record.id] then
		return false, "This hideout already has a purchase pending."
	end
	if not redeem and (funding.player + funding.treasury ~= offer.price
		or not self:ValidateHideoutFunding(client, record, funding)) then
		return false, "The payment changed. Review the upgrade again."
	end
	local inventory = character:GetInventory()
	local crate = redeem and self:FindUpgradeCrate(client, offer.recipe, offer.level, offer.squad == true) or nil
	if redeem and not crate then return false, "Bring the matching crate in your main inventory." end
	local inputs
	if offer.materials and not redeem then
		local missing
		inputs, missing = self:CollectCrateInputs(client, offer.materials)
		if not inputs then return false, missing end
	end
	if not redeem and not character:HasMoney(funding.player) then return false, "Not enough roubles." end
	local payload = self:BuildUpgradePayload(offer, funding, redeem)
	local instance = self.instances[record.id]
	self.personalPurchases[record.id] = true
	if instance then instance.operations = (instance.operations or 0) + 1 end
	local function release()
		self.personalPurchases[record.id] = nil
		if instance then instance.operations = instance.operations - 1 end
	end
	local function authorize()
		local current = self:BuildUpgradeOffer(client, record, offer.feature, offer.slot)
		if not IsValid(client) or client:GetCharacter() ~= character or self:GetHideout(record.id) ~= record
			or not self:CanUseUpgradeContact(client, target) or not current
			or not self:SameUpgradeOffer(current, offer) then return false end
		if redeem then
			return (offer.squad and current.rankAllowed or current.allowed) == true
				and self:IsUpgradeCrate(client, crate, offer.recipe, offer.level, offer.squad == true)
		end

		return current.allowed == true and self:ValidateHideoutFunding(client, record, funding)
	end
	local function finish(ok, reason, storage)
		if ok then
			self:ApplyUpgradePayload(record, payload, storage)
			if payload.kind == "personal" and payload.feature == "container" then
				self:CompleteInstalledLevel(character, payload.level)
			end
			if not self:Persist() then
				self.operationsReady = false
				ErrorNoHalt("[Hideouts] Upgrade committed; restart to replay its entitlement.\n")
			end
		end
		release()
		if not IsValid(client) or client:GetCharacter() ~= character then return end
		client:Notify(ok and "Hideout upgrade installed." or reason or "The upgrade could not be completed.")
		self:SendUpgradeOffers(client, target, record.id, true)
	end
	local function commit(storage)
		if offer.feature == "container" and not storage or not authorize() then
			finish(false, "Hideout access or the upgrade changed.")
			return
		end
		if storage then self:CloseInventoryStorage(storage) end
		self:CommitOperation(client, record, {
			item = crate, consume = crate ~= nil, inputs = inputs, from = (crate or inputs) and inventory or nil,
			moneyDelta = redeem and 0 or -funding.player, treasuryDelta = redeem and 0 or -funding.treasury,
			treasuryBalance = not redeem and funding.enabled and funding.balance or nil,
			rank = offer.squad and offer.rank or nil, payload = payload, authorize = authorize,
		}, function(ok, reason) finish(ok, reason, storage) end)
	end
	local function start()
		if offer.feature ~= "container" then commit() return end
		local slot = self:GetContainer(record, offer.slot)
		if not slot then commit() return end
		self:LoadOwnedInventory(record, offer.slot, slot, "cotzHideoutContainer", slot.width or 1, slot.height or 1,
			commit)
	end
	if not offer.squad then start() return true end
	self:CheckSquadRole(client, record, offer.rank, function(allowed)
		if not allowed then finish(false, "Your squad rank no longer permits this upgrade.") return end
		start()
	end)

	return true
end
