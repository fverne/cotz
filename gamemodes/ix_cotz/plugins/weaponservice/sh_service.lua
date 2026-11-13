local ACTIONS = {barrel = true, receiver = true, rebuild = true, dismantle = true}

function PLUGIN:ComponentID(weaponID, kind)
	return "weapon_" .. kind .. "_" .. weaponID
end

function PLUGIN:CanUse(client, target)
	if not IsValid(target) or target:GetClass() ~= "ix_vendor_adv" or target:GetSherpa() then return false end
	local character = client:GetCharacter()
	local name = target:GetDisplayName()
	if not character or not self.settings.providers[name] then return false end
	if not ix.progression.CanUseNPC(character, name) or not target:CanAccess(client) then return false end

	return client:GetPos():DistToSqr(target:GetPos()) <= self.settings.useDistance ^ 2
		and hook.Run("CanPlayerUseVendor", client, target) ~= false
end

function PLUGIN:OwnedWeapon(character, id)
	if type(id) ~= "number" or id % 1 ~= 0 then return end
	local item = character:GetInventory():GetItems()[id]
	if item and self.catalogue[item.uniqueID] then return item end
end

function PLUGIN:Conditions(client, item)
	local durability = item:GetData("durability", 100)
	local cleanliness = item:GetData("wear", 100)
	if item:GetData("equip", false) then
		local weapon = client:GetWeapon(item.class)
		if IsValid(weapon) then
			durability = weapon:GetWeaponDurability()
			cleanliness = weapon:GetWeaponWear()
		end
	end

	return math.Clamp(durability, 0, 100), math.Clamp(cleanliness, 0, 100)
end

function PLUGIN:SalvageYield(tier, durability, cleanliness)
	local expected = self.settings.yields[tier]
		* math.Clamp(durability, 0, 100) / 100 * math.Clamp(cleanliness, 0, 100) / 100
	local guaranteed = math.floor(expected)

	return guaranteed, expected - guaranteed
end

function PLUGIN:Pending(character)
	return character:GetData("weaponWorkshop", {}).pending or {}
end

function PLUGIN:CountItem(character, uniqueID)
	local count = 0
	for _, item in pairs(character:GetInventory():GetItems()) do
		if item.uniqueID == uniqueID and not item.cotzWorkshopLocked then
			count = count + (item.quantity and item:GetData("quantity", item.quantity) or 1)
		end
	end

	return count
end

