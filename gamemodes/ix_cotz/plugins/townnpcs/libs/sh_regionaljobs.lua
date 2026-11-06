local PLUGIN = PLUGIN
local DIFFICULTIES = {"easy", "medium", "hard"}

local function register(contact, tier, suffix, definition)
	local difficulty = DIFFICULTIES[tier]
	local reward = (contact.job.rewards or PLUGIN.settings.jobRewards)[difficulty]
	definition.tier = tier
	definition.townContact = contact.id
	definition.issuerName = contact.name
	definition.regionalJob = true
	definition.reward, definition.rewardCount = {}, 0
	definition.moneyReward, definition.repReward = reward.money, reward.reputation
	definition.icon = "propic/event/area"
	definition.categories = {"cotz/town/v2/" .. contact.id .. "/" .. difficulty}
	definition.numberRec = definition.numberRec or 1
	contact.categories[difficulty] = definition.categories
	ix.jobs.register(definition, definition.categories[1] .. "/" .. suffix)
end

local function regionalTargets(contact, tier)
	local map = contact.job.maps[DIFFICULTIES[tier]]
	for species, pack in pairs(ix.jobs.regionalCatalogue.packs[map] or {}) do
		local human = species == "bandit" or species == "merc" or species == "mili"
		local kind = contact.job.kind
		if (kind == "regionalHumans" and human) or (kind == "regionalHunting" and not human) then
			register(contact, tier, species, {name = "Eliminate %d " .. species .. ".",
				desc = "Eliminate %d " .. species .. " in " .. map .. ", then return to " .. contact.name .. ".",
				numberRec = math.ceil(1.1 * pack), targetMap = map, targetSpecies = species})
		elseif kind == "regionalMeals" or kind == "regionalSpecimens" then
			local products = ix.jobs.regionalCatalogue.products[species] or {}
			local itemID = kind == "regionalMeals" and products.meal or products.specimen
			if itemID and itemID ~= "" and ix.item.list[itemID] then
				local factor = kind == "regionalMeals" and 1.1 or (tier == 3 and 1 or 0.8)
				register(contact, tier, itemID, {name = "Deliver %d " .. ix.item.list[itemID].name .. ".",
					desc = "Deliver %d whole items from " .. species .. " found in " .. map .. ".",
					requiredItem = itemID, wholeItems = true, numberRec = math.ceil(factor * pack)})
			end
		end
	end
end

local function categoryHunts(contact, tier)
	local map = contact.job.maps[DIFFICULTIES[tier]]
	for category, members in pairs(ix.jobs.regional.groups) do
		local weights, count = {}, 0
		for species, pack in pairs(ix.jobs.regionalCatalogue.packs[map] or {}) do
			if members[species] then weights[species], count = 1 / pack, count + 1 end
		end
		if count >= 3 then
			register(contact, tier, category, {name = "Hunt %d packs of " .. category .. ".",
				desc = "Hunt %d pack equivalents of " .. category .. " in " .. map .. ".",
				targetMap = map, targetWeights = weights, numberRec = tier == 3 and {5, 6} or tier + 1})
		end
	end
end

local function valuableDeliveries(contact, tier)
	local home
	for index, map in ipairs(ix.jobs.regionalCatalogue.maps) do if map == contact.map then home = index end end
	for itemID, source in pairs(ix.jobs.regionalCatalogue.valuables) do
		local localSource, easierSource, harderSource = false, false, false
		for index, map in ipairs(ix.jobs.regionalCatalogue.maps) do
			for _, acquired in ipairs(source.maps) do
				if map == acquired then
					localSource = localSource or index == home
					easierSource = easierSource or index <= home
					harderSource = harderSource or index > home
				end
			end
		end
		local allowed = tier == 1 and easierSource or tier == 2 and localSource
		if tier == 3 then allowed = harderSource and not easierSource end
		local receivers = false
		for _, receiver in pairs(PLUGIN.contacts) do
			local disabled = receiver.disabledItems and receiver.disabledItems[itemID]
			if receiver.map == contact.map and (receiver.wantedItems or {})[itemID] and not disabled then
				receivers = true
			end
		end
		if allowed and receivers and ix.item.list[itemID] then
			register(contact, tier, itemID, {name = "Deliver %d " .. ix.item.list[itemID].name .. ".",
				desc = "Deliver %d units to a contact in " .. contact.map .. " who requests this category. Return to " .. contact.name .. " for payment. Previously collected or traded items count.",
				requiredItem = itemID, numberRec = source.batch * (tier == 1 and 1 or 2), alternateDelivery = true})
		end
	end
