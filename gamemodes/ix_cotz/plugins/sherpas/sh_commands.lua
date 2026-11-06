local function setAccess(character, value, add)
	local access = table.Copy(character:GetSherpaVendors())
	for index = #access, 1, -1 do
		if access[index] == value then table.remove(access, index) end
	end
	if add then access[#access + 1] = value end
	character:SetSherpaVendors(access)
end

local function lookedAtVendor(client)
	local entity = client:GetEyeTraceNoCursor().Entity
	if ix.sherpa.IsVendor(entity) and not entity.ixHideout
		and client:GetPos():DistToSqr(entity:GetPos()) <= 192 * 192 then return entity end
end

ix.command.Add("CharResetSherpaVendors", {
	adminOnly = true, arguments = {ix.type.character},
	OnRun = function(self, client, character)
		character:SetSherpaVendors({})
		return "Sherpa vendor access reset."
	end,
})

for _, add in ipairs({true, false}) do
	local verb = add and "Add" or "Remove"
	ix.command.Add("Char" .. verb .. "CurrentSherpaVendor", {
		adminOnly = true, arguments = {ix.type.character},
		OnRun = function(self, client, character)
			local entity = lookedAtVendor(client)
			if not entity then return "Look at a nearby Sherpa vendor outside a hideout." end
			local id = ix.sherpa.EnsureIdentity(entity)
			setAccess(character, id, add)
			if not add then setAccess(character, entity:GetDisplayName(), false) end
			ix.plugin.Get("vendor_adv"):SaveData()
			return "Sherpa vendor access updated."
		end,
	})
	ix.command.Add("Char" .. verb .. "SherpaVendor", {
		adminOnly = true, arguments = {ix.type.character, ix.type.string},
		OnRun = function(self, client, character, name)
			if #name > 256 then return "Vendor name or ID is too long." end
			setAccess(character, name, add)
			return "Sherpa vendor access updated."
		end,
	})
end

ix.command.Add("TakeVendorMoney", {
	OnRun = function(self, client)
		if not SERVER then return end
		local entity = lookedAtVendor(client)
		if not entity or not ix.sherpa.CanManage(client, entity) then return "No authorized nearby vendor." end
		ix.sherpa.Open(client, entity)
		return "Use Withdraw earnings in the trading window."
	end,
})

ix.command.Add("SherpaAttachStock", {
	adminOnly = true, arguments = {ix.type.string},
	OnRun = function(self, client, id)
		local entity = lookedAtVendor(client)
		local plugin = ix.plugin.Get("sherpas")
		local record = plugin.records and plugin.records[id]
		if not entity or not record then return "Look at a Sherpa vendor and provide a saved Sherpa ID." end
		if entity.sherpaRecord and entity.sherpaRecord.shop.inventoryID then
			return "Use a fresh vendor that has not opened stock yet."
		end
		for _, class in ipairs({"ix_vendor_adv", "ix_sherpa_vendor"}) do
			for _, other in ipairs(ents.FindByClass(class)) do
				if other ~= entity and other.sherpaID == id then return "That stock is already attached to a vendor." end
			end
		end
		entity.sherpaID, entity.sherpaRecord = id, record
		ix.sherpa.EnsureIdentity(entity)
		ix.plugin.Get("vendor_adv"):SaveData()
		return "Saved stock and earnings attached. Existing access grants still apply."
	end,
})

ix.command.Add("SherpaStockList", {
	adminOnly = true,
	OnRun = function(self, client)
		local plugin = ix.plugin.Get("sherpas")
		for id, record in SortedPairs(plugin.records or {}) do
			if istable(record) then
				client:ChatPrint(id .. " — " .. (record.name or "Sherpa") .. " — inventory " .. (record.shop.inventoryID or "none"))
			end
		end
	end,
})
