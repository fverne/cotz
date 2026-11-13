local FULL_CONDITION = 100

function ix.util.GetGasmaskFilterCondition(item)
	if not item.filterType then return false end
	local condition = item:GetData("filterCondition")
	if condition == nil then
		condition = FULL_CONDITION
		-- Missing legacy state means the original included filter, never an empty socket.
		if SERVER and item.id and item.id > 0 then item:SetData("filterCondition", condition) end
	end
	if condition == false then return false end

	return math.Clamp(condition / 20, 0, FULL_CONDITION)
end

local function inMainBackpack(item, inventory)
	if item.invID ~= inventory:GetID() or inventory:GetItemByID(item.id, true) ~= item then return false end
	local width, height = inventory:GetSize()
	for candidate, x, y in inventory:Iter() do
		if candidate == item then
			return x >= 1 and y >= 1 and x + item.width - 1 <= width and y + item.height - 1 <= height
		end
	end

	return false
end

function ix.util.CanChangeGasmaskFilter(item, client, pending)
	if not item or not item.isGasmask or not item.filterType or IsValid(item.entity) then return false end
	if item.cotzFilterPending and not pending then return false end
	if not IsValid(client) or not client:Alive() then return false end
	local character = client:GetCharacter()
	if not character then return false end
	local inventory = character:GetInventory()
	if item.invID ~= inventory:GetID() or inventory:GetItemByID(item.id, true) ~= item then return false end
	if not item:GetData("equip") and not inMainBackpack(item, inventory) then return false end
	local equipment = ix.plugin.list.equipmentslots
	if SERVER and equipment and equipment:GetPending(client) then return false end
	if not pending and (client.cotzFilterAction or client:GetNetVar("ix_hasBlackScreen", false)) then return false end

	return true
end

function ix.util.CanInstallGasmaskFilter(item, filter, client, pending)
	if not ix.util.CanChangeGasmaskFilter(item, client, pending) then return false end
	if not filter or not filter.isGasmaskFilter or filter.filterType ~= item.filterType then return false end
	if IsValid(filter.entity) or filter:GetData("equip") then return false end
	if filter.cotzFilterPending and not pending then return false end

	return inMainBackpack(filter, client:GetCharacter():GetInventory())
end

function ix.util.GetGasmaskFilterOptions(item, client)
	local options = {}
	if not ix.util.CanChangeGasmaskFilter(item, client) then return options end
	local inventory = client:GetCharacter():GetInventory()
	for _, filter in pairs(inventory:GetItems(true)) do
		if ix.util.CanInstallGasmaskFilter(item, filter, client) then
			local condition = math.floor(filter:GetData("filterCondition", FULL_CONDITION))
			local label = string.format("%s (%d%%)", filter:GetName(), condition)
			options[#options + 1] = {name = label:gsub("%%", "%%%%"), data = {filter.id}}
		end
	end
	table.sort(options, function(first, second) return first.data[1] < second.data[1] end)

	return options
end

if CLIENT then
	local FILTER_COLOR = Color(73, 140, 143)
	local EMPTY_COLOR = Color(154, 84, 70)
	local TRACK_COLOR = Color(41, 43, 38)

	function ix.util.PaintGasmaskFilter(item, width, height)
		local condition = item.isGasmaskFilter and item:GetData("filterCondition", FULL_CONDITION)
			or ix.util.GetGasmaskFilterCondition(item)
		local barWidth = math.max(0, math.min(38, width - 10))
		surface.SetDrawColor(TRACK_COLOR)
		surface.DrawRect(5, height - 17, barWidth, 4)
		surface.SetDrawColor(condition and condition > 0 and FILTER_COLOR or EMPTY_COLOR)
		surface.DrawRect(5, height - 17, barWidth * (condition or 0) / FULL_CONDITION, 4)
	end

	function ix.util.PopulateGasmaskFilterTooltip(tooltip, item)
		local definition = item.isGasmaskFilter and item or ix.item.list["gasmask_filter_" .. item.filterType]
		local condition = item.isGasmaskFilter and item:GetData("filterCondition", FULL_CONDITION)
			or ix.util.GetGasmaskFilterCondition(item)
		local row = tooltip:AddRow("gasmaskFilter")
		local state = condition == false and "No filter" or string.format("%d%%", math.floor(condition))
		row:SetText(definition.name .. ": " .. state)
		row:SizeToContents()
	end
end