end

local function fieldJob(contact, tier)
	local kind = contact.job.kind
	local definition = {name = contact.job.description, desc = contact.job.description,
		fieldType = kind, fieldMap = (contact.job.maps or {})[DIFFICULTIES[tier]]}
	if kind == "sensor" then definition.fieldSettings = {recordSeconds = 900} end
	if kind == "triangulation" then definition.fieldSettings = {readingCount = tier + 2} end
	if kind == "recovery" then
		definition.fieldCargoChoices = tier == 1 and {"job_recovery_tube", "job_recovery_module", "job_recovery_notes"}
			or {"job_recovery_tools", "job_recovery_equipment", "job_recovery_armour"}
		if tier == 3 then definition.fieldMaps = {"rp_garbage_cotz", "rp_waystation"} end
	elseif kind == "defence" then
		definition.regionalWaves = true
		definition.fieldMaps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation"}
		if tier > 1 then definition.fieldMaps[4] = "rp_pripyat_remaster" end
	elseif kind == "deadDrop" then
		local maps = tier == 1 and {contact.map} or {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"}
		for _, pickup in ipairs(tier == 3 and maps or {contact.map}) do
			for _, destination in ipairs(maps) do
				local allowed = (tier == 1 or pickup ~= destination)
					and not (tier == 2 and destination == "rp_pripyat_remaster")
				if allowed then
					local route = table.Copy(definition)
					route.fieldMap, route.destinationMap = pickup, destination
					route.fieldCargoChoices = {"town_quest_case", "town_quest_equipment", "town_quest_medical"}
					route.desc = "Collect the assigned parcel in " .. pickup .. " and deliver it to the cache in " .. destination .. ". Return to " .. contact.name .. "."
					register(contact, tier, pickup .. "/" .. destination, route)
				end
			end
		end
		return
	end
	definition.desc = definition.desc .. " Use Field work for the saved assignment and return instructions."
	register(contact, tier, kind, definition)
end

function PLUGIN:RegisterRegionalJobs(contact)
	local kind = contact.job.kind
	if kind == "none" then return end
	for tier in ipairs(DIFFICULTIES) do
		if kind == "dataExtract" then
			local oldID = "cotz/town/" .. contact.id .. "/" .. DIFFICULTIES[tier] .. "/dataExtract"
			local definition = table.Copy(ix.jobs.list[oldID])
			definition.completionOnly = nil
			register(contact, tier, "dataExtract", definition)
			local id = "cotz/town/v2/" .. contact.id .. "/" .. DIFFICULTIES[tier] .. "/dataExtract"
			definition.listenTrigger, definition.toolData.finishedtrigger = id, id
			ix.jobs.RegisterToolJob(definition, id)
		elseif kind == "valuableCourier" then
			valuableDeliveries(contact, tier)
		elseif kind == "categoryHunting" then
			categoryHunts(contact, tier)
		elseif kind:sub(1, 8) == "regional" then
			regionalTargets(contact, tier)
		elseif kind == "photography" then
			for _, subject in ipairs({"mutant", "anomaly"}) do
				register(contact, tier, subject, {name = "Photograph %d distinct " .. subject .. " types.",
					desc = "Photograph %d distinct " .. subject .. " types on any supported map, then return to " .. contact.name .. ". Live subjects must be visible in the camera frame. Repeated types and empty spawnpoints do not count.",
					photoKind = subject, numberRec = tier * 2 + 1})
			end
		elseif kind == "courier" then
			register(contact, tier, "courier", {name = "Deliver an information parcel and return.",
				desc = "Collect the information parcel from Brass, hand it to the named contact, then return to Brass. Use Field work to retry parcel collection if needed.",
				fieldType = "courier", bunkerGate = tier == 3})
		else
			fieldJob(contact, tier)
		end
	end
end
