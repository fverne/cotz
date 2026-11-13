local PLUGIN = PLUGIN
local ACTION_COOLDOWN = 0.5
local INSTALL_DURATION = 6
local ACTION_CHECK_INTERVAL = 0.1
local CREATION_TIMEOUT = 15

local function beginAction(item, client)
	if not ix.util.CanChangeGasmaskFilter(item, client) then return false end
	if (client.cotzFilterNextAction or 0) > CurTime() then return false end
	client.cotzFilterNextAction = CurTime() + ACTION_COOLDOWN

	return true
end

local function releaseAction(context, interrupt)
	if context.item.cotzFilterPending == context then context.item.cotzFilterPending = nil end
	if context.filter and context.filter.cotzFilterPending == context then context.filter.cotzFilterPending = nil end
	local client = context.client
	if client.cotzFilterAction == context then
		client.cotzFilterAction = nil
		if interrupt and context.installing and IsValid(client) then ix.util.PlayerActionInterrupt(client) end
	end
end

local function newContext(item, client, filter)
	local context = {
		item = item, client = client, filter = filter,
		character = client:GetCharacter(), inventory = client:GetCharacter():GetInventory(),
		wasEquipped = item:GetData("equip") == true,
		itemX = item.gridX, itemY = item.gridY,
		filterX = filter and filter.gridX, filterY = filter and filter.gridY,
	}
	item.cotzFilterPending = context
	if filter then filter.cotzFilterPending = context end
	client.cotzFilterAction = context

	return context
end

local function validContext(context)
	local item, client = context.item, context.client
	if not IsValid(client) or client:GetCharacter() ~= context.character then return false end
	if client.cotzFilterAction ~= context or item.cotzFilterPending ~= context then return false end
	if ix.item.instances[item.id] ~= item or ix.item.inventories[context.inventory:GetID()] ~= context.inventory then
		return false
	end
	if (item:GetData("equip") == true) ~= context.wasEquipped then return false end
	if item.gridX ~= context.itemX or item.gridY ~= context.itemY then return false end
	if not ix.util.CanChangeGasmaskFilter(item, client, true) then return false end
	local filter = context.filter
	if filter then
		return ix.item.instances[filter.id] == filter and filter.cotzFilterPending == context
			and filter.gridX == context.filterX and filter.gridY == context.filterY
			and ix.util.CanInstallGasmaskFilter(item, filter, client, true)
	end

	return item:GetFilterCondition() ~= false
end

local function canInteract(item, filter, client)
	if hook.Run("CanPlayerCombineItem", client, filter.id, item.id) == false then return false end
	if hook.Run("CanPlayerInteractItem", client, "InstallFilter", item.id, {filter.id}) == false then return false end

	return hook.Run("CanPlayerInteractItem", client, "InstallFilter", filter.id, {item.id}) ~= false
end

local function monitorInstallation(context)
	if context.client.cotzFilterAction ~= context then return end
	if not validContext(context) or not context.client:GetNetVar("ix_hasBlackScreen", false)
		or CurTime() > context.expires then
		releaseAction(context, true)

		return
	end
	timer.Simple(ACTION_CHECK_INTERVAL, function() monitorInstallation(context) end)
end

function ix.util.InstallGasmaskFilter(item, client, data)
	if not beginAction(item, client) then return end
	local filterID = istable(data) and data[1]
	if not isnumber(filterID) or filterID % 1 ~= 0 then return end
	local filter = client:GetCharacter():GetInventory():GetItemByID(filterID, true)
	if not ix.util.CanInstallGasmaskFilter(item, filter, client) then return end
	if not canInteract(item, filter, client) then return end
	local context = newContext(item, client, filter)
	context.installing = true
	context.expires = CurTime() + INSTALL_DURATION + 1
	timer.Simple(ACTION_CHECK_INTERVAL, function() monitorInstallation(context) end)
	ix.util.PlayerPerformBlackScreenAction(client, "Installing filter...", INSTALL_DURATION, function()
		if not validContext(context) or not canInteract(item, filter, client) then releaseAction(context) return end
		local incoming = math.Clamp(filter:GetData("filterCondition", 100), 0, 100)
		local outgoing = item:GetFilterCondition()
		if outgoing == false then
			if not filter:Remove() then releaseAction(context) return end
		else
			-- Matching cartridges share a definition: keep the old one in the incoming cartridge's cell.
			-- Read condition at completion so exposure during installation cannot recharge the old filter.
			filter:SetData("filterCondition", outgoing)
		end
		item:SetData("filterCondition", incoming)
		releaseAction(context)
		ix.weight.Update(context.character)
		client:EmitSound("stalkersound/inv_slot.mp3", 40)
	end)
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
	local context = newContext(item, client)
	timer.Simple(CREATION_TIMEOUT, function()
		if item.cotzFilterPending ~= context then return end
		releaseAction(context)
		if IsValid(client) and client:GetCharacter() == character then
			client:Notify("Filter removal timed out. The filter is still installed.")
		end
	end)

	-- Add(string) returns before database creation completes in the installed Helix version.
	ix.item.Instance(0, "gasmask_filter_" .. item.filterType, {filterCondition = condition}, 0, 0, function(filter)
		local valid = validContext(context)
		local x, y
		if valid then x, y = inventory:FindEmptySlot(1, 1, true) end
		local added = false
		if x and y then
			filter:SetData("filterCondition", item:GetFilterCondition())
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
		releaseAction(context)
	end, character:GetID(), client:SteamID64())
end

function ix.util.DamageGasmaskFilters(client, damageInfo)
	if damageInfo:GetDamage() <= 0 or not damageInfo:IsDamageType(DMG_RADIATION) then return end
	if IsValid(ix.temp.Corpses[client]) then return end
	if ix.plugin.list["buffs"] and client:HasBuff("buff_townradprotect") then return end
	local character = client:GetCharacter()
	for _, item in pairs(character:GetInventory():GetItems(true)) do
		if item.filterType and item.isGasmask and item:GetData("equip")
			and not item:GetData("unlimitedDurability", false) then
			local condition = item:GetFilterCondition()
			if condition and condition > 0 then
				local definition = ix.item.list["gasmask_filter_" .. item.filterType]
				local wearDivisor = item.filterWearDivisor or definition.filterWearDivisor
				item:SetData("filterCondition", math.max(0, condition - damageInfo:GetDamage() / wearDivisor))
			end
		end
	end
end

function PLUGIN:CanPlayerInteractItem(client, action, target)
	local item = isnumber(target) and ix.item.instances[target] or target
	-- Permit our permission recheck; OnCanRun and the server helper still reject another installation.
	if istable(item) and item.cotzFilterPending and action ~= "InstallFilter" then return false end
end

function PLUGIN:CanTransferItem(item)
	if item.cotzFilterPending then return false end
end

function PLUGIN:CanPlayerEquipItem(client, item)
	if client.cotzFilterAction or item.cotzFilterPending then return false end
end

function PLUGIN:CanPlayerUnequipItem(client, item)
	if client.cotzFilterAction or item.cotzFilterPending then return false end
end

function PLUGIN:PlayerDisconnected(client)
	local context = client.cotzFilterAction
	if context then releaseAction(context, true) end
end
