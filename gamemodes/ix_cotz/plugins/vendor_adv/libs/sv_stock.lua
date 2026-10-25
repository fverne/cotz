ix.vendorStock = ix.vendorStock or {}

local DATA_KEY = "vendorStock"
local SECONDS_PER_HOUR = 3600

local function getLine(character, vendor, uniqueID)
	local data = character:GetData(DATA_KEY, {})
	local key = game.GetMap() .. "/" .. vendor:GetDisplayName()
	data[key] = data[key] or {}
	local catalog = vendor.items[uniqueID]
	local maximum = catalog[VENDOR_MAXSTOCK]
	local now = os.time()
	local line = data[key][uniqueID]
	if not line then
		line = { count = math.min(catalog[VENDOR_STOCK] or 0, maximum), updated = now }
		data[key][uniqueID] = line
	end
	line.count = math.Clamp(line.count, 0, maximum)
	local interval, amount = vendor:GetStockInterval(uniqueID)
	local seconds = interval * SECONDS_PER_HOUR
	if seconds > 0 and amount > 0 then
		local periods = math.max(0, math.floor((now - line.updated) / seconds))
		line.count = line.count + periods * amount
		line.updated = line.updated + periods * seconds
	end
	line.count = math.Clamp(line.count, 0, maximum)
	if line.count == maximum then
		-- Full shelves cannot bank a partial interval for an immediate post-purchase refill.
		line.updated = now
	end
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

	return line.count, maximum
end

function ix.vendorStock.Set(character, vendor, uniqueID, amount)
	local count, maximum = ix.vendorStock.Get(character, vendor, uniqueID)
	if count == nil then
		return
	end
	local line, _, data = getLine(character, vendor, uniqueID)
	line.count = math.Clamp(math.floor(amount), 0, maximum)
	character:SetData(DATA_KEY, data, true)
	local client = character:GetPlayer()
	if IsValid(client) and client:GetCharacter() == character and client.ixVendorAdv == vendor then
		net.Start("ixVendorAdvStock")
		net.WriteString(uniqueID)
		net.WriteUInt(line.count, 16)
		net.Send(client)
	end

	return line.count
end

function ix.vendorStock.GetItems(character, vendor)
	local items = table.Copy(vendor.items)
	for uniqueID, data in pairs(items) do
		local count = ix.vendorStock.Get(character, vendor, uniqueID)
		if count ~= nil then
			data[VENDOR_STOCK] = count
		end
	end

	return items
end
