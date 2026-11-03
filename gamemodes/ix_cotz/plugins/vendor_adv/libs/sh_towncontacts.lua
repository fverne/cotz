local PLUGIN = PLUGIN
local TRADE_MODES = {SELLANDBUY = 1, SELLONLY = 2, BUYONLY = 3}

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
		local changed = removeDisabledItems(vendor.items, contact)
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
