ix.progression = ix.progression or {}

local CREDIT_KEY = "progressionServiceCredits"
local QUOTE_LIFETIME = 60
local MAX_DISCOUNT = 0.15
local SERVICE_CONTACTS = {
	repair = { ["'Technut'"] = true, ["'Boss'"] = true },
	treatment = { ["'Jitters'"] = true, ["'Arena Master'"] = true },
	storage = { ["'Cleaner'"] = true },
	wish = { ["'???'"] = true },
}
local CREDIT_LIMITS = {repair = 20000, treatment = 5000, storage = 50000, wish = 100000}
local TREATMENT_RATES = {hp = 2, rad = 3, psy = 4}
local WISH_PRICE = 1000000
local MAX_WISH_PRICE = 4000000
local WISH_TYPES = {carryinc = true, far = true, fbsr = true, hp = true, weapon = true, suit = true}

function ix.progression.GetServiceCredit(character, npc, service)
	local credits = character:GetData(CREDIT_KEY, {}) or {}

	return credits[npc .. "/" .. service] or 0
end

local function definitionDiscount(definition, npc, service)
	local discount = 0
	for _, benefit in ipairs(definition.serviceDiscounts or {}) do
		if benefit.npc == npc and benefit.service == service then
			discount = math.max(discount, benefit.fraction)
		end
	end

	return discount
end

function ix.progression.GetServiceDiscount(character, npc, service)
	local discount = 0
	for id, definition in pairs(ix.progression.definitions) do
		if definition.serviceDiscounts and ix.progression.IsCompleted(character, id) then
			discount = math.max(discount, definitionDiscount(definition, npc, service))
		end
	end

	return math.Clamp(discount, 0, MAX_DISCOUNT)
end

function ix.progression.QuoteService(character, npc, service, baseCost)
	local discount = ix.progression.GetServiceDiscount(character, npc, service)
	local price = math.max(0, math.ceil(baseCost * (1 - discount)))
	local credit = math.min(price, ix.progression.GetServiceCredit(character, npc, service))

	return price - credit, credit, baseCost - price
end

local function ownedItem(character, itemID)
	local item = character:GetInventory():GetItems()[tonumber(itemID)]
	if item and item:GetID() == tonumber(itemID) then
		return item
	end
end

local function repairOffer(client, data)
	local item = ownedItem(client:GetCharacter(), data.itemid)
	if not item or not item.canRepair then
		return
	end
	local field = item.isWeapon and "wear" or "durability"
	local missing = 100 - item:GetData(field, 100)
	if missing < 0.5 then
		return
	end

	return {item = item, field = field, baseCost = math.max(0, math.Round(missing * item:GetRepairCost()))}
end

local function treatmentOffer(client, data, npc)
	local requested = data.type
	if npc == "'Arena Master'" and requested ~= "hp" then
		return
	end
	local missing = {
		hp = math.max(0, client:GetMaxHealth() - client:Health()),
		rad = math.max(0, client:getRadiation()),
		psy = math.max(0, 100 - client:GetPsyHealth()),
	}
	if not missing[requested] and requested ~= "all" then
		return
	end
	local cost = 0
	for kind, value in pairs(missing) do
		if requested == kind or requested == "all" then
			cost = cost + math.Round(value * TREATMENT_RATES[kind])
		end
	end

	return {type = requested, baseCost = cost}
end

local function storageOffer(client, data)
	local character = client:GetCharacter()
	if not ix.progression.IsCompleted(character, "cleanerItemDelivery_Storage") then
		return
	end
	local horizontal = data.direction == "horizontally"
	if not horizontal and data.direction ~= "vertically" then
		return
	end
	local field = horizontal and "bankW" or "bankH"
	local size = character:GetData(field, ix.config.Get(field, 2))
	if size >= ix.config.Get(field .. "Max", 2) then
		return
	end
	local base = horizontal and 120 or 320

	return {field = field, size = size, baseCost = math.Round(base ^ (1 + size / 5.5))}
end

local function wishOffer(client, data)
	local character = client:GetCharacter()
	local kind = data.type
	local wishes = character:GetData("wishes", {}) or {}
	if not WISH_TYPES[kind] or wishes[kind] then
		return
	end
	local item
	if kind == "weapon" or kind == "suit" then
		item = ownedItem(character, data.itemid)
		local matchingType = item and ((kind == "weapon" and item.isWeapon) or (kind == "suit" and item.isBodyArmor))
		local eligible = matchingType and item.canRepair
		if not eligible or item:GetData("unlimitedDurability", false) then
			return
		end
	end
	local previous = character:GetData("wishPurchases", table.Count(wishes))

	return {type = kind, item = item, baseCost = math.min(MAX_WISH_PRICE, previous * WISH_PRICE)}
