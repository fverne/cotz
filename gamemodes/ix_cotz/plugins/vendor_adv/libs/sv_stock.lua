ix.vendorStock = ix.vendorStock or {}

local DATA_KEY = "vendorStock"
local SECONDS_PER_HOUR = 3600

function ix.vendorStock.GetMaximum(character, vendor, uniqueID)
	local catalog = vendor.items[uniqueID]
	if not catalog or not catalog[VENDOR_MAXSTOCK] then
		return
	end
	local maximum = catalog[VENDOR_MAXSTOCK]
	local interval, amount = vendor:GetStockInterval(uniqueID)
	if (vendor.GetSherpa and vendor:GetSherpa()) or catalog[VENDOR_MODE] == VENDOR_BUYONLY or interval <= 0 or amount <= 0 then
		return maximum
	end
	local progression = ix.progression
	local bonus = progression and progression.GetStockBonus
		and progression.GetStockBonus(character, vendor:GetDisplayName(), uniqueID) or 0

	return math.min(65535, maximum + bonus)
end

function ix.vendorStock.WritePolicy(vendor, uniqueID)
	local catalog = vendor.items[uniqueID]
	net.WriteUInt(catalog[VENDOR_MODE] or 0, 2)
	net.WriteBool(catalog[VENDOR_PRICE] ~= nil)
	if catalog[VENDOR_PRICE] ~= nil then net.WriteFloat(catalog[VENDOR_PRICE]) end
	local interval, amount = vendor:GetStockInterval(uniqueID)
	net.WriteFloat(interval)
	net.WriteUInt(math.Clamp(math.floor(amount), 0, 65535), 16)
end

local function sendStock(character, vendor, uniqueID, count, maximum, fraction)
	if ix.progression and not ix.progression.CanBuyItem(character, vendor:GetDisplayName(), uniqueID) then
		return
	end
	local client = character:GetPlayer()
	if IsValid(client) and client:GetCharacter() == character and client.ixVendorAdv == vendor then
		net.Start("ixVendorAdvStock")
		net.WriteString(uniqueID)
		net.WriteUInt(count, 16)
		net.WriteUInt(maximum, 16)
		net.WriteUInt(math.floor((fraction or 0) * 10000), 14)
		ix.vendorStock.WritePolicy(vendor, uniqueID)
		net.Send(client)
	end
end

local function getLine(character, vendor, uniqueID)
	local data = character:GetData(DATA_KEY, {})
	local key = game.GetMap() .. "/" .. vendor:GetDisplayName()
	data[key] = data[key] or {}
	local catalog = vendor.items[uniqueID]
	local maximum = ix.vendorStock.GetMaximum(character, vendor, uniqueID)
	local now = os.time()
	local line = data[key][uniqueID]
	if not line then
		line = { count = math.min(catalog[VENDOR_STOCK] or 0, catalog[VENDOR_MAXSTOCK]),
			updated = now, maximum = maximum }
		data[key][uniqueID] = line
	end
	local previousMaximum = line.maximum or catalog[VENDOR_MAXSTOCK]
	local refillMaximum = math.min(previousMaximum, maximum)
	line.count = math.Clamp(line.count, 0, refillMaximum)
	local interval, amount = vendor:GetStockInterval(uniqueID)
	local seconds = interval * SECONDS_PER_HOUR
	if seconds > 0 and amount > 0 then
		local periods = math.max(0, math.floor((now - line.updated) / seconds))
		line.count = line.count + periods * amount
		line.updated = line.updated + periods * seconds
	end
	line.count = math.Clamp(line.count, 0, refillMaximum)
	if line.count == refillMaximum then
		-- Full shelves cannot bank a partial interval for an immediate post-purchase refill.
		line.updated = now
		line.fraction = 0
	end
	line.maximum = maximum
	character:SetData(DATA_KEY, data, true)

	return line, maximum, data
end

function ix.vendorStock.Get(character, vendor, uniqueID)
	assert(character, "Personal vendor stock requires a character")
	local catalog = vendor.items[uniqueID]
	if not catalog or not catalog[VENDOR_MAXSTOCK] then
		return
	end
	local line, maximum = getLine(character, vendor, uniqueID)

	return line.count, maximum, line.fraction or 0
end

function ix.vendorStock.Set(character, vendor, uniqueID, amount)
	local count, maximum, fraction = ix.vendorStock.Get(character, vendor, uniqueID)
	if count == nil then
		return
	end
	local line, _, data = getLine(character, vendor, uniqueID)
	line.count = math.Clamp(math.floor(amount), 0, maximum)
	character:SetData(DATA_KEY, data, true)
	sendStock(character, vendor, uniqueID, line.count, maximum, line.fraction)

	return line.count
end

function ix.vendorStock.GetItems(character, vendor)
	local items = table.Copy(vendor.items)
	for uniqueID, data in pairs(items) do
		local count, maximum, fraction = ix.vendorStock.Get(character, vendor, uniqueID)
		if count ~= nil then
			data[VENDOR_STOCK] = count
			data[VENDOR_MAXSTOCK] = maximum
			data[VENDOR_TASK_PROGRESS] = fraction
		end
	end

	return items
end

function ix.vendorStock.Refresh(character, vendor)
	for uniqueID in pairs(vendor.items) do
		local count, maximum, fraction = ix.vendorStock.Get(character, vendor, uniqueID)
		if count ~= nil then
			sendStock(character, vendor, uniqueID, count, maximum, fraction)
		end
	end
end

function ix.vendorStock.TaskRestock(character, vendor, claimID, jobSerial)
	if vendor.GetSherpa and vendor:GetSherpa() then
		return false
	end
	local identity = game.GetMap() .. "/" .. vendor:GetDisplayName()
	local claims = character:GetData("vendorRestockClaims", {})
	claims[identity] = claims[identity] or {milestones = {}, lastJob = 0}
	local claim = claims[identity]
	if jobSerial then
		if jobSerial <= claim.lastJob then
			return false
		end
		claim.lastJob = jobSerial
	else
		if claim.milestones[claimID] then
			return false
		end
		claim.milestones[claimID] = true
	end
	character:SetData("vendorRestockClaims", claims, true)
	for uniqueID, catalog in pairs(vendor.items) do
		local interval, amount = vendor:GetStockInterval(uniqueID)
		local eligible = catalog[VENDOR_MAXSTOCK] and catalog[VENDOR_MAXSTOCK] > 0
			and catalog[VENDOR_MODE] and catalog[VENDOR_MODE] ~= VENDOR_BUYONLY
			and interval > 0 and amount > 0
			and not uniqueID:match("^quest_") and not uniqueID:match("^accesscard_")
		if eligible and ix.progression.CanBuyItem(character, vendor:GetDisplayName(), uniqueID) then
			local line, maximum, data = getLine(character, vendor, uniqueID)
			if line.count < maximum then
				local progress = (line.fraction or 0) + maximum * 0.2
				local whole = math.floor(progress + 0.000000001)
				line.count = math.min(maximum, line.count + whole)
				line.fraction = line.count == maximum and 0 or math.max(0, progress - whole)
				if line.count == maximum then
					line.updated = os.time()
				end
				character:SetData(DATA_KEY, data, true)
				sendStock(character, vendor, uniqueID, line.count, maximum, line.fraction)
			end
		end
	end
	character:Save()

	return true
end
