local PLUGIN = PLUGIN
local TRADE_MODES = {SELLANDBUY = 1, SELLONLY = 2, BUYONLY = 3}

local function plannedItems(contact, catalogue, stock)
	local items = {}
	for item in pairs(contact.buyingItems or contact.wantedItems or {}) do
		items[item] = {nil, nil, TRADE_MODES.BUYONLY}
	end
	for _, unlock in ipairs(catalogue) do
		local args = unlock.args
		items[args[1]] = {args[2], args[3], TRADE_MODES.SELLANDBUY,
			args[5], args[6], args[7]}
	end
	for _, item in ipairs(contact.supplies) do
		if not items[item] or items[item][3] == TRADE_MODES.BUYONLY then
			items[item] = {nil, stock.initial, TRADE_MODES.SELLANDBUY, stock.maximum, stock.interval, stock.amount}
		end
	end
	for item in pairs(contact.disabledItems or {}) do items[item] = nil end
	ix.vendorStock.ApplyDefaults(items)

	return items
end

local function isDisabled(contact, item)
	return contact.disabledItems and contact.disabledItems[item]
end

local function removeDisabledItems(items, contact)
	local changed = false
	for item in pairs(contact.disabledItems or {}) do
		if items[item] then
			items[item] = nil
			changed = true
		end
	end

	return changed
end

function PLUGIN:ConfigureTownTemplate(contact, catalogue, stock)
	local template = assert(ix.npctemplates.templates[contact.template], "Missing town vendor template")
	template.buyAll = contact.buyAll == true
	if contact.buyScale then template.scale = contact.buyScale end
	if contact.enforceCatalogue then
		template.items = plannedItems(contact, catalogue, stock)

		return
	end
	removeDisabledItems(template.items, contact)
	for _, item in ipairs(contact.supplies) do
		if not isDisabled(contact, item) then
			template.items[item] = template.items[item] or
				{nil, stock.initial, 1, stock.maximum, stock.interval, stock.amount}
		end
	end
	for _, unlock in ipairs(catalogue) do
		local args = unlock.args
		if not isDisabled(contact, args[1]) then
			template.items[args[1]] = template.items[args[1]] or
				{args[2], args[3], TRADE_MODES[args[4]], args[5], args[6], args[7]}
		end
	end
	ix.vendorStock.ApplyDefaults(template.items)
end

if SERVER then
	function PLUGIN:RefreshTownVendor(vendor, contact, catalogue, stock)
		local settingsChanged = vendor:GetBuyAll() ~= (contact.buyAll == true)
			or (contact.buyScale ~= nil and vendor.scale ~= contact.buyScale)
		vendor:SetBuyAll(contact.buyAll == true)
		if contact.buyScale then vendor.scale = contact.buyScale end
		if contact.enforceCatalogue then
			local items = plannedItems(contact, catalogue, stock)
			local changed = settingsChanged
			for item in pairs(vendor.items) do
				if not items[item] then
					vendor.items[item] = nil
					changed = true
				end
			end
			for item, expected in pairs(items) do
				local row = vendor.items[item] or {}
				for index = 1, 6 do
					if row[index] ~= expected[index] then changed = true end
				end
				vendor.items[item] = expected
			end

			return changed
		end
		local changed = removeDisabledItems(vendor.items, contact) or settingsChanged
		for _, item in ipairs(contact.supplies) do
			if not isDisabled(contact, item) and not vendor.items[item] then
				vendor:AddItemToList(item, nil, stock.initial, "SELLANDBUY",
					stock.maximum, stock.interval, stock.amount)
				changed = true
			end
		end
		for _, unlock in ipairs(catalogue) do
			if not isDisabled(contact, unlock.args[1]) and not vendor.items[unlock.args[1]] then
				vendor:AddItemToList(unpack(unlock.args, 1, 7))
				changed = true
			end
		end

		return changed
	end

	function PLUGIN:RefreshTownVendors(town)
		local changed = false
		for _, vendor in ipairs(ents.FindByClass("ix_vendor_adv")) do
			local contact = town.byName[vendor:GetDisplayName()]
			if contact and self:RefreshTownVendor(vendor, contact, town.catalogues[contact.name] or {},
				contact.supplyStock or town.settings.supplyStock) then changed = true end
		end
		if changed then self:SaveData() end
	end
end