end

local OFFER_BUILDERS = {repair = repairOffer, treatment = treatmentOffer, storage = storageOffer, wish = wishOffer}

function ix.progression.GetEarnedServiceText(character, npc)
	local parts = {}
	for service, contacts in pairs(SERVICE_CONTACTS) do
		if contacts[npc] then
			local credit = ix.progression.GetServiceCredit(character, npc, service)
			local discount = ix.progression.GetServiceDiscount(character, npc, service)
			if credit > 0 then parts[#parts + 1] = string.format("%s credit: %d", service, credit) end
			if discount > 0 then parts[#parts + 1] = string.format("%s discount: %g%%", service, discount * 100) end
		end
	end
	for id, definition in pairs(ix.progression.definitions) do
		if definition.keyNpc == npc and definition.recognition and ix.progression.IsCompleted(character, id) then
			parts[#parts + 1] = "Recognition: " .. definition.recognition
		end
	end
	table.sort(parts)

	return table.concat(parts, "; ")
end

function ix.progression.BuildServiceOffer(client, target, service, data)
	local character = client:GetCharacter()
	local npc = target:GetDisplayName()
	if not character or type(data) ~= "table" or not SERVICE_CONTACTS[service]
		or not SERVICE_CONTACTS[service][npc] or not ix.progression.CanUseNPC(character, npc) then
		return
	end
	local offer = OFFER_BUILDERS[service](client, data, npc)
	if not offer or type(offer.baseCost) ~= "number" or offer.baseCost < 0
		or offer.baseCost == math.huge or offer.baseCost % 1 ~= 0 then
		return
	end
	offer.cost, offer.credit, offer.discount = ix.progression.QuoteService(character, npc, service, offer.baseCost)
	offer.npc = npc

	return offer
end

function ix.progression.ServicePriceText(offer)
	local text = ix.currency.Get(offer.cost)
	if offer.credit > 0 then
		text = text .. " (" .. ix.currency.Get(offer.credit) .. " covered by your service credit)"
	end
	if offer.discount > 0 then
		text = text .. " (earned discount: " .. ix.currency.Get(offer.discount) .. ")"
	end

	return text
end

local SERVICE_TOPICS = {
	repair = {"ConfirmRepair", "NotEnoughMoneyRepair"},
	treatment = {"ConfirmHeal", "NotEnoughMoneyHeal"},
	storage = {"ConfirmStorageUpgrade", "NotEnoughMoneyStorage"},
	wish = {"ConfirmWish", "NotEnoughMoneyWish"},
}

function ix.progression.ResolveServiceOffer(client, target, service, data)
	if type(data) ~= "table" then return "BackTopic" end
	if service == "storage" and data.option == "use" then
		return ix.progression.IsCompleted(client:GetCharacter(), "cleanerItemDelivery_Storage")
			and "OpenStorage" or "BackTopic"
	end
	local offer = ix.progression.BuildServiceOffer(client, target, service, data)
	if not offer then return "BackTopic" end
	if not client:GetCharacter():HasMoney(offer.cost) then return SERVICE_TOPICS[service][2] end

	return SERVICE_TOPICS[service][1], {
		cost = offer.cost, type = data.type, itemid = data.itemid, direction = data.direction,
	}
end

function ix.progression.ConfirmService(topic, client, target, service, data)
	local offer = ix.progression.BuildServiceOffer(client, target, service, data)
	if offer and data.cost ~= nil and (type(data.cost) ~= "number" or data.cost < 0 or offer.cost > data.cost) then
		offer = nil
	end
	if CLIENT then
		topic.response = offer and ("This service will cost " .. ix.progression.ServicePriceText(offer) .. ".")
			or "That service is no longer available. Please choose it again."
	else
		client.ixProgressionServiceQuote = offer and {
			character = client:GetCharacter(), target = target, service = service,
			arguments = {type = data.type, itemid = data.itemid, direction = data.direction},
			cost = offer.cost, baseCost = offer.baseCost, expires = CurTime() + QUOTE_LIFETIME,
		} or nil
	end
end

function ix.progression.GetTreatmentOptions(client, target)
	local options = {}
	local names = {hp = "Physical health", rad = "Radiation treatment", psy = "Mental health", all = "Everything"}
	for _, kind in ipairs({"hp", "rad", "psy", "all"}) do
		local data = {type = kind}
		local offer = ix.progression.BuildServiceOffer(client, target, "treatment", data)
		if offer then
			data.cost = offer.cost
			options[#options + 1] = {statement = names[kind] .. " - " .. ix.progression.ServicePriceText(offer),
				topicID = "HealTopic", dyndata = data}
		end
	end

	return options
end

function ix.progression.GetRepairOptions(client, target)
	local options = {}
	for id, item in pairs(client:GetCharacter():GetInventory():GetItems()) do
		local data = {itemid = id}
		local offer = ix.progression.BuildServiceOffer(client, target, "repair", data)
		if offer then
			data.cost = offer.cost
			options[#options + 1] = {statement = item:GetName() .. " - " .. ix.progression.ServicePriceText(offer),
				topicID = "RepairItems", dyndata = data}
		end
	end

	return options
end

function ix.progression.GetStorageOptions(client, target)
	local options = {{statement = "Can I please see my storage?", topicID = "StorageTopic", dyndata = {option = "use"}}}
	for _, direction in ipairs({"horizontally", "vertically"}) do
		local data = {direction = direction}
		local offer = ix.progression.BuildServiceOffer(client, target, "storage", data)
		if offer then
			data.cost = offer.cost
			options[#options + 1] = {statement = "Expand storage " .. direction .. " - "
				.. ix.progression.ServicePriceText(offer), topicID = "StorageTopic", dyndata = data}
		end
	end

	return options
end

function ix.progression.GetWishOptions(client, target)
	local options = {}
	local names = {
		carryinc = "I wish to carry more of the riches of the Zone.",
		far = "I wish for anomalous skin.", fbsr = "I wish for kevlar in my skin.",
		hp = "I wish for my health to improve.",
	}
	local function addWish(kind, item)
		local data = {type = kind, itemid = item and item:GetID()}
		local offer = ix.progression.BuildServiceOffer(client, target, "wish", data)
		if offer then
			data.cost = offer.cost
			local label = item and ("I wish for my " .. item:GetName() .. " never to deteriorate.") or names[kind]
			options[#options + 1] = {statement = label .. " - " .. ix.progression.ServicePriceText(offer),
				topicID = "WishTopic", dyndata = data}
		end
	end
	for _, kind in ipairs({"carryinc", "far", "fbsr", "hp"}) do addWish(kind) end
	for _, item in pairs(client:GetCharacter():GetInventory():GetItems()) do
		if item.isWeapon then addWish("weapon", item) end
		if item.isBodyArmor then addWish("suit", item) end
	end

	return options
end

function ix.progression.ValidateBenefits(definition)
	local function checkBenefits(benefits)
		for _, reward in ipairs(benefits.items or {}) do
			assert(ix.item.list[reward.item], "Unknown reward item: " .. tostring(reward.item))
		end
		for _, reward in ipairs(benefits.services or {}) do
			assert(SERVICE_CONTACTS[reward.service] and SERVICE_CONTACTS[reward.service][reward.npc],
				"Unsupported service reward")
			assert(type(reward.amount) == "number" and reward.amount > 0
				and reward.amount <= CREDIT_LIMITS[reward.service] and reward.amount % 1 == 0,
				"Invalid service credit amount")
		end
	end
	checkBenefits(definition.completionBenefits or {})
	for _, benefits in ipairs(definition.checkpointBenefits or {}) do checkBenefits(benefits) end
	for _, discount in ipairs(definition.serviceDiscounts or {}) do
		assert(SERVICE_CONTACTS[discount.service] and SERVICE_CONTACTS[discount.service][discount.npc],
			"Unsupported service discount")
		assert(type(discount.fraction) == "number" and discount.fraction > 0
			and discount.fraction <= MAX_DISCOUNT, "Invalid service discount")
	end
end

if SERVER then
	function ix.progression.GrantBenefits(character, progressionID, benefits, claimID)
		local record = ix.progression.GetCharacterProgression(character)
		local line = ix.progression.GetLine(character, progressionID)
		line.benefitsClaimed = line.benefitsClaimed or {}
		if line.benefitsClaimed[claimID] then
			return false
		end
		local credits = table.Copy(character:GetData(CREDIT_KEY, {}) or {})
		for _, benefit in ipairs(benefits.services or {}) do
			local key = benefit.npc .. "/" .. benefit.service
			credits[key] = math.min(CREDIT_LIMITS[benefit.service], (credits[key] or 0) + benefit.amount)
		end
		line.pendingRewards = line.pendingRewards or {}
		for _, reward in ipairs(benefits.items or {}) do
			line.pendingRewards[#line.pendingRewards + 1] =
				ix.progression.PrepareReward(character, progressionID, line, table.Copy(reward))
		end
		line.benefitsClaimed[claimID] = true
		record.lines[progressionID] = line
		character:SetData(CREDIT_KEY, credits)
		ix.progression.SetCharacterProgression(character, record)
		character:Save()
		ix.progression.ClaimRewards(character, progressionID)

		return true
	end

	function ix.progression.CompleteCheckpoint(character, progressionID, level)
		local definition = ix.progression.definitions[progressionID]
		local threshold = definition and definition.progressthresholds[level]
		if not threshold or ix.progression.GetProgressionValue(character, progressionID) < threshold then
			return false
		end
		local benefits = definition.checkpointBenefits and definition.checkpointBenefits[level]
		if not benefits then return false end
		local granted = ix.progression.GrantBenefits(character, progressionID, benefits, "checkpoint:" .. level)
		if not granted then return false end
		local message = definition.checkpointMessages[level]
		ix.progression.Notify(character, definition.keyNpc, character:GetName() .. ", " .. message)
		local client = character:GetPlayer()
		if ix.vendorStock and ix.vendorStock.Refresh and IsValid(client) and IsValid(client.ixVendorAdv) then
			ix.vendorStock.Refresh(character, client.ixVendorAdv)
		end

		return true
	end

	local function applyTreatment(client, offer)
		if offer.type == "hp" or offer.type == "all" then client:SetHealth(client:GetMaxHealth()) end
		if offer.type == "rad" or offer.type == "all" then client:setRadiation(0) end
		if offer.type == "psy" or offer.type == "all" then client:SetPsyHealth(100) end
	end

	local function applyWish(client, offer)
		local character = client:GetCharacter()
		local wishes = character:GetData("wishes", {}) or {}
		local previous = character:GetData("wishPurchases", table.Count(wishes))
		if offer.item then
			offer.item:SetData("unlimitedDurability", true)
		else
			wishes[offer.type] = true
		end
		character:SetData("wishes", wishes)
		character:SetData("wishPurchases", previous + 1)
		if offer.type == "hp" then client:SetMaxHealth(125) end
		if offer.type == "far" or offer.type == "fbsr" then client:RecalculateResistances() end
	end

	local function applyRepair(client, offer)
		offer.item:SetData(offer.field, 100)
		if offer.item.isWeapon and offer.item.class then
			local weapon = client:GetWeapon(offer.item.class)
			if IsValid(weapon) then weapon:SetWeaponWear(100) end
		end
	end

	function ix.progression.ExecuteService(client, target, service, accepted)
		local quote = client.ixProgressionServiceQuote
		client.ixProgressionServiceQuote = nil
		local character = client:GetCharacter()
		if not accepted or not quote or quote.character ~= character or quote.target ~= target
			or quote.service ~= service or quote.expires < CurTime() or not IsValid(target)
			or not target:CanAccess(client)
			or client:GetPos():DistToSqr(target:GetPos()) > 192 * 192 then
			return false
		end
		local offer = ix.progression.BuildServiceOffer(client, target, service, quote.arguments)
		if not offer or offer.cost > quote.cost or offer.baseCost > quote.baseCost
			or not character:HasMoney(offer.cost) then
			return false
		end
		local credits = table.Copy(character:GetData(CREDIT_KEY, {}) or {})
		local key = offer.npc .. "/" .. service
		credits[key] = math.max(0, (credits[key] or 0) - offer.credit)
		character:SetData(CREDIT_KEY, credits)
		character:TakeMoney(offer.cost)
		if service == "repair" then applyRepair(client, offer) end
		if service == "treatment" then applyTreatment(client, offer) end
		if service == "storage" then character:SetData(offer.field, offer.size + 1) end
		if service == "wish" then applyWish(client, offer) end
		ix.dialogue.notifyMoneyLost(client, offer.cost)
		character:Save()

		return true
	end
end
