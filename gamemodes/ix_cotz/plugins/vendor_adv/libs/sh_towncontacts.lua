local PLUGIN = PLUGIN
local TRADE_MODES = {SELLANDBUY = 1, SELLONLY = 2, BUYONLY = 3}

function PLUGIN:ConfigureTownTemplate(contact, catalogue, stock)
	local template = assert(ix.npctemplates.templates[contact.template], "Missing town vendor template")
	for _, item in ipairs(contact.supplies) do
		template.items[item] = template.items[item] or
			{nil, stock.initial, 1, stock.maximum, stock.interval, stock.amount}
	end
	for _, unlock in ipairs(catalogue) do
		local args = unlock.args
		template.items[args[1]] = template.items[args[1]] or
			{args[2], args[3], TRADE_MODES[args[4]], args[5], args[6], args[7]}
	end
	ix.vendorStock.ApplyDefaults(template.items)
end

if SERVER then
	function PLUGIN:RefreshTownVendor(vendor, contact, catalogue, stock)
		local changed = false
		for _, item in ipairs(contact.supplies) do
			if not vendor.items[item] then
				vendor:AddItemToList(item, nil, stock.initial, "SELLANDBUY",
					stock.maximum, stock.interval, stock.amount)
				changed = true
			end
		end
		for _, unlock in ipairs(catalogue) do
			if not vendor.items[unlock.args[1]] then
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
