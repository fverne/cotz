local PLUGIN = PLUGIN
local ACTION_COOLDOWN = 0.5
local CREATION_TIMEOUT = 15

local function beginAction(item, client)
	if not ix.util.CanChangeGasmaskFilter(item, client) then return false end
	if (client.cotzFilterNextAction or 0) > CurTime() then return false end
	client.cotzFilterNextAction = CurTime() + ACTION_COOLDOWN

	return true
end

function ix.util.InstallGasmaskFilter(item, client, data)
	if not beginAction(item, client) or item:GetFilterCondition() ~= false then return end
	local filterID = istable(data) and data[1]
	if not isnumber(filterID) or filterID % 1 ~= 0 then return end
	local inventory = client:GetCharacter():GetInventory()
	local filter = inventory:GetItemByID(filterID, true)
	if not filter or not filter.isGasmaskFilter or filter.filterType ~= item.filterType then return end
	local options = ix.util.GetGasmaskFilterOptions(item, client)
	local allowed = false
	for _, option in ipairs(options) do
		if option.data[1] == filterID then allowed = true break end
	end
	if not allowed then return end
	if hook.Run("CanPlayerInteractItem", client, "InstallFilter", filter, {}) == false then return end
	local condition = math.Clamp(filter:GetData("filterCondition", 100), 0, 100)
	if not filter:Remove() then return end
	item:SetData("filterCondition", condition)
	ix.weight.Update(client:GetCharacter())
	client:EmitSound("stalkersound/inv_slot.mp3", 40)
end

function ix.util.RemoveGasmaskFilter(item, client)
	if not beginAction(item, client) then return end
	local condition = item:GetFilterCondition()
	if condition == false then return end
	local character = client:GetCharacter()
	local inventory = character:GetInventory()
	if not inventory:FindEmptySlot(1, 1, true) then
		client:Notify("Make room in your backpack before removing the filter.")

		return
	end
	local token = {}
	item.cotzFilterPending = token
	timer.Simple(CREATION_TIMEOUT, function()
		if item.cotzFilterPending ~= token then return end
		item.cotzFilterPending = nil
		if IsValid(client) and client:GetCharacter() == character then
			client:Notify("Filter removal timed out. The filter is still installed.")
		end
	end)

	-- Add(string) returns before database creation completes in the installed Helix version.
	ix.item.Instance(0, "gasmask_filter_" .. item.filterType, {filterCondition = condition}, 0, 0, function(filter)
		local current = item.cotzFilterPending == token
		local valid = current and IsValid(client) and client:GetCharacter() == character
			and ix.item.instances[item.id] == item and ix.item.inventories[inventory:GetID()] == inventory
			and ix.util.CanChangeGasmaskFilter(item, client, true) and item:GetFilterCondition() == condition
		local x, y
		if valid then x, y = inventory:FindEmptySlot(1, 1, true) end
		local added = false
		if x and y then
			-- This cartridge's mass is already carried inside the mask; do not charge it twice during placement.
			filter.cotzFilterReturning = true
			added = inventory:Add(filter.id, 1, nil, x, y)
			filter.cotzFilterReturning = nil
		end
		if added then
			item:SetData("filterCondition", false)
			ix.weight.Update(character)
			client:EmitSound("stalkersound/inv_slot.mp3", 40)
		else
			filter:Remove()
			if valid then client:Notify("The filter could not be placed. It is still installed.") end
		end
		if current then item.cotzFilterPending = nil end
	end, character:GetID(), client:SteamID64())
end

function ix.util.DamageGasmaskFilters(client, damageInfo)
	if damageInfo:GetDamage() <= 0 or not damageInfo:IsDamageType(DMG_RADIATION) then return end
	if IsValid(ix.temp.Corpses[client]) then return end
	local character = client:GetCharacter()
	for _, item in pairs(character:GetInventory():GetItems(true)) do
		if item.filterType and item.isGasmask and item:GetData("equip")
			and not item:GetData("unlimitedDurability", false) then
			local condition = item:GetFilterCondition()
			if condition and condition > 0 then
				local definition = ix.item.list["gasmask_filter_" .. item.filterType]
				item:SetData("filterCondition", math.max(0, condition - damageInfo:GetDamage() / definition.filterWearDivisor))
			end
		end
	end
end

function PLUGIN:CanPlayerInteractItem(client, action, target)
	local item = isnumber(target) and ix.item.instances[target] or target
	if istable(item) and item.cotzFilterPending then return false end
end

function PLUGIN:CanTransferItem(item)
	if item.cotzFilterPending then return false end
end

function PLUGIN:CanPlayerEquipItem(client, item)
	if item.cotzFilterPending then return false end
end
