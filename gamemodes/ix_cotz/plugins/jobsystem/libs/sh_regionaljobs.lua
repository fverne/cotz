ix.jobs.regional = ix.jobs.regional or {}

ix.jobs.regional.groups = {
	herbivores = {boar = true, flesh = true, tark = true},
	carnivores = {blinddog = true, pseudodog = true, psydog = true, cat = true, bloodsucker = true,
		chimera = true, electrochimera = true, hellhound = true, spider = true, sprig = true},
	psychics = {psydog = true, burer = true, controller = true, swampcontroller = true,
		electrocontroller = true, fastcontroller = true, karlik = true},
	humanoids = {zombie = true, snork = true, izlom = true, skeleton = true},
}

function ix.jobs.regional.Species(class)
	return ix.jobs.regionalCatalogue.classes[class]
end

function ix.jobs.regional.CanOffer(character, definition)
	if not definition or definition.completionOnly then return false end
	if definition.alternateDelivery and #ix.jobs.regional.EligibleReceivers(definition, false, true) == 0 then
		return false
	end
	if definition.bunkerGate and not ix.progression.CanBuyItem(character, "'Carbon'", "accesscard_bunker") then
		return false
	end
	if definition.photoKind then
		return definition.photoKind == character:GetData("townPhotoNext", "mutant")
	end

	return true
end

function ix.jobs.regional.EligibleReceivers(definition, includeLegacy, requirePlaced)
	local recipients = {}
	local issuer = ix.townNPCs.byName[definition.issuerName]
	if not issuer then return recipients end
	for _, receiver in pairs(ix.townNPCs.contacts) do
		if receiver.map == issuer.map
			and ix.townNPCs:WantsCourierItem(receiver, definition.requiredItem, includeLegacy ~= false)
			and (not requirePlaced or IsValid(ix.progression.GetNPCFromName(receiver.name))) then
			recipients[#recipients + 1] = receiver.name
		end
	end
	table.sort(recipients)

	return recipients
end

function ix.jobs.regional.PhotoNames(job)
	local names = {}
	local anomalies = ix.plugin.Get("anomalycontroller")
	for key in pairs(job.photoTypes or {}) do
		local name = key:gsub("_", " "):gsub("^%l", string.upper)
		for _, definition in ipairs(anomalies and anomalies.anomalydefs or {}) do
			if definition.entityname == key then name = definition.name or name break end
		end
		names[#names + 1] = name
	end
	table.sort(names)

	return names
end

function ix.jobs.regional.PhotoSummary(job)
	local names = ix.jobs.regional.PhotoNames(job)

	return "Captured " .. job.photoKind .. " types (" .. #names .. "/" .. job.numberRec .. "): "
		.. (#names > 0 and table.concat(names, ", ") or "None")
end

function ix.jobs.regional.FindHandIn(character, job)
	local definition = ix.jobs.list[job.identifier]
	if not definition or not definition.requiredItem or job.isCompleted then return end
	local pool = definition.requiredPool and ix.progression.itemPools[definition.requiredPool]
	for _, item in pairs(character:GetInventory():GetItems()) do
		local matches = item.uniqueID == definition.requiredItem and not definition.requiredPool
		for _, candidate in ipairs(pool and pool.candidates or {}) do
			if item.uniqueID == candidate.item then matches = true break end
		end
		local quantity = item:GetData("quantity", item.quantity or item.ammoAmount or 1)
		if matches and type(quantity) == "number" and quantity == quantity and quantity < math.huge
			and quantity >= 1 then return item, item.uniqueID end
	end
end

function ix.jobs.regional.CanDeliver(character, receiver, job)
	if ix.jobs.regional.ReceiverMatches(character, receiver, job) then
		return ix.jobs.regional.FindHandIn(character, job) ~= nil
	end
	local state = job.fieldTask

	return state and state.recipient == receiver.name and state.stage == "carrying"
		and ix.jobs.field.FindCargo(character, job) ~= nil or false
end

function ix.jobs.regional.ReceiverMatches(character, receiver, job)
	local definition = ix.jobs.list[job.identifier]
	if not definition or not definition.alternateDelivery or job.isCompleted then return false end
	local issuer = ix.townNPCs.byName[definition.issuerName]
	if not issuer or receiver.map ~= issuer.map then return false end
	if receiver.disabledItems and receiver.disabledItems[definition.requiredItem] then return false end

	return ix.townNPCs:WantsCourierItem(receiver, definition.requiredItem, true)
end

function ix.jobs.regional.DefenceWaves(map, tier)
	local encounters = ix.jobs.regionalCatalogue.encounters[map] or {}
	if #encounters == 0 then return end
	local encounter = encounters[math.random(#encounters)]
	local multipliers = ({{1, 1, 1}, {1, 1, 1.25, 1.5}, {1, 1.25, 1.5, 1.75, 2}})[tier]
	local waves = {}
	for _, multiplier in ipairs(multipliers) do
		local wave = {}
		for _, entry in ipairs(encounter) do
			for _ = 1, math.ceil(entry.count * multiplier) do wave[#wave + 1] = entry.class end
		end
		waves[#waves + 1] = wave
	end

	return waves
end

function ix.jobs.regional.SelectMap(definition)
	if not definition.fieldMaps then return definition.fieldMap end
	local available = {}
	for _, map in ipairs(definition.fieldMaps) do
		local candidate = table.Copy(definition)
		candidate.fieldMaps, candidate.fieldMap = nil, map
		if ix.jobs.field.IsAvailable(candidate) then available[#available + 1] = map end
	end
	if #available > 0 then return available[math.random(#available)] end
end

function ix.jobs.regional.CargoData(character, job, state)
	return {fieldOwner = character:GetID(), fieldClaim = job.rewardKey,
		fieldName = state.cargoName, fieldDescription = state.cargoDescription, fieldRecipient = state.recipient}
end