function PLUGIN:PlanRequirements(character, requirements)
	local plan = {}
	local items = character:GetInventory():GetItems()
	local ids = {}
	for id in pairs(items) do ids[#ids + 1] = id end
	table.sort(ids)
	for uniqueID, required in SortedPairs(requirements) do
		local remaining = required
		for _, id in ipairs(ids) do
			local item = items[id]
			if item.uniqueID == uniqueID and not item.cotzWorkshopLocked and remaining > 0 then
				local quantity = item.quantity and item:GetData("quantity", item.quantity) or 1
				local take = math.min(remaining, quantity)
				plan[#plan + 1] = {item = item, take = take, quantity = quantity}
				remaining = remaining - take
			end
		end
		if remaining > 0 then return end
	end

	return plan
end

function PLUGIN:BuildOffer(client, target, arguments)
	if not self:CanUse(client, target) or type(arguments) ~= "table" then return end
	local action = arguments.action
	if not ACTIONS[action] then return end
	local character = client:GetCharacter()
	local item = self:OwnedWeapon(character, arguments.itemid)
	if not item or item.cotzWorkshopLocked then return end
	local definition = self.catalogue[item.uniqueID]
	local durability, cleanliness = self:Conditions(client, item)
	local offer = {
		item = item, action = action, npc = target:GetDisplayName(), requirements = {},
		durability = durability, cleanliness = cleanliness, cost = 0, credit = 0, discount = 0, baseCost = 0,
	}
	if action == "barrel" or action == "receiver" then
		local component = ix.item.list[self:ComponentID(item.uniqueID, action)]
		offer.requirements = table.Copy(component.recipe)
		offer.reward = component.uniqueID
		offer.baseCost = math.ceil(ix.item.list[item.uniqueID].price * component.commissionRate)
		offer.cost, offer.credit, offer.discount =
			ix.progression.QuoteService(character, offer.npc, "repair", offer.baseCost)
	elseif action == "rebuild" then
		offer.requirements[self:ComponentID(item.uniqueID, "barrel")] = 1
		offer.requirements[self:ComponentID(item.uniqueID, "receiver")] = 1
		if durability >= 100 then offer.blocked = "This weapon already has full durability." end
	else
		offer.reward = self.salvageFamilies[definition.family].item
		offer.guaranteed, offer.extraChance = self:SalvageYield(definition.tier, durability, cleanliness)
		if item:GetData("equip", false) or item:GetData("ammo", 0) > 0
			or next(item:GetData("attachments", {})) ~= nil then
			offer.blocked = "Unequip, unload and remove all attachments before dismantling this weapon."
		end
	end
	if #self:Pending(character) > 0 then offer.blocked = "Collect your stored workshop items first." end
	offer.plan = self:PlanRequirements(character, offer.requirements)
	if not offer.plan then offer.blocked = "You are missing required ingredients." end
	if offer.plan and #offer.plan > self.settings.maxPending then
		offer.blocked = "Combine your ingredient stacks before requesting this exchange."
	end
	if not character:HasMoney(offer.cost) then offer.blocked = "You do not have enough money." end

	return offer
end

function PLUGIN:DescribeOffer(character, offer)
	local lines = {offer.item.name .. " [#" .. offer.item.id .. "]"}
	lines[#lines + 1] = string.format("Durability: %.1f%%; cleanliness: %.1f%%.",
		offer.durability, offer.cleanliness)
	if offer.action == "dismantle" then
		local chance = offer.extraChance * 100
		lines[#lines + 1] = "Dismantling destroys this weapon. Reward: " .. ix.item.list[offer.reward].name .. "."
		if chance > 0 then
			lines[#lines + 1] = string.format("%.2f%% chance of %d; %.2f%% chance of %d.",
				100 - chance, offer.guaranteed, chance, offer.guaranteed + 1)
		else
			lines[#lines + 1] = string.format("Guaranteed result: %d parts.", offer.guaranteed)
		end
	elseif offer.action == "rebuild" then
		lines[#lines + 1] = "Both components are consumed. Durability becomes 100%; cleanliness stays unchanged."
	else
		lines[#lines + 1] = "Output: " .. ix.item.list[offer.reward].name .. "."
		lines[#lines + 1] = "Base commission: " .. ix.currency.Get(offer.baseCost) .. "."
		lines[#lines + 1] = "Cash due: " .. ix.progression.ServicePriceText(offer) .. "."
	end
	for uniqueID, count in SortedPairs(offer.requirements) do
		lines[#lines + 1] = string.format("%s: %d required; %d carried.",
			ix.item.list[uniqueID].name, count, self:CountItem(character, uniqueID))
	end
	if offer.blocked then lines[#lines + 1] = offer.blocked end

	return table.concat(lines, "\n")
end

function PLUGIN:AuditCatalogue()
	for weaponID, entry in pairs(self.catalogue) do
		assert(ix.item.list[weaponID], "Missing workshop weapon: " .. weaponID)
		assert(self.salvageFamilies[entry.family] and self.settings.yields[entry.tier], "Invalid workshop family/tier")
		for _, kind in ipairs({"barrel", "receiver"}) do
			local component = ix.item.list[self:ComponentID(weaponID, kind)]
			assert(component and component.weaponID == weaponID and component.componentKind == kind,
				"Invalid workshop component for " .. weaponID)
			for id, quantity in pairs(component.recipe) do
				assert(ix.item.list[id] and quantity > 0 and quantity % 1 == 0, "Invalid workshop ingredient: " .. id)
			end
		end
	end
	local best = {}
	for tier = 1, #self.settings.yields do
		local pools = ix.randomitems and ix.randomitems.tables or {}
		for _, suffix in ipairs({"low", "high"}) do
			for _, entry in ipairs(pools[string.format("task_reward_weapon_%02d_%s", tier, suffix)] or {}) do
				local id, weight = entry[2][1], entry[1]
				if not best[id] or weight > best[id].weight then
					best[id] = {tier = tier, weight = weight}
				elseif weight == best[id].weight and tier ~= best[id].tier then
					best[id].conflict = true
				end
			end
		end
	end
	for id, entry in pairs(best) do
		if not self.catalogue[id] or self.catalogue[id].tier ~= entry.tier or entry.conflict then
			ErrorNoHalt("[Weapon Workshop] Review reward-pool tier for " .. id .. "; catalogue unchanged.\n")
		end
	end
end
